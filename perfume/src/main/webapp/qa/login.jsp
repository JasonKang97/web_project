<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>로그인</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
    <link rel="stylesheet" href="../css/login.css">

    <script src="../js/qa.js"></script> <!-- ✅ JS 분리 -->
    <script>
        // 로그인 버튼 클릭 시 실행될 함수
        function funcLogin() {
            const id = document.getElementById("admin_id").value.trim();
            const pw = document.getElementById("admin_passwd").value.trim();

            if (id === "") {
                alert("아이디를 입력하세요.");
                document.getElementById("admin_id").focus();
                return;
            }

            if (pw === "") {
                alert("비밀번호를 입력하세요.");
                document.getElementById("admin_passwd").focus();
                return;
            }

            document.loginForm.submit(); // 전통적인 방식으로 form 제출
        }
    </script>
</head>
<body>

<div class="qa-container">
    <h2>Q&A 관리자 로그인</h2>

    <!-- ✅ form name + onclick 전통형 방식 -->
    <form name="loginForm" action="qa_loginproc.jsp" method="post">
        <div class="qa-form-group">
            <label for="admin_id">아이디</label>
            <input type="text" name="admin_id" id="admin_id" required>
        </div>

        <div class="qa-form-group">
            <label for="admin_passwd">비밀번호</label>
            <input type="password" name="admin_passwd" id="admin_passwd" required>
        </div>

        <div class="qa-form-actions">
            <button type="button" onclick="funcLogin()">로그인</button>
        </div>
    </form>
</div>

</body>
</html>