<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style>
    /* 기본 스타일 */
    body {
        font-family: 'Noto Sans KR', sans-serif;
        background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
        min-height: 100vh;
        color: #2c3e50;
    }

    .container {
        max-width: 1200px;
        margin: 0 auto;
        padding: 2rem;
    }

    /* 헤더 스타일 */
    .header {
        text-align: center;
        margin-bottom: 3rem;
        padding: 2rem 0;
    }

    .header h1 {
        font-size: 2.5rem;
        color: #2c3e50;
        margin-bottom: 1rem;
        font-weight: 700;
    }

    .header p {
        color: #7f8c8d;
        font-size: 1.2rem;
    }

    /* 입력 영역 스타일 */
    .room-controls {
        background: white;
        padding: 2rem;
        border-radius: 15px;
        box-shadow: 0 10px 20px rgba(0,0,0,0.1);
        margin-bottom: 2rem;
    }

    .input-group {
        display: flex;
        gap: 1rem;
        margin-bottom: 1rem;
    }

    .input-group input {
        flex: 1;
        padding: 0.8rem 1rem;
        border: 2px solid #e0e0e0;
        border-radius: 10px;
        font-size: 1rem;
        transition: all 0.3s ease;
    }

    .input-group input:focus {
        border-color: #3498db;
        box-shadow: 0 0 0 3px rgba(52,152,219,0.2);
        outline: none;
    }

    .btn {
        padding: 0.8rem 1.5rem;
        border: none;
        border-radius: 10px;
        font-weight: 500;
        cursor: pointer;
        transition: all 0.3s ease;
    }

    .btn-primary {
        background: #3498db;
        color: white;
    }

    .btn-primary:hover {
        background: #2980b9;
        transform: translateY(-2px);
    }

    /* 스트림 영역 스타일 */
    .streams-container {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
        gap: 2rem;
        margin-top: 2rem;
    }

    .stream-card {
        background: white;
        border-radius: 15px;
        overflow: hidden;
        box-shadow: 0 10px 20px rgba(0,0,0,0.1);
        transition: all 0.3s ease;
    }

    .stream-card:hover {
        transform: translateY(-5px);
        box-shadow: 0 15px 30px rgba(0,0,0,0.2);
    }

    .stream-header {
        padding: 1rem;
        background: #34495e;
        color: white;
        text-align: center;
        font-weight: 500;
    }

    .stream-body {
        padding: 1rem;
    }

    /* 비디오 컨테이너 공통 스타일 */
    .video-container {
        position: relative;
        padding-top: 56.25%; /* 16:9 비율 */
        background: #f8f9fa;
        border-radius: 10px;
        overflow: hidden;
    }

    /* 비디오 태그 스타일 */
    video {
        position: absolute;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        object-fit: cover; /* 비디오가 컨테이너 안에 꽉 차게 */
        border-radius: 10px;
    }

    /* 원격 스트림 컨테이너 스타일 */
    #remoteStreamDiv {
        position: relative; /* 부모 컨테이너로 설정 */
        padding-top: 56.25%; /* 16:9 비율로 설정 */
        background: #f8f9fa; /* 비디오 없는 상태에서의 배경 */
        border-radius: 10px;
        overflow: hidden; /* 비디오가 컨테이너 밖으로 나가지 않도록 설정 */
    }

    /* 반응형 디자인 */
    @media (max-width: 768px) {
        .container {
            padding: 1rem;
        }

        .header h1 {
            font-size: 2rem;
        }

        .header p {
            font-size: 1rem;
        }

        .input-group {
            flex-direction: column;
        }

        .btn {
            width: 100%;
        }
    }
</style>

</head>
<body>
<div class="container">
    <!-- 헤더 -->
    <div class="header">
        <h1>시니어 케어</h1>
        <p>실시간 화상 통화를 시작하세요</p>
    </div>

    <!-- 룸 컨트롤 -->
    <div class="room-controls">
        <div class="input-group">
            <input type="number" id="roomIdInput" placeholder="방 번호를 입력하세요" min="1">
            <button class="btn btn-primary" id="enterRoomBtn">
                <i class="fas fa-door-open"></i> 입장하기
            </button>
            <button class="btn btn-success d-none" id="startSteamBtn">
                <i class="fas fa-video"></i> 스트리밍 시작
            </button>
        </div>

    </div>

    <!-- 스트림 영역 -->
    <div class="streams-container">
        <!-- 로컬 스트림 -->
        <div class="stream-card">
            <div class="stream-header">
                <i class="fas fa-user"></i> 보호사
            </div>
            <div class="stream-body">
                <div class="video-container">
                    <video id="localStream" autoplay playsinline controls class="d-none"></video>
                </div>
            </div>
        </div>

        <!-- 원격 스트림 -->
        <div class="stream-card">
            <div class="stream-header">
                <i class="fas fa-users"></i> 고객
            </div>
            <div class="stream-body">
                <div id="remoteStreamDiv">
                    <!-- 고객 스트림이 동적으로 추가됩니다 -->
                </div>
            </div>
        </div>
    </div>
</div>

<!-- 스크립트 -->
<script src="/js/rtc.js"></script>
