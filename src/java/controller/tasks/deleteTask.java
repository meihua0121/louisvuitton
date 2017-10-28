/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller.tasks;

import dao.TasksDAO;
import dao.TasksLogDAO;
import entity.Tasks;
import entity.TasksLog;
import java.io.IOException;
import java.sql.Date;
import java.time.Instant;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.ZonedDateTime;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author HP
 */
public class deleteTask extends HttpServlet {

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
        TasksDAO tasksManager = new TasksDAO();
        TasksLogDAO tasksLogManager = new TasksLogDAO();
        
        String taskID = request.getParameter("taskID");
        Tasks theTask = tasksManager.searchTasks(taskID);
        
        String orderID = theTask.getOrderID();
        String taskDescription = theTask.getTaskDescription();
        Date entryDate = theTask.getTaskDate();
        String taskOwner = theTask.getTaskOwner();
        Date taskDeadline = theTask.getTaskDeadline();
        String taskComments = theTask.getTaskComments();
        String taskPriority = theTask.getPriority();
        String taskStatus = theTask.getTaskProcessStatus();
        tasksManager.deleteTasks(taskID);

        //Generate parameters for the logs
        String taskLogID = tasksLogManager.createTaskLogID();
        java.sql.Timestamp timestamp = new java.sql.Timestamp(System.currentTimeMillis());
        String inputTime = timestamp.toString();
        String inputIso8601 = inputTime.replace(" ", "T");
        LocalDateTime localDateTime = LocalDateTime.parse(inputIso8601);
        ZoneId zoneId = ZoneId.of("America/New_York");
        ZonedDateTime zdt = ZonedDateTime.of(localDateTime, zoneId);
        Instant instant = zdt.toInstant();
        java.sql.Timestamp ts = java.sql.Timestamp.from(instant);
        
        TasksLog taskLog = new TasksLog(taskLogID, taskID, entryDate, taskOwner, taskPriority, orderID, taskDeadline, taskStatus, taskDescription, taskComments, "delete", "Distribution Center", "owner", ts);
        tasksLogManager.insertTasksLog(taskLog);

        String message = "Task " + taskID + " was successfully deleted!";
        response.sendRedirect("tasks.jsp?taskActionStatus=" + message);
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
