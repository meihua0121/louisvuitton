<!DOCTYPE html>
<%@page import="entity.Events, dao.EventsDAO, entity.Orders, entity.User,dao.AnalyticsDAO, dao.LoginDAO, dao.OrdersDAO, entity.Tasks, dao.TasksDAO, java.util.*,java.text.*"%>
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

        <!--maps css-->
        <link rel="stylesheet" href="https://www.amcharts.com/lib/3/plugins/export/export.css" type="text/css" media="all" />

        <style>
            * {
                border-radius: 0 !important;
            }
            table{
                table-layout: fixed;
                font-size: 0.9em;
            }
            td{
                word-wrap:break-word
            }

            .hiddenRow {
                padding: 0 !important;
            }
        </style>
    </head>
    <%
        Object javaObject = session.getAttribute("distributioncenter");
        User user = null;
        String nameOfUser = "";
        if (javaObject == null) {
            response.sendRedirect(path + "/login.jsp");
        } else {
            user = (User) javaObject;
            nameOfUser = user.getUserName();
        }

        //Come back to delete this laer
        EventsDAO eventsManager = new EventsDAO();
        List<Events> eventsList = eventsManager.retrieveEvents();

        OrdersDAO ordersManager = new OrdersDAO();
        List<Orders> ordersList = ordersManager.retrieveOrders();

        TasksDAO tasksManager = new TasksDAO();
        List<Tasks> tasksList = tasksManager.retrieveTasks();

        LoginDAO loginManager = new LoginDAO();
        Hashtable<String, User> listOfUsers = loginManager.retrieveUsers();

        AnalyticsDAO analyticsEngine = new AnalyticsDAO();
        Hashtable<String, List<Tasks>> listOfTasksOfEachUser = analyticsEngine.returnTheTasksOfEachUser();

        List<List<Orders>> upcomingOrdersList = analyticsEngine.returnNumberOfOrdersDueXDays(15);
        List<List<Orders>> overdueOrdersList = analyticsEngine.returnNumberOfOrdersXDaysFromNow(15);
        List<Orders> allOverduedOrders = analyticsEngine.returnAllOverDueOrders();

        List<List<Tasks>> upcomingTasksList = analyticsEngine.returnNumberOfTasksDueXDays(15);
        List<List<Tasks>> overdueTasksList = analyticsEngine.returnNumberOfTasksXDaysFromNow(15);
        List<Tasks> allOverduedTasks = analyticsEngine.returnAllOverDueTasks();

        List<String> lastestnotifications = analyticsEngine.returnLatestNotifications();
        List<Orders> ordersDuedMoreThan14Days = analyticsEngine.returnOrdersOverdueMoreThan14Days();
    %>

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

                        <a href="home.jsp" class="brand">
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
                                            <a href="processingLogDC.jsp">
                                                <span class="notification-icon bg-<%=sign%>">
                                                    <i class="fa fa-<%=icon%>"></i>
                                                </span>
                                                <span class="m-left-xs"><%=message%></span>
                                            </a>
                                        </li>

                                        <%
                                            }
                                        %>
                                        <li><a href="processingLogDC.jsp">View all notifications</a></li>					  
                                    </ul>
                                </li>
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
                                <a href="<%=path%>/distributionCenter/home.jsp">
                                    <span class="menu-content block">
                                        <span class="menu-icon"><i class="block fa fa-desktop fa-lg"></i></span>
                                        <span class="text m-left-sm">Home</span>
                                    </span>
                                    <span class="menu-content-hover block">
                                        Home
                                    </span>
                                </a>
                            </li>
                            <li class="bg-palette2">
                                <a href="<%=path%>/distributionCenter/calendar.jsp">
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
                                <a href="<%=path%>/distributionCenter/accountManagement.jsp">
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
                                Distribution Center Management
                            </div>
                            <div class="page-sub-header">
                                Welcome, <%=nameOfUser%> , <i class="fa fa-map-marker text-danger"></i> New York
                            </div>
                        </div>
                        <div class="col-sm-6 text-right text-left-sm p-top-sm">
                            <div class="btn-group">
                                <a class="btn btn-default hidden-print pull-right" onclick="window.print()"><i class="fa fa-print"></i> Print Tasks Page</a>
                            </div>
                        </div>
                    </div>


                    <div class="row">
                        <div class="col-lg-4">
                            <br>
                            <div class="panel">
                                <div class="panel-body no-padding">
                                    <div class="owl-carousel custom-carousel2 no-controls">
                                        <div class="item">
                                            <img src="<%=path%>/images/img6.jpg" alt="">
                                        </div>
                                        <div class="item">
                                            <img src="<%=path%>/images/img7.jpg" alt="">
                                        </div>
                                        <div class="item">
                                            <img src="<%=path%>/images/img8.jpg" alt="">
                                        </div>
                                    </div>
                                </div>
                                <div class="panel-footer bg-white">
                                    <div class="h4 text-success text-upper no-margin">No. of Events</div>
                                    <div class="clearfix paddingTB-md">
                                        <div class="pull-left">
                                            <h2 class="no-margin inline-block"><%=AnalyticsDAO.returnTotalNumOfEvents()%></h2><span> / <span class="badge badge-danger bounceIn animation-delay6 active"><%=AnalyticsDAO.returnNumOfPriorityEvents("High")%> High Priority</span></span>
                                        </div>
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
                                            <img src="<%=path%>/images/img6.jpg" alt="">
                                        </div>
                                        <div class="item">
                                            <img src="<%=path%>/images/img7.jpg" alt="">
                                        </div>
                                        <div class="item">
                                            <img src="<%=path%>/images/img8.jpg" alt="">
                                        </div>
                                    </div>
                                </div>
                                <div class="panel-footer bg-white">
                                    <div class="h4 text-success text-upper no-margin">No. of Orders</div>
                                    <div class="clearfix paddingTB-md">
                                        <div class="pull-left">
                                            <h2 class="no-margin inline-block"><%=AnalyticsDAO.returnTotalNumOfOrders()%></h2><span> / <span class="badge badge-danger bounceIn animation-delay6 active"><%=AnalyticsDAO.returnNumOfPriorityOrders("High")%> High Priority</span></span>
                                        </div>
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
                                            <img src="<%=path%>/images/img6.jpg" alt="">
                                        </div>
                                        <div class="item">
                                            <img src="<%=path%>/images/img7.jpg" alt="">
                                        </div>
                                        <div class="item">
                                            <img src="<%=path%>/images/img8.jpg" alt="">
                                        </div>
                                    </div>
                                </div>
                                <div class="panel-footer bg-white">
                                    <div class="h4 text-success text-upper no-margin">No. of Tasks</div>
                                    <div class="clearfix paddingTB-md">
                                        <div class="pull-left">
                                            <h2 class="no-margin inline-block"><%=AnalyticsDAO.returnTotalNumOfTasks()%></h2><span> / <span class="badge badge-danger bounceIn animation-delay6 active"><%=AnalyticsDAO.returnNumOfPriorityTasks("High")%> High Priority</span></span>
                                        </div>

                                    </div>
                                </div>
                            </div><!-- ./panel -->
                        </div>

                    </div>

                    <div class="row">
                        <div class="col-lg-12">
                            <div class="smart-widget widget-dark-blue">
                                <div class="smart-widget-header">
                                    Order List
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
                                            <input value="Download Table as .CSV" type="button" class="btn btn-success pull-right text-upper" onclick="downloadText($('#OrdersDataTable').table2CSV(), 'Orders.csv', 'text/plain')">                                           
                                        </div>
                                    </div>
                                    <div class="smart-widget-body no-padding">
                                        <div class="padding-md">
                                            <table class="table table-striped" id="OrdersDataTable">
                                                <thead>
                                                    <tr>
                                                        <th style="display:none;">Event ID</th>
                                                        <th style="display:none;">Order ID</th>
                                                        <th style="display:none;">Entry Date</th>
                                                        <th>Event Name</th>
                                                        <th>Order Number</th>
                                                        <th>Order Owner</th>
                                                        <th>Store Code</th>
                                                        <th style="display:none;">Product Family</th>
                                                        <th>Order Quantity</th>
                                                        <th>Shipping Date</th>
                                                        <th>Shipping Method</th>
                                                        <th>Order Status</th>
                                                        <th>Comments</th>
                                                        <th>Priority</th>
                                                        <th style="display:none;">Tracking Number</th>
                                                        <th style="display:none;">Date Completed</th>
                                                        <th>Actions</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <%
                                                        if (ordersList != null) {
                                                            for (int i = 0; i < ordersList.size(); i++) {
                                                                Orders theOrder = ordersList.get(i);
                                                                String orderNumber = theOrder.getOrderNumber();
                                                                String eventID = theOrder.getEventID();
                                                                String eventName = "None";
                                                                if (!eventID.equals("None")) {
                                                                    Events theEvent = eventsManager.searchEvents(eventID);
                                                                    eventName = theEvent.getEventName();
                                                                    
                                                                }
                                                                String orderID = theOrder.getOrderID();
                                                                Date orderDate = theOrder.getOrderDate();
                                                                String orderOwner = theOrder.getOrderOwner();
                                                                String storeCode = theOrder.getStoreCode();
                                                                String productFamily = theOrder.getProductFamily();
                                                                int orderQuantity = theOrder.getOrderQuantity();
                                                                Date shippingDate = theOrder.getShippingDate();
                                                                String shippingMethod = theOrder.getShippingMethod();
                                                                String comments = theOrder.getOrderComments();
                                                                String trackingNumber = theOrder.getTrackingNumber();
                                                                Date dateCompleted = theOrder.getDateCompleted();
                                                                //Perform priority checking for events
                                                                String orderPriority = theOrder.getPriority();
                                                                String priorityLable = "";
                                                                if (orderPriority.equals("High")) {
                                                                    priorityLable = "danger";
                                                                } else if (orderPriority.equals("Medium")) {
                                                                    priorityLable = "warning";
                                                                } else {
                                                                    priorityLable = "success";
                                                                }

                                                                //Perform event process status filtering
                                                                String orderProcessStatus = theOrder.getOrderStatus();
                                                                int orderProgress = Integer.parseInt(orderProcessStatus);
                                                                String progressLable = "";
                                                                if (orderProgress <= 40) {
                                                                    progressLable = "danger";
                                                                } else if (orderProgress < 100) {
                                                                    progressLable = "warning";
                                                                } else {
                                                                    progressLable = "success";
                                                                }
                                                    %>
                                                    <tr> 
                                                        <td style="display:none;"><%=eventID%></td>
                                                        <td style="display:none;"><%=orderID%></td>
                                                        <td style="display:none;"><%=orderDate%></td>
                                                        <td><%=eventName%></td>
                                                        <td><%=orderNumber%></td>
                                                        <td><%=orderOwner%></td>
                                                        <td><%=storeCode%></td>
                                                        <td style="display:none;"><%=productFamily%></td>
                                                        <td><%=orderQuantity%></td>
                                                        <td><%=shippingDate%></td>
                                                        <td><%=shippingMethod%></td>
                                                        <td><span class="label label-<%=progressLable%>"><%=orderProgress%>%</span></td>
                                                        <td width="10px"><%=comments%></td>
                                                        <td><span class="label label-<%=priorityLable%>"><%=orderPriority%></span></td>
                                                        <td style="display:none;"><%=trackingNumber%></td>
                                                        <td style="display:none;"><%=dateCompleted%></td>
                                                        <td>       
                                                            <button class="btn btn-info btn-xs" onclick="window.location.href = 'specificOrders.jsp?orderID=<%=orderID%>'">&nbsp; View Order &nbsp;&nbsp; </button>
                                                        </td>
                                                    </tr>
                                                    <%
                                                            }
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

                    <div class="row">
                        <div class="col-lg-12">
                            <div class="smart-widget widget-dark-blue">
                                <div class="smart-widget-header">
                                    Task List
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
                                            <input value="Download Table as .CSV" type="button" class="btn btn-success pull-right text-upper" onclick="downloadText($('#TaskDataTable').table2CSV(), 'Tasks.csv', 'text/plain')">                                           
                                        </div>
                                    </div>
                                    <div class="smart-widget-body no-padding">
                                        <div class="padding-md">
                                            <table class="table table-striped" id="TaskDataTable">
                                                <thead>
                                                    <tr>
                                                        <th style="display:none;">Order ID ID</th>
                                                        <th style="display:none;">Task ID</th>
                                                        <th>Task Description</th>
                                                        <th>Entry Date</th>
                                                        <th>Assigned</th>
                                                        <th>Task Deadline</th>
                                                        <th>Priority</th>
                                                        <th>Task Progress</th>
                                                        <th>Comments</th>
                                                        <th>Actions</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <%                                                        if (tasksList != null) {
                                                            for (int i = 0; i < tasksList.size(); i++) {
                                                                Tasks theTask = tasksList.get(i);
                                                                String orderID = theTask.getOrderID();
                                                                String taskID = theTask.getTaskID();
                                                                String taskDescription = theTask.getTaskDescription();
                                                                Date entryDate = theTask.getTaskDate();
                                                                String taskOwner = theTask.getTaskOwner();
                                                                Date taskDeadline = theTask.getTaskDeadline();
                                                                String taskComments = theTask.getTaskComments();
                                                                //Perform priority checking for events
                                                                String taskPriority = theTask.getPriority();
                                                                String priorityLable = "";
                                                                if (taskPriority.equals("High")) {
                                                                    priorityLable = "danger";
                                                                } else if (taskPriority.equals("Medium")) {
                                                                    priorityLable = "warning";
                                                                } else {
                                                                    priorityLable = "success";
                                                                }

                                                                //Perform event process status filtering
                                                                String taskProcessStatus = theTask.getTaskProcessStatus();
                                                                int taskProgress = Integer.parseInt(taskProcessStatus);
                                                                String progressLable = "";
                                                                if (taskProgress <= 40) {
                                                                    progressLable = "danger";
                                                                } else if (taskProgress < 100) {
                                                                    progressLable = "warning";
                                                                } else {
                                                                    progressLable = "success";
                                                                }
                                                    %>
                                                    <tr>
                                                        <td style="display:none;"><%=orderID%></td>
                                                        <td style="display:none;"><%=taskID%></td>
                                                        <td><%=taskDescription%></td>
                                                        <td><%=entryDate%></td>
                                                        <td><%=taskOwner%></td>
                                                        <td><%=taskDeadline%></td>
                                                        <td><span class="label label-<%=priorityLable%>"><%=taskPriority%></span></td>
                                                        <td><span class="label label-<%=progressLable%>"><%=taskProgress%>%</span></td>
                                                        <td><%=taskComments%></td>
                                                        <td>
                                                            <button type="submit" class="btn btn-info btn-xs" data-toggle="modal" href="#editTaskModal" onclick="update_Task_Params('<%=orderID%>', '<%=taskID%>', '<%=taskDescription%>', '<%=entryDate%>', '<%=taskOwner%>', '<%=taskDeadline%>', '<%=taskPriority%>', '<%=taskComments%>')">&nbsp; Edit &nbsp;&nbsp; </button>
                                                            <button type="submit" class="btn btn-danger btn-xs" data-toggle="modal" href="#deleteTaskModal" onclick="updateTaskID('<%=taskID%>')">Delete</button>
                                                        </td>
                                                    </tr>
                                                    <%
                                                            }
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


                    <div class="row">
                        <div class="col-lg-12">
                            <div class="smart-widget widget-dark-blue">
                                <div class="smart-widget-header">
                                    Workload Of Team
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
                                            <table class="table table-striped" id="WorkloadDataTable">
                                                <thead>
                                                    <tr>
                                                        <th>Username</th>
                                                        <th>Email</th>
                                                        <th>Phone Number</th>
                                                        <th>User Type</th>
                                                        <th>Number of Active Tasks</th>
                                                        <th>Number of Completed Tasks</th>
                                                        <!--<th>View Tasks</th>-->
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <%                                                        Set<String> keys = listOfUsers.keySet();
                                                        for (String key : keys) {
                                                            User theUser = listOfUsers.get(key);
                                                            String username = theUser.getUserName();
                                                            String email = theUser.getEmail();
                                                            String phoneNumber = theUser.getPhoneNumber();
                                                            String userType = theUser.getType();

                                                            List<Tasks> listOfTasks = listOfTasksOfEachUser.get(key);
                                                    %>       
                                                    <tr>
                                                        <td><%=username%></td>
                                                        <td><%=email%></td>
                                                        <td><%=phoneNumber%></td>
                                                        <td><%=userType%></td>
                                                        <td><%=listOfTasks.size()%></td>
                                                        <td>0</td>
                                                        <!--<td>
                                                            <button type="submit" class="btn btn-info btn-xs" data-toggle="modal" href="#viewTasks" onclick="update_User_Params('<%=username%>', '<%=email%>', '<%=phoneNumber%>', '<%=userType%>')"> View Tasks </button>
                                                        </td>-->
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

                    <div class="row">
                        <!--Analysis for orders volume-->
                        <div class="col-md-6">
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
                                            <div id="upcomingOrdersCone"></div>
                                        </div>
                                    </div>
                                </div><!-- ./smart-widget-inner -->
                            </div><!-- ./smart-widget -->
                        </div>

                        <!--End of volume analysis for orders-->

                        <!--Start of volume analysis for tasks-->
                        <div class="col-md-6">
                            <div id="D4" class="smart-widget widget-dark-blue">
                                <div class="smart-widget-header">
                                    Upcoming Tasks Volume Analysis
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
                                            <div id="upcomingTasksCone"></div>
                                        </div>
                                    </div>
                                </div><!-- ./smart-widget-inner -->
                            </div><!-- ./smart-widget -->
                        </div>        
                        <!--End of volume analysis for tasks-->                   
                    </div>

                    <!--Overdue orders analysis-->
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



                    <!--Overdue tasks analysis-->
                    <div class="row">
                        <div class="col-lg-12">
                            <div id="D3" class="smart-widget widget-dark-blue">
                                <div class="smart-widget-header">
                                    Overdue Tasks Analysis
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
                                            <div id="overdueTasks"></div>
                                        </div>

                                    </div>

                                    <div class="smart-widget-body no-padding">
                                        <div class="padding-md">
                                            <div class="row">
                                                <div class="col-md-6">
                                                    <div class="smart-widget-header"> Upcoming Tasks (Within 15 days of Deadline)</div><br>
                                                    <table class="table table-striped" id="upcomingTasksTable">
                                                        <thead>
                                                            <tr>
                                                                <th>Task Description</th>
                                                                <th>Entry Date</th>
                                                                <th>Task Owner</th>
                                                                <th>Task Deadline</th>
                                                            </tr>
                                                        </thead>

                                                        <tbody>
                                                            <%
                                                                for (int i = 0; i < upcomingTasksList.size(); i++) {
                                                                    List<Tasks> listOfTasksOnDay = upcomingTasksList.get(i);
                                                                    for (int j = 0; j < listOfTasksOnDay.size(); j++) {
                                                                        Tasks theTask = listOfTasksOnDay.get(j);
                                                                        String taskDescription = theTask.getTaskDescription();
                                                                        Date entryDate = theTask.getTaskDate();
                                                                        String taskOwner = theTask.getTaskOwner();
                                                                        Date taskDeadline = theTask.getTaskDeadline();
                                                            %>
                                                            <tr>
                                                                <td><%=taskDescription%></td>
                                                                <td><%=entryDate%></td>
                                                                <td><%=taskOwner%></td>
                                                                <td><%=taskDeadline%></td>
                                                            </tr>
                                                            <%
                                                                    }
                                                                }
                                                            %>
                                                        </tbody>
                                                    </table>
                                                </div>
                                                <div class="col-md-6">
                                                    <div class="smart-widget-header">Uncompleted Dued Tasks</div><br>

                                                    <table class="table table-striped" id="duedTasksTable">
                                                        <thead>
                                                            <tr>
                                                                <th>Task Description</th>
                                                                <th>Entry Date</th>
                                                                <th>Task Owner</th>
                                                                <th>Task Deadline</th>
                                                            </tr>
                                                        </thead>

                                                        <tbody>
                                                            <%
                                                                for (int i = 0; i < overdueTasksList.size(); i++) {
                                                                    List<Tasks> listOfTasksOnDay = overdueTasksList.get(i);
                                                                    for (int j = 0; j < listOfTasksOnDay.size(); j++) {
                                                                        Tasks theTask = listOfTasksOnDay.get(j);
                                                                        String taskDescription = theTask.getTaskDescription();
                                                                        Date entryDate = theTask.getTaskDate();
                                                                        String taskOwner = theTask.getTaskOwner();
                                                                        Date taskDeadline = theTask.getTaskDeadline();
                                                            %>
                                                            <tr>
                                                                <td><%=taskDescription%></td>
                                                                <td><%=entryDate%></td>
                                                                <td><%=taskOwner%></td>
                                                                <td><%=taskDeadline%></td>
                                                            </tr>
                                                            <%
                                                                    }
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
        <!-- Placed at the end of the document so the pages load faster -->

        <!--Modal for deleting tasks-->
        <div class="modal fade" id="deleteTaskModal">
            <div class="modal-dialog modal-sm">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                        <h4 class="modal-title" id="myModalLabel">Delete Task</h4>
                    </div>
                    <div class="modal-body">
                        <form id="deleteTaskForm" role="form" action="../deleteTaskDC">
                            <div class="form-group">
                                <p>Are you sure you want to delete this task?</p>
                            </div>
                            <input id="deleteTask" type="hidden" name="taskID" value="hamue">
                            <div class="row">
                                <hr>
                                <div class="col-lg-6"><a data-dismiss="modal" class="btn btn-danger block m-top-md">No</a></div>
                                <div class="col-lg-6"><a onclick="document.getElementById('deleteTaskForm').submit()"  class="btn btn-primary block m-top-md">Yes</a></div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
        <!--/Modal for deleting tasks/-->


        <!--Task Status Message for both successful Edit & deletion-->
        <div class="modal fade" id="taskActionStatus">
            <div class="modal-dialog modal-sm">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                        <h4 class="modal-title" id="myModalLabel">Status Message</h4>
                    </div>
                    <div class="modal-body">
                        <form role="form">
                            <div class="form-group">
                                <p id="taskInteractionMessage"><%                                    String taskActionStatus = (String) request.getParameter("taskActionStatus");
                                    if (taskActionStatus != null) {
                                    %>
                                    <%=taskActionStatus%>
                                    <%
                                        }
                                    %></p>
                            </div>
                            <div class="row">
                                <hr>
                                <div class="col-lg-12"><a data-dismiss="modal" class="btn btn-primary block m-top-md">ok</a></div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
        <!--/Task Status Message for both successful Edit & deletion-->

        <!-- Modal for editting tasks-->
        <div class="modal fade" id="editTaskModal">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                        <h4 class="modal-title">Edit Task</h4>
                    </div>
                    <div class="modal-body">
                        <form action="../editTaskDC" method="POST" id="editTaskForm" class="form-horizontal no-margin form-border">
                            <div class="form-group">
                                <label class="col-lg-2 control-label">Order ID</label>
                                <div class="col-lg-10">
                                    <p id="orderID_js" class="form-control-static">email@example.com</p>
                                    <input type="hidden" id="orderID_js_ED" name="orderID" type="text" value="">
                                </div><!-- /.col -->
                            </div><!-- /form-group -->
                            <div class="form-group">
                                <label class="col-lg-2 control-label">Task ID</label>
                                <div class="col-lg-10">
                                    <p id="taskID_js" class="form-control-static">email@example.com</p>
                                    <input type="hidden" id="taskID_js_ED" name="taskID" type="text" value="">
                                </div><!-- /.col -->
                            </div><!-- /form-group -->
                            <div class="form-group">
                                <label class="col-lg-2 control-label">Entry Date</label>
                                <div class="col-lg-10">
                                    <p id="taskDate_js" class="form-control-static">email@example.com</p>
                                    <input type="hidden" id="taskDate_js_ED" name="taskDate" type="text" value="">
                                </div><!-- /.col -->
                            </div><!-- /form-group -->
                            <div class="form-group">
                                <label class="col-lg-2 control-label">Task Owner</label>
                                <div class="col-lg-10">
                                    <input name="taskOwner" id="taskOwner_js" class="form-control" type="text" value="">
                                </div><!-- /.col -->
                            </div><!-- /form-group -->
                            <div class="form-group">
                                <label class="col-lg-2 control-label">Task Description</label>
                                <div class="col-lg-10">
                                    <input name="taskDescription" id="taskDescription_js" class="form-control" type="text" value="">
                                </div><!-- /.col -->
                            </div><!-- /form-group -->
                            <div class="form-group">
                                <label class="col-lg-2 control-label">Task Deadline</label>
                                <div class="col-lg-10">
                                    <div class="input-group">
                                        <input type="text" name="taskDeadline" id="taskDeadline_js" value="" class="datepicker-input-1 form-control">
                                        <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                    </div>
                                </div><!-- /.col -->
                            </div><!-- /form-group -->
                            <div class="form-group">
                                <label class="col-lg-2 control-label">Task Priority</label>
                                <div class="col-lg-10">
                                    <div class="radio inline-block">
                                        <div class="custom-radio m-right-xs">
                                            <input type="radio" id="inlineRadio1_high" value="High" name="taskPriority">
                                            <label for="inlineRadio1_high"></label>
                                        </div>
                                        <div class="inline-block vertical-top">High</div>
                                    </div>
                                    <div class="radio inline-block">
                                        <div class="custom-radio m-right-xs">
                                            <input type="radio" id="inlineRadio2_medium" value="Medium" name="taskPriority">
                                            <label for="inlineRadio2_medium"></label>
                                        </div>
                                        <div class="inline-block vertical-top">Medium</div>
                                    </div>
                                    <div class="radio inline-block">
                                        <div class="custom-radio m-right-xs">
                                            <input type="radio" id="inlineRadio3_low" value="Low" name="taskPriority">
                                            <label for="inlineRadio3_low"></label>
                                        </div>
                                        <div class="inline-block vertical-top">low</div>
                                    </div>
                                </div><!-- /.col -->
                            </div><!-- /form-group -->
                            <div class="form-group">
                                <label class="col-lg-2 control-label">Comments</label>
                                <div class="col-lg-10">
                                    <textarea class="form-control" id="taskComments_js" name="taskComment" rows="3" value=""></textarea>
                                </div><!-- /.col -->
                            </div><!-- /form-group -->
                        </form>
                    </div>
                    <div class="modal-footer">
                        <div class="col-lg-6"><a data-dismiss="modal" class="btn btn-danger block m-top-md">No</a></div>
                        <div class="col-lg-6"><a onclick="document.getElementById('editTaskForm').submit()"  class="btn btn-primary block m-top-md">Save Changes</a></div>
                    </div>
                </div>
            </div>
        </div>
        <!--/ Modal for editting tasks/-->


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

        <!--Highcharts scripts-->
        <script src="https://code.highcharts.com/highcharts.js"></script>
        <script src="https://code.highcharts.com/modules/exporting.js"></script>
        <script src="https://code.highcharts.com/modules/funnel.js"></script>

        <!-- Resources -->
        <script src="https://www.amcharts.com/lib/3/ammap.js"></script>
        <script src="https://www.amcharts.com/lib/3/maps/js/usaLow.js"></script>
        <script src="https://www.amcharts.com/lib/3/plugins/export/export.min.js"></script>
        <script src="https://www.amcharts.com/lib/3/themes/light.js"></script>


        <!-- Datatable -->
        <script src='<%=path%>/twitterBootstrap/js/jquery.dataTables.min.js'></script>
        <script src='<%=path%>/twitterBootstrap/js/uncompressed/dataTables.bootstrap.js'></script>

        <!--check if there is status message-->
        <script>

                            $(function () {

                                var theValue_taskDelOrEditStatus = document.getElementById("taskInteractionMessage").innerHTML;
                                var removedSpace_theValue_taskDelOrEditStatus = theValue_taskDelOrEditStatus.replace(/\s/g, '');
                                if (removedSpace_theValue_taskDelOrEditStatus !== null && removedSpace_theValue_taskDelOrEditStatus !== "" && typeof (removedSpace_theValue_taskDelOrEditStatus) !== "undefined") {
                                    $('#taskActionStatus').modal('show');
                                }
                            });

                            function updateTaskID(taskID) {
                                document.getElementById("deleteTask").value = taskID;
                            }

                            function update_Task_Params(orderID, taskID, taskDescription, entryDate, taskOwner, taskDeadline, taskPriority, taskComments) {
                                document.getElementById("orderID_js").innerHTML = orderID;
                                document.getElementById("orderID_js_ED").value = orderID;
                                document.getElementById("taskID_js").innerHTML = taskID;
                                document.getElementById("taskID_js_ED").value = taskID;
                                document.getElementById("taskDate_js").innerHTML = entryDate;
                                document.getElementById("taskDate_js_ED").value = entryDate;
                                document.getElementById("taskDescription_js").value = taskDescription;
                                document.getElementById("taskOwner_js").value = taskOwner;

                                document.getElementById("taskDeadline_js").value = taskDeadline;

                                if (taskPriority === 'High') {
                                    document.getElementById("inlineRadio1_high").checked = true;
                                } else if (taskPriority === 'Medium') {
                                    document.getElementById("inlineRadio2_medium").checked = true;
                                } else {
                                    document.getElementById("inlineRadio3_low").checked = true;
                                }


                                document.getElementById("taskComments_js").value = taskComments;

                            }

                            $(function () {
                                $('#OrdersDataTable').dataTable();
                            });
                            $(function () {
                                $('#TaskDataTable').dataTable();
                            });
                            $(function () {
                                $('#WorkloadDataTable').dataTable();
                            });


                            $(function () {
                                $('.datepicker-input-1').datetimepicker({
                                    pickTime: false,
                                    todayBtn: true,
                                    format: "YYYY-MM-DD"
                                });
                            });

        </script>

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

        <!--High Charts-->
        <script>
            //Cone chart for order analysis
            $(function () {
                Highcharts.chart('upcomingOrdersCone', {
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

            //Cone chart for tasks analysis
            $(function () {
                Highcharts.chart('upcomingTasksCone', {
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
                            name: 'Upcoming Tasks',
                            data: [
                                ['+14 Days', <%=upcomingTasksList.get(14).size()%>],
                                ['+13 Days', <%=upcomingTasksList.get(13).size()%>],
                                ['+12 Days', <%=upcomingTasksList.get(12).size()%>],
                                ['+11 Days', <%=upcomingTasksList.get(11).size()%>],
                                ['+10 Days', <%=upcomingTasksList.get(10).size()%>],
                                ['+9 Days', <%=upcomingTasksList.get(9).size()%>],
                                ['+8 Days', <%=upcomingTasksList.get(8).size()%>],
                                ['+7 Days', <%=upcomingTasksList.get(7).size()%>],
                                ['+6 Days', <%=upcomingTasksList.get(6).size()%>],
                                ['+5 Days', <%=upcomingTasksList.get(5).size()%>],
                                ['+4 Days', <%=upcomingTasksList.get(4).size()%>],
                                ['+3 Days', <%=upcomingTasksList.get(3).size()%>],
                                ['+2 Days', <%=upcomingTasksList.get(2).size()%>],
                                ['+1 Day', <%=upcomingTasksList.get(1).size()%>],
                                ['Today', <%=upcomingTasksList.get(0).size()%>]
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

            //Overdue tasks
            $(function () {
                Highcharts.chart('overdueTasks', {
                    chart: {
                        type: 'column'
                    },
                    title: {
                        text: ''
                    },
                    xAxis: {
                        categories: [
                            '14 days due',
                            '13 days due',
                            '12 days due',
                            '11 days due',
                            '10 days due',
                            '9 days due',
                            '8 days due',
                            '7 days due',
                            '6 days due',
                            '5 days due',
                            '4 days due',
                            '3 days due',
                            '2 days due',
                            '1 days due',
                            'due today'
                        ],
                        crosshair: true
                    },
                    yAxis: {
                        min: 0,
                        title: {
                            text: 'No. of Tasks'
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
                        '#7BCFAB'
                    ],
                    series: [{
                            name: '14 days due',
                            data: [<%=overdueTasksList.get(0).size()%>]

                        }, {
                            name: '13 days due',
                            data: [<%=overdueTasksList.get(1).size()%>]

                        },
                        {
                            name: '12 days due',
                            data: [<%=overdueTasksList.get(2).size()%>]

                        },
                        {
                            name: '11 days due',
                            data: [<%=overdueTasksList.get(3).size()%>]

                        },
                        {
                            name: '10 days due',
                            data: [<%=overdueTasksList.get(4).size()%>]

                        },
                        {
                            name: '9 days due',
                            data: [<%=overdueTasksList.get(5).size()%>]

                        },
                        {
                            name: '8 days due',
                            data: [<%=overdueTasksList.get(6).size()%>]

                        },
                        {
                            name: '7 days due',
                            data: [<%=overdueTasksList.get(7).size()%>]

                        },
                        {
                            name: '6 days due',
                            data: [<%=overdueTasksList.get(8).size()%>]

                        },
                        {
                            name: '5 days due',
                            data: [<%=overdueTasksList.get(9).size()%>]

                        },
                        {
                            name: '4 days due',
                            data: [<%=overdueTasksList.get(10).size()%>]

                        },
                        {
                            name: '3 days due',
                            data: [<%=overdueTasksList.get(11).size()%>]

                        },
                        {
                            name: '2 days due',
                            data: [<%=overdueTasksList.get(12).size()%>]

                        },
                        {
                            name: '1 days due',
                            data: [<%=overdueTasksList.get(13).size()%>]

                        },
                        {
                            name: 'due today',
                            data: [<%=overdueTasksList.get(14).size()%>]

                        }
                    ]
                });
            });

        </script>

        <script>


            $(function () {
                $('#upcomingOrdersTable').dataTable();
            });
            $(function () {
                $('#duedOrdersTable').dataTable();
            });

            $(function () {
                $('#upcomingTasksTable').dataTable();
            });
            $(function () {
                $('#duedTasksTable').dataTable();
            });
        </script>


    </body>
</html>
