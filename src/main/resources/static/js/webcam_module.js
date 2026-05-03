// 상태관리변수

let video; // 웹캠 돔 요소 접근할 변수로 초기값 null
let classifier = null; // XML 파일(가중치 데이터)을 로드하여 탐지기
//외부에서 웹캠 접근할 객체값 초기화 함수
export function initWebcam(videoId){
    video = document.getElementById(videoId);
    console.log("비디오 객체 초기화",videoId);
}

//openCV.js 라이브러리가 완전히 로드 되어을 떄 실행
cv.onRuntimeInitialized = async () => {
    classifier = new cv.CascadeClassifier(); // 얼굴 찾는 인공지능 탐지객체 생성해서 초기화
    console.log("OpenCV.js 준비 완료! classifier",classifier);
    //인공지능 알고리즘 비동기요청을 통해 정적리소스 가져오기
    const xmlUrl = "/js/opencv/haarcascade_frontalface_default.xml";
    const xmlPath = "haarcascade_frontalface_default.xml";

    try {
        const response = await axios.get(xmlUrl, { responseType: 'arraybuffer' }); // 정적리소스 비동기 요청 핵심: responseType 설정
        const data = new Uint8Array(response.data);//바이너리(이진) 데이터를 8비트 숫자배열[정수(0~255)]로 펼치기

        console.log("response ---- openCV ",response);
        console.log("response ---- data ",data);
        // OpenCV의 가상 디스크(File System, FS)의 루트("/")경로에 xmlPath 라는 이름으로 파일 저장
        cv.FS_createDataFile("/", xmlPath, data, true, false, false);

        //가상 디스크에 저장된 파일을 읽어 탐지기(classifier) 객체에 지식 주입 -> 인공지능이 얼굴 패턴을 알아볼 수 있게 됨
        classifier.load(xmlPath);
        console.log("모델 로드 완료, 얼굴찾기 가능");
    } catch (err) {
        console.error("모델 로드 중 에러", err);
    }

};

