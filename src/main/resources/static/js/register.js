import {
    captureFace,
    initWebcam,
    openCamera,
    closeCamera,
    initCanvas,
    clearCanvas,
    setCapturedFalse
} from './webcam_module.js';
import OtpManager from './opt_module.js';

let displayImg = null;
let serverImg = null;

window.addEventListener('DOMContentLoaded', () => {
    console.log("등록 스크립트");
    // 캔버스 돔 요소 접근 및  크기 초기화값 할당
    displayImg = initCanvas('#canvas', '.canvas-face_img');
    serverImg = initCanvas(null, '.hidden-face_img'); // 서버용 추가
    // 웹캠 돔 요소 접근 및 초기화값 할당
    initWebcam("#webcam");
});


//상태관리 초기변수
let isIdChecked = false;
let isAgreed = false; // 정보제공 동의하면 true로변경 됨

//아이디 중복검증 이벤트 트리거 요소
const confirmIdBtn=document.getElementById("confirm_id");
//아이디 입력창 값 저장 변수
const userIdInput = document.getElementById("user-id_str");
//중복확인 비동기 요청
async function confirmId(){

    //입력된 값 가져오기
    const userStrId = userIdInput.value.trim(); // 공백 제거!

    if (!userStrId) { //빈 값이면
        alert("아이디를 입력해주세요.");
        userIdInput.focus(); //포커스 다시 이동
        return;  // 코드 종료
    }

    try{
        const response = await axios.get('/user/check-id',
            {params:{
                    userStrId: userStrId //서버 컨트롤러의 @RequestParam 이름과 동일하게 작성 필요!
                }});

        console.log("아이디 중복 처리 response:",response);

        if (response.data.success){
            alert("사용 가능한 아이디");
            //중복검사 완료
            isIdChecked=true;
            // 아이디 입력 돔요소에 readOnly = true 속성 넣어주기
            userIdInput.readOnly = true;
            //중복확인 버튼 비활성화
            confirmIdBtn.disabled = true;
            //중복확인 버튼 텍스트 변경
            confirmIdBtn.innerText = "확인완료";
        }

    }catch(err){ // 200 코드 이외 전부 catch로 처리
        alert(err.response?.data?.exMsg || "알 수 없는 문제 발생");
        userIdInput.focus(); // 재포커싱
    }

}

//이벤트 트리거 걸어주기
if (confirmIdBtn) {
    confirmIdBtn.addEventListener('click', confirmId);
}




const  faceBtn = document.getElementById('face-btn');
// const faceBtn = document.querySelector('.face-btn');
const faceContent = document.querySelector('.apply-face_container');



function faceCameraOpen(){
    faceContent.classList.add("open"); // 카메라 UI 오픈
    faceContent.title="촬영카메라 열림";
    openCamera(); // 카메라 스트림 시작
}

//정보제공동의 해제시 카메라, 캔버스 초기화 함수
function faceCameraClose(){
    faceContent.classList.remove("open"); // 카메라 UI 오픈
    faceContent.title="촬영카메라 닫힘";
    closeCamera(); // 카메라 스트림 자원반납
}

function faceCameraReset(){
    if (currentBlob) {
        setCapturedFalse();      //isCatrued = false 로 변경
        currentBlob = null;   // 저장된 파일 데이터 비우기
        faceBtn.classList.replace("btn-dark", "btn-danger");
        console.log("재촬영 모드로 전환되었습니다.");
    }

    faceCameraOpen(); //공통 웹캠 출력 및 카메라 스트림 실행 함수
}


let currentBlob;
//웹캠.js에서 가져온 함수로 얼굴 캡쳐, 버튼 텍스트 변경
async function registerCaptureFace(e){

    // webcam.js에서 가져온 함수 사용 (버튼에 대한 상태변경을 위해 익명함수도 파라미터로 전달)
    const captured = await captureFace(e,(isCaptured)=>{
        console.log("회원가입 isCaptured",isCaptured);
        console.log("회원가입 displayImg",displayImg);
        console.log("회원가입 serverImg",serverImg);
    },displayImg, serverImg);

    console.log("registerCaptureFace captured",captured);
    //await 끝나고
    if(!captured) {return; } // 코드 실행 종료

    currentBlob = captured;
    console.log("registerCaptureFace currentBlob",currentBlob);
    // 카메라 창 닫고 자원정리
    faceCameraClose();
    faceBtn.innerText = "얼굴 재등록";
    faceBtn.classList.replace("btn-dark", "btn-danger");

    alert("얼굴 등록이 완료되었습니다.");
    console.log("captured",captured);

}

const captureBtn = document.getElementById('capture-btn');
if (captureBtn) {
    captureBtn.addEventListener('click', registerCaptureFace);
}

/*얼굴 등록 버튼 누르면 얼굴 촬영 웹캠 출력*/
if(faceBtn){
    faceBtn.addEventListener('click', faceCameraReset);
}

const closeBtn = document.getElementById('close-btn');
function closeCamBtn(){
    closeCamera(); //비디오 스트림 종료 ( 자원정리 )
    faceContent.classList.remove("open"); // 캠창 닫기
    faceContent.title = "촬영카메라 닫힘";
}
if (closeBtn) {
    closeBtn.addEventListener('click', closeCamBtn);
}

