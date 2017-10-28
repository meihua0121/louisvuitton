<!DOCTYPE html>
<%@page import="entity.EncryptDecrypt, entity.User, dao.EncryptDecryptDAO, dao.EventsDAO, entity.Orders, java.util.*,java.text.*, dao.AnalyticsDAO"%>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <title>Louis Vuitton - Facilitating Communications</title>
        <link rel="shortcut icon" type="image/x-icon" href="image/LV_logo.jpg" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta name="description" content="">
        <meta name="author" content="">

        <!-- Bootstrap core CSS -->
        <link href="twitterBootstrap/bootstrap/css/bootstrap.min.css" rel="stylesheet">

        <!-- Font Awesome -->
        <link href="twitterBootstrap/css/font-awesome.min.css" rel="stylesheet">

        <!-- ionicons -->
        <link href="twitterBootstrap/css/ionicons.min.css" rel="stylesheet">

        <!-- Animate -->
        <link href="twitterBootstrap/css/animate.min.css" rel="stylesheet">

        <!-- Owl Carousel -->
        <link href="twitterBootstrap/css/owl.carousel.min.css" rel="stylesheet">
        <link href="twitterBootstrap/css/owl.theme.default.min.css" rel="stylesheet">

        <!-- Slider -->
        <link href="twitterBootstrap/css/bootstrap-slider.css" rel="stylesheet"/>

        <!-- Tag Input -->
        <link href="twitterBootstrap/css/jquery.tagsinput.css" rel="stylesheet">

        <!-- Date Time Picker -->
        <link href="twitterBootstrap/css/datetimepicker.css" rel="stylesheet">

        <!-- Select2 -->
        <link href="twitterBootstrap/css/select2/select2.css" rel="stylesheet"/>	

        <!-- Simplify -->
        <link href="twitterBootstrap/css/simplify.min.css" rel="stylesheet">

        <!--datatable-->
        <link href="twitterBootstrap/css/dataTables.bootstrap.css" rel="stylesheet">


        <style>
            * {
                border-radius: 0 !important;
            }
        </style>


        <%
            Object javaObject = session.getAttribute("supplychain");
            User user = null;
            String nameOfUser = "";
            if (javaObject == null) {
                response.sendRedirect("login.jsp");
            } else {
                user = (User) javaObject;
                nameOfUser = user.getUserName();
            }

            AnalyticsDAO analyticsEngine = new AnalyticsDAO();

            //Priority level of events
            int numOfHighPriorityEvents = analyticsEngine.returnNumOfPriorityEvents("High");
            int numOfMediumPriorityEvents = analyticsEngine.returnNumOfPriorityEvents("Medium");
            int numOfLowPriorityEvents = analyticsEngine.returnNumOfPriorityEvents("Low");

            //Priority level of orders
            int numOfHighPriorityOrders = analyticsEngine.returnNumOfPriorityOrders("High");
            int numOfMediumPriorityOrders = analyticsEngine.returnNumOfPriorityOrders("Medium");
            int numOfLowPriorityOrders = analyticsEngine.returnNumOfPriorityOrders("Low");

            //Priority level of tasks
            int numOfHighPriorityTasks = analyticsEngine.returnNumOfPriorityTasks("High");
            int numOfMediumPriorityTasks = analyticsEngine.returnNumOfPriorityTasks("Medium");
            int numOfLowPriorityTasks = analyticsEngine.returnNumOfPriorityTasks("Low");

            //Number of orders
            int numOfGoodProgressOrders = analyticsEngine.returnNumOfMediumProgressOrders("61", "100");
            int numOfMediumProgressOrders = analyticsEngine.returnNumOfMediumProgressOrders("31", "60");
            int numOfPoorProgressOrders = analyticsEngine.returnNumOfPoorProgressOrders();

            List<List<Orders>> upcomingOrdersList = analyticsEngine.returnNumberOfOrdersDueXDays(15);
            List<List<Orders>> overdueOrdersList = analyticsEngine.returnNumberOfOrdersXDaysFromNow(15);
            List<Orders> allOverduedOrders = analyticsEngine.returnAllOverDueOrders();
            List<Orders> ordersDuedMoreThan14Days = analyticsEngine.returnOrdersOverdueMoreThan14Days();

            List<String> lastestnotifications = analyticsEngine.returnLatestNotifications();
        %>
    </head>

    <body class="overflow-hidden">
        <div class="wrapper preload">
            <div class="sidebar-right">
                <div class="sidebar-inner scrollable-sidebar">
                    <div class="sidebar-header clearfix">
                        <input class="form-control dark-input" placeholder="Search" type="text">
                        <div class="btn-group pull-right">
                            <a href="#" class="sidebar-setting" data-toggle="dropdown"><i class="fa fa-cog fa-lg"></i></a>
                            <ul class="dropdown-menu pull-right flipInV">
                                <li><a href="#"><i class="fa fa-circle text-danger"></i><span class="m-left-xs">Busy</span></a></li>
                                <li><a href="#"><i class="fa fa-circle-o"></i><span class="m-left-xs">Turn Off Chat</span></a></li>
                            </ul>
                        </div>
                    </div>
                </div><!-- sidebar-inner -->
            </div><!-- sidebar-right -->
            <header class="top-nav">
                <div class="top-nav-inner">
                    <div class="nav-header">
                        <button type="button" class="navbar-toggle pull-left sidebar-toggle" id="sidebarToggleSM">
                            <span class="icon-bar"></span>
                            <span class="icon-bar"></span>
                            <span class="icon-bar"></span>
                        </button>
                        <a href="dashboard.jsp" class="brand">
                            <img src="image/LV_logo.jpg" alt="HTML5 Icon" style="width:30px;height:30px;">
                            <span class="brand-name">LOUIS VUITTON</span>
                        </a>
                    </div>
                    <div class="nav-container">
                        <button type="button" class="navbar-toggle pull-left sidebar-toggle" id="sidebarToggleLG">
                            <span class="icon-bar"></span>
                            <span class="icon-bar"></span>
                            <span class="icon-bar"></span>
                        </button>
                        <ul class="nav-notification">	
                            <li class="search-list">
                                <div class="search-input-wrapper">
                                    <div class="search-input">
                                        <input type="text" class="form-control input-sm inline-block">
                                        <a href="#" class="input-icon text-normal"><i class="ion-ios7-search-strong"></i></a>
                                    </div>
                                </div>
                            </li>
                        </ul>
                        <div class="pull-right m-right-sm">
                            <div class="user-block hidden-xs">
                                <a href="#" id="userToggle" data-toggle="dropdown">
                                    <!--<img src="../image/profile1.jpg" alt="" class="img-circle inline-block user-profile-pic">-->
                                    <div class="user-detail inline-block">
                                        <%=nameOfUser%>
                                        <i class="fa fa-angle-down"></i>
                                    </div>
                                </a>
                                <div class="panel border dropdown-menu user-panel">
                                    <div class="panel-body paddingTB-sm">
                                        <ul>
                                            <li>
                                                <a href="login.jsp">
                                                    <i class="fa fa-power-off fa-lg"></i><span class="m-left-xs">Sign out</span>
                                                </a>
                                            </li>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                            <ul class="nav-notification">
                                <li>
                                    <a href="#" data-toggle="dropdown"><i class="fa fa-bell fa-lg"></i></a>
                                    <span class="badge badge-info bounceIn animation-delay6 active"><%=lastestnotifications.size()%></span>
                                    <ul class="dropdown-menu notification dropdown-3 pull-right">
                                        <li><a href="#">You have <%=lastestnotifications.size()%> new notifications</a></li>
                                            <%

                                                for (String message : lastestnotifications) {
                                                    String icon = "plus";
                                                    String sign = "success";
                                                    if (message.contains("delete")) {
                                                        sign = "danger";
                                                        icon = "bolt";
                                                    } else if (message.contains("update")) {
                                                        sign = "warning";
                                                        icon = "warning";
                                                    }

                                            %>
                                        <li>
                                            <a href="processingLog.jsp">
                                                <span class="notification-icon bg-<%=sign%>">
                                                    <i class="fa fa-<%=icon%>"></i>
                                                </span>
                                                <span class="m-left-xs"><%=message%></span>
                                            </a>
                                        </li>

                                        <%
                                            }
                                        %>
                                        <li><a href="processingLog.jsp">View all notifications</a></li>					  
                                    </ul>
                                </li>
                                <!--<li class="chat-notification">
                                    <a href="#" class="sidebarRight-toggle"><i class="fa fa-comments fa-lg"></i></a>
                                    <span class="badge badge-danger bounceIn">1</span>

                                    <div class="chat-alert">
                                        Hello, Are you there?
                                    </div>
                                </li>-->
                            </ul>
                        </div>
                    </div>
                </div><!-- ./top-nav-inner -->	
            </header>
            <aside class="sidebar-menu fixed">
                <div class="sidebar-inner scrollable-sidebar">
                    <div class="main-menu">
                        <ul class="accordion">
                            <li class="menu-header">
                                Main Menu
                            </li>
                            <li class="bg-palette1 active">
                                <a href="dashboard.jsp">
                                    <span class="menu-content block">
                                        <span class="menu-icon"><i class="block fa fa-desktop fa-lg"></i></span>
                                        <span class="text m-left-sm">Dashboard</span>
                                    </span>
                                    <span class="menu-content-hover block">
                                        Dashboard
                                    </span>
                                </a>
                            </li>
                            <li class="bg-palette2">
                                <a href="calendar.jsp">
                                    <span class="menu-content block">
                                        <span class="menu-icon"><i class="block fa fa-calendar fa-lg"></i></span>
                                        <span class="text m-left-sm">Calendar</span>
                                    </span>
                                    <span class="menu-content-hover block">
                                        Dashboard
                                    </span>
                                </a>
                            </li>
                            <li class="bg-palette2">
                                <a href="accountManagement/accountManagement.jsp">
                                    <span class="menu-content block">
                                        <span class="menu-icon"><i class="block fa fa-list fa-lg"></i></span>
                                        <span class="text m-left-sm">Management</span>
                                    </span>
                                    <span class="menu-content-hover block">
                                        Dashboard
                                    </span>
                                </a>
                            </li>
                        </ul>
                    </div>	
                </div><!-- sidebar-inner -->
            </aside>

            <div class="main-container">
                <div class="padding-md">
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="page-title">
                                Dashboard
                            </div>
                            <div class="page-sub-header">
                                Welcome, Mr <%=nameOfUser%> , <i class="fa fa-map-marker text-danger"></i> New York
                            </div>
                        </div>
                        <div class="col-sm-6 text-right text-left-sm p-top-sm">
                            <div class="btn-group">
                                <a class="btn btn-default hidden-print pull-right" onclick="window.print()"><i class="fa fa-print"></i> Print Dashboard Page</a>
                                <ul class="dropdown-menu pull-right" role="menu">
                                    <li><a href="#">Events</a></li>
                                    <li><a href="#">Tasks</a></li>
                                    <li><a href="#">Orders</a></li>
                                </ul>
                            </div>

                            <!--<a class="btn btn-success">Create New Events</a>-->
                        </div>
                    </div>


                    <div class="row">
                        <div class="col-lg-4">
                            <br>
                            <div class="panel">
                                <div class="panel-body no-padding">
                                    <div class="owl-carousel custom-carousel2 no-controls">
                                        <div class="item">
                                            <img src="images/img6.jpg" alt="">
                                        </div>
                                        <div class="item">
                                            <img src="images/img7.jpg" alt="">
                                        </div>
                                        <div class="item">
                                            <img src="images/img8.jpg" alt="">
                                        </div>
                                    </div>
                                </div>
                                <div class="panel-footer bg-white">
                                    <div class="h4 text-success text-upper no-margin">No. of Events</div>
                                    <div class="clearfix paddingTB-md">
                                        <div class="pull-left">
                                            <h2 class="no-margin inline-block"><%=AnalyticsDAO.returnTotalNumOfEvents()%></h2><span> / <span class="badge badge-danger bounceIn animation-delay6 active"><%=AnalyticsDAO.returnNumOfPriorityEvents("High")%> High Priority</span></span>
                                        </div>
                                        <a href="events.jsp" class="btn btn-success pull-right text-upper">Go to Events</a>
                                    </div>
                                </div>
                            </div><!-- ./panel -->
                        </div>

                        <div class="col-lg-4">
                            <br>
                            <div class="panel">
                                <div class="panel-body no-padding">
                                    <div class="owl-carousel custom-carousel2 no-controls">
                                        <div class="item">
                                            <img src="images/img6.jpg" alt="">
                                        </div>
                                        <div class="item">
                                            <img src="images/img7.jpg" alt="">
                                        </div>
                                        <div class="item">
                                            <img src="images/img8.jpg" alt="">
                                        </div>
                                    </div>
                                </div>
                                <div class="panel-footer bg-white">
                                    <div class="h4 text-success text-upper no-margin">No. of Orders</div>
                                    <div class="clearfix paddingTB-md">
                                        <div class="pull-left">
                                            <h2 class="no-margin inline-block"><%=AnalyticsDAO.returnTotalNumOfOrders()%></h2><span> / <span class="badge badge-danger bounceIn animation-delay6 active"><%=AnalyticsDAO.returnNumOfPriorityOrders("High")%> High Priority</span></span>
                                        </div>
                                        <a href="orders.jsp" class="btn btn-success pull-right text-upper">Go to Orders</a>
                                    </div>
                                </div>
                            </div><!-- ./panel -->
                        </div>

                        <div class="col-lg-4">
                            <br>
                            <div class="panel">
                                <div class="panel-body no-padding">
                                    <div class="owl-carousel custom-carousel2 no-controls">
                                        <div class="item">
                                            <img src="images/img6.jpg" alt="">
                                        </div>
                                        <div class="item">
                                            <img src="images/img7.jpg" alt="">
                                        </div>
                                        <div class="item">
                                            <img src="images/img8.jpg" alt="">
                                        </div>
                                    </div>
                                </div>
                                <div class="panel-footer bg-white">
                                    <div class="h4 text-success text-upper no-margin">No. of Tasks</div>
                                    <div class="clearfix paddingTB-md">
                                        <div class="pull-left">
                                            <h2 class="no-margin inline-block"><%=AnalyticsDAO.returnTotalNumOfTasks()%></h2><span> / <span class="badge badge-danger bounceIn animation-delay6 active"><%=AnalyticsDAO.returnNumOfPriorityTasks("High")%> High Priority</span></span>
                                        </div>
                                        <a href="tasks.jsp" class="btn btn-success pull-right text-upper">Go to Tasks</a>
                                    </div>
                                </div>
                            </div><!-- ./panel -->
                        </div>
                    </div>

                    <%
                        // EncryptDecrypt encryptToken = new EncryptDecrypt();
                        //EncryptDecryptDAO encryptionEngine = new EncryptDecryptDAO();
                        //String cipher = encryptionEngine.encrypt(encryptToken, "kingdomhearts");
                        //String plaintext = encryptionEngine.decrypt(encryptToken, cipher);
