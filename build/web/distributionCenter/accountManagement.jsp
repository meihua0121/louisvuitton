<!DOCTYPE html>
<%@page import="entity.EncryptDecrypt,java.util.*,java.text.*, dao.*, entity.User, java.util.Hashtable"%>
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
            Object javaObject = session.getAttribute("distributioncenter");
            User user = null;
            String nameOfUser = "";
            if (javaObject == null) {
                response.sendRedirect(path+"/login.jsp");
            } else {
                user = (User) javaObject;
                nameOfUser = user.getUserName();
            }

            LoginDAO loginManager = new LoginDAO();
            Hashtable<String, User> listOfUsers = loginManager.retrieveUsers();
            ArrayList<User> supplyChain = loginManager.returnpecifiedUserTypes(listOfUsers, "Supply Chain");
            ArrayList<User> distributionCenter = loginManager.returnpecifiedUserTypes(listOfUsers, "Distribution Center");
            ArrayList<User> logisticSupport = loginManager.returnpecifiedUserTypes(listOfUsers, "Logistic Support");

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
                            <li class="bg-palette3 active">
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
                                Account Management
                            </div>
                            <div class="page-sub-header">
                                Welcome, Mr <%=nameOfUser%> , <i class="fa fa-map-marker text-danger"></i> New York
                            </div>
                        </div>
                        <div class="col-sm-6 text-right text-left-sm p-top-sm">
                            <div class="btn-group">
                                <a class="btn btn-default hidden-print pull-right" onclick="window.print()"><i class="fa fa-print"></i> Print Account Management Page</a>
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
                                    Manage User Accounts
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
                                            <table class="table table-striped" id="userDataTable">
                                                <thead>
                                                    <tr>
                                                        <th>Username</th>
                                                        <th>Email</th>
                                                        <th>Phone Number</th>
                                                        <th>User Type</th>
                                                        <th>Actions</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <%
                                                        Set<String> keys = listOfUsers.keySet();
                                                        for (String key : keys) {
                                                            User theUser = listOfUsers.get(key);
                                                            String username = theUser.getUserName();
                                                            String email = theUser.getEmail();
                                                            String phoneNumber = theUser.getPhoneNumber();
                                                            String userType = theUser.getType();
                                                    %>       
                                                    <tr>
                                                        <td><%=username%></td>
                                                        <td><%=email%></td>
                                                        <td><%=phoneNumber%></td>
                                                        <td><%=userType%></td>
                                                        <td>
                                                            <button type="submit" class="btn btn-info btn-xs" data-toggle="modal" href="#editUserModal" onclick="update_User_Params('<%=username%>', '<%=email%>', '<%=phoneNumber%>', '<%=userType%>')"> Edit Account </button>
                                                            <button type="submit" class="btn btn-danger btn-xs" data-toggle="modal" href="#deleteUserModal" onclick="updateEmailAddress('<%=theUser.getEmail()%>')">Delete Account</button>
                                                        </td>
                                                    </tr>
                                                    <%
                                                        }
                                                    %>
                                                </tbody>
                                            </table>
                                        </div>
                                        <div class="bg-grey">
                                            <div class="row">
                                                <div class="col-xs-4 text-center">
                                                    <h3 class="m-top-sm"><%=supplyChain.size()%></h3>
                                                    <small class="m-bottom-sm block">No. of Supply Chain Account</small>
                                                </div>
                                                <div class="col-xs-4 text-center">
                                                    <h3 class="m-top-sm"><%=distributionCenter.size()%></h3>
                                                    <small class="m-bottom-sm block">No. of Distribution Center Account</small>
                                                </div>
                                                <div class="col-xs-4 text-center">
                                                    <h3 class="m-top-sm"><%=logisticSupport.size()%></h3>
                                                    <small class="m-bottom-sm block">No. of Logistic Support Account</small>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div><!-- ./smart-widget-inner -->
                            </div><!-- ./smart-widget -->
                        </div>
                    </div>

                    <div class="row"><br>
                        <div class="col-lg-12">
                            <div id="D1" class="smart-widget widget-dark-blue">
                                <div class="smart-widget-header">
                                    Create New User Accounts
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
                                            <form action="../createAccount" method="POST" id="addUserForm" class="form-horizontal no-margin form-border">
                                                <div class="form-group">
                                                    <label class="col-lg-2 control-label">Email</label>
                                                    <div class="col-lg-10">
                                                        <input name="email" class="form-control" type="text" placeholder="input email">
                                                        <input name="superuser" type="hidden" value="<%=nameOfUser%>">
                                                    </div><!-- /.col -->
                                                </div><!-- /form-group -->
                                                <div class="form-group">
                                                    <label class="col-lg-2 control-label">Name</label>
                                                    <div class="col-lg-10">
                                                        <input name="name" class="form-control" type="text" placeholder="input name">
                                                    </div><!-- /.col -->
                                                </div><!-- /form-group -->
                                                <div class="form-group">
                                                    <label class="col-lg-2 control-label">Phone Number</label>
                                                    <div class="col-lg-10">
                                                        <input name="phoneNumber" class="form-control" type="text" placeholder="input phone number">
                                                    </div><!-- /.col -->
                                                </div><!-- /form-group -->
                                                <div class="form-group">
                                                    <label class="col-lg-2 control-label">User Type</label>
                                                    <div class="col-lg-10">
                                                        <!--<div class="radio inline-block">
                                                            <div class="custom-radio m-right-xs">
                                                                <input type="radio" id="inlineRadio1" value="Supply Chain" name="userType">
                                                                <label for="inlineRadio1"></label>
                                                            </div>
                                                            <div class="inline-block vertical-top">Supply Chain</div>
                                                        </div>-->
                                                        <div class="radio inline-block">
                                                            <div class="custom-radio m-right-xs">
                                                                <input type="radio" id="inlineRadio2" value="Distribution Center" name="userType">
                                                                <label for="inlineRadio2"></label>
                                                            </div>
                                                            <div class="inline-block vertical-top">Distribution Center</div>
                                                        </div>
                                                        <div class="radio inline-block">
                                                            <div class="custom-radio m-right-xs">
                                                                <input type="radio" id="inlineRadio3" value="Logistic Support" name="userType">
                                                                <label for="inlineRadio3"></label>
                                                            </div>
                                                            <div class="inline-block vertical-top">Logistic Support</div>
                                                        </div>
                                                    </div><!-- /.col -->
                                                </div><!-- /form-group -->
                                                <div class="form-group">
                                                    <label class="col-lg-2 control-label">Password</label>
                                                    <div class="col-lg-10">
                                                        <input name="password" class="form-control" type="text" placeholder="input password">
                                                    </div><!-- /.col -->
                                                </div>
                                                <div class="form-group">
                                                    <div class="col-lg-12">
                                                        <a href="#createUserModal" data-toggle="modal" class="btn btn-success pull-right text-upper">Create New User</a><!---->
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

        <!-- Small modal to create new user account-->
        <div class="modal fade" id="createUserModal">
            <div class="modal-dialog modal-sm">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                        <h4 class="modal-title" id="myModalLabel">Create New User Account</h4>
                    </div>
                    <div class="modal-body">
                        <form role="form">
                            <div class="form-group">
                                <p>Are you sure you want to create this new user account?</p>
                            </div>
                            <div class="row">
                                <hr>
                                <div class="col-lg-6"><a data-dismiss="modal" class="btn btn-danger block m-top-md">No</a></div>
                                <div class="col-lg-6"><a onclick="document.getElementById('addUserForm').submit()" class="btn btn-primary block m-top-md">Yes</a></div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <!-- Small modal to delete new user account-->
        <div class="modal fade" id="deleteUserModal">
            <div class="modal-dialog modal-sm">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                        <h4 class="modal-title" id="myModalLabel">Delete User Account</h4>
                    </div>
                    <div class="modal-body">
                        <form id="deleteUserForm" role="form" action="../deleteAccount">
                            <div class="form-group">
                                <p>Are you sure you want to delete this new user account?</p>
                            </div>
                            <input id="deleteEmailAddress" type="hidden" name="email" value="hamue">
                            <input type="hidden" name="superuser" value="distributioncenter">
                            <div class="row">
                                <hr>
                                <div class="col-lg-6"><a data-dismiss="modal" class="btn btn-danger block m-top-md">No</a></div>
                                <div class="col-lg-6"><a onclick="document.getElementById('deleteUserForm').submit()"  class="btn btn-primary block m-top-md">Yes</a></div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <!--User Account creation Status Message-->
        <div class="modal fade" id="userAccStatus">
            <div class="modal-dialog modal-sm">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                        <h4 class="modal-title" id="myModalLabel">Status Message</h4>
                    </div>
                    <div class="modal-body">
                        <form role="form">
                            <div class="form-group">
                                <p id="userStatusMessage"><%                                    String userAccStatus = (String) request.getParameter("userAccStatus");
                                    if (userAccStatus != null) {
                                    %>
                                    <%=userAccStatus%>
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

        <!--Task Status Message for both successful Edit & deletion-->
        <div class="modal fade" id="accountActionStatus">
            <div class="modal-dialog modal-sm">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                        <h4 class="modal-title" id="myModalLabel">Status Message</h4>
                    </div>
                    <div class="modal-body">
                        <form role="form">
                            <div class="form-group">
                                <p id="accountInteractionMessage"><%                                    String acccountActionStatus = (String) request.getParameter("accountActionStatus");
                                    if (acccountActionStatus != null) {
                                    %>
                                    <%=acccountActionStatus%>
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
        <div class="modal fade" id="editUserModal">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                        <h4 class="modal-title">Edit User Account</h4>
                    </div>
                    <div class="modal-body">
                        <form action="../editAccount" method="POST" id="editAccountForm" class="form-horizontal no-margin form-border">
                            <div class="form-group">
                                <label class="col-lg-2 control-label">Email Address</label>
                                <div class="col-lg-10">
                                    <p id="email_js" class="form-control-static">email@example.com</p>
                                    <input type="hidden" id="email_js_ED" name="email" type="text" value="">
                                    <input type="hidden" name="superuser" value="distributioncenter">
                                </div><!-- /.col -->
                            </div><!-- /form-group -->
                            <div class="form-group">
                                <label class="col-lg-2 control-label">Username</label>
                                <div class="col-lg-10">
                                    <input name="username" id="username_js" class="form-control" type="text" value="">
                                </div><!-- /.col -->
                            </div><!-- /form-group -->
                            <div class="form-group">
                                <label class="col-lg-2 control-label">Phone Number</label>
                                <div class="col-lg-10">
                                    <input name="phoneNumber" id="phoneNumber_js" class="form-control" type="text" value="">
                                </div><!-- /.col -->
                            </div><!-- /form-group -->
                            <div class="form-group">
                                <label class="col-lg-2 control-label">User Type</label>
                                <div class="col-lg-10">
                                    <div class="radio inline-block">
                                        <div class="custom-radio m-right-xs">
                                            <input type="radio" id="inlineRadio1_high" value="Supply Chain" name="userType">
                                            <label for="inlineRadio1_low"></label>
                                        </div>
                                        <div class="inline-block vertical-top">Supply Chain</div>
                                    </div>
                                    <div class="radio inline-block">
                                        <div class="custom-radio m-right-xs">
                                            <input type="radio" id="inlineRadio2_medium" value="Distribution Center" name="userType">
                                            <label for="inlineRadio2_medium"></label>
                                        </div>
                                        <div class="inline-block vertical-top">Distribution Center</div>
                                    </div>
                                    <div class="radio inline-block">
                                        <div class="custom-radio m-right-xs">
                                            <input type="radio" id="inlineRadio3_low" value="Logistic Support" name="userType">
                                            <label for="inlineRadio3_high"></label>
                                        </div>
                                        <div class="inline-block vertical-top">Logistic Support</div>
                                    </div>
                                </div><!-- /.col -->
                            </div><!-- /form-group -->
                        </form>
                    </div>
                    <div class="modal-footer">
                        <div class="col-lg-6"><a data-dismiss="modal" class="btn btn-danger block m-top-md">No</a></div>
                        <div class="col-lg-6"><a onclick="document.getElementById('editAccountForm').submit()"  class="btn btn-primary block m-top-md">Save Changes</a></div>
                    </div>
                </div>
            </div>
        </div>
        <!--/ Modal for editting tasks/-->

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
                            $(function () {
                                $('#userDataTable').dataTable();
                            });

        </script>
        <script>
            function updateEmailAddress(emailAddress) {
                document.getElementById("deleteEmailAddress").value = emailAddress;
            }
            function update_User_Params(username, email, phoneNumber, userType) {
                document.getElementById("email_js").innerHTML = email;
                document.getElementById("email_js_ED").value = email;
                document.getElementById("username_js").value = username;
                document.getElementById("phoneNumber_js").value = phoneNumber;

                if (userType === 'Supply Chain') {
                    document.getElementById("inlineRadio1_high").checked = true;
                } else if (userType === 'Distribution Center') {
                    document.getElementById("inlineRadio2_medium").checked = true;
                } else {
                    document.getElementById("inlineRadio3_low").checked = true;
                }

            }

            $(function () {
                var theValue_userStatusMessage = document.getElementById("userStatusMessage").innerHTML;
                var theValue_accountInteractionMessage = document.getElementById("accountInteractionMessage").innerHTML;

                var removedSpace_theValue_userStatusMessage = theValue_userStatusMessage.replace(/\s/g, '');
                var removedSpace_theValue_accountInteractionMessage = theValue_accountInteractionMessage.replace(/\s/g, '');
                if (removedSpace_theValue_userStatusMessage !== null && removedSpace_theValue_userStatusMessage !== "" && typeof (removedSpace_theValue_userStatusMessage) !== "undefined") {
                    $('#userAccStatus').modal('show');
                }

                if (theValue_accountInteractionMessage !== null && theValue_accountInteractionMessage !== "" && typeof (theValue_accountInteractionMessage) !== "undefined") {
                    $('#accountActionStatus').modal('show');
                }
            });


        </script>
    </body>
</html>
