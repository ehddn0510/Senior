// 마커를 담을 배열입니다
var markers = [];

// 시니어 중심 좌표
var lat = $('#seniorLat').val();
var lng = $('#seniorLng').val();
var profileImagePath = "../../images/house.jpg"; // 고정된 이미지 경로

console.log("lat:", lat);
console.log("lng:", lng);

// 지도 설정
var mapContainer = document.getElementById('map');
var mapOption = {
    center: new kakao.maps.LatLng(lat, lng),
    level: 3 // 지도의 확대 레벨
};

// 지도 생성
var map = new kakao.maps.Map(mapContainer, mapOption);

// 장소 검색 객체 생성
var ps = new kakao.maps.services.Places();

// 검색 결과 목록과 마커를 클릭 시 표시할 인포윈도우
var infowindow = new kakao.maps.InfoWindow({ zIndex: 1 });

// 초기 중앙 마커 추가
addCenterMarker(lat, lng, profileImagePath);

// 기본 병원 카테고리 표시
searchPlaces("HP8");

// 병원/약국 버튼 클릭 이벤트 등록
document.getElementById('hospitalBtn').addEventListener('click', function () {
    updateCategory("HP8");
});
document.getElementById('pharmacyBtn').addEventListener('click', function () {
    updateCategory("PM9");
});

// 카테고리 변경 후 검색하는 함수
function updateCategory(category) {
    // 버튼 스타일 변경
    document.querySelectorAll('#category_wrap button').forEach((btn) => btn.classList.remove('active'));

    // 선택된 버튼에 스타일 적용
    if (category === "HP8") {
        document.getElementById('hospitalBtn').classList.add('active');
    } else if (category === "PM9") {
        document.getElementById('pharmacyBtn').classList.add('active');
    }

    // 기존 마커 제거 및 새로운 카테고리로 검색 실행
    removeMarker();
    searchPlaces(category);
}

// 중앙 마커 추가 함수
function addCenterMarker(lat, lng, imagePath) {
    var content = `
        <div class="custom-overlay">
            <img src="${imagePath}" style="width:50px; height:50px; border-radius:50%;" />
        </div>`;
    var overlay = new kakao.maps.CustomOverlay({
        position: new kakao.maps.LatLng(lat, lng),
        content: content
    });
    overlay.setMap(map);
}

// 장소 검색 요청 함수
function searchPlaces(category) {
    removeMarker(); // 기존 마커 제거
    ps.categorySearch(category, placesSearchCB, {
        location: new kakao.maps.LatLng(lat, lng),
        radius: 5000 // 반경 5km
    });
}

// 장소 검색 결과 콜백 함수
function placesSearchCB(data, status, pagination) {
    if (status === kakao.maps.services.Status.OK) {
        displayPlaces(data); // 검색된 장소 목록 및 마커 표시
        displayPagination(pagination); // 페이지네이션 표시
    } else if (status === kakao.maps.services.Status.ZERO_RESULT) {
        alert('검색 결과가 존재하지 않습니다.');
    } else if (status === kakao.maps.services.Status.ERROR) {
        alert('검색 결과 중 오류가 발생했습니다.');
    }
}

// 검색 결과 목록 및 마커 표시
function displayPlaces(places) {
    var listEl = document.getElementById('placesList');
    var fragment = document.createDocumentFragment();
    var bounds = new kakao.maps.LatLngBounds();

    // 기존 목록 초기화
    removeAllChildNods(listEl);

    // 기존 마커 제거
    removeMarker();

    // 검색 결과 처리
    places.forEach((place, i) => {
        var placePosition = new kakao.maps.LatLng(place.y, place.x);
        var marker = addMarker(placePosition, i); // 마커 생성
        var itemEl = getListItem(i, place); // 목록 항목 생성
        // 지도 범위 확장
        bounds.extend(placePosition);

        // 마커 및 목록 항목에 이벤트 추가
        (function (marker, title) {
            kakao.maps.event.addListener(marker, 'mouseover', () => displayInfowindow(marker, title));
            kakao.maps.event.addListener(marker, 'mouseout', () => infowindow.close());
            itemEl.onmouseover = () => displayInfowindow(marker, title);
            itemEl.onmouseout = () => infowindow.close();
        })(marker, place.place_name);

        fragment.appendChild(itemEl); // 목록에 항목 추가
    });

    // 완성된 목록 추가
    listEl.appendChild(fragment);

    // 지도 범위 설정
    map.setBounds(bounds);
}

// 목록 항목 생성 함수
function getListItem(index, place) {
    var el = document.createElement('li');
    el.className = 'item';

    el.innerHTML = `
        <span class="markerbg marker_${index + 1}"></span>
        <div class="info">
            <h5>${place.place_name}</h5>
            ${place.road_address_name ? `<span>${place.road_address_name}</span>` : ''}
            <span class="jibun gray">${place.address_name}</span>
            <span class="tel">${place.phone || '전화번호 없음'}</span>
        </div>`;
    return el;
}

// 마커 생성 함수
function addMarker(position, idx) {
    var imageSrc = 'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png';
    var imageSize = new kakao.maps.Size(36, 37);
    var imgOptions = {
        spriteSize: new kakao.maps.Size(36, 691),
        spriteOrigin: new kakao.maps.Point(0, idx * 46 + 10),
        offset: new kakao.maps.Point(13, 37)
    };

    var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imgOptions);
    var marker = new kakao.maps.Marker({
        position: position,
        image: markerImage
    });

    marker.setMap(map);
    markers.push(marker);

    return marker;
}

// 마커 제거 함수
function removeMarker() {
    markers.forEach(marker => marker.setMap(null));
    markers = [];
}

// 페이지네이션 표시
function displayPagination(pagination) {
    var paginationEl = document.getElementById('pagination');
    var fragment = document.createDocumentFragment();

    // 기존 페이지 번호 제거
    while (paginationEl.hasChildNodes()) {
        paginationEl.removeChild(paginationEl.lastChild);
    }

    // 새 페이지 번호 생성
    for (var i = 1; i <= pagination.last; i++) {
        var el = document.createElement('a');
        el.href = "#";
        el.innerHTML = i;
        el.className = i === pagination.current ? 'on' : '';
        el.onclick = (function (i) {
            return () => pagination.gotoPage(i);
        })(i);
        fragment.appendChild(el);
    }

    paginationEl.appendChild(fragment);
}

// 인포윈도우 표시
function displayInfowindow(marker, title) {
    var content = `<div style="padding:5px;z-index:1;">${title}</div>`;
    infowindow.setContent(content);
    infowindow.open(map, marker);
}

// 목록의 자식 요소 모두 제거
function removeAllChildNods(el) {
    while (el.hasChildNodes()) {
        el.removeChild(el.lastChild);
    }
}
