<!DOCTYPE html>
<%@page import="entity.Events, dao.EventsDAO, entity.Orders, entity.User,dao.AnalyticsDAO, dao.LoginDAO, dao.OrdersDAO, entity.Tasks, dao.TasksDAO, java.util.*,java.text.*"%>
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

        String theEmail = (String) request.getAttribute("Email");
        List<Tasks> tasksList = new ArrayList<Tasks>();
        LoginDAO loginManager = new LoginDAO();
        TasksDAO tasksManager = new TasksDAO();

        if (theEmail == null) {
            theEmail = request.getParameter("Email");
        }

        Object javaObject = session.getAttribute("logistics");
        User user = null;
        String nameOfUser = "";
        if (javaObject == null) {
            response.sendRedirect(path + "/login.jsp");
        } else {
            user = (User) javaObject;
            nameOfUser = user.getUserName();
            tasksList = tasksManager.retrieveTasksOfUser(user.getEmail());
        }


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

                        <a href="task_assignment.jsp" class="brand">
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
                    </div>
                </div><!-- ./top-nav-inner -->	
            </header>

            <div class="container">
                <div class="padding-md">
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="page-title">
                                My Tasks
                            </div>
                            <div class="page-sub-header">
                                Welcome, Mr <%=nameOfUser%> , <i class="fa fa-map-marker text-danger"></i> New York
                            </div>
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
                                        <div class="padding-md table-responsive">
                                            <table class="table table-striped">
                                                <thead>
                                                    <tr>
                                                        <th width="40px">Order ID</th>
                                                        <th width="40px">Task ID</th>
                                                        <th width="80px">Task Description</th>
                                                        <th width="50px">Entry Date</th>
                                                        <th width="50px">Assigned</th>
                                                        <th width="50px">Task Deadline</th>
                                                        <th width="50px">Priority</th>
                                                        <th width="50px">Task Progress</th>
                                                        <th width="50px">Comments</th>
                                                        <th width="60px">Completed(?)</th>
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
                                                        <td><%=orderID%></td>
                                                        <td><%=taskID%></td>
                                                        <td><%=taskDescription%></td>
                                                        <td><%=entryDate%></td>
                                                        <td><%=taskOwner%></td>
                                                        <td><%=taskDeadline%></td>
                                                        <td><span class="label label-<%=priorityLable%>"><%=taskPriority%></span></td>
                                                        <td><span class="label label-<%=progressLable%>"><%=taskProgress%>%</span></td>
                                                        <td><%=taskComments%></td>
                                                        <td>
                                                            <form id="<%=taskID%>" action="<%=path%>/editTaskStatus">
                                                                <input type="hidden" name="taskID" value="<%=taskID%>">
                                                                <input type="hidden" name="theEmail" value="<%=theEmail%>">
                                                                <%
                                                                    if (taskProcessStatus.equals("100")) {
                                                                %>
                                                                <button onclick="document.getElementById('<%=taskID%>').submit();" class="btn btn-danger btn-xs" >&nbsp; Not Complete &nbsp;&nbsp; </button>
                                                                <%
                                                                } else {
                                                                %>
                                                                <button onclick="document.getElementById('<%=taskID%>').submit();" class="btn btn-info btn-xs" >&nbsp; Complete &nbsp;&nbsp; </button>
                                                                <%
                                                                    }
                                                                %>
                                                            </form>
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

                </div><!-- ./padding-md -->
            </div><!-- /main-container -->

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

        <!-- Resources -->
        <script src="https://www.amcharts.com/lib/3/ammap.js"></script>
        <script src="https://www.amcharts.com/lib/3/maps/js/usaLow.js"></script>
        <script src="https://www.amcharts.com/lib/3/plugins/export/export.min.js"></script>
        <script src="https://www.amcharts.com/lib/3/themes/light.js"></script>


        <!-- Datatable -->
        <script src='<%=path%>/twitterBootstrap/js/jquery.dataTables.min.js'></script>
        <script src='<%=path%>/twitterBootstrap/js/uncompressed/dataTables.bootstrap.js'></script>

    </body>
</html>
