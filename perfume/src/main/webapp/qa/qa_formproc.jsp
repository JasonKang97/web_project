<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="pack.qa.QaBean" %>
<%@ page import="pack.qa.QaManager" %>
<jsp:useBean id="qaMgr" class="pack.qa.QaManager" />
<jsp:useBean id="bean" class="pack.qa.QaBean" />
<%
    request.setCharacterEncoding("UTF-8");

    // 📥 폼에서 전달된 데이터 수집
    bean.setWriter(request.getParameter("writer"));
    bean.setPostpassword(request.getParameter("postpassword"));
    bean.setTitle(request.getParameter("title"));
    bean.setPostcontent(request.getParameter("postcontent"));
    bean.setPostcreatedate(); // 현재 날짜 자동 생성
    bean.setSecretYN(request.getParameter("secretYN") == null ? 0 : 1); // 체크박스 값

    // 💾 DB 저장
    qaMgr.saveData(bean);

    // 📄 작성 후 목록으로 이동
    response.sendRedirect("qa_list.jsp");
%>
