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
        background-color: #ffffff;
    }
    .signup-options {
        display: flex;
        justify-content: space-between;
        gap: 1rem;
    }
    .btn-signup {
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
        border: none;
    }
    .btn-signup i {
        font-size: 2rem;
        margin-bottom: 0.5rem;
    }
    .btn-customer {
        background-color: #007bff;
    }
    .btn-customer:hover {
        background-color: #0056b3;
        transform: translateY(-5px);
        box-shadow: 0 5px 15px rgba(0, 123, 255, 0.3);
    }
    .btn-careworker {
        background-color: #28a745;
    }
    .btn-careworker:hover {
        background-color: #1e7e34;
        transform: translateY(-5px);
        box-shadow: 0 5px 15px rgba(40, 167, 69, 0.3);
    }
    .close {
        position: absolute;
        top: 1rem;
        right: 1rem;
        font-size: 1.5rem;
        color: #666;
        opacity: 1;
        transition: all 0.3s ease;
        background: none;
        border: none;
        cursor: pointer;
    }
    .close:hover {
        color: #333;
        transform: rotate(90deg);
    }
    @media (max-width: 576px) {
        .signup-options {
            flex-direction: column;
        }
        .btn-signup {
            width: 100%;
        }
    }
</style>
</head>
<body>

<div class="modal fade" id="signModal" tabindex="-1" aria-labelledby="signModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="signModalLabel">회원가입 유형 선택</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <div class="signup-options">
                    <a href="/signup/user" class="btn-signup btn-customer">
                        <i class="fas fa-user"></i>
                        고객으로 회원가입
                    </a>
                    <a href="/signup/careworker" class="btn-signup btn-careworker">
                        <i class="fas fa-hand-holding-heart"></i>
                        보호사로 회원가입
                    </a>
                </div>
            </div>
        </div>
    </div>
</div>