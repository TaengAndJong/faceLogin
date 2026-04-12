import {initWebcam, openCamera, captureFace, closeCamera} from './webcam.js';

//얼굴 로그인 버튼
const openCamBtn = document.getElementById("open-cam_btn");
const faceContent = document.querySelector('.apply-face_container');




console.log("openCamBtn",openCamBtn);

//페이지 로드될 때
window.addEventListener("DOMContentLoaded", async () => {
    initWebcam("webcam"); // 비디오 요소 초기화

});

//얼굴 로그인 시도 버튼 클릭 
openCamBtn.addEventListener("click", async () => {
    console.log("faceCaptureBtn clicked!");
    await openCamera();  // 웹캠 열림
    faceContent.classList.add("open"); // 카메라 UI 오픈
    faceContent.title="촬영카메라 열림";
});

//모달 닫기
const closeBtn = document.getElementById('close-btn');
function closeCamBtn(){
    closeCamera(); //비디오 스트림 종료 ( 자원정리 )
    faceContent.classList.remove("open"); // 캠창 닫기
    faceContent.title = "촬영카메라 닫힘";

}
if (closeBtn) {
    closeBtn.addEventListener('click', closeCamBtn);
}

// formdata 객체 생성
async function createFormdata(userId, faceBlob){
    const formData = new FormData();
    formData.append("userStrId",userId);
    formData.append("faceEncoding",faceBlob,"face.jpg");
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




const captureBtn = document.getElementById('capture-btn');
let currentBlob;
async function LoginCaptureFace(e){
    e.preventDefault();
    const userStrId = document.getElementById("user-str-id");
    if(userStrId.value == null){
        alert("먼저 아이디를 입력해주세요.");  return; //코드 종료
    }


        // webcam.js에서 가져온 함수 사용 (버튼에 대한 상태변경을 위해 익명함수도 파라미터로 전달)
        const captured = await captureFace(e,(isCaptured)=>{
            console.log("실시간 촬영 상태 isCaptured",isCaptured);
            captureBtn.innerText="얼굴인식 로그인 시도중"
            if(!isCaptured){//미촬영 상태
                //버튼 텍스트 변경
                openCamBtn.innerText= "로그인";
            }
        });
        //await 끝나고, blob 없으면 코드 종료
        if(!captured) {return; }
        // 촬영 완료되면
        currentBlob = captured;
        if(currentBlob == null) {alert("얼굴이미지가 없습니다. 다시 촬영해 주세요."); return}// Blob 데이터 없으면 코드 종료 , 재 로그인 필요


        // id,blob 데이터 있으면 formData를 구성
        const response = await createFormdata(userStrId, currentBlob);
        console.log(response.data);

        if(response.data.success){ alert("로그인 성공"); window.location.href = response.data;}

}

if (captureBtn) {
    captureBtn.addEventListener('click',LoginCaptureFace );
}







