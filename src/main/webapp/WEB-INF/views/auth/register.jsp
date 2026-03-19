<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<h2>회원가입</h2>

<form id="registerForm" action="/register" method="post">

    <%-- CSRF (운영 환경에서 사용) --%>
    <%--
    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
    --%>
    <fieldset>
        <legend>회원가입 정보입력</legend>
        <%-- 아이디 --%>
        <div>
            <label for="username">아이디</label>
            <input type="text" id="username" name="username" placeholder="아이디 입력" required autocomplete="username">
        </div>
        <%-- 이메일 --%>
        <div>
            <label for="email">이메일</label>
            <input type="email" id="email" name="email" placeholder="이메일 입력" required autocomplete="email">
        </div>
    </fieldset>

    <%-- 얼굴 인식 영역 --%>
    <fieldset >
        <legend>얼굴 인식</legend>
        <button type="button" class="open-face_btn"
                aria-controls="face-area"
                aria-expanded="false">얼굴등록</button>
        <div id="face-area" class="apply-face_container"
             role="dialog"
             aria-modal="true"
             aria-labelledby="face-title"
             hidden>
            <h3 id="face-title">얼굴 등록</h3>
            <div class="con webcam">
                <video id="webcam" width="400" height="400" aria-label="웹캠 화면" autoplay playsinline></video>
            </div>
            <div class="con canvas">
                <canvas id="canvas" width="400" height="400" aria-label="캡쳐된 얼굴 이미지"></canvas>
            </div>

            <button type="button" id="capture-btn">
                얼굴 캡처
            </button>
            <button type="button" id="close-btn"> 닫기 </button>
        </div>
    </fieldset>
</form>
<%-- 제출 --%>
<div>
    <button type="submit">
        회원가입
    </button>
    <button type="button">
        취소
    </button>
</div>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/register.js"></script>



<%--
java/JSP는 서버에서 돌아가는 언어이고
웹캠은 사용자의 브라우저(클라이언트)에 존재하는 장치로
 1) 웹캠은 자바스크립트를 사용하여 조작하여야 함
 - JSP의 역할: 영상을 보여줄 도화지(<video> 태그)와 데이터를 담을 그릇(input 태그)을 제공
 - JavaScript의 역할: 사용자의 카메라 권한을 요청하고,
    실시간 영상을 <video>에 연결하며, 버튼을 눌러 사진을 찍음
 --%>