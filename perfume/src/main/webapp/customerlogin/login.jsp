<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
String id = (String)session.getAttribute("customerKey");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>AromaDesk</title>
<link rel="stylesheet" type="text/css" href="../css/login.css">
<script type="text/javascript">

window.onload = () => {
    const loginBtn = document.querySelector("#Login");
    const newMemberBtn = document.querySelector("#NewMember");
    document.querySelector("#Main").addEventListener("click", () => {
        location.href = "../od/odeur_main.jsp";
    });

    if (loginBtn) {
        loginBtn.addEventListener("click", funcLogin);
    }
    if (newMemberBtn) {
        newMemberBtn.addEventListener("click", funcNewMember);
    }
}

function funcLogin(){
      if(loginForm.email.value === ""){ // id → email
        alert("이메일 입력");
        loginForm.email.focus();
      } else if(loginForm.passwd.value === ""){
        alert("회원 비밀번호 입력");
        loginForm.passwd.focus();
      } else {
        loginForm.action = "loginproc.jsp";
        loginForm.method = "post";
        loginForm.submit();
      }
    }


function funcNewMember(){
    location.href = "register_select.jsp";
}
</script>
</head>
<body>
<form name = "loginForm">
    <table>
      <tr>
          <td colspan="2" style="text-align: center;">회원 로그인</td>
      </tr>
      <tr>
          <td>아이디(E.mail)</td>
          <td><input type="text" name="email"></td>
      </tr>
      <tr>
          <td>비밀번호</td>
          <td><input type="password" name="passwd"></td>
      </tr>
      <tr>
          <td colspan="2">
              <input type="button" value="로 그 인" id="Login">
              <input type="button" value="회원가입" id="NewMember">
              <input type="button" value="메인으로 돌아가기" id="Main">
          </td>
      </tr>
    </table>
</form>

</body>
</html>