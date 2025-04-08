<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%request.setCharacterEncoding("utf-8");%>
<jsp:useBean id="bean" class="pack.product.ProductFormBean"/>
<jsp:setProperty property="*" name="bean"/>
<jsp:useBean id="productManager" class="pack.product.ProductManager"/>

<%
boolean b = productManager.insertProduct(bean);

if(b){
%>
<script type="text/javascript">
	alert("상품이 등록되었습니다.");
	location.href="productmanager.jsp";
</script>
<% 	
}else{
	%>
<script type="text/javascript">
	alert("상품 등록이 정상적으로 이루어지지 않았습니다.\n다시 시도해 주시기 바랍니다.");
	history.back();
</script>	
<%
}
%>