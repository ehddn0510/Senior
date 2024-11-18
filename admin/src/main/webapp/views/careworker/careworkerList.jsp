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

<div class="content-body">
    <div class="container-fluid">
        <h1>현재 가용 가능한 보호사 리스트</h1>
        <div class="col-12">
            <div class="card">
                <div class="card-body">
                    <div class="table-responsive">
                        <table id="example" class="display" style="min-width: 845px">
                            <thead>
                            <tr>
                                <th>ID</th>
                                <th>Username</th>
                                <th>Name</th>
                                <th>Tel</th>
                                <th>Email</th>
                                <th>Gender</th>
                                <th>Status</th>
                                <th>Street Address</th>
                                <th>Detail Address</th>
                                <th>Experience</th>
                            </tr>
                            </thead>
                            <tbody>
                            <!-- 데이터 행들 -->
                            <c:forEach var="careworker" items="${user}">
                                <tr onclick="window.location.href='careworker-detail?id=${careworker.cwId}'" style="cursor: pointer;">
                                    <td>${careworker.cwId}</td>
                                    <td>${careworker.cwUsername}</td>
                                    <td>${careworker.cwName}</td>
                                    <td>${careworker.cwTel}</td>
                                    <td>${careworker.cwEmail}</td>
                                    <td>${careworker.cwGender}</td>
                                    <td>${careworker.cwStatus}</td>
                                    <td>${careworker.cwStreetAddr}</td>
                                    <td>${careworker.cwDetailAddr1}</td>
                                    <td>${careworker.cwExperience}</td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
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
