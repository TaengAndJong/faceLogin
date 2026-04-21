
//ES6 클래스 객체 모듈화로 수정 ( 필드 선언형으로 작성 )

export default class otpManager {

    //클래스 멤버 필드 선언 및 초기화 ( 클래스 내부 필드에는 타입 선언 안함 -> 자바스크립트가 시행될 때 값을 보고 자동판단)
    el = null; // 외부에서 가져올 돔 요소 담을 변수
    timerInterval = null; // 타이머 
    isEmailVerified = false; // 이메일 인증상태여부
    duration = 180; // 타이머 기본 제한시간
    
    // 클래스 객체 생성자를 통한 외부값 반영 클래스 필드 초기화
    constructor(config){
        //클래스 멤버 필드 초기화
        this.el = config.elements; // 외부에서 가져온 elements 객체로 el에 담아주기
        //외부에 선언한 duration으로 초기값 변경
        if (config.duration) {this.duration = config.duration; }
    }

    
    // 실행할 기능들 ( 클래스 객체 내부의 함수 앞에는 function 선언 안함 )
    timerStart(duration){
        console.log("타이머 시작")
        //시작시간
        let timer = this.duration;

        //시간 초기화
        clearInterval(this.timerInterval);// 초기는 null

        //반복할 시간상태함수 작성 = null 에서 setInterval 함수로 타이머 진행 ,  일반함수 this와 화살표함수 this 구분하기!
        this.timerInterval = setInterval(()=>{
            console.log("timerInterval 시작")
            let minutes = parseInt(timer / 60, 10); // 분
            let seconds = parseInt(timer % 60, 10); // 초

            //두 자리수로 맞춰주기
            minutes = minutes < 10 ? "0" + minutes : minutes;
            seconds = seconds < 10 ? "0" + seconds : seconds;
            // 시간 텍스트 표시
            this.el.timerView.innerText = minutes + ":" + seconds;

            //시간 만료
            if (--timer < 0) { //1초씩 줄이기 ( -- 는 1초씩 감소 하는 연산자)
                clearInterval(this.timerInterval); // 반복 멈춤
                this.el.otpCodeInput.disabled = true;
                this.el.timerView.innerText = "시간 만료";
                console.log("타이머 인증 시간이 초과");
            }

        },1000);//1초마다

    }

    async sendOtpCode() {
        console.log("onclick sendOtpCode");
        //버튼 비활성화 (중복 클릭 방지)
        this.el.sendEmailBtn.disabled = true;

        //입력된 이메일 값 가져오기
        const email = this.el.userEmail.value.trim();
        // 이메일 입력 안했을 때 코드실행 종료
        if(!email) {
            alert("이메일을 입력해주세요.");
            this.el.sendEmailBtn.disabled = false; // 다시 누를 수 있게 버튼 초기화
            return;
        }
        //서버로 비동기 요청
        try{
            const response = await axios.post('/user/check-email',{email:email});
            console.log("email response:",response);

            if (response.data.success) { //서버의 정상처리
                console.log("이메일로 인증코드 발송 성공")
                //인증번호 전송 텍스트 출력
                this.el.otpText.innerText = response.data.message;

                //타이머 시작
                this.timerStart(600)//초단위 입력 (10분) 60초 * 10

                // 인증번호 입력 UI 출력
                if (this.el.otpValidBox) { //null 검증 필수

                    this.el.otpValidBox.style.display = "block"; // 클래스  스타일 제어

                }
                //이메일 입력창 읽기전용
                this.el.userEmail.readOnly = true;

            }

        }catch(err){

            //중복된 메일일 경우 ,인증코드 인증 실패한 경우 등 예외 전부 처리
            alert(err.response?.data?.exMsg || "발송 실패");
            //인증번호 재요청과 이메일 중복일 경우 수정해야하니까
            this.el.userEmail.readOnly = false;
            this.el.sendEmailBtn.disabled = false;
        }
    }

    async confirmOtpCode(){
        //이메일

        //입력된 인증번호 담은 변수
        const userOtpCode = this.el.otpCodeInput.value.trim();
        const email = this.el.userEmail.value.trim();
        //이메일과 otp코드 둘다 필요
        try{
            const response = await axios.post('/otp/check-otp',
                {email:email, // 이메일도 같이 보내주어야 서버 검증 용이
                    otpCode: userOtpCode});

            if(response.data.success) {
                this.el.otpText.innerText = response.data.message;  //응답을 성공적으로 받으면,
                // 인증 성공 상태로 변경
                this.isEmailVerified = true;
                clearInterval(this.timerInterval);//타이머 멈추기

                //데이터 변경 방지
                this.el.otpCodeInput.readOnly = true; // 수정 못하게 읽기전용
                this.el.confirmOtpBtn.disabled = true; // 버튼 클릭 막기

                //재인증요청 버튼 출력
                this.el.retryOtpSendBtn.style.display = "block";
            }

        }catch(err){
            alert(err.response?.data?.exMsg || "인증 실패");
        }

    }

    // otp 재요청
    retryOtp(){
        //이메일인증 버튼과 입력창 활성화
        this.el.sendEmailBtn.disabled = false;//이메일 인증버튼 활성화
        this.el.userEmail.readOnly = false;  //이메일 입력창 활성화
        this.el.otpCodeInput.readOnly = false; // 인증코드 입력창 활성화
        this.el.confirmOtpBtn.disabled = false; // 인증코드 검증 활성화
    }


    //함수실행 버튼 트리거 이벤트
    bindEvents() {
        if (this.el.sendEmailBtn) {
            this.el.sendEmailBtn.onclick = () => this.sendOtpCode();
        }
        
        // 버튼 상태분리하기 -> 이해하고 넘어가기 ( 정리필요)
        if (this.el.confirmOtpBtn) {
            this.el.confirmOtpBtn.onclick = () => this.confirmOtpCode();
        }
        if (this.el.confirmOtpBtn) {
            this.el.retryOtpSendBtn.onclick = () => this.retryOtp();
           //this.el.retryOtpSendBtn.addEventListener('click', () => this.retryOtp());
        }
    }

    // end
}


//주의사항 
//클래스 내부의 인스턴스, 함수 등을 호출할때는 this를 꼭 지칭해줘야 이 클래스 객체 내부에서 찾음 
//this가 없다면 전역으로 나가버림