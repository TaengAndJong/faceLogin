
//ES6 클래스 객체 모듈화로 수정 ( 필드 선언형으로 작성 )

/**
 * @typedef {Object} OtpElements - 외부에서 가져올 돔 요소를 담음. 초기값 빈 객체로 this.el이 null일 경우를 사전방지
 * @property {HTMLElement} [userEmail] - 이메일 입력창 (회원가입 시 필수)
 * @property {HTMLElement} [sendEmailBtn] - 인증번호 발송 버튼
 * @property {HTMLElement} [timerView] - 타이머 표시 영역
 * @property {HTMLElement} [spinner] - 로딩 스피너 요소
 *
 */



export default class otpManager {

    /**
     * @param {Object} config
     * @param {OtpElements} config.elements - 사용할 DOM 요소 객체
     * @param {string} config.otpType - 'REGISTER' 또는 'LOGIN'
     * @param {string} [config.staticEmail] - 고정 이메일 (로그인 시 사용)
     */


    //클래스 멤버 필드 선언 및 초기화 ( 클래스 내부 필드에는 타입 선언 안함 -> 자바스크립트가 시행될 때 값을 보고 자동판단)
    el = { }; 
    otpType= null; //LOGIN || REGISTER
    timerInterval = null; // 타이머 
    isEmailVerified = false; // 이메일 인증상태여부
    staticEmail = null; //고정 이메일
    duration = 180; // 타이머 기본 제한시간
    onSuccess = null; // 성공여부에 따른 이동 조건분기(회원가입, 로그인) [함수]
    isTimerExpired = false;// 시간만료 상태관리 변수


    // 클래스 객체 생성자를 통한 외부값 반영 클래스 필드 초기화
    constructor(config ={ }){  //
        //클래스 멤버 필드 초기화
        this.el = config.elements || this.el; // 외부에서 가져온 elements 객체로 el에 담거나 값이 없을 경우 { } (빈 객체)로 대체
        this.otpType= config.otpType ?? this.otpType; // 회원가입 또는 로그인타입
        this.spinner = this.el.spinner ?? null; // 타임스피너 el이 빈 객체여도 에러 안 남 (undefined 담김)
        this.duration = this.duration ?? this.duration;
        this.staticEmail = config.staticEmail ?? this.staticEmail;
        this.onSuccess = config.onSuccess ?? this.onSuccess; // 추가 인증 성공 후에

    }

    //외부에서 이메일 검증 상태 getter
    getEmailVerifiedStatus() {
        return this.isEmailVerified;
    }

    // 실행할 기능들 ( 클래스 객체 내부의 함수 앞에는 function 선언 안함 )
    timerStart(){
        console.log("타이머 시작");
        //시작시간
        let timer = this.duration;

        //시간 초기화
        clearInterval(this.timerInterval);// 초기는 null

        //반복할 시간상태함수 작성 = null 에서 setInterval 함수로 타이머 진행 ,  일반함수 this와 화살표함수 this 구분하기!
        this.timerInterval = setInterval(()=>{

            let minutes = parseInt(timer / 60, 10); // 분
            let seconds = parseInt(timer % 60, 10); // 초
            // console.log(`minutes : ${minutes} , seconds: ${seconds}`);
            //두 자리수로 맞춰주기
            minutes = minutes < 10 ? "0" + minutes : minutes;
            seconds = seconds < 10 ? "0" + seconds : seconds;

            // 시간 텍스트 표시
            this.el.timerView.innerText = minutes + ":" + seconds;

            //시간 만료
            if (--timer < 0) { //1초씩 줄이기 ( -- 는 1초씩 감소 하는 연산자)
                clearInterval(this.timerInterval); // 반복 멈춤
                this.el.otpCodeInput.disabled = false; // 인증코드 입력창 활성화
                this.el.timerView.innerText = "시간만료"; //만료 표기
                this.isTimerExpired = true;//시간만료 상태 관리
                console.log("타이머 인증 시간이 초과");

                this.el.confirmOtpBtn.classList.remove("show-btn");
               this.el.retryOtpSendBtn.classList.add("show-btn");

            }

        },1000);//1초마다

    }

