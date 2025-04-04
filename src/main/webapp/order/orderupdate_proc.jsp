<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="pack.order.OrderManager" %>
<%
    String order_no = request.getParameter("order_no");
    String canceled_not = request.getParameter("canceled_not");

    OrderManager manager = new OrderManager();
    boolean result = manager.updateOrderState(order_no, canceled_not);

    if (result) {
%>
    <script>alert('주문 상태가 수정되었습니다.'); location.href='ordermanager.jsp';</script>
<% } else { %>
    <script>alert('수정 실패'); history.back();</script>
<% } %>