import { initWebcam, openCamera, captureFace } from './webcam.js';

//사용자가 입력한 아이디
const userStrId = document.getElementById("user-str-id");
//얼굴 로그인 버튼
const openCameraBtn = document.getElementById("open-camera-btn");
const faceLoginBtn = document.getElementById("face-login-btn");



console.log("openCameraBtn",openCameraBtn);

//페이지 로드될 때
window.addEventListener("DOMContentLoaded", async () => {
    initWebcam("webcam"); // 비디오 요소 초기화

});

//얼굴 로그인 시도 버튼 클릭 
openCameraBtn.addEventListener("click", async () => {
    console.log("faceCaptureBtn clicked!");
    await openCamera();  // 웹캠 열림
});

// 얼굴 인식 시도
async function tryFaceLogin(e) {
    console.log("tryFaceLogin -- 실행 e.target",e.target);

    //캡쳐 실행 및 캡쳐된 바이너리 파일 받아오기
    const currentBlob =  await captureFace(e, (isCaptured, btn) => {
       // 이 부분은 webcam.js가 실행 완료(resolve)되기 직전에 호출됩니다.
       if (isCaptured) {
           btn.innerText = "로그인";
           btn.classList.replace("btn-primary", "btn-danger");
       } else {
           btn.innerText = "재로그인";
           btn.classList.replace("btn-danger", "btn-primary");
       }
   });

    console.log("currentBlob -- " ,currentBlob);
    if(currentBlob == null) {alert("얼굴이미지 데이터없음"); return}// Blob 데이터 없으면 코드 종료 , 재 로그인 필요

    //blob 데이터 있으면 formData를 구성
    const formData = new FormData();
    formData.append("userStrId",userStrId.value);
    formData.append("faceEncoding",currentBlob,"face.jpg");
    console.log("formData --- userStrId",formData.get("userStrId"));
    console.log("formData --- faceEncoding",formData.get("faceEncoding"));
    //서버로 비동기 요청 시도
    try{
        console.log("서버로 로그인 데이터 전송 시작");
      const response = await axios.post("/login/check", formData);
        console.log("로그인 시도 요청 response.data", response.data);

        if(response.data.success){
            window.location.href=response.data.data; // 마이페이지로 이동
        }

    }catch(err){
        console.error("인증 실패:", err);
        const errorMsg = err.response?.data?.message || "얼굴 인증에 실패했습니다.";
        alert(errorMsg);
    }

}

if(faceLoginBtn){
    faceLoginBtn.addEventListener("click",tryFaceLogin);
}
