<%@ page import="pack.cart.CartDto" %>
<%@ page import="java.util.ArrayList" %>
<%@ page pageEncoding="UTF-8" %>
<jsp:useBean id="cartManager" class="pack.cart.CartManager" scope="session"/>
<jsp:useBean id="stockManager" class="pack.stock.StockManager"/>

<%
    int user_no;
    System.out.println(session.getAttribute("user_no"));
    if(session.getAttribute("user_no") == null){
        user_no = 0;
    } else {
        user_no = (int)session.getAttribute("user_no");
    }
%>

<%@ include file="../include/top.jsp" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>고객:상품주문</title>
    <link rel="stylesheet" type="text/css" href="../css/common2.css">
</head>
<body>

<div class="page-container">
    <h2 class="section-title">장바구니</h2>

    <form action="orderproc.jsp" method="get">
        <table class="basic-table">
            <thead>
            <tr>
                <th>주문상품</th>
                <th>가격(소계)</th>
                <th>수량</th>
                <th>조회</th>
            </tr>
            </thead>
            <tbody>
            <%
                int totalPrice = 0;
                ArrayList<CartDto> list = cartManager.getCartsByCustomer(user_no);
                if(user_no == 0) {
            %>
            <tr>
                <td colspan="4" class="text-danger">로그인 후 이용 바랍니다.</td>
            </tr>
            <%
            } else if(list.isEmpty()) {
            %>
            <tr>
                <td colspan="4">주문 건수가 없습니다.</td>
            </tr>
            <%
            } else {
                for (CartDto dto : list) {
                    totalPrice += dto.getTotal_price();
            %>
            <tr>
                <td><%=dto.getProduct_name()%></td>
                <td><%=dto.getTotal_price()%></td>
                <td><%=dto.getQuantity()%></td>
                <td><button type="button" class="detail-button">상세보기</button></td>
            </tr>
            <%
                    }
                }
            %>
            <tr>
                <td colspan="4" class="text-end fw-bold">총 합계: <%=totalPrice%>원</td>
            </tr>
            </tbody>
        </table>

        <input type="hidden" name="user_no" value="<%=user_no%>">

        <div class="action-button-box">
            <button type="submit">결제하기</button>
        </div>
    </form>
</div>

</body>
</html>
<%@ include file="../include/bottom.jsp" %>
