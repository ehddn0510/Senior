<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<div class="content-body">
    <div class="container-fluid">
        <div class="row">
            <!-- 계약 금액 -->
            <div class="col-lg-4 col-sm-6">
                <div class="card">
                    <div class="stat-widget-one card-body">
                        <div class="stat-icon d-inline-block">
                            <i class="ti-money text-success border-success"></i>
                        </div>
                        <div class="stat-content d-inline-block">
                            <div class="stat-text">계약 금액</div>
                            <div class="stat-digit">
                                ${fn:escapeXml(totalContractAmount)}[user_id=${user.userId}].total_contract_amount | 0} 원
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- 연결 시니어 명수 -->
            <div class="col-lg-4 col-sm-6">
                <div class="card">
                    <div class="stat-widget-one card-body">
                        <div class="stat-icon d-inline-block">
                            <i class="ti-user text-primary border-primary"></i>
                        </div>
                        <div class="stat-content d-inline-block">
                            <div class="stat-text">연결 시니어 명수</div>
                            <div class="stat-digit">
                                ${fn:escapeXml(seniorCount)}[user_id=${user.userId}].senior_count | 0} 명
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- 계약 유지 기간 -->
            <div class="col-lg-4 col-sm-6">
                <div class="card">
                    <div class="stat-widget-one card-body">
                        <div class="stat-icon d-inline-block">
                            <i class="ti-layout-grid2 text-pink border-pink"></i>
                        </div>
                        <div class="stat-content d-inline-block">
                            <div class="stat-text">계약 유지 기간</div>
                            <div class="stat-digit">
                                ${fn:escapeXml(contractRenewalCount)}[user_id=${user.userId}].renewal_count | 0} 회
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- 유저 프로필 헤더 -->
        <div class="profile">
            <div class="profile-head">
                <div class="photo-content">
                    <div class="cover-photo"></div>
                    <div class="profile-photo">
                        <img src="images/profile/${user.userProfile}" class="img-fluid rounded-circle" alt="프로필 이미지">
                    </div>
                </div>
                <div class="profile-info text-center mt-3">
                    <h4 class="text-primary">${user.userName}</h4>
                    <p class="mb-1">ID: ${user.userUsername}</p>
                    <p>Email: ${user.userEmail}</p>
                    <p>Phone: ${user.userTel}</p>
                </div>
            </div>
        </div>

        <!-- 유저 상세 정보 -->
        <div class="row mt-4">
            <div class="col-lg-8">
                <!-- 수정 가능한 폼 -->
                <div class="card mt-3">
                    <div class="card-body">
                        <h5 class="text-primary">Edit User Information</h5>
                        <form id="updateUserForm" action="<c:url value='/api/user/updateUser' />" method="post"
                              onsubmit="return validateForm()">
                            <input type="hidden" name="userId" value="${user.userId}"/>
                            <input type="hidden" name="userUsername" value="${user.userUsername}"/> <!-- 숨김 처리 -->

                            <div class="form-group">
                                <label for="userName">Name</label>
                                <input type="text" class="form-control" id="userName" name="userName"
                                       value="${user.userName}">
                            </div>
                            <div class="form-group">
                                <label for="userEmail">Email</label>
                                <input type="email" class="form-control" id="userEmail" name="userEmail"
                                       value="${user.userEmail}">
                            </div>
                            <div class="form-group">
                                <label for="userTel">Phone</label>
                                <input type="text" class="form-control" id="userTel" name="userTel"
                                       value="${user.userTel}">
                            </div>

                            <!-- 주소 입력 필드 및 우편번호 검색 버튼 -->
                            <div class="form-group">
                                <label for="userZipcode">Address</label>
                                <div class="d-flex align-items-center mb-2">
                                    <input type="text" class="form-control mr-2" id="userZipcode" name="userZipcode"
                                           placeholder="우편번호" value="${user.userZipcode}" readonly/>
                                    <a href="javascript:void(0);" onclick="popupZipSearch(); return false;"
                                       class="btn btn-primary px-4">우편번호 찾기</a>
                                </div>
                                <input type="text" class="form-control mb-2" id="userDetailAdd1" name="userDetailAdd1"
                                       placeholder="Street" value="${user.userStreetAddr}" readonly/>
                                <input type="text" class="form-control mb-2" id="userDetailAddr1" name="userDetailAddr1"
                                       placeholder="Apartment" value="${user.userDetailAddr1}">
                                <input type="text" class="form-control" id="userDetailAddr2" name="userDetailAddr2"
                                       placeholder="Building Name" value="${user.userDetailAddr2}" readonly>
                            </div>

                            <div class="form-group">
                                <label for="userStatus">Status</label>
                                <select class="form-control" id="userStatus" name="userStatus">
                                    <option value="Active" ${user.userStatus == 'Active' ? 'selected' : ''}>Active
                                    </option>
                                    <option value="Inactive" ${user.userStatus == 'Inactive' ? 'selected' : ''}>
                                        Inactive
                                    </option>
                                </select>
                            </div>

                            <button type="submit" class="btn btn-primary">Update</button>
                        </form>
                    </div>
                </div>
            </div>
            <div class="col-lg-4">
                <h5 class="text-primary">Senior List</h5>
                <c:forEach items="${senior}" var="senior">
                    <div class="card mb-3">
                        <div class="card-body text-center">
                            <h5 class="text-primary">${senior.seniorName}</h5>
                            <p class="mb-1">${senior.seniorGender == 'male' ? '남성' : '여성'}</p>
                            <p class="mb-1">
                                <fmt:formatDate value="${senior.seniorBirth}" pattern="yyyy년 MM월 dd일" />
                            </p>
                            <div class="mt-4 text-center">
                                <!-- Detail 버튼으로 수정하고 링크 연결 -->
                                <a href="<c:url value='/senior-detail?id=${senior.seniorId}' />" class="btn btn-primary btn-sm">Detail</a>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>
    </div>
