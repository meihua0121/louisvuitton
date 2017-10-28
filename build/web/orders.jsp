<!DOCTYPE html>
<%@page import="entity.Events, entity.User, dao.EventsDAO, entity.Orders,dao.AnalyticsDAO, dao.OrdersDAO, java.util.*,java.text.*"%>
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
        </style>
    </head>
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

        //Come back to delete this laer
        EventsDAO eventsManager = new EventsDAO();
        List<Events> eventsList = eventsManager.retrieveEvents();

        OrdersDAO ordersManager = new OrdersDAO();
        List<Orders> ordersList = ordersManager.retrieveOrders();

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
                                    <!--<img src="image/profile1.jpg" alt="" class="img-circle inline-block user-profile-pic">-->
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
                            <li class="bg-palette3">
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
                                Orders
                            </div>
                            <div class="page-sub-header">
                                Welcome, Mr Luis Restrepo , <i class="fa fa-map-marker text-danger"></i> New York
                            </div>
                        </div>
                        <div class="col-sm-6 text-right text-left-sm p-top-sm">
                            <div class="btn-group">
                                <a class="btn btn-default hidden-print pull-right" onclick="window.print()"><i class="fa fa-print"></i> Print Orders Page</a>
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

                    <!--highmaps visualizations-->
                    <div class="row">
                        <div class="col-lg-12">
                            <div class="smart-widget widget-dark-blue">
                                <div class="smart-widget-header">
                                    Orders based on Geolocation
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
                                            <div id="EventMap1" style="height: 300px; min-width: 410px; max-width: 900px; margin: 0 auto"></div>
                                        </div>
                                    </div>
                                    <div class="smart-widget-body no-padding">
                                        <div class="padding-md">
                                            <input value="Download Table as .CSV" type="button" class="btn btn-success pull-right text-upper" onclick="downloadText($('#OrderDataTable').table2CSV(), 'Orders.csv', 'text/plain')">                                           
                                        </div>
                                    </div>
                                    <div class="smart-widget-body no-padding">
                                        <div class="padding-md ">
                                            <table class="table table-striped" id="OrderDataTable">
                                                <thead>
                                                    <tr>
                                                        <th style="display:none;">Event ID</th>
                                                        <th style="display:none;">Order ID</th>
                                                        <th style="display:none;">Entry Date</th>
                                                        <th>Order Number</th>
                                                        <th>Order Owner</th>
                                                        <th>Store Code</th>
                                                        <th>Product Family</th>
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
                                                        <td><%=orderNumber%></td>
                                                        <td><%=orderOwner%></td>
                                                        <td><%=storeCode%></td>
                                                        <td><%=productFamily%></td>
                                                        <td><%=orderQuantity%></td>
                                                        <td><%=shippingDate%></td>
                                                        <td><%=shippingMethod%></td>
                                                        <td><span class="label label-<%=progressLable%>"><%=orderProgress%>%</span></td>
                                                        <td width="10px"><%=comments%></td>
                                                        <td><span class="label label-<%=priorityLable%>"><%=orderPriority%></span></td>
                                                        <td style="display:none;"><%=trackingNumber%></td>
                                                        <td style="display:none;"><%=dateCompleted%></td>
                                                        <td>       
                                                            <button type="submit" class="btn btn-info btn-xs" data-toggle="modal" href="#editOrderModal" onclick="update_Order_Params('<%=eventID%>', '<%=orderID%>', '<%=orderOwner%>', '<%=storeCode%>', '<%=productFamily%>', '<%=orderQuantity%>', '<%=shippingDate%>', '<%=shippingMethod%>', '<%=orderPriority%>', '<%=comments%>', '<%=orderDate%>', '<%=orderNumber%>')">&nbsp; Edit &nbsp;&nbsp; </button>
                                                            <button type="submit" class="btn btn-danger btn-xs" data-toggle="modal" href="#deleteOrderModal" onclick="updateOrderID('<%=orderID%>')">Delete</button>                                                        
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
                                    Create New Orders
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
                                            <form action="addOrder" method="POST" id="addOrderForm" class="form-horizontal no-margin form-border">
                                                <div class="form-group">
                                                    <label class="col-lg-2 control-label">Order Template Filter</label>
                                                    <div class="col-lg-10">
                                                    <input id="orderTemplateNumber" class="form-control" type="text" placeholder="input order name">
                                                    </div>
                                                    <div class="col-lg-12"><br>
                                                        <div class="btn btn-primary pull-right text-upper" id="orderTemplate" data-role="button">Filter Orders</div>
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label class="col-lg-2 control-label">Event ID</label>
                                                    <div class="col-lg-10">
                                                        <select name="theEventID" class="select2 width-100">
                                                            <option value="None">None</option>
                                                            <%                                                                if (eventsList != null) {
                                                                    for (int i = 0; i < eventsList.size(); i++) {
                                                                        Events theEvent = eventsList.get(i);
                                                                        String eventID = theEvent.getEventID();
                                                                        String eventName = theEvent.getEventName();
                                                            %>
                                                            <option value="<%=eventID%>"><%=eventName%> (<%=eventID%>)</option>
                                                            <%
                                                                    }
                                                                }
                                                            %>
                                                        </select>
                                                    </div><!-- /.col -->
                                                </div><!-- /form-group -->
                                                <div class="form-group">
                                                    <label class="col-lg-2 control-label">Order Number</label>
                                                    <div class="col-lg-10">
                                                        <input name="orderNumber" class="form-control" type="text" placeholder="input order number">
                                                    </div><!-- /.col -->
                                                </div><!-- /form-group -->
                                                <div class="form-group">
                                                    <label class="col-lg-2 control-label">Order Owner</label>
                                                    <div class="col-lg-10">
                                                        <input name="orderOwner" class="form-control" type="text" placeholder="input order owner">
                                                    </div><!-- /.col -->
                                                </div><!-- /form-group -->
                                                <div class="form-group">
                                                    <label class="col-lg-2 control-label">Store Code</label>
                                                    <div class="col-lg-10">
                                                        <input name="storeCode" class="form-control" type="text" placeholder="input store code">
                                                    </div><!-- /.col -->
                                                </div><!-- /form-group -->
                                                <div class="form-group">
                                                    <label class="col-lg-2 control-label">Product Family</label>
                                                    <div class="col-lg-10">
                                                        <input name="productFamily" class="form-control" type="text" placeholder="input product family">
                                                    </div><!-- /.col -->
                                                </div><!-- /form-group -->
                                                <div class="form-group">
                                                    <label class="col-lg-2 control-label">Order Quantity</label>
                                                    <div class="col-lg-10">
                                                        <input name="productQuantity" class="form-control" type="text" placeholder="input order quantity">
                                                    </div><!-- /.col -->
                                                </div><!-- /form-group -->
                                                <div class="form-group">
                                                    <label class="col-lg-2 control-label">Shipping Date</label>
                                                    <div class="col-lg-10">
                                                        <div class="input-group">
                                                            <input type="text" name="shippingDate" id="theDatePick" value="" class="datepicker-input form-control">
                                                            <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                                        </div>
                                                    </div><!-- /.col -->
                                                </div><!-- /form-group -->
                                                <div class="form-group">
                                                    <label class="col-lg-2 control-label">Shipping Method</label>
                                                    <div class="col-lg-10">
                                                        <input type="text" name="shippingMethod" value="" class="form-control" placeholder="input shipping method">
                                                    </div><!-- /.col -->
                                                </div><!-- /form-group -->
                                                <div class="form-group">
                                                    <label class="col-lg-2 control-label">Order Priority</label>
                                                    <div class="col-lg-10">
                                                        <div class="radio inline-block">
                                                            <div class="custom-radio m-right-xs">
                                                                <input type="radio" id="inlineRadio4" value="High" name="orderPriority">
                                                                <label for="inlineRadio4"></label>
                                                            </div>
                                                            <div class="inline-block vertical-top">High</div>
                                                        </div>
                                                        <div class="radio inline-block">
                                                            <div class="custom-radio m-right-xs">
                                                                <input type="radio" id="inlineRadio5" value="Medium" name="orderPriority">
                                                                <label for="inlineRadio5"></label>
                                                            </div>
                                                            <div class="inline-block vertical-top">Medium</div>
                                                        </div>
                                                        <div class="radio inline-block">
                                                            <div class="custom-radio m-right-xs">
                                                                <input type="radio" id="inlineRadio6" value="Low" name="orderPriority">
                                                                <label for="inlineRadio6"></label>
                                                            </div>
                                                            <div class="inline-block vertical-top">low</div>
                                                        </div>
                                                    </div><!-- /.col -->
                                                </div>
                                                <div class="form-group">
                                                    <label class="col-lg-2 control-label">Comments</label>
                                                    <div class="col-lg-10">
                                                        <textarea class="form-control" name="orderComment" rows="3" ></textarea>
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
                                                        <a  href="#createOrderModal" data-toggle="modal" class="btn btn-success pull-right text-upper">Create New Order</a><!---->
                                                    </div>
                                                </div><!-- /form-group -->
                                            </form>
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

        <!--Model for confirming whether the user wants to create form-->
        <div class="modal fade" id="createOrderModal">
            <div class="modal-dialog modal-sm">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                        <h4 class="modal-title" id="myModalLabel">Create New Order</h4>
                    </div>
                    <div class="modal-body">
                        <form role="form">
                            <div class="form-group">
                                <p>Are you sure you want to create this new order?</p>
                            </div>
                            <div class="row">
                                <hr>
                                <div class="col-lg-6"><a data-dismiss="modal" class="btn btn-danger block m-top-md">No</a></div>
                                <div class="col-lg-6"><a onclick="document.getElementById('addOrderForm').submit()" class="btn btn-primary block m-top-md">Yes</a></div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <!--Modal for deleting orders-->
        <div class="modal fade" id="deleteOrderModal">
            <div class="modal-dialog modal-sm">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                        <h4 class="modal-title" id="myModalLabel">Delete Order</h4>
                    </div>
                    <div class="modal-body">
                        <form id="deleteOrderForm" role="form" action="deleteOrder">
                            <div class="form-group">
                                <p>Are you sure you want to delete this order?</p>
                            </div>
                            <input id="deleteOrder" type="hidden" name="orderID" value="hamue">
                            <div class="row">
                                <hr>
                                <div class="col-lg-6"><a data-dismiss="modal" class="btn btn-danger block m-top-md">No</a></div>
                                <div class="col-lg-6"><a onclick="document.getElementById('deleteOrderForm').submit()"  class="btn btn-primary block m-top-md">Yes</a></div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
        <!--/Modal for deleting orders/-->


        <!-- Modal for editting orders-->
        <div class="modal fade" id="editOrderModal">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                        <h4 class="modal-title">Edit Order</h4>
                    </div>
                    <div class="modal-body">
                        <form action="editOrder" method="POST" id="editOrderForm" class="form-horizontal no-margin form-border">
                            <div class="form-group">
                                <label class="col-lg-2 control-label">Order ID</label>
                                <div class="col-lg-10">
                                    <p id="orderID_js" class="form-control-static">email@example.com</p>
                                    <input type="hidden" id="orderID_js_ED" name="orderID" type="text" value="">
                                </div><!-- /.col -->
                            </div><!-- /form-group -->
                            <div class="form-group">
                                <label class="col-lg-2 control-label">Entry Date</label>
                                <div class="col-lg-10">
                                    <p id="orderDate_js" class="form-control-static">email@example.com</p>
                                    <input type="hidden" id="orderDate_js_ED" name="orderDate" type="text" value="">
                                </div><!-- /.col -->
                            </div><!-- /form-group -->
                            <div class="form-group">
                                <label class="col-lg-2 control-label">Event ID</label>
                                <div class="col-lg-10">
                                    <select name="eventID" class="select2 width-100">
                                        <option id="eventID_Select" value="None" selected="selected"></option>
                                        <%                                                                if (eventsList != null) {
                                                for (int i = 0; i < eventsList.size(); i++) {
                                                    Events theEvent = eventsList.get(i);
                                                    String eventID = theEvent.getEventID();
                                                    String eventName = theEvent.getEventName();
                                        %>
                                        <option value="<%=eventID%>"><%=eventName%> (<%=eventID%>)</option>
                                        <%
                                                }
                                            }
                                        %>
                                        <option value="None">None</option>
                                    </select>
                                </div><!-- /.col -->
                            </div><!-- /form-group -->

                            <div class="form-group">
                                <label class="col-lg-2 control-label">Order Number</label>
                                <div class="col-lg-10">
                                    <input name="orderNumber" id="orderNumber_js" class="form-control" type="text" value="">
                                </div><!-- /.col -->
                            </div><!-- /form-group -->
                            <div class="form-group">
                                <label class="col-lg-2 control-label">Order Owner</label>
                                <div class="col-lg-10">
                                    <input name="orderOwner" id="orderOwner_js" class="form-control" type="text" value="">
                                </div><!-- /.col -->
                            </div><!-- /form-group -->
                            <div class="form-group">
                                <label class="col-lg-2 control-label">Store Code</label>
                                <div class="col-lg-10">
                                    <input name="storeCode" id="storeCode_js" class="form-control" type="text" value="">
                                </div><!-- /.col -->
                            </div><!-- /form-group -->
                            <div class="form-group">
                                <label class="col-lg-2 control-label">Product Family</label>
                                <div class="col-lg-10">
                                    <input name="productFamily" id="productFamily_js" class="form-control" type="text" value="">
                                </div><!-- /.col -->
                            </div><!-- /form-group -->
                            <div class="form-group">
                                <label class="col-lg-2 control-label">Order Quantity</label>
                                <div class="col-lg-10">
                                    <input name="orderQuantity" id="orderQuantity_js" class="form-control" type="text" value="">
                                </div><!-- /.col -->
                            </div><!-- /form-group -->
                            <div class="form-group">
                                <label class="col-lg-2 control-label">Shipping Date</label>
                                <div class="col-lg-10">
                                    <div class="input-group">
                                        <input type="text" name="shippingDate" id="shippingDate_js" value="" class="datepicker-input-1 form-control">
                                        <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                    </div>
                                </div><!-- /.col -->
                            </div><!-- /form-group -->
                            <div class="form-group">
                                <label class="col-lg-2 control-label">Shipping Method</label>
                                <div class="col-lg-10">
                                    <input type="text" name="shippingMethod" id="shippingMethod_js" value="" class="form-control" placeholder="input shipping method">
                                </div><!-- /.col -->
                            </div><!-- /form-group -->
                            <div class="form-group">
                                <label class="col-lg-2 control-label">Order Priority</label>
                                <div class="col-lg-10">
                                    <div class="radio inline-block">
                                        <div class="custom-radio m-right-xs">
                                            <input type="radio" id="inlineRadio4_high" value="High" name="orderPriority">
                                            <label for="inlineRadio4_high"></label>
                                        </div>
                                        <div class="inline-block vertical-top">High</div>
                                    </div>
                                    <div class="radio inline-block">
                                        <div class="custom-radio m-right-xs">
                                            <input type="radio" id="inlineRadio5_medium" value="Medium" name="orderPriority">
                                            <label for="inlineRadio5_medium"></label>
                                        </div>
                                        <div class="inline-block vertical-top">Medium</div>
                                    </div>
                                    <div class="radio inline-block">
                                        <div class="custom-radio m-right-xs">
                                            <input type="radio" id="inlineRadio6_low" value="Low" name="orderPriority">
                                            <label for="inlineRadio6_low"></label>
                                        </div>
                                        <div class="inline-block vertical-top">low</div>
                                    </div>
                                </div><!-- /.col -->
                            </div><!-- /form-group -->
                            <div class="form-group">
                                <label class="col-lg-2 control-label">Comments</label>
                                <div class="col-lg-10">
                                    <textarea class="form-control" id="orderComments_js" name="orderComment" rows="3" value=""></textarea>
                                </div><!-- /.col -->
                            </div><!-- /form-group -->
                        </form>
                    </div>
                    <div class="modal-footer">
                        <div class="col-lg-6"><a data-dismiss="modal" class="btn btn-danger block m-top-md">No</a></div>
                        <div class="col-lg-6"><a onclick="document.getElementById('editOrderForm').submit()"  class="btn btn-primary block m-top-md">Save Changes</a></div>
                    </div>
                </div>
            </div>
        </div>
        <!--/ Modal for editting orders/-->

        <!--Order Status Message for both successful Edit & deletion-->
        <div class="modal fade" id="orderActionStatus">
            <div class="modal-dialog modal-sm">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                        <h4 class="modal-title" id="myModalLabel">Status Message</h4>
                    </div>
                    <div class="modal-body">
                        <form role="form">
                            <div class="form-group">
                                <p id="orderInteractionMessage"><%                                    String orderActionStatus = (String) request.getParameter("orderActionStatus");
                                    if (orderActionStatus != null) {
                                    %>
                                    <%=orderActionStatus%>
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

        <!--Order creation status-->
        <div class="modal fade" id="orderStatus">
            <div class="modal-dialog modal-sm">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                        <h4 class="modal-title" id="myModalLabel">Order Status Message</h4>
                    </div>
                    <div class="modal-body">
                        <form role="form">
                            <div class="form-group">
                                <p id="orderStatusMessage"><%                                    String orderStatus = (String) request.getAttribute("OrderMessage");
                                    if (orderStatus != null) {
                                    %>
                                    <%=orderStatus%>
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
        <a href="#" class="scroll-to-top hidden-print"><i class="fa fa-chevron-up fa-lg"></i></a>
        <a href="#" class="scroll-to-top hidden-print"><i class="fa fa-chevron-up fa-lg"></i></a>
        <!-- Placed at the end of the document so the pages load faster -->

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

        <!-- Resources -->
        <script src="https://www.amcharts.com/lib/3/ammap.js"></script>
        <script src="https://www.amcharts.com/lib/3/maps/js/usaLow.js"></script>
        <script src="https://www.amcharts.com/lib/3/plugins/export/export.min.js"></script>
        <script src="https://www.amcharts.com/lib/3/themes/light.js"></script>


        <!-- Datatable -->
        <script src='twitterBootstrap/js/jquery.dataTables.min.js'></script>
        <script src='twitterBootstrap/js/uncompressed/dataTables.bootstrap.js'></script>

        <!--check if there is status message-->
        <script>
                            $(function () {
                                var theValue_orderCreation = document.getElementById("orderStatusMessage").innerHTML;
                                var theValue_orderDelOrEditStatus = document.getElementById("orderInteractionMessage").innerHTML;

                                var removedSpace_theValue_orderCreation = theValue_orderCreation.replace(/\s/g, '');
                                var removedSpace_theValue_orderDelOrEditStatus = theValue_orderDelOrEditStatus.replace(/\s/g, '');

                                if (removedSpace_theValue_orderCreation !== null && removedSpace_theValue_orderCreation !== "" && typeof (removedSpace_theValue_orderCreation) !== "undefined") {
                                    $('#orderStatus').modal('show');
                                }
                                if (removedSpace_theValue_orderDelOrEditStatus !== null && removedSpace_theValue_orderDelOrEditStatus !== "" && typeof (removedSpace_theValue_orderDelOrEditStatus) !== "undefined") {
                                    $('#orderActionStatus').modal('show');
                                }
                            });

                            function updateOrderID(orderID) {
                                document.getElementById("deleteOrder").value = orderID;
                            }
                            function update_Order_Params(eventID, orderID, orderOwner, storeCode, productFamily, orderQuantity, shippingDate, shippingMethod, orderPriority, comments, orderDate, orderNumber) {
                                //document.getElementById("eventID_js").innerHTML = eventID;
                                //document.getElementById("eventID_js_ED").value = eventID;
                                console.log("Warning");

                                document.getElementById("orderID_js").innerHTML = orderID;
                                document.getElementById("orderID_js_ED").value = orderID;
                                document.getElementById("eventID_Select").innerHTML = "Current: " + eventID;
                                document.getElementById("eventID_Select").value = eventID;
                                document.getElementById("orderNumber_js").value = orderNumber;
                                document.getElementById("orderDate_js").innerHTML = orderDate;
                                document.getElementById("orderDate_js_ED").value = orderDate;
                                document.getElementById("orderOwner_js").value = orderOwner;
                                document.getElementById("storeCode_js").value = storeCode;
                                document.getElementById("productFamily_js").value = productFamily;
                                document.getElementById("orderQuantity_js").value = orderQuantity;
                                document.getElementById("shippingMethod_js").value = shippingMethod;

                                if (orderPriority === 'High') {
                                    document.getElementById("inlineRadio4_high").checked = true;
                                } else if (orderPriority === 'Medium') {
                                    document.getElementById("inlineRadio5_medium").checked = true;
                                } else {
                                    document.getElementById("inlineRadio6_low").checked = true;
                                }

                                var shippingDate_format_arr = shippingDate.split("-");
                                var shippingDate_format = shippingDate_format_arr[0] + "-" + shippingDate_format_arr[1] + "-" + shippingDate_format_arr[2];
                                document.getElementById("shippingDate_js").value = shippingDate_format;

                                document.getElementById("orderComments_js").value = comments;

                            }
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

         <script>
            $(function (){
                var ordersArray = <%=OrdersDAO.stringOrdersforTemplate(OrdersDAO.retrieveOrders())%>;
                $("#orderTemplate").click(function ()
                {
                    var orderNumber = document.getElementById("orderTemplateNumber").value;
                    var orderFiltered = $.grep(ordersArray, function (o) {
                        return o.number.toLowerCase().includes(orderNumber.toLowerCase());
                    });
                    
                    $('[name$=orderNumber]').val(orderFiltered[0].number);
                    $('[name$=orderOwner]').val(orderFiltered[0].owner);
                    $('[name$=storeCode]').val(orderFiltered[0].storeCode); 
                    $('[name$=productFamily]').val(orderFiltered[0].productFamily);
                    $('[name$=productQuantity]').val(orderFiltered[0].quantity);
                    $('[name$=orderComment]').val(orderFiltered[0].comments);
                    $('[name$=shippingMethod]').val(orderFiltered[0].shippingMethod);
                    if (orderFiltered[0].priority === "High") {
                        $("#inlineRadio4").prop("checked", true);
                    }
                    if (orderFiltered[0].priority === "Medium") {
                        $("#inlineRadio5").prop("checked", true);
                    }
                    if (orderFiltered[0].priority === "Low") {
                        $("#inlineRadio6").prop("checked", true);
                    }
                    $('[name$=shippingDate]').val(orderFiltered[0].shippingDate);
                });
            });           
        </script>
        
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
                $('#OrderDataTable').dataTable();
            });

            //Select2
            $('.select2').select2();

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

                document.getElementById("theDatePick").value = year + "-" + month + "-" + day
                //Date & Time Picker
            });
        </script>
    </body>
</html>
