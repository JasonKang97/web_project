<%@ page contentType="text/html; charset=UTF-8" %>
<%
    // 세션 종료 처리
    session.invalidate();
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>로그아웃</title>
    <script>
        // 페이지 로드 시 자동으로 로그인 페이지로 이동
        function logoutNow() {
            alert("로그아웃 되었습니다.");
            location.href = "qa_list.jsp";
        }
    </script>
</head>
<body onload="logoutNow()"> <!-- ✅ 페이지 로드시 자동 로그아웃 안내 및 이동 -->
</body>
</html>
