<%@ page
        pageEncoding="UTF-8"
%>
<%
    response.setHeader("Cache-Control", "no-store");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);

    String adminid = (String)session.getAttribute("adminKey"); // 페이지 마다 세션을 읽어들이는게 비효율적이므로 top 페이지에서 세션을 읽은 후 본문에서 include한다.

    if(adminid == null || adminid.isEmpty()){
        response.sendRedirect("adminlogin.jsp");
        return;
    }
%>
<nav class="navbar navbar-expand-lg navbar-light bg-light sticky-top">
    <div class="container-fluid"> <a class="navbar-brand" href="#"><i class="bi bi-box-seam"></i> 향수 판매 관리</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNavDropdown" aria-controls="navbarNavDropdown" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNavDropdown">
            <ul class="navbar-nav ml-auto">
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="#" id="navbarDropdownMenuLink" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                        <%=adminid%> 님
                    </a>
                    <ul class="dropdown-menu dropdown-menu-right" aria-labelledby="navbarDropdownMenuLink">
                        <li><hr class="dropdown-divider"></li>
                        <li><a class="dropdown-item" href="adminlogout.jsp">로그아웃</a></li>
                    </ul>
                </li>
            </ul>
        </div>
    </div>
</nav>