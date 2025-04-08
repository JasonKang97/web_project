<%@page import="pack.Login.CusLoginBean"%>
<%@page import="pack.Login.CustomerManager"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    request.setCharacterEncoding("utf-8");

    String email = request.getParameter("email");

    CusLoginBean bean = new CusLoginBean();
    bean.setUsername(request.getParameter("username"));
    bean.setUserpassword(request.getParameter("userpassword"));
    bean.setGender(request.getParameter("gender"));
    bean.setPhonenumber(request.getParameter("phonenumber"));
    bean.setAddress(request.getParameter("address"));
    bean.setDetailaddress(request.getParameter("detailaddress"));
    bean.setBirthdate(request.getParameter("birthdate"));
    bean.setMembershiptype(request.getParameter("membershiptype"));

    CustomerManager manager = new CustomerManager();
    boolean b = manager.customerUpdateByEmail(bean, email);

    if (b) {
        response.sendRedirect("customer_personalD.jsp");
    } else {
    	%>
        <script>
  	      alert("고객 정보 수정 실패");
      	  history.back();
        </script>
        <%
    }
%>
