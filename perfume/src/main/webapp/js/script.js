function funcAdminLogin(){
	if(adminLoginForm.admin_id.value===""){
		alert("관리자 아이디를 입력하세요.");
		adminLoginForm.admin_id.focus();
		return;
	}
	else if(adminLoginForm.admin_pwd.value===""){
		alert("관리자 비밀번호를 입력하세요.");
		adminLoginForm.admin_pwd.focus();
		return;
	}
	adminLoginForm.submit();
}

function funcHome(){
	location.href="../guest/guest_index.jsp";
}

function productDetail(product_no){	// 관리자: 상품 처리
	document.detailFrm.product_no.value=product_no;
	document.detailFrm.submit();
}

function productUpdate(product_no){
	document.updateFrm.product_no.value = product_no;
	document.updateFrm.submit();
}

function productDelete(product_no){
	if(confirm("정말 삭제하시겠습니까?")){
	document.deleteFrm.product_no.value = product_no;
	document.deleteFrm.submit();
	}	
}

function productStock(product_no, productname){
	document.stockFrm.product_no.value = product_no;
	document.stockFrm.productname.value = productname;
	document.stockFrm.submit();
}