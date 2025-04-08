<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="pack.delivery.DeliveryManager" %>
<%@ page import="pack.delivery.DeliveryBean" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<jsp:useBean id="deliveryManager" class="pack.delivery.DeliveryManager" />
<jsp:useBean id="dbean" class="pack.delivery.DeliveryBean" />

<%
    List<DeliveryBean> list = deliveryManager.getDeliveryDetail();
    request.setAttribute("list", list);
%>
<link rel="stylesheet" type="text/css" href="../css/style.css">
<h2>배송 목록(관리자)</h2>
<table border="1" cellpadding="5" cellspacing="0">
    <thead>
        <tr>
            <th>주문번호</th>
            <th>고객명</th>
            <th>상품명</th>
            <th>배송상태</th>
            <th>배송시작일</th>
            <th>배송주소</th>
            <th>수정</th>
        </tr>
    </thead>
    <tbody>
        <c:forEach var="row" items="${list}">
            <tr>
                <td>${row.ordernumber}</td>
                <td>${row.username}</td>
                <td>${row.productname}</td>
                <td>
                    <c:choose>
                    	<c:when test="${row.deliverystatus == 0}">주문 취소</c:when>
                        <c:when test="${row.deliverystatus == 1}">관리자 확인 전</c:when>
                        <c:when test="${row.deliverystatus == 2}">상품 준비중</c:when>
                        <c:when test="${row.deliverystatus == 3}">배송중</c:when>
                        <c:when test="${row.deliverystatus == 4}">배송 완료</c:when>
                        <c:otherwise>알 수 없음</c:otherwise>
                    </c:choose>
                </td>
                <td>
                    <c:choose>
                        <c:when test="${row.shippingdate != null}">
                            ${fn:substring(row.shippingdate, 0, 10)}
                        </c:when>
                        <c:otherwise>-</c:otherwise>
                    </c:choose>
                </td>
                <td>${row.shpaddress} ${row.shpdetailaddress}</td>
                <td><a href="deliveryupdate.jsp?ordernumber=${row.ordernumber}">수정</a></td>
            </tr>
        </c:forEach>
    </tbody>
</table>


