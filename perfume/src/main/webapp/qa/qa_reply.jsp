<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="pack.qa.QaDto" %>
<%@ include file="../include/top.jsp" %>
<link rel="stylesheet" href="../css/common2.css?v=mintclean">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">

<jsp:useBean id="qaDto" class="pack.qa.QaDto" scope="request" />

<%
  String no = request.getParameter("no");
%>

<div class="qa-container">
  <h2 class="qa-title"><i class="bi bi-reply"></i> 답변 작성</h2>

  <form method="post" action="qa_replyproc.jsp" class="qa-form">
    <input type="hidden" name="no" value="<%= no %>" />

    <div class="mb-4">
      <label for="replycontent" class="form-label">답변 내용</label>
      <textarea name="replycontent" id="replycontent" class="form-control" rows="6" required></textarea>
    </div>

    <div class="qa-button-group">
      <button type="submit" class="btn btn-dark"><i class="bi bi-send"></i> 등록</button>
      <button type="button" class="btn btn-outline-secondary" onclick="location.href='qa_detail.jsp?no=<%= no %>'">취소</button>
    </div>
  </form>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="../js/qa.js"></script>
<%@ include file="../include/bottom.jsp" %>
