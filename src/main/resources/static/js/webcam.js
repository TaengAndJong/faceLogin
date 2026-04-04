// 상태관리변수
let isCaptured = false; //촬영상태관리
let capturedBlob = null; // 이미지를 blob로 변환상태관리
let video = null; // 웹캠 돔 요소 접근할 변수로 초기값 null

//외부에서 웹캠 접근할 객체값 초기화 함수
export function initWebcam(videoId){
    video = document.getElementById(videoId);
}

//사진촬영
export function openCamera(){

    //호명된 웹캠 객체가 없으면 종ㄹ요
    if(!video) return;

    video.style.display = "block"; // 비디오 보이기

    // 브라우저에게 카메라 권한 요청
    navigator.mediaDevices.getUserMedia({ video: true, audio: false })
        .then(stream => {
            video.srcObject = stream; // 비디오 태그에 실시간 영상 연결
        })
        .catch(err => {
            console.error("카메라를 켤 수 없습니다: ", err);
            alert("카메라 권한을 허용해주세요.");
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

// 캡처 후 생성된 Blob을 외부에서 가져갈 수 있게 하는 함수 (함수 캡슐화)
export function getCapturedBlob() {
    return capturedBlob;
}


//얼굴 캡쳐, 버튼 텍스트 변경
export function captureFace(e,btnStatusfunc){

    if (!e || !video) { // 이벤트 객체가 없거나 비디오객체가 없을 경우
        console.error("Webcam이 초기화되지 않았거나 이벤트가 없습니다.");
        return;
    }

    //e.currentTarget 또는 e.target으로 이벤트트리거 요소를 지칭
    const btn = e.currentTarget;
    const canvas = document.getElementById('canvas');
    //캔버스가 없을 경우 종료
    if (!canvas) {
        console.error("Canvas 요소를 찾을 수 없습니다.");
        return;
    }

    const context = canvas.getContext('2d');
    console.log("captureFace btn",btn);

    if(!isCaptured){ // false 이면,미촬영이라면
        // 캔버스 설정
        canvas.width = 400;
        canvas.height = 400;
        // 캔버스에 그리기
        context.drawImage(video, 0, 0, canvas.width, canvas.height);
        // 카메라 스트림 자원 정리하기
        closeCamera();
        video.style.display = "none"; // 비디오닫기
        //Blob로 변환 
        canvas.toBlob((blob) => {  // 자바가 MultipartFile로 받기 편하게 하기위함
            capturedBlob = blob; // 변환된 blob 값 재할당
            console.log("JPG를 blob로  변환 완료");
            //촬영상태 변경
            isCaptured = true;
            if (typeof btnStatusfunc === "function")  { btnStatusfunc(isCaptured, btn)};
        }, "image/jpeg", 0.8); // 0.9는 80% 품질로 압축하겠다는 뜻


    }else{
        //이전 캔버스 사진지우기 (초기화)
        context.clearRect(0, 0, canvas.width, canvas.height);
        isCaptured = false;
        capturedBlob = null; // 이전 데이터 초기화 ( 이전 데이터 서버로 전송되는 버그 방지 )
        if (typeof btnStatusfunc === "function") {btnStatusfunc(isCaptured, btn)};
    }

}

