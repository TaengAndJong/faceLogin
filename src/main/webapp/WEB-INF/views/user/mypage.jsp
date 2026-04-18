<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="userData" value="${userDetails}"/>
<%--${userDetails.user}로 접근할 필요없이 바로 엔터티로 접근 ( userDetails에 위임메서드 형태로 설정함 )--%>

<div class="content-inner">
    <h3 class="form-main-title">
        마이페이지
    </h3>
    <form id="mypageForm" class="form" action="/mypage" method="post">
        <%-- CSRF (운영 환경에서 사용) --%>
        <%--
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
        --%>
        <input type="hidden" id="userId" name="userId" value="${userData.userId}">
        <fieldset>
            <legend class="h5 form-title">회원정보</legend>
            <%-- 아이디 --%>
            <div class="row mb-2">
                <label for="user-id_str" class="col-sm-2 col-form-label">아이디</label>
                <div class="col-sm-6">
                    <input type="text" id="user-id_str" class="form-control-plaintext" value="${userData.userStrId}" readonly>
                </div>
            </div>

            <%-- 이메일  중복확인 언제 : 이메일 입력 끝나면 API 호출 ? 아니면 중복확인 버튼 추가 ?--%>
            <div class="row mb-2">
                <label for="email" class="col-sm-2 col-form-label">이메일</label>
                <div class="col-sm-6">
                    <input type="text" id="email" class="form-control-plaintext" value="${userData.email}" readonly>
                </div>
            </div>

            <div class="row mb-2">
                <label for="created_at" class="col-sm-2 col-form-label">가입일</label>
                <div class="col-sm-6">
                    <input type="text" id="created_at" class="form-control-plaintext" value="${userData.createdAt}" readonly>
                </div>
            </div>

            <div class="row mb-2">
                <label for="user_role" class="col-sm-2 col-form-label">등급</label>
                <div class="col-sm-6">
                    <p id="user_role">${userData.userRole}</p>
                </div>
            </div>

            <div class="row">
                <label for="agreeState" class="col-sm-2 col-form-label">정보제공<br/>동의여부</label>
                <div class="col-sm-6">
                    <input type="text" id="agreeState" class="form-control-plaintext" value="${userData.agreeStatusString}" readonly>
                </div>
            </div>

        </fieldset>

    </form>
    <%-- 제출 --%>

    <div class="button-group">
        <button type="button" onclick="location.href='${pageContext.request.contextPath}/modifyUserData'" class="btn btn-primary">
            정보수정
        </button>
        <button type="button" onclick="location.href='${pageContext.request.contextPath}/deleteAccount'"  class="btn btn-secondary">
            회원탈퇴
        </button>
    </div>
</div>

<%--<script type="module" src="${pageContext.request.contextPath}/js/mypagae.js"></script>--%>
