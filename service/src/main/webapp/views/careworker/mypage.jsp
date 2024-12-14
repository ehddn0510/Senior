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
                <li class="menu-item" onclick="mypage.showSection('licenseSection')">
                    <i class="fas fa-file-alt"></i>
                    <p>자격증 관리</p>
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
                        <div class="info-value" id="cwName"></div>
                    </div>
                    <div class="info-item">
                        <div class="info-label">이메일</div>
                        <div class="info-value" id="cwEmail"></div>
                    </div>
                    <div class="info-item">
                        <div class="info-label">전화번호</div>
                        <div class="info-value" id="cwTel"></div>
                    </div>
                    <div class="info-item">
                        <div class="info-label">경력</div>
                        <div class="info-value" id="cwIntro"></div>
                    </div>
                    <div class="info-item">
                        <div class="info-label">우편번호</div>
                        <div class="info-value" id="cwZipcode"></div>
                    </div>
                    <div class="info-item">
                        <div class="info-label">주소</div>
                        <div class="info-value" id="cwStreetAddr"></div>
                    </div>
                    <div class="info-item">
                        <div class="info-label">상세주소</div>
                        <div class="info-value">
                            <span id="cwDetailAddr1"></span>
                            <span id="cwDetailAddr2"></span>
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
                        <input type="text" class="form-control" id="updateName" name="cwName" required>
                    </div>
                    <div class="form-group">
                        <label class="form-label">이메일</label>
                        <input type="email" class="form-control" id="updateEmail" name="cwEmail" required>
                    </div>
                    <div class="form-group">
                        <label class="form-label">전화번호</label>
                        <input type="tel" class="form-control" id="updateTel" name="cwTel" required>
                    </div>
                    <div class="form-group">
                        <label class="form-label">경력</label>
                        <input type="text" class="form-control" id="updateIntro" name="cwIntro" required>
                    </div>
                    <div class="form-group">
                        <label class="form-label">우편번호</label>
                        <input type="text" readonly class="form-control" id="updateZipcode" name="cwZipcode">
                    </div>
                    <div class="form-group">
                        <label class="form-label">주소</label>
                        <input type="text" readonly class="form-control" id="updateStreetAddr" name="cwStreetAddr">
                    </div>
                    <div class="form-group">
                        <label class="form-label">상세주소</label>
                        <input type="text" readonly class="form-control" id="updateDetailAddr1" name="cwDetailAddr1">
                    </div>
                    <div class="form-group">
                        <label class="form-label">추가 상세주소</label>
                        <input type="text" class="form-control" id="updateDetailAddr2" name="cwDetailAddr2">
                    </div>
                    <button type="button" class="btn btn-primary" onclick="mypage.updateCwInfo()">
                        <i class="fas fa-check"></i> 수정하기
                    </button>
                </form>
            </div>

            <div id="licenseSection" style="display: none;">
                <h2 class="section-title">자격증 관리</h2>

                <!-- 현재 자격증 목록 -->
                <div id="currentLicenses" style="
        background-color: #f9f9f9;
        border: 1px solid #ddd;
        padding: 20px;
        border-radius: 8px;
        margin-bottom: 20px;
        box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);">
                    <h3 style="margin-bottom: 15px;">현재 자격증</h3>
                    <table class="table">
                        <thead>
                        <tr>
                            <th>자격증 이름</th>
                            <th>시작 날짜</th>
                            <th>종료 날짜</th>
                            <th>상태</th>
                        </tr>
                        </thead>
                        <tbody id="licenseTableBody">
                        <!-- 자격증 목록이 동적으로 추가됩니다 -->
                        </tbody>
                    </table>
                </div>

                <!-- 구분선 -->
                <hr style="border: 0; border-top: 2px solid #eee; margin: 20px 0;">

                <!-- 자격증 추가 폼 -->
                <div id="addLicenseForm" style="
        background-color: #fff;
        border: 1px solid #ccc;
        padding: 20px;
        border-radius: 8px;
        box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);">
                    <h3 style="margin-bottom: 15px;">자격증 추가</h3>
                    <form id="licenseForm" class="license-form">
                        <div class="form-group">
                            <label for="licenseName">자격증 이름</label>
                            <input type="text" class="form-control" id="licenseName" name="licenseName" required>
                        </div>
                        <div class="form-group">
                            <label for="licenseStartDate">시작 날짜</label>
                            <input type="date" class="form-control" id="licenseStartDate" name="licenseStartDate"
                                   required>
                        </div>
                        <div class="form-group">
                            <label for="licenseEndDate">종료 날짜</label>
                            <input type="date" class="form-control" id="licenseEndDate" name="licenseEndDate" required>
                        </div>
                        <div class="form-group">
                            <label for="licenseStatus">상태</label>
                            <select class="form-control" id="licenseStatus" name="licenseStatus">
                                <option value="1">활성</option>
                                <option value="0">비활성</option>
                            </select>
                        </div>
                        <button type="button" class="btn btn-primary" onclick="mypage.addLicense()">
                            <i class="fas fa-plus"></i> 추가하기
                        </button>
                    </form>
                </div>
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
                    <i class="fas fa-cw-times"></i> 탈퇴하기
                </button>
            </div>
        </div>
    </div>
