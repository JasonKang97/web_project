<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.*" %>
<%@ page import="pack.order.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    OrderManager manager = new OrderManager();
    ArrayList<OrderDto> list = manager.getAllOrders();
    request.setAttribute("orderlist", list);
%>
<html>
<head>
    <title>주문 관리</title>
    <link rel="stylesheet" type="text/css" href="../css/style.css">
</head>
<body>
<h2>주문 목록</h2>
<table border="1">
    <tr>
        <th>주문번호</th><th>고객명</th><th>상품명</th><th>수량</th><th>가격</th>
        <th>총액</th><th>상태</th><th>주문일</th><th>수정</th>
    </tr>
    <c:forEach var="order" items="${orderlist}">
        <tr>
            <td>${order.order_no}</td>
            <td>${order.user_name}</td>
            <td>${order.product_name}</td>
            <td>${order.order_quantity}</td>
            <td>${order.product_price}</td>
            <td>${order.total_price}</td>
            <td>${order.canceled_not}</td>
            <td>${order.order_date}</td>
            <td>
                <a href="orderupdate.jsp?order_no=${order.order_no}">[상태수정]</a>
            </td>
        </tr>
    </c:forEach>
</table>
</body>
</html>
