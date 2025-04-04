<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="pack.order.*" %>
<%
    String order_no = request.getParameter("order_no");
    OrderManager manager = new OrderManager();
    OrderDto bean = manager.getOrder(order_no);
%>
<html>
<head><title>주문 상태 수정</title></head>
<body>
<h2>주문 상태 수정 - 주문번호: <%= bean.getOrder_no() %></h2>
<p>고객명: <%= bean.getUser_name() %></p>
<p>상품명: <%= bean.getProduct_name() %></p>
<p>총액: <%= bean.getTotal_price() %></p>
<form method="post" action="orderupdate_proc.jsp">
    <input type="hidden" name="order_no" value="<%= bean.getOrder_no() %>">
    <label>주문 상태:
        <select name="canceled_not">
            <option value="주문" <%= bean.getCanceled_not().equals("주문") ? "selected" : "" %>>주문</option>
            <option value="취소" <%= bean.getCanceled_not().equals("취소") ? "selected" : "" %>>취소</option>
        </select>
    </label>
    <input type="submit" value="수정"><!-- 사랑해 ㅋㅋ-->
</form>
</body>
</html>