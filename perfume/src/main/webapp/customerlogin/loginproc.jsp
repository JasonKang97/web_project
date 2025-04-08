<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="loginManager" class="pack.Login.LoginManager" />

<%
request.setCharacterEncoding("utf-8");

String email = request.getParameter("email");
String passwd = request.getParameter("passwd");

boolean b = loginManager.loginCheck(email, passwd);

if(b){
	session.setAttribute("customerKey", email);
	int userNo = loginManager.getUser_no(email);
	session.setAttribute("user_no", userNo); // user_no 세션에 저장

	response.sendRedirect("../od/odeur_main.jsp");
}else{
	%>
	<script>
	alert("회원 로그인 실패. 다시 확인해주세요.");
	location.href = "login.jsp";
	</script>
	<%
}
%>