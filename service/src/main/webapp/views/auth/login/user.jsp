<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script>
    let login = {
        init: function () {
            $('#loginbtn').click(() => {
                this.login();
            });
        },
        login: function () {
            let data = {
                userUsername: $("#username").val(),
                userPassword: $("#password").val(),
            };

            $.ajax({
                type: "POST",
                url: "/api/users/login",
                data: JSON.stringify(data),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
            }).done(function (resp) {
                if (resp.status === 200 && resp.data === "1") {
                    location.href = "/";
                } else {
                    alert(resp.data); // 예외 메시지를 사용자에게 표시
                }
            }).fail(function (error) {
                alert("서버와의 통신 중 오류가 발생했습니다.");
                console.error("Error:", error);
            });
        }
    }
    $(function () {
        login.init();
    })
</script>

<div class="container" style="margin-top: 5rem">
    <div class="row justify-content-center mt-5"  style="margin-bottom: 6rem">
        <div class="col-md-6">
            <div class="card shadow-sm">
                <div class="card-body">
                    <h3 class="card-title text-center mb-4">고객 로그인</h3>
                    <form>
                        <div class="form-group">
                            <label for="username">아이디</label>
                            <input type="text" class="form-control" id="username" name="username"
                                   placeholder="아이디를 입력하세요" required>
                        </div>
                        <div class="form-group">
                            <label for="password">비밀번호</label>
                            <input type="password" class="form-control" id="password" name="password"
                                   placeholder="비밀번호를 입력하세요" required>
                        </div>
                    </form>
                    <div class="text-center">
                        <button type="button" id="loginbtn" class="btn btn-primary btn-block" style="background-color: #82c419; border: none">로그인</button>
                    </div>
                    <div class="mt-3 text-center">
                        <p>아직 계정이 없으신가요? <a href="/signup/user">회원가입</a></p>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
