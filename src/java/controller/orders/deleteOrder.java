/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller.orders;

import dao.OrdersDAO;
import dao.OrdersLogDAO;
import entity.Orders;
import entity.OrdersLog;
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
public class deleteOrder extends HttpServlet {

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
        OrdersDAO ordersManager = new OrdersDAO();
        OrdersLogDAO orderLogsManager = new OrdersLogDAO();

        String orderID = request.getParameter("orderID");
        Orders theOrder = ordersManager.searchOrders(orderID);
        String orderNumber = theOrder.getOrderNumber();
        String eventID = theOrder.getEventID();
        Date orderDate = theOrder.getOrderDate();
        String orderOwner = theOrder.getOrderOwner();
        String storeCode = theOrder.getStoreCode();
        String productFamily = theOrder.getProductFamily();
        int orderQuantity = theOrder.getOrderQuantity();
        Date shippingDate = theOrder.getShippingDate();
        String shippingMethod = theOrder.getShippingMethod();
        String comments = theOrder.getOrderComments();
        String orderStatus = theOrder.getOrderStatus();
        //Perform priority checking for events
        String orderPriority = theOrder.getPriority();
        String trackingnumber = theOrder.getTrackingNumber();
        Date dateCompleted = theOrder.getDateCompleted();

        //Delete order
        ordersManager.deleteOrders(orderID);

        //Generate orderlogsID
        String orderLogID = orderLogsManager.createOrderLogID();
        java.sql.Timestamp timestamp = new java.sql.Timestamp(System.currentTimeMillis());
        //Generate orderlogsID
        String inputTime = timestamp.toString();
        String inputIso8601 = inputTime.replace(" ", "T");
        LocalDateTime localDateTime = LocalDateTime.parse(inputIso8601);
        ZoneId zoneId = ZoneId.of("America/New_York");
        ZonedDateTime zdt = ZonedDateTime.of(localDateTime, zoneId);
        Instant instant = zdt.toInstant();
        java.sql.Timestamp ts = java.sql.Timestamp.from(instant);

        OrdersLog orderLog = new OrdersLog(orderLogID, orderID, orderDate, orderOwner, storeCode, productFamily, orderQuantity, shippingDate, shippingMethod, orderStatus, comments, orderPriority, eventID, trackingnumber, dateCompleted, orderNumber, "delete", "Distribution Center", "Owner", ts);
        orderLogsManager.insertOrdersLog(orderLog);

        String message = "Order " + orderID + " was successfully deleted!";
        response.sendRedirect("orders.jsp?orderActionStatus=" + message);
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
