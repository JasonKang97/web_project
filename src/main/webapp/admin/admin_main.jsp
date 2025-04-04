<%@ page
        contentType="text/html;charset=UTF-8"
        pageEncoding="UTF-8"
%>
<%
    request.setCharacterEncoding("utf-8");
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <title>관리 페이지</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css"> <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
    <style>
        .navbar {
            background-color: #f8f9fa; /* Light gray background */
        }
        .navbar-brand {
            font-weight: bold;
        }
        .nav-link {
            padding: 0.75rem 1rem;
        }
        .sidebar {
            width: 280px;
            height: 100vh; /* 또는 flex-grow-0 */
            background-color: #343a40; /* Dark background for sidebar */
            color: white;
        }
        .sidebar a {
            color: white;
        }
        .sidebar a:hover {
            color: #f8f9fa;
        }
        .content-area {
            flex-grow: 1;
            height: 100vh;
        }
        .main-container {
            display: flex;
        }
    </style>
</head>
<body>
<%@include file="admin_top.jsp"%>
<div class="main-container">
    <div class="d-flex flex-column flex-shrink-0 p-3 sidebar">
        <a href="#" class="d-flex align-items-center mb-3 mb-md-0 me-md-auto text-white text-decoration-none">
            <span class="fs-4">관리 항목</span>
        </a>
        <hr>
        <ul class="nav nav-pills flex-column mb-auto">
            <li class="nav-item">
                <a href="admin_customer.jsp" class="nav-link text-white" aria-current="page" target="test">
                    <i class="bi bi-people me-2"></i> 고객관리
                </a>
            </li>
            <li class="nav-item">
                <a href="../admin_orderlist/productmanager.jsp" class="nav-link text-white" aria-current="page" target="test">
                    <i class="bi bi-box-seam-fill me-2"></i> 상품관리
                </a>
            </li>
            <li class="nav-item">
                <a href="admin_stock.jsp" class="nav-link text-white" target="test">
                    <i class="bi bi-box-seam me-2"></i> 재고관리
                </a>
            </li>
            <li class="nav-item">
                <a href="../order/ordermanager.jsp" class="nav-link text-white" target="test">
                    <i class="bi bi-cart me-2"></i> 주문관리
                </a>
            </li>
            <li class="nav-item">
                <a href="../delivery/deliverymanager.jsp" class="nav-link text-white" target="test">
                    <i class="bi bi-truck me-2"></i> 배송관리
                </a>
            </li>
        </ul>
    </div>
    <div class="content-area">
        <iframe src="" name="test" width="100%" height="100%" style="border: none;"></iframe>
    </div>
</div>
<%@include file="admin_bottom.jsp"%>
</body>
</html>