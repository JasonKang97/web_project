<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="pack.qa.QaManager, pack.qa.QaDto" %>
<%@ include file="../include/top.jsp" %>
<link rel="stylesheet" href="../css/common2.css?v=mintclean">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">

<%
  request.setCharacterEncoding("UTF-8");
  String no = request.getParameter("no");
  String inputPw = request.getParameter("postpassword");
  String loginId = (String) session.getAttribute("id");

  QaManager mgr = new QaManager();
  QaDto dto = mgr.getData(no);

  boolean isAdmin = "admin".equals(loginId);
  boolean isWriter = dto.getWriter().equals(loginId);
%>

<%

%>

<div class="qa-container">
  <h2 class="qa-title"><i class="bi bi-chat-dots"></i> 문의 내용</h2>

  <div class="mb-4">
    <strong>작성자 :</strong>
    <%
      String writer = dto.getWriter();
      if (writer.length() == 1) out.print(writer);
      else if (writer.length() == 2) out.print(writer.charAt(0) + "*");
      else out.print(writer.charAt(0) + "*" + writer.charAt(writer.length() - 1));
    %><br>
    <strong>작성일 :</strong> <%= dto.getPostcreatedate() %><br>
    <strong>제목 :</strong> <%= dto.getTitle() %><br>
  </div>

  <div class="mb-4">
    <label class="form-label">내용</label>
    <div class="p-3 border rounded" style="background-color:#fffef7; min-height:150px;">
      <%= dto.getPostcontent() %>
    </div>

    <%-- ✅ 첨부 이미지가 있을 경우 표시 --%>
    <%
      String qaimagelink = dto.getQaimagelink();
      if (qaimagelink != null && !qaimagelink.trim().isEmpty()) {
    %>
    <div class="mt-3">
      <label class="form-label">첨부 이미지</label><br>
      <img src="../upload/<%= qaimagelink %>" width="400" class="img-thumbnail">
    </div>
    <% } %>
  </div>

  <% if (dto.getReplycontent() != null && !dto.getReplycontent().isEmpty()) { %>
  <div class="qa-reply-box mt-4 p-4 rounded">
    <div class="qa-reply-title mb-3">
      <i class="bi bi-chat-dots-fill text-primary me-2"></i> <strong>관리자 답변</strong>
    </div>

    <div class="qa-reply-content p-3 mb-3 bg-light-subtle border-start border-3 border-primary rounded">
      <pre class="m-0"><%= dto.getReplycontent() %></pre>
    </div>

    <div class="qa-reply-meta text-muted small">
      답변일 : <%= dto.getReplyday() %>
    </div>
  </div>
  <% } %>


  <div class="qa-button-group">
    <form method="post" action="qa_check.jsp">
      <input type="hidden" name="mode" value="edit">
      <input type="hidden" name="no" value="<%= dto.getPublish_no() %>">
      <button type="submit" class="btn btn-outline-success"><i class="bi bi-pencil"></i> 수정</button>
    </form>

    <form method="post" action="qa_check.jsp" name="deleteForm">
      <input type="hidden" name="mode" value="delete">
      <input type="hidden" name="no" value="<%= dto.getPublish_no() %>">
      <button type="button" class="btn btn-outline-danger" onclick="confirmDelete()"><i class="bi bi-trash"></i> 삭제</button>
    </form>

    <% if (isAdmin && !isWriter) { %>
    <form method="post" action="qa_reply.jsp">
      <input type="hidden" name="no" value="<%= dto.getPublish_no() %>">
      <button type="submit" class="btn btn-outline-primary"><i class="bi bi-reply"></i> 답글</button>
    </form>
    <% } %>

    <form method="post" action="qa_list.jsp">
      <button type="submit" class="btn btn-secondary">목록</button>
    </form>
  </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="../js/qa.js"></script>
<%@ include file="../include/bottom.jsp" %>
