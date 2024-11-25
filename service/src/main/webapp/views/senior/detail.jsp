<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="container mt-5">
  <h2 class="text-center">시니어 상세 정보</h2>
  <div class="row justify-content-center mt-4">
    <div class="col-md-8">
      <div class="card">
        <div class="card-body">
          <h4 class="card-title text-center">${senior.seniorName}</h4>
          <div class="text-center mb-4">
            <img src="/imgs/senior/${senior.seniorProfile}"
                 alt="시니어 프로필 이미지"
                 style="width: 200px; height: 200px; border-radius: 50%; object-fit: cover;">
          </div>
          <ul class="list-group list-group-flush">
            <li class="list-group-item">
              <strong>성별:</strong> <c:choose>
              <c:when test="${senior.seniorGender == 'M'}">남성</c:when>
              <c:otherwise>여성</c:otherwise>
            </c:choose>
            </li>
            <li class="list-group-item">
              <strong>전화번호:</strong> ${senior.seniorTel}
            </li>
            <li class="list-group-item">
              <strong>생년월일:</strong> ${senior.seniorBirth}
            </li>
            <li class="list-group-item">
              <strong>주소:</strong>
              ${senior.seniorStreetAddr} ${senior.seniorDetailAddr2}, ${senior.seniorDetailAddr1} (${senior.seniorZipcode})
            </li>
            <li class="list-group-item">
              <strong>중요 사항:</strong>
              <p>${senior.seniorSignificant != null ? senior.seniorSignificant : '특이사항 없음'}</p>
            </li>
            <li class="list-group-item">
              <strong>등록일:</strong> ${senior.seniorRdate}
            </li>
          </ul>
          <h5 class="mt-4">건강 정보</h5>
          <ul class="list-group">
            <c:forEach items="${healthinfo}" var="info">
              <li class="list-group-item">
                <strong>질병명:</strong> ${info.diseaseName}<br>
                <strong>설명:</strong> ${info.diseaseDescription}
              </li>
            </c:forEach>
            <c:if test="${healthinfo == null || healthinfo.isEmpty()}">
              <li class="list-group-item text-muted">등록된 건강 정보가 없습니다.</li>
            </c:if>
          </ul>
          <div class="text-center mt-4">
            <a href="/senior/update/${senior.seniorId}" class="btn btn-warning">수정</a>
            <a href="/senior/list" class="btn btn-secondary">목록으로</a>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>
