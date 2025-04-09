<%@ page contentType="text/html; charset=UTF-8" %>

<style>
  .footer {
    background-color: #f9f9f9;
    color: #444;
    padding: 40px 20px;
    font-size: 0.95em;
    width: 100%;
    border-top: 1px solid #e0e0e0;
    /* position 제거됨 */
  }

  .footer-inner {
    max-width: 1200px;
    margin: 0 auto;
    text-align: left;
    line-height: 1.8;
  }

  .footer-logo {
    font-weight: 600;
    font-size: 1.5em;
    margin-bottom: 10px;
    color: #222;
  }

  .footer-info p {
    margin: 5px 0;
  }

  /* sticky-footer-pusher 관련 요소 제거 가능 */
  .sticky-footer-pusher {
    height: 0;
  }

  html, body {
    margin: 0;
    padding: 0;
    min-height: 100vh;
    position: relative;
    box-sizing: border-box;
    /* padding-bottom 제거 가능 */
  }
</style>


<div class="footer">
  <div class="footer-inner">
    <div class="footer-logo">Acorn</div>
    <div class="footer-info">
      <p><strong>(주)에이콘이즈</strong> | 에이콘아카데미 강남 최영식, 서의환, 박수현, 강진석, 고천우</p>
      <p>팀장 : 최영식　사업자등록번호 : 123-45-67890　최애의 간식 : 버터칩, 하리보젤리　고객센터 : 01-234-1234</p>
      <p><strong>강남 본원</strong> : 서울특별시 강남구 테헤란로124 삼원타워 5층 501호</p>
      <p style="margin-top: 10px; color: #888;">
        COPYRIGHT(C) HBILAB. ALL RIGHTS RESERVED.
        <span style="float: right;">
          <a href="<%=request.getContextPath()%>/admin/admin_main.jsp" style="color: #666; text-decoration: none;">관리자 페이지</a>
        </span>
      </p>
    </div>
  </div>
</div>
