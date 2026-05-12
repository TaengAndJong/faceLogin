import {
    initWebcam,
    openCamera,
    captureFace,
    closeCamera,
    initCanvas,
    clearCanvas,
    setCapturedFalse
} from './webcam_module.js';
import OtpManager from "./opt_module.js";

let displayImg = null;
let serverImg = null;

console.log("로그인 스크립트 실행 (모듈) --- 모듈선언 시에는 돔요소, 리소스가 전부 로드된 이후에 실행되어 이벤트 필요없음");
displayImg = initCanvas('#canvas', '.canvas-face_img');
serverImg = initCanvas(null, '.hidden-face_img'); // 서버용 추가
initWebcam("#webcam")


//얼굴 로그인 버튼
const openCamBtn = document.getElementById("face-btn");
const faceContent = document.querySelector('.apply-face_container');

//자원 정리 공통메서드
function resetFaceAuth (msg = ""){
    if(msg) alert(msg); // 메시지가 있으면 alert 띄우기;
    //faceContent가 있을꼉우에만 실행
    if (faceContent){
        faceContent.classList.remove("open");
        faceContent.title="촬영카메라 닫힘";
    }
    // 공통 모듈에서 가져온 자원 반납 함수 호출
    if (typeof closeCamera === 'function') closeCamera();
    if (captureBtn) captureBtn.innerText = "촬영";
    if (openCamBtn) openCamBtn.focus();
}


//얼굴 로그인 시도 버튼 클릭
openCamBtn.addEventListener("click", async () => {
    clearCanvas(displayImg);
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

// formdata 객체 생성 ==> 발생 예외는 부모한테 던짐
async function createFormdata(userId, faceBlob){

    const formData = new FormData();
    formData.append("userStrId",userId);
    formData.append("faceEncoding",faceBlob,"face.jpg");

    //서버로 비동기 요청 시도
    try{

        const response = await axios.post("/login/check", formData);
        return response; // 부모 함수로 응답 던지기

    }catch(err){

        resetFaceAuth(); //  자원반납 및 UI 정리
        return err.response; // 부모 함수에게 에러 던지기
    }
}



const captureBtn = document.getElementById('capture-btn');
let currentBlob;
console.log("로그인 captureBtn",captureBtn);
console.log("로그인 currentBlob",currentBlob);
async function LoginCaptureFace(e){
    e.preventDefault();

    const userStrId = document.getElementById("user-str-id").value;
    // 아이디 입력 안하면 코드 종료
    if(!userStrId.trim()){ // null, undefined, ""(빈문자열) 전부 잡힘
        resetFaceAuth("먼저 아이디를 입력해주세요");
        return; //코드 종료
    }

    try {
        // webcam.js에서 가져온 함수 사용 (버튼에 대한 상태변경을 위해 익명함수도 파라미터로 전달)
        const captured = await captureFace(e, (isCaptured) => {
            //console.log("실시간 촬영 상태 isCaptured",isCaptured);
            captureBtn.innerText = "인식 중" // 타임스피너 추가 ?
            if (!isCaptured) {//미촬영 상태
                console.log("미촬영 상태");
            }
        },displayImg,serverImg);
        //await 끝나고, blob 없으면 코드 종료
        if (!captured) {return;}

        // 촬영 완료되면
        currentBlob = captured;
        // Blob 데이터 없으면 코드 종료 , 재 로그인 필요
        if (currentBlob == null) {alert("얼굴이미지가 없습니다. 다시 촬영해 주세요.");return;  }

        // id,blob 데이터 있으면 formData를 구성
        const response = await createFormdata(userStrId, currentBlob); //login-check 결과 받음
        console.log("response---------- 응답 객체",response);
        if(!response?.data){ // 시스템 에러 방어코드
            console.log("시스템 에러 발생 - 응답 객체를 못받아옴",response);
            throw new Error("서버 응답 에러 발생");// catch block 으로 던짐
        }

        if (!response.data.success) { // 비즈니스 로직 에러 방어코드
            console.log("비즈니스로직 에러 발생 - 응답 객체는 받았지만 로직실패", response);
            setCapturedFalse();
            closeCamera();
            clearCanvas(displayImg);
            throw new Error(response.data.exMsg || "인증 처리에 실패했습니다.");// catch block 으로 던짐

        }

        // creataeForm에서 받아온 response
        console.log("로그인 컨트롤러 ok 200code, response.data", response.data);
            
        // 다 통과하면 인증성공 또는 추가인증 분기와 그외 처리
        switch (response.data.code) {
            case "SUCCESS":
                alert("로그인 성공");
                window.location.href = response.data.data; // mypage
                break;
            case "OTP_REQUIRED" :
               // 추가인증로직 추가 ( 서버에서 이미 email로 코드 발송)
                console.log("추가인증 스위치문 case otp 추가인증 요구");
                //웹캡 레이어 닫고 비디오 자원정리
                closeCamera(); //비디오 스트림 종료 ( 자원정리 )
                faceContent.classList.remove("open"); // 캠창 닫기
                faceContent.title = "촬영카메라 닫힘";
                //OTP 입력 UI 출력
                const otpValidBox = document.getElementById("otp_valid");
                otpValidBox.style.display = "block"; //otp 검증 박스 열기

                //Otp 모듈 인스턴스 생성하기
                const otpMangerObj = new OtpManager({
                    elements:{
                        userStrId:document.getElementById("user-str-id"),
                        otpText: document.querySelector(".otp-text"),
                        otpCodeInput: document.getElementById("otp-code"),
                        timerView: document.getElementById("timer"),
                        confirmOtpBtn: document.getElementById("confirm_otp"),
                        retryOtpSendBtn: document.getElementById("reset-otp"),
                    },
                    duration:10, // 타이머 값 설정
                    staticEmail:response.data.data, //서버에서 받은 이메일
                    otpType: "LOGIN", //로그인 타입
                    onSuccess: (data) => {
                        if (data.redirectUrl) { // 값이 있을 때만 이동, 스크립트 멈충 방지
                            location.href = data.redirectUrl; // 뎁스 고민 없이 바로 이동!
                        }
                    }
                });

                //email 마스킹 및 text 문구 설정
                const maskedEmail = otpMangerObj.staticEmail.replace(/(..)(.*)(?=@)/, "$1****"); // kbo8311 -> kb****
                otpMangerObj.el.otpText.innerText = `${response.data.message}\n(${maskedEmail})`;

                //버튼 요소 함수동작 이벤트 트리거 먼저 호출하여 버튼 기능 생성
                otpMangerObj.bindEvents();
                //타이머도 시작
                otpMangerObj.timerStart();
                break;
            default:
                //그외 처리 구간 ==> catch로 던짐
                throw new Error("정의되지 않은 응답 코드");
        } //switch 끝
    }catch (err){
        // 서버에서 보낸 에러 메시지 또는 기본 메시지
        const errorMsg = err.response?.data?.exMsg  || "얼굴 인증에 실패했습니다.";
        resetFaceAuth(errorMsg); //  자원반납 및 UI 정리
    }
// 끝
}

if (captureBtn) {
    captureBtn.addEventListener('click',LoginCaptureFace );
}







