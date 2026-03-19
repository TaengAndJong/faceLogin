<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<form id="loginForm" action="/login-auth" method="post">
    <input type="text" name="username">
    <input type="hidden" id="faceImage" name="faceImage">
    <button type="button" onclick="captureAndSubmit()">로그인</button>
</form>