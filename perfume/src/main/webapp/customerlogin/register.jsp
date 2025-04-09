<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("utf-8");
String membershiptype = request.getParameter("membershiptype");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>AromaDesk 회원가입</title>
<script type="text/javascript" src="/js/jquery-1.11.3.min.js"></script>
<script src="../js/popup_2.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<link rel="stylesheet" type="text/css" href="../css/style.css">

<script>
window.onload = function() {
  const emailIdInput = document.getElementById("email_id");
  const emailDomainSelect = document.getElementById("email_domain");
  const customDomainInput = document.getElementById("custom_domain");
  const finalEmailInput = document.getElementById("final_email");
  const submitButton = document.getElementById("btnSubmit");

  function updateFullEmail() {
	  const id = document.getElementById("email_id").value.trim();
	  const domainSelect = document.getElementById("email_domain").value;
	  const customDomain = document.getElementById("custom_domain").value.trim();
	  const domain = (domainSelect === "custom") ? customDomain : domainSelect;

	  if (!id || !domain) {
	    document.getElementById("final_email").value = "";
	    return "";
	  }

	  const fullEmail = id + "@" + domain;
	  document.getElementById("final_email").value = fullEmail;
	  return fullEmail;
	}


  function handleDomainChange() {
    if (emailDomainSelect.value === "custom") {
      customDomainInput.style.display = "inline";
    } else {
      customDomainInput.style.display = "none";
    }
    updateFullEmail();
  }

  emailIdInput.addEventListener("input", updateFullEmail);
  emailDomainSelect.addEventListener("change", handleDomainChange);
  customDomainInput.addEventListener("input", updateFullEmail);

  submitButton.onclick = function(e) {
    const fullEmail = updateFullEmail().trim();

    if (!fullEmail || !fullEmail.includes("@")) {
      alert("이메일을 정확히 입력해주세요.");
      return;
    }

    const pw = document.querySelector("input[name='userpassword']").value;
    const repw = document.querySelector("input[name='repasswd']").value;

    if (pw !== repw) {
      alert("비밀번호가 일치하지 않습니다.");
      return;
    }
    
    const requiredFields = document.querySelectorAll("input[name], select[name]");
    for (let field of requiredFields) {
      if (field.type === "radio") continue; // 성별은 따로 체크할 거라서 건너뜀
      if (field.value.trim() === "") {
        alert("모든 항목을 입력해주세요.");
        field.focus();
        return;
      }
    }

    // 성별 체크
    const genderChecked = document.querySelectorAll('input[name="gender"]:checked').length > 0;
    if (!genderChecked) {
      alert("성별을 선택해주세요.");
      return;
    }

    document.regForm.submit();
  };

  function checkEmailDuplicate() {
    const fullEmail = updateFullEmail().trim();

    if (!fullEmail || !fullEmail.includes("@")) {
      alert("이메일 아이디와 도메인을 모두 입력해주세요.");
      return;
    }

    const xhr = new XMLHttpRequest();
    xhr.open("POST", "idcheck.jsp", true);
    xhr.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
    xhr.onreadystatechange = function () {
      if (xhr.readyState === 4 && xhr.status === 200) {
        const result = xhr.responseText.trim();
        alert(result);
        if (result.includes("이미")) {
          emailIdInput.value = "";
          emailIdInput.focus();
        } else {
          document.getElementById("passwd").focus();
        }
      }
    };
    xhr.send("email=" + encodeURIComponent(fullEmail));
  }

  document.getElementById("checkEmailDuplicate").addEventListener("click", checkEmailDuplicate);
};
</script>
</head>

<body>
<br>
<table>
<tr>
<td align="center">
<form name="regForm" method="post" action="registerproc.jsp">
<table border="1">
<tr align="center" style="background-color: #556677">
  <td colspan="2"><b style="color: #FFFFFF">회원 가입</b></td>
</tr>
<tr>
  <td width="20%" style="text-align: center;">아이디<br>[Email로 작성.]</td>
  <td>
    <input type="text" id="email_id" size="15" placeholder="이메일 아이디" class="input_id">
    @
    <span id="domainWrapper">
      <input type="text" id="custom_domain" style="display: none;" placeholder="ex) example.com">
      <select id="email_domain">
        <option value="">이메일 선택해주세요</option>
        <option value="naver.com">naver.com</option>
        <option value="gmail.com">gmail.com</option>
        <option value="kakao.com">kakao.com</option>
        <option value="custom">직접 작성</option>
      </select>
    </span>
    <input type="hidden" id="final_email" name="email">
    <input type="button" value="ID중복확인" id="checkEmailDuplicate">
  </td>
</tr>
<tr><td>패스워드</td><td><input type="password" name="userpassword" size="15" id="passwd"></td></tr>
<tr><td>패스워드 확인</td><td><input type="password" name="repasswd" size="15"></td></tr>
<tr><td>이름</td><td><input type="text" name="username" size="15"></td></tr>
<tr><td>전화번호</td><td><input type="text" name="phonenumber" size="20"></td></tr>
<tr><td>생년월일</td><td><input type="date" name="birthdate"></td></tr>
<tr><td>성별</td>
  <td>
    <label><input type="radio" name="gender" value="남"> 남자</label>
    <label><input type="radio" name="gender" value="여"> 여자</label>
  </td>
</tr>
<tr>
  <td>우편번호</td>
  <td>
    <input type="text" name="addrcode" size="7" id="sample6_postcode" class="postcode" readonly>
    <input type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기">
  </td>
</tr>
<tr>
  <td>주소</td>
  <td><input type="text" id="sample6_address" name="address" size="60" readonly></td>
</tr>
<tr>
  <td>상세주소</td>
  <td>
    <input type="text" id="sample6_detailAddress" name="detailaddress" size="60">
    <input type="hidden" id="sample6_extraAddress">
  </td>
</tr>
<tr>
  <td>가입경로</td>
  <td>
    <select name="membershiptype">
      <option value="0" <%= (membershiptype == null || membershiptype.equals("0")) ? "selected" : "" %>>선택하세요</option>
      <option value="자체가입" <%= "자체가입".equals(membershiptype) ? "selected" : "" %>>자체 이메일 가입</option>
      <option value="kakao" <%= "kakao".equals(membershiptype) ? "selected" : "" %>>카카오</option>
      <option value="naver" <%= "naver".equals(membershiptype) ? "selected" : "" %>>네이버</option>
    </select>
  </td>
</tr>
<tr>
  <td colspan="2" style="text-align: center;">
    <input type="button" value="회원가입" id="btnSubmit">
    <input type="reset" value="다시쓰기">
  </td>
</tr>
</table>
</form>
</td>
</tr>
</table>
</body>
</html>