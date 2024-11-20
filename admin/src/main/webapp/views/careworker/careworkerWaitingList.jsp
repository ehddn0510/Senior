<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style>
    tbody tr td {
        color: black; /* 기본 글자 색상을 검정으로 설정 */
        font-size: 10px; /* 원하는 글자 크기로 조정 */
    }

    tbody tr:hover td {
        color: #3043c7; /* 마우스를 올렸을 때 글자 색상을 파란색으로 설정 */
    }
</style>
<!-- Add Bootstrap CSS -->
<!-- Add Bootstrap JavaScript -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"></script>
<div class="content-body">
    <div class="container-fluid">
        <h1>자격증 승인 신청한 보호사 리스트</h1>
        <div class="col-12">
            <div class="card">
                <div class="card-body">
                    <div class="row">
                        <c:forEach var="careworker" items="${careworkers}">
                            <div class="col-xl-4 col-xxl-6 col-lg-6 col-sm-6">
                                <div class="card text-center">
                                    <div class="card text-center border custom-border">
                                        <div class="card-header">
                                            <h4 class="card-title" style="color: #6C4FF0;">${careworker.cwName}</h4>
                                            <p style="color: #444444;">${careworker.cwEmail}</p>
                                            <p style="color: #444444;">${careworker.cwTel}</p>
                                        </div>
                                        <div class="card-body">
                                            <!-- 탭 메뉴 -->
                                            <ul class="nav nav-tabs card-body-tabs">
                                                <li class="nav-item">
                                                    <a class="nav-link active" data-bs-toggle="tab"
                                                       href="#licenses-${careworker.cwId}">자격증</a>
                                                </li>
                                                <li class="nav-item">
                                                    <a class="nav-link" data-bs-toggle="tab"
                                                       href="#details-${careworker.cwId}">추가 정보</a>
                                                </li>
                                            </ul>
                                            <!-- 탭 컨텐츠 -->
                                            <div class="tab-content mt-3">
                                                <!-- 자격증 탭 -->
                                                <div id="licenses-${careworker.cwId}" class="tab-pane fade show active">
                                                    <c:choose>
                                                        <c:when test="${not empty careworker.licenses}">
                                                            <c:forEach var="license" items="${careworker.licenses}">
                                                                <h4>${license.licenseName}</h4>
                                                                <p>(${license.licenseStartDate}
                                                                    ~ ${license.licenseEndDate})</p>
                                                            </c:forEach>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <p class="text-danger">자격 요건이 만족하지 않습니다.</p>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </div>
                                                <!-- 추가 정보 탭 -->
                                                <div id="details-${careworker.cwId}" class="tab-pane fade">
                                                    <p style="color: #444444;">
                                                        성별:
                                                        <c:choose>
                                                            <c:when test="${careworker.cwGender == 'M'}">남성</c:when>
                                                            <c:when test="${careworker.cwGender == 'F'}">여성</c:when>
                                                            <c:otherwise>알 수 없음</c:otherwise>
                                                        </c:choose>
                                                    </p>
                                                    <p style="color: #444444;">주소: ${careworker.cwStreetAddr} ${careworker.cwDetailAddr1}</p>
                                                    <p style="color: #444444;">경력: ${careworker.cwExperience}년</p>
                                                </div>
                                            </div>
                                            <a href="careworker-approval?id=${careworker.cwId}"
                                               class="btn btn-primary btn-card mt-3"
                                                    <c:if test="${empty careworker.licenses}">
                                                        disabled
                                                        style="background-color: #cccccc; color: #666666; border: none; cursor: not-allowed;"
                                                    </c:if>>
                                                <c:choose>
                                                    <c:when test="${not empty careworker.licenses}">
                                                        상세 보기
                                                    </c:when>
                                                    <c:otherwise>
                                                        승인 불가
                                                    </c:otherwise>
                                                </c:choose>
                                            </a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>


<!-- Required vendors -->
<script src="./vendor/global/global.min.js"></script>
<script src="./js/quixnav-init.js"></script>
<script src="./js/custom.min.js"></script>

<!-- Datatable -->
<script src="./vendor/datatables/js/jquery.dataTables.min.js"></script>
<script src="./js/plugins-init/datatables.init.js"></script>
