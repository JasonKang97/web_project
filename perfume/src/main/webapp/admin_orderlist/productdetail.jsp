<%@page import="pack.product.ProductDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<jsp:useBean id="productManager" class="pack.product.ProductManager"/>

<%
String product_no = request.getParameter("product_no");

ProductDto productDto = productManager.getProduct(product_no);

%>
 

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품보기</title>
<link href="../css/style.css?v=2" rel="stylesheet" type="text/css">
<script type="text/javascript" src="../js/script.js"></script>
</head>
<body>
<h2>* 상품 상세보기 *</h2>
<table style="width:90%">
	<tr>
		<td style="width:20%">
		<img src="../upload/<%=productDto.getImagelink()%>" width="200"/>
		</td>
		<td style="width:50%; vertical-align: top">
			<table style="width:100%">
				<tr>
					<td>상품번호</td><td><%=productDto.getProduct_no() %></td>
				</tr>
				<tr>
					<td>상품명</td><td><%=productDto.getProductname() %></td>
				</tr>
				<tr>
					<td>브랜드</td><td><%=productDto.getProductbrand()%></td>
				</tr>
				<tr>
					<td>TOP</td><td><%=productDto.getTopnote() %></td>
				</tr>
				<tr>
					<td>MIDDLE</td><td><%=productDto.getMiddlenote() %></td>
				</tr>
				<tr>
					<td>BASE</td><td><%=productDto.getBasenote() %></td>
				</tr>
				<tr>
					<td>주 고객층</td><td><%=productDto.getMajorcustomer() %></td>
				</tr>
				<tr>
					<td>출시일</td><td><%=productDto.getReleasedate() %></td>
				</tr>
				<tr>
					<td>가격</td><td><%=productDto.getProductprice() %></td>
				</tr>

			</table>
		</td>
		<td style="width:30%; vertical-align: top;" >
			<b>* 상품 설명 *</b><br>
			<%=productDto.getOtherdescription() %>
		</td>
	</tr>
	<tr>
		<td colspan="3">
			<a href="javascript:productUpdate('<%=productDto.getProduct_no() %>')">수정하기</a>&nbsp;&nbsp;&nbsp;
			<a href="javascript:productDelete('<%=productDto.getProduct_no() %>')">삭제하기</a>&nbsp;&nbsp;&nbsp;
			<a href="javascript:productStock('<%=productDto.getProduct_no() %>', '<%=productDto.getProductname() %>')">재고등록</a>
		</td>
	</tr>
</table>


<!-- productproc로 바로 가는게 아니라 수정 화면을 띄워 정보 수정 후 정보 전달 -->
<form action="productupdate.jsp" name="updateFrm" method="post" style="display: none;">	
	<input type="hidden" name="product_no">
</form>

<form action="productdelete.jsp" name="deleteFrm" method="post" style="display: none;">
	<input type="hidden" name="product_no">
</form>
<form action="producstockproc.jsp" name="stockFrm" method="post" style="display: none;">
	<input type="hidden" name="product_no">
	<input type="hidden" name="productname">
</form>
</body>
</html>