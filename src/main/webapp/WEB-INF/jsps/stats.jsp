<%@ page import="edu.mca.util.Response" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<!DOCTYPE html>
<html lang="en" ng-app="Dashboard">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width">
    <title>Product Sales Dashboard</title>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/chart/css/style.css" type="text/css">
    <link type="text/css" rel="stylesheet" href="<%=request.getContextPath()%>/chart/css/material.css">
    <script type="text/javascript" src="<%=request.getContextPath()%>/chart/js/material.js"></script>
    <script src="<%=request.getContextPath()%>/chart/js/jquery-2.2.2.min.js"></script>

</head>
<body>
<!-- Simple header with scrollable tabs. -->
<div class="mdl-layout mdl-js-layout mdl-layout--fixed-header">
    <header class="mdl-layout__header">
        <div class="mdl-layout__header-row">
            <!-- Title -->
            <span class="mdl-layout-title mdl-layout--large-screen-only">
					<small class="mdl-color-text--white">
						${campaignName} - Stats Datewise and Citywise
					</small>
            </span>
            <div class="mdl-layout-spacer"></div>
            <span class="mdl-layout-icon brand-logo pos-left"><img
                    src="<%=request.getContextPath()%>/images/home-logo.jpg" onclick="location.href='home'"></span>

            <button id="demo-menu-lower-right"
                    class="mdl-button mdl-js-button mdl-button--icon">
                <i class="material-icons">more_vert</i>
            </button>

            <ul class="mdl-menu mdl-menu--bottom-right mdl-js-menu mdl-js-ripple-effect"
                for="demo-menu-lower-right">
                <li class="mdl-menu__item" onclick="location.href='logout'">Log Out</li>
            </ul>
        </div>
        <!-- Tabs -->
    </header>
    <!-- <div class="mdl-layout__drawer">
        <span class="mdl-layout-title">Title</span>
        <nav class="mdl-navigation">
            <a class="mdl-navigation__link" href="index.html">Campaign Name</a>

        </nav>
    </div> -->
    <main class="mdl-layout__content">
        <section ng-controller="CampaignController">
            <div class="mdl-grid" style="margin-top: 50px;">
                <div class="mdl-cell mdl-cell--6-col mdl-cell--6-col-desktop mdl-cell--12-col-phone mdl-cell--4-col-tablet demo-card-square mdl-card mdl-shadow--2dp">
                    <div class="mdl-card__supporting-text">
                        <!--<div id="TajMahalCouponGenerated" style="width: 100%; min-width: 250px; max-width: 600px; margin: 0 auto"></div>-->
                        <div id="datewise_stats"
                             style="width: 100%; min-width: 250px; max-width: 600px; margin: 0 auto"></div>
                    </div>


                    <table class="mdl-data-table mdl-js-data-table" width="100%">
                        <thead>
                        <tr>
                            <th class="mdl-data-table__cell--non-numeric">Date</th>
                            <th class="mdl-data-table__cell--non-numeric">Store</th>
                            <th class="mdl-data-table__cell--non-numeric">No of User</th>
                            <th class="mdl-data-table__cell--non-numeric">Product Count</th>
                        </tr>
                        </thead>
                        <tbody>
                        <%
                            Map<String, List<Response>> dateWiseTableMap = (Map<String, List<Response>>) request.getAttribute("dateWiseTableMap");

                            for (Map.Entry<String, List<Response>> map : dateWiseTableMap.entrySet()) {
                        %>
                        <tr>
                            <td class="mdl-data-table__cell--non-numeric"
                                rowspan="<%=map.getValue().size()%>"><%=map.getKey()%>
                            </td>
                            <td class="mdl-data-table__cell--non-numeric"><%=map.getValue().get(0).getStoreName()%>
                            </td>
                            <td class="mdl-data-table__cell--non-numeric"><%=map.getValue().get(0).getCount()%>
                            </td>

                            <td class="mdl-data-table__cell--non-numeric"><%=map.getValue().get(0).getSum()%>
                            </td>
                        </tr>
                        <%
                            for (int i = 1; i < map.getValue().size(); i++) {
                        %>
                        <tr>
                            <td class="mdl-data-table__cell--non-numeric"><%=map.getValue().get(i).getStoreName()%>
                            </td>
                            <td class="mdl-data-table__cell--non-numeric"><%=map.getValue().get(i).getCount()%>
                            </td>
                            <td class="mdl-data-table__cell--non-numeric"><%=map.getValue().get(i).getSum()%>
                            </td>
                        </tr>
                        <%}%>
                        <%
                            }
                        %>

                        </tbody>
                    </table>


                </div>
                <div class="mdl-cell mdl-cell--6-col mdl-cell--6-col-desktop mdl-cell--12-col-phone mdl-cell--4-col-tablet demo-card-square mdl-card mdl-shadow--2dp">
                    <div class="mdl-card__supporting-text">
                        <div id="citywise_stats"
                             style="width: 100%; min-width: 250px; max-width: 600px; height: 400px; margin: 0 auto"></div>
                    </div>


                    <table class="mdl-data-table mdl-js-data-table" width="100%">
                        <thead>
                        <tr>
                            <th class="mdl-data-table__cell--non-numeric">Date</th>
                            <th class="mdl-data-table__cell--non-numeric">Store</th>
                            <th class="mdl-data-table__cell--non-numeric">No of User</th>
                            <th class="mdl-data-table__cell--non-numeric">Product Count</th>
                        </tr>
                        </thead>
                        <tbody>
                        <%
                            Map<String, List<Response>> cityWiseTableMap = (Map<String, List<Response>>) request.getAttribute("cityWiseTableMap");

                            for (Map.Entry<String, List<Response>> map : cityWiseTableMap.entrySet()) {
                        %>
                        <tr>
                            <td class="mdl-data-table__cell--non-numeric"
                                rowspan="<%=map.getValue().size()%>"><%=map.getKey()%>
                            </td>
                            <td class="mdl-data-table__cell--non-numeric"><%=map.getValue().get(0).getStoreName()%>
                            </td>
                            <td class="mdl-data-table__cell--non-numeric"><%=map.getValue().get(0).getCount()%>
                            </td>

                            <td class="mdl-data-table__cell--non-numeric"><%=map.getValue().get(0).getSum()%>
                            </td>
                        </tr>
                        <%
                            for (int i = 1; i < map.getValue().size(); i++) {
                        %>
                        <tr>
                            <td class="mdl-data-table__cell--non-numeric"><%=map.getValue().get(i).getStoreName()%>
                            </td>
                            <td class="mdl-data-table__cell--non-numeric"><%=map.getValue().get(i).getCount()%>
                            </td>
                            <td class="mdl-data-table__cell--non-numeric"><%=map.getValue().get(i).getSum()%>
                            </td>
                        </tr>
                        <%}%>
                        <%
                            }
                        %>

                        </tbody>
                    </table>
                </div>


            </div>
        </section>
    </main>
