<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%@ page import="org.apache.ibatis.session.SqlSession" %>
<%@ page import="org.apache.ibatis.session.SqlSessionFactory" %>
<%@ page import="pack.mybatis.SqlMapConfig" %>
<%@ page import="pack.mybatis.DeliveryMapper" %>
<%@ page import="pack.delivery.DeliveryBean" %>

<%
    int ordernumber = Integer.parseInt(request.getParameter("ordernumber"));
    SqlSessionFactory factory = SqlMapConfig.getSqlSessionFactory();
    SqlSession sqlSession = factory.openSession();
    DeliveryMapper mapper = sqlSession.getMapper(DeliveryMapper.class);
    DeliveryBean bean = mapper.selectOne(ordernumber);
    sqlSession.close();

    if (bean == null) {
        out.println("<script>alert('배송 정보를 찾을 수 없습니다.'); history.back();</script>");
        return;
    }

    request.setAttribute("delivery", bean);
%>

<html>
<head>
    <title>배송 상태 수정</title>
    <link rel="stylesheet" type="text/css" href="../css/style.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

    <script>
        let prevStatus;

        window.onload = () => {
            prevStatus = parseInt(document.getElementById("prevstatus").value);
        };

        function checkDeliveryStatusChange(e) {
            const newStatus = parseInt(document.getElementById("deliverystatus").value);
            if (newStatus < prevStatus) {
                const myModal = new bootstrap.Modal(document.getElementById('confirmModal'));
                myModal.show();
                return false;
            }
            return true;
        }

        function proceedSubmit() {
            document.getElementById("updateForm").submit();
        }
    </script>
</head>
<body class="container">
<h2 class="mt-4 mb-3">배송 상태 수정</h2>

<form id="updateForm" action="deliveryupdate_proc.jsp" method="post" onsubmit="return checkDeliveryStatusChange(event);">
    <input type="hidden" name="ordernumber" value="${delivery.order_no}" />
    <input type="hidden" id="prevstatus" name="prevstatus" value="${delivery.deliverystatus}" />

    <div class="mb-2">고객명: <strong>${delivery.username}</strong></div>
    <div class="mb-2">상품명: <strong>${delivery.productname}</strong></div>

    <div class="mb-2">배송시작일:
        <c:choose>
            <c:when test="${not empty delivery.shippingdate}">
                <fmt:formatDate value="${delivery.shippingdate}" pattern="yyyy-MM-dd"/>
            </c:when>
            <c:otherwise>-</c:otherwise>
        </c:choose>
    </div>

    <div class="mb-3">
        <label for="deliverystatus" class="form-label">배송 상태 변경:</label>
        <select class="form-select" id="deliverystatus" name="deliverystatus">
            <option value="0" ${delivery.deliverystatus == 0 ? 'selected' : ''}>주문 취소</option>
            <option value="1" ${delivery.deliverystatus == 1 ? 'selected' : ''}>관리자 확인 중</option>
            <option value="2" ${delivery.deliverystatus == 2 ? 'selected' : ''}>상품 준비중</option>
            <option value="3" ${delivery.deliverystatus == 3 ? 'selected' : ''}>배송중</option>
            <option value="4" ${delivery.deliverystatus == 4 ? 'selected' : ''}>배송완료</option>
        </select>
    </div>

    <button type="submit" class="btn btn-primary">수정 완료</button>
</form>

<!-- ✅ Bootstrap 확인용 모달 -->
<div class="modal fade" id="confirmModal" tabindex="-1" aria-labelledby="confirmModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title">상태 되돌림 확인</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="닫기"></button>
      </div>
      <div class="modal-body">
        현재 상태보다 낮은 단계로 변경하려고 합니다.<br>정말 진행하시겠습니까?
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
        <button type="button" class="btn btn-danger" onclick="proceedSubmit();">변경 계속</button>
      </div>
    </div>
  </div>
</div>

</body>
</html>
