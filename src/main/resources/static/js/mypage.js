


const tryWithdraw = async () =>{
    const userStrId = document.getElementById("user-id_str").value;

    console.log("userStrId--- 회원탈퇴 ", userStrId);

    if (!confirm("정말 탈퇴하시겠습니까? 데이터는 복구되지 않습니다.")) return;

    try{
        const response = await axios.post("/user/withdraw",null,{
            params:{
                userStrId : userStrId
            },
            withCredentials: true //쿠키 담아보내기
        });

        console.log("마이페이지 회원탈퇴 response",response.data);
        //성공
        if (response.data.success) { //비즈니스 에러 방지조건
            alert(response.data.message); //탈퇴 성공 코드
            location.href = "/login"; // 탈퇴 후 리다이렉트 페이지
        }

    }catch(err){//네트워크/서버 에러
        console.log("마이페이지 회원탈퇴 err",err.response);
        alert(err.response.data.exMsg);
    }


}

const btn = document.getElementById('withdrawBtn');
if (btn) {
    btn.addEventListener('click', tryWithdraw);
}
