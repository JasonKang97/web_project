<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="pack.delivery.DeliveryBean" %>
<%@ page import="pack.delivery.DeliveryManager" %>

<jsp:useBean id="dbean" class="pack.delivery.DeliveryBean" />
<jsp:useBean id="deliveryManager" class="pack.delivery.DeliveryManager" />

<%
    String orderid = request.getParameter("ordernumber");
    if (orderid != null) {
        dbean = deliveryManager.getDeliveryInfo(Integer.parseInt(orderid));
        request.setAttribute("dbean", dbean);
    }
%>

<%
    if (dbean == null) {
%>
    <p>해당 배송 정보를 찾을 수 없습니다.</p>
    <p><a href="deliverymanager.jsp">← 돌아가기</a></p>
<%
    } else {
%>
<link rel="stylesheet" type="text/css" href="../css/style.css">
<h2>배송 상태 수정</h2>
<form method="post" action="deliveryupdate_proc.jsp">
    <input type="hidden" name="ordernumber" value="<%= dbean.getOrdernumber() %>" />
    <input type="hidden" name="prevStatus" id="prevStatus" value="<%= dbean.getDeliverystatus() %>" />
    <input type="hidden" name="shippingdate" id="shippingdate" value="" />

    <p>고객명: <%= dbean.getUsername() %></p>
    <p>상품명: <%= dbean.getProductname() %></p>
    <p>운송장번호: <%= dbean.getTrackingnumber() %></p>
    <p>배송주소: <%= dbean.getShpaddress() %> <%= dbean.getShpdetailaddress() %></p>

    <p>배송 상태:
        <select name="newStatus" id="newStatus" onchange="handleChange()">
            <option value="1" <%= dbean.getDeliverystatus() == 1 ? "selected" : "" %>>관리자 확인 전</option>
            <option value="2" <%= dbean.getDeliverystatus() == 2 ? "selected" : "" %>>상품 준비중</option>
            <option value="3" <%= dbean.getDeliverystatus() == 3 ? "selected" : "" %>>배송중</option>
            <option value="4" <%= dbean.getDeliverystatus() == 4 ? "selected" : "" %>>배송 완료</option>
        </select>
    </p>

    <input type="submit" value="변경 저장" />
</form>

<script>
    const prev = document.getElementById("prevStatus").value;

    function handleChange() {
        const sel = document.getElementById("newStatus");
        const newVal = sel.value;

        // 단계 하락 시 확인 팝업
        if (parseInt(newVal) < parseInt(prev)) {
            if (!confirm("정말 이전 단계로 변경하시겠습니까?")) {
                sel.value = prev;
                return;
            }
        }

        // 3번 배송중으로 변경 시 날짜 설정 (YYYY-MM-DD)
        if (parseInt(newVal) === 3 && parseInt(prev) !== 3) {
            const now = new Date();
            const dateOnly = now.toISOString().slice(0, 10); // 'YYYY-MM-DD'
            document.getElementById("shippingdate").value = dateOnly;
        } else {
            document.getElementById("shippingdate").value = "";
        }
    }
</script>

<%
    } // dbean != null
%>
