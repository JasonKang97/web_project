<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>AdminLogin</title>
<link rel="stylesheet" type="text/css" href="../css/style.css">

<script type="text/javascript">
window.onload = function(){
	document.getElementById("btnAdminLogin").onclick = funcAdminLogin;
	document.getElementById("btnHome").onclick = funcAdminHome;
}

function funcAdminLogin(){		// 관리자 로그인 빈박스 확인작업
	if(adminLoginForm.admin_id.value === ""){
		alert("관리자 id를 입력하세요");
		adminLoginForm.admin_id.focus();
		return;
	}
	
	if(adminLoginForm.admin_passwd.value === ""){
		alert("관리자 password를 입력하세요");
		adminLoginForm.admin_passwd.focus();
		return;
	}
	
	adminLoginForm.submit();
}

function funcAdminHome(){	
	location.href="../od/odeur_main.jsp";
}
</script>
</head>
<body>
<form action="adminloginproc.jsp" name="adminLoginForm" method="post">
<table style="width: 300">
  <tr>
  	<td colspan="2">
  		<h2>Admin Login</h2>
  	</td>
  </tr>
  <tr>
  	<td>Id</td>
  	<td><input type="text" name="admin_id"></td>
  </tr>
  <tr>
  	<td>Password</td>
  	<td><input type="password" name="admin_passwd"></td>
  </tr>
  <tr>
  	<td colspan="2">
  		<input type="button" value="관리자 로그인" id="btnAdminLogin">
  		<input type="button" value="메인 홈페이지" id="btnHome">
  	</td>
  </tr>
</table>
</form>
</body>
</html>