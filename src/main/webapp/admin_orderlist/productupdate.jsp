<%@page import="pack.product.ProductDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="productManager" class="pack.product.ProductManager"/>
<%
ProductDto dto = productManager.getProduct(request.getParameter("product_no"));
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 수정</title>
<link href="../css/style.css?v=2" rel="stylesheet" type="text/css">
<script type="text/javascript" src="../js/script.js"></script>
</head>
<body>
<h2>상품 수정</h2>
<form action="/perfume/product/update" method="post" enctype="multipart/form-data">
<table style="width:90%">
	<tr>
		<td>상품명</td>
		<td><input type="text" name="productname" value="<%=dto.getProductname()%>"></td>
	</tr>
	<tr>
		<td>브랜드</td>
		<td><input type="text" name="productbrand" value="<%=dto.getProductbrand()%>"></td>
	</tr>
	<tr>
		<td>TOP</td>
		<td><input type="text" name="topnote" value="<%=dto.getTopnote()%>"></td>
	</tr>
	<tr>
		<td>MIDDLE</td>
		<td><input type="text" name="middlenote" value="<%=dto.getMiddlenote()%>"></td>
	</tr>
	<tr>
		<td>BASE</td>
		<td><input type="text" name="basenote" value="<%=dto.getBasenote()%>"></td>
	</tr>
	<tr>
		<td>주 고객층</td>
		<td>
			<input type="radio" name="majorcustomer" value="남성" <%if("남성".equals(dto.getMajorcustomer()) || dto.getMajorcustomer()==null)%>checked="checked" <%;%>>남성
			<input type="radio" name="majorcustomer" value="여성" <%if("여성".equals(dto.getMajorcustomer()))%>checked="checked" <%;%>>여성
			<input type="radio" name="majorcustomer" value="남녀공통" <%if("남녀공통".equals(dto.getMajorcustomer()))%>checked="checked" <%;%>>남녀공통
		</td>
	</tr>
	<tr>
		<td>출시일</td>
		<td><input type="date" name="releasedate" value="<%=dto.getReleasedate()%>"></td>
	</tr>
	<tr>
		<td>가격</td>
		<td><input type="text" name="productprice" value="<%=dto.getProductprice()%>"></td>
	</tr>
	<tr>
		<td>기타사항</td>
		<td><textarea rows="5" style="width:98%" name="otherdescription"><%=dto.getOtherdescription()%></textarea></td>
	</tr>
	<tr>
		<td>사 진</td>
		<td>
			<img src="../upload/<%=dto.getImagelink()%>" style="width: 20%">
			<input type="file" name="image" size="30" accept="image/*">
			<input type="hidden" name="currentImage" value="<%=dto.getImagelink()%>">
		</td>
	</tr>
	<tr>
		<td colspan="2" style="text-align: center">
		<br>
		<input type="hidden" name="product_no" value="<%=dto.getProduct_no()%>">
		<input type="submit" value="상품 수정">
		<input type="reset" value="입력 초기화">
		<input type="button" value="수정 취소" onclick="history.back()" >
		</td>
	</tr>
</table>
</form>
</body>
</html>