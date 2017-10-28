<!DOCTYPE html>
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

        <!-- Simplify -->
        <link href="twitterBootstrap/css/simplify.min.css" rel="stylesheet">

        <style>
            #background {
                position: fixed;
                top: 50%;
                left: 50%;
                min-width: 100%;
                min-height: 100%;
                width: auto;
                height: auto;
                z-index: -100;
                -webkit-transform: translateX(-50%) translateY(-50%);
                transform: translateX(-50%) translateY(-50%);
                background: url(polina.jpg) no-repeat;
                background-size: cover;
            }
            .container h1 {
                color: white;
            }
        </style>
    </head>

    <%
        String theMessage = request.getParameter("message");
    %>
    <body>
        <!--<video autoplay loop muted poster="screenshot.jpg" id="background">
            <source src="http://techslides.com/demos/sample-videos/small.mp4" type="video/mp4">
        </video>-->
        <div style="position: fixed; z-index: -99; width: 100%; height: 100%">
            <iframe frameborder="0" height="100%" width="100%" 
                    src="https://youtube.com/embed/jFne8xKtRTE?autoplay=1&controls=0&showinfo=0&autohide=1">
            </iframe>
        </div>
        <div class="container">
            <div class="row">
                <div class="col-md-12">
                    <div class="wrapper no-navigation preload"><div class="sign-in-wrapper">
                            <div class="sign-in-inner">
                                <div class="panel" style="opacity: 0.95">
                                    <div class="panel-footer bg-white">

                                        <div class="login-brand text-center">
                                            <img src="image/LV_logo.jpg" alt="Mountain View" style="width:50px;height:50px;">
                                            <b>Louis</b> <strong class="text-skin">Vuitton</strong>
                                        </div>
                                        <form action="loginAccount" method='POST' id='loginForm'>
                                            <%
                                                if (theMessage != null) {
                                            %>
                                            <div class="alert alert-danger alert-dismissible" role="alert">
                                                <button type="button" class="close" data-dismiss="alert"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                                                <i class="fa fa-times-circle m-right-xs"></i> <strong>Oh snap!</strong> <%=theMessage%>
                                            </div>
                                            <%
                                                }
                                            %>
                                            <div class="form-group m-bottom-md">
                                                <input type="text" name="email" class="form-control" placeholder="Email Address">
                                            </div>
                                            <div class="form-group">
                                                <input type="password" name="password" class="form-control" placeholder="Password">
                                            </div>

                                            <div class="form-group">
                                                <div class="custom-checkbox">
                                                    <input type="checkbox" id="chkRemember">
                                                    <label for="chkRemember"></label>
                                                </div>
                                                Remember me
                                            </div>

                                            <div class="m-top-md p-top-sm">
                                                <a onclick="document.getElementById('loginForm').submit();" class="btn btn-success block">Sign in</a>
                                            </div>
                                        </form>
                                    </div>
                                </div><!-- ./panel -->
                            </div><!-- ./sign-in-inner -->
                        </div><!-- ./sign-in-wrapper -->
                    </div><!-- /wrapper -->
                </div>
            </div>
        </div>
    </body>
</html>