    async sendOtpCode() { //입력한 otp 번호 서버로 보내는 함수
        console.log("onclick sendOtpCode");
        //버튼 비활성화 (중복 클릭 방지)
        if (this.el.sendEmailBtn) {this.el.sendEmailBtn.disabled = true;
            this.el.sendEmailBtn.innerText="발송 중";
        }

        //입력된 이메일 값 가져오기
        // 1. 입력창이 있으면 그 값을 가져오고, 없으면(로그인 모드면) 저장된 staticEmail을 사용
        const email = this.el.userEmail ? this.el.userEmail.value.trim() : this.staticEmail;

        // 이메일 입력 안했을 때 코드실행 종료(회원가입에서만) = staticEmail 또는 userEmail 값 검증
        if (this.el.userEmail && !email) {
            alert("이메일을 입력해주세요.");
            this.el.sendEmailBtn.disabled = false; // 다시 누를 수 있게 버튼 초기화
            return; //코드 종료
        }

        //서버로 비동기 요청 ->  타입에 따라서 이메일
        try{
            console.log("otp번호 보내기",this.otpType);
            const response = await axios.post('/user/check-email',{
                email:email,
                otpType:this.otpType
            });

            console.log("email response:",response);

            if (response.data.success) { //서버의 정상처리
                //
                this.el.sendEmailBtn.innerText="발송완료";
                //타이머 시작
                this.timerStart();
                //인증번호 전송 텍스트 출력
                this.el.otpText.innerText = response.data.message;
                //인증확인 버튼 출력 필요
                this.el.confirmOtpBtn.classList.add("show-btn");
                this.el.retryOtpSendBtn.classList.remove("show-btn");

                // 인증번호 입력 UI 출력
                if (this.el.otpValidBox) { //null 검증 필수
                    this.el.otpValidBox.style.display = "block"; // 클래스  스타일 제어
                }
                //이메일 입력창 읽기전용
                if (this.el.userEmail) {
                    this.el.userEmail.readOnly = true;
                }

            }

        }catch(err){
            //타임스피너 정지
            //중복된 메일일 경우 ,인증코드 인증 실패한 경우 등 예외 전부 처리
            alert(err.response?.data?.exMsg || "발송 실패");
            //인증번호 재요청과 이메일 중복일 경우 수정해야하니까
            if (this.el.userEmail) this.el.userEmail.readOnly = false;
            if (this.el.sendEmailBtn) this.el.sendEmailBtn.disabled = false;
        }

    }

    async confirmOtpCode(){
        //이메일
        //입력된 인증번호 담은 변수
        const userOtpCode = this.el.otpCodeInput.value.trim();
        const userStrId = this.el.userStrId ? this.el.userStrId.value.trim() : null; // 로그인, 회원가입 구분
        const email = this.el.userEmail ? this.el.userEmail.value.trim() : this.staticEmail; // 로그인 , 회원가입 이메일 값 구분 필요
        console.log(`
            userOtpCode : ${userOtpCode},
            email :${email},
            otpType :${this.otpType},
            userStrId : ${userStrId}`);

        //이메일과 otp코드 둘다 필요
        try{
            const response = await axios.post('/otp/check-otp',
                {
                    userStrId:userStrId,
                    email:email, // 이메일도 같이 보내주어야 서버 검증 용이
                    otpType: this.otpType,
                    otpCode: userOtpCode
                });

            console.log("response:",response);
            console.log("response data:",response.data);

            if(response.data.success) {

                clearInterval(this.timerInterval);//타이머 멈추기
                this.el.otpText.innerText = response.data.message;  //응답을 성공적으로 받으면,
                // 인증 성공 상태로 변경
                this.isEmailVerified = true;
                //데이터 변경 방지
                this.el.otpCodeInput.readOnly = true; // 수정 못하게 읽기전용
                this.el.confirmOtpBtn.disabled = true; // 버튼 클릭 막기
                this.el.confirmOtpBtn.innerText="인증완료";

                //onSuccess 함수 확인하여 조건분기를 통해 화면이동 필요
                if(typeof this.onSuccess == "function"){ // 비동기 요청 결과를 onSuccess 함수에 담아초기화
                    const result = response.data.data || {}; // null, 빈 값 방지 안전망
                    this.onSuccess(result);//응답 성공으로 받아온 데이터 넘기기
                }
            }

        }catch(err){
            alert(err.response?.data?.exMsg || "인증 실패");

        }

    }

    // otp 재요청
    retryOtp(){
        console.log("retryOtp --- 실행");
        //이메일인증 버튼과 입력창 활성화
        if(this.el.sendEmailBtn) {this.el.sendEmailBtn.disabled = false;}//이메일 인증버튼 활성화
        if(this.el.userEmail) {this.el.userEmail.disabled = false;} //이메일 입력창 활성화
        this.el.otpCodeInput.readOnly = false; // 인증코드 입력창 활성화
        this.el.confirmOtpBtn.disabled = false; // 인증코드 검증 활성화
        this.sendOtpCode();// 재전송 함수 실행
    }




    //함수실행 버튼 트리거 이벤트
    bindEvents() {
        //opt 처음 발송
        if (this.el.sendEmailBtn) {
            console.log("입력된 otp 전송");
            this.el.sendEmailBtn.addEventListener('click', () => this.sendOtpCode());
        }
        //인증 확인
        if (this.el.confirmOtpBtn) {
            console.log("서버에서 처음 검증");
            this.el.confirmOtpBtn.addEventListener('click', () => this.confirmOtpCode());
        }
        //otp재발송
        if (this.el.retryOtpSendBtn) {
            console.log("재인증");
            this.el.retryOtpSendBtn.addEventListener('click', () => this.retryOtp());
        }
    }

    // end
}

//주의사항
//클래스 내부의 인스턴스, 함수 등을 호출할때는 this를 꼭 지칭해줘야 이 클래스 객체 내부에서 찾음 
//this가 없다면 전역으로 나가버림