<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

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

    textarea {
        width: 100%;
        resize: none; /* 사용자가 크기를 조정하지 못하도록 설정 (원하면 제거 가능) */
        display: block;
    }
</style>
<div class="container signup-container" style="margin-top: 5rem">
    <div class="row justify-content-center mt-5" style="margin-bottom: 6rem">
        <div class="col-md-6">
            <div class="card border-0">
                <div class="card-body">
                    <h3 class="card-title text-center mb-4">시니어 등록</h3>
                    <form id="senior_add_form">
                        <div class="form-group text-center">
                            <label for="profile">
                                <div class="profile-preview-container mt-3">
                                    <img id="profilePreview" src="/images/default-profile.jpg"
                                         style="width: 170px; height: 170px; object-fit: cover; border: 1px solid #ddd; border-radius: 50%;"
                                         alt="이미지 미리보기"/>
                                </div>
                            </label>
                            <input type="file" class="form-control" id="profile" name="seniorProfileFile"
                                   accept="image/*"
                                   hidden="hidden"/>
                        </div>
                        <div class="form-group">
                            <label for="name">이름</label>
                            <input type="text" class="form-control" id="name" name="seniorName"
                                   placeholder="이름을 입력하세요." required>
                        </div>
                        <div class="form-group">
                            <label for="gender">성별:</label>
                            <select class="form-control" id="gender" name="seniorGender">
                                <option value="M">남성</option>
                                <option value="F">여성</option>
                            </select>
                        </div>
                        <div class="form-group">
                            <label for="tel">전화번호</label>
                            <input type="text" class="form-control" id="tel" name="seniorTel" placeholder="전화번호 입력"
                                   maxlength="11" required>
                            <small id="telMessage" class="form-text"></small>
                        </div>
                        <div class="form-group">
                            <label for="birthday">생년월일</label>
                            <input type="date" class="form-control" id="birthday" name="seniorBirth">
                        </div>
                        <div class="form-group">
                            <label for="zipcode">우편번호</label>
                            <div class="input-group">
                                <input type="text" class="form-control" id="zipcode" name="seniorZipcode"
                                       placeholder="우편번호를 검색하세요" readonly required>
                                <div class="input-group-append">
                                    <button type="button" class="btn btn-outline-secondary" id="zipcodeBtn">우편번호 검색
                                    </button>
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="streetAddr">도로명 주소</label>
                            <input type="text" class="form-control" id="streetAddr" name="seniorStreetAddr"
                                   placeholder="주소를 입력하세요" readonly required>
                        </div>
                        <div class="form-group">
                            <label for="detailAddr2">상세주소 1</label>
                            <input type="text" class="form-control" id="detailAddr2" name="seniorDetailAddr2"
                                   placeholder="상세주소 1을 입력하세요" readonly required>
                        </div>
                        <div class="form-group">
                            <label for="detailAddr1">상세주소 2</label>
                            <input type="text" class="form-control" id="detailAddr1" name="seniorDetailAddr1"
                                   placeholder="상세주소 2를 입력하세요">
                        </div>
                        <div class="form-group">
                            <label for="significant">중요 사항</label>
                            <textarea id="significant" name="seniorSignificant" rows="3"
                                      placeholder="중요 사항을 입력하세요"></textarea>
                        </div>
                        <input type="hidden" id="latitude" name="seniorLatitude">
                        <input type="hidden" id="longitude" name="seniorLongitude">
                        <input type="hidden" name="userId" value="${sessionScope.principal}">
                    </form>
                    <button type="submit" id="btn_add" class="btn btn-primary btn-block border-0">등록하기
                    </button>
                </div>
            </div>
        </div>
    </div>
</div>
<script src="/js/senior.js"></script>
