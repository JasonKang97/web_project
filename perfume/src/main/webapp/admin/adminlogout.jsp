<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%

//session.removeAttribute("adminKey");
session.invalidate();

%>

<script>
	alert("관리자 로그아웃 완료!");
	location.href = "../od/odeur_main.jsp";
</script>    