</div>

<script>
    // 수정 요청을 AJAX로 처리
    document.getElementById("updateUserForm").addEventListener("submit", function(event) {
        event.preventDefault(); // 폼 기본 제출 동작 방지

        const formData = new FormData(this);

        fetch("<c:url value='/api/user/updateUser' />", {
            method: "POST",
            body: formData
        })
            .then(response => response.json())
            .then(data => {
                if (data.data === 1) {
                    alert("수정이 완료되었습니다."); // 성공 알림
                    window.location.href = window.location.href; // 현재 페이지 새로고침
                } else {
                    alert("수정에 실패했습니다."); // 실패 알림
                    window.location.href = window.location.href; // 현재 페이지 새로고침
                }
            })
            .catch(error => {
                alert("수정 요청 중 오류가 발생했습니다. 다시 시도해주세요.");
                console.error("Error:", error);
                window.location.href = window.location.href; // 현재 페이지 새로고침
            });
    });

    function popupZipSearch() {
        new daum.Postcode({
            oncomplete: function (data) {
                var fullAddr = ''; // 최종 주소 변수
                var extraAddr = ''; // 조합형 주소 변수

                if (data.userSelectedType === 'R') { // 도로명 주소
                    fullAddr = data.roadAddress;
                } else { // 지번 주소
                    fullAddr = data.jibunAddress;
                }

                // 도로명 주소에 추가 정보가 있을 경우
                if (data.userSelectedType === 'R') {
                    if (data.bname !== '') {
                        extraAddr += data.bname;
                    }
                    if (data.buildingName !== '') {
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    fullAddr += (extraAddr !== '' ? ' (' + extraAddr + ')' : '');
                }

                // 주소와 괄호 내용을 분리
                var mainAddr = fullAddr.replace(/\s*\([^)]*\)/, '').trim(); // 괄호 포함 내용을 제거한 주소
                var buildingNameMatch = fullAddr.match(/\(([^)]+)\)/); // () 안의 텍스트 추출

                // 우편번호와 주소 필드에 입력
                document.getElementById('userZipcode').value = data.zonecode;
                document.getElementById("userStreetAddr").value = mainAddr; // 괄호 제외 주소
                document.getElementById("userDetailAddr2").value = buildingNameMatch ? buildingNameMatch[1] : ""; // 괄호 안의 내용

                // 상세 주소 입력 필드로 포커스 이동
                document.getElementById("userDetailAddr1").focus();
            }
        }).open();
    }
</script>

