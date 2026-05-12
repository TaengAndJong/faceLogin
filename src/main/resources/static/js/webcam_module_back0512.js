//일반 모듈형식

// 상태관리변수
let video; // 웹캠 돔 요소 접근할 변수로 초기값 null
let isCaptured = false;
let faceClassifier = null; //  얼굴 전체 XML 파일(가중치 데이터)을 로드하여 탐지기
let eyeClassifier = null; //  눈
let noseClassifier = null; //  코와 입
let canvasBox; // 캔버스 크기 정해줄 부모
let canvas; //살제 캔버스



/**
 * 비디오 초기화 함수
 * {string} videoId - 비디오 요소 ID (예: '#canvas')
 */
//외부에서 웹캠 접근할 객체값 초기화 함수
export function initWebcam(videoId){
    video = document.querySelector(videoId);
    console.log("video",video);
    if (!video) {
        console.error(`비디오 요소(${videoId})를 찾을 수 없음`);
    }
}

/**
 * 캔버스 초기화 함수
 * {string} boxId - 부모 컨테이너의 ID (예: '#canvas') 옵션값 , 선택요소가 없으면 null 입력
 * {string} canvasClass - 실제 캔버스의 클래스명 (예: '.canvas-face_img') , 필수값
 */
export function initCanvas(boxId, canvasClass){
    const cvs = document.querySelector(canvasClass); // 캔버스요소는 필수
    let box =  null;
    let cvsWidth= null;
    let cvsHeight = null;

    if (!cvs) {
        console.error(` canvas의 ${canvasClass} 요소를 찾을 수 없음`);
        return;
    }
    if (boxId && boxId !== "null") { //문자열 에러 방지
        box = document.querySelector(boxId);
        if (!box) {
            console.error(`지정된 ${boxId} 요소를 찾을 수 없음`);
            return null; // 명시적으로 값 없음 상태 반환
        }
    }

    console.log("canvasBox",canvasBox);
    console.log("canvas",canvas);

    //돔요소가 값이 설정되면  캔버스의 크기와 높이 초기화값 설정 ( 높이, 넓이 0 이면 시스템 에러남 )
    cvsWidth = cvs.offsetWidth || 300;
    cvsHeight = cvs.offsetHeight|| 300;
    console.log(`cvs 넓이 ${cvsWidth} , 높이 ${cvsHeight}`);
    return {
        box: box,
        canvas: cvs,
        width: cvsWidth,
        height: cvsHeight
    };
}

//캔버스 초기화 함수
export function clearCanvas() {
    if (canvas) {
        const context = canvas.getContext('2d');
        // 캔버스 전체 영역을 투명하게 지움
        context.clearRect(0, 0, canvas.width, canvas.height);
        canvasBox.classList.remove("open"); // 캔버스 UI 숨기기
        // 추가로 관리해야 할 상태가 있다면 여기서 처리
        isCaptured = false;
        console.log("캔버스가 초기화되었습니다.");
    }
}

//알고리즘 xml 서버에서 불러올 비동기 함수
const loadXmlFun = async (xmlName, xmlUrl) =>{

    try{
        const response = await axios.get(xmlUrl, { responseType: 'arraybuffer' }); // 정적리소스 비동기 요청 핵심: responseType 설정
        const data = new Uint8Array(response.data);//바이너리(이진) 데이터를 8비트 숫자배열[정수(0~255)]로 펼치기

        //기존 파일이 있으면 삭제  ( 브라우저 새로고침 시 메모리 잔재처리)
        try { cv.FS_unlink(xmlName); } catch (e) {}

        // OpenCV의 가상 디스크(File System, FS)의 루트("/")경로에 xmlPath 라는 이름으로 파일 저장
        cv.FS_createDataFile("/", xmlName, data, true, false, false);

        const classifier= new cv.CascadeClassifier(); // 얼굴 찾는 인공지능 탐지객체 생성해서 초기화
        //가상 디스크에 저장된 파일을 읽어 탐지기(faceClassifier) 객체에 지식 주입 -> 인공지능이 얼굴 패턴을 알아볼 수 있게 됨
        classifier.load(xmlName);

        console.log(`${xmlName} 모델 주입 완료!`);
        return classifier; // 생성된 객체를 반환

    }catch (err) {
        console.error("모델 로드 중 에러", err);
        alert(`${err.responseText}`);
    }

}

