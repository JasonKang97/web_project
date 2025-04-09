<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page import="org.apache.ibatis.session.SqlSession" %>
<%@ page import="pack.mybatis.SqlMapConfig" %>
<%@ page import="pack.mybatis.DeliveryMapper" %>
<%@ page import="pack.delivery.DeliveryBean" %>
<%@ page import="java.util.*" %>

<%
    SqlSession sqlSession = SqlMapConfig.getSqlSessionFactory().openSession();
    DeliveryMapper mapper = sqlSession.getMapper(DeliveryMapper.class);
    List<DeliveryBean> list = mapper.selectAll();
    sqlSession.close();

    request.setAttribute("deliverylist", list);
%>

<html>
<head>
    <title>배송관리</title>
    <link rel="stylesheet" href="../css/style.css">
</head>
<body>
<h2>배송 관리 페이지</h2>
<table border="1">
    <tr>
        <th>주문번호</th>
        <th>회원번호</th>
        <th>받는사람</th>
        <th>상품명</th>
        <th>배송상태</th>
        <th>배송시작일</th>
        <th>수정</th>
    </tr>
    <c:forEach var="dbean" items="${deliverylist}">
        <tr>
            <td><c:out value="${dbean.order_no}"/></td>
            <td><c:out value="${dbean.usern_no}"/></td>
            <td><c:out value="${dbean.username}"/></td>
            <td><c:out value="${dbean.productname}"/></td>
            <td>
                <c:choose>
                    <c:when test="${dbean.deliverystatus == 0}">주문 취소</c:when>
                    <c:when test="${dbean.deliverystatus == 1}">관리자 확인</c:when>
                    <c:when test="${dbean.deliverystatus == 2}">상품 준비중</c:when>
                    <c:when test="${dbean.deliverystatus == 3}">배송중</c:when>
                    <c:when test="${dbean.deliverystatus == 4}">배송완료</c:when>
                    <c:otherwise>기타</c:otherwise>
                </c:choose>
            </td>
            <td>
                <c:choose>
                    <c:when test="${not empty dbean.shippingdate}">
                        <fmt:formatDate value="${dbean.shippingdate}" pattern="yyyy-MM-dd"/>
                    </c:when>
                    <c:otherwise>-</c:otherwise>
                </c:choose>
            </td>
            <td>
                <a href="deliveryupdate.jsp?ordernumber=${dbean.order_no}">수정</a>
            </td>
        </tr>
    </c:forEach>
</table>
</body>
</html>
