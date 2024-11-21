<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script>
    let signup = {
        init: function () {
            $('#btn_add').click(() => {
                if (!this.validateForm()) {
                    alert("입력되지 않거나 올바르지 않은 정보가 있습니다.");
                } else {
                    this.register();
                }
            });
            $('#zipcodeBtn').click(() => {
                this.openPostcode();
            });
            $('#username').on('input', () => this.validateUsername());
            $('#password').on('input', () => this.validatePassword());
            $('#passwordConfirm').on('input', () => this.checkPasswordMatch());
            $('#email').on('input', () => this.validateEmail());
            $('#tel').on('input', () => this.validateTel());

            $('#profile').on('change', (e) => this.previewProfileImage(e.target));

        },
        validateUsername: function () {
            let username = $('#username').val();
            let message = $('#usernameMessage');

            if (username === '') {
                message.text('');
                return;
            }

            if (/^[a-zA-Z0-9_]{4,20}$/.test(username)) {
                message.text('사용 가능한 아이디입니다.').removeClass('text-danger').addClass('text-success');
            } else {
                message.text('아이디는 4~20자의 영문, 숫자와 특수문자 "_"만 사용 가능합니다.').removeClass('text-success').addClass('text-danger');
            }
        },
        validatePassword: function () {
            let password = $('#password').val();
            let message = $('#passwordMessage');

            this.checkPasswordMatch();

            if (password === '') {
                message.text('');
                return;
            }

            if (this.isPasswordValid(password)) {
                message.text('사용 가능한 비밀번호입니다.').removeClass('text-danger').addClass('text-success');
            } else {
                message.text('비밀번호는 8~16자리의 영문 대소문자, 숫자, 특수문자 중 3가지 이상 조합이어야 합니다.').removeClass('text-success').addClass('text-danger');
            }
        },
        isPasswordValid: function (password) {
            if (password.length < 8 || password.length > 16) {
                return false;
            }

            let hasLowerCase = /[a-z]/.test(password);
            let hasUpperCase = /[A-Z]/.test(password);
            let hasNumber = /[0-9]/.test(password);
            let hasSpecialChar = /[!@#$%^&*(),.?":{}|<>]/.test(password);

            return [hasLowerCase, hasUpperCase, hasNumber, hasSpecialChar].filter(Boolean).length >= 3;
        },
        checkPasswordMatch: function () {
            let password = $('#password').val();
            let passwordConfirm = $('#passwordConfirm').val();
            let message = $('#passwordConfirmMessage');

            if (password === '') {
                message.text('');
                return;
            }

            if (password === passwordConfirm) {
                message.text('비밀번호가 일치합니다.').removeClass('text-danger').addClass('text-success');
            } else {
                message.text('비밀번호가 일치하지 않습니다.').removeClass('text-success').addClass('text-danger');
            }
        },
        validateEmail: function () {
            let email = $('#email').val();
            let message = $('#emailMessage');

            if (email === '') {
                message.text('');
                return;
            }

            if (/^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$/.test(email)) {
                message.text('사용 가능한 이메일입니다.').removeClass('text-danger').addClass('text-success');
            } else {
                message.text('올바른 이메일 형식을 입력하세요.').removeClass('text-success').addClass('text-danger');
            }
        },
        validateName: function () {
            let name = $('#name').val();

            if (name === '') {
                return false;
            } else {
                return true;
            }
        },
        validateAddress: function () {
            let zipcode = $('#zipcode').val();
            let streetAddr = $('#streetAddr').val();
            let detailAddr1 = $('#detailAddr1').val();
            let detailAddr2 = $('#detailAddr2').val();

            if (zipcode === '' || streetAddr === '' || detailAddr1 === '' || detailAddr2 === '') {
                return false;
            } else {
                return true;
            }
        },
        validateBirthday: function () {
            let birthday = $('#birthday').val();

            if (birthday === '') {
                return false;
            } else {
                const today = new Date();
                const inputDate = new Date(birthday);

                if (inputDate >= today) {
                    return false;
                }

                return true;
            }
        },
        validateTel: function () {
            let tel = $('#tel').val();
            let message = $('#telMessage');

            if (tel === '') {
                message.text('');
                return;
            }

            if (/^(01[0-9]{9})$/.test(tel)) {
                message.text('사용 가능한 전화번호입니다.').removeClass('text-danger').addClass('text-success');
            } else {
                message.text('전화번호는 - 를 제외하여 입력하세요.').removeClass('text-success').addClass('text-danger');
            }
        },
        validateForm: function () {
            this.validateUsername();
            this.validatePassword();
            this.checkPasswordMatch();
            this.validateEmail();
            this.validateTel();
            let isNameValid = this.validateName();
            let isAddressValid = this.validateAddress();
            let isBirthdayValid = this.validateBirthday();

            let isValid = (
                $('#usernameMessage').hasClass('text-success') &&
                $('#passwordMessage').hasClass('text-success') &&
                $('#passwordConfirmMessage').hasClass('text-success') &&
                $('#emailMessage').hasClass('text-success') &&
                $('#telMessage').hasClass('text-success') &&
                isNameValid &&
                isAddressValid &&
                isBirthdayValid
            );

            return isValid;
        },

        openPostcode: function () {
            new daum.Postcode({
                oncomplete: function (data) {
                    let roadAddr = data.roadAddress;
                    let extraRoadAddr = '';

                    if (data.bname !== '' && /[동|로|가]$/g.test(data.bname)) {
                        extraRoadAddr += data.bname;
                    }
                    if (data.buildingName !== '' && data.apartment === 'Y') {
                        extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }

                    $("#zipcode").val(data.zonecode);
                    $("#streetAddr").val(roadAddr);
                    $("#detailAddr2").val(extraRoadAddr);
                }
            }).open();
        },

        previewProfileImage: function (input) {
            const file = input.files[0];
            const preview = $('#profilePreview');

            if (file) {
                const reader = new FileReader();
                reader.onload = function (e) {
                    preview.attr('src', e.target.result);
                };
                reader.readAsDataURL(file);
            } else {
                preview.attr('src', '/images/default-profile.jpg');
            }
        },

        register: function () {
            let form = $('#user_add_form')[0];
            let formData = new FormData(form);

            $.ajax({
                type: 'POST',
                url: '/api/users/signup',
                data: formData,
                processData: false,
                contentType: false,
                dataType: 'json',
            }).done(function (resp) {
                if (resp.status === 200) {
                    alert('회원가입이 완료되었습니다.');
                    location.href = '/login/user';
                } else {
                    alert(resp.data);
                }
            }).fail(function (error) {
                alert('서버와의 통신 중 오류가 발생했습니다.');
                console.error('Error:', error);
            });
        }
    };

    $(function () {
        signup.init();
    });
</script>
<style>
    #btn_add {
        font-size: 1.2rem;
        border-radius: 8px;
        padding: 10px 20px;
        background: linear-gradient(to right, #82c419, #6ca417);
        color: #fff;
    }
    #btn_add:hover {
        background: linear-gradient(to right, #6ca417, #82c419);
    }
    .form-group label {
        font-weight: bold;
        margin-bottom: 5px;
    }
    .profile-preview-container img {
        transition: transform 0.3s;
    }
    .profile-preview-container img:hover {
        transform: scale(1.1);
    }
</style>
<div class="container signup-container" style="margin-top: 5rem">
    <div class="row justify-content-center mt-5" style="margin-bottom: 6rem">
        <div class="col-md-6">
            <div class="card border-0">
                <div class="card-body">
                    <h3 class="card-title text-center mb-4">고객으로 회원가입</h3>
                    <form id="user_add_form">
                        <div class="form-group text-center">
                            <label for="profile">
                                <div class="profile-preview-container mt-3">
                                    <img id="profilePreview" src="/images/default-profile.jpg"
                                         style="width: 170px; height: 170px; object-fit: cover; border: 1px solid #ddd; border-radius: 50%;"
                                         alt="이미지 미리보기"/>
                                </div>
                            </label>
                            <input type="file" class="form-control" id="profile" name="userProfileFile" accept="image/*"
                                   hidden="hidden"/>
                        </div>
                        <div class="form-group">
                            <label for="username">아이디</label>
                            <input type="text" class="form-control" id="username" name="userUsername"
                                   placeholder="아이디를 입력하세요" required>
                            <small id="usernameMessage" class="form-text"></small>
                        </div>
                        <div class="form-group">
                            <label for="password">비밀번호</label>
                            <input type="password" class="form-control" id="password" name="userPassword"
                                   placeholder="비밀번호를 입력하세요" required>
                            <small id="passwordMessage" class="form-text"></small>
                        </div>
                        <div class="form-group">
                            <label for="passwordConfirm">비밀번호 재확인</label>
                            <input type="password" class="form-control" id="passwordConfirm" placeholder="비밀번호를 입력하세요"
                                   required>
                            <small id="passwordConfirmMessage" class="form-text"></small>
                        </div>
                        <div class="form-group">
                            <label for="name">이름</label>
                            <input type="text" class="form-control" id="name" name="userName" placeholder="이름을 입력하세요"
                                   required>
                        </div>
                        <div class="form-group">
                            <label for="tel">전화번호</label>
                            <input type="text" class="form-control" id="tel" name="userTel" placeholder="전화번호 입력"
                                   maxlength="11" required>
                            <small id="telMessage" class="form-text"></small>
                        </div>
                        <div class="form-group">
                            <label for="email">이메일</label>
                            <input type="email" class="form-control" id="email" name="userEmail"
                                   placeholder="이메일을 입력하세요" required>
                            <small id="emailMessage" class="form-text"></small>
                        </div>
                        <div class="form-group">
                            <label for="birthday">생년월일</label>
                            <input type="date" class="form-control" id="birthday" name="userBirthday" required>
                        </div>
                        <div class="form-group">
                            <label for="zipcode">우편번호</label>
                            <div class="input-group">
                                <input type="text" class="form-control" id="zipcode" name="userZipcode"
                                       placeholder="우편번호를 검색하세요" readonly required>
                                <div class="input-group-append">
                                    <button type="button" class="btn btn-outline-secondary" id="zipcodeBtn">우편번호 검색
                                    </button>
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="streetAddr">주소</label>
                            <input type="text" class="form-control" id="streetAddr" name="userStreetAddr"
                                   placeholder="주소를 입력하세요" readonly required>
                        </div>
                        <div class="form-group">
                            <label for="detailAddr2">상세주소 1</label>
                            <input type="text" class="form-control" id="detailAddr2" name="userDetailAddr2"
                                   placeholder="상세주소 1을 입력하세요" readonly required>
                        </div>
                        <div class="form-group">
                            <label for="detailAddr1">상세주소 2</label>
                            <input type="text" class="form-control" id="detailAddr1" name="userDetailAddr1"
                                   placeholder="상세주소 2를 입력하세요">
                        </div>
                    </form>
                    <button type="submit" id="btn_add" class="btn btn-primary btn-block border-0">회원가입
                    </button>
                    <div class="mt-3 text-center">
                        <p>이미 계정이 있으신가요? <a href="/login/user">로그인</a></p>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
