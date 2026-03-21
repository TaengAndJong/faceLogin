<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<html>
    <head>
        <title>Face Login</title>
        <script>const contextPath = "${pageContext.request.contextPath}";</script>
        <%-- 공통  JS --%>
        <script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
        <%-- 공통 JS --%>
        <link rel="stylesheet" href="${contextPath}/css/style.css">
    </head>

    <body>
    <%-- /WEB-INF 는 외부 접근 차단 영역이라 views 기준으로 상대경로 사용--%>
    <jsp:include page="header.jsp" />
    <jsp:include page="nav.jsp" />

    <%--동적 페이지 영역으로 현재 요청 URL에 맞는 JSP를 자동으로 include--%>
    <div class="content">
        <!-- 실제 페이지 영역 -->
        <jsp:include page="/WEB-INF/views/${contentPage}" />
    </div>

    <jsp:include page="footer.jsp" />

    </body>
</html>