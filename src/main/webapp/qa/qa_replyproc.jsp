<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="pack.qa.QaBean, pack.qa.QaManager" %>

<%
    request.setCharacterEncoding("UTF-8");

    String no = request.getParameter("no");
    String replycontent = request.getParameter("replycontent");
    String adminid = (String) session.getAttribute("id"); // 로그인된 관리자 ID

    // 날짜 포맷
    java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd");
    String replyday = sdf.format(new java.util.Date());

    QaBean bean = new QaBean();
    bean.setPublish_no(Integer.parseInt(no));
    bean.setReplycontent(replycontent);
    bean.setReplyday(replyday);
    bean.setAdminid(adminid);

    QaManager mgr = new QaManager();
    mgr.saveReplyOnly(bean);
%>

<script>
    alert("답글이 등록되었습니다.");
    location.href = "qa_detail.jsp?no=<%= no %>";
</script>
