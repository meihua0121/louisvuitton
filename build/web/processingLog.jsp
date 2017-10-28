<!DOCTYPE html>
<%@page import="entity.EncryptDecrypt,java.util.*,java.text.*, dao.*, entity.*, java.sql.Timestamp"%>
<html lang="en">
    <%
        String path = request.getContextPath();
    %>
    <head>
        <meta charset="utf-8">
        <title>Louis Vuitton - Facilitating Communications</title>
        <link rel="shortcut icon" type="image/x-icon" href="<%=path%>/image/LV_logo.jpg" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta name="description" content="">
        <meta name="author" content="">

        <!-- Bootstrap core CSS -->
        <link href="<%=path%>/twitterBootstrap/bootstrap/css/bootstrap.min.css" rel="stylesheet">

        <!-- Font Awesome -->
        <link href="<%=path%>/twitterBootstrap/css/font-awesome.min.css" rel="stylesheet">

        <!-- ionicons -->
        <link href="<%=path%>/twitterBootstrap/css/ionicons.min.css" rel="stylesheet">

        <!-- Animate -->
        <link href="<%=path%>/twitterBootstrap/css/animate.min.css" rel="stylesheet">

        <!-- Owl Carousel -->
        <link href="<%=path%>/twitterBootstrap/css/owl.carousel.min.css" rel="stylesheet">
        <link href="<%=path%>/twitterBootstrap/css/owl.theme.default.min.css" rel="stylesheet">

        <!-- Slider -->
        <link href="<%=path%>/twitterBootstrap/css/bootstrap-slider.css" rel="stylesheet"/>

        <!-- Tag Input -->
        <link href="<%=path%>/twitterBootstrap/css/jquery.tagsinput.css" rel="stylesheet">

        <!-- Date Time Picker -->
        <link href="<%=path%>/twitterBootstrap/css/datetimepicker.css" rel="stylesheet">

        <!-- Select2 -->
        <link href="<%=path%>/twitterBootstrap/css/select2/select2.css" rel="stylesheet"/>	

        <!-- Simplify -->
        <link href="<%=path%>/twitterBootstrap/css/simplify.min.css" rel="stylesheet">

        <!--datatable-->
        <link href="<%=path%>/twitterBootstrap/css/dataTables.bootstrap.css" rel="stylesheet">


        <style>
            * {
                border-radius: 0 !important;
            }
        </style>

        <%
            LoginDAO loginManager = new LoginDAO();
            
            Object javaObject = session.getAttribute("supplychain");
            User user = null;
            String nameOfUser = "";
            if (javaObject == null) {
                response.sendRedirect("login.jsp");
            } else {
                user = (User) javaObject;
                nameOfUser = user.getUserName();
            }
            
            EventsLogDAO eventsLogManager = new EventsLogDAO();
            List<EventsLog> listOfEventsLog = eventsLogManager.retrieveEventsLog();

            OrdersLogDAO ordersLogManager = new OrdersLogDAO();
            List<OrdersLog> listOfOrdersLog = ordersLogManager.retrieveOrdersLog();

            TasksLogDAO tasksLogManager = new TasksLogDAO();
            List<TasksLog> listOftasksLog = tasksLogManager.retrieveTasksLog();

            AnalyticsDAO analyticsEngine = new AnalyticsDAO();
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
                        <a href="<%=path%>/dashboard.jsp" class="brand">
                            <img src="<%=path%>/image/LV_logo.jpg" alt="HTML5 Icon" style="width:30px;height:30px;">
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
                                                <a href="<%=path%>/login.jsp">
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
                                            <a href="<%=path%>/processingLog.jsp">
                                                <span class="notification-icon bg-<%=sign%>">
                                                    <i class="fa fa-<%=icon%>"></i>
                                                </span>
                                                <span class="m-left-xs"><%=message%></span>
                                            </a>
                                        </li>

                                        <%
                                            }
                                        %>
                                        <li><a href="<%=path%>/processingLog.jsp">View all notifications</a></li>					  
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
                            <li class="bg-palette1">
                                <a href="<%=path%>/dashboard.jsp">
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
                                <a href="<%=path%>/calendar.jsp">
                                    <span class="menu-content block">
                                        <span class="menu-icon"><i class="block fa fa-calendar fa-lg"></i></span>
                                        <span class="text m-left-sm">Calendar</span>
                                    </span>
                                    <span class="menu-content-hover block">
                                        Dashboard
                                    </span>
                                </a>
                            </li>

                            <li class="bg-palette3">
                                <a href="<%=path%>/accountManagement/accountManagement.jsp">
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
                                Processing Log
                            </div>
                            <div class="page-sub-header">
                                Welcome, Mr <%=nameOfUser%> , <i class="fa fa-map-marker text-danger"></i> New York
                            </div>
                        </div>
                        <div class="col-sm-6 text-right text-left-sm p-top-sm">
                            <div class="btn-group">
                                <a class="btn btn-default hidden-print pull-right" onclick="window.print()"><i class="fa fa-print"></i> Print Processing Log Page</a>
                                <ul class="dropdown-menu pull-right" role="menu">
                                    <li><a href="#">Events</a></li>
                                    <li><a href="#">Tasks</a></li>
                                    <li><a href="#">Orders</a></li>
                                </ul>
                            </div>

                            <!--<a class="btn btn-success">Create New Events</a>-->
                        </div>
                    </div>


                    <div class="row"><br>
                        <div class="col-lg-12">
                            <div id="D1" class="smart-widget widget-dark-blue">
                                <div class="smart-widget-header">
                                    Events Log
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
                                            <input value="Download Table as .CSV" type="button" class="btn btn-success pull-right text-upper" onclick="downloadText($('#eventslog').table2CSV(), 'Eventslog.csv', 'text/plain')">                                           
                                        </div>
                                    </div>
                                    <div class="smart-widget-body no-padding">
                                        <div class="padding-md">
                                            <table class="table table-striped" id="eventslog">
                                                <thead>
                                                    <tr>
                                                        <th style="display:none;">Event Log ID</th>
                                                        <th style="display:none;">Event ID</th>
                                                        <th>Event Name</th>
                                                        <th>Entry Date</th>
                                                        <th>Event Owner</th>
                                                        <th>Priority</th>
                                                        <th>Deadline</th>
                                                        <th style="display:none;">Process Status</th>
                                                        <th style="display:none;">Event Location</th>
                                                        <th style="display:none;">Comments</th>
                                                        <th>Action Type</th>
                                                        <th>User Type</th>
                                                        <th>Username</th>
                                                        <th>Timestamp</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <%
                                                        for (int i = 0; i < listOfEventsLog.size(); i++) {
                                                            EventsLog eventlog = listOfEventsLog.get(i);
                                                            String eventLogID = eventlog.getEventLogID();
                                                            String eventID = eventlog.getEventID();
                                                            String eventName = eventlog.getEventName();
                                                            Date eventDate = eventlog.getEventDate();
                                                            String eventOwner = eventlog.getEventOwner();
                                                            String eventPriority = eventlog.getPriority();
                                                            Date eventDeadline = eventlog.getEventDeadline();
                                                            String eventProcessStatus = eventlog.getEventProcessStatus();
                                                            String eventLocation = eventlog.getEventLocation();
                                                            String comments = eventlog.getComments();
                                                            String actionType = eventlog.getActionType();
                                                            String userType = eventlog.getUserType();
                                                            String username = eventlog.getUsername();
                                                            Timestamp timestamp = eventlog.getTimestamp();
                                                    %>
                                                    <tr>
                                                        <td style="display:none;"><%=eventLogID%></td>
                                                        <td style="display:none;"><%=eventID%></td>
                                                        <td><%=eventName%></td>
                                                        <td><%=eventDate%></td>
                                                        <td><%=eventOwner%></td>
                                                        <td><%=eventPriority%></td>
                                                        <td><%=eventDeadline%></td>
                                                        <td style="display:none;"><%=eventProcessStatus%></td>
                                                        <td style="display:none;"><%=eventLocation%></td>
                                                        <td style="display:none;"><%=comments%></td>
                                                        <td><%=actionType%></td>
                                                        <td><%=userType%></td>
                                                        <td><%=username%></td>
                                                        <td><%=timestamp%></td>
                                                    </tr>
                                                    <%
                                                        }
                                                    %>
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
                                </div><!-- ./smart-widget-inner -->
                            </div><!-- ./smart-widget -->
                        </div>
                    </div>

                    <!--Orders log-->
                    <div class="row"><br>
                        <div class="col-lg-12">
                            <div id="D1" class="smart-widget widget-dark-blue">
                                <div class="smart-widget-header">
                                    Orders Log
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
                                            <input value="Download Table as .CSV" type="button" class="btn btn-success pull-right text-upper" onclick="downloadText($('#orderslog').table2CSV(), 'Orderslog.csv', 'text/plain')">                                           
                                        </div>
                                    </div>
                                    <div class="smart-widget-body no-padding">
                                        <div class="padding-md">
                                            <table class="table table-striped" id="orderslog">
                                                <thead>
                                                    <tr>
                                                        <th style="display:none;">Order Log ID</th>
                                                        <th style="display:none;">Order ID</th>
                                                        <th>Entry Date</th>
                                                        <th>Order Owner</th>
                                                        <th>Store Code</th>
                                                        <th>Product Family</th>
                                                        <th>Order Quantity</th>
                                                        <th>Shipping Date</th>
                                                        <th style="display:none;">Shipping Method</th>
                                                        <th style="display:none;">Order Status</th>
                                                        <th style="display:none;">Comments</th>
                                                        <th style="display:none;">Priority</th>
                                                        <th style="display:none;">Event ID</th>
                                                        <th>Tracking Number</th>
                                                        <th>Date Completed</th>
                                                        <th>Action Type</th>
                                                        <th>User Type</th>
                                                        <th>Username</th>
                                                        <th>Timestamp</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <%
                                                        for (int i = 0; i < listOfOrdersLog.size(); i++) {
                                                            OrdersLog orderLog = listOfOrdersLog.get(i);

                                                            String orderLogID = orderLog.getOrderLogID();
                                                            String orderID = orderLog.getOrderID();
                                                            Date orderDate = orderLog.getOrderDate();
                                                            String orderOwner = orderLog.getOrderOwner();
                                                            String storeCode = orderLog.getStoreCode();
                                                            String productFamily = orderLog.getProductFamily();
                                                            int orderQuantity = orderLog.getOrderQuantity();
                                                            Date shippingDate = orderLog.getShippingDate();
                                                            String shippingMethod = orderLog.getShippingMethod();
                                                            String orderStatus = orderLog.getOrderStatus();
                                                            String orderComments = orderLog.getOrderComments();
                                                            String priority = orderLog.getPriority();
                                                            String eventID = orderLog.getEventID();
                                                            String trackingNumber = orderLog.getTrackingNumber();
                                                            Date dateCompleted = orderLog.getDateCompleted();
                                                            String actionType = orderLog.getActionType();
                                                            String userType = orderLog.getUserType();
                                                            String username = orderLog.getUsername();
                                                            Timestamp timestamp = orderLog.getTimestamp();

                                                    %>
                                                    <tr>
                                                        <td style="display:none;"><%=orderLogID%></td>
                                                        <td style="display:none;"><%=orderID%></td>
                                                        <td><%=orderDate%></td>
                                                        <td><%=orderOwner%></td>
                                                        <td><%=storeCode%></td>
                                                        <td><%=productFamily%></td>
                                                        <td><%=orderQuantity%></td>
                                                        <td><%=shippingDate%></td>
                                                        <td style="display:none;"><%=shippingMethod%></td>
                                                        <td style="display:none;"><%=orderStatus%></td>
                                                        <td style="display:none;"><%=orderComments%></td>
                                                        <td style="display:none;"><%=priority%></td>
                                                        <td style="display:none;"><%=eventID%></td>
                                                        <td><%=trackingNumber%></td>
                                                        <td><%=dateCompleted%></td>
                                                        <td><%=actionType%></td>
                                                        <td><%=userType%></td>
                                                        <td><%=username%></td>
                                                        <td><%=timestamp%></td>
                                                    </tr>
                                                    <%
                                                        }
                                                    %>
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
                                </div><!-- ./smart-widget-inner -->
                            </div><!-- ./smart-widget -->
                        </div>
                    </div>


                    <!--Tasks log-->

                    <div class="row"><br>
                        <div class="col-lg-12">
                            <div id="D1" class="smart-widget widget-dark-blue">
                                <div class="smart-widget-header">
                                    Tasks Log
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
                                            <input value="Download Table as .CSV" type="button" class="btn btn-success pull-right text-upper" onclick="downloadText($('#taskslog').table2CSV(), 'Taskslog.csv', 'text/plain')">                                           
                                        </div>
                                    </div>
                                    <div class="smart-widget-body no-padding">
                                        <div class="padding-md">
                                            <table class="table table-striped" id="taskslog">
                                                <thead>
                                                    <tr>
                                                        <th style="display:none;">Task Log ID</th>
                                                        <th style="display:none;">Task ID</th>
                                                        <th>Event Name</th>
                                                        <th>Task Owner</th>
                                                        <th>Order ID</th>
                                                        <th>Deadline</th>
                                                        <th>Task Description</th>
                                                        <th>Process Status</th>
                                                        <th>Comments</th>
                                                        <th>Action Type</th>
                                                        <th>User Type</th>
                                                        <th>Username</th>
                                                        <th>Timestamp</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <%
                                                        for (int i = 0; i < listOftasksLog.size(); i++) {
                                                            TasksLog taskLog = listOftasksLog.get(i);
                                                            String taskLogID = taskLog.getTaskLogID();
                                                            String taskID = taskLog.getTaskID();
                                                            Date taskDate = taskLog.getTaskDate();
                                                            String taskOwner = taskLog.getTaskOwner();
                                                            String priority = taskLog.getPriority();
                                                            String orderID = taskLog.getOrderID();
                                                            Date taskDeadline = taskLog.getTaskDeadline();
                                                            String taskProcessStatus = taskLog.getTaskProcessStatus();
                                                            String taskDescription = taskLog.getTaskDescription();
                                                            String taskComments = taskLog.getTaskComments();
                                                            String actionType = taskLog.getActionType();
                                                            String userType = taskLog.getUserType();
                                                            String username = taskLog.getUsername();
                                                            Timestamp timestamp = taskLog.getTimestamp();
                                                    %>
                                                    <tr>
                                                        <td style="display:none;"><%=taskLogID%></td>
                                                        <td style="display:none;"><%=taskID%></td>
                                                        <td><%=taskDate%></td>
                                                        <td><%=taskOwner%></td>
                                                        <td><%=priority%></td>
                                                        <td><%=orderID%></td>
                                                        <td><%=taskDeadline%></td>
                                                        <td><%=taskDescription%></td>
                                                        <td><%=taskComments%></td>
                                                        <td><%=actionType%></td>
                                                        <td><%=userType%></td>
                                                        <td><%=username%></td>
                                                        <td><%=timestamp%></td>
                                                    </tr>
                                                    <%
                                                        }
                                                    %>
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
                                </div><!-- ./smart-widget-inner -->
                            </div><!-- ./smart-widget -->
                        </div>
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
        <script src="<%=path%>/twitterBootstrap/js/jquery-1.11.1.min.js"></script>

        <!-- Bootstrap -->
        <script src="<%=path%>/twitterBootstrap/bootstrap/js/bootstrap.min.js"></script>

        <!-- Popup Overlay -->
        <script src='<%=path%>/twitterBootstrap/js/jquery.popupoverlay.min.js'></script>

        <!-- Slider -->
        <script src='<%=path%>/twitterBootstrap/js/uncompressed/bootstrap-slider.js'></script>	

        <!-- Moment -->
        <script src='<%=path%>/twitterBootstrap/js/uncompressed/moment.js'></script>

        <!-- Date Time picker -->
        <script src='<%=path%>/twitterBootstrap/js/uncompressed/bootstrap-datetimepicker.js'></script>

        <!-- Select2 -->
        <script src='<%=path%>/twitterBootstrap/js/select2.min.js'></script>

        <!-- Slimscroll -->
        <script src='<%=path%>/twitterBootstrap/js/jquery.slimscroll.min.js'></script>

        <!-- Modernizr -->
        <script src='<%=path%>/twitterBootstrap/js/modernizr.min.js'></script>

        <!-- Simplify -->
        <script src="<%=path%>/twitterBootstrap/js/simplify/simplify.js"></script>

        <!-- Datatable -->
        <script src='<%=path%>/twitterBootstrap/js/jquery.dataTables.min.js'></script>
        <script src='<%=path%>/twitterBootstrap/js/uncompressed/dataTables.bootstrap.js'></script>


        <script>
                                                jQuery.fn.table2CSV = function (options) {
                                                    var options = jQuery.extend({
                                                        separator: ',',
                                                        header: [],
                                                        delivery: 'normal' // popup, value
                                                    },
                                                            options);

                                                    var csvData = [];
                                                    var headerArr = [];
                                                    var el = this;

                                                    //header
                                                    var numCols = options.header.length;
                                                    var tmpRow = []; // construct header avalible array

                                                    if (numCols > 0) {
                                                        for (var i = 0; i < numCols; i++) {
                                                            tmpRow[tmpRow.length] = formatData(options.header[i]);
                                                        }
                                                    } else {
                                                        $(el).filter(':visible').find('th').each(function () {
                                                            //if ($(this).css('display') !== 'none')
                                                            tmpRow[tmpRow.length] = formatData($(this).html());
                                                        });
                                                    }

                                                    row2CSV(tmpRow);

                                                    // actual data
                                                    $(el).find('tr').each(function () {
                                                        var tmpRow = [];
                                                        $(this).filter(':visible').find('td').each(function () {
                                                            //if ($(this).css('display') !== 'none')
                                                            tmpRow[tmpRow.length] = formatData($(this).html());
                                                        });
                                                        row2CSV(tmpRow);
                                                    });
                                                    if (options.delivery === 'popup') {
                                                        var mydata = csvData.join('\n');
                                                        return popup(mydata);
                                                    } else {
                                                        var mydata = csvData.join('\n');
                                                        return mydata;
                                                    }

                                                    function row2CSV(tmpRow) {
                                                        var tmp = tmpRow.join(''); // to remove any blank rows
                                                        // alert(tmp);
                                                        if (tmpRow.length > 0 && tmp !== '') {
                                                            var mystr = tmpRow.join(options.separator);
                                                            csvData[csvData.length] = mystr;
                                                        }
                                                    }
                                                    function formatData(input) {
                                                        // replace " with ?
                                                        var regexp = new RegExp(/["]/g);
                                                        var output = input.replace(regexp, "?");
                                                        //HTML
                                                        var regexp = new RegExp(/\<[^\<]+\>/g);
                                                        var output = output.replace(regexp, "");
                                                        if (output === "")
                                                            return '';
                                                        return '"' + output + '"';
                                                    }

                                                    function popup(data) {
                                                        var generator = window.open('', 'csv', 'height=400,width=600');
                                                        generator.document.write('<html><head><title>CSV</title>');
                                                        generator.document.write('</head><body >');
                                                        generator.document.write('<textArea cols=70 rows=15 wrap="off" >');
                                                        generator.document.write(data);
                                                        generator.document.write('</textArea>');
                                                        generator.document.write('</body></html>');
                                                        generator.document.close();
                                                        return true;
                                                    }
                                                }
                                                function downloadText(strData, strFileName, strMimeType) {
                                                    var D = document,
                                                            A = arguments,
                                                            a = D.createElement("a"),
                                                            d = A[0],
                                                            n = A[1],
                                                            t = A[2] || "text/plain";

                                                    //build download link:
                                                    a.href = "data:" + strMimeType + "charset=utf-8," + escape(strData);

                                                    if (window.MSBlobBuilder) { // IE10
                                                        var bb = new MSBlobBuilder();
                                                        bb.append(strData);
                                                        return navigator.msSaveBlob(bb, strFileName);
                                                    } /* end if(window.MSBlobBuilder) */


                                                    if ('download' in a) { //FF20, CH19
                                                        a.setAttribute("download", n);
                                                        a.innerHTML = "downloading...";
                                                        D.body.appendChild(a);
                                                        setTimeout(function () {
                                                            var e = D.createEvent("MouseEvents");
                                                            e.initMouseEvent("click", true, false, window, 0, 0, 0, 0, 0, false, false, false, false, 0, null);
                                                            a.dispatchEvent(e);
                                                            D.body.removeChild(a);
                                                        }, 66);
                                                        return true;
                                                    }
                                                    ; /* end if('download' in a) */

                                                    //do iframe dataURL download: (older W3)
                                                    var f = D.createElement("iframe");
                                                    D.body.appendChild(f);
                                                    f.src = "data:" + (A[2] ? A[2] : "application/octet-stream") + (window.btoa ? ";base64" : "") + "," + (window.btoa ? window.btoa : escape)(strData);
                                                    setTimeout(function () {
                                                        D.body.removeChild(f);
                                                    }, 333);
                                                    return true;
                                                }

        </script>

        <script>
            $(function () {
                $('#eventslog').dataTable();
                $('#orderslog').dataTable();
                $('#taskslog').dataTable();
            });

        </script>
    </body>
</html>
