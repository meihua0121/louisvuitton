<!DOCTYPE html>
<%@page import="entity.Events, entity.User, dao.AnalyticsDAO, dao.EventsDAO, java.util.*,java.text.*"%>
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
        }else{
            user = (User)javaObject;
            nameOfUser = user.getUserName();
        }

        EventsDAO eventsManager = new EventsDAO();
        List<Events> eventsList = eventsManager.retrieveEvents();
        Date today = new Date(Calendar.getInstance().getTime().getTime());

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
                                Events
                            </div>
                            <div class="page-sub-header">
                                Welcome, Mr <%=nameOfUser%> , <i class="fa fa-map-marker text-danger"></i> New York
                            </div>
                        </div>
                        <div class="col-sm-6 text-right text-left-sm p-top-sm">
                            <div class="btn-group">
                                <a class="btn btn-default hidden-print pull-right" onclick="window.print()"><i class="fa fa-print"></i> Print Events Page</a>
                                <ul class="dropdown-menu pull-right" role="menu">
                                    <li><a href="#">Events</a></li>
                                    <li><a href="#">Tasks</a></li>
                                    <li><a href="#">Orders</a></li>
                                </ul>
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
                                            <div id="EventMap1" style="height: 300px; min-width: 410px; max-width: 900px; margin: 0 auto"></div>
                                        </div>
                                    </div>
                                    <div class="smart-widget-body no-padding">
                                        <div class="padding-md">
                                            <input value="Download Table as .CSV" type="button" class="btn btn-success pull-right text-upper" onclick="downloadText($('#EventDataTable').table2CSV(), 'Events.csv', 'text/plain')">                                           
                                        </div>
                                    </div>
                                    <div class="smart-widget-body no-padding">
                                        <div class="padding-md ">
                                            <table class="table table-striped" id="EventDataTable">
                                                <thead>
                                                    <tr>
                                                        <th style="display:none;">Event ID</th>
                                                        <th>Event Name</th>
                                                        <th>Entry Date</th>
                                                        <th>Event Owner</th>
                                                        <th>Priority</th>
                                                        <th>Deadline</th>
                                                        <th>Event Location</th>
                                                        <th>Comments</th>
                                                        <th>Status</th>
                                                        <th>Actions</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <%                                                        if (eventsList != null) {
                                                            for (int i = 0; i < eventsList.size(); i++) {
                                                                Events theEvent = eventsList.get(i);
                                                                String eventID = theEvent.getEventID();
                                                                String eventName = theEvent.getEventName();
                                                                Date eventDate = theEvent.getEventDate();
                                                                Date eventDeadline = theEvent.getEventDeadline();
                                                                String eventOwner = theEvent.getEventOwner();
                                                                String eventLocation = theEvent.getEventLocation();
                                                                String eventComments = theEvent.getComments();
                                                                //Perform priority checking for events
                                                                String eventPriority = theEvent.getPriority();
                                                                String priorityLable = "";
                                                                if (eventPriority.equals("High")) {
                                                                    priorityLable = "danger";
                                                                } else if (eventPriority.equals("Medium")) {
                                                                    priorityLable = "warning";
                                                                } else {
                                                                    priorityLable = "success";
                                                                }

                                                                //Perform event process status filtering
                                                                String eventProcessStatus = theEvent.getEventProcessStatus();
                                                                int eventProgress = Integer.parseInt(eventProcessStatus);
                                                                String progressLable = "";
                                                                if (eventProgress <= 40) {
                                                                    progressLable = "danger";
                                                                } else if (eventProgress < 100) {
                                                                    progressLable = "warning";
                                                                } else {
                                                                    progressLable = "success";
                                                                }
                                                    %>
                                                    <tr>
                                                        <td style="display:none;"><%=eventID%></td>
                                                        <td><%=eventName%></td>
                                                        <td><%=eventDate%></td>
                                                        <td><%=eventOwner%></td>
                                                        <td><span class="label label-<%=priorityLable%>"><%=eventPriority%></span></td>
                                                        <td><%=eventDeadline%></td>
                                                        <td><%=eventLocation%></td>
                                                        <td width="10px"><%=eventComments%></td>
                                                        <td><span class="label label-<%=progressLable%>"><%=eventProgress%>%</span></td>
                                                        <td>
                                                            <button type="submit" class="btn btn-info btn-xs" data-toggle="modal" href="#editEventModal" onclick="update_Event_Params('<%=eventID%>', '<%=eventName%>', '<%=eventDate%>', '<%=eventOwner%>', '<%=eventPriority%>', '<%=eventLocation%>', '<%=eventComments%>', '<%=eventDeadline%>', '<%=eventProgress%>')">Edit</button>
                                                            <button type="submit" class="btn btn-danger btn-xs" data-toggle="modal" href="#deleteEventModal" onclick="updateEventID('<%=eventID%>')">Delete</button>
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
                                    Create New Events
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
                                            <form action="addEvent" method="POST" id="addEventForm" class="form-horizontal no-margin form-border">
                                                <div class="form-group">
                                                    <label class="col-lg-2 control-label">Event Template Filter</label>
                                                    <div class="col-lg-10">
                                                    <input id="eventTemplateName" class="form-control" type="text" placeholder="input event name">
                                                    </div>
                                                    <div class="col-lg-12"><br>
                                                        <div class="btn btn-primary pull-right text-upper" id="eventTemplate" data-role="button">Filter Events</div>
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label class="col-lg-2 control-label">Event Name</label>
                                                    <div class="col-lg-10">
                                                        <input name="eventName" class="form-control" type="text" placeholder="input event name">
                                                    </div><!-- /.col -->
                                                </div><!-- /form-group -->
                                                <div class="form-group">
                                                    <label class="col-lg-2 control-label">Event Owner</label>
                                                    <div class="col-lg-10">
                                                        <input name="eventOwner" class="form-control" type="text" placeholder="input event owner">
                                                    </div><!-- /.col -->
                                                </div><!-- /form-group -->
                                                <div class="form-group">
                                                    <label class="col-lg-2 control-label">Event Date</label>
                                                    <div class="col-lg-10">
                                                        <div class="input-group">
                                                            <input type="text" name="eventDate" id="theDatePick" value="" class="datepicker-input form-control">
                                                            <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                                        </div>
                                                    </div><!-- /.col -->
                                                </div><!-- /form-group -->
                                                <div class="form-group">
                                                    <label class="col-lg-2 control-label">Event Priority</label>
                                                    <div class="col-lg-10">
                                                        <div class="radio inline-block">
                                                            <div class="custom-radio m-right-xs">
                                                                <input type="radio" id="inlineRadio1" value="High" name="eventPriority">
                                                                <label for="inlineRadio1"></label>
                                                            </div>
                                                            <div class="inline-block vertical-top">High</div>
                                                        </div>
                                                        <div class="radio inline-block">
                                                            <div class="custom-radio m-right-xs">
                                                                <input type="radio" id="inlineRadio2" value="Medium" name="eventPriority">
                                                                <label for="inlineRadio2"></label>
                                                            </div>
                                                            <div class="inline-block vertical-top">Medium</div>
                                                        </div>
                                                        <div class="radio inline-block">
                                                            <div class="custom-radio m-right-xs">
                                                                <input type="radio" id="inlineRadio3" value="Low" name="eventPriority">
                                                                <label for="inlineRadio3"></label>
                                                            </div>
                                                            <div class="inline-block vertical-top">low</div>
                                                        </div>
                                                    </div><!-- /.col -->
                                                </div><!-- /form-group -->
                                                <div class="form-group">
                                                    <label class="col-lg-2 control-label">Event Location</label>
                                                    <div class="col-lg-10">
                                                        <input class="form-control" name="eventLocation" type="text" placeholder="input Location">
                                                    </div><!-- /.col -->
                                                </div><!-- /form-group -->
                                                <div class="form-group">
                                                    <label class="col-lg-2 control-label">Comments</label>
                                                    <div class="col-lg-10">
                                                        <textarea class="form-control" name="eventComment" rows="3" ></textarea>
                                                    </div><!-- /.col -->
                                                </div><!-- /form-group -->
                                                <div class="form-group">
                                                    <div class="col-lg-12">
                                                        <a  href="#createEventModal" data-toggle="modal" class="btn btn-success pull-right text-upper">Create New Event</a><!---->
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
        <!-- Small modal -->
        <div class="modal fade" id="createEventModal">
            <div class="modal-dialog modal-sm">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                        <h4 class="modal-title" id="myModalLabel">Create New Event</h4>
                    </div>
                    <div class="modal-body">
                        <form role="form">
                            <div class="form-group">
                                <p>Are you sure you want to create this new event?</p>
                            </div>
                            <div class="row">
                                <hr>
                                <div class="col-lg-6"><a data-dismiss="modal" class="btn btn-danger block m-top-md">No</a></div>
                                <div class="col-lg-6"><a onclick="document.getElementById('addEventForm').submit()" class="btn btn-primary block m-top-md">Yes</a></div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>


        <!--Event creation status-->
        <div class="modal fade" id="eventStatus">
            <div class="modal-dialog modal-sm">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                        <h4 class="modal-title" id="myModalLabel">Event Status Message</h4>
                    </div>
                    <div class="modal-body">
                        <form role="form">
                            <div class="form-group">
                                <p id="eventStatusMessage"><%                                    String eventStatus = (String) request.getAttribute("EventMessage");
                                    if (eventStatus != null) {
                                    %>
                                    <%=eventStatus%>
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

        <!--Modal for deleting events-->
        <div class="modal fade" id="deleteEventModal">
            <div class="modal-dialog modal-sm">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                        <h4 class="modal-title" id="myModalLabel">Delete Event</h4>
                    </div>
                    <div class="modal-body">
                        <form id="deleteEventForm" role="form" action="deleteEvent">
                            <div class="form-group">
                                <p>Are you sure you want to delete this event?</p>
                            </div>
                            <input id="deleteEvent" type="hidden" name="eventID" value="hamue">
                            <div class="row">
                                <hr>
                                <div class="col-lg-6"><a data-dismiss="modal" class="btn btn-danger block m-top-md">No</a></div>
                                <div class="col-lg-6"><a onclick="document.getElementById('deleteEventForm').submit()"  class="btn btn-primary block m-top-md">Yes</a></div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
        <!--/Modal for deleting events/-->


        <!-- Modal for editting events-->
        <div class="modal fade" id="editEventModal">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                        <h4 class="modal-title">Edit Event</h4>
                    </div>
                    <div class="modal-body">
                        <form action="editEvent" method="POST" id="editEventForm" class="form-horizontal no-margin form-border">
                            <div class="form-group">
                                <label class="col-lg-2 control-label">Event ID</label>
                                <div class="col-lg-10">
                                    <p id="eventID_js" class="form-control-static">email@example.com</p>
                                    <input type="hidden" id="eventID_js_ED" name="eventID" type="text" value="">
                                </div><!-- /.col -->
                            </div><!-- /form-group -->
                            <div class="form-group">
                                <label class="col-lg-2 control-label">Entry Date</label>
                                <div class="col-lg-10">
                                    <p id="eventDate_js" class="form-control-static">email@example.com</p>
                                    <input type="hidden" id="eventDate_js_ED" name="eventDate" type="text" value="">
                                </div><!-- /.col -->
                            </div><!-- /form-group -->
                            <div class="form-group">
                                <label class="col-lg-2 control-label">Event Name</label>
                                <div class="col-lg-10">
                                    <input name="eventName" id="eventName_js" class="form-control" type="text" value="">
                                </div><!-- /.col -->
                            </div><!-- /form-group -->
                            <div class="form-group">
                                <label class="col-lg-2 control-label">Event Owner</label>
                                <div class="col-lg-10">
                                    <input name="eventOwner" id="eventOwner_js" class="form-control" type="text" value="">
                                </div><!-- /.col -->
                            </div><!-- /form-group -->
                            <div class="form-group">
                                <label class="col-lg-2 control-label">Event Deadline</label>
                                <div class="col-lg-10">
                                    <div class="input-group">
                                        <input type="text" name="eventDeadline" id="eventDeadline_js" value="" class="datepicker-input-1 form-control">
                                        <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                    </div>
                                </div><!-- /.col -->
                            </div><!-- /form-group -->
                            <div class="form-group">
                                <label class="col-lg-2 control-label">Event Priority</label>
                                <div class="col-lg-10">
                                    <div class="radio inline-block">
                                        <div class="custom-radio m-right-xs">
                                            <input type="radio" id="inlineRadio4_high" value="High" name="eventPriority">
                                            <label for="inlineRadio4_high"></label>
                                        </div>
                                        <div class="inline-block vertical-top">High</div>
                                    </div>
                                    <div class="radio inline-block">
                                        <div class="custom-radio m-right-xs">
                                            <input type="radio" id="inlineRadio5_medium" value="Medium" name="eventPriority">
                                            <label for="inlineRadio5_medium"></label>
                                        </div>
                                        <div class="inline-block vertical-top">Medium</div>
                                    </div>
                                    <div class="radio inline-block">
                                        <div class="custom-radio m-right-xs">
                                            <input type="radio" id="inlineRadio6_low" value="Low" name="eventPriority">
                                            <label for="inlineRadio6_low"></label>
                                        </div>
                                        <div class="inline-block vertical-top">low</div>
                                    </div>
                                </div><!-- /.col -->
                            </div><!-- /form-group -->
                            <div class="form-group">
                                <label class="col-lg-2 control-label">Event Location</label>
                                <div class="col-lg-10">
                                    <input class="form-control" id="eventLocation_js" name="eventLocation" type="text" value="">
                                    <input type="hidden" id="eventProgress_js" name="eventProgress" type="text" value="">
                                </div><!-- /.col -->
                            </div><!-- /form-group -->
                            <div class="form-group">
                                <label class="col-lg-2 control-label">Comments</label>
                                <div class="col-lg-10">
                                    <textarea class="form-control" id="eventComments_js" name="eventComment" rows="3" value=""></textarea>
                                </div><!-- /.col -->
                            </div><!-- /form-group -->
                        </form>
                    </div>
                    <div class="modal-footer">
                        <div class="col-lg-6"><a data-dismiss="modal" class="btn btn-danger block m-top-md">No</a></div>
                        <div class="col-lg-6"><a onclick="document.getElementById('editEventForm').submit()"  class="btn btn-primary block m-top-md">Save Changes</a></div>
                    </div>
                </div>
            </div>
        </div>
        <!--/ Modal for editting events/-->

        <!--Event Status Message for both successful Edit & deletion-->
        <div class="modal fade" id="eventActionStatus">
            <div class="modal-dialog modal-sm">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                        <h4 class="modal-title" id="myModalLabel">Status Message</h4>
                    </div>
                    <div class="modal-body">
                        <form role="form">
                            <div class="form-group">
                                <p id="EventInteractionMessage"><%                                    String eventActionStatus = (String) request.getParameter("eventActionStatus");
                                    if (eventActionStatus != null) {
                                    %>
                                    <%=eventActionStatus%>
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
                                var theValue_eventCreationStatus = document.getElementById("eventStatusMessage").innerHTML;
                                var theValue_eventDelOrEditStatus = document.getElementById("EventInteractionMessage").innerHTML;

                                var removedSpace_theValue_eventCreationStatus = theValue_eventCreationStatus.replace(/\s/g, '');
                                var removedSpace_theValue_eventDelOrEditStatus = theValue_eventDelOrEditStatus.replace(/\s/g, '');

                                if (removedSpace_theValue_eventCreationStatus !== null && removedSpace_theValue_eventCreationStatus !== "" && typeof (removedSpace_theValue_eventCreationStatus) !== "undefined") {
                                    $('#eventStatus').modal('show');
                                }

                                if (removedSpace_theValue_eventDelOrEditStatus !== null && removedSpace_theValue_eventDelOrEditStatus !== "" && typeof (removedSpace_theValue_eventDelOrEditStatus) !== "undefined") {
                                    $('#eventActionStatus').modal('show');
                                }
                            });

                            function updateEventID(eventID) {
                                document.getElementById("deleteEvent").value = eventID;
                            }

                            function update_Event_Params(eventID, eventName, eventDate, eventOwner, eventPriority, eventLocation, eventComments, eventDeadline, eventProgress) {
                                document.getElementById("eventID_js").innerHTML = eventID;
                                document.getElementById("eventID_js_ED").value = eventID;
                                document.getElementById("eventDate_js").innerHTML = eventDate;
                                document.getElementById("eventDate_js_ED").value = eventDate;
                                document.getElementById("eventName_js").value = eventName;
                                document.getElementById("eventOwner_js").value = eventOwner;

                                if (eventPriority === 'High') {
                                    document.getElementById("inlineRadio4_high").checked = true;
                                } else if (eventPriority === 'Medium') {
                                    document.getElementById("inlineRadio5_medium").checked = true;
                                } else {
                                    document.getElementById("inlineRadio6_low").checked = true;
                                }

                                var eventdeadline_arr = eventDeadline.split("-");
                                var eventDeadline_format = eventdeadline_arr[0] + "-" + eventdeadline_arr[1] + "-" + eventdeadline_arr[2];
                                //var eventDeadline_format = eventDeadline.replace(/-/g, "/");


                                document.getElementById("eventDeadline_js").value = eventDeadline_format;
                                document.getElementById("eventLocation_js").value = eventLocation;
                                document.getElementById("eventComments_js").value = eventComments;
                                document.getElementById("eventProgress_js").value = eventProgress;
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
                var eventsArray = <%=EventsDAO.stringEventsforTemplate(EventsDAO.retrieveEvents())%>;
                $("#eventTemplate").click(function ()
                {
                    var eventName = document.getElementById("eventTemplateName").value;
                    var eventFiltered = $.grep(eventsArray, function (e) {
                        return e.name.toLowerCase().includes(eventName.toLowerCase());
                    });
                    $('[name$=eventName]').val(eventFiltered[0].name);
                    $('[name$=eventOwner]').val(eventFiltered[0].owner);
                    $('[name$=eventLocation]').val(eventFiltered[0].location);
                    $('[name$=eventComment]').val(eventFiltered[0].comments);
                    //alert(String(eventFiltered[0].priority) === "High");
                    if (eventFiltered[0].priority === "High") {
                        $("#inlineRadio1").prop("checked", true);
                    }
                    if (eventFiltered[0].priority === "Medium") {
                        $("#inlineRadio2").prop("checked", true);
                    }
                    if (eventFiltered[0].priority === "Low") {
                        $("#inlineRadio3").prop("checked", true);
                    }
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
                $('#EventDataTable').dataTable();
            });

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
