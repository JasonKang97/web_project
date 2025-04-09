<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.Timestamp" %>
<%@ page import="org.apache.ibatis.session.SqlSession" %>
<%@ page import="pack.mybatis.SqlMapConfig" %>
<%@ page import="pack.mybatis.DeliveryMapper" %>
<%@ page import="pack.delivery.DeliveryBean" %>

<%
    request.setCharacterEncoding("UTF-8");

    int order_no = Integer.parseInt(request.getParameter("ordernumber"));
    int deliverystatus = Integer.parseInt(request.getParameter("deliverystatus"));

    SqlSession sqlSession = SqlMapConfig.getSqlSessionFactory().openSession();
    DeliveryMapper mapper = sqlSession.getMapper(DeliveryMapper.class);

    DeliveryBean bean = new DeliveryBean();
    bean.setOrder_no(order_no);
    bean.setDeliverystatus(deliverystatus);

    // 배송중이면 시작일 설정, 아닐 경우 null
    if (deliverystatus == 3) {
        bean.setShippingdate(new Timestamp(System.currentTimeMillis()));
    } else if (deliverystatus == 0 || deliverystatus == 1 || deliverystatus == 2) {
        bean.setShippingdate(null);
    }

    int result = mapper.updateStatus(bean);
    sqlSession.commit();
    sqlSession.close();

    if (result > 0) {
%>
<script>
    alert("배송 상태가 성공적으로 수정되었습니다.");
    location.href = "deliverymanager.jsp";
</script>
<%
    } else {
%>
<script>
    alert("배송 상태 수정에 실패했습니다.");
    history.back();
</script>
<%
    }
%>
