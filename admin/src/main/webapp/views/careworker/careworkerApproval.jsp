<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<div class="content-body">
    <div class="container-fluid">
        <h2>Careworker Approval</h2>
        <div class="row mt-4">
            <!-- 보호사 정보 (읽기 전용) -->
            <div class="col-lg-8">
                <div class="card">
                    <div class="card-body">
                        <h5 class="text-primary">Careworker Information</h5>
                        <p><strong>Name:</strong> ${user.cwName}</p>
                        <p><strong>Email:</strong> ${user.cwEmail}</p>
                        <p><strong>Phone:</strong> ${user.cwTel}</p>
                        <p><strong>Address:</strong> ${user.cwStreetAddr} ${user.cwDetailAddr1}, ${user.cwDetailAddr2}</p>
                        <p><strong>Experience:</strong> ${user.cwExperience} years</p>
                        <p><strong>Introduction:</strong> ${user.cwIntro}</p>
                    </div>
                </div>
            </div>

            <!-- 자격증 정보 (읽기 전용) -->
            <div class="col-lg-4">
                <h5 class="text-primary">Licenses</h5>
                <c:forEach items="${licenses}" var="license">
                    <div class="card mb-3">
                        <div class="card-body">
                            <h5 class="text-primary">${license.licenseName}</h5>
                            <p><strong>Start Date:</strong> ${license.licenseStartDate}</p>
                            <p><strong>End Date:</strong> ${license.licenseEndDate}</p>
                            <p><strong>Status:</strong> ${license.licenseStatus == 1 ? 'Valid' : 'Expired'}</p>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>

        <!-- 승인/보류 버튼 -->
        <div class="row mt-4">
            <div class="col-lg-12 text-center">
                <button onclick="approveCareworker('<c:url value="/api/careworker/approve?id=${user.cwId}"/>')" class="btn btn-success">승인</button>
                <button class="btn btn-warning mx-2" onclick="holdCareworker()">보류</button>
            </div>
        </div>
    </div>
</div>

<script>
    function approveCareworker(url, detailUrl, cwId) {
        if (confirm('보호사를 승인하시겠습니까?')) {
            fetch(url, {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
            })
                .then(response => response.json())
                .then(data => {
                    if (data.data === 1) {
                        alert("승인이 완료되었습니다.");
                        window.location.href = `/careworker-detail?id=${user.cwId}`; // 보호사 상세 페이지로 이동
                    } else {
                        alert("승인에 실패했습니다.");
                    }
                })
                .catch(error => {
                    alert("승인 요청 중 오류가 발생했습니다. 다시 시도해주세요.");
                    console.error("Error:", error);
                });
        }
    }



    // 보류 처리 함수
    function holdCareworker() {
        if (confirm('보호사 승인 요청을 보류하시겠습니까?')) {
            window.history.back(); // 이전 페이지로 돌아가기
        }
    }
</script>
