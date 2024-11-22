<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style>
    tbody tr td {
        color: black; /* 기본 글자 색상을 검정으로 설정 */
        font-size: 10px; /* 원하는 글자 크기로 조정 */
    }

    tbody tr:hover td {
        color: #3043c7; /* 마우스를 올렸을 때 글자 색상을 파란색으로 설정 */
    }
</style>

<div class="content-body">
    <div class="container-fluid">
        <div class="row">
            <div class="col-lg-6 col-sm-6">
                <div class="card">
                    <div class="card-header">
                        <h4 class="card-title">현재 active/inactive 비율</h4>
                    </div>
                    <div class="card-body">
                        <div id="gauge-chart" class="ct-chart ct-golden-section">
                            <div class="chartist-tooltip" style="top: -38.3999px; left: 342px;"><span
                                    class="chartist-tooltip-value">40</span></div>
                            <svg xmlns:ct="http://gionkunz.github.com/chartist-js/ct" width="100%" height="100%"
                                 class="ct-chart-donut" style="width: 100%; height: 100%;">
                                <g class="ct-series ct-series-a">
                                    <path d="M195.253,72.347A90.6,90.6,0,0,0,177.95,125.6" class="ct-slice-donut"
                                          ct:value="20" style="stroke-width: 60px;"></path>
                                </g>
                                <g class="ct-series ct-series-b">
                                    <path d="M215.297,52.303A90.6,90.6,0,0,0,195.068,72.603" class="ct-slice-donut"
                                          ct:value="10" style="stroke-width: 60px;"></path>
                                </g>
                                <g class="ct-series ct-series-c">
                                    <path d="M296.547,39.434A90.6,90.6,0,0,0,215.041,52.489" class="ct-slice-donut"
                                          ct:value="30" style="stroke-width: 60px;"></path>
                                </g>
                                <g class="ct-series ct-series-d">
                                    <path d="M359.15,125.6A90.6,90.6,0,0,0,296.246,39.337" class="ct-slice-donut"
                                          ct:value="40" style="stroke-width: 60px;"></path>
                                </g>
                            </svg>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-lg-6 col-sm-6">
                <div class="card">
                    <div class="card-header">
                        <h4 class="card-title">최근 1년간 월별 신규 가입자 추이</h4>
                    </div>
                    <div class="card-body">
                        <div id="chart-with-area" class="ct-chart ct-golden-section">
                            <div class="chartist-tooltip" style="top: -43.2px; left: 519px;"><span
                                    class="chartist-tooltip-value">9</span></div>
                            <svg xmlns:ct="http://gionkunz.github.com/chartist-js/ct" width="100%" height="100%"
                                 class="ct-chart-line" style="width: 100%; height: 100%;">
                                <g class="ct-grids">
                                    <line x1="50" x2="50" y1="15" y2="216.1999969482422"
                                          class="ct-grid ct-horizontal"></line>
                                    <line x1="109.01250457763672" x2="109.01250457763672" y1="15" y2="216.1999969482422"
                                          class="ct-grid ct-horizontal"></line>
                                    <line x1="168.02500915527344" x2="168.02500915527344" y1="15" y2="216.1999969482422"
                                          class="ct-grid ct-horizontal"></line>
                                    <line x1="227.03751373291016" x2="227.03751373291016" y1="15" y2="216.1999969482422"
                                          class="ct-grid ct-horizontal"></line>
                                    <line x1="286.0500183105469" x2="286.0500183105469" y1="15" y2="216.1999969482422"
                                          class="ct-grid ct-horizontal"></line>
                                    <line x1="345.0625228881836" x2="345.0625228881836" y1="15" y2="216.1999969482422"
                                          class="ct-grid ct-horizontal"></line>
                                    <line x1="404.0750274658203" x2="404.0750274658203" y1="15" y2="216.1999969482422"
                                          class="ct-grid ct-horizontal"></line>
                                    <line x1="463.08753204345703" x2="463.08753204345703" y1="15" y2="216.1999969482422"
                                          class="ct-grid ct-horizontal"></line>
                                    <line y1="216.1999969482422" y2="216.1999969482422" x1="50" x2="522.1000366210938"
                                          class="ct-grid ct-vertical"></line>
                                    <line y1="193.84444173177084" y2="193.84444173177084" x1="50" x2="522.1000366210938"
                                          class="ct-grid ct-vertical"></line>
                                    <line y1="171.48888651529947" y2="171.48888651529947" x1="50" x2="522.1000366210938"
                                          class="ct-grid ct-vertical"></line>
                                    <line y1="149.13333129882812" y2="149.13333129882812" x1="50" x2="522.1000366210938"
                                          class="ct-grid ct-vertical"></line>
                                    <line y1="126.77777608235677" y2="126.77777608235677" x1="50" x2="522.1000366210938"
                                          class="ct-grid ct-vertical"></line>
                                    <line y1="104.42222086588542" y2="104.42222086588542" x1="50" x2="522.1000366210938"
                                          class="ct-grid ct-vertical"></line>
                                    <line y1="82.06666564941406" y2="82.06666564941406" x1="50" x2="522.1000366210938"
                                          class="ct-grid ct-vertical"></line>
                                    <line y1="59.71111043294272" y2="59.71111043294272" x1="50" x2="522.1000366210938"
                                          class="ct-grid ct-vertical"></line>
                                    <line y1="37.355555216471345" y2="37.355555216471345" x1="50" x2="522.1000366210938"
                                          class="ct-grid ct-vertical"></line>
                                    <line y1="15" y2="15" x1="50" x2="522.1000366210938"
                                          class="ct-grid ct-vertical"></line>
                                </g>
                                <g>
                                    <g class="ct-series ct-series-a">
                                        <path d="M50,216.2L50,104.422C69.671,74.615,89.342,15,109.013,15C128.683,15,148.354,59.711,168.025,59.711C187.696,59.711,207.367,37.356,227.038,37.356C246.708,37.356,266.379,86.538,286.05,104.422C305.721,122.307,325.392,149.133,345.063,149.133C364.733,149.133,384.404,104.422,404.075,104.422C423.746,104.422,443.417,119.326,463.088,126.778L463.088,216.2Z"
                                              class="ct-area"></path>
                                        <path d="M50,104.422C69.671,74.615,89.342,15,109.013,15C128.683,15,148.354,59.711,168.025,59.711C187.696,59.711,207.367,37.356,227.038,37.356C246.708,37.356,266.379,86.538,286.05,104.422C305.721,122.307,325.392,149.133,345.063,149.133C364.733,149.133,384.404,104.422,404.075,104.422C423.746,104.422,443.417,119.326,463.088,126.778"
                                              class="ct-line"></path>
                                        <line x1="50" y1="104.42222086588542" x2="50.01" y2="104.42222086588542"
                                              class="ct-point" ct:value="5"></line>
                                        <line x1="109.01250457763672" y1="15" x2="109.02250457763672" y2="15"
                                              class="ct-point" ct:value="9"></line>
                                        <line x1="168.02500915527344" y1="59.71111043294272" x2="168.03500915527343"
                                              y2="59.71111043294272" class="ct-point" ct:value="7"></line>
                                        <line x1="227.03751373291016" y1="37.355555216471345" x2="227.04751373291015"
                                              y2="37.355555216471345" class="ct-point" ct:value="8"></line>
                                        <line x1="286.0500183105469" y1="104.42222086588542" x2="286.06001831054687"
                                              y2="104.42222086588542" class="ct-point" ct:value="5"></line>
                                        <line x1="345.0625228881836" y1="149.13333129882812" x2="345.0725228881836"
                                              y2="149.13333129882812" class="ct-point" ct:value="3"></line>
                                        <line x1="404.0750274658203" y1="104.42222086588542" x2="404.0850274658203"
                                              y2="104.42222086588542" class="ct-point" ct:value="5"></line>
                                        <line x1="463.08753204345703" y1="126.77777608235677" x2="463.097532043457"
                                              y2="126.77777608235677" class="ct-point" ct:value="4"></line>
                                    </g>
                                </g>
                                <g class="ct-labels">
                                    <foreignObject style="overflow: visible;" x="50" y="221.1999969482422"
                                                   width="59.01250457763672" height="20"><span
                                            class="ct-label ct-horizontal ct-end" xmlns="http://www.w3.org/2000/xmlns/"
                                            style="width: 59px; height: 20px;">1</span></foreignObject>
                                    <foreignObject style="overflow: visible;" x="109.01250457763672"
                                                   y="221.1999969482422" width="59.01250457763672" height="20"><span
                                            class="ct-label ct-horizontal ct-end" xmlns="http://www.w3.org/2000/xmlns/"
                                            style="width: 59px; height: 20px;">2</span></foreignObject>
                                    <foreignObject style="overflow: visible;" x="168.02500915527344"
                                                   y="221.1999969482422" width="59.01250457763672" height="20"><span
                                            class="ct-label ct-horizontal ct-end" xmlns="http://www.w3.org/2000/xmlns/"
                                            style="width: 59px; height: 20px;">3</span></foreignObject>
                                    <foreignObject style="overflow: visible;" x="227.03751373291016"
                                                   y="221.1999969482422" width="59.01250457763672" height="20"><span
                                            class="ct-label ct-horizontal ct-end" xmlns="http://www.w3.org/2000/xmlns/"
                                            style="width: 59px; height: 20px;">4</span></foreignObject>
                                    <foreignObject style="overflow: visible;" x="286.0500183105469"
                                                   y="221.1999969482422" width="59.01250457763672" height="20"><span
                                            class="ct-label ct-horizontal ct-end" xmlns="http://www.w3.org/2000/xmlns/"
                                            style="width: 59px; height: 20px;">5</span></foreignObject>
                                    <foreignObject style="overflow: visible;" x="345.0625228881836"
                                                   y="221.1999969482422" width="59.01250457763672" height="20"><span
                                            class="ct-label ct-horizontal ct-end" xmlns="http://www.w3.org/2000/xmlns/"
                                            style="width: 59px; height: 20px;">6</span></foreignObject>
                                    <foreignObject style="overflow: visible;" x="404.0750274658203"
                                                   y="221.1999969482422" width="59.01250457763672" height="20"><span
                                            class="ct-label ct-horizontal ct-end" xmlns="http://www.w3.org/2000/xmlns/"
                                            style="width: 59px; height: 20px;">7</span></foreignObject>
                                    <foreignObject style="overflow: visible;" x="463.08753204345703"
                                                   y="221.1999969482422" width="59.01250457763672" height="20"><span
                                            class="ct-label ct-horizontal ct-end" xmlns="http://www.w3.org/2000/xmlns/"
                                            style="width: 59px; height: 20px;">8</span></foreignObject>
                                    <foreignObject style="overflow: visible;" y="193.84444173177084" x="10"
                                                   height="22.355555216471355" width="30"><span
                                            class="ct-label ct-vertical ct-start" xmlns="http://www.w3.org/2000/xmlns/"
                                            style="height: 22px; width: 30px;">0</span></foreignObject>
                                    <foreignObject style="overflow: visible;" y="171.4888865152995" x="10"
                                                   height="22.355555216471355" width="30"><span
                                            class="ct-label ct-vertical ct-start" xmlns="http://www.w3.org/2000/xmlns/"
                                            style="height: 22px; width: 30px;">1</span></foreignObject>
                                    <foreignObject style="overflow: visible;" y="149.13333129882812" x="10"
                                                   height="22.355555216471352" width="30"><span
                                            class="ct-label ct-vertical ct-start" xmlns="http://www.w3.org/2000/xmlns/"
                                            style="height: 22px; width: 30px;">2</span></foreignObject>
                                    <foreignObject style="overflow: visible;" y="126.77777608235677" x="10"
                                                   height="22.35555521647136" width="30"><span
                                            class="ct-label ct-vertical ct-start" xmlns="http://www.w3.org/2000/xmlns/"
                                            style="height: 22px; width: 30px;">3</span></foreignObject>
                                    <foreignObject style="overflow: visible;" y="104.42222086588542" x="10"
                                                   height="22.355555216471345" width="30"><span
                                            class="ct-label ct-vertical ct-start" xmlns="http://www.w3.org/2000/xmlns/"
                                            style="height: 22px; width: 30px;">4</span></foreignObject>
                                    <foreignObject style="overflow: visible;" y="82.06666564941406" x="10"
                                                   height="22.35555521647136" width="30"><span
                                            class="ct-label ct-vertical ct-start" xmlns="http://www.w3.org/2000/xmlns/"
                                            style="height: 22px; width: 30px;">5</span></foreignObject>
                                    <foreignObject style="overflow: visible;" y="59.71111043294272" x="10"
                                                   height="22.355555216471345" width="30"><span
                                            class="ct-label ct-vertical ct-start" xmlns="http://www.w3.org/2000/xmlns/"
                                            style="height: 22px; width: 30px;">6</span></foreignObject>
                                    <foreignObject style="overflow: visible;" y="37.355555216471345" x="10"
                                                   height="22.355555216471373" width="30"><span
                                            class="ct-label ct-vertical ct-start" xmlns="http://www.w3.org/2000/xmlns/"
                                            style="height: 22px; width: 30px;">7</span></foreignObject>
                                    <foreignObject style="overflow: visible;" y="15" x="10" height="22.355555216471345"
                                                   width="30"><span class="ct-label ct-vertical ct-start"
                                                                    xmlns="http://www.w3.org/2000/xmlns/"
                                                                    style="height: 22px; width: 30px;">8</span>
                                    </foreignObject>
                                    <foreignObject style="overflow: visible;" y="-15" x="10" height="30" width="30">
                                        <span class="ct-label ct-vertical ct-start"
                                              xmlns="http://www.w3.org/2000/xmlns/"
                                              style="height: 30px; width: 30px;">9</span></foreignObject>
                                </g>
                            </svg>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <h1>User List</h1>
        <div class="col-12">
            <div class="card">
                <div class="card-body">
                    <div class="table-responsive">
                        <table id="example" class="display" style="min-width: 845px">
                            <thead>
                            <tr>
                                <th>ID</th>
                                <th>Username</th>
                                <th>Tel</th>
                                <th>Email</th>
                                <th>Name</th>
                                <th>Zipcode</th>
                                <th>Street</th>
                                <th>Address2</th>
                                <th>Address3</th>
                                <th>Status</th>
                            </tr>
                            </thead>
                            <tbody>
                            <!-- 데이터 행들 -->
                            <c:forEach var="user" items="${user}">
                                <tr onclick="window.location.href='customer-detail?id=${user.userId}'"
                                    style="cursor: pointer;">
                                    <td>${user.userId}</td>
                                    <td>${user.userUsername}</td>
                                    <td>${user.userTel}</td>
                                    <td>${user.userEmail}</td>
                                    <td>${user.userName}</td>
                                    <td>${user.userZipcode}</td>
                                    <td>${user.userStreetAddr}</td>
                                    <td>${user.userDetailAddr1}</td>
                                    <td>${user.userDetailAddr2}</td>
                                    <td>${user.userStatus}</td>
                                </tr>
                            </c:forEach>
                            </tbody>

                            <%--                            <tfoot>--%>
                            <%--                            <tr>--%>
                            <%--                                <th>User ID</th>--%>
                            <%--                                <th>Username</th>--%>
                            <%--                                <th>Password</th>--%>
                            <%--                                <th>Tel</th>--%>
                            <%--                                <th>Email</th>--%>
                            <%--                                <th>Name</th>--%>
                            <%--                                <th>Birthday</th>--%>
                            <%--                                <th>Zipcode</th>--%>
                            <%--                                <th>Address1</th>--%>
                            <%--                                <th>Address2</th>--%>
                            <%--                                <th>Address3</th>--%>
                            <%--                                <th>Registration Date</th>--%>
                            <%--                                <th>Status</th>--%>
                            <%--                                <th>Profile</th>--%>
                            <%--                            </tr>--%>
                            <%--                            </tfoot>--%>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Required vendors -->
<script src="./vendor/global/global.min.js"></script>
<script src="./js/quixnav-init.js"></script>
<script src="./js/custom.min.js"></script>

<!-- Datatable -->
<script src="./vendor/datatables/js/jquery.dataTables.min.js"></script>
<script src="./js/plugins-init/datatables.init.js"></script>
