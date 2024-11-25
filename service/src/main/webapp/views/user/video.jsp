<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- WebRTC Center UI -->
<div class="container py-5">
    <!-- 제목 -->
    <div class="text-center mb-4">
        <h1 class="display-4 text-primary">WebRTC Center</h1>
        <p class="lead text-secondary">Connect and stream effortlessly in your room.</p>
    </div>

    <!-- 룸 입력 및 버튼 -->
    <div class="row justify-content-center mb-4">
        <div class="col-md-6">
            <div class="input-group">
                <input type="number" class="form-control" id="roomIdInput" placeholder="Enter Room ID">
                <button class="btn btn-primary" id="enterRoomBtn">Enter Room</button>
            </div>
            <button class="btn btn-success btn-block mt-3 d-none" id="startSteamBtn">Start Streams</button>
        </div>
    </div>

    <!-- 스트림 영역 -->
    <div class="row">
        <!-- 로컬 스트림 -->
        <div class="col-md-6 mb-3">
            <div class="card border-primary">
                <div class="card-header text-center bg-primary text-white">Your Stream</div>
                <div class="card-body">
                    <div class="embed-responsive embed-responsive-16by9">
                        <video id="localStream" autoplay playsinline controls class="embed-responsive-item d-none"></video>
                    </div>
                </div>
            </div>
        </div>

        <!-- 원격 스트림 -->
        <div class="col-md-6">
            <div class="card border-secondary">
                <div class="card-header text-center bg-secondary text-white">Remote Streams</div>
                <div class="card-body">
                    <div id="remoteStreamDiv" class="d-flex flex-wrap justify-content-center">
                        <!-- 원격 스트림 비디오가 추가됩니다. -->
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- 연결된 JS -->
<script src="/js/rtc.js"></script>

<!-- 스타일 -->
<style>
    /* 전체 배경 및 텍스트 */
    body {
        background-color: #f8f9fa;
        color: #333;
    }

    /* 입력 필드와 버튼 스타일 */
    #roomIdInput {
        border-right: none;
        border-radius: 0.25rem 0 0 0.25rem;
    }

    #enterRoomBtn {
        border-radius: 0 0.25rem 0.25rem 0;
    }

    /* 숨김 처리 클래스 (JavaScript에서 삭제됨) */
    .d-none {
        display: none !important;
    }

    /* 원격 스트림 비디오 스타일 */
    #remoteStreamDiv video {
        width: 160px;
        height: auto;
        margin: 10px;
        border: 2px solid #ddd;
        border-radius: 8px;
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
        transition: transform 0.3s ease;
    }

    #remoteStreamDiv video:hover {
        transform: scale(1.1);
    }

    /* 로컬 스트림 스타일 */
    #localStream {
        display: block;
        border: 2px solid #007bff;
        border-radius: 8px;
    }
</style>
