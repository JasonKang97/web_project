<%@ page language="java" contentType="text/plain; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:useBean id="loginManager" class="pack.Login.LoginManager" />

<%
request.setCharacterEncoding("UTF-8");
String email = request.getParameter("email");

System.out.println("idcheck.jsp에서 전달받은 email: " + email);

boolean isDuplicate = loginManager.isEmailDuplicate(email);


if (isDuplicate) {
    out.print("이미 사용 중인 이메일입니다.");
} else {
    out.print("사용 가능한 이메일입니다.");
}
%>
