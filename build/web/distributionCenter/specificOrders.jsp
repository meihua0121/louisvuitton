<!DOCTYPE html>
<%@page import="entity.Events,  entity.Tasks, entity.Orders,dao.*, entity.User, java.util.*,java.text.*"%>
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

        OrdersDAO ordersManager = new OrdersDAO();
        //List<Orders> ordersList = ordersManager.retrieveOrders();

        String orderID = request.getParameter("orderID");
        Orders specificOrder = ordersManager.searchOrders(orderID);

        //Come back to delete this laer
        EventsDAO eventsManager = new EventsDAO();
        List<Events> eventsList = eventsManager.retrieveEvents();

        TasksDAO tasksManager = new TasksDAO();
        List<Tasks> listOfTasksForASpecificOrder = tasksManager.filterTasks("orderID", orderID);

        LoginDAO loginManager = new LoginDAO();
        Hashtable<String, User> listOfUsers = loginManager.retrieveUsers();

        AnalyticsDAO analyticsEngine = new AnalyticsDAO();
        List<String> lastestnotifications = analyticsEngine.returnLatestNotifications();
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
                            <img src="../image/LV_logo.jpg" alt="HTML5 Icon" style="width:30px;height:30px;">
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
                        </ul>
                    </div>
                </div><!-- sidebar-inner -->
            </aside>

            <div class="main-container">
                <div class="padding-md">

                    <ul class="breadcrumb">
                        <li><span class="primary-font"><i class="icon-home"></i></span><a href="index.html"> Home</a></li>
                        <li>Orders</li>	 
                        <li>#<%=specificOrder.getOrderID()%></li>	 
                    </ul>

                    <div class="row">
                        <div class="col-lg-12">
                            <div class="clearfix">
                                <div class="pull-left">
                                    <span class="img-demo bg-dark-blue">
                                        LV
                                    </span>
                                    <div class="pull-left m-left-sm">
                                        <h3 class="m-bottom-xs m-top-xs">Order#00023897</h3>
                                        <span class="text-muted">Made by: <%=specificOrder.getOrderOwner()%></span>
                                    </div>
                                </div>
                                <div class="pull-right">
                                    <h5><strong>Order Date:</strong></h5>
                                    <strong><%=specificOrder.getOrderDate()%></strong>
                                </div>
                            </div>
                            <hr>
                            <a class="btn btn-default hidden-print pull-right" onclick="window.print()" id="invoicePrint"><i class="fa fa-print"></i> Print Order</a>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-lg-12">
                            <div class="smart-widget widget-dark-blue">
                                <div class="smart-widget-header">
                                    Order Details
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
                                            <table class="table table-striped" id="OrdersDataTable">
                                                <thead>
                                                    <tr>
                                                        <th>Order Number</th>
                                                        <th>Event ID</th>
                                                        <th>Order ID</th>
                                                        <th>Order Owner</th>
                                                        <th>Store Code</th>
                                                        <th>Product Family</th>
                                                        <th>Order Quantity</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <%
                                                        String orderNumber = specificOrder.getOrderNumber();
                                                        String eventID = specificOrder.getEventID();
                                                        Date orderDate = specificOrder.getOrderDate();
                                                        String orderOwner = specificOrder.getOrderOwner();
                                                        String storeCode = specificOrder.getStoreCode();
                                                        String productFamily = specificOrder.getProductFamily();
                                                        int orderQuantity = specificOrder.getOrderQuantity();
                                                        Date shippingDate = specificOrder.getShippingDate();
                                                        String shippingMethod = specificOrder.getShippingMethod();
                                                        String comments = specificOrder.getOrderComments();
                                                        //Perform priority checking for events
                                                        String orderPriority = specificOrder.getPriority();
                                                        String priorityLable = "";
                                                        if (orderPriority.equals("High")) {
                                                            priorityLable = "danger";
                                                        } else if (orderPriority.equals("Medium")) {
                                                            priorityLable = "warning";
                                                        } else {
                                                            priorityLable = "success";
                                                        }

                                                        //Perform event process status filtering
                                                        String orderProcessStatus = specificOrder.getOrderStatus();
                                                        int orderProgress = Integer.parseInt(orderProcessStatus);
                                                        String progressLable = "";
                                                        if (orderProgress <= 40) {
                                                            progressLable = "danger";
                                                        } else if (orderProgress < 100) {
                                                            progressLable = "warning";
                                                        } else {
                                                            progressLable = "success";
                                                        }

                                                        String trackingNumber = specificOrder.getTrackingNumber();
                                                        if (trackingNumber.equals("")) {
                                                            trackingNumber = "None";
                                                        }

                                                        Date dateCompleted = specificOrder.getDateCompleted();

                                                    %>
                                                    <tr>
                                                        <td><%=orderNumber%></td>
                                                        <td><%=eventID%></td>
                                                        <td><%=orderID%></td>
                                                        <td><%=orderOwner%></td>
                                                        <td><%=storeCode%></td>
                                                        <td><%=productFamily%></td>
                                                        <td><%=orderQuantity%></td>
                                                    </tr>
                                                </tbody>
                                            </table>

                                            <table class="table table-striped" id="OrdersDataTable">
                                                <thead>
                                                    <tr>
                                                        <th>Shipping Date</th>
                                                        <th>Shipping Method</th>
                                                        <th>Order Status</th>
                                                        <th>Tracking Number</th>
                                                        <th>Priority</th>
                                                        <th>Comments</th>
                                                        <th>Date Completed</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <tr>
                                                        <td><%=shippingDate%></td>
                                                        <td><%=shippingMethod%></td>
                                                        <td><span class="label label-<%=progressLable%>"><%=orderProgress%>%</span></td>
                                                        <td><%=trackingNumber%></td>
                                                        <td><span class="label label-<%=priorityLable%>"><%=orderPriority%></span></td>
                                                        <td width="10px"><%=comments%></td>
                                                        <td><%=dateCompleted%></td>
                                                    </tr>
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
                                    Update Order Details
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
                                            <div class="row">
                                                <div class="col-lg-12">
                                                    <form action="<%=path%>/editOrderDC" method="POST" id="editOrderForm" class="form-horizontal no-margin form-border">
                                                        <input name="orderID" type="hidden" value="<%=orderID%>">
                                                        <div class="form-group">
                                                            <label class="col-lg-2 control-label">Tracking Number</label>
                                                            <div class="col-lg-10">
                                                                <input name="trackingNumber" value="<%=trackingNumber%>" class="form-control" type="text" placeholder="input tracking number">
                                                            </div><!-- /.col -->
                                                        </div><!-- /form-group -->
                                                        <div class="form-group">
                                                            <label class="col-lg-2 control-label">Order Progress</label>
                                                            <div class="col-lg-10">
                                                                <input name="theOrderProgress" value="<%=orderProgress%>" class="form-control" type="text" placeholder="input order progress">
                                                            </div><!-- /.col -->
                                                        </div><!-- /form-group -->
                                                        <div class="form-group">
                                                            <label class="col-lg-2 control-label">Completed Order(?)</label>
                                                            <div class="col-lg-10">
                                                                <%
                                                                    if (dateCompleted != null) {
                                                                %>
                                                                <div class="radio inline-block">
                                                                    <div class="custom-radio m-right-xs">
                                                                        <input type="radio" id="inlineRadio1" value="Yes" name="orderCompletion" checked="checked">
                                                                        <label for="inlineRadio1"></label>
                                                                    </div>
                                                                    <div class="inline-block vertical-top">Yes</div>
                                                                </div>
                                                                <div class="radio inline-block">
                                                                    <div class="custom-radio m-right-xs">
                                                                        <input type="radio" id="inlineRadio2" value="No" name="orderCompletion">
                                                                        <label for="inlineRadio2"></label>
                                                                    </div>
                                                                    <div class="inline-block vertical-top">No</div>
                                                                </div>
                                                                <%
                                                                } else {
                                                                %>
                                                                <div class="radio inline-block">
                                                                    <div class="custom-radio m-right-xs">
                                                                        <input type="radio" id="inlineRadio1" value="Yes" name="orderCompletion">
                                                                        <label for="inlineRadio1"></label>
                                                                    </div>
                                                                    <div class="inline-block vertical-top">Yes</div>
                                                                </div>
                                                                <div class="radio inline-block">
                                                                    <div class="custom-radio m-right-xs">
                                                                        <input type="radio" id="inlineRadio2" value="No" name="orderCompletion" checked="checked">
                                                                        <label for="inlineRadio2"></label>
                                                                    </div>
                                                                    <div class="inline-block vertical-top">No</div>
                                                                </div>
                                                                <%
                                                                    }
                                                                %>


                                                            </div><!-- /.col -->
                                                        </div><!-- /form-group -->
                                                        <div class="form-group">
                                                            <div class="col-lg-12">
                                                                <a  href="#editOrderModal" data-toggle="modal" class="btn btn-success pull-right text-upper">Update Order</a><!---->
                                                            </div>
                                                        </div><!-- /form-group -->
                                                    </form>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div><!-- ./smart-widget-inner -->
                            </div><!-- ./smart-widget -->
                        </div>

                        <div class="col-lg-12">
                            <div class="smart-widget widget-dark-blue">
                                <div class="smart-widget-header">
                                    Tasks Management
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

                                            <div class="row">
                                                <div class="col-lg-6">
                                                    <h5><strong>Current Tasks Assignment</strong></h5>
                                                </div>
                                                <div class="col-lg-12">
                                                    <table class="table table-striped" id="EventDataTable">
                                                        <thead>
                                                            <tr>
                                                                <th>Order ID</th>
                                                                <th>Task ID</th>
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
                                                            <%
                                                                if (listOfTasksForASpecificOrder != null) {
                                                                    for (int i = 0; i < listOfTasksForASpecificOrder.size(); i++) {
                                                                        Tasks theTask = listOfTasksForASpecificOrder.get(i);
                                                                        String taskID = theTask.getTaskID();
                                                                        String taskDescription = theTask.getTaskDescription();
                                                                        Date entryDate = theTask.getTaskDate();
                                                                        String taskOwner = theTask.getTaskOwner();
                                                                        Date taskDeadline = theTask.getTaskDeadline();
                                                                        String taskComments = theTask.getTaskComments();
                                                                        //Perform priority checking for events
                                                                        String taskPriority = theTask.getPriority();
                                                                        String priorityLable_task = "";
                                                                        if (taskPriority.equals("High")) {
                                                                            priorityLable_task = "danger";
                                                                        } else if (taskPriority.equals("Medium")) {
                                                                            priorityLable_task = "warning";
                                                                        } else {
                                                                            priorityLable_task = "success";
                                                                        }

                                                                        //Perform event process status filtering
                                                                        String taskProcessStatus = theTask.getTaskProcessStatus();
                                                                        int taskProgress = Integer.parseInt(taskProcessStatus);
                                                                        String progressLable_task = "";
                                                                        if (taskProgress <= 40) {
                                                                            progressLable_task = "danger";
                                                                        } else if (taskProgress < 100) {
                                                                            progressLable_task = "warning";
                                                                        } else {
                                                                            progressLable_task = "success";
                                                                        }
                                                            %>
                                                            <tr>
                                                                <td><%=orderID%></td>
                                                                <td><%=taskID%></td>
                                                                <td><%=taskDescription%></td>
                                                                <td><%=entryDate%></td>
                                                                <td><%=taskOwner%></td>
                                                                <td><%=taskDeadline%></td>
                                                                <td><span class="label label-<%=priorityLable_task%>"><%=taskPriority%></span></td>
                                                                <td><span class="label label-<%=progressLable_task%>"><%=taskProgress%>%</span></td>
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

                                            <!--row-->
                                            <div class="row">
                                                <div class="col-lg-6">
                                                    <h5><strong>Add New Tasks</strong></h5>
                                                </div>
                                                <div class="col-lg-12">
                                                    <form action="<%=path%>/addTaskDC" method="POST" id="addTaskDC" class="form-horizontal no-margin form-border">

                                                        <div class="form-group">
                                                            <label class="col-lg-2 control-label">Order ID</label>
                                                            <div class="col-lg-10">
                                                                <p id="orderID_js" class="form-control-static"><%=orderID%></p>
                                                                <input type="hidden" id="orderID_js_ED" name="theOrderID" type="text" value="<%=orderID%>">
                                                            </div><!-- /.col -->
                                                        </div><!-- /form-group -->

                                                        <div class="form-group">
                                                            <label class="col-lg-2 control-label">Task Description</label>
                                                            <div class="col-lg-10">
                                                                <input name="taskDescription" class="form-control" type="text" placeholder="input task description">
                                                            </div><!-- /.col -->
                                                        </div><!-- /form-group -->
                                                        <div class="form-group">
                                                            <label class="col-lg-2 control-label">Assign To</label>
                                                            <div class="col-lg-10">
                                                                <select name="assignTo" class="select2 width-100">
                                                                    <option>None</option>
                                                                    <%                                                                        Set<String> keys = listOfUsers.keySet();
                                                                        for (String key : keys) {
                                                                            User theUser = listOfUsers.get(key);
                                                                            String email = theUser.getEmail();
                                                                    %>     
                                                                    <option value="<%=email%>"><%=theUser.getUserName()%> (<%=email%>)</option>
                                                                    <%
                                                                        }
                                                                    %>
                                                                </select>                                                    
                                                            </div><!-- /.col -->
                                                        </div><!-- /form-group -->
                                                        <div class="form-group">
                                                            <label class="col-lg-2 control-label">Task Deadline</label>
                                                            <div class="col-lg-10">
                                                                <div class="input-group">
                                                                    <input type="text" name="taskDeadline" value="" class="datepicker-input form-control">
                                                                    <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                                                </div>
                                                            </div><!-- /.col -->
                                                        </div><!-- /form-group -->
                                                        <div class="form-group">
                                                            <label class="col-lg-2 control-label">Task Priority</label>
                                                            <div class="col-lg-10">
                                                                <div class="radio inline-block">
                                                                    <div class="custom-radio m-right-xs">
                                                                        <input type="radio" id="inlineRadio4" value="High" name="taskPriority">
                                                                        <label for="inlineRadio4"></label>
                                                                    </div>
                                                                    <div class="inline-block vertical-top">High</div>
                                                                </div>
                                                                <div class="radio inline-block">
                                                                    <div class="custom-radio m-right-xs">
                                                                        <input type="radio" id="inlineRadio5" value="Medium" name="taskPriority">
                                                                        <label for="inlineRadio5"></label>
                                                                    </div>
                                                                    <div class="inline-block vertical-top">Medium</div>
                                                                </div>
                                                                <div class="radio inline-block">
                                                                    <div class="custom-radio m-right-xs">
                                                                        <input type="radio" id="inlineRadio6" value="Low" name="taskPriority">
                                                                        <label for="inlineRadio6"></label>
                                                                    </div>
                                                                    <div class="inline-block vertical-top">low</div>
                                                                </div>
                                                            </div><!-- /.col -->
                                                        </div>
                                                        <div class="form-group">
                                                            <label class="col-lg-2 control-label">Comments</label>
                                                            <div class="col-lg-10">
                                                                <textarea class="form-control" name="taskComment" rows="3" ></textarea>
                                                            </div><!-- /.col -->
                                                        </div><!-- /form-group -->
                                                        <div class="form-group">
                                                            <label class="col-lg-2 control-label">Send Email Notification (?)</label>
                                                            <div class="col-lg-10">
                                                                <div class="radio inline-block">
                                                                    <div class="custom-radio m-right-xs">
                                                                        <input type="radio" id="inlineRadio7" value="Yes" name="sendEmail" onclick="document.getElementById('emailmessagecustomizer').style.display = 'block'">
                                                                        <label for="inlineRadio7"></label>
                                                                    </div>
                                                                    <div class="inline-block vertical-top">Yes</div>
                                                                </div>
                                                                <div class="radio inline-block">
                                                                    <div class="custom-radio m-right-xs">
                                                                        <input type="radio" id="inlineRadio8" value="No" name="sendEmail" checked="checked" onclick="document.getElementById('emailmessagecustomizer').style.display = 'none'">
                                                                        <label for="inlineRadio8"></label>
                                                                    </div>
                                                                    <div class="inline-block vertical-top">No</div>
                                                                </div>
                                                            </div><!-- /.col -->
                                                        </div>
                                                        <div class="form-group" id="emailmessagecustomizer" style="display: none;">
                                                            <label class="col-lg-2 control-label">Email Message</label>
                                                            <div class="col-lg-10">
                                                                <textarea class="form-control" name="emailMessage" rows="5" ></textarea>
                                                            </div><!-- /.col -->
                                                        </div><!-- /form-group -->
                                                        <div class="form-group">
                                                            <div class="col-lg-12">
                                                                <a  href="#createTaskModal" data-toggle="modal" class="btn btn-success pull-right text-upper">Create New Task</a><!---->
                                                            </div>
                                                        </div><!-- /form-group -->
                                                    </form>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div><!-- ./smart-widget-inner -->
                            </div><!-- ./smart-widget -->
                        </div>
                    </div>
                </div>


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

        <!--Model for confirming whether the user wants to create form-->
        <div class="modal fade" id="editOrderModal">
            <div class="modal-dialog modal-sm">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                        <h4 class="modal-title" id="myModalLabel">Create New Order</h4>
                    </div>
                    <div class="modal-body">
                        <form role="form">
                            <div class="form-group">
                                <p>Are you sure you want to edit this new order?</p>
                            </div>
                            <div class="row">
                                <hr>
                                <div class="col-lg-6"><a data-dismiss="modal" class="btn btn-danger block m-top-md">No</a></div>
                                <div class="col-lg-6"><a onclick="document.getElementById('editOrderForm').submit()" class="btn btn-primary block m-top-md">Yes</a></div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>

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
                        <form action="<%=path%>/editTaskDC" method="POST" id="editTaskForm" class="form-horizontal no-margin form-border">
                            <div class="form-group">
                                <label class="col-lg-2 control-label">Order ID</label>
                                <div class="col-lg-10">
                                    <p id="orderID_js" class="form-control-static">email@example.com</p>
                                    <input type="hidden" id="orderID_js_ED" name="orderID" type="text" value="<%=orderID%>">
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

        <!-- Small modal -->
        <div class="modal fade" id="createTaskModal">
            <div class="modal-dialog modal-sm">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                        <h4 class="modal-title" id="myModalLabel">Create New Task</h4>
                    </div>
                    <div class="modal-body">
                        <form role="form">
                            <div class="form-group">
                                <p>Are you sure you want to create this new task?</p>
                            </div>
                            <div class="row">
                                <hr>
                                <div class="col-lg-6"><a data-dismiss="modal" class="btn btn-danger block m-top-md">No</a></div>
                                <div class="col-lg-6"><a onclick="document.getElementById('addTaskDC').submit()" class="btn btn-primary block m-top-md">Yes</a></div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>

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

        <!--check if there is status message-->
        <script>

                                    $(function () {
                                        $('.datepicker-input').datetimepicker({
                                            pickTime: false,
                                            todayBtn: true,
                                            format: "YYYY-MM-DD"
                                        });
                                    });

                                    $(function () {
                                        $('.datepicker-input-1').datetimepicker({
                                            pickTime: false,
                                            todayBtn: false,
                                            format: "YYYY-MM-DD"
                                        });
                                    });


        </script>
        <script>

            $(function () {
                var theValue_taskCreation = document.getElementById("taskStatusMessage").innerHTML;
                var theValue_taskDelOrEditStatus = document.getElementById("taskInteractionMessage").innerHTML;

                var removedSpace_theValue_taskCreation = theValue_taskCreation.replace(/\s/g, '');
                var removedSpace_theValue_taskDelOrEditStatus = theValue_taskDelOrEditStatus.replace(/\s/g, '');
                if (removedSpace_theValue_taskCreation !== null && removedSpace_theValue_taskCreation !== "" && typeof (removedSpace_theValue_taskCreation) !== "undefined") {
                    $('#taskStatus').modal('show');
                }
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

            //Select2
            $('.select2').select2();


            $(function () {
                var currentDate = new Date()
                var day = currentDate.getDate()
                var month = currentDate.getMonth() + 1
                var year = currentDate.getFullYear()
                if (month < 10) {
                    month = "0" + month;
                }
                if (day < 10) {
                    day = "0" + day;
                }
                document.getElementById("theDatePick").value = year + "/" + month + "/" + day
                //Date & Time Picker
            });


        </script>
    </body>
</html>
