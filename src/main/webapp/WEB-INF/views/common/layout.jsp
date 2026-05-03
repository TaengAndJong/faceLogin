<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> <%-- 조건문 처리용 --%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> <%-- 문자열 처리용 --%>

<%-- 특정 페이지 전용 CSS 동적 삽입  경로 미리 추출 , 기준은 contentPage 경로--%>
<c:set var="finalPath" value="${fn:substringBefore(contentPage, '.')}" /> <%-- . 문자 전까지 자르기--%>
<%--특정 페이지 전용  body에 사용할 클래스 --%>
<c:set var="pageName" value="${fn:contains(finalPath, '/') ? fn:substringAfter(finalPath, '/') : finalPath}" />
<html>
    <head>
        <title>Face Login</title>
        <script>const contextPath = "${pageContext.request.contextPath}";</script>
        <%-- 공통  JS --%>
        <script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
        <%-- 공통 bootstrap --%>
        <link rel="stylesheet" href="${contextPath}/css/common/reset.css">
        <%-- 공통 bootstrap --%>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet" crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.13.1/font/bootstrap-icons.min.css" crossorigin="anonymous">
        <%-- 공통 fonts --%>
        <link rel="stylesheet" href="${contextPath}/css/common/fonts.css">
        <%-- 공통 css --%>
        <link rel="stylesheet" href="${contextPath}/css/common/custom.css">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>

        <%-- 자동 CSS 매칭 --%>
        <c:if test="${not empty finalPath}">
            <link rel="stylesheet" href="${contextPath}/css/${finalPath}.css">
        </c:if>
    </head>
<c:if test="${not empty pageName}">
    <body class="body ${pageName}">
</c:if>
    <%-- /WEB-INF 는 외부 접근 차단 영역이라 views 기준으로 상대경로 사용--%>
    <jsp:include page="header.jsp" />
    <jsp:include page="nav.jsp" />

    <%--동적 페이지 영역으로 현재 요청 URL에 맞는 JSP를 자동으로 include--%>

    <div class="content">
        <div class="content-inner">
        <!-- 실제 페이지 영역 -->
        <jsp:include page="/WEB-INF/views/${contentPage}" />
        </div>
    </div>
    <jsp:include page="footer.jsp" />
    <script src="${contextPath}/js/common.js"></script>
    <%--공통 라이브러리 (OpenCV가 필요한 페이지들만 묶기)--%>
    <c:if test="${pageName eq 'register' || pageName eq 'login' || pageName eq 'mypage'}">
        <script src="${contextPath}/js/opencv/opencv_v4.5.0_.js" defer></script>
    </c:if>
    <%--페이지 전용 스크립트 자동 매칭--%>
    <c:if test="${not empty pageName}">
        <script type="module" src="${contextPath}/js/${pageName}.js"></script>
    </c:if>

    </body>
</html>