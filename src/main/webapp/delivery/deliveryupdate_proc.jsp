<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="pack.delivery.DeliveryManager" %>

<jsp:useBean id="deliveryManager" class="pack.delivery.DeliveryManager" />

<%
    request.setCharacterEncoding("UTF-8");

    String ordernumberStr = request.getParameter("ordernumber");
    String newStatusStr = request.getParameter("newStatus");
    String shippingdate = request.getParameter("shippingdate");

    int ordernumber = 0;
    int newStatus = 0;

    boolean updateResult = false;

    try {
        ordernumber = Integer.parseInt(ordernumberStr);
        newStatus = Integer.parseInt(newStatusStr);

        // 배송상태가 3번(배송중)이고 날짜도 넘어온 경우만 날짜 포함 업데이트
        if (newStatus == 3 && shippingdate != null && !shippingdate.trim().equals("")) {
            updateResult = deliveryManager.updateStatus(ordernumber, newStatus, shippingdate);
        } else {
            updateResult = deliveryManager.updateStatus(ordernumber, newStatus, null);
        }

    } catch (Exception e) {
        System.out.println("처리 중 오류 발생: " + e.getMessage());
    }
%>

<script>
    alert("<%= updateResult ? "배송 상태가 성공적으로 변경되었습니다." : "배송 상태 변경에 실패했습니다." %>");
    location.href = "deliverymanager.jsp";
</script>
