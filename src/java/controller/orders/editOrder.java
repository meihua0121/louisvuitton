/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller.orders;

import dao.OrdersDAO;
import dao.OrdersLogDAO;
import entity.Events;
import entity.Orders;
import entity.OrdersLog;
import java.io.IOException;
import java.util.Date;
import java.text.SimpleDateFormat;
import java.time.Instant;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.ZonedDateTime;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author HP
 */
public class editOrder extends HttpServlet {

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
        OrdersDAO orderManager = new OrdersDAO();
        OrdersLogDAO orderLogsManager = new OrdersLogDAO();
        //Get the parameters from the form
        String eventID = request.getParameter("eventID");
        
        
        
        String orderID = request.getParameter("orderID");
        String orderOwner = request.getParameter("orderOwner");
        String storeCode = request.getParameter("storeCode");
        String productFamily = request.getParameter("productFamily");
        int productQuantity = 0;
        try{
            productQuantity = Integer.parseInt(request.getParameter("orderQuantity"));
        }catch(Exception e){
            System.out.println(e.getMessage());
        }
        String shippingMethod = request.getParameter("shippingMethod");
        String orderPriority = request.getParameter("orderPriority");
        String orderComment = request.getParameter("orderComment");

        Orders theOrder = orderManager.searchOrders(orderID);
        if(theOrder == null){
            response.sendRedirect("orders.jsp");
        }
        Date entryDate = theOrder.getOrderDate();
        String shippingDate = request.getParameter("shippingDate");
        String orderNumber = request.getParameter("orderNumber");
        String orderStatus = theOrder.getOrderStatus();
        String trackingNumber = theOrder.getTrackingNumber();
        Date dateCompleted = theOrder.getDateCompleted();

        SimpleDateFormat format = new SimpleDateFormat("yyyyMMdd");

        String[] ddMMYYYY_shippingDate = shippingDate.split("-");
        Date shippingDate_parsed = null;
        try {

            if (ddMMYYYY_shippingDate[0].length() == 4) {
                shippingDate_parsed = format.parse(ddMMYYYY_shippingDate[0] + ddMMYYYY_shippingDate[1] + ddMMYYYY_shippingDate[2]);
            } else {
                shippingDate_parsed = format.parse(ddMMYYYY_shippingDate[2] + ddMMYYYY_shippingDate[0] + ddMMYYYY_shippingDate[1]);
            }
            // System.out.println(eventDate_parsed);
            //System.out.println(eventDeadline_parsed);
        } catch (Exception e) {

        }

        java.sql.Date eventDeadline_sql = new java.sql.Date(shippingDate_parsed.getTime());
        java.sql.Date entryDate_sql = new java.sql.Date(entryDate.getTime());
        java.sql.Date dateCompleted_sql = null;
        if (dateCompleted != null) {
            dateCompleted_sql = new java.sql.Date(dateCompleted.getTime());
        }

        Orders newOrder = new Orders(orderID, entryDate_sql, orderOwner, storeCode, productFamily, productQuantity, eventDeadline_sql, shippingMethod, orderStatus, orderComment, orderPriority, eventID, trackingNumber, dateCompleted_sql, orderNumber);
        orderManager.updateOrders(newOrder);

        //Generate orderlogsID
        String orderLogID = orderLogsManager.createOrderLogID();
        java.sql.Timestamp timestamp = new java.sql.Timestamp(System.currentTimeMillis());
        String inputTime = timestamp.toString();
        String inputIso8601 = inputTime.replace(" ", "T");
        LocalDateTime localDateTime = LocalDateTime.parse(inputIso8601);
        ZoneId zoneId = ZoneId.of("America/New_York");
        ZonedDateTime zdt = ZonedDateTime.of(localDateTime, zoneId);
        Instant instant = zdt.toInstant();
        java.sql.Timestamp ts = java.sql.Timestamp.from(instant);
        
        OrdersLog orderLog = new OrdersLog(orderLogID, orderID, entryDate_sql, orderOwner, storeCode, productFamily, productQuantity, eventDeadline_sql, shippingMethod, orderStatus, orderComment, orderPriority, eventID, trackingNumber, null, orderNumber, "edit", "Distribution Center", "Owner", ts);
        orderLogsManager.insertOrdersLog(orderLog);

        RequestDispatcher rd = request.getRequestDispatcher("orders.jsp");
        request.setAttribute("OrderMessage", orderID + " was successfully editted!");
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
