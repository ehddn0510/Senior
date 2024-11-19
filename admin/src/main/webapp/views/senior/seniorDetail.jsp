<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<div class="content-body">
    <div class="container-fluid">
        <!-- 시니어 정보 헤더 -->
        <div class="profile">
            <div class="profile-head">
                <div class="profile-info text-center mt-3">
                    <h4 class="text-primary">${senior.seniorName}</h4>
                    <p class="mb-1">ID: ${senior.seniorId}</p>
                    <p>Phone: ${senior.seniorTel}</p>
                    <p>Gender: ${senior.seniorGender == 'male' ? '남성' : '여성'}</p>
                </div>
            </div>
        </div>

        <!-- 시니어 상세 정보 -->
        <div class="row mt-4">
            <div class="col-lg-8">
                <!-- 수정 가능한 폼 -->
                <div class="card mt-3">
                    <div class="card-body">
                        <h5 class="text-primary">Edit Senior Information</h5>
                        <form action="updateSenior" method="post">
                            <input type="hidden" name="seniorId" value="${senior.seniorId}" />

                            <div class="form-group">
                                <label for="seniorName">Name</label>
                                <input type="text" class="form-control" id="seniorName" name="seniorName" value="${senior.seniorName}">
                            </div>
                            <div class="form-group">
                                <label for="seniorTel">Phone</label>
                                <input type="text" class="form-control" id="seniorTel" name="seniorTel" value="${senior.seniorTel}">
                            </div>
                            <div class="form-group">
                                <label for="seniorBirth">Birth Date</label>
                                <input type="date" class="form-control" id="seniorBirth" name="seniorBirth" value="<fmt:formatDate value='${senior.seniorBirth}' pattern='yyyy-MM-dd' />">
                            </div>

                            <!-- 주소 입력 필드 및 우편번호 검색 버튼 -->
                            <div class="form-group">
                                <label for="seniorZipcode">Address</label>
                                <div class="d-flex align-items-center mb-2">
                                    <input type="text" class="form-control mr-2" id="seniorZipcode" name="seniorZipcode" placeholder="우편번호" value="${senior.seniorZipcode}" readonly />
                                    <a href="javascript:void(0);" onclick="popupZipSearch();" class="btn btn-primary px-4">우편번호 찾기</a>
                                </div>
                                <input type="text" class="form-control mb-2" id="seniorStreetAddr" name="seniorStreetAddr" placeholder="Street" value="${senior.seniorStreetAddr}" readonly />
                                <input type="text" class="form-control mb-2" id="seniorDetailAddr1" name="seniorDetailAddr1" placeholder="Apartment" value="${senior.seniorDetailAddr1}">
                                <input type="text" class="form-control" id="seniorDetailAddr2" name="seniorDetailAddr2" placeholder="Building Name" value="${senior.seniorDetailAddr2}">
                            </div>

                            <div class="form-group">
                                <label for="seniorStatus">Status</label>
                                <select class="form-control" id="seniorStatus" name="seniorStatus">
                                    <option value="active" ${senior.seniorStatus == 'active' ? 'selected' : ''}>Active</option>
                                    <option value="inactive" ${senior.seniorStatus == 'inactive' ? 'selected' : ''}>Inactive</option>
                                </select>
                            </div>

                            <div class="form-group">
                                <label for="seniorSignificant">Significant Information</label>
                                <textarea class="form-control" id="seniorSignificant" name="seniorSignificant" rows="3">${senior.seniorSignificant}</textarea>
                            </div>

                            <button type="submit" class="btn btn-primary">Update</button>
                        </form>
                    </div>
                </div>
            </div>

            <!-- Senior 목록 표시 -->
            <div class="col-lg-4">
                <h5 class="text-primary">Senior List</h5>
                <c:forEach items="${seniors}" var="seniorItem">
                    <div class="card mb-3">
                        <div class="card-body text-center">
                            <h5 class="text-primary">
                                <a href="senior-detail?id=${seniorItem.seniorId}">${seniorItem.seniorName}</a>
                            </h5>
                            <p class="mb-1">${seniorItem.seniorGender == 'male' ? '남성' : '여성'}</p>
                            <p class="mb-1">
                                <fmt:formatDate value="${seniorItem.seniorBirth}" pattern="yyyy년 MM월 dd일" />
                            </p>
                            <div class="mt-4 text-center">
                                <a href="javascript:void(0)" class="btn btn-primary btn-sm">Follow</a>
                                <a href="javascript:void(0)" class="btn btn-dark btn-sm">Message</a>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>
    </div>
</div>

<script>
    document.querySelector("form[action='updateSenior']").addEventListener("submit", function(event) {
        event.preventDefault(); // 폼 기본 제출 동작 방지

        const formData = new FormData(this);

        fetch("<c:url value='/api/senior/updateSenior' />", {
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

    function popupZipSearch(){
        new daum.Postcode({
            oncomplete: function(data) {
                var fullAddr = ''; // 최종 주소 변수
                var extraAddr = ''; // 조합형 주소 변수

                if (data.userSelectedType === 'R') { // 도로명 주소
                    fullAddr = data.roadAddress;
                } else { // 지번 주소
                    fullAddr = data.jibunAddress;
                }

                // 도로명 주소에 추가 정보가 있을 경우
                if(data.userSelectedType === 'R'){
                    if(data.bname !== ''){
                        extraAddr += data.bname;
                    }
                    if(data.buildingName !== ''){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    fullAddr += (extraAddr !== '' ? ' ('+ extraAddr +')' : '');
                }

                // 주소와 괄호 내용을 분리
                var mainAddr = fullAddr.replace(/\s*\([^)]*\)/, '').trim(); // 괄호 포함 내용을 제거한 주소
                var buildingNameMatch = fullAddr.match(/\(([^)]+)\)/); // () 안의 텍스트 추출

                // 우편번호와 주소 필드에 입력
                document.getElementById('seniorZipcode').value = data.zonecode;
                document.getElementById("seniorStreetAddr").value = mainAddr; // 괄호 제외 주소
                document.getElementById("seniorDetailAddr2").value = buildingNameMatch ? buildingNameMatch[1] : ""; // 괄호 안의 내용

                // 상세 주소 입력 필드로 포커스 이동
                document.getElementById("seniorDetailAddr1").focus();
            }
        }).open();
    }
</script>

