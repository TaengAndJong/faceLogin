import { initWebcam, openCamera, captureFace, getCapturedBlob } from './webcam.js';

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

    //캡쳐 실행
   const promiseResult =await captureFace=(e,(isCaptured,btn) =>{
        console.log("로그인 페이지 js : isCaptured,btn",isCaptured,btn);
    });
    console.log("promiseResult",promiseResult);

    //captureFace 함수가 실행되면 현재 Blob 가져오기 (캡쳐 결과물)
    const currentBlob = getCapturedBlob();
    console.log("currentBlob -- " ,currentBlob);
    if(currentBlob == null) {alert("얼굴이미지 데이터없음"); return}// Blob 데이터 없으면 코드 종료 , 재 로그인 필요

    //blob 데이터 있으면 formData를 구성
    const formData = new FormData();
    formData.append("userStrId",userStrId.value);
    formData.append("faceEncoding",currentBlob,"face.jpg");

    //서버로 비동기 요청 시도
    try{
      const response =  axios.post("/login/check", formData);
        console.log("로그인 시도 요청 response.data", response.data);
        if (response.status === 200) {
            window.location.href = "/mypage";
        }
    }catch(err){
        console.error("인증 실패:", err);
        const errorMsg = err.response?.data?.message || "얼굴 인증에 실패했습니다.";
        alert(errorMsg);
    }

}

if(faceLoginBtn){
    faceLoginBtn.addEventListener("click",tryFaceLogin(e));
}
