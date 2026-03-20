
// 촬영상태관리
let isCaptured = false;
const video = document.getElementById('webcam'); // 웹캠 돔 요소 접근

// 사진촬영 시작
const openCamera =()=>{
    video.style.display = "block"; // 비디오 보이기
    // 브라우저에게 카메라 권한 요청
    navigator.mediaDevices.getUserMedia({ video: true, audio: false })
        .then(stream => {
            video.srcObject = stream; // 비디오 태그에 실시간 영상 연결
        })
        .catch(err => {
            console.error("카메라를 켤 수 없습니다: ", err);
            alert("카메라 권한을 허용해주세요.");
        });
}
// 촬영 끝 자원정리
const closeCamera =()=>{
    const stream = video.srcObject; // 현재 작동중인 비디오 태그의 스트림 가져오기
    if (stream) {
        const tracks = stream.getTracks(); //스트림 내부의 모든 트랙(오디오 ,비디오) 를 가져옴
        tracks.forEach(track => { // 트랙내부를 순회하며
            track.stop(); // 각 트랙 정지
        });
        // 비디오 태그와 스트림의 연결을 끊어 화면을 검게 만듦
        video.srcObject=null;
    }
}


//사진 찍기
let capturedBlob = null; // canvas캡쳐 이미지를 blob로 바꾼값을 담을 변수

//얼굴 캡쳐, 버튼 텍스트 변경
const captureFace = (e) => {
    // 화살표 함수에서 버튼을 지칭할 때는 e.currentTarget 또는 e.target을 씁니다.
    const btn = e.currentTarget;
    const canvas = document.getElementById('canvas');
    const context = canvas.getContext('2d');


    if(!isCaptured){ // true 이면

        // 캔버스 설정
        canvas.width = 400;
        canvas.height = 400;
        // 캔버스에 그리기
        context.drawImage(video, 0, 0, canvas.width, canvas.height);

        // 카메라 스트림 자원 정리하기
        closeCamera();
        //Blob 생성
        canvas.toBlob((blob) => {
            capturedBlob = blob;
        }, "image/png");

        // 버튼 텍스트 변경 (e.currentTarget 덕분에 가능!)
        btn.innerText = "재촬영하기";
        //버튼 컬러변경
        btn.classList.replace("btn-primary", "btn-danger");
        //촬영상태 변경
        isCaptured = true;
        alert("촬영 완료");
    }else{
        //이전 캔버스 사진지우기
        context.clearRect(0, 0, canvas.width, canvas.height);
        //재촬영 모드
        openCamera();
        //텍스트 변경
        btn.innerText = "사진 촬영";
        //버튼 컬러변경
        btn.classList.replace("btn-danger", "btn-primary");
        //촬영상태 변경
        isCaptured = false;
        // 이전 데이터 초기화
        capturedBlob = null;
    }


};

//form submit 전송 스크립트
document.getElementById("registerForm").addEventListener("submit", async  function(e) {
    e.preventDefault();

    if (!capturedBlob) {
        alert("사진을 먼저 촬영해주세요.");
        return;
    }

    const formData = new FormData();
    formData.append("username", document.getElementById("username").value);
    formData.append("email", document.getElementById("email").value);

    // 이미지를 blob로 변경
    formData.append("faceImage", capturedBlob, "face.png");

    try{
        // axios.post(URL,데이터) 호출, Json 자동 파싱하여 data에 담김
        const response = await axios.post("/register", formData);
        const data = await response.data;
        // 200 이면
        console.log("회원가입 성공:", data);
        alert("회원가입 완료");
       //로그인페이지로 이동시키려면?
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
* 4) fetch의 body에 formData를 담아주면 자동으로 multipart/form-data 변경됨
* 5) fetch는 서버로부터 Response 객체를 담은 Promise를 반환 후 json으로 변경
*    == Promise<Response> 를 반환
* 6) then에서 최종 JSON 데이터 객체를 받아 사용
* */