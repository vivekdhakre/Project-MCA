<%@ page import="java.sql.ResultSet" %>
<!DOCTYPE html>
<html lang="en" ng-app="Dashboard">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width">
    <title>Campaign Report</title>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/chart/css/style.css" type="text/css">
    <link type="text/css" rel="stylesheet" href="<%=request.getContextPath()%>/chart/css/material.css">


    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/style.css">
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/font-awesome.css">
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/font-awesome.min.css">
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/bootstrap.min.css" media="screen">

    <script src="<%=request.getContextPath()%>/js/jquery-1.10.2.js"></script>
    <%--<script src="<%=request.getContextPath()%>/js/jquery-ui.js"></script>--%>
    <%--<script src="<%=request.getContextPath()%>/js/jquery-ui-1.10.0.custom.js"></script>--%>
    <script type="text/javascript" src="<%=request.getContextPath()%>/chart/js/material.js"></script>
    <%--<script src="<%=request.getContextPath()%>/chart/js/jquery-2.2.2.min.js"></script>--%>


    <script>

        $(function () {

            $("#from").datepicker({
                defaultDate: "+1w",
                changeMonth: true,
                numberOfMonths: 1,
                onClose: function (selectedDate) {
                    $("#to").datepicker("option", "minDate", selectedDate);
                }
            });

            $("#to").datepicker({
                defaultDate: "+1w",
                changeMonth: true,
                numberOfMonths: 1,
                onClose: function (selectedDate) {
                    $("#from").datepicker("option", "maxDate", selectedDate);
                }
            });
        });

    </script>

</head>
<body>

<div class="mdl-layout mdl-js-layout mdl-layout--fixed-header">
    <header class="mdl-layout__header">
        <div class="mdl-layout__header-row">
            <!-- Title -->
            <span class="mdl-layout-icon brand-logo pos-left"></span>
            <span class="mdl-layout-title mdl-layout--large-screen-only">
					<small class="mdl-color-text--white">
						Select Date Range for Stats
					</small></span>
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
    <main class="mdl-layout__content">
        <div class="auto-1000">
            <div class="main-container">
                <div class="report-container">
                    <h2></h2>
                    <div class="select-form">
                        <form action="view" method="post">
                            <table>
                                <tr>
                                    <td>From Date</td>
                                    <td><input type="text" name="from" id="from"
                                               style="background:#fff url(<%=request.getContextPath()%>/images/cal.png) no-repeat right 50%">
                                    </td>
                                </tr>
                                <tr>
                                    <td>to Date</td>
                                    <td><input type="text" name="to" id="to"
                                               style="background:#fff url(<%=request.getContextPath()%>/images/cal.png) no-repeat right 50%">
                                    </td>
                                </tr>

                                <tr>
                                    <td>Campaign</td>
                                    <td>
                                        <select name="channelid" id="channelid" style="background: white;">
                                            <option value="-1">--Please Select--</option>
                                            <% ResultSet rst = (ResultSet) request.getAttribute("rst");
                                                while (rst.next()) {
                                            %>
                                            <option value="<%=rst.getLong(1)%>"><%=rst.getString(2)%>
                                            </option>
                                            <%}%>
                                        </select>
                                    </td>
                                </tr>

                                <tr>
                                    <td colspan="2"><input type="Submit" id="sbmtn" value="Show Report"></td>
                                </tr>

                            </table>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </main>
</div>
</body>
</html>

