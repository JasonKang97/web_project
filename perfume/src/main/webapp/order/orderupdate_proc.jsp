<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="org.apache.ibatis.session.SqlSession" %>
<%@ page import="org.apache.ibatis.session.SqlSessionFactory" %>
<%@ page import="pack.mybatis.SqlMapConfig" %>
<%@ page import="pack.mybatis.OrderMapper" %>
<%@ page import="pack.order.OrderDto" %>

<%
    request.setCharacterEncoding("UTF-8");

    int order_no = Integer.parseInt(request.getParameter("order_no"));
    String cancelednot = request.getParameter("cancelednot");

    OrderDto dto = new OrderDto();
    dto.setOrder_no(order_no);
    dto.setCancelednot(cancelednot);
  
    SqlSessionFactory factory = SqlMapConfig.getSqlSessionFactory();
    SqlSession sqlSession = factory.openSession();
    OrderMapper mapper = sqlSession.getMapper(OrderMapper.class);

    int result = mapper.updateCanceledNot(dto);
    sqlSession.commit();
    sqlSession.close();

    if (result > 0) {
%>
<script>
    alert("주문 상태가 수정되었습니다.");
    location.href = "ordermanager.jsp";
</script>
<%
    } else {
%>
<script>
    alert("수정에 실패했습니다.");
    history.back();
</script>
<%
    }
%>