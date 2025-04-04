<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="pack.qa.QaManager, pack.qa.QaDto" %>
<%
    request.setCharacterEncoding("UTF-8");

    String no = request.getParameter("no");
    String inputPw = request.getParameter("postpassword");

    QaManager mgr = new QaManager();
    QaDto dto = mgr.getData(no);

    if (inputPw == null || !inputPw.equals(dto.getPostpassword())) {
%>
<!-- ✅ 비밀번호 틀렸을 때 JS로 알림 처리 -->
<script src="../js/qa.js"></script>
<script>
    alertPasswordMismatch(); // 🔽 qa.js에 정의된 함수 호출
</script>
<%
        return;
    }

    mgr.delData(no);
%>
<script>
    alert("게시글이 삭제되었습니다.");
    location.href = "qa_list.jsp";
</script>
