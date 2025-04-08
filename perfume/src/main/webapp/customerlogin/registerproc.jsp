<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("utf-8");
%>
<jsp:useBean id="cbean" class="pack.Login.CusLoginBean" />
<jsp:setProperty property="*" name="cbean" />

<jsp:useBean id="loginManager" class="pack.Login.LoginManager" />

<%
String createdate = new SimpleDateFormat("yyyy-MM-dd").format(new Date());
cbean.setCreatedate(createdate);

// 디버깅용 확인
System.out.println("최종 이메일 : " + cbean.getEmail());

boolean b = loginManager.memberInsert(cbean);  
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입 결과</title>
</head>
<body>
<%
if(b){
	out.println("<b>회원가입을 축하합니다!</b>");
	out.println("<a href='login.jsp'>회원 로그인</a><br>");
}else{
	out.println("<b>회원가입 실패. 다시 확인해주세요.</b>");
	out.println("<a href='register.jsp'>가입 재시도</a><br>");
}
%>
</body>
</html>
