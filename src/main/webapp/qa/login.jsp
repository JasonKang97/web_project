<%@ page contentType="text/html; charset=UTF-8" %>

<%
    request.setCharacterEncoding("UTF-8");
    String loginId = request.getParameter("id");

    if (loginId != null && !loginId.isEmpty()) {
        session.setAttribute("id", loginId);
        response.sendRedirect("qa_list.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>로그인</title>
    <link rel="stylesheet" href="../css/common.css">
    <script src="../js/qa.js"></script> <!-- ✅ JS 분리 -->
</head>
<body>

<div class="qa-container">
    <h2>관리자 로그인</h2>

    <!-- ✅ 전통형: form name 부여 + 버튼에 onclick 연결 -->
    <form name="loginForm">
        <div class="qa-form-group">
            <label for="id">아이디</label>
            <input type="text" name="id" id="id" required>
        </div>

        <div class="qa-form-actions">
            <button type="button" onclick="funcLogin()">로그인</button>
        </div>
    </form>
</div>

</body>
</html>
