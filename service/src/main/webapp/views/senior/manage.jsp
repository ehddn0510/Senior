<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <style>
    .container {
      display: flex;
      flex-direction: row;
      justify-content: center; /* 가로 중앙 정렬 */
      align-items: center; /* 세로 중앙 정렬 */
      height: 70vh; /* 콘텐츠 영역 높이 */
      gap: 20px; /* 섹션 간 간격 */
    }
    .section {
      flex: 1;
      height: 50%; /* 높이를 50%로 설정 */
      max-width: 400px; /* 최대 너비 제한 */
      text-align: center;
      border: 2px solid #ddd;
      border-radius: 10px;
      background-color: #f9f9f9; /* 기본 배경색 */
      transition: background-color 0.3s, transform 0.3s; /* 부드러운 전환 효과 */
      cursor: pointer;
      display: flex;
      justify-content: center; /* 텍스트 가로 정렬 */
      align-items: center; /* 텍스트 세로 정렬 */
    }
    .section:hover {
      background-color: #d4edda; /* 초록색 하이라이트 */
      transform: scale(1.05); /* 확대 효과 */
    }
    h3 {
      margin: 0; /* 제목 간격 제거 */
      font-size: 1.5rem; /* 글자 크기 조정 */
    }
  </style>
</head>
<body>
<div class="container">
  <!-- 정보 관리 섹션 -->
  <div
          class="section"
          id="info-management"
          onclick="location.href='/senior/info'">
    <h3>정보 관리</h3>
  </div>

  <!-- 건강 관리 섹션 -->
  <div
          class="section"
          id="health-management"
          onclick="location.href='/senior/health'">
    <h3>건강 관리</h3>
  </div>
</div>
</body>
</html>
