<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="container mt-5">
  <div class="row">
    <!-- 왼쪽 메뉴 -->
    <div class="col-md-3">
      <div class="list-group">
        <button class="list-group-item list-group-item-action active" onclick="mypage.showSection('infoSection')">내 정보</button>
        <button class="list-group-item list-group-item-action" onclick="mypage.showSection('updateSection')">회원정보 수정</button>
        <button class="list-group-item list-group-item-action" onclick="mypage.showSection('passwordSection')">비밀번호 변경</button>
        <button class="list-group-item list-group-item-action text-danger" onclick="mypage.showSection('deleteSection')">회원 탈퇴</button>
      </div>
    </div>

    <!-- 메인 콘텐츠 -->
    <div class="col-md-9">
      <!-- 내 정보 -->
      <div id="infoSection" class="card shadow-sm p-4">
        <h3 class="mb-4" style="color: #4CAF50;">마이페이지</h3>
        <div class="form-group mb-3">
          <label for="userName"><strong>이름:</strong></label>
          <span id="userName"></span>
        </div>
        <div class="form-group mb-3">
          <label for="userUsername"><strong>아이디:</strong></label>
          <span id="userUsername"></span>
        </div>
        <div class="form-group mb-3">
          <label for="userEmail"><strong>이메일:</strong></label>
          <span id="userEmail"></span>
        </div>
        <div class="form-group mb-3">
          <label for="userTel"><strong>전화번호:</strong></label>
          <span id="userTel"></span>
        </div>
        <div class="form-group mb-3">
          <label for="userZipcode"><strong>우편번호:</strong></label>
          <span id="userZipcode"></span>
        </div>
        <div class="form-group mb-3">
          <label for="userStreetAddr"><strong>주소:</strong></label>
          <span id="userStreetAddr"></span>
        </div>
        <div class="form-group mb-3">
          <label for="userDetailAddr1"><strong>상세주소:</strong></label>
          <span id="userDetailAddr1"></span>
        </div>
        <div class="form-group mb-3">
          <label for="userDetailAddr2"><strong>추가 상세주소:</strong></label>
          <span id="userDetailAddr2"></span>
        </div>
      </div>

      <!-- 회원 정보 수정 -->
      <div id="updateSection" class="card shadow-sm p-4 mt-4" style="display: none;">
        <h3 class="mb-4" style="color: #4CAF50;">회원정보 수정</h3>
        <form id="updateForm">
          <div class="form-group mb-3">
            <label for="updateName">이름</label>
            <input type="text" class="form-control" id="updateName" name="userName" required>
          </div>
          <div class="form-group mb-3">
            <label for="updateEmail">이메일</label>
            <input type="email" class="form-control" id="updateEmail" name="userEmail" required>
          </div>
          <div class="form-group mb-3">
            <label for="updateTel">전화번호</label>
            <input type="text" class="form-control" id="updateTel" name="userTel" required>
          </div>
          <div class="form-group mb-3">
            <label for="updateZipcode">우편번호</label>
            <input type="text" class="form-control" id="updateZipcode" name="userZipcode">
          </div>
          <div class="form-group mb-3">
            <label for="updateStreetAddr">주소</label>
            <input type="text" class="form-control" id="updateStreetAddr" name="userStreetAddr">
          </div>
          <div class="form-group mb-3">
            <label for="updateDetailAddr1">상세주소</label>
            <input type="text" class="form-control" id="updateDetailAddr1" name="userDetailAddr1">
          </div>
          <div class="form-group mb-3">
            <label for="updateDetailAddr2">추가 상세주소</label>
            <input type="text" class="form-control" id="updateDetailAddr2" name="userDetailAddr2">
          </div>
          <button type="button" class="btn btn-success w-100 mt-3" onclick="mypage.updateUserInfo()">수정</button>
          <button type="button" class="btn btn-link w-100 mt-2" onclick="mypage.showSection('infoSection')">취소</button>
        </form>
      </div>

      <!-- 비밀번호 수정 -->
      <div id="passwordSection" class="card shadow-sm p-4 mt-4" style="display: none;">
        <h3 class="mb-4" style="color: #4CAF50;">비밀번호 변경</h3>
        <form id="passwordForm">
          <div class="form-group mb-3">
            <label for="newPassword">새 비밀번호</label>
            <input type="password" class="form-control" id="newPassword" required>
          </div>
          <div class="form-group mb-3">
            <label for="confirmPassword"> 비밀번호 재확인</label>
            <input type="password" class="form-control" id="confirmPassword" required>
          </div>
          <button type="button" class="btn btn-warning w-100 mt-3" onclick="mypage.updatePassword()">비밀번호 변경</button>
          <button type="button" class="btn btn-link w-100 mt-2" onclick="mypage.showSection('infoSection')">취소</button>
        </form>
      </div>



      <!-- 회원 탈퇴 -->
      <div id="deleteSection" class="card shadow-sm p-4 mt-4" style="display: none;">
        <h3 class="mb-4 text-danger">회원 탈퇴</h3>
        <p class="text-center">정말로 회원 탈퇴를 진행하시겠습니까?</p>
        <button class="btn btn-danger w-100 mt-3" onclick="mypage.deleteAccount()">탈퇴하기</button>
        <button type="button" class="btn btn-link w-100 mt-2" onclick="mypage.showSection('infoSection')">취소</button>
      </div>
    </div>
  </div>
