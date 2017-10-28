/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller.users;

import dao.LoginDAO;
import entity.User;
import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author HP
 */
public class loginAccount extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        LoginDAO loginManager = new LoginDAO();
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        boolean userExists = loginManager.authUser(email, password);

        if (userExists) {
            User user = loginManager.searchUser(email);
            request.setAttribute("user", user);
            String userType = user.getType();
            RequestDispatcher rd = null;
            HttpSession session = request.getSession();

            if (userType.equals("Supply Chain")) {
                //rd = request.getRequestDispatcher("dashboard.jsp");
                session.setAttribute("supplychain", user);
                response.sendRedirect("dashboard.jsp");

            } else if (userType.equals("Distribution Center")) {
                //rd = request.getRequestDispatcher("distributionCenter/home.jsp");
                session.setAttribute("distributioncenter", user);
                response.sendRedirect("distributionCenter/home.jsp");

            } else {
                //request.setAttribute("Email", email);
                //rd = request.getRequestDispatcher("teamLead/task_assignment.jsp");
                session.setAttribute("logistics", user);
                response.sendRedirect("teamLead/task_assignment.jsp");
            }

            //rd.forward(request, response);
        } else {
            response.sendRedirect("login.jsp?message=You keyed in an invalid email/password");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
