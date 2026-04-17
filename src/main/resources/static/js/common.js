//header 로그아웃 버튼
const logoutBtn = document.getElementById('logoutBtn');
//로그아웃 비동기 요청
async function logout() {

    try{
        //로그아웃 post 요청
        const response = await axios.post('/logout', {});
        console.log("로그아웃 비동기 요청 응답",response);
        if(response.data.success){
            window.location.href = response.data.data;
        }

    }catch(err){

        alert(err.response.data.message || "서버 오류 발생");
        window.location.href = err.response.data.data;
    }

}

if(logoutBtn) {
    logoutBtn.addEventListener("click",logout);
}