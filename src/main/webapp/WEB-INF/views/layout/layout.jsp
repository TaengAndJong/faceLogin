<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<html>
    <head>
        <title>Face Login</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    </head>

    <body>
    <%-- /WEB-INF 는 외부 접근 차단 영역이라 views 기준으로 상대경로 사용--%>
    <jsp:include page="../common/header.jsp" />
    <jsp:include page="../common/nav.jsp" />

    <%--동적 페이지 영역으로 현재 요청 URL에 맞는 JSP를 자동으로 include--%>
    <div class="content">
        <!-- 실제 페이지 영역 -->
        <jsp:include page="${pageContext.request.servletPath}.jsp"/>
    </div>

    <jsp:include page="../common/footer.jsp" />

    </body>
</html>