</div>

<script src="<%=request.getContextPath()%>/chart/js/highcharts.js"></script>
<script src="<%=request.getContextPath()%>/chart/js/modules/data.js"></script>
<script src="<%=request.getContextPath()%>/chart/js/modules/drilldown.js"></script>

<script type="text/javascript">


    $(function () {

        var datewiseKeys = <%=request.getAttribute("datewiseKeys")%>;
        var datewiseValues = <%=request.getAttribute("datewiseValues")%>;


        $('#datewise_stats').highcharts({
            chart: {
                type: 'column'
            },
            title: {
                text: '${campaignName} Stats - Datewise'
            },
            credits: {
                enabled: false,
                text: '',
                href: ''
            },
            colors: ['#8BC34A', '#673AB7', '#009688', '#FF1744', '#3F51B5', '#2196F3', '#03A9F4', '#00BCD4', '#009688', '#4CAF50', '#8BC34A', '#CDDC39', '#FFEB3B', '#FFC107', '#FF9800', '#FF5722', '#795548', '#607D8B'],
            xAxis: {
                categories: datewiseKeys,
                labels: {
                    rotation: -90
                },
                crosshair: true
            },
            yAxis: {
                min: 0,
                title: {
                    text: ''
                }
            },
            tooltip: {
                headerFormat: '<span style="font-size:10px">{point.key}</span><table>',
                pointFormat: '<tr><td style="color:{series.color};padding:0">{series.name}: </td>' +
                '<td style="padding:0"><b>{point.y}</b></td></tr>',
                footerFormat: '</table>',
                shared: true,
                useHTML: true
            },
            plotOptions: {
                column: {
                    pointPadding: 0.2,
                    borderWidth: 0
                }
            },
            series: datewiseValues
        });
    });


    $(function () {

        var citywiseKeys = <%=request.getAttribute("citywiseKeys")%>;
        var citywiseValues = <%=request.getAttribute("citywiseValues")%>;

        $('#citywise_stats').highcharts({
            chart: {
                type: 'column'
            },
            title: {
                text: '${campaignName} Stats - Citywise'
            },
            credits: {
                enabled: false,
                text: '',
                href: ''
            },
            colors: ['#2196F3', '#03A9F4', '#00BCD4', '#009688', '#4CAF50', '#8BC34A', '#CDDC39', '#FFEB3B', '#FFC107', '#FF9800', '#FF5722', '#795548', '#607D8B'],
            xAxis: {
                categories: citywiseKeys,
                labels: {
                    rotation: -90
                },
                crosshair: true
            },
            yAxis: {
                min: 0,
                title: {
                    text: ''
                }
            },
            tooltip: {
                headerFormat: '<span style="font-size:10px">{point.key}</span><table>',
                pointFormat: '<tr><td style="color:{series.color};padding:0">{series.name}: </td>' +
                '<td style="padding:0"><b>{point.y}</b></td></tr>',
                footerFormat: '</table>',
                shared: true,
                useHTML: true
            },
            plotOptions: {
                column: {
                    pointPadding: 0.2,
                    borderWidth: 0
                }
            },
            series: citywiseValues
        });
    });

</script>
</body>
</html>