<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;500;700&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<style>
    body {
        font-family: 'Noto Sans KR', sans-serif;
    }
    .modal-content {
        border: none;
        border-radius: 20px;
        box-shadow: 0 10px 30px rgba(0,0,0,0.1);
        overflow: hidden;
    }
    .modal-header {
        background-color: #f8f9fa;
        border-bottom: none;
        padding: 2rem;
        text-align: center;
    }
    .modal-title {
        font-weight: 700;
        color: #333;
        font-size: 1.8rem;
        margin-bottom: 0;
    }
    .modal-body {
        padding: 2rem;
    }
    .login-options {
        display: flex;
        justify-content: space-between;
        gap: 1rem;
    }
    .btn-login {
        flex: 1;
        font-size: 1.1rem;
        font-weight: 500;
        padding: 1.5rem 1rem;
        border-radius: 15px;
        transition: all 0.3s ease;
        display: flex;
        flex-direction: column;
        align-items: center;
        justify-content: center;
        text-decoration: none;
        color: #fff;
    }
    .btn-login i {
        font-size: 2rem;
        margin-bottom: 0.5rem;
    }
    .btn-customer {
        background-color: #4CAF50;
    }
    .btn-customer:hover {
        background-color: #45a049;
        transform: translateY(-5px);
        box-shadow: 0 5px 15px rgba(76, 175, 80, 0.3);
    }
    .btn-careworker {
        background-color: #2196F3;
    }
    .btn-careworker:hover {
        background-color: #1e88e5;
        transform: translateY(-5px);
        box-shadow: 0 5px 15px rgba(33, 150, 243, 0.3);
    }
    .close {
        position: absolute;
        top: 1rem;
        right: 1rem;
        font-size: 1.5rem;
        color: #666;
        opacity: 1;
        transition: all 0.3s ease;
    }
    .close:hover {
        color: #333;
        transform: rotate(90deg);
    }
</style>
</head>
<body>

<div class="modal fade" id="loginModal" tabindex="-1" aria-labelledby="loginModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="loginModalLabel">로그인 유형 선택</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <div class="login-options">
                    <a href="/login/user" class="btn-login btn-customer">
                        <i class="fas fa-user"></i>
                        고객 로그인
                    </a>
                    <a href="/login/careworker" class="btn-login btn-careworker">
                        <i class="fas fa-hand-holding-heart"></i>
                        보호사 로그인
                    </a>
                </div>
            </div>
        </div>
    </div>
</div>