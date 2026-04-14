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
    console.log("createFormdata",userId, faceBlob);

    const formData = new FormData();
    formData.append("userStrId",userId);
    formData.append("faceEncoding",faceBlob,"face.jpg");

    formData.forEach((value, key) => {
        console.log(`${key}:`, value);
    });

    //서버로 비동기 요청 시도
    try{
        console.log("서버로 로그인 데이터 전송 시작");
        const response = await axios.post("/login/check", formData);
        console.log("로그인 시도 요청 response.data", response.data);
        return response; // 부모 함수로 응답 던지기

    }catch(err){
        console.error("인증 실패:", err);
       //UI만 정리
        captureBtn.innerText="촬영";
        faceContent.classList.remove("open");
        faceContent.title="촬영카메라 닫힘";
        closeCamera(); // 카메라 자원 반환
        return err.response; // 부모 함수에게 에러 던지기
    }
}





const captureBtn = document.getElementById('capture-btn');
let currentBlob;
async function LoginCaptureFace(e){
    e.preventDefault();

    const userStrId = document.getElementById("user-str-id").value;
    // 아이디 입력 안하면 코드 종료
    if(!userStrId.trim()){ // null, undefined, ""(빈문자열) 전부 잡힘
        alert("먼저 아이디를 입력해주세요.");
        faceContent.classList.remove("open"); // 카메라 UI 오픈
        faceContent.title="촬영카메라 닫힘";
        closeCamera(); // 카메라 자원 반환
        return; //코드 종료
    }

    // webcam.js에서 가져온 함수 사용 (버튼에 대한 상태변경을 위해 익명함수도 파라미터로 전달)
        const captured = await captureFace(e,(isCaptured)=>{
            console.log("실시간 촬영 상태 isCaptured",isCaptured);
            captureBtn.innerText="얼굴인식 로그인 시도중"
            if(!isCaptured){//미촬영 상태
                console.log("미촬영 상태");
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
        // creataeForm에서 받아온 response
        if(response && response.data.success){
            alert("로그인 성공");
            window.location.href = response.data.data; // mypage
        }else {
            // 서버에서 보낸 에러 메시지 또는 기본 메시지
            const errorMsg = response?.data?.exMsg || "얼굴 인증에 실패했습니다.";
            alert(errorMsg);
            //카메라 버튼에 포커싱
            openCamBtn.focus();
        }

}

if (captureBtn) {
    captureBtn.addEventListener('click',LoginCaptureFace );
}







