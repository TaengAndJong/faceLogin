<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<form id="loginForm" action="/login-auth" method="post">
    <input type="text" name="username" id="user-str-id">
    <video id="webcam"></video>
    <button id="face-login-btn" type="button">얼굴 로그인</button>
</form>
<script type="module" src="${pageContext.request.contextPath}/js/login.js"></script>

