<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>




    <h2 class="form-main-title">로그인</h2>
    <form id="loginForm" class="form" action="/login/check" method="post" >
        <div class="row mb-2">
            <label for="user-str-id" class="col-sm-2 col-form-label" >아이디</label>
            <div class="col-sm-5">
                <input type="text" name="userStrId" id="user-str-id" class="form-control" placeholder="아이디 입력" required autocomplete="userStrId">
            </div>
            <div class="col-auto">
                <button type="button" id="face-btn" class="btn btn-dark "
                        aria-controls="face-area"
                        aria-expanded="false">얼굴확인</button>
            </div>
            <div class="col-auto">
                <a href="<c:url value='/register' />" id="join-btn" class="btn btn-outline-dark" title="회원가입">회원가입</a>
            </div>
        </div>
        <%--얼굴캠 --%>
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
                    <div id="canvas">
                        <canvas class="canvas-face_img" aria-label="촬영된 이미지 미리보기"></canvas>
                    </div>
                </div>
                <div class="btn-box">
                    <button type="button" id="capture-btn" class="btn btn-primary">촬영</button>
                    <button type="button" id="close-btn" class="btn btn-secondary">닫기</button>
                </div>
            </div>
        </fieldset>
        <%-- OTP인증--%>
        <fieldset>
            <legend class="sr-only">추가인증 opt 입력창</legend>
            <div id="otp_valid" class="mt-2">
                <div class="row">
                    <label for="otp-code" class="col-sm-2 col-form-label">인증번호</label>
                    <div class="col-sm-5">
                        <input type="text" id="otp-code" class="form-control" name="otpCode" placeholder="인증번호 6자리">
                    </div>
                    <div id="otp-btn_box" class="col-sm-5 d-flex">
                        <button type="button" id="confirm_otp"  class="btn btn-dark me-2 show-btn">인증확인</button>
                        <button type="button" id="reset-otp"  class="btn btn-primary me-2">재인증</button>
                        <span id="timer" class="text-bg-danger btn">3:00</span>
                    </div>
                </div>
                <p class="otp-text"></p>
            </div>
        </fieldset>

    </form>


<%--<script type="text/javascript" defer src="${pageContext.request.contextPath}/js/opencv/opencv_v4.5.0_.js" ></script>--%>
<%--<script type="module" src="${pageContext.request.contextPath}/js/login.js"></script>--%>

