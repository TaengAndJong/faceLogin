//얼굴등록 버튼 클릭 시 실행 비디오 UI띄워주기


//웹캠 작동
const video = document.getElementById('webcam'); // 웹캠 돔 요소 접근
// 브라우저에게 카메라 권한 요청
navigator.mediaDevices.getUserMedia({ video: true, audio: false })
    .then(stream => {
        video.srcObject = stream; // 비디오 태그에 실시간 영상 연결
    })
    .catch(err => {
        console.error("카메라를 켤 수 없습니다: ", err);
        alert("카메라 권한을 허용해주세요.");
    });


//사진 찍기
let capturedBlob = null; // canvas캡쳐 이미지를 blob로 바꾼값을 담을 변수
document.getElementById('capture-btn').addEventListener('click', () => {
    const canvas = document.getElementById('canvas'); //캔버스 돔 요소 접근
    const context = canvas.getContext('2d');

    // 비디오의 현재 화면을 캔버스에 그리기
    context.drawImage(video, 0, 0, 400, 400);

    // 비디오 닫기
    const stream = video.srcObject; // 현재 작동중인 비디오 태그의 스트림 가져오기
    const tracks = stream.getTracks(); //스트림 내부의 모든 트랙(오디오 ,비디오) 를 가져옴

    tracks.forEach(track => { // 트랙내부를 순회하며
        track.stop(); // 각 트랙 정지
    });

    video.srcObject = null; // 비디오 태그와 스트림의 연결을 끊어 화면을 검게 만듦

    //canvas blob로 변환
    canvas.toBlob((blob) => {
        capturedBlob = blob;// blob로 변환된 값 저장
        console.log("capturedBlob-- blob 생성 완료", capturedBlob);
        alert("얼굴 데이터가 준비되었습니다. 회원가입을 계속해주세요!");
    },"image/png");
});

//form submit 전송 스크립트
document.getElementById("registerForm").addEventListener("submit", async  function(e) {
    e.preventDefault();

    if (!capturedBlob) {
        alert("얼굴을 먼저 캡처해주세요!");
        return;
    }

    const formData = new FormData();

    formData.append("username", document.getElementById("username").value);
    formData.append("email", document.getElementById("email").value);

    // 이미지를 blob로 변경
    formData.append("faceImage", capturedBlob, "face.png");

    try{
        const response =
            await fetch("/api/register", {
                method: "POST",
                body: formData,
            });

        // response객체를 담은 promise 객체를 먼저 json으로 파싱
        const data = await response.json();
        
        if(!response.ok){ // 200아니면 서버에서 결과 데이터를 출력 또는 서버오류
            throw new Error(data.message || "서버 오류");
            // const error = new Error(data.message || "에러 발생");
            // error.code = data.code;
            // error.status = res.status;
            // throw error;
        }

        // 200 이면
        console.log("회원가입 성공:", data);

    }catch(err){
        console.error(err);
        console.log("회원가입 실패:", err);
        //사용자에게 안내
        if (err.status === 400) {
            alert("입력값 확인하세요");
        } else if (err.status === 500) {
            alert("서버 오류 발생");
        } else {
            alert(err.message);
        }

    }
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