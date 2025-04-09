<%@page import="pack.product.ProductDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
<form action="guest_cartproc.jsp">
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
				<tr>
					<td>수량</td><td><input type="number" min="1" value="1" name="quantity"></td>
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
			<input type="submit" value="카트에 담기">&nbsp;&nbsp;&nbsp;
			<input type="button" onclick="history.back()" value="돌아가기">
		</td>
	</tr>
</table>
<input type="hidden" name="product_no" value="<%=productDto.getProduct_no() %>">
</form>
</body>
</html>