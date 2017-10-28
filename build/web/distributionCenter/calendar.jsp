<!DOCTYPE html>
<%@page import="entity.User, dao.EventsDAO, dao.TasksDAO, dao.OrdersDAO, entity.Events, java.util.*,java.text.*,dao.AnalyticsDAO"%>
<html lang="en">

    <%
        String path = request.getContextPath();
    %>
    <head>
        <meta charset="utf-8">
        <title>Louis Vuitton - Facilitating Communications</title>
        <link rel="shortcut icon" type="image/x-icon" href="image/LV_logo.jpg" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta name="description" content="">
        <meta name="author" content="">

        <!-- Bootstrap core CSS -->
        <link href="<%=path%>/twitterBootstrap/bootstrap/css/bootstrap.min.css" rel="stylesheet">

        <!-- Font Awesome -->
        <link href="<%=path%>/twitterBootstrap/css/font-awesome.min.css" rel="stylesheet">

        <!-- ionicons -->
        <link href="<%=path%>/twitterBootstrap/css/ionicons.min.css" rel="stylesheet">7

        <!-- Animate -->

        <!--FullCalendar Dependencies-->
        <link href='<%=path%>/twitterBootstrap/css/fullcalendar.css' rel='stylesheet' />
        <link href='<%=path%>/twitterBootstrap/css/fullcalendar.print.css' rel='stylesheet' media='print' />

        <!--jQuery-->
        <script src='<%=path%>/twitterBootstrap/js/jquery.min.js'></script>
        <script src='<%=path%>/twitterBootstrap/js/jquery-ui.min.js'></script>
        <script src='<%=path%>/twitterBootstrap/js/moment.min.js'></script>

        <!-- Animate -->
        <link href="<%=path%>/twitterBootstrap/css/animate.min.css" rel="stylesheet">

        <!-- Owl Carousel -->
        <link href="<%=path%>/twitterBootstrap/css/owl.carousel.min.css" rel="stylesheet">
        <link href="<%=path%>/twitterBootstrap/css/owl.theme.default.min.css" rel="stylesheet">

        <!-- Simplify -->
        <link href="<%=path%>/twitterBootstrap/css/simplify.min.css" rel="stylesheet">


        <!--FullCalendar-->
        <script src='<%=path%>/twitterBootstrap/js/fullcalendar.min.js'></script>

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
        Object javaObject = session.getAttribute("distributioncenter");
        User user = null;
        String nameOfUser = "";
        if (javaObject == null) {
            response.sendRedirect(path + "/login.jsp");
        } else {
            user = (User) javaObject;
            nameOfUser = user.getUserName();
        }
        
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
                                    <!--<img src="<%=path%>/image/profile1.jpg" alt="" class="img-circle inline-block user-profile-pic">-->
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

                            <li class="bg-palette1">
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
                            <li class="bg-palette2 active">
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
                        <div class="col-lg-12">
                            <div class="full-calendar-wrapper clearfix">
                                <div class="calendar-external-events bg-dark-blue text-white">
                                    <h4 class="m-bottom-md">
                                        Calendar Filters
                                    </h4>
                                    <div class="external-event" id="eventCalendar" data-role="button">Show event Calendar</div>
                                    <div class="external-event">
                                        Filter by event
                                        <input id="FilterEventName" type="text" placeholder="Type your event name.." style="color:#000"/>
                                        <div id="FilterEvent" data-role="button">Filter!</div>
                                    </div>
                                    <div class="external-event">
                                        <div id="orderCalendar" data-role="button">Show order Calendar</div>
                                    </div>
                                    <div class="external-event">
                                        Filter by order
                                        <input id="FilterOrderID" type="text" placeholder="Type your order ID.." style="color:#000"/>
                                        <div id="FilterOrder" data-role="button">Filter!</div>
                                    </div>
                                    <div class="external-event">
                                        <div id="taskCalendar" data-role="button">Show task Calendar</div>
                                    </div>
                                    <div class="external-event">
                                        Filter tasks by user ID
                                        <input id="FilterUsername" type="text" placeholder="Type your order ID.." style="color:#000"/>
                                        <div id="FilterTask" data-role="button">Filter!</div>
                                    </div>
                                </div>

                                <div class="full-calendar-body clearfix">
                                    <div id="calendar"></div>
                                </div>
                            </div>
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

        <!-- /wrapper -->

        <a href="#" class="scroll-to-top hidden-print"><i class="fa fa-chevron-up fa-lg"></i></a>


        <!-- Jquery -->
        <script src="<%=path%>/twitterBootstrap/js/jquery-1.11.1.min.js"></script>

        <!-- Bootstrap -->
        <script src="<%=path%>/twitterBootstrap/bootstrap/js/bootstrap.min.js"></script>

        <!-- Jauery UI -->
        <script src="<%=path%>/twitterBootstrap/js/jquery-ui.custom.min.js"></script>   

        <!-- Slimscroll -->
        <script src='<%=path%>/twitterBootstrap/js/jquery.slimscroll.min.js'></script>

        <!-- Popup Overlay -->
        <script src='<%=path%>/twitterBootstrap/js/jquery.popupoverlay.min.js'></script>

        <!-- Modernizr -->
        <script src='<%=path%>/twitterBootstrap/js/modernizr.min.js'></script>

        <!-- Moment -->
        <script src='<%=path%>/twitterBootstrap/js/moment.min.js'></script>

        <!-- Full Calendar -->
        <script src='<%=path%>/twitterBootstrap/js/fullcalendar.min.js'></script>

        <!-- Simplify -->
        <script src="<%=path%>/twitterBootstrap/js/simplify/simplify.js"></script>

        <script>

            $(function () {
                var eventsArray = <%=EventsDAO.stringEventsforCalendar(EventsDAO.retrieveEvents())%>;
                var ordersArray = <%=OrdersDAO.stringOrdersforCalendar(OrdersDAO.retrieveOrders())%>;
                var tasksArray = <%=TasksDAO.stringTasksforCalendar(TasksDAO.retrieveTasks())%>;
                var calendar = $('#calendar').fullCalendar(
                        {
                            eventStartEditable: false,
                            eventDurationEditable: false,
                            header:
                                    {
                                        left: 'prev,next today',
                                        center: 'title',
                                        right: 'month'
                                    },
                            defaultView: 'month',
                            /*
                             selectable:true will enable user to select datetime slot
                             selectHelper will add helpers for selectable.
                             */
                            selectable: true,
                            selectHelper: true,
                            editable: true,
                            events: eventsArray
                        });

                $("#FilterEvent").click(function ()
                {
                    $('#calendar').fullCalendar('removeEvents');
                    var eventName = document.getElementById("FilterEventName").value;
                    var eventFiltered = $.grep(eventsArray, function (e) {
                        return e.title.toLowerCase().includes(eventName.toLowerCase());
                    });
                    $('#calendar').fullCalendar('addEventSource', eventFiltered);
                    if (eventFiltered.length !== 0) {
                        var eventFilteredID = eventFiltered[0].id;
                    }
                    var orderFiltered = $.grep(ordersArray, function (o) {
                        return o.id === eventFilteredID;
                    });
                    $('#calendar').fullCalendar('addEventSource', orderFiltered);


                }
                );

                $("#FilterOrder").click(function ()
                {
                    $('#calendar').fullCalendar('removeEvents');
                    var orderID = document.getElementById("FilterOrderID").value;
                    var orderFiltered = $.grep(ordersArray, function (o) {
                        return o.title === orderID;
                    });
                    $('#calendar').fullCalendar('addEventSource', orderFiltered);
                    var taskFiltered = $.grep(tasksArray, function (t) {
                        return t.id === orderID;
                    });
                    $('#calendar').fullCalendar('addEventSource', taskFiltered);
                }
                );

                $("#FilterTask").click(function ()
                {
                    $('#calendar').fullCalendar('removeEvents');
                    var userName = document.getElementById("FilterUsername").value;
                    var taskFiltered = $.grep(tasksArray, function (t) {
                        return t.className.toLowerCase().includes(userName.toLowerCase());
                    });
                    $('#calendar').fullCalendar('addEventSource', taskFiltered);
                }
                );

                $('#FilterEventName').keypress(function (e) {
                    var key = e.which;
                    if (key === 13)  // the enter key code
                    {
                        $('#FilterEvent').click();
                        return false;
                    }
                });

                $('#FilterOrderID').keypress(function (e) {
                    var key = e.which;
                    if (key === 13)  // the enter key code
                    {
                        $('#FilterOrder').click();
                        return false;
                    }
                });

                $('#FilterUsername').keypress(function (e) {
                    var key = e.which;
                    if (key === 13)  // the enter key code
                    {
                        $('#FilterTask').click();
                        return false;
                    }
                });

                $("#eventCalendar").click(function ()
                {
                    $('#calendar').fullCalendar('removeEvents');
                    $('#calendar').fullCalendar('addEventSource', eventsArray);
                }
                );

                $("#orderCalendar").click(function ()
                {
                    $('#calendar').fullCalendar('removeEvents');
                    $('#calendar').fullCalendar('addEventSource', ordersArray);
                }
                );

                $("#taskCalendar").click(function ()
                {
                    $('#calendar').fullCalendar('removeEvents');
                    $('#calendar').fullCalendar('addEventSource', tasksArray);
                }
                );

            });

        </script>
    </body>
</html>
