<!DOCTYPE html>
<html lang="en" ng-app="Dashboard">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width">
    <title>Campaign Report</title>
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
            <span class="mdl-layout-icon brand-logo pos-left"></span>
            <span class="mdl-layout-title mdl-layout--large-screen-only">
					<small class="mdl-color-text--white">
						Stats Datewise and Citywise
					</small>
            </span>
            <div class="mdl-layout-spacer"></div>

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
                </div>
                <div class="mdl-cell mdl-cell--6-col mdl-cell--6-col-desktop mdl-cell--12-col-phone mdl-cell--4-col-tablet demo-card-square mdl-card mdl-shadow--2dp">
                    <div class="mdl-card__supporting-text">
                        <div id="citywise_stats"
                             style="width: 100%; min-width: 250px; max-width: 600px; height: 400px; margin: 0 auto"></div>
                    </div>
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

        var genJson = <%=request.getAttribute("dateWiseMap")%>;

        console.log(genJson);

        $('#datewise_stats').highcharts({
            chart: {
                type: 'column'
            },
            title: {
                text: 'Coupon Generation Date Wise'
            },
            credits: {
                enabled: false,
                text: '',
                href: ''
            },
            colors: ['rgb(63,81,181)', '#FF1744'],
            xAxis: {
                categories: Object.keys(genJson),
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
            series: [{
                name: 'Datewise States',
                data: Object.values(genJson)

            }]
        });
    });


    $(function () {

        var genJson = <%=request.getAttribute("cityWiseMap")%>;

        console.log(genJson);

        $('#citywise_stats').highcharts({
            chart: {
                type: 'column'
            },
            title: {
                text: 'Coupon Generation Date Wise'
            },
            credits: {
                enabled: false,
                text: '',
                href: ''
            },
            colors: ['#FF1744'],
            xAxis: {
                categories: Object.keys(genJson),
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
            series: [{
                name: 'Citywise States',
                data: Object.values(genJson)

            }]
        });
    });

</script>
</body>
</html>