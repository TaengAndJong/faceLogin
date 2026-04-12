// 상태관리변수

let video; // 웹캠 돔 요소 접근할 변수로 초기값 null

//외부에서 웹캠 접근할 객체값 초기화 함수
export function initWebcam(videoId){
    video = document.getElementById(videoId);
    console.log("비디오 객체 초기화",videoId);
}

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
function closeCamera(){
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

        const context = canvas.getContext('2d');
        console.log(`captureFace btn: ${btn} ,context: ${context}`);
        if(!isCaptured){ // false 이면,미촬영이라면
            // 캔버스 설정
            canvas.width = 400;
            canvas.height = 400;
            // 캔버스에 그리기
            context.drawImage(video, 0, 0, canvas.width, canvas.height);
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

            console.log("바이너리로 데이터 변경 끝 객체값 확인 capturedBlob",capturedBlob );

    }else{
            //이전 캔버스 사진지우기 (초기화)
            context.clearRect(0, 0, canvas.width, canvas.height);
            isCaptured = false;
            capturedBlob = null; // 이전 데이터 초기화 ( 이전 데이터 서버로 전송되는 버그 방지 )
            if (typeof btnStatusfunc === "function") {btnStatusfunc(isCaptured, btn)};
            resolve(null);
        }


    });

}

