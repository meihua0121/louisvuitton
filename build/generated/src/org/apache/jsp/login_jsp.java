package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;

public final class login_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {

  private static final JspFactory _jspxFactory = JspFactory.getDefaultFactory();

  private static java.util.List<String> _jspx_dependants;

  private org.glassfish.jsp.api.ResourceInjector _jspx_resourceInjector;

  public java.util.List<String> getDependants() {
    return _jspx_dependants;
  }

  public void _jspService(HttpServletRequest request, HttpServletResponse response)
        throws java.io.IOException, ServletException {

    PageContext pageContext = null;
    HttpSession session = null;
    ServletContext application = null;
    ServletConfig config = null;
    JspWriter out = null;
    Object page = this;
    JspWriter _jspx_out = null;
    PageContext _jspx_page_context = null;

    try {
      response.setContentType("text/html");
      pageContext = _jspxFactory.getPageContext(this, request, response,
      			null, true, 8192, true);
      _jspx_page_context = pageContext;
      application = pageContext.getServletContext();
      config = pageContext.getServletConfig();
      session = pageContext.getSession();
      out = pageContext.getOut();
      _jspx_out = out;
      _jspx_resourceInjector = (org.glassfish.jsp.api.ResourceInjector) application.getAttribute("com.sun.appserv.jsp.resource.injector");

      out.write("<!DOCTYPE html>\n");
      out.write("<html lang=\"en\">\n");
      out.write("    <head>\n");
      out.write("        <meta charset=\"utf-8\">\n");
      out.write("        <title>Louis Vuitton - Facilitating Communications</title>\n");
      out.write("        <link rel=\"shortcut icon\" type=\"image/x-icon\" href=\"image/LV_logo.jpg\" />\n");
      out.write("        <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\n");
      out.write("        <meta name=\"description\" content=\"\">\n");
      out.write("        <meta name=\"author\" content=\"\">\n");
      out.write("\n");
      out.write("        <!-- Bootstrap core CSS -->\n");
      out.write("        <link href=\"twitterBootstrap/bootstrap/css/bootstrap.min.css\" rel=\"stylesheet\">\n");
      out.write("\n");
      out.write("        <!-- Font Awesome -->\n");
      out.write("        <link href=\"twitterBootstrap/css/font-awesome.min.css\" rel=\"stylesheet\">\n");
      out.write("\n");
      out.write("        <!-- ionicons -->\n");
      out.write("        <link href=\"twitterBootstrap/css/ionicons.min.css\" rel=\"stylesheet\">\n");
      out.write("\n");
      out.write("        <!-- Simplify -->\n");
      out.write("        <link href=\"twitterBootstrap/css/simplify.min.css\" rel=\"stylesheet\">\n");
      out.write("\n");
      out.write("        <style>\n");
      out.write("            #background {\n");
      out.write("                position: fixed;\n");
      out.write("                top: 50%;\n");
      out.write("                left: 50%;\n");
      out.write("                min-width: 100%;\n");
      out.write("                min-height: 100%;\n");
      out.write("                width: auto;\n");
      out.write("                height: auto;\n");
      out.write("                z-index: -100;\n");
      out.write("                -webkit-transform: translateX(-50%) translateY(-50%);\n");
      out.write("                transform: translateX(-50%) translateY(-50%);\n");
      out.write("                background: url(polina.jpg) no-repeat;\n");
      out.write("                background-size: cover;\n");
      out.write("            }\n");
      out.write("            .container h1 {\n");
      out.write("                color: white;\n");
      out.write("            }\n");
      out.write("        </style>\n");
      out.write("    </head>\n");
      out.write("\n");
      out.write("    ");

        String theMessage = request.getParameter("message");
    
      out.write("\n");
      out.write("    <body>\n");
      out.write("        <!--<video autoplay loop muted poster=\"screenshot.jpg\" id=\"background\">\n");
      out.write("            <source src=\"http://techslides.com/demos/sample-videos/small.mp4\" type=\"video/mp4\">\n");
      out.write("        </video>-->\n");
      out.write("        <div style=\"position: fixed; z-index: -99; width: 100%; height: 100%\">\n");
      out.write("            <iframe frameborder=\"0\" height=\"100%\" width=\"100%\" \n");
      out.write("                    src=\"https://youtube.com/embed/jFne8xKtRTE?autoplay=1&controls=0&showinfo=0&autohide=1\">\n");
      out.write("            </iframe>\n");
      out.write("        </div>\n");
      out.write("        <div class=\"container\">\n");
      out.write("            <div class=\"row\">\n");
      out.write("                <div class=\"col-md-12\">\n");
      out.write("                    <div class=\"wrapper no-navigation preload\"><div class=\"sign-in-wrapper\">\n");
      out.write("                            <div class=\"sign-in-inner\">\n");
      out.write("                                <div class=\"panel\" style=\"opacity: 0.95\">\n");
      out.write("                                    <div class=\"panel-footer bg-white\">\n");
      out.write("\n");
      out.write("                                        <div class=\"login-brand text-center\">\n");
      out.write("                                            <img src=\"image/LV_logo.jpg\" alt=\"Mountain View\" style=\"width:50px;height:50px;\">\n");
      out.write("                                            <b>Louis</b> <strong class=\"text-skin\">Vuitton</strong>\n");
      out.write("                                        </div>\n");
      out.write("                                        <form action=\"loginAccount\" method='POST' id='loginForm'>\n");
      out.write("                                            ");

                                                if (theMessage != null) {
                                            
      out.write("\n");
      out.write("                                            <div class=\"alert alert-danger alert-dismissible\" role=\"alert\">\n");
      out.write("                                                <button type=\"button\" class=\"close\" data-dismiss=\"alert\"><span aria-hidden=\"true\">&times;</span><span class=\"sr-only\">Close</span></button>\n");
      out.write("                                                <i class=\"fa fa-times-circle m-right-xs\"></i> <strong>Oh snap!</strong> ");
      out.print(theMessage);
      out.write("\n");
      out.write("                                            </div>\n");
      out.write("                                            ");

                                                }
                                            
      out.write("\n");
      out.write("                                            <div class=\"form-group m-bottom-md\">\n");
      out.write("                                                <input type=\"text\" name=\"email\" class=\"form-control\" placeholder=\"Email Address\">\n");
      out.write("                                            </div>\n");
      out.write("                                            <div class=\"form-group\">\n");
      out.write("                                                <input type=\"password\" name=\"password\" class=\"form-control\" placeholder=\"Password\">\n");
      out.write("                                            </div>\n");
      out.write("\n");
      out.write("                                            <div class=\"form-group\">\n");
      out.write("                                                <div class=\"custom-checkbox\">\n");
      out.write("                                                    <input type=\"checkbox\" id=\"chkRemember\">\n");
      out.write("                                                    <label for=\"chkRemember\"></label>\n");
      out.write("                                                </div>\n");
      out.write("                                                Remember me\n");
      out.write("                                            </div>\n");
      out.write("\n");
      out.write("                                            <div class=\"m-top-md p-top-sm\">\n");
      out.write("                                                <a onclick=\"document.getElementById('loginForm').submit();\" class=\"btn btn-success block\">Sign in</a>\n");
      out.write("                                            </div>\n");
      out.write("                                        </form>\n");
      out.write("                                    </div>\n");
      out.write("                                </div><!-- ./panel -->\n");
      out.write("                            </div><!-- ./sign-in-inner -->\n");
      out.write("                        </div><!-- ./sign-in-wrapper -->\n");
      out.write("                    </div><!-- /wrapper -->\n");
      out.write("                </div>\n");
      out.write("            </div>\n");
      out.write("        </div>\n");
      out.write("    </body>\n");
      out.write("</html>\n");
    } catch (Throwable t) {
      if (!(t instanceof SkipPageException)){
        out = _jspx_out;
        if (out != null && out.getBufferSize() != 0)
          out.clearBuffer();
        if (_jspx_page_context != null) _jspx_page_context.handlePageException(t);
        else throw new ServletException(t);
      }
    } finally {
      _jspxFactory.releasePageContext(_jspx_page_context);
    }
  }
}
