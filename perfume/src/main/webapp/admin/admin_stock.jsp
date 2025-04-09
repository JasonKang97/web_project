<%@ page import="java.util.ArrayList" %>
<%@ page import="pack.stock.StockDto" %>
<%@ page
        contentType="text/html;charset=UTF-8"
        pageEncoding="UTF-8"
%>
<jsp:useBean id="stockManager" class="pack.stock.StockManager"/>

<%
    request.setCharacterEncoding("utf-8");
    String keyword = request.getParameter("keyword");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>재고 관리</title>
    <link rel="stylesheet" href="../css/style.css">
    <%--<style>
        body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; padding: 20px; }
        table { width: 100%; border-collapse: collapse; margin-top: 20px; }
        th, td { border: 1px solid #ccc; padding: 8px; text-align: center; }
        th { background-color: #f4f4f4; }
        h2 { margin-bottom: 10px; }
        .search-bar { margin-bottom: 10px; }
    </style>--%>
</head>
<body>
<h2>재고 관리</h2>

<div class="search-bar">
    <form method="get">
        <input type="text" name="keyword" placeholder="상품명 검색" />
        <input type="submit" value="검색" />
    </form>
</div>

<table>
    <tr>
        <th>재고 번호</th><th>상품 번호</th><th>상품명</th><th>수량</th><th>입고일</th><th>최근 수정일</th><th>재고 관리</th>
    </tr>
    <%
        ArrayList<StockDto> list;
        if(keyword == null || keyword.isEmpty()){
            list = stockManager.getStockAll();
        } else {
            list = stockManager.getStockPart(keyword);
        }
        if(list.isEmpty()){
    %>
    <tr><td colspan="6">등록된 상품이 없습니다.</td></tr>
    <%
    } else {
        for(StockDto dto : list){
    %>
    <tr>
        <td><%=dto.getStock_no()%></td>
        <td><%=dto.getProduct_no()%></td>
        <td><%=dto.getProduct_name()%></td>
        <td><%=dto.getProduct_quantity()%></td>
        <td><%=dto.getCreate_date().toString().substring(0,19)%></td>
        <td><%=dto.getLastmodified_date().toString().substring(0,19)%></td>
        <td><a href="admin_stock_update.jsp?Stock=<%=dto.getStock_no()%>">재고 수정</a></td>
    </tr>
    <%
            }
        }
    %>
</table>
</body>
</html>