%>
                    <!--highmaps visualizations-->
                    <div class="row">
                        <div class="col-lg-6">
                            <div id="D1" class="smart-widget widget-dark-blue">
                                <div class="smart-widget-header">
                                    Events based on Geolocation
                                    <span class="smart-widget-option">
                                        <span class="refresh-icon-animated">
                                            <i class="fa fa-circle-o-notch fa-spin"></i>
                                        </span>
                                        <a href="#" class="widget-toggle-hidden-option">
                                            <i class="fa fa-cog"></i>
                                        </a>
                                        <a href="#" class="widget-collapse-option" data-toggle="collapse">
                                            <i class="fa fa-chevron-up"></i>
                                        </a>
                                        <a href="#" class="widget-refresh-option">
                                            <i class="fa fa-refresh"></i>
                                        </a>
                                        <a href="#" class="widget-remove-option">
                                            <i class="fa fa-times"></i>
                                        </a>
                                    </span>
                                </div>
                                <div class="smart-widget-inner">
                                    <div class="smart-widget-hidden-section">
                                        <ul class="widget-color-list clearfix">
                                            <li style="background-color:#20232b;" data-color="widget-dark"></li>
                                            <li style="background-color:#4c5f70;" data-color="widget-dark-blue"></li>
                                            <li style="background-color:#23b7e5;" data-color="widget-blue"></li>
                                            <li style="background-color:#2baab1;" data-color="widget-green"></li>
                                            <li style="background-color:#edbc6c;" data-color="widget-yellow"></li>
                                            <li style="background-color:#fbc852;" data-color="widget-orange"></li>
                                            <li style="background-color:#e36159;" data-color="widget-red"></li>
                                            <li style="background-color:#7266ba;" data-color="widget-purple"></li>
                                            <li style="background-color:#f5f5f5;" data-color="widget-light-grey"></li>
                                            <li style="background-color:#fff;" data-color="reset"></li>
                                        </ul>
                                    </div>
                                    <div class="smart-widget-body no-padding">
                                        <div class="padding-md">
                                            <div id="EventMap1" style="height: 350px; min-width: 410px; max-width: 900px; margin: 0 auto"></div>
                                        </div>

                                        <div class="bg-grey">
                                            <div class="row">
                                                <div class="col-xs-4 text-center">
                                                    <h3 class="m-top-sm">100</h3>
                                                    <small class="m-bottom-sm block">Louisana DC</small>
                                                </div>
                                                <div class="col-xs-4 text-center">
                                                    <h3 class="m-top-sm">70</h3>
                                                    <small class="m-bottom-sm block">New Jersey DC</small>
                                                </div>
                                                <div class="col-xs-4 text-center">
                                                    <h3 class="m-top-sm">23</h3>
                                                    <small class="m-bottom-sm block">Head Office</small>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div><!-- ./smart-widget-inner -->
                            </div><!-- ./smart-widget -->
                        </div>


                        <div class="col-lg-6">
                            <div id="D2" class="smart-widget widget-dark-blue">
                                <div class="smart-widget-header">
                                    Events/Orders/Tasks based on Priority
                                    <span class="smart-widget-option">
                                        <span class="refresh-icon-animated">
                                            <i class="fa fa-circle-o-notch fa-spin"></i>
                                        </span>
                                        <a href="#" class="widget-toggle-hidden-option">
                                            <i class="fa fa-cog"></i>
                                        </a>
                                        <a href="#" class="widget-collapse-option" data-toggle="collapse">
                                            <i class="fa fa-chevron-up"></i>
                                        </a>
                                        <a href="#" class="widget-refresh-option">
                                            <i class="fa fa-refresh"></i>
                                        </a>
                                        <a href="#" class="widget-remove-option">
                                            <i class="fa fa-times"></i>
                                        </a>
                                    </span>
                                </div>
                                <div class="smart-widget-inner">
                                    <div class="smart-widget-hidden-section">
                                        <ul class="widget-color-list clearfix">
                                            <li style="background-color:#20232b;" data-color="widget-dark"></li>
                                            <li style="background-color:#4c5f70;" data-color="widget-dark-blue"></li>
                                            <li style="background-color:#23b7e5;" data-color="widget-blue"></li>
                                            <li style="background-color:#2baab1;" data-color="widget-green"></li>
                                            <li style="background-color:#edbc6c;" data-color="widget-yellow"></li>
                                            <li style="background-color:#fbc852;" data-color="widget-orange"></li>
                                            <li style="background-color:#e36159;" data-color="widget-red"></li>
                                            <li style="background-color:#7266ba;" data-color="widget-purple"></li>
                                            <li style="background-color:#f5f5f5;" data-color="widget-light-grey"></li>
                                            <li style="background-color:#fff;" data-color="reset"></li>
                                        </ul>
                                    </div>
                                    <div class="smart-widget-body no-padding">
                                        <div class="padding-md">
                                            <div id="EventPriority1" style="height: 350px; min-width: 410px; max-width: 900px; margin: 0 auto"></div>

                                        </div>

                                        <div class="bg-grey">
                                            <div class="row">
                                                <div class="col-xs-4 text-center">
                                                    <h3 class="m-top-sm"><%=AnalyticsDAO.returnTotalNumOfEvents()%></h3>
                                                    <small class="m-bottom-sm block">Total Events</small>
                                                </div>
                                                <div class="col-xs-4 text-center">
                                                    <h3 class="m-top-sm"><%=AnalyticsDAO.returnTotalNumOfOrders()%></h3>
                                                    <small class="m-bottom-sm block">Total Orders</small>
                                                </div>
                                                <div class="col-xs-4 text-center">
                                                    <h3 class="m-top-sm"><%=AnalyticsDAO.returnTotalNumOfTasks()%></h3>
                                                    <small class="m-bottom-sm block">Total Tasks</small>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div><!-- ./smart-widget-inner -->
                            </div><!-- ./smart-widget -->
                        </div>
                    </div>


                    <div class="row">
                        <div class="col-lg-6">
                            <div id="D3" class="smart-widget widget-dark-blue">
                                <div class="smart-widget-header">
                                    Progress Status of Orders
                                    <span class="smart-widget-option">
                                        <span class="refresh-icon-animated">
                                            <i class="fa fa-circle-o-notch fa-spin"></i>
                                        </span>
                                        <a href="#" class="widget-toggle-hidden-option">
                                            <i class="fa fa-cog"></i>
                                        </a>
                                        <a href="#" class="widget-collapse-option" data-toggle="collapse">
                                            <i class="fa fa-chevron-up"></i>
                                        </a>
                                        <a href="#" class="widget-refresh-option">
                                            <i class="fa fa-refresh"></i>
                                        </a>
                                        <a href="#" class="widget-remove-option">
                                            <i class="fa fa-times"></i>
                                        </a>
                                    </span>
                                </div>
                                <div class="smart-widget-inner">
                                    <div class="smart-widget-hidden-section">
                                        <ul class="widget-color-list clearfix">
                                            <li style="background-color:#20232b;" data-color="widget-dark"></li>
                                            <li style="background-color:#4c5f70;" data-color="widget-dark-blue"></li>
                                            <li style="background-color:#23b7e5;" data-color="widget-blue"></li>
                                            <li style="background-color:#2baab1;" data-color="widget-green"></li>
                                            <li style="background-color:#edbc6c;" data-color="widget-yellow"></li>
                                            <li style="background-color:#fbc852;" data-color="widget-orange"></li>
                                            <li style="background-color:#e36159;" data-color="widget-red"></li>
                                            <li style="background-color:#7266ba;" data-color="widget-purple"></li>
                                            <li style="background-color:#f5f5f5;" data-color="widget-light-grey"></li>
                                            <li style="background-color:#fff;" data-color="reset"></li>
                                        </ul>
                                    </div>
                                    <div class="smart-widget-body no-padding">
                                        <div class="padding-md">
                                            <div id="progressStatus1"></div>
                                            <div id="totalSalesChart" class="morris-chart" style="height:1px; visibility: hidden"></div>
                                        </div>

                                        <!--<div class="bg-grey">
                                            <div class="row">
                                                <div class="col-xs-4 text-center">
                                                    <h3 class="m-top-sm">33</h3>
                                                    <small class="m-bottom-sm block">Total Tasks</small>
                                                </div>
                                                <div class="col-xs-4 text-center">
                                                    <h3 class="m-top-sm">12</h3>
                                                    <small class="m-bottom-sm block">New Tasks</small>
                                                </div>
                                                <div class="col-xs-4 text-center">
                                                    <h3 class="m-top-sm">90</h3>
                                                    <small class="m-bottom-sm block">Priority Tasks</small>
                                                </div>
                                            </div>
                                        </div>-->
                                    </div>
                                </div><!-- ./smart-widget-inner -->
                            </div><!-- ./smart-widget -->
                        </div><!-- ./col -->

                        <div class="col-lg-6">
                            <div id="D4" class="smart-widget widget-dark-blue">
                                <div class="smart-widget-header">
                                    Upcoming Orders Volume Analysis
                                    <span class="smart-widget-option">
                                        <span class="refresh-icon-animated">

                                            <i class="fa fa-circle-o-notch fa-spin"></i>
                                        </span>
                                        <a href="#" class="widget-toggle-hidden-option">
                                            <i class="fa fa-cog"></i>
                                        </a>
                                        <a href="#" class="widget-collapse-option" data-toggle="collapse">
                                            <i class="fa fa-chevron-up"></i>
                                        </a>
                                        <a href="#" class="widget-refresh-option">
                                            <i class="fa fa-refresh"></i>
                                        </a>
                                        <a href="#" class="widget-remove-option">
                                            <i class="fa fa-times"></i>
                                        </a>
                                    </span>
                                </div>
                                <div class="smart-widget-inner">
                                    <div class="smart-widget-hidden-section">
                                        <ul class="widget-color-list clearfix">
                                            <li style="background-color:#20232b;" data-color="widget-dark"></li>
                                            <li style="background-color:#4c5f70;" data-color="widget-dark-blue"></li>
                                            <li style="background-color:#23b7e5;" data-color="widget-blue"></li>
                                            <li style="background-color:#2baab1;" data-color="widget-green"></li>
                                            <li style="background-color:#edbc6c;" data-color="widget-yellow"></li>
                                            <li style="background-color:#fbc852;" data-color="widget-orange"></li>
                                            <li style="background-color:#e36159;" data-color="widget-red"></li>
                                            <li style="background-color:#7266ba;" data-color="widget-purple"></li>
                                            <li style="background-color:#f5f5f5;" data-color="widget-light-grey"></li>
                                            <li style="background-color:#fff;" data-color="reset"></li>
                                        </ul>
                                    </div>
                                    <div class="smart-widget-body no-padding">
                                        <div class="padding-md">
                                            <div id="DaysToDeadline"></div>
                                            <div id="placeholder" style="height:1px; visibility: hidden;"></div>
                                        </div>

                                        <!--<div class="bg-grey">
                                            <div class="row">
                                                <div class="col-xs-4 text-center">
                                                    <h3 class="m-top-sm">3491</h3>
                                                    <small class="m-bottom-sm block">Total Sales</small>
                                                </div>
                                                <div class="col-xs-4 text-center">
                                                    <h3 class="m-top-sm">721</h3>
                                                    <small class="m-bottom-sm block">New Orders</small>
                                                </div>
                                                <div class="col-xs-4 text-center">
                                                    <h3 class="m-top-sm">$8103</h3>
                                                    <small class="m-bottom-sm block">Total Earnings</small>
                                                </div>
                                            </div>
                                        </div>-->
                                    </div>
                                </div><!-- ./smart-widget-inner -->
                            </div><!-- ./smart-widget -->
                        </div><!-- ./col -->
                    </div>

                    <div class="row">
                        <div class="col-lg-12">
                            <div id="D3" class="smart-widget widget-dark-blue">
                                <div class="smart-widget-header">
                                    Overdue Orders Analysis
                                    <span class="smart-widget-option">
                                        <span class="refresh-icon-animated">
                                            <i class="fa fa-circle-o-notch fa-spin"></i>
                                        </span>
                                        <a href="#" class="widget-toggle-hidden-option">
                                            <i class="fa fa-cog"></i>
                                        </a>
                                        <a href="#" class="widget-collapse-option" data-toggle="collapse">
                                            <i class="fa fa-chevron-up"></i>
                                        </a>
                                        <a href="#" class="widget-refresh-option">
                                            <i class="fa fa-refresh"></i>
                                        </a>
                                        <a href="#" class="widget-remove-option">
                                            <i class="fa fa-times"></i>
                                        </a>
                                    </span>
                                </div>
                                <div class="smart-widget-inner">
                                    <div class="smart-widget-hidden-section">
                                        <ul class="widget-color-list clearfix">
                                            <li style="background-color:#20232b;" data-color="widget-dark"></li>
                                            <li style="background-color:#4c5f70;" data-color="widget-dark-blue"></li>
                                            <li style="background-color:#23b7e5;" data-color="widget-blue"></li>
                                            <li style="background-color:#2baab1;" data-color="widget-green"></li>
                                            <li style="background-color:#edbc6c;" data-color="widget-yellow"></li>
                                            <li style="background-color:#fbc852;" data-color="widget-orange"></li>
                                            <li style="background-color:#e36159;" data-color="widget-red"></li>
                                            <li style="background-color:#7266ba;" data-color="widget-purple"></li>
                                            <li style="background-color:#f5f5f5;" data-color="widget-light-grey"></li>
                                            <li style="background-color:#fff;" data-color="reset"></li>
                                        </ul>
                                    </div>
                                    <div class="smart-widget-body no-padding">
                                        <div class="padding-md">
                                            <div id="overdueOrders"></div>
                                            <div id="totalSalesChart" class="morris-chart" style="height:1px; visibility: hidden"></div>
                                        </div>

                                    </div>

                                    <div class="smart-widget-body no-padding">
                                        <div class="padding-md">
                                            <div class="row">
                                                <div class="col-md-6">
                                                    <div class="smart-widget-header"> Upcoming Orders (Within 15 days of Deadline)</div><br>
                                                    <table class="table table-striped" id="upcomingOrdersTable">
                                                        <thead>
                                                            <tr>
                                                                <th>Order Number</th>
                                                                <th>Store Code</th>
                                                                <th>Product Family</th>
                                                                <th>Order Quantity</th>
                                                                <th>Shipping Date</th>
                                                                <th>Shipping Method</th>
                                                            </tr>
                                                        </thead>

                                                        <tbody>
                                                            <%
                                                                for (int i = 0; i < upcomingOrdersList.size(); i++) {
                                                                    List<Orders> listOfOrdersOnDay = upcomingOrdersList.get(i);
                                                                    for (int j = 0; j < listOfOrdersOnDay.size(); j++) {
                                                                        Orders theOrder = listOfOrdersOnDay.get(j);
                                                                        String orderNumber = theOrder.getOrderNumber();
                                                                        String storeCode = theOrder.getStoreCode();
                                                                        String productFamily = theOrder.getProductFamily();
                                                                        int orderQuantity = theOrder.getOrderQuantity();
                                                                        Date shippingDate = theOrder.getShippingDate();
                                                                        String shippingMethod = theOrder.getShippingMethod();
                                                            %>
                                                            <tr>
                                                                <td><%=orderNumber%></td>
                                                                <td><%=storeCode%></td>
                                                                <td><%=productFamily%></td>
                                                                <td><%=orderQuantity%></td>
                                                                <td><%=shippingDate%></td>
                                                                <td><%=shippingMethod%></td>
                                                            </tr>
                                                            <%
                                                                    }
                                                                }
                                                            %>
                                                        </tbody>
                                                    </table>
                                                </div>
                                                <div class="col-md-6">
                                                    <div class="smart-widget-header">Uncompleted Dued Orders</div><br>

                                                    <table class="table table-striped" id="duedOrdersTable">
                                                        <thead>
                                                            <tr>
                                                                <th>Order Number</th>
                                                                <th>Store Code</th>
                                                                <th>Product Family</th>
                                                                <th>Order Quantity</th>
                                                                <th>Shipping Date</th>
                                                                <th>Shipping Method</th>
                                                            </tr>
                                                        </thead>

                                                        <tbody>
                                                            <%
                                                                for (int k = 0; k < allOverduedOrders.size(); k++) {
                                                                    Orders order = allOverduedOrders.get(k);
                                                                    String orderNumber_due = order.getOrderNumber();
                                                                    String storeCode_due = order.getStoreCode();
                                                                    String productFamily_due = order.getProductFamily();
                                                                    int orderQuantity_due = order.getOrderQuantity();
                                                                    Date shippingDate_due = order.getShippingDate();
                                                                    String shippingMethod_due = order.getShippingMethod();
                                                            %>
                                                            <tr>
                                                                <td><%=orderNumber_due%></td>
                                                                <td><%=storeCode_due%></td>
                                                                <td><%=productFamily_due%></td>
                                                                <td><%=orderQuantity_due%></td>
                                                                <td><%=shippingDate_due%></td>
                                                                <td><%=shippingMethod_due%></td>
                                                            </tr>
                                                            <%
                                                                }
                                                            %>
                                                        </tbody>
                                                    </table>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div><!-- ./smart-widget-inner -->
                            </div><!-- ./smart-widget -->
                        </div><!-- ./col -->


                    </div>


                </div><!-- ./padding-md -->
            </div><!-- /main-container -->

            <footer class="footer">
                <span class="footer-brand">
                    <strong class="text-danger">Louis</strong>Vuitton 
                </span>
                <p class="no-margin">
                    &copy; 2016 <strong>Ace Consulting</strong>. ALL Rights Reserved. 
                </p>	
            </footer>
        </div><!-- /wrapper -->

        <a href="#" class="scroll-to-top hidden-print"><i class="fa fa-chevron-up fa-lg"></i></a>

        <!-- Jquery -->
        <script src="twitterBootstrap/js/jquery-1.11.1.min.js"></script>

        <!-- Bootstrap -->
        <script src="twitterBootstrap/bootstrap/js/bootstrap.min.js"></script>

        <!-- Popup Overlay -->
        <script src='twitterBootstrap/js/jquery.popupoverlay.min.js'></script>

        <!-- Slider -->
        <script src='twitterBootstrap/js/uncompressed/bootstrap-slider.js'></script>	

        <!-- Moment -->
        <script src='twitterBootstrap/js/uncompressed/moment.js'></script>

        <!-- Date Time picker -->
        <script src='twitterBootstrap/js/uncompressed/bootstrap-datetimepicker.js'></script>

        <!-- Select2 -->
        <script src='twitterBootstrap/js/select2.min.js'></script>

        <!-- Slimscroll -->
        <script src='twitterBootstrap/js/jquery.slimscroll.min.js'></script>

        <!-- Modernizr -->
        <script src='twitterBootstrap/js/modernizr.min.js'></script>

        <!-- Simplify -->
        <script src="twitterBootstrap/js/simplify/simplify.js"></script>

        <!-- Datatable -->
        <script src='twitterBootstrap/js/jquery.dataTables.min.js'></script>
        <script src='twitterBootstrap/js/uncompressed/dataTables.bootstrap.js'></script>


        <!--Highcharts scripts-->
        <script src="https://code.highcharts.com/highcharts.js"></script>
        <script src="https://code.highcharts.com/modules/exporting.js"></script>
        <script src="https://code.highcharts.com/modules/funnel.js"></script>

        <!-- Resources -->
        <script src="https://www.amcharts.com/lib/3/ammap.js"></script>
        <script src="https://www.amcharts.com/lib/3/maps/js/usaLow.js"></script>
        <script src="https://www.amcharts.com/lib/3/plugins/export/export.min.js"></script>
        <link rel="stylesheet" href="https://www.amcharts.com/lib/3/plugins/export/export.css" type="text/css" media="all" />
        <script src="https://www.amcharts.com/lib/3/themes/light.js"></script>
        <script>

                                    //Maps for events priority drilldown
                                    $(function () {
                                        Highcharts.chart('EventPriority1', {
                                            chart: {
                                                type: 'column'
                                            },
                                            title: {
                                                text: ''
                                            },
                                            xAxis: {
                                                categories: [
                                                    'Priority High',
                                                    'Priority Medium',
                                                    'Priority Low'
                                                ],
                                                crosshair: true
                                            },
                                            yAxis: {
                                                min: 0,
                                                title: {
                                                    text: 'No. of Events/Tasks/Orders'
                                                }
                                            },
                                            credits: {
                                                enabled: false
                                            },
                                            tooltip: {
                                                headerFormat: '<span style="font-size:10px">{point.key}</span><table>',
                                                pointFormat: '<tr><td style="color:{series.color};padding:0">{series.name}: </td>' +
                                                        '<td style="padding:0"><b>{point.y:.1f}</b></td></tr>',
                                                footerFormat: '</table>',
                                                shared: true,
                                                useHTML: true
                                            },
                                            plotOptions: {
                                                column: {
                                                    pointPadding: 0.2,
                                                    borderWidth: 0
                                                },
                                            },
                                            colors: [
                                                '#7CB5EC',
                                                '#DAF7A6',
                                                '#7BCFAB'
                                            ],
                                            series: [{
                                                    name: 'Events',
                                                    data: [<%=numOfHighPriorityEvents%>, <%=numOfMediumPriorityEvents%>, <%=numOfLowPriorityEvents%>]

                                                }, {
                                                    name: 'Orders',
                                                    data: [<%=numOfHighPriorityOrders%>, <%=numOfMediumPriorityOrders%>, <%=numOfLowPriorityOrders%>]

                                                }, {
                                                    name: 'Tasks',
                                                    data: [<%=numOfHighPriorityTasks%>, <%=numOfMediumPriorityTasks%>, <%=numOfLowPriorityTasks%>]

                                                }]
                                        });
                                    });
                                    //Event by status progress, progressStatus1
                                    $(function () {
                                        Highcharts.chart('progressStatus1', {
                                            chart: {
                                                type: 'column'
                                            },
                                            title: {
                                                text: ''
                                            },
                                            xAxis: {
                                                categories: [
                                                    'Poor Progress',
                                                    'Medium Progress',
                                                    'Good Progress'
                                                ],
                                                crosshair: true
                                            },
                                            yAxis: {
                                                min: 0,
                                                title: {
                                                    text: 'No. of Orders'
                                                }
                                            },
                                            credits: {
                                                enabled: false
                                            },
                                            tooltip: {
                                                headerFormat: '<span style="font-size:10px">{point.key}</span><table>',
                                                pointFormat: '<tr><td style="color:{series.color};padding:0">{series.name}: </td>' +
                                                        '<td style="padding:0"><b>{point.y:.1f}</b></td></tr>',
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
                                            colors: [
                                                '#7BCFAB',
                                                '#FFC300',
                                                '#C70039'
                                            ],
                                            series: [{
                                                    name: 'Good Progress (61%-100%)',
                                                    data: [<%=numOfGoodProgressOrders%>]

                                                }, {
                                                    name: 'Medium Progress (31%-60%)',
                                                    data: [<%=numOfMediumProgressOrders%>]

                                                }, {
                                                    name: 'Poor Progress (1%-30%)',
                                                    data: [<%=numOfPoorProgressOrders%>]

                                                }]
                                        });
                                    });
                                    $(function () {
                                        Highcharts.chart('DaysToDeadline', {
                                            chart: {
                                                type: 'funnel',
                                                marginRight: 100
                                            },
                                            title: {
                                                text: '',
                                                x: -50
                                            },
                                            credits: {
                                                enabled: false
                                            },
                                            plotOptions: {
                                                series: {
                                                    dataLabels: {
                                                        enabled: true,
                                                        format: '<b>{point.name}</b> ({point.y:,.0f})',
                                                        color: (Highcharts.theme && Highcharts.theme.contrastTextColor) || 'black',
                                                        softConnector: true
                                                    },
                                                    neckWidth: '30%',
                                                    neckHeight: '15%'

                                                            //-- Other available options
                                                            // height: pixels or percent
                                                            // width: pixels or percent
                                                }
                                            },
                                            colors: [
                                                '#7BCFAB',
                                                '#83DF8E',
                                                '#8BDF83',
                                                '#D2F064',
                                                '#DCF095',
                                                '#DAF7A6',
                                                '#FCFBC9',
                                                '#F7F460',
                                                '#FFC300',
                                                '#E1BF4F',
                                                '#DAA600',
                                                '#D62C5C',
                                                '#D8114A',
                                                '#C70039',
                                                '#900C3F'
                                            ],
                                            legend: {
                                                enabled: false
                                            },
                                            series: [{
                                                    name: 'Upcoming Orders',
                                                    data: [
                                                        ['+14 Days', <%=upcomingOrdersList.get(14).size()%>],
                                                        ['+13 Days', <%=upcomingOrdersList.get(13).size()%>],
                                                        ['+12 Days', <%=upcomingOrdersList.get(12).size()%>],
                                                        ['+11 Days', <%=upcomingOrdersList.get(11).size()%>],
                                                        ['+10 Days', <%=upcomingOrdersList.get(10).size()%>],
                                                        ['+9 Days', <%=upcomingOrdersList.get(9).size()%>],
                                                        ['+8 Days', <%=upcomingOrdersList.get(8).size()%>],
                                                        ['+7 Days', <%=upcomingOrdersList.get(7).size()%>],
                                                        ['+6 Days', <%=upcomingOrdersList.get(6).size()%>],
                                                        ['+5 Days', <%=upcomingOrdersList.get(5).size()%>],
                                                        ['+4 Days', <%=upcomingOrdersList.get(4).size()%>],
                                                        ['+3 Days', <%=upcomingOrdersList.get(3).size()%>],
                                                        ['+2 Days', <%=upcomingOrdersList.get(2).size()%>],
                                                        ['+1 Day', <%=upcomingOrdersList.get(1).size()%>],
                                                        ['Today', <%=upcomingOrdersList.get(0).size()%>]
                                                    ]
                                                }]
                                        });
                                    });
                                    //Event by status progress, progressStatus1
                                    $(function () {
                                        Highcharts.chart('overdueOrders', {
                                            chart: {
                                                type: 'column'
                                            },
                                            title: {
                                                text: ''
                                            },
                                            xAxis: {
                                                categories: [
                                                    '> 14 days late',
                                                    '14 days late',
                                                    '13 days late',
                                                    '12 days late',
                                                    '11 days late',
                                                    '10 days late',
                                                    '9 days late',
                                                    '8 days late',
                                                    '7 days late',
                                                    '6 days late',
                                                    '5 days late',
                                                    '4 days late',
                                                    '3 days late',
                                                    '2 days late',
                                                    '1 days late',
                                                    'due today'
                                                ],
                                                crosshair: true
                                            },
                                            yAxis: {
                                                min: 0,
                                                title: {
                                                    text: 'No. of Orders'
                                                }
                                            },
                                            credits: {
                                                enabled: false
                                            },
                                            tooltip: {
                                                headerFormat: '<span style="font-size:10px">{point.key}</span><table>',
                                                pointFormat: '<tr><td style="color:{series.color};padding:0">{series.name}: </td>' +
                                                        '<td style="padding:0"><b>{point.y:.1f}</b></td></tr>',
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
                                            colors: [
                                                '#900C3F',
                                                '#C70039',
                                                '#D8114A',
                                                '#D62C5C',
                                                '#DAA600',
                                                '#E1BF4F',
                                                '#FFC300',
                                                '#F7F460',
                                                '#FCFBC9',
                                                '#DAF7A6',
                                                '#DCF095',
                                                '#D2F064',
                                                '#8BDF83',
                                                '#83DF8E',
                                                '#7BCFAB',
                                                '#7BCFAB'
                                            ],
                                            series: [{
                                                    name: '> 14 days late',
                                                    data: [<%=ordersDuedMoreThan14Days.size()%>]

                                                },
                                                {
                                                    name: '14 days due',
                                                    data: [<%=overdueOrdersList.get(0).size()%>]

                                                }, {
                                                    name: '13 days due',
                                                    data: [<%=overdueOrdersList.get(1).size()%>]

                                                },
                                                {
                                                    name: '12 days due',
                                                    data: [<%=overdueOrdersList.get(2).size()%>]

                                                },
                                                {
                                                    name: '11 days due',
                                                    data: [<%=overdueOrdersList.get(3).size()%>]

                                                },
                                                {
                                                    name: '10 days due',
                                                    data: [<%=overdueOrdersList.get(4).size()%>]

                                                },
                                                {
                                                    name: '9 days due',
                                                    data: [<%=overdueOrdersList.get(5).size()%>]

                                                },
                                                {
                                                    name: '8 days due',
                                                    data: [<%=overdueOrdersList.get(6).size()%>]

                                                },
                                                {
                                                    name: '7 days due',
                                                    data: [<%=overdueOrdersList.get(7).size()%>]

                                                },
                                                {
                                                    name: '6 days due',
                                                    data: [<%=overdueOrdersList.get(8).size()%>]

                                                },
                                                {
                                                    name: '5 days due',
                                                    data: [<%=overdueOrdersList.get(9).size()%>]

                                                },
                                                {
                                                    name: '4 days due',
                                                    data: [<%=overdueOrdersList.get(10).size()%>]

                                                },
                                                {
                                                    name: '3 days due',
                                                    data: [<%=overdueOrdersList.get(11).size()%>]

                                                },
                                                {
                                                    name: '2 days due',
                                                    data: [<%=overdueOrdersList.get(12).size()%>]

                                                },
                                                {
                                                    name: '1 days due',
                                                    data: [<%=overdueOrdersList.get(13).size()%>]

                                                },
                                                {
                                                    name: 'due today',
                                                    data: [<%=overdueOrdersList.get(14).size()%>]

                                                }
                                            ]
                                        });
                                    });
        </script>
        <!-- Chart code -->
        <script>
            var map = AmCharts.makeChart("EventMap1", {
                "type": "map",
                "theme": "light",
                "colorSteps": 10,
                "dataProvider": {
                    "map": "usaLow",
                    "areas": [{
                            "id": "US-AL",
                            "value": 4447100
                        }, {
                            "id": "US-AK",
                            "value": 626932
                        }, {
                            "id": "US-AZ",
                            "value": 5130632
                        }, {
                            "id": "US-AR",
                            "value": 2673400
                        }, {
                            "id": "US-CA",
                            "value": 33871648
                        }, {
                            "id": "US-CO",
                            "value": 4301261
                        }, {
                            "id": "US-CT",
                            "value": 3405565
                        }, {
                            "id": "US-DE",
                            "value": 783600
                        }, {
                            "id": "US-FL",
                            "value": 15982378
                        }, {
                            "id": "US-GA",
                            "value": 8186453
                        }, {
                            "id": "US-HI",
                            "value": 1211537
                        }, {
                            "id": "US-ID",
                            "value": 1293953
                        }, {
                            "id": "US-IL",
                            "value": 12419293
                        }, {
                            "id": "US-IN",
                            "value": 6080485
                        }, {
                            "id": "US-IA",
                            "value": 2926324
                        }, {
                            "id": "US-KS",
                            "value": 2688418
                        }, {
                            "id": "US-KY",
                            "value": 4041769
                        }, {
                            "id": "US-LA",
                            "value": 4468976
                        }, {
                            "id": "US-ME",
                            "value": 1274923
                        }, {
                            "id": "US-MD",
                            "value": 5296486
                        }, {
                            "id": "US-MA",
                            "value": 6349097
                        }, {
                            "id": "US-MI",
                            "value": 9938444
                        }, {
                            "id": "US-MN",
                            "value": 4919479
                        }, {
                            "id": "US-MS",
                            "value": 2844658
                        }, {
                            "id": "US-MO",
                            "value": 5595211
                        }, {
                            "id": "US-MT",
                            "value": 902195
                        }, {
                            "id": "US-NE",
                            "value": 1711263
                        }, {
                            "id": "US-NV",
                            "value": 1998257
                        }, {
                            "id": "US-NH",
                            "value": 1235786
                        }, {
                            "id": "US-NJ",
                            "value": 8414350
                        }, {
                            "id": "US-NM",
                            "value": 1819046
                        }, {
                            "id": "US-NY",
                            "value": 18976457
                        }, {
                            "id": "US-NC",
                            "value": 8049313
                        }, {
                            "id": "US-ND",
                            "value": 642200
                        }, {
                            "id": "US-OH",
                            "value": 11353140
                        }, {
                            "id": "US-OK",
                            "value": 3450654
                        }, {
                            "id": "US-OR",
                            "value": 3421399
                        }, {
                            "id": "US-PA",
                            "value": 12281054
                        }, {
                            "id": "US-RI",
                            "value": 1048319
                        }, {
                            "id": "US-SC",
                            "value": 4012012
                        }, {
                            "id": "US-SD",
                            "value": 754844
                        }, {
                            "id": "US-TN",
                            "value": 5689283
                        }, {
                            "id": "US-TX",
                            "value": 20851820
                        }, {
                            "id": "US-UT",
                            "value": 2233169
                        }, {
                            "id": "US-VT",
                            "value": 608827
                        }, {
                            "id": "US-VA",
                            "value": 7078515
                        }, {
                            "id": "US-WA",
                            "value": 5894121
                        }, {
                            "id": "US-WV",
                            "value": 1808344
                        }, {
                            "id": "US-WI",
                            "value": 5363675
                        }, {
                            "id": "US-WY",
                            "value": 493782
                        }]
                },
                "areasSettings": {
                    "autoZoom": true
                },
                "valueLegend": {
                    "right": 10,
                    "minValue": "little events",
                    "maxValue": "a lot of events!"
                },
                "export": {
                    "enabled": true
                }

            });


            $(function () {
                $('#upcomingOrdersTable').dataTable();
            });
            $(function () {
                $('#duedOrdersTable').dataTable();
            });

        </script>

        <!-- HTML -->

    </body>
</html>
