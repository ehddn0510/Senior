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

            if (password === passwordConfirm) {
                message.text('비밀번호가 일치합니다.').removeClass('text-danger').addClass('text-success');
            } else {
                message.text('비밀번호가 일치하지 않습니다.').removeClass('text-success').addClass('text-danger');
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

        validateGender: function () {
            let gender = $('#gender').val();

            if (gender === 'N') {
                return false;
            } else {
                return true;
            }
        },

        validateHoliday: function () {
            let holiday = $('#holiday').val();

            if (holiday === '선택') {
                return false;
            } else {
                return true;
            }
        },

        validateIntro: function () {
            let intro = $('#intro').val();

            if (intro === '') {
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
            let isGenderValid = this.validateGender();
            let isHolidayValid = this.validateHoliday();
            let isIntroValid = this.validateIntro();

            let isValid = (
                $('#usernameMessage').hasClass('text-success') &&
                $('#passwordMessage').hasClass('text-success') &&
                $('#passwordConfirmMessage').hasClass('text-success') &&
                $('#emailMessage').hasClass('text-success') &&
                $('#telMessage').hasClass('text-success') &&
                isNameValid &&
                isAddressValid &&
                isBirthdayValid &&
                isGenderValid &&
                isHolidayValid &&
                isIntroValid
            );

            return isValid;
        },

        openPostcode: function () {
            new daum.Postcode({
                oncomplete: (data) => {
                    let roadAddr = data.roadAddress;
                    let extraRoadAddr = '';

                    if (data.bname !== '' && /[동|로|가]$/g.test(data.bname)) {
                        extraRoadAddr += data.bname;
                    }
                    if (data.buildingName !== '' && data.apartment === 'Y') {
                        extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }

                    this.getAddressCoords(roadAddr)
                        .then((coords) => {
                            const x = coords.getLng();
                            const y = coords.getLat();

                            console.log('x:', x);
                            console.log('y:', y);

                            $("#zipcode").val(data.zonecode);
                            $("#streetAddr").val(roadAddr);
                            $("#detailAddr2").val(extraRoadAddr);

                            $("#latitude").val(x);
                            $("#longitude").val(y);
                        })
                        .catch((error) => {
                            console.error('좌표 조회 실패:', error);
                            alert('주소에 대한 좌표를 조회할 수 없습니다.');
                        });
                }
            }).open();
        },

        getAddressCoords: function (address) {
            const geoCoder = new kakao.maps.services.Geocoder();
            return new Promise((resolve, reject) => {
                geoCoder.addressSearch(address, (result, status) => {
                    if (status === kakao.maps.services.Status.OK) {
                        const coords = new kakao.maps.LatLng(result[0].x, result[0].y);
                        resolve(coords);
                    } else {
                        reject(status);
                    }
                });
            });
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
            let form = $('#careworker_add_form')[0];
            let formData = new FormData(form);
            console.log('formData:', formData);
            $.ajax({
                type: 'POST',
                url: '/api/careworkers/signup',
                data: formData,
                processData: false,
                contentType: false,
                dataType: 'json',
            }).done(function (resp) {
                if (resp.status === 200) {
                    alert('회원가입이 완료되었습니다.');
                    location.href = '/login/careworker';
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
                    <h3 class="card-title text-center mb-4">보호사로 회원가입</h3>
                    <form id="careworker_add_form">
                        <div class="form-group text-center">
                            <label for="profile">
                                <div class="profile-preview-container mt-3">
                                    <img id="profilePreview" src="/images/default-profile.jpg"
                                         style="width: 170px; height: 170px; object-fit: cover; border: 1px solid #ddd; border-radius: 50%;"
                                         alt="이미지 미리보기"/>
                                </div>
                            </label>
                            <input type="file" class="form-control" id="profile" name="cwProfileFile" accept="image/*"
                                   hidden="hidden"/>
                        </div>
                        <div class="form-group">
                            <label for="username">아이디</label>
                            <input type="text" class="form-control" id="username" name="cwUsername"
                                   placeholder="아이디를 입력하세요" required>
                            <small id="usernameMessage" class="form-text"></small>
                        </div>
                        <div class="form-group">
                            <label for="password">비밀번호</label>
                            <input type="password" class="form-control" id="password" name="cwPassword"
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
                            <input type="text" class="form-control" id="name" name="cwName" placeholder="이름을 입력하세요"
                                   required>
                        </div>
                        <div class="form-group">
                            <label for="gender">성별</label>
                            <select class="form-control" id="gender" name="cwGender" required>
                                <option value="N">선택</option>
                                <option value="M">남성</option>
                                <option value="F">여성</option>
                            </select>
                        </div>
                        <div class="form-group">
                            <label for="tel">전화번호</label>
                            <input type="text" class="form-control" id="tel" name="cwTel" placeholder="전화번호 입력"
                                   maxlength="11" required>
                            <small id="telMessage" class="form-text"></small>
                        </div>
                        <div class="form-group">
                            <label for="email">이메일</label>
                            <input type="email" class="form-control" id="email" name="cwEmail"
                                   placeholder="이메일을 입력하세요" required>
                            <small id="emailMessage" class="form-text"></small>
                        </div>
                        <div class="form-group">
                            <label for="birthday">생년월일</label>
                            <input type="date" class="form-control" id="birthday" name="cwBirthday" required>
                        </div>
                        <div class="form-group">
                            <label for="holiday">휴무일</label>
                            <select class="form-control" id="holiday" name="cwHoliday" required>
                                <c:forEach var="day" items="${['선택', 'SUNDAY','MONDAY','TUESDAY','WEDNESDAY','THURSDAY','FRIDAY','SATURDAY']}">
                                    <option value="${day}">${day}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="form-group">
                            <label for="experience">경력 (년)</label>
                            <input type="number" class="form-control" id="experience" name="cwExperience" min="0"
                                   placeholder="보호사 경력 (년)" required>
                        </div>
                        <div class="form-group">
                            <label for="intro">소개</label>
                            <textarea class="form-control" id="intro" name="cwIntro" rows="3"
                                      placeholder="자신을 소개해주세요." required></textarea>
                        </div>
                        <div class="form-group">
                            <label for="zipcode">우편번호</label>
                            <div class="input-group">
                                <input type="text" class="form-control" id="zipcode" name="cwZipcode"
                                       placeholder="우편번호를 검색하세요" readonly required>
                                <div class="input-group-append">
                                    <button type="button" class="btn btn-outline-secondary" id="zipcodeBtn">우편번호 검색
                                    </button>
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="streetAddr">주소</label>
                            <input type="text" class="form-control" id="streetAddr" name="cwStreetAddr"
                                   placeholder="주소를 입력하세요" readonly required>
                        </div>
                        <div class="form-group">
                            <label for="detailAddr2">상세주소 1</label>
                            <input type="text" class="form-control" id="detailAddr2" name="cwDetailAddr2"
                                   placeholder="상세주소 1을 입력하세요" readonly required>
                        </div>
                        <div class="form-group">
                            <label for="detailAddr1">상세주소 2</label>
                            <input type="text" class="form-control" id="detailAddr1" name="cwDetailAddr1"
                                   placeholder="상세주소 2를 입력하세요">
                        </div>
                        <input type="hidden" id="latitude" name="cwLatitude">
                        <input type="hidden" id="longitude" name="cwLongitude">
                    </form>
                    <button type="submit" id="btn_add" class="btn btn-primary btn-block border-0">회원가입
                    </button>
                    <div class="mt-3 text-center">
                        <p>이미 계정이 있으신가요? <a href="/login/careworker">로그인</a></p>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
