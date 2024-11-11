<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style>
    tbody tr td {
        color: black;
        font-size: 10px;
    }

    tbody tr:hover td {
        color: #3043c7;
    }
</style>

<div class="content-body">
    <div class="container-fluid">
        <h1>Senior List</h1>
        <div class="col-12">
            <div class="card">
                <div class="card-body">
                    <div class="table-responsive">
                        <table id="example" class="display" style="min-width: 845px">
                            <thead>
                            <tr>
                                <th>ID</th>
                                <th>Name</th>
                                <th>Gender</th>
                                <th>Tel</th>
                                <th>Birth</th>
                                <th>Zipcode</th>
                                <th>Street Address</th>
                                <th>Detail Address 1</th>
                                <th>Detail Address 2</th>
                                <th>Status</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach var="senior" items="${seniors}">
                                <tr onclick="window.location.href='senior-detail?id=${senior.seniorId}'" style="cursor: pointer;">
                                    <td>${senior.seniorId}</td>
                                    <td>${senior.seniorName}</td>
                                    <td>${senior.seniorGender}</td>
                                    <td>${senior.seniorTel}</td>
                                    <td>${senior.seniorBirth}</td>
                                    <td>${senior.seniorZipcode}</td>
                                    <td>${senior.seniorStreetAddr}</td>
                                    <td>${senior.seniorDetailAddr1}</td>
                                    <td>${senior.seniorDetailAddr2}</td>
                                    <td>${senior.seniorStatus}</td>
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
