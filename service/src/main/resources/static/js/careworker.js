let careworkerList = {
    init: function () {
        // 보호사 검색 함수
        const fetchCareworkers = () => {
            const selected = $('#senior-select').val().split(',');
            const latitude = selected[0];
            const longitude = selected[1];

            // 반경 선택값
            const radius = $('#radius-select').val();

            $.ajax({
                url: `/api/careworkers/nearby`,
                method: 'GET',
                data: {
                    latitude: latitude,
                    longitude: longitude,
                    radius: radius
                },
                success: function (data) {
                    if (!Array.isArray(data)) {
                        alert("API 응답이 올바르지 않습니다.");
                        return;
                    }

                    const listDiv = $('#careworker-list');
                    listDiv.empty(); // 기존 결과 초기화

                    data.forEach(careworker => {
                        const name = careworker.cwName || '이름 없음';
                        const profile = careworker.cwProfile || 'default-profile.png';
                        const tel = careworker.cwTel || '연락처 없음';
                        const distance = careworker.distance != null ? careworker.distance.toFixed(2) + ' km' : '정보 없음';

                        const card = `
    <div class="card">
        <img src="/imgs/careworker/${profile}" class="card-img-top" alt="${name}" 
             onerror="this.src='/imgs/default-profile.jpg'">
        <div class="card-body">
            <h5 class="card-title">${name}</h5>
            <p class="card-text">
                <strong>거리:</strong> ${distance}<br>
                <strong>연락처:</strong> ${tel}
            </p>
            <a href="/user/careworkers/${careworker.cwId}" class="btn-primary btn-sm">자세히 보기</a>
        </div>
    </div>
`;
                        listDiv.append(card);
                    });
                },
                error: function (xhr, status, error) {
                    console.error("Error:", error);
                    alert("보호사 데이터를 가져오는 데 실패했습니다.");
                }
            });
        };

        // 페이지 로드 시 기본 검색 실행
        $(document).ready(fetchCareworkers);

        // 보호사 검색 버튼 클릭 이벤트
        $('#search-btn').click(fetchCareworkers);
    }
}

$(function () {
    careworkerList.init();
});
