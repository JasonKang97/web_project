<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
//session.removeAttribute("user_no");
//session.removeAttribute("idKey");

session.invalidate();
%>

<script>
	alert("로그아웃 성공! 안녕히 가세요.");
	location.href="../od/odeur_main.jsp";
</script>    
