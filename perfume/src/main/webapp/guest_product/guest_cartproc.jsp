<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="cartManager" class="pack.cart.CartManager"></jsp:useBean>
<%
request.setCharacterEncoding("utf-8");
int user_no = (int)session.getAttribute("user_no");
int product_no = Integer.parseInt(request.getParameter("product_no"));
int quantity = Integer.parseInt(request.getParameter("quantity"));
boolean b = cartManager.changeCart(user_no, product_no, quantity);

if(b){
%>
<script>
	alert("상품을 카트에 담았습니다.");
	location.href = "guest_productlist.jsp";
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