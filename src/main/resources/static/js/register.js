import { captureFace,initWebcam,openCamera,closeCamera } from './webcam.js';

// 웹캠 돔 요소 접근 및 초기화값 할당
initWebcam("webcam");

//상태관리 초기변수
let isIdChecked = false;
let isAgreed = false;

//아이디 중복검증 이벤트 트리거 요소
const confirmIdBtn=document.getElementById("confirm_id");
//아이디 입력창 값 저장 변수
const userIdInput = document.getElementById("user-id_str");
//중복확인 비동기 요청
async function confirmId(){

    //입력된 값 가져오기
    const userIdStr = userIdInput.value.trim(); // 공백 제거!

    if (!userIdStr) { //빈 값이면
        alert("아이디를 입력해주세요.");
        userIdInput.focus(); //포커스 다시 이동
        return;  // 코드 종료
    }

    try{
        const response = await axios.get('/user/check-id',
            {params:{
                    userIdStr: userIdStr //서버 컨트롤러의 @RequestParam 이름과 동일하게 작성 필요!
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

//이메일 인증
const sendEmailBtn=document.getElementById("send-otp_email");
const userEmail = document.getElementById("email-input");
const otpText = document.querySelector(".otp-text");
const otpCodeInput = document.getElementById("otp-code");
const retryOtpSendBtn=document.getElementById("reset-otp");

//타이머 상태관리 변수
let timerInterval;
// 시간을 표시할 요소
const timerView = document.getElementById("timer");
//타이머 시작 함수
function timerStart(duration){
    console.log("타이머 시작")
    //시작시간
    let timer = duration;

    //시간 초기화
    clearInterval(timerInterval);

    //반복할 시간상태함수 작성
    timerInterval = setInterval(()=>{
        console.log("timerInterval 시작")
        let minutes = parseInt(timer / 60, 10); // 분
        let seconds = parseInt(timer % 60, 10); // 초

        //두 자리수로 맞춰주기
        minutes = minutes < 10 ? "0" + minutes : minutes;
        seconds = seconds < 10 ? "0" + seconds : seconds;
        // 시간 텍스트 표시
        timerView.innerText = minutes + ":" + seconds;

        //시간 만료
        if (--timer < 0) { //1초씩 줄이기 ( -- 는 1초씩 감소 하는 연산자)
            clearInterval(timerInterval); // 반복 멈춤
            otpCodeInput.disabled = true;
            timerView.innerText = "시간 만료";
            alert("인증 시간이 초과되었습니다.");
        }

    },1000);//1초마다

}

//UI입력컨테이너
const otpValidBox = document.getElementById("otp_valid");
let isEmailVerified = false; // 이메일 인증 여부 상태값
//서버로 인증번호 요청 함수
async function sendOtpCode() {
    console.log("onclick sendOtpCode");
    //버튼 비활성화 (중복 클릭 방지)
    sendEmailBtn.disabled = true;

    //입력된 이메일 값 가져오기
    const email = userEmail.value.trim();
    // 이메일 입력 안했을 때 코드실행 종료
    if(!email) {
        alert("이메일을 입력해주세요.");
        return;
    }

    //서버로 비동기 요청
    try{
        const response = await axios.post('/user/check-email',{email:email});
        console.log("email response:",response);

        if (response.data.success) { //서버의 정상처리
            console.log("이메일로 인증코드 발송 성공")
            //인증번호 전송 텍스트 출력
            otpText.innerText = response.data.message;

            //타이머 시작
            timerStart(600)//초단위 입력 (3분) 60초 * 3

            // 인증번호 입력 UI 출력
            if (otpValidBox) { //null 검증 필수

                otpValidBox.style.display = "block"; // 클래스  스타일 제어

            }
            //이메일 입력창 읽기전용
            userEmail.readOnly = true;

        }

    }catch(err){

        //중복된 메일일 경우 ,인증코드 인증 실패한 경우 등 예외 전부 처리
        alert(err.response?.data?.exMsg || "발송 실패");
        //인증번호 재요청과 이메일 중복일 경우 수정해야하니까
        userEmail.readOnly = false;
        sendEmailBtn.disabled = false;
    }
    
}



//otp코드 인증
const confirmOtpBtn= document.getElementById("confirm_otp");
//받아온 인증번호 입력 후 서버 인증 요청 함수
async function confirmOtpCode(){
    //이메일

    //입력된 인증번호 담은 변수
    const userOtpCode = otpCodeInput.value.trim();
    const email = userEmail.value.trim();
    //이메일과 otp코드 둘다 필요
    try{
        const response = await axios.post('/otp/check-otp',
            {email:email, // 이메일도 같이 보내주어야 서버 검증 용이
            otpCode: userOtpCode});

        if(response.data.success) {
            otpText.innerText = response.data.message;  //응답을 성공적으로 받으면,
            // 인증 성공 상태로 변경
            isEmailVerified = true;
            clearInterval(timerInterval);//타이머 멈추기

            //데이터 변경 방지
            otpCodeInput.readOnly = true; // 수정 못하게 읽기전용
            confirmOtpBtn.disabled = true; // 버튼 클릭 막기

            //재인증요청 버튼 출력
            retryOtpSendBtn.style.display = "block";
        }

    }catch(err){
        alert(err.response?.data?.exMsg || "인증 실패");
    }

}
//인증요청
async function retryOtp(){
    //이메일인증 버튼과 입력창 활성화
    sendEmailBtn.disabled = false;//이메일 인증버튼 활성화
    userEmail.readOnly = false;  //이메일 입력창 활성화
    otpCodeInput.readOnly = false; // 인증코드 입력창 활성화
    confirmOtpBtn.disabled = false; // 인증코드 검증 활성화
}


//이벤트 트리거 걸어주기
if (sendEmailBtn) {
    sendEmailBtn.addEventListener('click', sendOtpCode);
}
if (confirmOtpBtn) {
    confirmOtpBtn.addEventListener('click', confirmOtpCode);
}
if (confirmOtpBtn) {
    retryOtpSendBtn.addEventListener('click', retryOtp);
}


const openCamBtn = document.getElementById('open-cam_btn');
const faceContent = document.querySelector('.apply-face_container');
// const canvas = document.getElementById("canvas");


function FaceCameraOpen(){
    faceContent.classList.add("open"); // 카메라 UI 오픈
    faceContent.title="촬영카메라 열림";
    openCamera(); // 카메라 스트림 시작
}

if(openCamBtn){
    openCamBtn.addEventListener('click',FaceCameraOpen);
}


let currentBlob;
//웹캠.js에서 가져온 함수로 얼굴 캡쳐, 버튼 텍스트 변경
async function registerCaptureFace(e){
   // currentBlob = null; //이전 촬영 데이터 초기화

    // webcam.js에서 가져온 함수 사용 (버튼에 대한 상태변경을 위해 익명함수도 파라미터로 전달)
    const captured = await captureFace(e,(isCaptured)=>{
        console.log("실시간 촬영 상태 isCaptured",isCaptured);

        if(!isCaptured){//미촬영 상태
            // canvas.classList.remove("open");//캔버스 닫기
            //버튼 텍스트 변경 
            openCamBtn.innerText= "얼굴 등록";
            //버튼 컬러 변경
            openCamBtn.classList.replace("btn-dark", "btn-danger");

        }
    });

    //await 끝나고
    if(!captured) {return; }

    currentBlob = captured;
    openCamBtn.innerText = "얼굴 재등록";
    openCamBtn.classList.replace("btn-danger", "btn-dark");
    // 카메라 창 닫기
    faceContent.classList.remove("open");
    faceContent.title = "촬영카메라 닫힘";
    alert("얼굴 등록이 완료되었습니다.");
    console.log("captured",captured);

}

const captureBtn = document.getElementById('capture-btn');
if (captureBtn) {
    captureBtn.addEventListener('click', registerCaptureFace);
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

//form submit 전송 스크립트
document.getElementById("registerForm").addEventListener("submit", async function(e) {
    console.log("submit");
    e.preventDefault(); // 이벤트버블링, 사전 이벤트 발생 방지

    //checkbox 동의
    isAgreed = document.getElementById("chk").checked; // value는 true 값만 가져오고, checked 해야 체크 확인가능
    console.log("isAgreed--submit", isAgreed);

    //방어
    if (!isIdChecked) { //아이디 중복 체크
        alert("아이디 중복을 확인해주세요.");
        return;
    }

    if (!isEmailVerified) { // 이메일 인증 체크
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
    formData.append("userIdStr", document.getElementById("user-id_str").value);
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


/* face recongnition agree statement JS*/
//동의 버튼을 클릭하면 얼굴 등록 버튼 출력
const agreeCheckBtn = document.getElementById('chk');

function faceToggle(e){
    const faceBtn = document.querySelector('.face-btn');
    faceBtn.classList.toggle("block");

}

if(agreeCheckBtn){
    agreeCheckBtn.addEventListener('change', faceToggle);
}

/*얼굴 등록 버튼 누르면 얼굴 촬영 웹캠 출력*/


