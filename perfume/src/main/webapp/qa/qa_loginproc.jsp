<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
    request.setCharacterEncoding("UTF-8");

    String id = request.getParameter("admin_id");
    String pw = request.getParameter("admin_passwd");

    // 아이디와 비밀번호 모두 정확할 때만 로그인 허용
    if ("admin".equals(id) && "1234".equals(pw)) {
        session.setAttribute("id", id); // 세션에 id 저장
        response.sendRedirect("qa_list.jsp"); // 로그인 성공 시 게시판 목록으로 이동
    } else {
%>
        <script>
            alert("아이디 또는 비밀번호가 틀렸습니다.");
            history.back();
        </script>
<%
    }
%>