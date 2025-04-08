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

<div class="qa-container">
    <h2>비밀번호 확인</h2>

    <!-- ✅ form 전송 시 자바스크립트 함수로 체크 -->
    <form method="post" action="<%=action%>" class="qa-form" onsubmit="return checkPassword()">
        <input type="hidden" name="no" value="<%=no%>">

        <div class="qa-form-group">
            <label for="postpassword">비밀번호</label>
            <input type="password" id="postpassword" name="postpassword" required>
        </div>

        <div class="qa-form-actions">
            <button type="submit">확인</button>
            <button type="button" onclick="history.back()">취소</button>
            <button type="button" onclick="location.href='qa_list.jsp'">목록보기</button>
        </div>
    </form>
</div>

<!-- ✅ JS 파일 연결 -->
<script src="../js/qa.js"></script>
<%@ include file="../include/bottom.jsp" %>
