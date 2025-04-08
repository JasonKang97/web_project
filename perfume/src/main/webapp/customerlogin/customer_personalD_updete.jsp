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
<title>마이 페이지 정보 수정</title>
<link rel="stylesheet" type="text/css" href="../css/style.css">
</head>
<body>
<h2>마이 페이지 정보 수정</h2>
<form method="post" action="customer_personalD_updeteproc.jsp">
    <input type="hidden" name="email" value="<%= dto.getEmail() %>">
    <input type="hidden" name="username" value="<%= dto.getUsername() %>">
    <input type="hidden" name="userpassword" value="<%= dto.getUserpassword() %>">
    <input type="hidden" name="membershiptype" value="<%= dto.getMembershiptype() %>">
    <table border="1">
    	<tr><td>아이디[ Email ]</td><td><%= dto.getEmail() %></td></tr>
        <tr><td>고객 이름</td><td><%= dto.getUsername() %></td></tr>
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
            <input type="button" value="수정 취소" onclick="if(confirm('수정 취소 하시겠습니까? 수정한 내용은 삭제 후 마이페이지로 갑니다.')) { location.href='customer_personalD.jsp'; }">
            <input type="button" value="메인 페이지" onclick="if(confirm('메인페이지로 이동 하시겠습니까? 수정한 내용은 삭제 후 홈페이지로 돌아갑니다.')) { location.href='../od/odeur_main.jsp'; }">
        </td></tr>
    </table>
</form>
</body>
</html>
