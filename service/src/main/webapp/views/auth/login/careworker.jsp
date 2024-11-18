<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>보호사 로그인</title>
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.4.4/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script>
    let login = {
        init: function () {
            $('#loginbtn').click(() => {
                this.login();
            });
        },
        login: function () {
            let data = {
                cwUsername: $("#username").val(),
                cwPassword: $("#password").val(),
            };

            $.ajax({
                type: "POST",
                url: "/api/careworkers/login",
                data: JSON.stringify(data),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
            }).done(function (resp) {
                if (resp.data === 1) {
                    location.href = "/";
                } else {
                    alert("로그인 실패");
                }
            }).fail(function (error) {
                alert("로그인 실패 ! " + error);
                console.error("Error:", error);
            });
        }
    }
    $(function () {
        login.init();
    })
</script>
<body class="bg-light">
<div class="container">
    <div class="row justify-content-center mt-5">
        <div class="col-md-6">
            <div class="card shadow-sm">
                <div class="card-body">
                    <h3 class="card-title text-center mb-4">보호사 로그인</h3>
                    <form>
                        <div class="form-group">
                            <label for="username">아이디</label>
                            <input type="email" class="form-control" id="username" name="username"
                                   placeholder="아이디를 입력하세요" required>
                        </div>
                        <div class="form-group">
                            <label for="password">비밀번호</label>
                            <input type="password" class="form-control" id="password" name="password"
                                   placeholder="비밀번호를 입력하세요" required>
                        </div>
                    </form>
                    <div class="text-center">
                        <button type="button" id="loginbtn" class="btn btn-primary btn-block">로그인</button>
                    </div>
                    <div class="mt-3 text-center">
                        <p>아직 계정이 없으신가요? <a href="/signup/customer">회원가입</a></p>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>
