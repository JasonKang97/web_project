<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="../include/top.jsp" %>
<link rel="stylesheet" href="../css/common2.css">

<%
    String no = request.getParameter("no"); // 게시글 번호
    String mode = request.getParameter("mode"); // 동작 모드 (edit or delete)
    String action = "qa_detail.jsp";
    if ("edit".equals(mode)) action = "qa_edit.jsp";
    else if ("delete".equals(mode)) action = "qa_delete.jsp";
%>

<div class="page-container">
    <h2>비밀번호 확인</h2>

    <!-- ✅ form 전송 시 자바스크립트 함수로 체크 -->
    <form method="post" action="<%=action%>" class="qa-form" onsubmit="return checkPassword()">
        <input type="hidden" name="no" value="<%=no%>">

        <div class="qa-form-group">
            <label for="postpassword">비밀번호</label>
            <input type="password" id="postpassword" name="postpassword" required>
        </div>
        <br>
        <div class="qa-form-actions">
            <input type="submit" value="확인">
            <input type="button" onclick="history.back()" value="취소">
            <input type="button" onclick="location.href='qa_list.jsp'" value="목록보기">
        </div>
    </form>
</div>

<!-- ✅ JS 파일 연결 -->
<script src="../js/qa.js"></script>
<%@ include file="../include/bottom.jsp" %>