//Otp 모듈 인스턴스 생성하기
const otpMangerObj = new OtpManager({
    elements:{
        sendEmailBtn: document.getElementById("send-otp_email"), //발송버튼
        userEmail: document.getElementById("email-input"), // 이메일 입력창
        otpText: document.querySelector(".otp-text"),//메시지 출력
        otpCodeInput: document.getElementById("otp-code"), // 인증코드입력
        retryOtpSendBtn: document.getElementById("reset-otp"), // 인증코드 재발급
        timerView: document.getElementById("timer"), // 인증 가능 시간
        otpValidBox: document.getElementById("otp_valid"), // 인증코드박스
        confirmOtpBtn: document.getElementById("confirm_otp"), // 인증코드 확인버튼
    },
    otpType: "REGISTER", //회원가입 타입 -  otp 검증 타입 
    duration:60, // 인증시간 초기값 설정
    onTimeSpinner: (isVisible) => { // 타임 스피너 커스텀 함수
        const spinner = document.getElementById('spinner');
        const spinnerText = document.querySelector('.spinner-text');

        if (isVisible) {
            spinner.classList.add('active'); // 보이기
            spinnerText.innerText = "OTP 발송 중";       // 글자 변경 (선택)
        } else {
            spinner.classList.remove('active');    // 숨기기
            spinnerText.innerText = "";
        }

    }
});

// 버튼 이벤트 발생함수 => 등록에서는 버튼트리거 걸어서 함수실행
otpMangerObj.bindEvents();


/* face recongnition agree statement JS*/
//동의 버튼을 클릭하면 얼굴 등록 버튼 출력
const agreeCheckBtn = document.getElementById('chk');

//얼굴정보제공 동의에 따른 얼굴 등록 UI 출력 토글
function shareFaceInfoToggle(e){

    isAgreed = e.target.checked; // 정보제공동의 값 재설정

    if(isAgreed){ //true 일 경우 : UI 출력, 카메라, 캔버스 초기화
        faceBtn.classList.add("block"); // 웹캠 UI 출력
        initCanvas('#canvas', '.canvas-face_img'); // 캔버스 초기화
        console.log("카메라 자원 할당 완료");
    }else{ //false 일 경우
        faceBtn.classList.remove("block"); // 웹캠 UI 숨김
        clearCanvas();// 캔버스 초기화
        faceCameraClose();
        console.log("카메라 자원 반납 완료");
    }

}

if(agreeCheckBtn){
    agreeCheckBtn.addEventListener('change', shareFaceInfoToggle);
}



//form submit 전송 스크립트
document.getElementById("registerForm").addEventListener("submit", async function(e) {
    console.log("submit");
    e.preventDefault(); // 이벤트버블링, 사전 이벤트 발생 방지

    //방어
    if (!isIdChecked) { //아이디 중복 체크
        alert("아이디 중복을 확인해주세요.");
        return;
    }

    if (!otpMangerObj.getEmailVerifiedStatus()) { // 이메일 인증 체크 ==>  otpManager에서 접근해서 사용하기
        alert("이메일 인증을 완료해주세요.");
        return;
    }

    if (!isAgreed) { //아이디 중복 체크
        alert("약관 동의가 필요합니다.");
        return;
    }

    //webcam.js에서 변경된 현재 blob 값 가져오기
    if (!currentBlob) {
        alert("사진을 먼저 촬영해주세요.");
        return;
    }



    const formData = new FormData();
    formData.append("userStrId", document.getElementById("user-id_str").value);
    formData.append("email", document.getElementById("email-input").value);
    formData.append("faceEncoding", currentBlob, "face.jpg");// blob로 변경된 이미지 담기, 이미지명은 face.jpg로 고정
    formData.append("agreeState", isAgreed);

    try{
        // axios.post(URL,데이터) 호출, Json 자동 파싱하여 data에 담김
        const response = await axios.post("/register", formData);
        const data = await response.data;
        // 200 이면
        console.log("회원가입 성공:", data);
        alert("회원가입 완료");
       //로그인페이지로 이동시키려면?
        location.href = "/login"; // 또는 contextPath를 포함한 절대 경로
    }catch(err){//성공이 아니면 catch로 넘어감

        //서버가 보낸 에러 응답 객체는 err.response에 담김
        console.error(err);
        console.log("회원가입 실패:", err);
        if(err.response){ //실패 응답이 있으면
            const status = err.response.status; //서버에서 정한 상태값
            const serverMessage = err.response.data.message || "서버에서 메시지를 보내지 않았습니다."; // 서버 실패 응답 메시지
            //사용자에게 안내 ( 400은 사용자가 수정가능한 에러, 500은 수정 불가로 400, 500 기준으로 나누기)
            if (status === 400) {alert("입력값을 확인하세요: " + serverMessage);}
            else if (status === 401) {
                alert("인증이 만료되었습니다.");
                location.href = "/login";
            } else alert(`에러(${status}): ${serverMessage}`);
        }else {
            alert("네트워크 연결을 확인해주세요.");
        }

    }//catch  end
});




/*
* submit 전체흐름
* 1) e.preventDefault로 사전이벤트 발생 방지하고 JS로 직접 요청 제어
* 2) 캡쳐된 이미지를 blob로 변경된 값 존재여부에 따른 서버 요청방지
* 3) formData 객체에 유저정보와 이미지 담아주기
* 4) Axios에 FormData를 담아 보내면 자동으로 multipart/form-data 헤더가 설정됨
* 5) Axios는 응답을 받아 자동으로 JSON을 파싱하여 response.data에 담아줌
* 6) try-catch를 통해 HTTP 상태 코드(400, 500 등)에 따른 예외 처리를 수행
* */

/*
* formData.append(name,value,filename);
* */




