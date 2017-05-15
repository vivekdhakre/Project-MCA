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
</head>
<body>

<div class="mdl-layout mdl-js-layout mdl-layout--fixed-header">
    <header class="mdl-layout__header">
        <div class="mdl-layout__header-row">
            <!-- Title -->
            <span class="mdl-layout-icon brand-logo pos-left"></span>
            <span class="mdl-layout-title mdl-layout--large-screen-only">
          <small class="mdl-color-text--white">
            Product Sales Dashboard - Login
          </small></span>
            <div class="mdl-layout-spacer"></div>


        </div>
        <!-- Tabs -->
    </header>
    <main class="mdl-layout__content">
        <div class="auto-1000">
            <div class="main-container">
                <div class="report-container">
                    <h2></h2>
                    <div class="select-form">
                        <form action="loginservlet" method="post">
                            <table>
                                <tr>
                                    <td style="width:30%;text-align: left;"><label>User Name</label></td>
                                    <td>
                                        <input type="text" name="username" id="username" placeholder="Enter Username"
                                               required="required">
                                    </td>
                                </tr>
                                <tr>
                                    <td style="width:30%;text-align: left;"><label>Password</label></td>
                                    <td>
                                        <input type="password" name="password" id="password"
                                               placeholder="Enter Password" required="required">
                                    </td>
                                </tr>

                                <tr>
                                    <td colspan="2"><input type="Submit" id="sbmtn" value="Login"></td>
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





















