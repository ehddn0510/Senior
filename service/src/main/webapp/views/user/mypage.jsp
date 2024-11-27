<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="container py-5">
  <div class="row">
    <div class="col-lg-4">
      <!-- 프로필 카드 -->
      <div class="card mb-4">
        <div class="card-body text-center">
          <img src="https://via.placeholder.com/150" alt="avatar" class="rounded-circle img-fluid" style="width: 150px;">
          <h5 class="my-3" id="profileName"></h5>
          <p class="text-muted mb-1" id="profileUsername"></p>
          <p class="text-muted mb-4" id="profileEmail"></p>
          <div class="d-flex justify-content-center mb-2">
            <button type="button" class="btn btn-primary" onclick="mypage.showSection('updateSection')">프로필 수정</button>
            <button type="button" class="btn btn-outline-primary ms-1" onclick="mypage.showSection('passwordSection')">비밀번호 변경</button>
          </div>
        </div>
      </div>
      <!-- 메뉴 카드 -->
      <div class="card mb-4 mb-lg-0">
        <div class="card-body p-0">
          <ul class="list-group list-group-flush rounded-3">
            <li class="list-group-item d-flex justify-content-between align-items-center p-3" onclick="mypage.showSection('infoSection')">
              <i class="fas fa-user fa-lg text-warning"></i>
              <p class="mb-0">내 정보</p>
            </li>
            <li class="list-group-item d-flex justify-content-between align-items-center p-3" onclick="mypage.showSection('updateSection')">
              <i class="fas fa-cog fa-lg" style="color: #333333;"></i>
              <p class="mb-0">회원정보 수정</p>
            </li>
            <li class="list-group-item d-flex justify-content-between align-items-center p-3" onclick="mypage.showSection('passwordSection')">
              <i class="fas fa-lock fa-lg" style="color: #55acee;"></i>
              <p class="mb-0">비밀번호 변경</p>
            </li>
            <li class="list-group-item d-flex justify-content-between align-items-center p-3" onclick="mypage.showSection('deleteSection')">
              <i class="fas fa-user-times fa-lg" style="color: #ac2bac;"></i>
              <p class="mb-0">회원 탈퇴</p>
            </li>
          </ul>
        </div>
      </div>
    </div>
    <div class="col-lg-8">
      <!-- 내 정보 섹션 -->
      <div id="infoSection" class="card mb-4">
        <div class="card-body">
          <h2 class="h3 mb-4 text-primary">내 정보</h2>
          <div class="row">
            <div class="col-sm-3">
              <p class="mb-0">이름</p>
            </div>
            <div class="col-sm-9">
              <p class="text-muted mb-0" id="userName"></p>
            </div>
          </div>
          <hr>
          <div class="row">
            <div class="col-sm-3">
              <p class="mb-0">이메일</p>
            </div>
            <div class="col-sm-9">
              <p class="text-muted mb-0" id="userEmail"></p>
            </div>
          </div>
          <hr>
          <div class="row">
            <div class="col-sm-3">
              <p class="mb-0">전화번호</p>
            </div>
            <div class="col-sm-9">
              <p class="text-muted mb-0" id="userTel"></p>
            </div>
          </div>
          <hr>
          <div class="row">
            <div class="col-sm-3">
              <p class="mb-0">주소</p>
            </div>
            <div class="col-sm-9">
              <p class="text-muted mb-0">
                <span id="userZipcode"></span><br>
                <span id="userStreetAddr"></span><br>
                <span id="userDetailAddr1"></span>
                <span id="userDetailAddr2"></span>
              </p>
            </div>
          </div>
        </div>
      </div>
      <!-- 회원정보 수정 섹션 -->
      <div id="updateSection" class="card mb-4" style="display: none;">
        <div class="card-body">
          <h2 class="h3 mb-4 text-primary">회원정보 수정</h2>
          <form id="updateForm">
            <div class="mb-3">
              <label for="updateName" class="form-label">이름</label>
              <input type="text" class="form-control" id="updateName" name="userName" required>
            </div>
            <div class="mb-3">
              <label for="updateEmail" class="form-label">이메일</label>
              <input type="email" class="form-control" id="updateEmail" name="userEmail" required>
            </div>
            <div class="mb-3">
              <label for="updateTel" class="form-label">전화번호</label>
              <input type="tel" class="form-control" id="updateTel" name="userTel" required>
            </div>
            <div class="mb-3">
              <label for="updateZipcode" class="form-label">우편번호</label>
              <input type="text" class="form-control" id="updateZipcode" name="userZipcode">
            </div>
            <div class="mb-3">
              <label for="updateStreetAddr" class="form-label">주소</label>
              <input type="text" class="form-control" id="updateStreetAddr" name="userStreetAddr">
            </div>
            <div class="mb-3">
              <label for="updateDetailAddr1" class="form-label">상세주소</label>
              <input type="text" class="form-control" id="updateDetailAddr1" name="userDetailAddr1">
            </div>
            <div class="mb-3">
              <label for="updateDetailAddr2" class="form-label">추가 상세주소</label>
              <input type="text" class="form-control" id="updateDetailAddr2" name="userDetailAddr2">
            </div>
            <button type="button" class="btn btn-primary" onclick="mypage.updateUserInfo()">수정</button>
          </form>
        </div>
      </div>
      <!-- 비밀번호 변경 섹션 -->
      <div id="passwordSection" class="card mb-4" style="display: none;">
        <div class="card-body">
          <h2 class="h3 mb-4 text-primary">비밀번호 변경</h2>
          <form id="passwordForm">
            <div class="mb-3">
              <label for="newPassword" class="form-label">새 비밀번호</label>
              <input type="password" class="form-control" id="newPassword" required>
            </div>
            <div class="mb-3">
              <label for="confirmPassword" class="form-label">비밀번호 재확인</label>
              <input type="password" class="form-control" id="confirmPassword" required>
            </div>
            <button type="button" class="btn btn-primary" onclick="mypage.updatePassword()">비밀번호 변경</button>
          </form>
        </div>
      </div>
      <!-- 회원 탈퇴 섹션 -->
      <div id="deleteSection" class="card mb-4" style="display: none;">
        <div class="card-body">
          <h2 class="h3 mb-4 text-danger">회원 탈퇴</h2>
          <div class="alert alert-danger" role="alert">
            <h4 class="alert-heading">주의!</h4>
            <p>회원 탈퇴 시 모든 정보가 삭제되며 복구할 수 없습니다.</p>
          </div>
          <p class="mb-4">정말로 회원 탈퇴를 진행하시겠습니까?</p>
          <button class="btn btn-danger" onclick="mypage.deleteAccount()">탈퇴하기</button>
        </div>
      </div>
    </div>
  </div>
