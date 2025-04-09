<%@page import="pack.product.ProductDto"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<jsp:useBean id="productManager" class="pack.product.ProductManager" />
<%
ArrayList<ProductDto> list = productManager.getProductWoman();
request.setAttribute("list", list); // list를 request에 저장하여 JSTL에서 접근 가능하도록 설정

%>
<%@ include file="../include/top.jsp" %>
<link href="../css/common2.css?v=2" rel="stylesheet" type="text/css">
<link href="../css/guest_product.css?v=2" rel="stylesheet" type="text/css">
<script type="text/javascript" src="../js/script.js"></script>


<div>
	<h2 class="section-title">&nbsp;여성</h2>
	<div class="product-grid">
		<c:forEach var="product" items="${list}">
			<div class="product-card">
			<a href="guest_productdetail.jsp?product_no=${product.product_no}">
				<img src="../upload/${product.imagelink}" alt="${product.productname}" style="width: 20vh;">
				<h3>${product.productname}</h3>
				<p class="price">${product.productprice}원</p>
			</a>
			</div>
		</c:forEach>
	</div>
</div>

<%@ include file="../include/bottom.jsp" %>