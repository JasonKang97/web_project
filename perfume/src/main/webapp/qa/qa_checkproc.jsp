<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="pack.qa.QaManager" %>
<jsp:useBean id="qaMgr" class="pack.qa.QaManager" />
<%
    request.setCharacterEncoding("UTF-8");

    String loginId = (String) session.getAttribute("id"); // 세션에서 관리자 ID 가져오기
    boolean isAdmin = "admin".equals(loginId); // 관리자 여부 확인

    int no = Integer.parseInt(request.getParameter("no")); // 게시글 번호
    String inputPass = request.getParameter("postpassword"); // 입력된 비밀번호

    boolean check = qaMgr.checkPassword(no, inputPass); // 비밀번호 일치 여부 확인

    if (check || isAdmin) {
        response.sendRedirect("qa_detail.jsp?no=" + no); // 통과 시 상세 페이지로 이동
    } else {
%>
        <script>
            alert("비밀번호가 일치하지 않습니다.");
            history.back();
        </script>
<%
    }
%>