</div>

<script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/js/all.min.js"></script>
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

    updateUserInfoDisplay: function(user) {
      document.getElementById('profileName').textContent = user.userName;
      document.getElementById('profileUsername').textContent = user.userUsername;
      document.getElementById('profileEmail').textContent = user.userEmail;

      const fields = ['userName', 'userEmail', 'userTel', 'userZipcode', 'userStreetAddr', 'userDetailAddr1', 'userDetailAddr2'];
      fields.forEach(field => {
        const element = document.getElementById(field);
        if (element) {
          element.textContent = user[field] || "없음";
        }
      });
    },

    populateUpdateForm: function(user) {
      const fields = ['updateName', 'updateEmail', 'updateTel', 'updateZipcode', 'updateStreetAddr', 'updateDetailAddr1', 'updateDetailAddr2'];
      fields.forEach(field => {
        const element = document.getElementById(field);
        if (element) {
          element.value = user[field.replace('update', 'user')] || "";
        }
      });
    },

    updateUserInfo: function () {
      const form = document.getElementById('updateForm');
      const formData = new FormData(form);
      const updatedInfo = Object.fromEntries(formData.entries());

      fetch(`/api/users/update/${userId}`, {
        method: "PUT",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify(updatedInfo),
      })
              .then((response) => response.json())
              .then((data) => {
                if (data.status === 200) {
                  alert("회원정보가 수정되었습니다.");
                  this.loadUserInfo();
                  this.showSection('infoSection');
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
        headers: { "Content-Type": "text/plain" },
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
        fetch(`/api/users/delete/${userId}`, { method: "DELETE" })
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

    logout: function() {
      fetch('/logout', { method: 'POST' })
              .then(() => {
                window.location.href = "/login/user";
              })
              .catch(err => console.error("로그아웃 오류:", err));
    },

    showSection: function (sectionId) {
      const sections = ['infoSection', 'updateSection', 'passwordSection', 'deleteSection'];
      sections.forEach(section => {
        document.getElementById(section).style.display = section === sectionId ? 'block' : 'none';
      });
    }
  };

  document.addEventListener("DOMContentLoaded", function () {
    mypage.init();
  });
</script>