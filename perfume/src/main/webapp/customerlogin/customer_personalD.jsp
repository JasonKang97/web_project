<%@page import="pack.Login.CusLoginDto"%>
<%@page import="pack.Login.CustomerManager"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%
request.setCharacterEncoding("utf-8");

// 세션에서 user_no 가져오기
Integer userNo = (Integer) session.getAttribute("user_no");

CusLoginDto dto = null;
if (userNo != null) {
    CustomerManager manager = new CustomerManager();
    dto = manager.getCustomerByUserNo(userNo); 
} else {
    out.println("<p>로그인 정보가 없습니다. 로그인 해주세요.</p>");
    return;
}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이 페이지</title>
<link rel="stylesheet" type="text/css" href="../css/style.css">
</head>
<body>

<h2>마이 페이지</h2>

<!-- 사용자에게 보여주는 table (form 바깥) -->
<table border="1">
    <tr><td>아이디(Email)</td><td><%= dto.getEmail() %></td></tr>
    <tr><td>고객 이름</td><td><%= dto.getUsername() %></td></tr>
    <tr><td>성별</td><td><%= dto.getGender() %></td></tr>
    <tr><td>전화번호</td><td><%= dto.getPhonenumber() %></td></tr>
    <tr><td>주소</td><td><%= dto.getAddress() %></td></tr>
    <tr><td>상세주소</td><td><%= dto.getDetailaddress() %></td></tr>
    <tr><td>생년월일</td><td><%= dto.getBirthdate() %></td></tr>
    <tr><td>회원구분</td><td><%= dto.getMembershiptype() %></td></tr>
</table>

<!-- 정보 수정 form (hidden input 만) -->
<form method="post" action="customer_personalD_updete.jsp">
    <input type="hidden" name="email" value="<%= dto.getEmail() %>">
    <input type="hidden" name="username" value="<%= dto.getUsername() %>">
    <input type="hidden" name="gender" value="<%= dto.getGender() %>">
    <input type="hidden" name="address" value="<%= dto.getAddress() %>">
    <input type="hidden" name="detailaddress" value="<%= dto.getDetailaddress() %>">
    <input type="hidden" name="birthdate" value="<%= dto.getBirthdate() %>">
    <input type="hidden" name="phonenumber" value="<%= dto.getPhonenumber() %>">
    <input type="hidden" name="userpassword" value="<%= dto.getUserpassword() %>">
    <input type="hidden" name="membershiptype" value="<%= dto.getMembershiptype() %>">
    <br>
<table>
        <tr><td colspan="2" style="text-align:center">
            <input type="submit" value="정보 수정">
            <input type="button" value="뒤로 가기" onclick="location.href='../od/odeur_main.jsp'">
        </td></tr>
</table>
    <br>
</form>

</body>
</html>
