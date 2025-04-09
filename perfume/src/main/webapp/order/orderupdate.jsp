<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="org.apache.ibatis.session.SqlSession" %>
<%@ page import="org.apache.ibatis.session.SqlSessionFactory" %>
<%@ page import="pack.mybatis.SqlMapConfig" %>
<%@ page import="pack.mybatis.OrderMapper" %>
<%@ page import="pack.order.OrderDto" %>

<%
    int order_no = Integer.parseInt(request.getParameter("order_no"));
    SqlSessionFactory factory = SqlMapConfig.getSqlSessionFactory();
    SqlSession sqlSession = factory.openSession();
    OrderMapper mapper = sqlSession.getMapper(OrderMapper.class);
    OrderDto order = mapper.selectOrderByNo(order_no);
    sqlSession.close();

    request.setAttribute("order", order);
%>

<html>
<head>
  <title>주문 수정</title>
  <link rel="stylesheet" href="../css/style.css">
</head>
<body>
<h2>주문 상태 수정</h2>

<form action="orderupdate_proc.jsp" method="post">
  <input type="hidden" name="order_no" value="${order.order_no}" />

  <p>고객명: ${order.user_name}</p>
  <p>상품명: ${order.productname}</p>
  <p>주문수량: ${order.orderquantity}</p>
  <p>총금액: ${order.totalprice}</p>

  <p>주문/취소:
    <select name="cancelednot">
      <option value="주문" ${order.cancelednot == '주문' ? 'selected' : ''}>주문</option>
      <option value="취소" ${order.cancelednot == '취소' ? 'selected' : ''}>취소</option>
    </select>
  </p>

  <input type="submit" value="수정 완료">
</form>
</body>
</html>