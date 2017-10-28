/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller.logs.tasks;

import dao.TasksDAO;
import entity.Tasks;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author HP
 */
public class editTaskStatus extends HttpServlet {

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

        String path = request.getContextPath();

        TasksDAO taskManager = new TasksDAO();
        String taskID = request.getParameter("taskID");
        String email = request.getParameter("theEmail");
        Tasks theTask = TasksDAO.searchTasks(taskID);

        String orderID = theTask.getOrderID();
        String taskDescription = theTask.getTaskDescription();
        Date entryDate = theTask.getTaskDate();
        String taskOwner = theTask.getTaskOwner();
        Date taskDeadline = theTask.getTaskDeadline();
        String taskComments = theTask.getTaskComments();
        String taskPriority = theTask.getPriority();
        String taskStatus = theTask.getTaskProcessStatus();
        
        if(taskStatus.equals("0")){
            taskStatus = "100";
        }else{
            taskStatus = "0";
        }
        
        Tasks newTask = new Tasks(taskID, entryDate, taskOwner, taskPriority, orderID, taskDeadline, taskStatus, taskDescription, taskComments);
        taskManager.updateTasks(newTask);

        if (taskStatus.equals("0")) {
            response.sendRedirect("teamLead/task_assignment.jsp?Email=" + email);
        } else {
            response.sendRedirect("teamLead/task_assignment.jsp?Email=" + email);
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
