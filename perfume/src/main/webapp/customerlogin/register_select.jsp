<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>AromaDesk 회원가입</title>
</head>
<body>
<h2 style="text-align: center;"></h2>
  <table style="align-content: center;">
  <tr>
  	<td colspan="3"><h2 style="text-align: center;">Odeur 회원가입</h2></td>
  </tr>
    <tr>
      <td align="center">
        <img src="../images/이메일원형.png" alt="이메일로 가입" width="200" height="200" style="cursor:pointer;" onclick="goRegister('자체가입')"><br>
        자체 이메일 가입
      </td>
      <td style="width: 50px;"></td> <!-- 이미지 간격 -->
      <td align="center">
        <img src="../images/카카오원형.png" alt="카카오로 가입" width="200" height="200" style="cursor:pointer;" onclick="goRegister('kakao')"><br>
        카카오로 가입
      </td>
      <td style="width: 50px;"></td>
      <td align="center">
        <img src="../images/네이버원형.png" alt="네이버로 가입" width="200" height="200" style="cursor:pointer;" onclick="goRegister('naver')"><br>
        네이버로 가입
      </td>
    </tr>
  </table>

  <script>
    function goRegister(type) {
    	location.href = "register.jsp?membershiptype=" + type;
    }
  </script>
</body>
</html>