</div>

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
                  document.getElementById("userName").innerText = user.userName || "없음";
                  document.getElementById("userUsername").innerText = user.userUsername || "없음";
                  document.getElementById("userEmail").innerText = user.userEmail || "없음";
                  document.getElementById("userTel").innerText = user.userTel || "없음";
                  document.getElementById("userZipcode").innerText = user.userZipcode || "없음";
                  document.getElementById("userStreetAddr").innerText = user.userStreetAddr || "없음";
                  document.getElementById("userDetailAddr1").innerText = user.userDetailAddr1 || "없음";
                  document.getElementById("userDetailAddr2").innerText = user.userDetailAddr2 || "없음";

                  document.getElementById("updateName").value = user.userName || "";
                  document.getElementById("updateEmail").value = user.userEmail || "";
                  document.getElementById("updateTel").value = user.userTel || "";
                  document.getElementById("updateZipcode").value = user.userZipcode || "";
                  document.getElementById("updateStreetAddr").value = user.userStreetAddr || "";
                  document.getElementById("updateDetailAddr1").value = user.userDetailAddr1 || "";
                  document.getElementById("updateDetailAddr2").value = user.userDetailAddr2 || "";
                }
              })
              .catch((err) => console.error("사용자 정보 로드 오류:", err));
    },

    updateUserInfo: function () {
      const userName = document.getElementById("updateName").value;
      const userEmail = document.getElementById("updateEmail").value;
      const userTel = document.getElementById("updateTel").value;
      const userZipcode = document.getElementById("updateZipcode").value;
      const userStreetAddr = document.getElementById("updateStreetAddr").value;
      const userDetailAddr1 = document.getElementById("updateDetailAddr1").value;
      const userDetailAddr2 = document.getElementById("updateDetailAddr2").value;

      fetch(`/api/users/update/${userId}`, {
        method: "PUT",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({
          userName,
          userEmail,
          userTel,
          userZipcode,
          userStreetAddr,
          userDetailAddr1,
          userDetailAddr2,
        }),
      })
              .then((response) => response.json())
              .then((data) => {
                if (data.status === 200) {
                  alert("회원정보가 수정되었습니다.");
                  location.reload(); // 페이지 새로고침
                } else {
                  alert("회원정보 수정에 실패했습니다.");
                }
              })
              .catch((err) => console.error("회원정보 수정 오류:", err));
    },

    updatePassword: function () {
      const newPassword = document.getElementById("newPassword").value;
      const confirmPassword = document.getElementById("confirmPassword").value;

      // 새로운 비밀번호와 재확인 비밀번호 일치 여부 확인
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
        headers: { "Content-Type": "text/plain" }, // JSON 대신 text/plain 설정
        body: newPassword, // JSON.stringify 제거
      })
              .then((response) => response.json())
              .then((data) => {
                if (data.status === 200) {
                  alert("비밀번호가 변경되었습니다. 다시 로그인해주세요.");
                  // 로그아웃 요청
                  fetch('/logout', { method: 'POST' })
                          .then(() => {
                            location.href = "/login/user"; // 로그인 페이지로 이동
                          })
                          .catch(err => console.error("로그아웃 오류:", err));
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
                    // 세션 종료 및 메인 페이지 이동
                    fetch('/logout', { method: 'POST' })
                            .then(() => {
                              location.href = "/"; // 메인 페이지로 리다이렉트
                            })
                            .catch(err => console.error("로그아웃 오류:", err));
                  } else {
                    alert("회원 탈퇴에 실패했습니다.");
                  }
                })
                .catch((err) => console.error("회원 탈퇴 오류:", err));
      }
    },


    showSection: function (sectionId) {
      document
              .querySelectorAll("#infoSection, #updateSection, #passwordSection, #deleteSection")
              .forEach((section) => (section.style.display = "none"));
      document.getElementById(sectionId).style.display = "block";
    },
  };

  document.addEventListener("DOMContentLoaded", function () {
    mypage.init();
  });
</script>