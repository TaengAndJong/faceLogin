<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<form id="loginForm" action="/login/check" method="post">
    <label for="user-str-id">사용자 아이디</label>
    <input type="text" name="username" id="user-str-id" placeholder="아이디 입력">
    <fieldset >
        <legend>얼굴 인식</legend>
        <button type="button" id="open-camera-btn"
                aria-controls="face-area"
                aria-expanded="false">얼굴 촬영</button>
        <div id="face-area" class="apply-face_container"
             role="dialog"
             aria-modal="true"
             aria-labelledby="face-title">
            <h3 id="face-title">얼굴 등록</h3>
            <div class="con webcam">
                <video id="webcam" width="400" height="400" aria-label="웹캠 화면" autoplay playsinline></video>
            </div>
            <div class="con canvas">
                <canvas id="canvas" width="400" height="400" aria-label="캡쳐된 얼굴 이미지"></canvas>
            </div>
            <button type="button" id="face-login-btn">
                로그인
            </button>
            <button type="button" id="close-btn"> 닫기 </button>
        </div>
    </fieldset>
</form>
<a href="<c:url value='/register' />" id="join-btn" title="회원가입">회원가입</a>
<script type="module" src="${pageContext.request.contextPath}/js/login.js"></script>

