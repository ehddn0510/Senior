<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en" class="h-100">

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width,initial-scale=1">
    <title>Focus - Bootstrap Admin Dashboard</title>
    <link rel="icon" type="image/png" sizes="16x16" href="./images/favicon.png">
    <link href="./css/style.css" rel="stylesheet">

    <!-- JavaScript dependencies (jQuery 제거) -->
    <script src="./vendor/global/global.min.js"></script>
</head>

<body class="h-100">
<div class="authincation h-100">
    <div class="container-fluid h-100">
        <div class="row justify-content-center h-100 align-items-center">
            <div class="col-md-6">
                <div class="authincation-content">
                    <div class="row no-gutters">
                        <div class="col-xl-12">
                            <div class="auth-form">
                                <h4 class="text-center mb-4">Sign up your account</h4>
                                <!-- Register form -->
                                <form id="registerForm" onsubmit="return false;">
                                    <div class="form-group">
                                        <label><strong>Username</strong></label>
                                        <input type="text" class="form-control" id="admin_username" placeholder="Enter username" required>
                                    </div>
                                    <div class="form-group">
                                        <label><strong>Password</strong></label>
                                        <input type="password" class="form-control" id="admin_password" placeholder="Enter password" required>
                                    </div>
                                    <div class="form-group">
                                        <label><strong>Name</strong></label>
                                        <input type="text" class="form-control" id="admin_name" placeholder="Enter name" required>
                                    </div>
                                    <div class="text-center mt-4">
                                        <button type="button" class="btn btn-primary btn-block" id="signupbtn">Sign me up</button>
                                    </div>
                                </form>
                                <div class="new-account mt-3">
                                    <p>Already have an account? <a class="text-primary" href="<c:url value='/login'/>">Sign in</a></p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    document.addEventListener("DOMContentLoaded", function() {
        let register = {
            init: function() {
                document.getElementById('signupbtn').addEventListener('click', () => {
                    this.register();
                });
            },
            register: function() {
                let data = {
                    adminUsername: document.getElementById("admin_username").value,
                    adminPassword: document.getElementById("admin_password").value,
                    adminName: document.getElementById("admin_name").value,
                };

                fetch('<c:url value="/api/admin/signup"/>', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json; charset=utf-8'
                    },
                    body: JSON.stringify(data)
                })
                    .then(response => {
                        if (response.ok) {
                            alert("SUCCESS TO SIGN UP");
                            window.location.href = "<c:url value='/login'/>";
                        } else {
                            return response.text().then(text => { throw new Error(text) });
                        }
                    })
                    .catch(error => {
                        alert("FAIL TO SIGN UP! " + error.message);
                        console.error("Error:", error);
                    });
            }
        };
        register.init();
    });
</script>

</body>
</html>
