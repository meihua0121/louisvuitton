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
import java.text.SimpleDateFormat;
import java.time.Instant;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.ZonedDateTime;
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
public class editEvent extends HttpServlet {

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
        //Initialize the eventmanager instance
        EventsDAO eventManager = new EventsDAO();
        EventsLogDAO eventLogManager = new EventsLogDAO();

        //shall use concatenation of event ID until i think of a better way to make them unique and not conflict
        String eventID = request.getParameter("eventID");
        String eventName = request.getParameter("eventName");
        String eventOwner = request.getParameter("eventOwner");
        String eventDate = request.getParameter("eventDate");
        String eventPriority = request.getParameter("eventPriority");
        String eventLocation = request.getParameter("eventLocation");
        String eventProcessStatus = request.getParameter("eventProgress");
        String eventComment = request.getParameter("eventComment");
        String eventDeadline = request.getParameter("eventDeadline");

        SimpleDateFormat format = new SimpleDateFormat("yyyyMMdd");
        java.sql.Date dateToday = null;

        //Process the date
        String[] ddMMYYYY_eventDate = eventDate.split("-");
        String[] ddMMYYYY_eventDeadline = eventDeadline.split("-");

        Date eventDate_parsed = null;
        Date eventDeadline_parsed = null;
        
        try {
            eventDate_parsed = format.parse(ddMMYYYY_eventDate[0] + ddMMYYYY_eventDate[1] + ddMMYYYY_eventDate[2]);
            if (ddMMYYYY_eventDeadline[0].length() == 4) {
                eventDeadline_parsed = format.parse(ddMMYYYY_eventDeadline[0] + ddMMYYYY_eventDeadline[1] + ddMMYYYY_eventDeadline[2]);
            } else {
                eventDeadline_parsed = format.parse(ddMMYYYY_eventDeadline[2] + ddMMYYYY_eventDeadline[1] + ddMMYYYY_eventDeadline[0]);
            }
        } catch (Exception e) {

        }

        //Prepare the date items
        java.sql.Date eventDate_sql = new java.sql.Date(eventDate_parsed.getTime());
        java.sql.Date eventDeadline_sql = new java.sql.Date(eventDeadline_parsed.getTime());

        //Create new event and update database
        Events newEvent = new Events(eventID, eventName, eventDate_sql, eventOwner, eventPriority, eventDeadline_sql, eventProcessStatus, eventLocation, eventComment);
        eventManager.updateEvents(newEvent);

        //Current timestamp + Generate new log id
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
        EventsLog eventLog = new EventsLog(eventLogID, eventID, eventName, eventDate_sql, eventOwner, eventPriority, eventDeadline_sql, eventProcessStatus, eventLocation, eventComment, "edit", "Supply Chain", "Owner", ts);
        eventLogManager.insertEventsLog(eventLog);

        //Redirect back to event.jsp
        RequestDispatcher rd = request.getRequestDispatcher("events.jsp");
        request.setAttribute("EventMessage", eventName + " was successfully editted!");
        rd.forward(request, response);
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
