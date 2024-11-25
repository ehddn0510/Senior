<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<body class="bg-light">
<div class="container mt-5">
  <div class="row" style="margin-bottom: 150px">
    <!-- 왼쪽 메뉴 -->
    <div class="col-3 mb-4">
      <div class="card">
        <div class="card-body">
          <nav class="nav flex-column nav-pills">
            <a class="nav-link active" href="#infoSection" data-bs-toggle="pill">
              <i class="bi bi-person-circle me-2"></i>내 정보
            </a>
            <a class="nav-link" href="#updateSection" data-bs-toggle="pill">
              <i class="bi bi-pencil-square me-2"></i>회원정보 수정
            </a>
            <a class="nav-link" href="#passwordSection" data-bs-toggle="pill">
              <i class="bi bi-key me-2"></i>비밀번호 변경
            </a>
            <a class="nav-link text-danger" href="#deleteSection" data-bs-toggle="pill">
              <i class="bi bi-person-x me-2"></i>회원 탈퇴
            </a>
          </nav>
        </div>
      </div>
    </div>

    <!-- 메인 콘텐츠 -->
    <div class="col-9">
      <div class="tab-content">
        <!-- 내 정보 -->
        <div id="infoSection" class="tab-pane fade show active">
          <div class="card">
            <div class="card-body">
              <h3 class="card-title mb-4" style="color: #4CAF50;">마이페이지</h3>
              <div class="row">
                <div class="col-6 mb-3">
                  <label class="form-label"><strong>이름:</strong></label>
                  <p id="userName" class="form-control-plaintext"></p>
                </div>
                <div class="col-6 mb-3">
                  <label class="form-label"><strong>아이디:</strong></label>
                  <p id="userUsername" class="form-control-plaintext"></p>
                </div>
                <div class="col-6 mb-3">
                  <label class="form-label"><strong>이메일:</strong></label>
                  <p id="userEmail" class="form-control-plaintext"></p>
                </div>
                <div class="col-6 mb-3">
                  <label class="form-label"><strong>전화번호:</strong></label>
                  <p id="userTel" class="form-control-plaintext"></p>
                </div>
                <div class="col-6 mb-3">
                  <label class="form-label"><strong>우편번호:</strong></label>
                  <p id="userZipcode" class="form-control-plaintext"></p>
                </div>
                <div class="col-6 mb-3">
                  <label class="form-label"><strong>주소:</strong></label>
                  <p id="userStreetAddr" class="form-control-plaintext"></p>
                </div>
                <div class="col-6 mb-3">
                  <label class="form-label"><strong>상세주소:</strong></label>
                  <p id="userDetailAddr1" class="form-control-plaintext"></p>
                </div>
                <div class="col-6 mb-3">
                  <label class="form-label"><strong>추가 상세주소:</strong></label>
                  <p id="userDetailAddr2" class="form-control-plaintext"></p>
                </div>
              </div>
            </div>
          </div>
        </div>

        <!-- 회원 정보 수정 -->
        <div id="updateSection" class="tab-pane fade">
          <div class="card">
            <div class="card-body">
              <h3 class="card-title mb-4" style="color: #4CAF50;">회원정보 수정</h3>
              <form id="updateForm">
                <div class="row">
                  <div class="col-6 mb-3">
                    <label for="updateName" class="form-label">이름</label>
                    <input type="text" class="form-control" id="updateName" name="userName"
                           required>
                  </div>
                  <div class="col-6 mb-3">
                    <label for="updateEmail" class="form-label">이메일</label>
                    <input type="email" class="form-control" id="updateEmail" name="userEmail"
                           required>
                  </div>
                  <div class="col-6 mb-3">
                    <label for="updateTel" class="form-label">전화번호</label>
                    <input type="text" class="form-control" id="updateTel" name="userTel"
                           required>
                  </div>
                  <div class="col-6 mb-3">
                    <label for="updateZipcode" class="form-label">우편번호</label>
                    <input type="text" class="form-control" id="updateZipcode"
                           name="userZipcode">
                  </div>
                  <div class="col-12 mb-3">
                    <label for="updateStreetAddr" class="form-label">주소</label>
                    <input type="text" class="form-control" id="updateStreetAddr"
                           name="userStreetAddr">
                  </div>
                  <div class="col-6 mb-3">
                    <label for="updateDetailAddr1" class="form-label">상세주소</label>
                    <input type="text" class="form-control" id="updateDetailAddr1"
                           name="userDetailAddr1">
                  </div>
                  <div class="col-6 mb-3">
                    <label for="updateDetailAddr2" class="form-label">추가 상세주소</label>
                    <input type="text" class="form-control" id="updateDetailAddr2"
                           name="userDetailAddr2">
                  </div>
                </div>
                <button type="button" class="btn btn-success w-100 mt-3"
                        onclick="mypage.updateUserInfo()">수정
                </button>
              </form>
            </div>
          </div>
        </div>

        <!-- 비밀번호 수정 -->
        <div id="passwordSection" class="tab-pane fade">
          <div class="card">
            <div class="card-body">
              <h3 class="card-title mb-4" style="color: #4CAF50;">비밀번호 변경</h3>
              <form id="passwordForm">
                <div class="mb-3">
                  <label for="newPassword" class="form-label">새 비밀번호</label>
                  <input type="password" class="form-control" id="newPassword" required>
                </div>
                <div class="mb-3">
                  <label for="confirmPassword" class="form-label">비밀번호 재확인</label>
                  <input type="password" class="form-control" id="confirmPassword" required>
                </div>
                <button type="button" class="btn btn-warning w-100 mt-3"
                        onclick="mypage.updatePassword()">비밀번호 변경
                </button>
              </form>
            </div>
          </div>
        </div>

        <!-- 회원 탈퇴 -->
        <div id="deleteSection" class="tab-pane fade">
          <div class="card">
            <div class="card-body">
              <h3 class="card-title mb-4 text-danger">회원 탈퇴</h3>
              <div class="alert alert-danger" role="alert">
                <i class="bi bi-exclamation-triangle-fill me-2"></i>
                주의: 회원 탈퇴 시 모든 정보가 삭제되며 복구할 수 없습니다.
              </div>
              <p class="text-center mb-4">정말로 회원 탈퇴를 진행하시겠습니까?</p>
              <button class="btn btn-danger w-100" onclick="mypage.deleteAccount()">탈퇴하기</button>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
  const userId = '${userId}';

  const mypage = {
    init: function () {
      this.loadUserInfo();
    },

    loadUserInfo: function () {
      fetch(`/api/users/${userId}`)
              .then((response) => {
                if (!response.ok) throw new Error("사용자 정보를 불러오는 데 실패했습니다.");
                return response.json();
              })
              .then((data) => {
                const user = data.data;
                if (user) {
                  this.updateUserInfoDisplay(user);
                  this.populateUpdateForm(user);
                }
              })
              .catch((err) => console.error("사용자 정보 로드 오류:", err));
    },

    updateUserInfoDisplay: function (user) {
      const fields = ['userName', 'userUsername', 'userEmail', 'userTel', 'userZipcode', 'userStreetAddr', 'userDetailAddr1', 'userDetailAddr2'];
      fields.forEach(field => {
        document.getElementById(field).textContent = user[field] || "없음";
      });
    },

    populateUpdateForm: function (user) {
      const fields = ['updateName', 'updateEmail', 'updateTel', 'updateZipcode', 'updateStreetAddr', 'updateDetailAddr1', 'updateDetailAddr2'];
      fields.forEach(field => {
        document.getElementById(field).value = user[field.replace('update', 'user')] || "";
      });
    },

    updateUserInfo: function () {
      const form = document.getElementById('updateForm');
      const formData = new FormData(form);
      const updatedInfo = Object.fromEntries(formData.entries());

      fetch(`/api/users/update/${userId}`, {
        method: "PUT",
        headers: {"Content-Type": "application/json"},
        body: JSON.stringify(updatedInfo),
      })
              .then((response) => response.json())
              .then((data) => {
                if (data.status === 200) {
                  alert("회원정보가 수정되었습니다.");
                  this.loadUserInfo();
                  bootstrap.Tab.getInstance(document.querySelector('a[href="#infoSection"]')).show();
                } else {
                  alert("회원정보 수정에 실패했습니다.");
                }
              })
              .catch((err) => console.error("회원정보 수정 오류:", err));
    },

    updatePassword: function () {
      const newPassword = document.getElementById("newPassword").value;
      const confirmPassword = document.getElementById("confirmPassword").value;

      if (!newPassword || !confirmPassword) {
        alert("비밀번호를 입력해주세요.");
        return;
      }

      if (newPassword !== confirmPassword) {
        alert("새 비밀번호와 재확인 비밀번호가 일치하지 않습니다.");
        return;
      }

      fetch(`/api/users/update/password/${userId}`, {
        method: "PUT",
        headers: {"Content-Type": "text/plain"},
        body: newPassword,
      })
              .then((response) => response.json())
              .then((data) => {
                if (data.status === 200) {
                  alert("비밀번호가 변경되었습니다. 다시 로그인해주세요.");
                  this.logout();
                } else {
                  alert("비밀번호 변경에 실패했습니다.");
                }
              })
              .catch((err) => console.error("비밀번호 변경 오류:", err));
    },

    deleteAccount: function () {
      if (confirm("정말로 회원 탈퇴를 진행하시겠습니까?")) {
        fetch(`/api/users/delete/${userId}`, {method: "DELETE"})
                .then((response) => response.json())
                .then((data) => {
                  if (data.status === 200) {
                    alert("회원 탈퇴가 완료되었습니다. 메인 페이지로 이동합니다.");
                    this.logout();
                  } else {
                    alert("회원 탈퇴에 실패했습니다.");
                  }
                })
                .catch((err) => console.error("회원 탈퇴 오류:", err));
      }
    },

    logout: function () {
      fetch('/logout', {method: 'POST'})
              .then(() => {
                window.location.href = "/login/user";
              })
              .catch(err => console.error("로그아웃 오류:", err));
    }
  };

  document.addEventListener("DOMContentLoaded", function () {
    mypage.init();
  });
</script>

</body>
</html>
