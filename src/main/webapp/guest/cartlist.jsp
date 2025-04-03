<%@ page import="pack.cart.CartDto" %>
<%@ page import="java.util.ArrayList" %>
<%@ page
        contentType="text/html;charset=UTF-8"
        pageEncoding="UTF-8"
%>
<jsp:useBean id="cartManager" class="pack.cart.CartManager" scope="session"/>
<jsp:useBean id="stockManager" class="pack.stock.StockManager"/>
<%
    session.setAttribute("customer_no", 1);
    int customer_no = (int)session.getAttribute("customer_no");
    System.out.println(customer_no);
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>고객:상품주문</title>
    <link rel="stylesheet" type="text/css" href="../css/style.css">
    <script type="text/javascript" src="../js/script.js"></script>
</head>
<body>
<h2>* 장바구니 목록 *</h2>
<%--<%@include file="guest_top.jsp"%>--%>
<table style="width: 95%;">
    <tr style="background-color: silver;">
        <th>주문상품</th><th>가격(소계)</th><th>수량</th><th>조회</th>
    </tr>
    <%
        int totalPrice = 0;
        ArrayList<CartDto> list = cartManager.getCartsByCustomer(customer_no);
        if(list.isEmpty()) {
    %>
    <tr>
        <td colspan="5">주문 건수가 없습니다.</td>
    </tr>
    <%
    } else {
        for (CartDto dto : list) {
//            System.out.println(dto.getUsername() + " " + dto.getProduct_name() + " " + dto.getQuantity() + " " + dto.getTotal_price());
            totalPrice += dto.getTotal_price();
    %>
    <tr>
        <td><%=dto.getProduct_name()%></td>
        <td><%=dto.getTotal_price()%></td>
        <td><%=dto.getQuantity()%></td>
        <td>상세보기</td>

    </tr>
    <%
        }
    }
    %>
    <tr>
        <td colspan="4">총 합 : <%=totalPrice%></td>
    </tr>
</table>
<%--<%@include file="guest_bottom.jsp"%>--%>
<form action="productdetail_g.jsp" name="detailFrm">
    <input type="hidden" name="no">
</form>
</body>
</html>