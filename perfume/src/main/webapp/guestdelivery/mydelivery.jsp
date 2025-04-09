<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.*" %>
<%@ page import="pack.delivery.CustomerDeliveryManager" %>
<%@ page import="pack.delivery.CustomerDeliveryDto" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    Integer userNo = (Integer) session.getAttribute("user_no");
    if (userNo == null) {
        out.println("<script>alert('로그인이 필요합니다.'); location.href='../customerlogin/login.jsp';</script>");
        return;
    }

    CustomerDeliveryManager manager = new CustomerDeliveryManager();
    List<CustomerDeliveryDto> list = manager.getMyDeliveries(userNo);
    for(CustomerDeliveryDto d : list){
        System.out.println(d.getOrder_no() + " " + d.getProduct_name() + " " + d.getOrder_quantity());
    }
    request.setAttribute("deliveryList", list);
%>
<%@ include file="../include/top.jsp" %>
<html>
<head>
    <title>나의 배송 조회</title>
    <link rel="stylesheet" type="text/css" href="../css/common2.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
</head>
<body>
<div class="page-container">
<h2 class="section-title">나의 배송 내역</h2>
<table class="basic-table">
<tr>
    <th>주문번호</th><th>상품명</th><th>수량</th><th>주문일</th>
    <th>배송상태</th><th>송장번호</th><th>주소</th>
</tr>
<c:forEach var="d" items="${deliveryList}">
<tr>
    <td>${d.order_no}</td>
    <td><a href="../guest_product/guest_productdetail.jsp?product_no=${d.product_no}" class="title-btn detail-button">${d.product_name}</a></td>
    <td>${d.order_quantity}</td>
    <td>${d.order_date}</td>
    <td>
        <c:choose>
        	<c:when test="${d.deliverystatus == 0}">주문취소</c:when>
            <c:when test="${d.deliverystatus == 1}">주문접수</c:when>
            <c:when test="${d.deliverystatus == 2}">상품준비 중</c:when>
            <c:when test="${d.deliverystatus == 3}">배송중</c:when>
            <c:when test="${d.deliverystatus == 4}">배송완료</c:when>
            <c:otherwise>확인불가</c:otherwise>
        </c:choose>
    </td>
    <td>${d.trackingnumber}</td>
    <td>${d.shpaddress} ${d.shpdetailaddress}</td>
</tr>
</c:forEach>
</table>
</div>
</body>
</html>

<%@ include file="../include/bottom.jsp" %>