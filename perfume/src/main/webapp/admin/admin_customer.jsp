<%@page import="pack.Login.CustomerManager"%>
<%@page import="pack.Login.CusLoginDto"%>
<%@page import="java.util.ArrayList"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>


<% 
request.setCharacterEncoding("utf-8"); 
String customsearch = request.getParameter("customsearch");
%>

<jsp:useBean id="customerManager" class="pack.Login.CustomerManager" />

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>고객 관리</title>
    <link rel="stylesheet" type="text/css" href="../css/style.css">
</head>
<body>
<h2>고객 정보 관리</h2>

<div class="search-bar">
    <form method="get">
        <input type="text" name="customsearch" placeholder="고객 검색" />
        <input type="submit" value="검색" />
    </form>
</div>

<table>
    <tr>
        <th>사용자이름</th><th>아이디[ Email ]</th><th>성별</th><th>전화번호</th><th>주소</th><th>상세주소</th><th>-</th>
    </tr>
    <%
   		CustomerManager customM = new CustomerManager();
    
        ArrayList<CusLoginDto> list = null;
        if(customsearch == null || customsearch.isEmpty()){
            list = customM.getCustomerAll();
        } else {
            list = customM.getCustomerPart(customsearch);
        }
        if(list.isEmpty()){	
    %>
    <tr><td colspan="6">가입한 고객(회원)이 없습니다.</td></tr>
    <%
    } else {
        for(CusLoginDto dto : list){
    %>
    <tr>
        <td><%=dto.getUsername()%></td>
        <td><%=dto.getEmail()%></td>
        <td><%=dto.getGender()%></td>
        <td><%=dto.getPhonenumber()%></td>
        <td><%=dto.getAddress()%></td>
        <td><%=dto.getDetailaddress()%></td>
        <td><a href='admin_customer_update.jsp?email=<%= dto.getEmail() %>'>고객 상세 정보</a></td>
    </tr>
    <%
            }
        }
    %>
</table>
</body>
</html>