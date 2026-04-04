import { initWebcam, openCamera, captureFace, getCapturedBlob } from './webcam.js';


initWebcam("webcam"); // 비디오 요소 초기화

//사용자가 입력한 아이디
const userStrId = document.getElementById("user-str-id");

//얼굴 로그인 버튼
const faceLoginBtn = document.getElementById("face-login-btn");
faceLoginBtn.addEventListener("click", async (e) => {
    openCamera();
    captureFace(e); //이벤트 객체 넘겨주기
    //captureFace 함수가 실행되면 현재 Blob 가져오기
    const currentBlob = getCapturedBlob();
    if(currentBlob == null) {alert("얼굴이미지 데이터없음"); return}// Blob 데이터 없으면 코드 종료 , 재 로그인 필요

    //blob 데이터 있으면 formData를 구성
    const formData = new FormData();
    formData.append("userStrId",userStrId.value);
    formData.append("faceEncoding",currentBlob,"face.jpg");

    //서버로 비동기 요청 시도
    try{
      const response = await axios.post("/login", formData);


    }catch(err){

    }

})

