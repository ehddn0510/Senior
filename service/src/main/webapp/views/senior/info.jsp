<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Senior Information Management</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
        }
        .container {
            max-width: 800px;
            margin: 0 auto;
            padding: 20px;
        }
        .actions {
            margin-bottom: 20px;
        }
        .actions button {
            padding: 10px 20px;
            background-color: #007bff;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }
        .actions button:hover {
            background-color: #0056b3;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        table, th, td {
            border: 1px solid #ddd;
        }
        th, td {
            padding: 10px;
            text-align: center;
        }
        th {
            background-color: #f8f9fa;
        }
        /* 모달 스타일 */
        .modal {
            display: none;
            position: fixed;
            z-index: 1050; /* 헤더보다 높은 z-index */
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.5); /* 어두운 배경 */
            overflow: hidden; /* 외부 스크롤 방지 */
        }

        .modal-content {
            position: relative;
            margin: 5% auto;
            padding: 20px;
            background-color: white;
            width: 60%;
            max-height: 80%; /* 화면 높이의 80% */
            border-radius: 10px;
            overflow-y: auto; /* 모달 내부 스크롤 활성화 */
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
        }

        .modal-header, .modal-footer {
            text-align: center;
        }

        .modal-header {
            font-size: 1.5rem;
            margin-bottom: 20px;
        }

        .modal-footer button {
            padding: 10px 20px;
            background-color: #28a745;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }

        .modal-footer button:hover {
            background-color: #218838;
        }

        .form-group {
            margin-bottom: 15px;
        }

        label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
        }

        input, textarea, select {
            width: 100%;
            padding: 8px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }
    </style>
    <script>
        let seniorList = []; // 시니어 목록 데이터를 관리하는 배열

        // 모달 열기
        function openModal() {
            document.getElementById("modal").style.display = "block";
            document.body.style.overflow = "hidden"; // 외부 스크롤 방지
        }

        // 모달 닫기
        function closeModal() {
            document.getElementById("modal").style.display = "none";
            document.body.style.overflow = "auto"; // 외부 스크롤 재활성화
        }

        // 세션에서 userId 가져오기
        const userId = '<%= session.getAttribute("principal") %>'; // JSP에서 세션 값을 가져옵니다.

        // 시니어 등록
        function registerSenior() {
            const senior = {
                seniorName: document.getElementById("seniorName").value,
                seniorGender: document.getElementById("seniorGender").value,
                seniorTel: document.getElementById("seniorTel").value,
                seniorBirth: document.getElementById("seniorBirth").value,
                seniorZipcode: document.getElementById("seniorZipcode").value,
                seniorStreetAddr: document.getElementById("seniorStreetAddr").value,
                seniorDetailAddr1: document.getElementById("seniorDetailAddr1").value,
                seniorDetailAddr2: document.getElementById("seniorDetailAddr2").value,
                seniorSignificant: document.getElementById("seniorSignificant").value,
                seniorStatus: "Active",
                userId: userId // 로그인 세션에서 가져온 userId를 추가
            };

            fetch(`/api/senior/`, {
                method: "POST",
                headers: { "Content-Type": "application/json" },
                body: JSON.stringify(senior),
            })
                .then((response) => response.json())
                .then((data) => {
                    if (data.status === 200) {
                        alert("시니어가 성공적으로 등록되었습니다.");
                        closeModal(); // 모달 닫기
                        addSeniorToTable(senior); // 목록에 추가
                    } else {
                        alert("시니어 등록에 실패했습니다.");
                    }
                })
                .catch((err) => console.error("시니어 등록 오류:", err));
        }

        // 시니어 수정
        function updateSenior(seniorId) {
            const senior = {
                seniorName: document.getElementById(`updateName_${seniorId}`).value,
                seniorTel: document.getElementById(`updateTel_${seniorId}`).value,
                seniorSignificant: document.getElementById(`updateSignificant_${seniorId}`).value,
                seniorStatus: "Active",
                userId: userId // 로그인 세션에서 가져온 userId를 추가
            };

            fetch(`/api/senior/update/${seniorId}`, {
                method: "PUT",
                headers: { "Content-Type": "application/json" },
                body: JSON.stringify(senior),
            })
                .then((response) => response.json())
                .then((data) => {
                    if (data.status === 200) {
                        alert("시니어 정보가 수정되었습니다.");
                        location.reload(); // 페이지 새로고침
                    } else {
                        alert("시니어 수정에 실패했습니다.");
                    }
                })
                .catch((err) => console.error("시니어 수정 오류:", err));
        }

        // 시니어 상태 변경 (소프트 삭제)
        function deleteSenior(seniorId) {
            if (!confirm("정말로 상태를 변경하시겠습니까?")) return;

            fetch(`/api/senior/delete/${seniorId}`, {
                method: "DELETE",
                headers: { "Content-Type": "application/json" },
            })
                .then((response) => response.json())
                .then((data) => {
                    if (data.status === 200) {
                        alert("시니어 상태가 변경되었습니다.");
                        location.reload(); // 페이지 새로고침
                    } else {
                        alert("상태 변경에 실패했습니다.");
                    }
                })
                .catch((err) => console.error("시니어 상태 변경 오류:", err));
        }

    </script>
