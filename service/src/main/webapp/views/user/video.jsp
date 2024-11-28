<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

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
