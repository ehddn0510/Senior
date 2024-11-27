<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<div class="modal fade" id="loginModal" tabindex="-1" aria-labelledby="loginModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
            </div>
            <div class="modal-body">
                <h2 class="modal-title">시니어케어</h2>
                <p class="modal-subtitle">로그인 유형을 선택해 주세요</p>
                <div class="modal-options">
                    <a href="/login/user" class="btn-action btn-customer">
                        <i class="fas fa-user action-icon"></i>
                        <span>고객 로그인</span>
                    </a>
                    <a href="/login/careworker" class="btn-action btn-careworker">
                        <i class="fas fa-hand-holding-heart action-icon"></i>
                        <span>보호사 로그인</span>
                    </a>
                </div>
            </div>
        </div>
    </div>
</div>