//openCV.js 라이브러리가 완전히 로드 되어을 떄 실행
cv.onRuntimeInitialized = async () => {
    console.log("얼굴탐지 인공지능 알고리즘 비동기요청으로 가져와 초기화")
    const baseUrl = "/js/opencv/";
    //Promise.all은 
    [faceClassifier, eyeClassifier, noseClassifier] = await Promise.all([
        loadXmlFun("face.xml", baseUrl + "haarcascade_frontalface_default.xml"),
        loadXmlFun("eye.xml", baseUrl + "haarcascade_eye.xml"),
        loadXmlFun("nose.xml", baseUrl + "haarcascade_mcs_nose.xml")
    ]);

    if (faceClassifier && eyeClassifier && noseClassifier) {
        console.log("얼굴, 눈, 코 탐지기 알고리즘 준비 완료");
    }

};


/**
 * 웹캠 열기
 * @param {Function} onLoading - 스피너 제어 콜백 (isVisible => { ... })
 */



//사진촬영
export async function openCamera(onLoading){
    console.log("OpenCamera 클릭");

    //호명된 웹캠 객체가 없으면 종료
    if(!video) { console.log("비디오 요소 값 없음"); return;}
    //타임스피너
    //if (typeof onLoading === 'function') onLoading(true);
    // 비디오 보이기
    video.classList.add("open");

    // 브라우저에게 카메라 권한 요청
    try{
        
        //스트림 권한 얻을 때까지 기다려야함
        const stream = await navigator.mediaDevices.getUserMedia({ video: {
                width: { ideal: 500 },
                height: { ideal: 500 }
            }, audio: false })
        // 비디오 태그에 실시간 영상 연결 ( 받아온 스트림 데이터 연결 )
        video.srcObject = stream;
       //최종반환 : 비디오가 재생 준비될 때까지 한 번 더 대기
       return await new Promise((resolve) => {
            video.onloadedmetadata = () => {
              //  if (typeof onLoading === 'function') onLoading(false); // 타임 스피너 반환
                video.play();
                resolve(stream); // 준비가 전부 완료된 스트림 결과물로 담아줌
            };
        });
       
    }catch(err){
      //  if (typeof onLoading === 'function') onLoading(false);
        console.error("카메라를 켤 수 없습니다: ", err);
        alert("카메라 권한을 허용해주세요.");
        throw err;
    }

}
// 촬영 끝 자원정리
export function closeCamera(){
    const stream = video.srcObject; // 현재 작동중인 비디오 태그의 스트림 가져오기
    if (stream) {
        const tracks = stream.getTracks(); //스트림 내부의 모든 트랙(오디오 ,비디오) 를 가져옴
        tracks.forEach(track => { // 트랙내부를 순회하며
            track.stop(); // 각 트랙 정지
        });
        // 비디오 태그와 스트림의 연결을 끊어 화면을 검게 만듦
        video.srcObject=null;
    }
}

