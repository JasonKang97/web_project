<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="pack.qa.QaBean" %>
<%@ page import="pack.qa.QaManager" %>
<jsp:useBean id="qaMgr" class="pack.qa.QaManager" />
<jsp:useBean id="bean" class="pack.qa.QaBean" />
<%
    request.setCharacterEncoding("UTF-8");

    // 🟡 수정할 게시글 정보 설정
    bean.setPublish_no(Integer.parseInt(request.getParameter("publish_no")));
    bean.setWriter(request.getParameter("writer"));
    bean.setPostpassword(request.getParameter("postpassword"));
    bean.setTitle(request.getParameter("title"));
    bean.setPostcontent(request.getParameter("postcontent"));
    bean.setPostcreatedate(); // 현재 날짜 세팅
    bean.setSecretYN(request.getParameter("secretYN") == null ? 0 : 1);

    // 🟢 DB에 업데이트 처리
    qaMgr.saveEdit(bean);

    // 🔁 수정 후 상세 페이지로 리다이렉트
    response.sendRedirect("qa_detail.jsp?no=" + bean.getPublish_no());
%>
