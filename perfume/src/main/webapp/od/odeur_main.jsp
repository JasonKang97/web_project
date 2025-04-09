<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>Odeur - 메인페이지</title>

  <!-- ✅ 공통 CSS -->
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/common.css">

  <!-- ✅ Bootstrap Carousel CDN -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

  <style>
    /* ✅ 슬라이드 높이 + 이미지 비율 유지 */
    .carousel-item img {
      height: 80vh;
      object-fit: cover;
      filter: brightness(80%); /* 살짝 어둡게 */
    }

    /* ✅ 텍스트 오버레이 */
    .carousel-caption {
      bottom: 20%;
    }

    .carousel-caption h2 {
      font-size: 3rem;
      font-weight: bold;
      color: #fff;
      text-shadow: 2px 2px 8px rgba(0, 0, 0, 0.6);
    }

    .carousel-caption p {
      font-size: 1.2rem;
      color: #eee;
      text-shadow: 1px 1px 5px rgba(0, 0, 0, 0.5);
    }

    /* ✅ 좌우 버튼 커스텀 */
    .carousel-control-prev-icon,
    .carousel-control-next-icon {
      background-color: rgba(0, 0, 0, 0.5);
      border-radius: 50%;
      background-size: 40px;
      padding: 20px;
    }
  </style>
</head>
<body>

<%@ include file="/include/top.jsp" %>

<!-- ✅ Bootstrap Carousel 시작 -->
<div id="mainCarousel" class="carousel slide" data-bs-ride="carousel">
  <div class="carousel-inner">

    <!-- ✅ 첫 번째 슬라이드: 향수 전체 보기 -->
    <div class="carousel-item active">
      <a href="${pageContext.request.contextPath}/guest_product/guest_productlistOBMan.jsp">
        <img src="${pageContext.request.contextPath}/img/main1.jpg" class="d-block w-100" alt="main1">
      </a>
      <div class="carousel-caption d-none d-md-block">
        <h2>향기로 기억되는 순간</h2>
        <p>ODEUR Premium Fragrance</p>
      </div>
    </div>

    <!-- ✅ 두 번째 슬라이드: 신상품 추천 -->
    <div class="carousel-item">
      <a href="${pageContext.request.contextPath}/guest_product/guest_productlistOBWoman.jsp">
        <img src="${pageContext.request.contextPath}/img/main2.jpg" class="d-block w-100" alt="main2">
      </a>
      <div class="carousel-caption d-none d-md-block">
        <h2>당신만의 향기를 찾아서</h2>
        <p>Elegant. Soft. Memorable.</p>
      </div>
    </div>

  </div>

  <!-- 좌우 버튼 -->
  <button class="carousel-control-prev" type="button" data-bs-target="#mainCarousel" data-bs-slide="prev">
    <span class="carousel-control-prev-icon"></span>
  </button>
  <button class="carousel-control-next" type="button" data-bs-target="#mainCarousel" data-bs-slide="next">
    <span class="carousel-control-next-icon"></span>
  </button>
</div>
<!-- ✅ Bootstrap Carousel 끝 -->

<%@ include file="/include/bottom.jsp" %>

</body>
</html>
