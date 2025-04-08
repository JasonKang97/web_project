<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="../include/top.jsp" %>

<!-- ✅ CSS 연결 -->
<link rel="stylesheet" href="../css/common2.css?v=mintclean">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">

<div class="qa-container">
  <h2 class="qa-title"><i class="bi bi-pencil-square"></i> 문의 작성</h2>

  <!-- ✅ 이미지 첨부 가능하도록 multipart/form-data 설정 -->
  <form method="post" action="${pageContext.request.contextPath}/qa/QaUploadServlet"
        enctype="multipart/form-data" class="qa-form">

    <!-- 작성자 -->
    <div class="mb-3">
      <label for="writer" class="form-label">작성자</label>
      <input type="text" class="form-control" name="writer" id="writer" required>
    </div>

    <!-- 제목 -->
    <div class="mb-3">
      <label for="title" class="form-label">제목</label>
      <input type="text" class="form-control" name="title" id="title" required>
    </div>

    <!-- 내용 -->
    <div class="mb-3">
      <label for="postcontent" class="form-label">내용</label>
      <textarea class="form-control" name="postcontent" id="postcontent" rows="6" required></textarea>
    </div>

    <!-- 이미지 첨부 -->
    <div class="mb-3">
      <label for="image" class="form-label">이미지 첨부</label>
      <input class="form-control" type="file" name="qaimagelink" id="image" accept="image/*">
    </div>

    <!-- 비밀글 -->
    <div class="form-check mb-3">
      <input class="form-check-input" type="checkbox" name="secretYN" id="secretYN" value="1">
      <label class="form-check-label" for="secretYN">비밀글로 작성</label>
    </div>

    <!-- 비밀번호 -->
    <div class="mb-4">
      <label for="postpassword" class="form-label">비밀번호</label>
      <input type="password" class="form-control" name="postpassword" id="postpassword" required>
    </div>

    <!-- 버튼 -->
    <div class="qa-button-group">
      <button type="submit" class="btn btn-dark"><i class="bi bi-send"></i> 등록</button>
      <button type="button" class="btn btn-outline-secondary" id="cancelBtn">취소</button>
    </div>
  </form>
</div>

<!-- ✅ JS 연결 -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="../js/qa.js"></script>
<%@ include file="../include/bottom.jsp" %>
