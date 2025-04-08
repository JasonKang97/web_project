<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 추가</title>
<link href="../css/style.css?v=2" rel="stylesheet" type="text/css">
<script type="text/javascript" src="../js/script.js"></script>
</head>
<body>
<h2>상품 추가</h2>
<form action="/perfume/product/upload" method="post" enctype="multipart/form-data">
<table style="width:90%">
	<tr>
		<td>상품명</td>
		<td><input type="text" name="productname"></td>
	</tr>
	<tr>
		<td>브랜드</td>
		<td><input type="text" name="productbrand"></td>
	</tr>
	<tr>
		<td>TOP</td>
		<td><input type="text" name="topnote"></td>
	</tr>
	<tr>
		<td>MIDDLE</td>
		<td><input type="text" name="middlenote"></td>
	</tr>
	<tr>
		<td>BASE</td>
		<td><input type="text" name="basenote"></td>
	</tr>
	<tr>
		<td>주 고객층</td>
		<td>
			<input type="radio" name="majorcustomer" value="남성" checked="checked">남성
			<input type="radio" name="majorcustomer" value="여성">여성
			<input type="radio" name="majorcustomer" value="남녀공통">남녀공통
		</td>
	</tr>
	<tr>
		<td>출시일</td>
		<td><input type="date" name="releasedate"></td>
	</tr>
	<tr>
		<td>가격</td>
		<td><input type="text" name="productprice"></td>
	</tr>
	<tr>
		<td>기타사항</td>
		<td><textarea rows="5" style="width:98%" name="otherdescription"></textarea></td>
	</tr>
	<tr>
		<td>사 진</td>
		<td><input type="file" name="imagelink" size="30" accept="image/*"></td>
	</tr>
	<tr>
		<td colspan="2" style="text-align: center">
		<br>
		<input type="submit" value="상품 등록">&nbsp;&nbsp;&nbsp;
		<input type="reset" value="입력 초기화">
		</td>
	</tr>
</table>
</form>
</body>
</html>