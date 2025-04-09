<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:useBean id="stockManager" class="pack.stock.StockManager" />

<%
request.setCharacterEncoding("UTF-8");
int product_no = Integer.parseInt(request.getParameter("product_no"));
boolean success = stockManager.insertStock(product_no);
if (success) {
%>
<script>
	alert("재고가 등록되었습니다.");
	location.href = "../admin/admin_stock.jsp";
</script>
<%
} else {
%>
<script>
	alert("등록에 실패했습니다. 다시 시도해주세요.");
	history.back();
</script>
<%
}
%>
