/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller.dc.tasks;

import controller.tasks.*;
import dao.TasksDAO;
import entity.Tasks;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author HP
 */
public class editTaskDC extends HttpServlet {

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
        TasksDAO taskManager = new TasksDAO();
        //Get the parameters from the form

        String orderID = request.getParameter("orderID");
        String taskID = request.getParameter("taskID");
        String taskDescription = request.getParameter("taskDescription");
        String taskOwner = request.getParameter("taskOwner");
        String taskPriority = request.getParameter("taskPriority");

        String taskComment = request.getParameter("taskComment");
        String entryDate = request.getParameter("taskDate");
        String taskDeadline = request.getParameter("taskDeadline");

        Tasks theTask = TasksDAO.searchTasks(taskID);
        String progressStatus = theTask.getTaskProcessStatus();
        System.out.println(theTask);
        
        SimpleDateFormat format = new SimpleDateFormat("yyyyMMdd");

        String[] ddMMYYYY_entryDate = entryDate.split("-");
        String[] ddMMYYYY_taskDeadline = taskDeadline.split("-");
        Date entryDate_parsed = null;
        Date taskDeadline_parsed = null;
        try {
            entryDate_parsed = format.parse(ddMMYYYY_entryDate[0] + ddMMYYYY_entryDate[1] + ddMMYYYY_entryDate[2]);
            if (ddMMYYYY_taskDeadline[0].length() == 4) {
                taskDeadline_parsed = format.parse(ddMMYYYY_taskDeadline[0] + ddMMYYYY_taskDeadline[1] + ddMMYYYY_taskDeadline[2]);
            } else {
                taskDeadline_parsed = format.parse(ddMMYYYY_taskDeadline[2] + ddMMYYYY_taskDeadline[0] + ddMMYYYY_taskDeadline[1]);
            }
        } catch (Exception e) {

        }

        java.sql.Date entryDate_sql = new java.sql.Date(entryDate_parsed.getTime());
        java.sql.Date  eventDeadline_sql = new java.sql.Date(taskDeadline_parsed.getTime());
        Tasks newTask = new Tasks(taskID, entryDate_sql, taskOwner, taskPriority, orderID, eventDeadline_sql, progressStatus, taskDescription, taskComment);
        System.out.println(newTask);
        
        taskManager.updateTasks(newTask);
        String message = taskID + " was successfully editted!";
        response.sendRedirect("distributionCenter/specificOrders.jsp?orderID=" + orderID);

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
