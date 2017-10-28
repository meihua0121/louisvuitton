/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller.tasks;

import dao.EmailDAO;
import dao.LoginDAO;
import dao.OrdersDAO;
import dao.TasksDAO;
import dao.TasksLogDAO;
import entity.Tasks;
import entity.TasksLog;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.time.Instant;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.ZonedDateTime;
import java.util.Calendar;
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
public class addTask extends HttpServlet {

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
        try (PrintWriter out = response.getWriter()) {

            //Initialize the eventmanager instance
            OrdersDAO orderManager = new OrdersDAO();
            TasksDAO taskManager = new TasksDAO();
            LoginDAO userManager = new LoginDAO();
            TasksLogDAO tasksLogManager = new TasksLogDAO();

            //Get the parameters from the form
            String orderID = request.getParameter("theOrderID");
            String taskID = taskManager.createTaskID();
            String taskDescription = request.getParameter("taskDescription");
            String assignTo = request.getParameter("assignTo");
            String taskDeadline = request.getParameter("taskDeadline");
            String taskPriority = request.getParameter("taskPriority");
            String taskComment = request.getParameter("taskComment");
            String shouldSendEmail = request.getParameter("sendEmail");

            String taskStatus = "0";
            SimpleDateFormat format = new SimpleDateFormat("yyyyMMdd");
            java.sql.Date dateToday = null;
            //Process the date
            String[] ddMMYYYY = taskDeadline.split("-");

            Date parsed = null;
            int orderQuantity = 0;

            try {
                dateToday = new java.sql.Date(Calendar.getInstance().getTime().getTime());
                parsed = format.parse(ddMMYYYY[0] + ddMMYYYY[1] + ddMMYYYY[2]);
            } catch (Exception e) {
                System.out.println(e.getMessage());
            }

            java.sql.Date sql = new java.sql.Date(parsed.getTime());
            Tasks newTask = new Tasks(taskID, dateToday, assignTo, taskPriority, orderID, sql, taskStatus, taskDescription, taskComment);
            taskManager.insertTasks(newTask);
            
            if (shouldSendEmail.equals("Yes")) {
                //Send email to inform person who was assigned task
                String additionalMessage = request.getParameter("emailMessage");;
                EmailDAO emailSend = new EmailDAO();
                String message = "Order: " + orderID + "\n"
                        + "Task: " + taskID + "\n"
                        + "Task Description: " + taskDescription + "\n"
                        + "Task Deadline: " + taskDeadline + "\n"
                        + "Task Priority: " + taskPriority + "\n"
                        + "Task Status: " + taskStatus + "%\n"
                        + "Task Comments: " + taskComment + "\n\n"
                        + "Additional Message: " + additionalMessage;
                emailSend.sendMail(assignTo, "LVSystem123@gmail.com", "smtp.gmail.com", "New Task Assigned to you!", message);
            }
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

            TasksLog taskLog = new TasksLog(taskLogID, taskID, dateToday, assignTo, taskPriority, orderID, sql, taskStatus, taskDescription, taskComment, "create", "Distribution Center", "owner", ts);
            tasksLogManager.insertTasksLog(taskLog);

            RequestDispatcher rd = request.getRequestDispatcher("tasks.jsp");
            request.setAttribute("TaskMessage", taskID + " was successfully created!");
            rd.forward(request, response);
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
