/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller.orders;

import dao.EmailDAO;
import dao.OrdersDAO;
import dao.OrdersLogDAO;
import entity.Orders;
import entity.OrdersLog;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;
import java.text.SimpleDateFormat;
import java.time.Instant;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.ZonedDateTime;
import java.util.ArrayList;
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
public class addOrder extends HttpServlet {

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
            OrdersLogDAO orderLogsManager = new OrdersLogDAO();

            //Get the parameters from the form
            String eventID = request.getParameter("theEventID");
            String orderID = orderManager.createOrderID();
            String orderOwner = request.getParameter("orderOwner");
            String storeCode = request.getParameter("storeCode");
            String productFamily = request.getParameter("productFamily");
            String productQuantity = request.getParameter("productQuantity");
            String shippingDate = request.getParameter("shippingDate");
            String shippingMethod = request.getParameter("shippingMethod");
            String orderPriority = request.getParameter("orderPriority");
            String orderComment = request.getParameter("orderComment");
            String orderNumber = request.getParameter("orderNumber");
            String shouldSendEmail = request.getParameter("sendEmail");
            //orderComment = orderComment.replace("\"", "\\\"");
            //orderComment = orderComment.replace("\'", "\\\'");
                    
            String orderStatus = "0";
            String trackingNumber = "";
            SimpleDateFormat format = new SimpleDateFormat("yyyyMMdd");
            java.sql.Date dateToday = null;
            //Process the date
            String[] ddMMYYYY = shippingDate.split("-");

            Date parsed = null;
            int orderQuantity = 0;
            try {
                dateToday = new java.sql.Date(Calendar.getInstance().getTime().getTime());
                parsed = format.parse(ddMMYYYY[0] + ddMMYYYY[1] + ddMMYYYY[2]);
                orderQuantity = Integer.parseInt(productQuantity);
                //parsed = format.parse("20111102");
            } catch (Exception e) {

            }

            java.sql.Date sql = new java.sql.Date(parsed.getTime());

            Orders newOrder = new Orders(orderID, dateToday, orderOwner, storeCode, productFamily, orderQuantity, sql, shippingMethod, orderStatus, orderComment, orderPriority, eventID, trackingNumber, null, orderNumber);
            orderManager.insertOrders(newOrder);
            if (shouldSendEmail.equals("Yes")) {
                
                ArrayList<String> emailAddress = new ArrayList<>();
                emailAddress.add("phil.perrotta@louisvuitton.com");
                emailAddress.add("luis.restrepo@louisvuitton.com");
                emailAddress.add("mary.baccam@louisvuitton.com");
                emailAddress.add("gabriel.beck@louisvuitton.com");
                emailAddress.add("yk2738@columbia.edu");
                String additionalMessage = request.getParameter("emailMessage");;
                //Send email to inform person who was assigned task
                EmailDAO emailSend = new EmailDAO();
                String message = "Order ID: " + orderID + "\n"
                        + "Order Number: " + orderNumber + "\n"
                        + "Store Code: " + storeCode + "\n"
                        + "Product Family: " + productFamily + "\n"
                        + "Quantity: " + productQuantity + "\n"
                        + "Shipping Date: " + shippingDate + "\n"
                        + "Shipping Method: " + shippingMethod + "\n"
                        + "Order Priority: " + orderPriority + "\n"
                        + "Order Comment: " + orderComment + "\n\n"
                        + "Additional Message: " + additionalMessage;
                
                for(int i=0; i<emailAddress.size(); i++){
                    emailSend.sendMail(emailAddress.get(i), "LVSystem123@gmail.com", "smtp.gmail.com", "New Order!", message);
                }
            }
            //Generate orderlogsID
            String orderLogID = orderLogsManager.createOrderLogID();
            java.sql.Timestamp timestamp = new java.sql.Timestamp(System.currentTimeMillis());
            String inputTime = timestamp.toString();
            String inputIso8601 = inputTime.replace ( " ", "T" );
            LocalDateTime localDateTime = LocalDateTime.parse ( inputIso8601 );
            ZoneId zoneId = ZoneId.of ( "America/New_York" );
            ZonedDateTime zdt = ZonedDateTime.of ( localDateTime, zoneId );
            Instant instant = zdt.toInstant();
            java.sql.Timestamp ts = java.sql.Timestamp.from (instant);
            
            OrdersLog orderLog = new OrdersLog(orderLogID, orderID, dateToday, orderOwner, storeCode, productFamily, orderQuantity, sql, shippingMethod, orderStatus, orderComment, orderPriority, eventID, trackingNumber, null, orderNumber, "create", "Distribution Center", "Owner", ts);
            orderLogsManager.insertOrdersLog(orderLog);

            RequestDispatcher rd = request.getRequestDispatcher("orders.jsp");
            request.setAttribute("OrderMessage", orderID + " was successfully created!");
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
