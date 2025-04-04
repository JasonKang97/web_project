// 🔍 검색창 토글 열고 닫기
function toggleSearchBox() {
    const searchBox = document.getElementById("slide-search");
    if (searchBox.classList.contains("active")) {
        searchBox.classList.remove("active"); // 열려있으면 닫기
    } else {
        searchBox.classList.add("active"); // 닫혀있으면 열기
    }
}

// ✅ 로그인 처리 (login.jsp)
function funcLogin() {
    if (loginForm.id.value.trim() === "") {
        alert("회원 아이디를 입력하세요.");
        loginForm.id.focus();
    } else {
        loginForm.method = "post";
        loginForm.action = "login.jsp";
        loginForm.submit(); // 로그인 시도
    }
}

// ✅ 로그아웃 알림 후 이동
function logoutNow() {
    alert("로그아웃 되었습니다.");
    location.href = "qa_list.jsp"; // 목록 페이지로 이동
}

// ✅ 글쓰기에서 "취소" → 목록으로 이동
function cancelToListPage() {
    const cancelBtn = document.getElementById("cancelBtn");
    if (cancelBtn) {
        cancelBtn.onclick = function () {
            location.href = "qa_list.jsp";
        };
    }
}

// ✅ 수정 페이지에서 "취소" → 목록으로 이동
function cancelEditToList() {
    const cancelBtn = document.getElementById("editCancelBtn");
    if (cancelBtn) {
        cancelBtn.onclick = function () {
            location.href = "qa_list.jsp";
        };
    }
}

// ✅ 삭제 확인 → 확인 누르면 삭제 form 전송
function confirmDelete() {
    const confirmed = confirm("정말 삭제하시겠습니까?");
    if (confirmed) {
        document.forms["deleteForm"].submit(); // name="deleteForm"인 form 전송
    }
}

// ✅ 비밀번호 불일치 알림 (qa_deleteproc.jsp 등에서 호출)
function alertPasswordMismatch() {
    alert("비밀번호가 일치하지 않습니다.");
    history.back();
}

// ✅ 관리자 답글 작성 중 취소 시 → 상세보기 페이지로 이동
function replyCancel(no) {
    location.href = "qa_detail.jsp?no=" + no;
}

// ✅ 초기화: 취소 버튼 이벤트 바인딩 실행
window.onload = function () {
    cancelToListPage();     // 글쓰기 취소 버튼
    cancelEditToList();     // 수정 취소 버튼
};
