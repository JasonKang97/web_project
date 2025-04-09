<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="org.apache.ibatis.session.SqlSession" %>
<%@ page import="org.apache.ibatis.session.SqlSessionFactory" %>
<%@ page import="pack.mybatis.SqlMapConfig" %>
<%@ page import="pack.mybatis.OrderMapper" %>
<%@ page import="pack.order.OrderDto" %>
<%@ page import="java.util.List" %>

<%
    SqlSessionFactory factory = SqlMapConfig.getSqlSessionFactory();
    SqlSession sqlSession = factory.openSession();
    OrderMapper mapper = sqlSession.getMapper(OrderMapper.class);
    List<OrderDto> list = mapper.getAllOrders();
    sqlSession.close();

    request.setAttribute("orderList", list);
%>

<html>
<head>
  <title>주문 관리</title>
  <link rel="stylesheet" type="text/css" href="../css/style.css">
</head>
<body>
<h2>주문 관리 (관리자)</h2>

<table border="1">
  <tr>
    <th>주문번호</th>
    <th>고객명</th>
    <th>상품명</th>
    <th>수량</th>
    <th>총금액</th>
    <th>주문상태</th>
    <th>주문일</th>
    <th>수정</th>
  </tr>
  <c:forEach var="o" items="${orderList}">
    <tr>
      <td>${o.order_no}</td>
      <td>${o.user_name}</td>
      <td>${o.productname}</td>
      <td>${o.orderquantity}</td>
      <td>${o.totalprice}</td>
      <td>${o.cancelednot}</td>
      <td><fmt:formatDate value="${o.orderdate}" pattern="yyyy-MM-dd" /></td>
      <td><a href="orderupdate.jsp?order_no=${o.order_no}">수정</a></td>
    </tr>
  </c:forEach>
</table>
</body>
</html>