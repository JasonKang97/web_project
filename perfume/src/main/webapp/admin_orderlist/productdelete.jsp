<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="productManager" class="pack.product.ProductManager"/>
<%
String product_no = request.getParameter("product_no");
boolean result = productManager.deleteProduct(product_no);

if(result){
%>
	<script>
		alert("정상적으로 처리되었습니다.");
		location.href="productmanager.jsp";
	</script>
<%
}else{
%>
	<script>
		alert("에러 발생\n관리자에게 문의하시기 바랍니다.");
		location.href="productmanager.jsp";
	</script>
<%
}
%>
