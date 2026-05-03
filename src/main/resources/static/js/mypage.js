
const tryWithdraw = async () =>{
    if (!confirm("정말 탈퇴하시겠습니까? 데이터는 복구되지 않습니다.")) return;
    const response = await axios.post("/user/withdraw",{userStrId : userStrId});

    console.log("마이페이지 회원탈퇴 response",response);

}
