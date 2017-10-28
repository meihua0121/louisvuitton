/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller.events;

import dao.EventsDAO;
import dao.EventsLogDAO;
import entity.Events;
import entity.EventsLog;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;
import java.text.SimpleDateFormat;
import java.time.Instant;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.ZonedDateTime;
import java.util.Calendar;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author HP
 */
public class addEvent extends HttpServlet {

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
            EventsDAO eventManager = new EventsDAO();
            EventsLogDAO eventLogManager = new EventsLogDAO();

            //shall use concatenation of event ID until i think of a better way to make them unique and not conflict
            String eventID = eventManager.createEventID();
            String eventName = request.getParameter("eventName");
            String eventOwner = request.getParameter("eventOwner");
            String eventDate = request.getParameter("eventDate");
            String eventPriority = request.getParameter("eventPriority");
            String eventLocation = request.getParameter("eventLocation");
            String eventProcessStatus = "0";
            String eventComment = request.getParameter("eventComment");

            SimpleDateFormat format = new SimpleDateFormat("yyyyMMdd");
            java.sql.Date dateToday = null;
            //Process the date
            String[] ddMMYYYY = eventDate.split("-");

            Date parsed = null;
            try {
                dateToday = new java.sql.Date(Calendar.getInstance().getTime().getTime());
                parsed = format.parse(ddMMYYYY[0] + ddMMYYYY[1] + ddMMYYYY[2]);
                //parsed = format.parse("20111102");
            } catch (Exception e) {

            }
            java.sql.Date sql = new java.sql.Date(parsed.getTime());

            //Add new event
            Events newEvent = new Events(eventID, eventName, dateToday, eventOwner, eventPriority, sql, eventProcessStatus, eventLocation, eventComment);
            eventManager.insertEvents(newEvent);

            //Current timestamp
            java.sql.Timestamp timestamp = new java.sql.Timestamp(System.currentTimeMillis());
            String eventLogID = eventLogManager.createEventLogID();
            String inputTime = timestamp.toString();
            String inputIso8601 = inputTime.replace(" ", "T");
            LocalDateTime localDateTime = LocalDateTime.parse(inputIso8601);
            ZoneId zoneId = ZoneId.of("America/New_York");
            ZonedDateTime zdt = ZonedDateTime.of(localDateTime, zoneId);
            Instant instant = zdt.toInstant();
            java.sql.Timestamp ts = java.sql.Timestamp.from(instant);

            //Add new events log
            EventsLog eventLog = new EventsLog(eventLogID, eventID, eventName, dateToday, eventOwner, eventPriority, sql, eventProcessStatus, eventLocation, eventComment, "create", "Supply Chain", "Owner", ts);
            eventLogManager.insertEventsLog(eventLog);

            RequestDispatcher rd = request.getRequestDispatcher("events.jsp");
            request.setAttribute("EventMessage", eventName + " was successfully created!");
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
