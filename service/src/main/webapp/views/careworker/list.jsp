<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<body>
<section class="layout_padding">
    <div class="container">
        <!-- 제목 -->
        <div class="heading_container">
            <h2 class="filter_heading">지금 당신을 기다리는 보호사 리스트를 확인해보세요.</h2>
        </div>

        <!-- 필터 섹션 -->
        <div class="filter_section">
            <form id="searchForm">
                <fieldset>
                    <legend class="filter_title">보호사 찾기</legend>

                    <!-- 우편번호 필터 -->
                    <div class="form_group">
                        <label for="zipcode" class="form_label">우편번호로 찾기</label>
                        <div class="input-group">
                            <!-- 우편번호 입력 필드 -->
                            <input
                                    type="text"
                                    id="sample4_postcode"
                                    name="zipcode"
                                    placeholder="우편번호를 입력하세요"
                                    readonly
                                    class="form-control border-right-0"
                            />
                            <!-- 우편번호 검색 버튼 -->
                            <button
                                    type="button"
                                    class="btn btn-primary border-left-0"
                                    onclick="sample4_execDaumPostcode()"
                                    style="background-color: #39b54a; color: white; border: none;"
                            >
                                검색
                            </button>
                        </div>
                        <!-- 숨겨진 필드 -->
                        <input type="hidden" id="sample4_roadAddress" name="roadAddress" />
                        <input type="hidden" id="sample4_jibunAddress" name="jibunAddress" />
                    </div>

                    <!-- 경력 필터 -->
                    <div class="form_group">
                        <label for="experience" class="form_label">경력으로 찾기</label>
                        <select id="experience" name="experience" class="form_select">
                            <option value="">전체</option>
                            <option value="1">1년 이하</option>
                            <option value="5">1년 ~ 5년</option>
                            <option value="10">5년 이상</option>
                        </select>
                    </div>

                    <!-- 성별 필터 -->
                    <div class="form_group">
                        <span class="form_label">성별로 찾기</span>
                        <div class="radio_group">
                            <label>
                                <input type="radio" name="gender" value="" checked>
                                전체
                            </label>
                            <label>
                                <input type="radio" name="gender" value="male">
                                남
                            </label>
                            <label>
                                <input type="radio" name="gender" value="female">
                                여
                            </label>
                        </div>
                    </div>

                    <!-- 검색 버튼 -->
                    <div class="form_group">
                        <button type="button" class="submit_btn" onclick="searchCareworkers()">검색</button>
                    </div>
                </fieldset>
            </form>
        </div>

        <!-- 보호사 리스트 섹션 -->
        <div id="careworkerList" class="careworker_list">
            <!-- 검색 결과가 여기에 동적으로 추가됩니다 -->
        </div>
    </div>
</section>

<script>
    // 다음 우편번호 API 호출 함수
    function sample4_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 도로명 주소 변수
                var roadAddr = data.roadAddress;
                // 지번 주소 변수
                var jibunAddr = data.jibunAddress;

                // 우편번호 및 주소 입력 필드에 값 설정
                document.getElementById('sample4_postcode').value = data.zonecode;
                document.getElementById('sample4_roadAddress').value = roadAddr;
                document.getElementById('sample4_jibunAddress').value = jibunAddr;

                // 참고 항목이 있다면 추가 표시
                var extraRoadAddr = '';
                if (data.bname !== '' && /[동|로|가]$/g.test(data.bname)) {
                    extraRoadAddr += data.bname;
                }
                if (data.buildingName !== '' && data.apartment === 'Y') {
                    extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                if (extraRoadAddr !== '') {
                    extraRoadAddr = ' (' + extraRoadAddr + ')';
                }

                if (roadAddr !== '') {
                    document.getElementById("sample4_roadAddress").value += extraRoadAddr;
                }
            }
        }).open();
    }

    // AJAX를 사용한 검색
    function searchCareworkers() {
        const formData = new FormData(document.getElementById('searchForm'));

        fetch('/careworker/search', {
            method: 'POST',
            body: new URLSearchParams(formData),
        })
            .then(response => response.json())
            .then(data => {
                const careworkerList = document.getElementById('careworkerList');
                careworkerList.innerHTML = '';

                if (data.length === 0) {
                    careworkerList.innerHTML = '<p>검색 결과가 없습니다.</p>';
                    return;
                }

                data.forEach(worker => {
                    const workerCard = `
                    <div class="worker_card">
                        <div class="photo" style="background-image: url('${worker.photo}');">
                            <span class="waiting_time">${worker.waitingTime || ''}</span>
                        </div>
                        <div class="info">
                            <p class="greeting">
                                안녕하세요. 저는 <span>${worker.country}</span>에 사는 <em>${worker.name}</em>입니다.
                            </p>
                            <p class="details">
                                <em>${worker.age}살 ${worker.gender}</em>이고, <em>${worker.experience}년 경력</em>을 가지고 있습니다.<br>
                                ${worker.message || ''}
                            </p>
                        </div>
                        <div class="actions">
                            <form action="/careworker/select" method="post">
                                <input type="hidden" name="workerId" value="${worker.id}">
                                <button type="submit" class="btn btn-interest">관심 등록</button>
                            </form>
                            <a href="/careworker/support?id=${worker.id}" class="btn btn-support">지원하기</a>
                        </div>
                    </div>
                `;
                    careworkerList.innerHTML += workerCard;
                });
            })
            .catch(error => console.error('검색 오류:', error));
    }
</script>
</body>
