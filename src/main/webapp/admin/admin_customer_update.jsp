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
<title>고객 정보 수정</title>
<link rel="stylesheet" type="text/css" href="../css/style.css">
</head>
<body>
<h2>고객 정보 수정</h2>
<form method="post" action="admin_customer_updateproc.jsp">
    <input type="hidden" name="email" value="<%= dto.getEmail() %>">
    <input type="hidden" name="userpassword" value="<%= dto.getUserpassword() %>">
    <input type="hidden" name="membershiptype" value="<%= dto.getMembershiptype() %>">
    <table border="1">
    	<tr><td>아이디[ Email ]</td><td><%= dto.getEmail() %></td></tr>
        <tr><td>고객 이름</td><td><input type="text" name="username" value="<%= dto.getUsername() %>"></td></tr>
        <tr><td>성별</td>
            <td>
                <label><input type="radio" name="gender" value="남" <%= dto.getGender().equals("남") ? "checked" : "" %>>남</label>
                <label><input type="radio" name="gender" value="여" <%= dto.getGender().equals("여") ? "checked" : "" %>>여</label>
            </td>
        </tr>
        <tr><td>전화번호</td><td><input type="text" name="phonenumber" value="<%= dto.getPhonenumber() %>"></td></tr>
        <tr><td>주소</td><td><input type="text" name="address" value="<%= dto.getAddress() %>"></td></tr>
        <tr><td>상세주소</td><td><input type="text" name="detailaddress" value="<%= dto.getDetailaddress() %>"></td></tr>
        <tr><td>생년월일</td><td><input type="date" name="birthdate" value="<%= dto.getBirthdate() %>"></td></tr>
        <tr><td>회원구분</td>
           		<td>
                     <%= dto.getMembershiptype()%>
            	</td>
        </tr>
        <tr><td colspan="2" style="text-align:center">
            <input type="submit" value="정보 수정">
            <input type="button" value="목록" onclick="location.href='admin_customer.jsp'">
        </td></tr>
    </table>
</form>
</body>
</html>
