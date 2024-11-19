<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<style>
    .modal-header {
        background-color: #f8f9fa;
    }

    .btn-custom {
        font-size: 1.2rem;
        font-weight: 500;
        padding: 0.75rem;
        width: 100%;
    }

    .btn-customer {
        background-color: #007bff;
        color: #fff;
    }

    .btn-customer:hover {
        background-color: #0056b3;
    }

    .btn-careworker {
        background-color: #28a745;
        color: #fff;
    }

    .btn-careworker:hover {
        background-color: #1e7e34;
    }
</style>
<div class="modal fade" id="signModal" tabindex="-1" aria-labelledby="loginModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="loginModalLabel">회원가입 유형 선택</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body text-center">
                <div class="d-flex flex-column">
                    <!-- 고객 로그인 버튼 -->
                    <a href="/signup/user" class="btn btn-custom btn-customer mb-3">
                        고객으로 회원가입
                    </a>
                    <!-- 보호사 로그인 버튼 -->
                    <a href="/signup/careworker" class="btn btn-custom btn-careworker">
                        보호사로 회원가입
                    </a>
                </div>
            </div>
        </div>
    </div>
</div>
