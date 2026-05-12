<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


    <h3 class="form-main-title">
        회원가입
<%--        <span class="icon me-2">--%>
<%--            <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 576 512"><path d="M512 80c8.8 0 16 7.2 16 16l0 320c0 8.8-7.2 16-16 16L64 432c-8.8 0-16-7.2-16-16L48 96c0-8.8 7.2-16 16-16l448 0zM64 32C28.7 32 0 60.7 0 96L0 416c0 35.3 28.7 64 64 64l448 0c35.3 0 64-28.7 64-64l0-320c0-35.3-28.7-64-64-64L64 32zM208 248a56 56 0 1 0 0-112 56 56 0 1 0 0 112zm-32 40c-44.2 0-80 35.8-80 80 0 8.8 7.2 16 16 16l192 0c8.8 0 16-7.2 16-16 0-44.2-35.8-80-80-80l-64 0zM376 144c-13.3 0-24 10.7-24 24s10.7 24 24 24l80 0c13.3 0 24-10.7 24-24s-10.7-24-24-24l-80 0zm0 96c-13.3 0-24 10.7-24 24s10.7 24 24 24l80 0c13.3 0 24-10.7 24-24s-10.7-24-24-24l-80 0z"/></svg>--%>
<%--        </span>--%>
    </h3>
    <form id="registerForm" class="form" action="/register" method="post">
        <%-- CSRF (운영 환경에서 사용) --%>
        <%--
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
        --%>
        <fieldset>
            <legend class="h5 form-title">회원정보</legend>

            <%-- 아이디 --%>
            <div class="row mb-2">
                <label for="user-id_str" class="col-sm-2 col-form-label">아이디</label>
                <div class="col-sm-6">
                    <input type="text" id="user-id_str" class="form-control" name="userStrId" placeholder="아이디 입력" required autocomplete="userStrId">
                </div>
                <div class="col-sm">
                    <button type="button" id="confirm_id" class="btn btn-dark">중복확인</button>
                </div>
            </div>
            <%-- 이메일  중복확인 언제 : 이메일 입력 끝나면 API 호출 ? 아니면 중복확인 버튼 추가 ?--%>
            <div class="row mb-2">
                <label for="email-input" class="col-sm-2 col-form-label">이메일</label>
                <div class="col-sm-6">
                    <input type="email" id="email-input" class="form-control" name="email" placeholder="이메일 입력" required autocomplete="email">
                </div>
                <div class="col-sm-auto">
                    <button type="button" id="send-otp_email" class="btn btn-dark">인증번호</button>
                </div>

                <div id="otp_valid" class="mt-2 p-0">
                    <div class="row">
                        <label for="otp-code" class="col-sm-2 col-form-label">인증번호</label>
                        <div class="col-sm-4">
                            <input type="text" id="otp-code" class="form-control" name="otpCode" placeholder="인증번호 6자리">
                        </div>
                        <div id="otp-btn_box" class="col-sm-5 d-flex">
                            <button type="button" id="confirm_otp"  class="btn btn-dark me-2 show-btn">인증확인</button>
                            <button type="button" id="reset-otp"  class="btn btn-primary me-2">재인증</button>
                            <span id="timer" class="text-bg-danger btn">03:00</span>
                        </div>
                        <p class="otp-text"></p>

                    </div>
                </div>
            </div>
        </fieldset>
        <fieldset>
            <legend class="h5 form-title">정보제공 동의여부</legend>
            <div class="row">
                <div class="card mb-3">
                    <div class="card-body">
                        <h5 class="card-title">얼굴 인식 정보 수집 동의</h5>
                        <p class="card-text text-muted small">
                            촬영된 이미지는 <strong>벡터 데이터로 변환 후<span class="text-danger">즉시 파기</span></strong>됩니다.
                            <strong>변환된 데이터는 복구가 불가능한 수치 형태로 DB에 안전하게 저장</strong>됩니다.
                        </p>
                    </div>
                </div>
                <div class="form-check">
                    <input type="checkbox" id="chk"  class="form-check-input" name="agreeState" value="true" required>
                    <label for="chk" class="form-check-label fw-bold">  (필수) 얼굴 식별 정보 수집 및 이용에 동의합니다.</label>
                </div>
            </div>
        </fieldset>
        <%-- 얼굴 인식 영역 --%>
        <fieldset class="face-filed">
            <legend class="sr-only">얼굴 촬영 필드</legend>
            <button type="button" id="face-btn"  class="btn btn-dark"
                    aria-controls="face-area"
                    aria-expanded="false">얼굴 등록</button>
            <div id="face-area" class="apply-face_container"
                 role="dialog"
                 aria-modal="true"
                 aria-labelledby="face-title">
                <h3 id="face-title" class="sr-only">얼굴촬영 웹캠</h3>
                <div class="face-con">
                    <div class="con-inner">
                        <video id="webcam"  aria-label="웹캠 화면" autoplay playsinline></video>
                    </div>
                    <button type="button" id="capture-btn" class="btn btn-primary">촬영</button>
                    <button type="button" id="close-btn" class="btn btn-secondary">닫기</button>
                </div>
            </div>
            <div id="canvas">
                <canvas class="canvas-face_img" aria-label="화면에 보여지는 캡쳐된 얼굴 이미지"></canvas>
            </div>

            <canvas class="hidden-face_img" aria-label="서버로 보낼 캡쳐된 얼굴 이미지"></canvas>

        </fieldset>
        <%-- 얼굴 인식 영역 --%>

    </form>
    <%-- 제출 --%>
    <div class="button-group">
        <button type="submit" form="registerForm"  class="btn btn-primary">
            회원가입
        </button>
        <button type="button" onclick="location.href='${pageContext.request.contextPath}/login'"  class="btn btn-secondary">
            취소
        </button>
    </div>


<%--<script type="text/javascript" defer src="${pageContext.request.contextPath}/js/opencv/opencv_v4.5.0_.js" ></script>--%>
<%--<script type="module" src="${pageContext.request.contextPath}/js/register.js"></script>--%>



<%--
java/JSP는 서버에서 돌아가는 언어이고
웹캠은 사용자의 브라우저(클라이언트)에 존재하는 장치로
 1) 웹캠은 자바스크립트를 사용하여 조작하여야 함
 - JSP의 역할: 영상을 보여줄 도화지(<video> 태그)와 데이터를 담을 그릇(input 태그)을 제공
 - JavaScript의 역할: 사용자의 카메라 권한을 요청하고,
    실시간 영상을 <video>에 연결하며, 버튼을 눌러 사진을 찍음
 --%>