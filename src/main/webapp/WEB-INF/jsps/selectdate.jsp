<%@ page import="java.sql.ResultSet" %>
<!DOCTYPE html>
<html lang="en" ng-app="Dashboard">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width">
    <title>Product Sales Dashboard</title>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/chart/css/style.css" type="text/css">
    <link type="text/css" rel="stylesheet" href="<%=request.getContextPath()%>/chart/css/material.css">
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/style.css">
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/font-awesome.css">
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/font-awesome.min.css">
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/bootstrap.min.css" media="screen">

    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/bootstrap-datepicker.css"
          media="screen">

    <script src="<%=request.getContextPath()%>/js/jquery-1.10.2.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/chart/js/material.js"></script>

    <script type="text/javascript" src="<%=request.getContextPath()%>/js/bootstrap-datepicker.js"></script>

    <script>

        $(document).ready(function () {
            $('#sbmtn').click(function () {

                var from = $("#from").val();
                if (from == '') {
                    alert("Please Enter From Date");
                    $("#from").focus();
                    return false;
                }

                var to = $("#to").val();
                if (from == '') {
                    alert("Please Enter To Date");
                    $("#to").focus();
                    return false;
                }

                var pid = $("#pid").val();
                if (pid == '-1') {
                    alert("Please Select Product");
                    $("#pid").focus();
                    return false;
                }

                return true;
            });
        });



        $(function () {
            $("#from").datepicker({
                endDate: "today",
                changeMonth: true,
                numberOfMonths: 1,
                autoclose: true,
                todayHighlight: true
            }).on('changeDate', function () {
                var selectedFdate = new Date($(this).val());
                var endDate = new Date(selectedFdate.setDate(selectedFdate.getDate() + 14));
                $('#to').datepicker('setStartDate', new Date($(this).val()));
                var endDate = new Date() > endDate ? endDate : new Date($(this).val());
                $('#to').datepicker('setEndDate', endDate);
            });

            $("#to").datepicker({
                endDate: "today",
                changeMonth: true,
                numberOfMonths: 1,
                autoclose: true,
                todayHighlight: true
            }).on('changeDate', function () {
                $('#from').datepicker('setEndDate', new Date($(this).val()));
                var selectedTdate = new Date($(this).val());
                var startDate = new Date(selectedTdate.setDate(selectedTdate.getDate() - 14));
                $('#from').datepicker('setStartDate', startDate);

            });
        });

    </script>

</head>
<body>

<div class="mdl-layout mdl-js-layout mdl-layout--fixed-header">
    <header class="mdl-layout__header">
        <div class="mdl-layout__header-row">
            <!-- Title -->
            <span class="mdl-layout-title mdl-layout--large-screen-only">
				<small class="mdl-color-text--white">
					Select Date Range for Stats
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
                <li class="mdl-menu__item" onclick="location.href='home'">Home</li>
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
                        <form action="stats" method="post">
                            <table>
                                <tr>
                                    <td style="width:30%;text-align: left;"><label>From Date</label></td>
                                    <td><input type="text" name="from" id="from"
                                               style="background:#fff url(<%=request.getContextPath()%>/images/cal.png) no-repeat right 50%"
                                               readonly>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="width:30%;text-align: left;"><label>To Date</label></td>
                                    <td><input type="text" name="to" id="to"
                                               style="background:#fff url(<%=request.getContextPath()%>/images/cal.png) no-repeat right 50%"
                                               readonly>
                                    </td>
                                </tr>

                                <tr>
                                    <td style="width:30%;text-align: left;"><label>Product</label></td>
                                    <td>
                                        <select name="pid" id="pid" style="background: white;">
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