//얼굴 캡쳐, 버튼 텍스트 변경
export function captureFace(e,btnStatusfunc,displayImg, serverImg){
   console.log(" captureFace 로그인 얼굴촬영 함수 진입");

    //toBlob() 비동기 콜백함수의 데이터 반환타이밍을 위해 Promise객체 반환
    return new Promise((resolve) => {//성공, 실패
        console.log("promise 객체 진입");
        
        // 파라미터로 넘어온 전시용 변수 재설정 : 구조분해로 할당
        const { canvas, box: canvasBox, width, height } = displayImg;
        const { canvas : hiddenCanvas } = serverImg;
        //필수 사용 변수가 값이 없을 경우 사전검증 및 코드 종료 ==>  보류
        if (!video || !canvas || !canvasBox) { 
            console.log(`초기화 실패 상태 -> 비디오: ${!!video}, 캔버스: ${!!canvas}, 이벤트: ${!!e}`);
            resolve(null); // 코드 종료에 대한 promise null 반환
            return;
        }


        let capturedBlob = null; // 이미지를 blob로 변환상태관리
        //e.currentTarget 또는 e.target으로 이벤트트리거 요소를 지칭
        const btn = e.currentTarget;
        const context = canvas.getContext('2d', { willReadFrequently: true });


        if(!isCaptured){ // false 이면,미촬영이라면
            console.log("isCaptured 미촬영이라면",isCaptured);

                // 캔버스에 얼굴그리기
                context.drawImage(video, 0, 0, width, height);
                //openCv.js 변수 초기화
                let imagData =  cv.imread(canvas); //openCv로 이미지를 OpenCV 전용 데이터(Mat)로 변환하여 읽어오기 (컬러)
                let gray = new cv.Mat(); // 흑백이미지 담을 객체,Matrix(행렬)의 약자
                let faces = new cv.RectVector();//찾은 얼굴 벡터를 담을 객체
                let eyes = new cv.RectVector();   // roiFace에서 눈
                let noses = new cv.RectVector();   //roiFace에서 코 탐지

                // openCv.js 전처리 시작
                try{
                    console.log("이미지 전처리 시작");
                    cv.cvtColor(imagData, gray, cv.COLOR_RGBA2GRAY, 0); // 흑백 이미지로 변환하여 gray 객체에 담음
                    // 얼굴 인식 부분 좌표
                    if (faceClassifier && !faceClassifier.empty()) { // 알고리즘 객체가 초기화되었다면

                        let dsize = new cv.Size(canvas.width, canvas.height);
                        faceClassifier.detectMultiScale(imagData, faces, 1.05, 2, 0); // 흑백이미지에서 얼굴 탐지 후 얼굴 위치좌표를 RectVector 담아줌


                        if (faces.size() > 0) { // 탐지된 얼굴 이미지가 하나 담기면
                            console.log("faces.size()", faces.size());
                            // 찾은 얼굴 개수만큼 반복해서 그리기 (인공지능의 사람 판독 및 RectVector의 배열 타입때문)
                            for (let i = 0; i < faces.size(); ++i) {
                                let face = faces.get(i); // i번째 얼굴 이미지 접근
                                console.log(`${i}번째 얼굴 이미지 접근 ${face}`);
                                let faceRect = new cv.Rect(face.x, face.y, face.width, face.height);  //컬러이미지에서 얼굴만 추출


                                // 돋보기(ROI) 설정:
                                let roiColorFace = imagData.roi(faceRect); //컬러 얼굴 부분만 추출
                                let roigrayFace = gray.roi(faceRect);// 흑백 얼굴 부분만 추출


                                // 얼굴 전체가 아니라 위쪽 60% 영역만 눈 탐지 범위로 설정
                                let eyeArea = new cv.Rect(0, 0, face.width, face.height * 0.6);
                                let eyeRoi = roiColorFace.roi(eyeArea); // 눈 전용 돋보기


                                //컬러 이미지에 얼굴 사각형
                                let p1 = new cv.Point(0, 0); //원본이미지에 표현이라서 0,0으로 시작
                                let p2 = new cv.Point(face.width, face.height);
                                cv.rectangle(roiColorFace, p1, p2, [0, 255, 0, 255], 2);

                                // 서버 분석용
                                let forServerFace = new cv.Mat();
                                cv.resize(roigrayFace, forServerFace, dsize, 0, 0, cv.INTER_AREA);
                                //숨겨진 캔버스에 흑백 얼굴 출력 (이후 Blob으로 변환되어 서버로 전송)
                                cv.imshow(hiddenCanvas, forServerFace);
                                forServerFace.delete();


                                // 얼굴 영역(roiFace)에서 눈 탐지
                                if (eyeClassifier && !eyeClassifier.empty()) {
                                    eyeClassifier.detectMultiScale(eyeRoi, eyes, 1.1, 5, 0);
                                }
                                for(let j=0; j<eyes.size(); ++j) {
                                    let eye = eyes.get(j);
                                    cv.rectangle(roiColorFace, {x: eye.x, y: eye.y}, {x: eye.x + eye.width, y: eye.y + eye.height}, [255, 255, 255, 255], 2);
                                }

                                // 얼굴 영역(roiFace)에서 코 탐지
                                if (noseClassifier && !noseClassifier.empty()) {
                                    noseClassifier.detectMultiScale(roiColorFace, noses,1.05, 2, 0);
                                }
                                for (let j = 0; j < noses.size(); ++j) {
                                    let nose = noses.get(j);
                                    cv.rectangle(roiColorFace, {x: nose.x, y: nose.y}, {x: nose.x + nose.width, y: nose.y + nose.height}, [255, 0, 0, 255], 2);
                                }
                                // 사용한 ROI 메모리 해제 (도화지는 imagData에 남아있음)
                                roiColorFace.delete();
                                roigrayFace.delete();
                                eyeRoi.delete();
                                console.log("얼굴 영역 추출 및 리사이징 완료");
                            }

                            //for end
                            //사용자에게 보여줄 이미지 ( 모든 낙서가 완료된 '전체 도화지'를 전시용으로 리사이즈)
                            let forClientFace = new cv.Mat();
                            cv.resize(imagData, forClientFace, dsize, 0, 0, cv.INTER_AREA);
                            cv.imshow(canvas, forClientFace); //화면에 그려짐
                            console.log("전체 컬러 화면 출력 완료");
                            forClientFace.delete(); // 자원정리

                        } else {
                            console.log("얼굴이 감지되지 않았습니다.");
                            throw new Error("NO_FACE"); //catch로 던져 모아서 처리
                        }

                    }

                }catch (err){
                    //에러 메시지에 따른 분기 처리
                    if (err.message === "NO_FACE") {
                        alert("얼굴이 감지되지 않았습니다. 조명이 밝은 곳에서 정면을 응시해 주세요.");
                        // 여기서 UI를 닫지 않고 함수를 종료하면 사용자는 다시 촬영 버튼을 누를 수 있음
                    } else {
                        alert("시스템 오류가 발생했습니다: " + err.message);

                    }
                    return null; //에러가 발생하면 null 반환해서 코드 종료
                }finally {
                    //  자원 정리 에러와 상관없이 사용했던 자원 전부 반남
                    if (imagData) imagData.delete();
                    if (gray) gray.delete();
                    if (faces) faces.delete();
                    if (eyes) eyes.delete();
                    if (noses) noses.delete();
                    console.log("OpenCV 메모리 자원 반납 완료");
                }
                //openCv.js 끝
            
            // 카메라 스트림 자원 정리하기
            closeCamera();
            video.classList.remove("open");// 비디오닫기
            //Blob로 변환  ( 비동기(콜백) 영역 )
            hiddenCanvas.toBlob((blob) => {  // 자바가 MultipartFile로 받기 편하게 하기위함
                capturedBlob = blob; // 변환된 blob 값 재할당
                console.log("JPG를 blob로  변환 완료",capturedBlob);
                //촬영상태 변경
                isCaptured = true;
                //파라미터 타입이 함수일 경우, 실행
                if (typeof btnStatusfunc === "function")  { btnStatusfunc(isCaptured, btn)}
                // 반환할 최종 이미지 데이터 ( 객체로 담아서 반환)
                resolve(blob);
            }, "image/jpeg", 0.8); // 0.9는 80% 품질로 압축하겠다는 뜻
            canvasBox.classList.add("open");
            console.log("바이너리로 데이터 변경 끝 객체값 확인 capturedBlob",capturedBlob );

    }else{
            //이전 캔버스 사진지우기 (초기화)
            context.clearRect(0, 0, canvas.width, canvas.height);
            isCaptured = false;
            canvasBox.classList.remove("open");
            capturedBlob = null; // 이전 데이터 초기화 ( 이전 데이터 서버로 전송되는 버그 방지 )
            if (typeof btnStatusfunc === "function") {btnStatusfunc(isCaptured, btn)}
            resolve(null);
        }

    });

}

//얼굴 캡쳐 상태 초기화
export function setCapturedFalse() {
    isCaptured = false; // isCaptured만 미촬영 상태로 변경, 캔버스는 사용자가 봐야하기때문에 리셋 안함
    console.log("isCaptured만 미촬영 상태로 변경됨, false ");
}


//인공지능 알고리즘 자원정리
if (typeof window !== 'undefined') {
    window.addEventListener('beforeunload', () => {
        if (faceClassifier && !faceClassifier.empty()) {
            faceClassifier.delete();
            console.log("🧹 공통 모듈: OpenCV Classifier 자원 반납 완료");
        }
    });
}