<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="container mt-5">
    <h2 class="text-center mb-4">근처 보호사 리스트</h2>

    <!-- 시니어 선택 -->
    <div class="form-inline mb-4 d-flex align-items-center">
        <!-- 시니어 선택 -->
        <label for="senior-select" class="mr-2">내 시니어 선택:</label>
        <select id="senior-select" class="form-control mr-2">
            <c:forEach var="senior" items="${seniors}">
                <option value="${senior.seniorLatitude},${senior.seniorLongitude}">
                        ${senior.seniorName} (${senior.seniorStatus})
                </option>
            </c:forEach>
        </select>

        <!-- 반경 선택 -->
        <label for="radius-select" class="mr-2">반경:</label>
        <select id="radius-select" class="form-control mr-2">
            <option value="1">1 km</option>
            <option value="3">3 km</option>
            <option value="5" selected>5 km</option>
            <option value="10">10 km</option>
            <option value="20">20 km</option>
        </select>

        <!-- 검색 버튼 -->
        <button class="btn btn-primary" id="search-btn">보호사 검색</button>
    </div>

    <!-- 보호사 리스트 -->
    <div id="careworker-list" class="row"></div>
</div>

<script src="/js/careworker.js"></script>

