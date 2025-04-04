<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:useBean id="stockManager" class="pack.stock.StockManager" />

<%
    request.setCharacterEncoding("UTF-8");

    int stockNo = Integer.parseInt(request.getParameter("stock_no"));
    int quantity = Integer.parseInt(request.getParameter("product_quantity"));

    boolean success = stockManager.updateStockQuantity(stockNo, quantity);

    if (success) {
%>
<script>
    alert("재고 수량이 성공적으로 수정되었습니다.");
    location.href = "admin_stock.jsp";
</script>
<%
} else {
%>
<script>
    alert("수정에 실패했습니다. 다시 시도해주세요.");
    history.back();
</script>
<%
    }
%>
