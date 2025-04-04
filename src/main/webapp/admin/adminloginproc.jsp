<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="loginManager" class="pack.Login.LoginManager" />

<%
String adminid = request.getParameter("admin_id");
String adminpasswd = request.getParameter("admin_passwd");
  
boolean b = loginManager.adminLoginCheck(adminid, adminpasswd);

if(b){
	session.setAttribute("adminKey", adminid);   // 관리자 로그인 세션 생성
	response.sendRedirect("admin_main.jsp");
}else{ 
%>
	<script>
	alert("관리자 로그인 실패. 다시 입력해주세요.");
	location.href = "adminlogin.jsp";
	</script>
<%	
}
%>