</head>
<body>
<div class="container">
    <div class="left-section">
        <h1>시니어 관리</h1>
        <div class="actions">
            <button onclick="openModal()">시니어 등록</button>
        </div>
    </div>
    <div class="right-section">
        <h2>시니어 목록</h2>
        <table>
            <thead>
            <tr>
                <th>ID</th>
                <th>이름</th>
                <th>전화번호</th>
                <th>상태</th>
                <th>관리</th>
            </tr>
            </thead>
            <tbody id="seniorTableBody">
            <!-- 시니어 목록 데이터 추가 -->
            </tbody>
        </table>
    </div>
</div>


<div id="modal" class="modal">
    <div class="modal-content">
        <div class="modal-header">
            <h3>시니어 등록</h3>
        </div>
        <div class="modal-body">
            <!-- 모달 내부에 스크롤 활성화 -->
            <div class="form-group">
                <label for="seniorName">이름:</label>
                <input type="text" id="seniorName" required>
            </div>
            <div class="form-group">
                <label for="seniorGender">성별:</label>
                <select id="seniorGender">
                    <option value="M">남성</option>
                    <option value="F">여성</option>
                </select>
            </div>
            <div class="form-group">
                <label for="seniorTel">전화번호:</label>
                <input type="text" id="seniorTel" placeholder="예: 010-1234-5678">
            </div>
            <div class="form-group">
                <label for="seniorBirth">생년월일:</label>
                <input type="date" id="seniorBirth">
            </div>
            <div class="form-group">
                <label for="seniorZipcode">우편번호:</label>
                <input type="text" id="seniorZipcode">
            </div>
            <div class="form-group">
                <label for="seniorStreetAddr">도로명 주소:</label>
                <input type="text" id="seniorStreetAddr">
            </div>
            <div class="form-group">
                <label for="seniorDetailAddr1">상세 주소 1:</label>
                <input type="text" id="seniorDetailAddr1">
            </div>
            <div class="form-group">
                <label for="seniorDetailAddr2">상세 주소 2:</label>
                <input type="text" id="seniorDetailAddr2">
            </div>
            <div class="form-group">
                <label for="seniorSignificant">중요 사항:</label>
                <textarea id="seniorSignificant" rows="3" placeholder="중요 사항을 입력하세요"></textarea>
            </div>
        </div>
        <div class="modal-footer">
            <button onclick="registerSenior()">등록</button>
            <button onclick="closeModal()">취소</button>
        </div>
    </div>
</div>

</body>
</html>
