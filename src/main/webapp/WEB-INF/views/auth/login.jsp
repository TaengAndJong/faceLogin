<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="customCss" value="/css/login/login.css" scope="request" />


<div class="content-inner">
    <h2 class="form-main-title">로그인</h2>
    <form id="loginForm" class="form" action="/login/check" method="post" >
        <div class="row mb-2">
            <label for="user-str-id" class="col-sm-2 col-form-label" >아이디</label>
            <div class="col-sm-5">
                <input type="text" name="userIdStr" id="user-str-id" class="form-control" placeholder="아이디 입력" required autocomplete="userIdStr">
            </div>
            <div class="col-auto">
                <button type="button" id="open-cam_btn" class="btn btn-dark face-btn"
                        aria-controls="face-area"
                        aria-expanded="false">로그인</button>
            </div>
            <div class="col-auto">
                <a href="<c:url value='/register' />" id="join-btn" class="btn btn-outline-dark" title="회원가입">회원가입</a>
            </div>
        </div>

        <fieldset class="face-filed">
            <legend class="sr-only">얼굴 로그인 촬영 영역</legend>
            <div id="face-area" class="apply-face_container"
                 role="dialog"
                 aria-modal="true"
                 aria-labelledby="face-title">
                <h3 id="face-title" class="sr-only">얼굴 촬영 모달</h3>
                <div id="cam-status" class="sr-only" aria-live="polite">카메라가 활성화되었습니다. 정면을 바라봐주세요.</div>
                <div class="face-con">
                    <video id="webcam" aria-label="실시간 카메라 화면" autoplay playsinline></video>
                    <canvas id="canvas" aria-label="촬영된 이미지 미리보기"></canvas>
                </div>
                <button type="button" id="capture-btn" class="btn btn-primary">촬영</button>
                <button type="button" id="close-btn" class="btn btn-secondary">닫기</button>
            </div>
        </fieldset>
    </form>

</div>
<script type="module" src="${pageContext.request.contextPath}/js/login.js"></script>

