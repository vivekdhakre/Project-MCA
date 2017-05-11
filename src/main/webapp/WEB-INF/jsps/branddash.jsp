<!DOCTYPE html>
<html lang="en" ng-app="Dashboard">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width">
    <title>Campaign Report</title>
    <link rel="stylesheet" href="chart/css/style.css" type="text/css">
    <link type="text/css" rel="stylesheet" href="chart/css/material.css">
    <script type="text/javascript" src="chart/js/material.js"></script>
    <script src="chart/js/jquery-2.2.2.min.js"></script>

</head>
<body>

<%
    String role = String.valueOf(session.getAttribute("role"));
    String cid = String.valueOf(session.getAttribute("cid"));

    if (role != null && !"".equals(role.trim()) && role.trim().equalsIgnoreCase("brand")
            && cid != null && cid.trim().matches("[0-9]+")) {


%>

<!-- Simple header with scrollable tabs. -->
<div class="mdl-layout mdl-js-layout mdl-layout--fixed-header">
    <header class="mdl-layout__header">
        <div class="mdl-layout__header-row">
            <!-- Title -->
            <span class="mdl-layout-icon"><a id="logo-container" href="#" class="brand-logo pos-left"><img width=""
                                                                                                           src="chart/images/icons/ic_launcher.png"
                                                                                                           alt="brand-logo"></a></span>
            <span class="mdl-layout-title mdl-layout--large-screen-only"><small class="mdl-color-text--white">Campaign Report -<%=session.getAttribute("productname") %></small></span>
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
            <div class="mdl-grid">
                <div class="mdl-cell mdl-cell--6-col mdl-cell--6-col-desktop mdl-cell--12-col-phone mdl-cell--4-col-tablet demo-card-square mdl-card mdl-shadow--2dp">
                    <div class="mdl-card__supporting-text">
                        <!--<div id="TajMahalCouponGenerated" style="width: 100%; min-width: 250px; max-width: 600px; margin: 0 auto"></div>-->
                        <div id="generation"
                             style="width: 100%; min-width: 250px; max-width: 600px; margin: 0 auto"></div>
                    </div>
                </div>
                <div class="mdl-cell mdl-cell--6-col mdl-cell--6-col-desktop mdl-cell--12-col-phone mdl-cell--4-col-tablet demo-card-square mdl-card mdl-shadow--2dp">
                    <div class="mdl-card__supporting-text">
                        <div id="Redemption"
                             style="width: 100%; min-width: 250px; max-width: 600px; height: 400px; margin: 0 auto"></div>
                    </div>
                </div>
                <div class="mdl-cell mdl-cell--6-col mdl-cell--6-col-desktop mdl-cell--12-col-phone mdl-cell--4-col-tablet demo-card-square mdl-card mdl-shadow--2dp">
                    <div class="mdl-card__supporting-text">
                        <div id="citywiseRedemptionDiv"
                             style="width: 100%; min-width: 250px; height: 400px; margin: 0 auto"></div>
                    </div>
                </div>
                <div class="mdl-cell mdl-cell--6-col mdl-cell--6-col-desktop mdl-cell--12-col-phone mdl-cell--4-col-tablet demo-card-square mdl-card mdl-shadow--2dp">
                    <div class="mdl-card__supporting-text">
                        <div id="topStoresRedemptionDiv"
                             style="width: 100%; min-width: 250px; height: 400px; margin: 0 auto"></div>
                    </div>
                </div>
            </div>
        </section>
    </main>
</div>

<script src="chart/js/highcharts.js"></script>
<script src="chart/js/modules/data.js"></script>
<script src="chart/js/modules/drilldown.js"></script>

<script type="text/javascript">


    $(function () {

        var genJson = <%=session.getAttribute("genCount")%>;

        $('#generation').highcharts({
            chart: {
                type: 'column'
            },
            title: {
                text: 'Coupon Generation Date Wise'
            },
            credits: {
                enabled: false,
                text: 'Ahoy Telecom Pvt.Ltd.',
                href: 'http://www.ahoy.co.in'
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
                name: 'Coupon Generated',
                data: Object.values(genJson)

            }]
        });
    });

    $(function () {

        var rdmDateJson = <%=session.getAttribute("redeemDates")%>;
        var rdmJson = <%=session.getAttribute("rdmSeries")%>;


        $('#Redemption').highcharts({
            chart: {
                type: 'column'
            },
            title: {
                text: '# of Redemption - Date Wise'
            },
            credits: {
                enabled: false,
                text: 'Ahoy Telecom Pvt.Ltd.',
                href: 'http://www.ahoy.co.in'
            },
            colors: ['#FF1744', 'green'],
            xAxis: {
                categories: rdmDateJson,
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
            series: rdmJson
        });
    });


    $(function () {
        $('#topStoresRedemptionDiv').highcharts({
            chart: {
                type: 'bar'
            },
            title: {
                text: '# of Redemption - Top Stores'
            },
            credits: {
                enabled: false,
                text: 'Ahoy Telecom Pvt.Ltd.',
                href: 'http://www.ahoy.co.in'
            },
            colors: ['#009688'],
            xAxis: {
                categories: <%=session.getAttribute("storeCodeList")%>
            },
            yAxis: {
                min: 0,
                title: {
                    text: 'Top Stores Redemption'
                }
            },
            tooltip: {
                pointFormat: '<b>{point.name}: {point.y}</b>'
            },
            legend: {
                reversed: true
            },
            plotOptions: {
                series: {
                    stacking: 'normal'
                }
            },
            series: [{
                name: 'Top Redemption',
                data: <%=session.getAttribute("storeCodeCountList")%>
            }]
        });
    });


    $(function () {
        var cityWiseListJson = <%=session.getAttribute("cityWiseList")%>;


        var defaultTitle = "# of Redemption - Citywise";
        // var drilldownTitlePrefix = "Campaign - Base Targeting in ";
        // var drilldownTitleSuffix = " (1st Jul 2016 - 29th Aug 2016)";
        // Create the chart
        var chart = new Highcharts.Chart({
            chart: {
                type: 'pie',
                backgroundColor: 'transparent',
                renderTo: 'citywiseRedemptionDiv',
                events: {
                    drilldown: function (e) {
                        chart.setTitle({text: defaultTitle});
                    },
                    drillup: function (e) {
                        chart.setTitle({text: defaultTitle});
                    }
                }
            },
            credits: {
                enabled: false,
                text: 'Ahoy Telecom Pvt.Ltd.',
                href: 'http://www.ahoy.co.in'
            },
            colors: ['#8BC34A', '#673AB7', '#009688', '#FF1744', '#3F51B5', '#2196F3', '#03A9F4', '#00BCD4', '#009688', '#4CAF50', '#8BC34A', '#CDDC39', '#FFEB3B', '#FFC107', '#FF9800', '#FF5722', '#795548', '#607D8B'],
            title: {
                text: defaultTitle
            },
            xAxis: {
                type: 'category'
            },

            legend: {
                enabled: false
            },

            plotOptions: {
                series: {
                    borderWidth: 0,
                    dataLabels: {
                        enabled: true
                    }
                }
            },
            tooltip: {
                formatter: function () {
                    return '<b>' + this.series.name + ': </b>' + this.series.name;
                }
            },

            series: [{
                name: 'Redemption',
                colorByPoint: true,
                data: cityWiseListJson
            }],


        });
    });

</script>

<% } else {
    response.sendRedirect("login.jsp");
}
%>
</body>
</html>