<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<jsp:useBean id="stockManager" class="pack.stock.StockManager" />
<jsp:useBean id="stockDto" class="pack.stock.StockDto"/>
<%
    request.setCharacterEncoding("utf-8");
    int stockNo = Integer.parseInt(request.getParameter("Stock"));
    stockDto = stockManager.getStockByNo(stockNo); // getStockByNo는 stock_no로 단건 조회하는 메서드
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>재고 수정</title>
    <%--<style>
        body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; padding: 20px; }
        form { max-width: 400px; margin: 0 auto; }
        label { display: block; margin-top: 10px; }
        input[type="text"], input[type="number"] { width: 100%; padding: 8px; margin-top: 5px; }
        input[type="submit"] { margin-top: 15px; padding: 10px 15px; }
    </style>--%>
    <link rel="stylesheet" href="../css/style.css">
</head>
<body>
<h2>재고 수정</h2>
<form action="admin_stock_update_proc.jsp" method="post">
    <input type="hidden" name="stock_no" value="<%= stockDto.getStock_no() %>" />

    <label>상품 번호</label>
    <input type="text" name="product_no" value="<%= stockDto.getProduct_no() %>" readonly />

    <label>상품명</label>
    <input type="text" name="product_name" value="<%= stockDto.getProduct_name() %>" readonly />

    <label>재고 수량</label>
    <input type="number" name="product_quantity" value="<%= stockDto.getProduct_quantity() %>" required min="0"/>

    <label>입고일</label>
    <input type="text" name="create_date" value="<%= stockDto.getCreate_date().toString().substring(0,19) %>" readonly />

    <label>최근 수정일</label>
    <input type="text" name="release_date" value="<%= stockDto.getLastmodified_date().toString().substring(0,19) %>" readonly />

    <input type="submit" value="수정 완료" />
</form>
</body>
</html>
