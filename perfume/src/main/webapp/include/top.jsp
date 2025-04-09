<%@ page contentType="text/html; charset=UTF-8" %>
<%
  String sessionUser = (String) session.getAttribute("customerKey");
  boolean isLoggedIn = (sessionUser != null);
%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>AromaDesk</title>

  <!-- Bootstrap + FontAwesome -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
  <% String ctx = request.getContextPath(); %>
  
  <link rel="stylesheet" href="<%=ctx %>/css/common.css">
</head>
<body>

<!-- ✅ 상단 고정 헤더 -->
<header class="sticky-top bg-white shadow-sm z-3">
  <div class="container-fluid d-flex align-items-center justify-content-between py-3 px-4">
    <div class="d-none d-lg-block" style="width: 180px;"></div>
    <div class="logo-area text-center flex-grow-1">
  		<a href="../od/odeur_main.jsp" class="text-decoration-none text-dark">AromaDesk</a>
	</div>

    <div class="d-flex align-items-center gap-4 header-icons">
      <i class="fa fa-search" onclick="toggleSearchBox()" title="검색"></i>

      <!-- 사람 아이콘 드롭다운 -->
      <div class="dropdown position-relative">
        <i class="fa fa-user" id="userDropdown" title="마이페이지"></i>
        <div class="dropdown-menu user-dropdown px-3 py-2">
          <% if (!isLoggedIn) { %>
          <!-- ❌ 로그인 X -->
          <div class="dropdown-header">로그인/회원가입</div>
          <ul class="list-unstyled small mb-0">
            <li><a class="dropdown-item ps-0" href="<%=ctx %>/customerlogin/login.jsp">- 로그인</a></li>
            <li><a class="dropdown-item ps-0" href="<%=ctx %>/customerlogin/register.jsp">- 회원가입</a></li>
            <li><a class="dropdown-item ps-0" href="<%=ctx %>/guestdelivery/mydelivery.jsp">- 주문목록/배송조회</a></li>
          </ul>
          <% } else { %>
          <!-- ✅ 로그인 O -->
          <div class="dropdown-header"><%= sessionUser %>님</div>
          <ul class="list-unstyled small mb-0">
            <li><a class="dropdown-item ps-0" href="<%=ctx %>/customerlogin/customer_personalD.jsp">- 마이페이지</a></li>
            <li><a class="dropdown-item ps-0" href="<%=ctx %>/guestdelivery/mydelivery.jsp">- 주문목록/배송조회</a></li>
            <li><a class="dropdown-item ps-0" href="<%=ctx %>/customerlogin/logout.jsp">- 로그아웃</a></li>
          </ul>
          <% } %>
        </div>
      </div>

      <!-- 장바구니 -->
      <a href="<%=ctx %>/guest/cartlist.jsp"><i class="fa fa-shopping-cart" title="장바구니"></i></a>
    </div>
  </div>

  <!-- 내비게이션 메뉴 -->
  <nav class="border-top">
    <ul class="nav justify-content-center gap-5 fw-semibold py-2 small">
      <li class="nav-item"><a class="nav-link" href="<%=ctx %>/guest_product/guest_productlistOBNew.jsp">신상품</a></li>
      <li class="nav-item"><a class="nav-link" href="<%=ctx %>/guest_product/guest_productlist.jsp">전체상품</a></li>
      <li class="nav-item dropdown">
        <a class="nav-link dropdown-toggle" href="#">추천순</a>
        <ul class="dropdown-menu text-center">
          <li><a class="dropdown-item" href="<%=ctx %>/guest_product/guest_productlistOBMan.jsp">남성</a></li>
          <li><a class="dropdown-item" href="<%=ctx %>/guest_product/guest_productlistOBWoman.jsp">여성</a></li>
        </ul>
      </li>
      <li class="nav-item dropdown">
        <a class="nav-link dropdown-toggle" href="#">향기순</a>
        <ul class="dropdown-menu text-center">
          <li><a class="dropdown-item" href="<%=ctx %>/guest_product/guest_productlistOBTop.jsp">Top</a></li>
          <li><a class="dropdown-item" href="<%=ctx %>/guest_product/guest_productlistOBMiddle.jsp">Middle</a></li>
          <li><a class="dropdown-item" href="<%=ctx %>/guest_product/guest_productlistOBBase.jsp">Base</a></li>
        </ul>
      </li>
      <li class="nav-item"><a class="nav-link" href="<%=ctx %>/qa/qa_list.jsp">Q&A</a></li>
    </ul>
  </nav>
</header>


<!-- 검색창 슬라이드 -->
<div id="slide-search" class="slide-search">
  <i class="fa fa-times close-btn" onclick="toggleSearchBox()"></i>
  <form method="post" action="<%=ctx %>/qa/qa_list.jsp" class="d-flex w-100 gap-2">
    <input type="hidden" name="searchType" value="title">
    <input type="text" name="searchWord" class="form-control" placeholder="검색어를 입력하세요" required />
    <button type="submit" class="btn btn-outline-dark"><i class="fa fa-search"></i></button>
  </form>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
  function toggleSearchBox() {
    const box = document.getElementById('slide-search');
    box.classList.toggle('active');
  }

  const userIcon = document.getElementById('userDropdown');
  const userMenu = document.querySelector('.user-dropdown');

  userIcon.addEventListener('mouseenter', () => {
    userMenu.classList.add('show');
  });
  userIcon.addEventListener('mouseleave', () => {
    setTimeout(() => {
      if (!userMenu.matches(':hover')) userMenu.classList.remove('show');
    }, 200);
  });
  userMenu.addEventListener('mouseleave', () => userMenu.classList.remove('show'));
  userMenu.addEventListener('mouseenter', () => userMenu.classList.add('show'));

  document.querySelectorAll('.nav-item.dropdown').forEach((item) => {
    const menu = item.querySelector('.dropdown-menu');
    item.addEventListener('mouseenter', () => {
      menu.classList.add('show');
      menu.style.opacity = '1';
      menu.style.visibility = 'visible';
    });
    item.addEventListener('mouseleave', () => {
      menu.classList.remove('show');
      menu.style.opacity = '0';
      menu.style.visibility = 'hidden';
    });
  });
</script>
<script src="../js/qa.js"></script>
</body>
</html>
