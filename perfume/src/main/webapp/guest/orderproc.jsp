<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<jsp:useBean id="orderTxManager" class="pack.order.OrderTransactionManager" />

<%
    request.setCharacterEncoding("UTF-8");

    int user_no = Integer.parseInt(request.getParameter("user_no"));
    System.out.println(user_no);
    boolean success = orderTxManager.processOrderTransaction(user_no);
%>

<script>
    <% if (success && user_no != 0) { %>
    alert("주문이 정상적으로 처리되었습니다.");
    location.href = "../guestdelivery/mydelivery.jsp";
    <% } else { %>
    alert("주문 처리 중 문제가 발생했습니다. 다시 시도해주세요.");
    location.href = "cartlist.jsp";
    <% } %>
</script>
