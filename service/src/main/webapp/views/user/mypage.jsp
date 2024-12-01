<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="mypage-container">
  <div class="profile-section">
    <!-- 왼쪽 사이드바 -->
    <div class="profile-sidebar">
      <div class="profile-info">
        <img alt="프로필 이미지" class="profile-image" id="profileImage">
        <h3 class="profile-name" id="profileName"></h3>
        <p class="profile-email" id="profileEmail"></p>
        <div class="profile-actions">
          <button class="btn btn-primary" onclick="mypage.showSection('updateSection')">
            <i class="fas fa-edit"></i> 프로필 수정
          </button>
        </div>
      </div>
      <ul class="menu-list">
        <li class="menu-item" onclick="mypage.showSection('infoSection')">
          <i class="fas fa-user"></i>
          <p>내 정보</p>
        </li>
        <li class="menu-item" onclick="mypage.showSection('updateSection')">
          <i class="fas fa-cog"></i>
          <p>회원정보 수정</p>
        </li>
        <li class="menu-item" onclick="mypage.showSection('passwordSection')">
          <i class="fas fa-lock"></i>
          <p>비밀번호 변경</p>
        </li>
        <li class="menu-item" onclick="mypage.showSection('deleteSection')">
          <i class="fas fa-user-times"></i>
          <p>회원 탈퇴</p>
        </li>
      </ul>
    </div>

    <!-- 오른쪽 컨텐츠 -->
    <div class="content-section">
      <!-- 내 정보 섹션 -->
      <div id="infoSection">
        <h2 class="section-title">내 정보</h2>
        <div class="info-grid">
          <div class="info-item">
            <div class="info-label">이름</div>
            <div class="info-value" id="userName"></div>
          </div>
          <div class="info-item">
            <div class="info-label">이메일</div>
            <div class="info-value" id="userEmail"></div>
          </div>
          <div class="info-item">
            <div class="info-label">전화번호</div>
            <div class="info-value" id="userTel"></div>
          </div>
          <div class="info-item">
            <div class="info-label">우편번호</div>
            <div class="info-value" id="userZipcode"></div>
          </div>
          <div class="info-item">
            <div class="info-label">주소</div>
            <div class="info-value" id="userStreetAddr"></div>
          </div>
          <div class="info-item">
            <div class="info-label">상세주소</div>
            <div class="info-value">
              <span id="userDetailAddr1"></span>
              <span id="userDetailAddr2"></span>
            </div>
          </div>
        </div>
      </div>

      <!-- 회원정보 수정 섹션 -->
      <div id="updateSection" style="display: none;">
        <h2 class="section-title">회원정보 수정</h2>
        <form id="updateForm">
          <div class="form-group">
            <label class="form-label">이름</label>
            <input type="text" class="form-control" id="updateName" name="userName" required>
          </div>
          <div class="form-group">
            <label class="form-label">이메일</label>
            <input type="email" class="form-control" id="updateEmail" name="userEmail" required>
          </div>
          <div class="form-group">
            <label class="form-label">전화번호</label>
            <input type="tel" class="form-control" id="updateTel" name="userTel" required>
          </div>
          <div class="form-group">
            <label class="form-label">우편번호</label>
            <input type="text" readonly class="form-control" id="updateZipcode" name="userZipcode">
          </div>
          <div class="form-group">
            <label class="form-label">주소</label>
            <input type="text" readonly class="form-control" id="updateStreetAddr" name="userStreetAddr">
          </div>
          <div class="form-group">
            <label class="form-label">상세주소</label>
            <input type="text" readonly class="form-control" id="updateDetailAddr1" name="userDetailAddr1">
          </div>
          <div class="form-group">
            <label class="form-label">추가 상세주소</label>
            <input type="text" class="form-control" id="updateDetailAddr2" name="userDetailAddr2">
          </div>
          <button type="button" class="btn btn-primary" onclick="mypage.updateUserInfo()">
            <i class="fas fa-check"></i> 수정하기
          </button>
        </form>
      </div>

      <!-- 비밀번호 변경 섹션 -->
      <div id="passwordSection" style="display: none;">
        <h2 class="section-title">비밀번호 변경</h2>
        <form id="passwordForm">
          <div class="form-group">
            <label class="form-label">새 비밀번호</label>
            <input type="password" class="form-control" id="newPassword" required>
          </div>
          <div class="form-group">
            <label class="form-label">비밀번호 재확인</label>
            <input type="password" class="form-control" id="confirmPassword" required>
          </div>
          <button type="button" class="btn btn-primary" onclick="mypage.updatePassword()">
            <i class="fas fa-key"></i> 비밀번호 변경
          </button>
        </form>
      </div>

      <!-- 회원 탈퇴 섹션 -->
      <div id="deleteSection" style="display: none;">
        <h2 class="section-title">회원 탈퇴</h2>
        <div class="alert-danger">
          <h4 class="alert-heading">
            <i class="fas fa-exclamation-triangle"></i> 주의!
          </h4>
          <p>회원 탈퇴 시 모든 정보가 삭제되며 복구할 수 없습니다.</p>
        </div>
        <p>정말로 회원 탈퇴를 진행하시겠습니까?</p>
        <button class="btn btn-danger" onclick="mypage.deleteAccount()">
          <i class="fas fa-user-times"></i> 탈퇴하기
        </button>
      </div>
    </div>
  </div>