</div>

<script>
    const cwId = '${cwId}';
    const mypage = {
        init: function () {
            this.loadCwInfo();
            this.loadLicenses();
            this.showSection('infoSection');
        },

        loadCwInfo: function () {
            fetch(`/api/careworkers/${cwId}`)
                .then(response => {
                    if (!response.ok) throw new Error("사용자 정보를 불러오는데 실패했습니다.");
                    return response.json();
                })
                .then(data => {
                    const cw = data.data;
                    if (cw) {
                        this.updateCwInfoDisplay(cw);
                        this.populateUpdateForm(cw);
                        this.updateProfileDisplay(cw);
                    }
                })
                .catch(error => {
                    alert("사용자 정보를 불러오는데 실패했습니다.");
                    console.error("사용자 정보 로드 오류:", error);
                });

        },

        updateCwInfoDisplay: function (cw) {
            document.getElementById("cwName").textContent = cw.cwName || "없음";
            document.getElementById("cwEmail").textContent = cw.cwEmail || "없음";
            document.getElementById("cwTel").textContent = cw.cwTel || "없음";
            document.getElementById("cwIntro").textContent = cw.cwIntro || "없음";
            document.getElementById("cwZipcode").textContent = cw.cwZipcode || "없음";
            document.getElementById("cwStreetAddr").textContent = cw.cwStreetAddr || "없음";
            document.getElementById("cwDetailAddr1").textContent = cw.cwDetailAddr1 || "없음";
            document.getElementById("cwDetailAddr2").textContent = cw.cwDetailAddr2 || "없음";
        },

        updateProfileDisplay: function (cw) {
            document.getElementById("profileImage").src = cw.cwProfile ? `/imgs/careworker/` + cw.cwProfile : "../images/default-profile.jpg";
            document.getElementById("profileName").textContent = cw.cwName || "이름 없음";
            document.getElementById("profileEmail").textContent = cw.cwEmail || "이메일 없음";
        },

        populateUpdateForm: function (cw) {
            document.getElementById("updateName").value = cw.cwName || "";
            document.getElementById("updateEmail").value = cw.cwEmail || "";
            document.getElementById("updateTel").value = cw.cwTel || "";
            document.getElementById("updateIntro").value = cw.cwIntro || "";
            document.getElementById("updateZipcode").value = cw.cwZipcode || "";
            document.getElementById("updateStreetAddr").value = cw.cwStreetAddr || "";
            document.getElementById("updateDetailAddr1").value = cw.cwDetailAddr1 || "";
            document.getElementById("updateDetailAddr2").value = cw.cwDetailAddr2 || "";
        },

        updateCwInfo: function () {
            const formData = new FormData(document.getElementById("updateForm"));
            const updatedInfo = Object.fromEntries(formData.entries());

            fetch(`/api/careworkers/update/${cwId}`, {
                method: "PUT",
                headers: {"Content-Type": "application/json"},
                body: JSON.stringify(updatedInfo)
            })
                .then(response => {
                    if (!response.ok) throw new Error("회원정보 수정 실패");
                    return response.json();
                })
                .then(data => {
                    if (data.status === 200) {
                        alert("회원정보가 성공적으로 수정되었습니다.");
                        this.loadCwInfo(); // 정보 갱신
                        this.showSection("infoSection");
                    } else {
                        alert(`회원정보 수정 실패: ${data.data || "알 수 없는 오류"}`);
                    }
                })
                .catch(error => {
                    console.error("회원정보 수정 오류:", error);
                    alert("회원정보 수정 중 오류가 발생했습니다.");
                });
        },


        updatePassword: function () {
            const newPassword = document.getElementById("newPassword").value;
            const confirmPassword = document.getElementById("confirmPassword").value;

            if (newPassword !== confirmPassword) {
                alert("새 비밀번호와 확인 비밀번호가 일치하지 않습니다.");
                return;
            }

            fetch(`/api/careworkers/update/password/${cwId}`, {
                method: "PUT",
                headers: {"Content-Type": "text/plain"},
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

        deleteAccount: function () {
            if (confirm("정말로 회원 탈퇴를 진행하시겠습니까? 이 작업은 되돌릴 수 없습니다.")) {
                fetch(`/api/careworkers/delete/${cwId}`, {method: "DELETE"})
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

        addLicense: function () {
            const licenseForm = document.getElementById("licenseForm");
            const formData = new FormData(licenseForm);
            const licenseData = Object.fromEntries(formData.entries());

            // 시작 날짜와 종료 날짜에 시간 추가
            licenseData.licenseStartDate += "T00:00:00";
            licenseData.licenseEndDate += "T00:00:00";

            // 서버로 데이터 전송
            fetch(`/api/careworkers/${cwId}/licenses`, {
                method: "POST",
                headers: { "Content-Type": "application/json" },
                body: JSON.stringify(licenseData)
            })
                .then(response => {
                    if (!response.ok) throw new Error("자격증 추가 실패");
                    return response.json();
                })
                .then(data => {
                    if (data.status === 200) {
                        alert("자격증이 성공적으로 추가되었습니다.");
                        this.loadLicenses(); // 자격증 목록 갱신
                    } else {
                        alert(`자격증 추가 실패: ${data.data || "알 수 없는 오류"}`);
                    }
                })
                .catch(error => {
                    console.error("자격증 추가 오류:", error);
                    alert("자격증 추가 중 오류가 발생했습니다.");
                });
        },

        logout: function () {
            fetch('/logout', {method: 'POST'})
                .then(() => {
                    window.location.href = "/";
                })
                .catch(error => console.error("로그아웃 오류:", error));
        },

        loadLicenses: function () {
            fetch(`/api/careworkers/${cwId}/licenses`)
                .then(response => {
                    if (!response.ok) throw new Error("자격증 정보를 불러오는데 실패했습니다.");
                    return response.json();
                })
                .then(data => {
                    console.log("API 응답:", data);

                    const licenses = data.data || [];
                    console.log("파싱된 자격증 목록:", licenses);

                    const tbody = document.getElementById("licenseTableBody");
                    if (!tbody) {
                        console.error("licenseTableBody 요소를 찾을 수 없습니다.");
                        return;
                    }

                    tbody.innerHTML = ""; // 기존 내용을 초기화합니다.

                    if (licenses.length === 0) {
                        console.log("자격증 데이터가 비어 있습니다.");
                        tbody.innerHTML = `<tr><td colspan="4">등록된 자격증이 없습니다.</td></tr>`;
                        return;
                    }

                    licenses.forEach(license => {
                        const row = document.createElement("tr");

                        // 자격증 이름
                        const nameCell = document.createElement("td");
                        nameCell.textContent = license.licenseName || "없음";
                        row.appendChild(nameCell);

                        // 시작 날짜
                        const startDateCell = document.createElement("td");
                        startDateCell.textContent = license.licenseStartDate
                            ? formatDate(license.licenseStartDate)
                            : "없음";
                        row.appendChild(startDateCell);

                        // 종료 날짜
                        const endDateCell = document.createElement("td");
                        endDateCell.textContent = license.licenseEndDate
                            ? formatDate(license.licenseEndDate)
                            : "없음";
                        row.appendChild(endDateCell);

                        // 상태
                        const statusCell = document.createElement("td");
                        statusCell.textContent = license.licenseStatus === "1" ? "유효" : "유효 X";
                        row.appendChild(statusCell);

                        tbody.appendChild(row); // 테이블에 추가
                    });

                    function formatDate(dateString) {
                        const date = new Date(dateString);
                        const year = date.getFullYear();
                        const month = String(date.getMonth() + 1).padStart(2, "0");
                        const day = String(date.getDate()).padStart(2, "0");
                        return year + "년 " + month + "월 " + day + "일";
                    }

                    console.log("테이블 렌더링 완료.");
                })
                .catch(error => {
                    console.error("자격증 정보 로드 오류:", error);
                });
        },
        showSection: function (sectionId) {
            const sections = ['infoSection', 'updateSection', 'passwordSection', 'deleteSection', 'licenseSection'];
            sections.forEach(section => {
                document.getElementById(section).style.display = section === sectionId ? 'block' : 'none';
            });
        }
    };

    document.addEventListener("DOMContentLoaded", function () {
        mypage.init();
    });
</script>
