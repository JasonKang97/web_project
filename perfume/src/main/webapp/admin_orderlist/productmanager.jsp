<%@page import="pack.product.ProductDto"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="productManager" class="pack.product.ProductManager"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품관리</title>
<link href="../css/style.css?v=2" rel="stylesheet" type="text/css">
<script type="text/javascript" src="../js/script.js"></script>
</head>
<body>
<h2>상품관리</h2>
<div class="btn-container">
    <a href="productinsert.jsp" class="btn">상품 등록</a>
</div>
<table>
	<tr >
		<th>상품번호</th><th>상품명</th><th>브랜드</th><th>TOP</th><th>MIDDLE</th><th>BASE</th>
		<th>주 고객층</th><th>출시일</th><th>가격</th><th>상세보기</th>
	</tr>
	<%
	ArrayList<ProductDto> list = productManager.getProductAll();
	if(list.size()==0){
	%>
	<tr>
		<td colspan="6">등록된 상품이 없습니다.</td>
	</tr>
	<%
	} else{
		for(ProductDto p:list){
	%>
	<tr>
		<td><%=p.getProduct_no() %></td>
		<td><%=p.getProductname() %></td>
		<td><%=p.getProductbrand() %></td>
		<td><%=p.getTopnote() %></td>
		<td><%=p.getMiddlenote() %></td>
		<td><%=p.getBasenote() %></td>
		<td><%=p.getMajorcustomer() %></td>
		<td><%=p.getReleasedate() %></td>
		<td><%=p.getProductprice() %></td>
		<td>
			<a href="javascript:productDetail('<%=p.getProduct_no()%>')">보기</a>
		</td>
	</tr>
	<%
		}
	}
%>
</table>
<form action="productdetail.jsp" name="detailFrm" style="display: none;">
	<input type="hidden" name="product_no">
</form>
</body>
</html>