//사진촬영
export function openCamera(){
    console.log("OpenCamera-- 클릭");

    //호명된 웹캠 객체가 없으면 종ㄹ요
    if(!video) return;

    video.classList.add("open"); // 비디오 보이기

    // 브라우저에게 카메라 권한 요청
    navigator.mediaDevices.getUserMedia({ video: {
            width: { ideal: 500 },
            height: { ideal: 500 }
        }, audio: false })
        .then(stream => {
            video.srcObject = stream; // 비디오 태그에 실시간 영상 연결
            //비디오가 실제로 연결될 때까지 대기
            return new Promise((resolve) => {
                video.onloadedmetadata = () => {
                    video.play();
                    resolve(stream);
                };
            });
        })
        .catch(err => {
            console.error("카메라를 켤 수 없습니다: ", err);
            alert("카메라 권한을 허용해주세요.");
            throw err;
        });
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
export function captureFace(e,btnStatusfunc){
    console.log(" captureFace 로그인 얼굴촬영 함수 진입");
    
    //toBlob() 비동기 콜백함수의 데이터 반환타이밍을 위해 Promise객체 반환
    return new Promise((resolve) => {//성공, 실패
        console.log("promise 객체 진입");
        let capturedBlob = null; // 이미지를 blob로 변환상태관리
        let isCaptured = false; //촬영상태관리 초기화

        if (!e || !video) { // 이벤트 객체가 없거나 비디오객체가 없을 경우, 코드 사전 종료
            console.error("Webcam이 초기화되지 않았거나 이벤트가 없습니다.");
            resolve(null); // 코드 종료에 대한 promise null 반환
            return;
        }

        //e.currentTarget 또는 e.target으로 이벤트트리거 요소를 지칭
        const btn = e.currentTarget;
        const canvas = document.getElementById('canvas');
        //캔버스가 없을 경우 사전 종료
        if (!canvas) {
            console.error("Canvas 요소를 찾을 수 없습니다.");
            resolve(null);
            return; //종료
        }

        let context = canvas.getContext('2d');
        console.log(`captureFace btn: ${btn} ,context: ${context}`);
        if(!isCaptured){ // false 이면,미촬영이라면
            // 캔버스 설정
            canvas.width = 400;
            canvas.height = 400;
            // 캔버스에 그리기
            context.drawImage(video, 0, 0, canvas.width, canvas.height);
            //openCv.js 변수 초기화
            let imagData = null;
            let gray = null;
            let faces = null;
            // openCv.js 전처리 시작
            try{
                imagData = cv.imread(canvas); //openCv로 이미지를 OpenCV 전용 데이터(Mat)로 변환하여 읽어오기
                gray = new cv.Mat(); //메모리 공간을 미리 할당 (흑백이미지 담을 그릇),Matrix(행렬)의 약자
                console.log("imagData",imagData);
                console.log("gray",gray);

                // 흑백 변환 (얼굴 인식 정확도 향상)으로 이미지 전처리하기 ( 흑백이미지를 mat 객체에 담아줌)
                cv.cvtColor(imagData, gray, cv.COLOR_RGBA2GRAY, 0);

                //얼굴인식 (classifier 사용)
                 faces = new cv.RectVector();//찾은 얼굴 좌표 담을 곳
                console.log("얼굴좌표 담을 객체 생성",faces);

                if (classifier && !classifier.empty()) { // 객체가 초기화되었다면 
                    console.log("흑백이미지에서 얼굴좌표 찾기 ");
                    // 흑백사진에서 얼굴 탐지
                    classifier.detectMultiScale(gray, faces, 1.1, 3, 0);
                    // 내부적으로 좌표를 RectVector 담아줌
                    console.log("흑백이미지에서 얼굴좌표 찾기 완료");
                }

                if (faces.size() > 0) {
                    console.log(`얼굴 감지 성공: ${faces.size()}개`);
                    // 필요하다면 여기서 얼굴 부분만 다시 Crop 하거나 전처리를 추가
                    context = canvas.getContext('2d');

                    // 찾은 얼굴 개수만큼 반복해서 그리기
                    for (let i = 0; i < faces.size(); ++i) {
                        let face = faces.get(i); // i번째 얼굴 좌표 꺼내기

                        //  원본 이미지(imagData)에서 얼굴 영역만 잘라내기 (ROI 설정)
                        // cv.Rect(x, y, width, height)
                        let rect = new cv.Rect(face.x, face.y, face.width, face.height);
                        let croppedFace = imagData.roi(rect); // 원본에서 해당 사각형 영역만 추출

                        // 서버 분석용으로 크기를 일정하게 맞추기 (예: 200x200)
                        let finalFace = new cv.Mat();
                        let dsize = new cv.Size(200, 200);
                        cv.resize(croppedFace, finalFace, dsize, 0, 0, cv.INTER_AREA);

                        // 잘라낸 얼굴을 다시 캔버스에 그리기 (사용자 확인용)
                        // 캔버스 크기를 얼굴 크기에 맞게 조절
                        canvas.width = 200;
                        canvas.height = 200;
                        cv.imshow('canvas', finalFace); // 캔버스에 최종 얼굴만 출력

                        // 5. 메모리 정리 (중요!)
                        // croppedFace와 finalFace는 여기서만 쓰고 버리는 것이므로 반드시 삭제
                        croppedFace.delete();
                        finalFace.delete();

                        console.log("얼굴 영역 추출 및 리사이징 완료!");
                    }
                } else {
                    console.log("얼굴이 감지되지 않았습니다.");
                    alert("얼굴이 감지되지 않았습니다.")
                }

            }catch (err){
                console.log("OpenCV 처리 중 오류:", err);
                alert("OpenCV 처리 중 오류 :",err.statusText);
            }finally {

                //  자원 정리 :  에러와 상관없이 사용했던 자원 전부 반남
                if (imagData) imagData.delete();
                if (gray) gray.delete();
                if (faces) faces.delete();

                console.log("OpenCV 메모리 자원 반납 완료");
            }
            //openCv.js 끝
            
            // 카메라 스트림 자원 정리하기
            closeCamera();
            video.classList.remove("open") // 비디오닫기
            //Blob로 변환  ( 비동기(콜백) 영역 )
            canvas.toBlob((blob) => {  // 자바가 MultipartFile로 받기 편하게 하기위함
                capturedBlob = blob; // 변환된 blob 값 재할당
                console.log("JPG를 blob로  변환 완료");
                //촬영상태 변경
                isCaptured = true;
                //파라미터 타입이 함수일 경우, 실행
                if (typeof btnStatusfunc === "function")  { btnStatusfunc(isCaptured, btn)};
                // 반환할 최종 이미지 데이터
                resolve(blob);
            }, "image/jpeg", 0.8); // 0.9는 80% 품질로 압축하겠다는 뜻
            canvas.classList.add("open");
            console.log("바이너리로 데이터 변경 끝 객체값 확인 capturedBlob",capturedBlob );

    }else{
            //이전 캔버스 사진지우기 (초기화)
            context.clearRect(0, 0, canvas.width, canvas.height);
            isCaptured = false;
            canvas.classList.remove("open");
            capturedBlob = null; // 이전 데이터 초기화 ( 이전 데이터 서버로 전송되는 버그 방지 )
            if (typeof btnStatusfunc === "function") {btnStatusfunc(isCaptured, btn)};
            resolve(null);
        }


    });

}

//인공지능 알고리즘 자원정리
if (typeof window !== 'undefined') {
    window.addEventListener('beforeunload', () => {
        if (classifier && !classifier.empty()) {
            classifier.delete();
            console.log("🧹 공통 모듈: OpenCV Classifier 자원 반납 완료");
        }
    });
}