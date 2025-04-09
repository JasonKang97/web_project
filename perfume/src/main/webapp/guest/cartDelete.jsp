<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="cartManager" class="pack.cart.CartManager"/>
<%
int user_no = (int)session.getAttribute("user_no");

boolean flag = cartManager.deleteAll(user_no);
%>
<script>
    <% if (flag) { %>
        alert("장바구니가 비워졌습니다.");
        location.href = "cartlist.jsp";
    <% } else { %>
        alert("장바구니 비우기에 실패했습니다.");
        history.back();
    <% } %>
</script>