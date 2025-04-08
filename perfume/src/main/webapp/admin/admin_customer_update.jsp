<%@page import="pack.Login.CusLoginDto"%>
<%@page import="pack.Login.CustomerManager"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%
    request.setCharacterEncoding("utf-8");
    String email = request.getParameter("email");
    CustomerManager manager = new CustomerManager();
    CusLoginDto dto = manager.getCustomerByEmail(email);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>고객 상세 정보</title>
<link rel="stylesheet" type="text/css" href="../css/style.css">
</head>
<body>
<h2>고객 상세 정보</h2>
<form method="post" action="admin_customer_updateproc.jsp">
     <input type="hidden" name="email" value="<%= dto.getEmail() %>">
    <input type="hidden" name="username" value="<%= dto.getUsername() %>">
    <input type="hidden" name="gender" value="<%= dto.getGender() %>">
    <input type="hidden" name="address" value="<%= dto.getAddress() %>">
    <input type="hidden" name="detailaddress" value="<%= dto.getDetailaddress() %>">
    <input type="hidden" name="birthdate" value="<%= dto.getBirthdate() %>">
    <input type="hidden" name="phonenumber" value="<%= dto.getPhonenumber() %>">
    <input type="hidden" name="userpassword" value="<%= dto.getUserpassword() %>">
    <input type="hidden" name="membershiptype" value="<%= dto.getMembershiptype() %>">
    <table border="1">
    	<tr><td>아이디[ Email ]</td><td><%= dto.getEmail() %></td></tr>
        <tr><td>고객 이름</td><td><%= dto.getUsername() %></td></tr>
        <tr><td>성별</td><td><%= dto.getGender() %></td></tr>
        <tr><td>전화번호</td><td><%= dto.getPhonenumber() %></td></tr>
        <tr><td>주소</td><td><%= dto.getAddress() %></td></tr>
        <tr><td>상세주소</td><td><%= dto.getDetailaddress() %></td></tr>
        <tr><td>생년월일</td><td><%= dto.getBirthdate() %></td></tr>
        <tr><td>회원구분</td>
           		<td>
                     <%= dto.getMembershiptype()%>
            	</td>
        </tr>
        <tr><td colspan="2" style="text-align:center">
            <input type="submit" value="확인 완료">
            <input type="button" value="목록" onclick="location.href='admin_customer.jsp'">
        </td></tr>
    </table>
</form>
</body>
</html>
