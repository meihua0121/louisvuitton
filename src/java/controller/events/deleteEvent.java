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
public class deleteEvent extends HttpServlet {

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
        
        EventsDAO eventsManager = new EventsDAO();
        EventsLogDAO eventLogManager = new EventsLogDAO();

        String eventID = request.getParameter("eventID");
        Events theEvent = eventsManager.searchEvents(eventID);

        //Delete the events
        eventsManager.deleteEvents(eventID);

        //Retrieve parameters to log down the changes
        String eventName = theEvent.getEventName();
        Date eventDate = theEvent.getEventDate();
        Date eventDeadline = theEvent.getEventDeadline();
        String eventProcessStatus = theEvent.getEventProcessStatus();
        String eventOwner = theEvent.getEventOwner();
        String eventLocation = theEvent.getEventLocation();
        String eventComments = theEvent.getComments();
        //Perform priority checking for events
        String eventPriority = theEvent.getPriority();

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
        EventsLog eventLog = new EventsLog(eventLogID, eventID, eventName, eventDate, eventOwner, eventPriority, eventDeadline, eventProcessStatus, eventLocation, eventComments, "delete", "Supply Chain", "Owner", ts);
        eventLogManager.insertEventsLog(eventLog);

        String message = "Event " + eventID + " was successfully deleted!";
        response.sendRedirect("events.jsp?eventActionStatus=" + message);
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
