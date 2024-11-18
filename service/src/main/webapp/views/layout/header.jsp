<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <title>seniorCare</title>
    <meta charset="utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no"/>
    <link rel="stylesheet" type="text/css"
          href="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/assets/owl.carousel.min.css"/>
    <link rel="stylesheet" type="text/css" href="css/bootstrap.css"/>
    <link href="css/font-awesome.min.css" rel="stylesheet"/>
    <link href="https://fonts.googleapis.com/css?family=Open+Sans:400,700|Poppins:400,500,700&display=swap"
          rel="stylesheet"/>
    <link href="css/style.css" rel="stylesheet"/>
    <link href="css/responsive.css" rel="stylesheet"/>
</head>
<body>
<div class="hero_area">
    <header class="header_section">
        <div class="container-fluid">
            <nav class="navbar navbar-expand-lg custom_nav-container">
                <a class="navbar-brand" href="/">
                    <span>Senior Care</span>
                </a>
                <div class="user_option">
                    <%-- 고객 메뉴 --%>
                    <c:if test="${sessionScope.role == 'CUSTOMER'}">
                        <a href="/choice">보호사 신청</a>
                        <a href="/senior-health">시니어 건강</a>
                        <a href="/schedule">일정관리</a>
                        <a href="/help">문의</a>
                        <a href="/cmypage">마이페이지</a>
                    </c:if>

                    <%-- 보호사 메뉴 --%>
                    <c:if test="${sessionScope.role == 'CAREWORKER'}">
                        <a href="/senior-list">시니어 리스트</a>
                        <a href="/contact">계약관리</a>
                        <a href="/cwschedule">일정관리</a>
                        <a href="/cwmypage">마이페이지</a>
                    </c:if>

                    <!-- 로그인/로그아웃 -->
                    <c:choose>
                        <c:when test="${not empty sessionScope.principal}">
                            <a href="/logout"><span>로그아웃</span>
                                <i class="fa fa-user" aria-hidden="true"></i>
                            </a>
                        </c:when>
                        <c:otherwise>
                            <a href="/login"><span>로그인</span>
                            </a>
                            <a href="/signup"><span>회원가입</span>
                            </a>
                        </c:otherwise>
                    </c:choose>
                </div>
            </nav>
        </div>
    </header>
</div>
