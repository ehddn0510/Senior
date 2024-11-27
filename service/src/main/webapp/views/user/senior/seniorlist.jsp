<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="container mt-5">
  <h2 class="text-center mb-4">나의 시니어 리스트</h2>
  <div class="row">
    <c:forEach var="senior" items="${seniors}">
      <div class="col-md-4 mb-4">
        <div class="card h-100">
          <c:choose>
            <c:when test="${not empty senior.seniorProfile}">
              <img src="/imgs/senior/${senior.seniorProfile}" class="card-img-top" alt="${senior.seniorName}">
            </c:when>
            <c:otherwise>
              <img src="/static/images/default-profile.png" class="card-img-top" alt="Default Profile">
            </c:otherwise>
          </c:choose>

          <div class="card-body">
            <h5 class="card-title">${senior.seniorName}</h5>
            <p class="card-text">
              <strong>성별:</strong> ${senior.seniorGender}<br>
              <strong>연락처:</strong> ${senior.seniorTel}<br>
            </p>
            <a href="/seniors/${senior.seniorId}" class="btn btn-primary btn-sm">자세히 보기</a>
          </div>
        </div>
      </div>
    </c:forEach>
  </div>
</div>