</div>

<script>
  const userId = '${userId}';

  const mypage = {
    init: function() {
      this.loadUserInfo();
      this.showSection('infoSection');
    },

    loadUserInfo: function() {
      fetch(`/api/users/${userId}`)
              .then(response => {
                if (!response.ok) throw new Error("사용자 정보를 불러오는데 실패했습니다.");
                return response.json();
              })
              .then(data => {
                const user = data.data;
                if (user) {
                  this.updateUserInfoDisplay(user);
                  this.populateUpdateForm(user);
                  this.updateProfileDisplay(user);
                }
              })
              .catch(error => {
                console.error("사용자 정보 로드 오류:", error);
                alert("사용자 정보를 불러오는데 실패했습니다.");
              });
    },

    updateUserInfoDisplay: function(user) {
      document.getElementById("userName").textContent = user.userName || "없음";
      document.getElementById("userEmail").textContent = user.userEmail || "없음";
      document.getElementById("userTel").textContent = user.userTel || "없음";
      document.getElementById("userZipcode").textContent = user.userZipcode || "없음";
      document.getElementById("userStreetAddr").textContent = user.userStreetAddr || "없음";
      document.getElementById("userDetailAddr1").textContent = user.userDetailAddr1 || "없음";
      document.getElementById("userDetailAddr2").textContent = user.userDetailAddr2 || "없음";
    },

    updateProfileDisplay: function(user) {
      document.getElementById("profileImage").src = user.userProfile ? `/imgs/user/`+user.userProfile : "../images/default-profile.jpg";
      document.getElementById("profileName").textContent = user.userName || "이름 없음";
      document.getElementById("profileEmail").textContent = user.userEmail || "이메일 없음";

    },

    populateUpdateForm: function(user) {
      document.getElementById("updateName").value = user.userName || "";
      document.getElementById("updateEmail").value = user.userEmail || "";
      document.getElementById("updateTel").value = user.userTel || "";
      document.getElementById("updateZipcode").value = user.userZipcode || "";
      document.getElementById("updateStreetAddr").value = user.userStreetAddr || "";
      document.getElementById("updateDetailAddr1").value = user.userDetailAddr1 || "";
      document.getElementById("updateDetailAddr2").value = user.userDetailAddr2 || "";
    },

    updateUserInfo: function() {
      const formData = new FormData(document.getElementById("updateForm"));
      const updatedInfo = Object.fromEntries(formData.entries());

      fetch(`/api/users/update/${userId}`, {
        method: "PUT",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify(updatedInfo)
      })
              .then(response => response.json())
              .then(data => {
                if (data.status === 200) {
                  alert("회원정보가 성공적으로 수정되었습니다.");
                  this.loadUserInfo();
                  this.showSection('infoSection');
                } else {
                  throw new Error("회원정보 수정에 실패했습니다.");
                }
              })
              .catch(error => {
                console.error("회원정보 수정 오류:", error);
                alert("회원정보 수정에 실패했습니다.");
              });
    },

    updatePassword: function() {
      const newPassword = document.getElementById("newPassword").value;
      const confirmPassword = document.getElementById("confirmPassword").value;

      if (newPassword !== confirmPassword) {
        alert("새 비밀번호와 확인 비밀번호가 일치하지 않습니다.");
        return;
      }

      fetch(`/api/users/update/password/${userId}`, {
        method: "PUT",
        headers: { "Content-Type": "text/plain" },
        body: newPassword
      })
              .then(response => response.json())
              .then(data => {
                if (data.status === 200) {
                  alert("비밀번호가 성공적으로 변경되었습니다. 다시 로그인해주세요.");
                  this.logout();
                } else {
                  throw new Error("비밀번호 변경에 실패했습니다.");
                }
              })
              .catch(error => {
                console.error("비밀번호 변경 오류:", error);
                alert("비밀번호 변경에 실패했습니다.");
              });
    },

    deleteAccount: function() {
      if (confirm("정말로 회원 탈퇴를 진행하시겠습니까? 이 작업은 되돌릴 수 없습니다.")) {
        fetch(`/api/users/delete/${userId}`, { method: "DELETE" })
                .then(response => response.json())
                .then(data => {
                  if (data.status === 200) {
                    alert("회원 탈퇴가 완료되었습니다. 메인 페이지로 이동합니다.");
                    this.logout();
                  } else {
                    throw new Error("회원 탈퇴에 실패했습니다.");
                  }
                })
                .catch(error => {
                  console.error("회원 탈퇴 오류:", error);
                  alert("회원 탈퇴에 실패했습니다.");
                });
      }
    },

    logout: function() {
      fetch('/logout', { method: 'POST' })
              .then(() => {
                window.location.href = "/";
              })
              .catch(error => console.error("로그아웃 오류:", error));
    },

    showSection: function(sectionId) {
      const sections = ['infoSection', 'updateSection', 'passwordSection', 'deleteSection'];
      sections.forEach(section => {
        document.getElementById(section).style.display = section === sectionId ? 'block' : 'none';
      });
    }
  };

  document.addEventListener("DOMContentLoaded", function() {
    mypage.init();
  });
</script>
