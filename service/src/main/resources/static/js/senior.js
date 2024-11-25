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
        $('#tel').on('input', () => this.validateTel());

        $('#profile').on('change', (e) => this.previewProfileImage(e.target));

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
        this.validateTel();
        let isNameValid = this.validateName();
        let isAddressValid = this.validateAddress();
        let isBirthdayValid = this.validateBirthday();

        console.log(isNameValid);
        console.log(isAddressValid);
        console.log(isBirthdayValid);

        let isValid = (
            $('#telMessage').hasClass('text-success') &&
            isNameValid &&
            isAddressValid &&
            isBirthdayValid
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
        let form = $('#senior_add_form')[0];
        let formData = new FormData(form);

        $.ajax({
            type: 'POST',
            url: '/api/senior/insert',
            data: formData,
            processData: false,
            contentType: false,
            dataType: 'json',
        }).done(function (resp) {
            if (resp.status === 200 ) {
                alert('시니어 등록이 완료되었습니다.');
                location.href = '/';
            } else {
                console.log(resp.data);
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