<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>로그아웃</title>
    <script src="../js/qa.js"></script> <!-- ✅ JS 분리 -->
</head>
<body onload="logoutNow()"> <!-- ✅ 페이지 로드 시 로그아웃 함수 실행 -->
</body>
</html>

<%
    // 세션 종료 처리
    session.invalidate();
%>
