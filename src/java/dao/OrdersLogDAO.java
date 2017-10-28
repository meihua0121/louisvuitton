/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import connection.ConnectionManager;
import entity.Orders;
import entity.OrdersLog;
import entity.User;
import java.sql.Connection;
import java.sql.Date;
import java.sql.Timestamp;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

/**
 *
 * @author HP
 */
public class OrdersLogDAO {

    //initiate table name
    private static final String TBLNAME = "ordersLog";
    
    public static void insertOrdersLog(OrdersLog orderLog) {
        
        String orderLogID = orderLog.getOrderLogID();
        String orderID = orderLog.getOrderID();
        Date orderDate = orderLog.getOrderDate();
        String orderOwner = orderLog.getOrderOwner();
        String storeCode = orderLog.getStoreCode();
        String productFamily = orderLog.getProductFamily();
        int orderQuantity = orderLog.getOrderQuantity();
        Date shippingDate = orderLog.getShippingDate();
        String shippingMethod = orderLog.getShippingMethod();
        String orderStatus = orderLog.getOrderStatus();
        String orderComments = orderLog.getOrderComments();
        String priority = orderLog.getPriority();
        String eventID = orderLog.getEventID();
        String trackingNumber = orderLog.getTrackingNumber();
        Date dateCompleted = orderLog.getDateCompleted();
        String actionType = orderLog.getActionType();
        String userType = orderLog.getUserType();
        String username = orderLog.getUsername();
        Timestamp timestamp = orderLog.getTimestamp();
        
        try {
            Connection conn = ConnectionManager.getConnection();
            PreparedStatement ps;
            String insertOrder = "insert into ordersLog(orderLogID, orderID, orderDate, orderOwner, storeCode, productFamily, orderQuantity, shippingDate, shippingMethod, orderStatus, orderComments, priority, eventID, trackingNumber, dateCompleted, orderNumber, actionType, userType, username, timestamp) Values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?);";
            ps = conn.prepareStatement(insertOrder);
            ps.setString(1, orderLogID);
            ps.setString(2, orderID);
            ps.setDate(3, orderDate);
            ps.setString(4, orderOwner);
            ps.setString(5, storeCode);
            ps.setString(6, productFamily);
            ps.setInt(7, orderQuantity);
            ps.setDate(8, shippingDate);
            ps.setString(9, shippingMethod);
            ps.setString(10, orderStatus);
            ps.setString(11, orderComments);
            ps.setString(12, priority);
            ps.setString(13,eventID);
            ps.setString(14,trackingNumber);
            ps.setDate(15,dateCompleted);
            ps.setString(16,trackingNumber);
            ps.setString(17, actionType);
            ps.setString(18, userType);
            ps.setString(19, username);
            ps.setTimestamp(20, timestamp);
            ps.executeUpdate();

        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
    }

    public static List<OrdersLog> retrieveOrdersLog() {
        //These are for connection to mySQL database
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        List<OrdersLog> results = new ArrayList<>();

        try {
            conn = ConnectionManager.getConnection();

            String sql = "SELECT orderLogID, orderID, orderDate, orderOwner, storeCode, productFamily, orderQuantity, shippingDate, shippingMethod, orderStatus, orderComments, priority, eventID, trackingNumber, dateCompleted, orderNumber, actionType, userType, username, timestamp FROM " + TBLNAME;
            stmt = conn.prepareStatement(sql);

            rs = stmt.executeQuery();
            while (rs.next()) {
                String orderLogID = rs.getString("orderLogID");
                String orderID = rs.getString("orderID");
                Date orderDate = rs.getDate("orderDate");
                String orderOwner = rs.getString("orderOwner");
                String storeCode = rs.getString("storeCode");
                String productFamily = rs.getString("productFamily");
                int orderQuantity = rs.getInt("orderQuantity");
                Date shippingDate = rs.getDate("shippingDate");
                String shippingMethod = rs.getString("shippingMethod");
                String orderStatus = rs.getString("orderStatus");
                String orderComments = rs.getString("orderComments");
                String priority = rs.getString("priority");
                String eventID = rs.getString("eventID");
                String trackingNumber = rs.getString("trackingNumber");
                Date dateCompleted = rs.getDate("dateCompleted");
                String orderNumber = rs.getString("orderNumber");
                String actionType = rs.getString("actionType");
                String userType = rs.getString("userType");
                String username = rs.getString("username");
                Timestamp timestamp = rs.getTimestamp("timestamp");

                OrdersLog obj = new OrdersLog(orderLogID, orderID, orderDate, orderOwner, storeCode, productFamily, orderQuantity, shippingDate, shippingMethod, orderStatus, orderComments, priority, eventID, trackingNumber, dateCompleted, orderNumber, actionType, userType, username, timestamp);
                results.add(obj);
            }

        } catch (SQLException e) {
            System.out.println(e.getMessage());
        } finally {
            ConnectionManager.close(conn, stmt, rs);

        }
        return results;
    }

    public static OrdersLog searchOrdersLog(String searchText) {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        OrdersLog obj = null;
        try {
            conn = ConnectionManager.getConnection();

            String sql = "SELECT orderLogID, orderID, orderDate, orderOwner, storeCode, productFamily, orderQuantity, shippingDate, shippingMethod, orderStatus, orderComments, priority, eventID, trackingNumber, dateCompleted, orderNumber, actionType, userType, username, timestamp FROM " + TBLNAME + " WHERE orderLogID LIKE ?";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, "%" + searchText + "%");
            System.out.println(sql);
            rs = stmt.executeQuery();
            while (rs.next()) {
                String orderLogID = rs.getString("orderLogID");
                String orderID = rs.getString("orderID");
                Date orderDate = rs.getDate("orderDate");
                String orderOwner = rs.getString("orderOwner");
                String storeCode = rs.getString("storeCode");
                String productFamily = rs.getString("productFamily");
                int orderQuantity = rs.getInt("orderQuantity");
                Date shippingDate = rs.getDate("shippingDate");
                String shippingMethod = rs.getString("shippingMethod");
                String orderStatus = rs.getString("orderStatus");
                String orderComments = rs.getString("orderComments");
                String priority = rs.getString("priority");
                String eventID = rs.getString("eventID");
                String trackingNumber = rs.getString("trackingNumber");
                Date dateCompleted = rs.getDate("dateCompleted");
                String orderNumber = rs.getString("orderNumber");
                String actionType = rs.getString("actionType");
                String userType = rs.getString("userType");
                String username = rs.getString("username");
                Timestamp timestamp = rs.getTimestamp("timestamp");

                obj = new OrdersLog(orderLogID, orderID, orderDate, orderOwner, storeCode, productFamily, orderQuantity, shippingDate, shippingMethod, orderStatus, orderComments, priority, eventID, trackingNumber, dateCompleted, orderNumber, actionType, userType, username, timestamp);
            }

        } catch (SQLException e) {
            System.out.println(e.getMessage());
        } finally {
            ConnectionManager.close(conn, stmt);
        }
        return obj;
    }
    
    public static List<OrdersLog> filterOrdersLog(String attribute, String value) {
        Connection conn = null;
        PreparedStatement stmt = null;
        String sql = "";
        ResultSet rs = null;
        OrdersLog obj = null;
        List<OrdersLog> results = new ArrayList<>();
        
        try {
            conn = ConnectionManager.getConnection();

            sql = "SELECT orderLogID, orderID, orderDate, orderOwner, storeCode, productFamily, orderQuantity, shippingDate, shippingMethod, orderStatus, orderComments, priority, eventID, trackingNumber, dateCompleted, orderNumber, actionType, userType, username, timestamp FROM " + TBLNAME + " WHERE " + attribute + " LIKE ?";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, value);
            rs = stmt.executeQuery();
            while (rs.next()) {
                String orderLogID = rs.getString("orderLogID");
                String orderID = rs.getString("orderID");
                Date orderDate = rs.getDate("orderDate");
                String orderOwner = rs.getString("orderOwner");
                String storeCode = rs.getString("storeCode");
                String productFamily = rs.getString("productFamily");
                int orderQuantity = rs.getInt("orderQuantity");
                Date shippingDate = rs.getDate("shippingDate");
                String shippingMethod = rs.getString("shippingMethod");
                String orderStatus = rs.getString("orderStatus");
                String orderComments = rs.getString("orderComments");
                String priority = rs.getString("priority");
                String eventID = rs.getString("eventID");
                String trackingNumber = rs.getString("trackingNumber");
                Date dateCompleted = rs.getDate("dateCompleted");
                String orderNumber = rs.getString("orderNumber");
                String actionType = rs.getString("actionType");
                String userType = rs.getString("userType");
                String username = rs.getString("username");
                Timestamp timestamp = rs.getTimestamp("timestamp");

                obj = new OrdersLog(orderLogID, orderID, orderDate, orderOwner, storeCode, productFamily, orderQuantity, shippingDate, shippingMethod, orderStatus, orderComments, priority, eventID, trackingNumber, dateCompleted, orderNumber, actionType, userType, username, timestamp);
                results.add(obj);
            }

        } catch (SQLException e) {
            System.out.println(e.getMessage());
        } finally {
            ConnectionManager.close(conn, stmt);
        }
        return results;
    }
    
    public static List<OrdersLog> retrieveOrdersLogOfUser(String userName) {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        List<OrdersLog> results = new ArrayList<>();

        try {
            conn = ConnectionManager.getConnection();

            String sql = "SELECT orderLogID, orderID, orderDate, orderOwner, storeCode, productFamily, orderQuantity, shippingDate, shippingMethod, orderStatus, orderComments, priority, eventID, trackingNumber, dateCompleted, orderNumber, actionType, userType, username, timestamp FROM " + TBLNAME + " WHERE username LIKE ? ";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, userName);
            rs = stmt.executeQuery();

            while (rs.next()) {
                String orderLogID = rs.getString("orderLogID");
                String orderID = rs.getString("orderID");
                Date orderDate = rs.getDate("orderDate");
                String orderOwner = rs.getString("orderOwner");
                String storeCode = rs.getString("storeCode");
                String productFamily = rs.getString("productFamily");
                int orderQuantity = rs.getInt("orderQuantity");
                Date shippingDate = rs.getDate("shippingDate");
                String shippingMethod = rs.getString("shippingMethod");
                String orderStatus = rs.getString("orderStatus");
                String orderComments = rs.getString("orderComments");
                String priority = rs.getString("priority");
                String eventID = rs.getString("eventID");
                String trackingNumber = rs.getString("trackingNumber");
                Date dateCompleted = rs.getDate("dateCompleted");
                String orderNumber = rs.getString("orderNumber");
                String actionType = rs.getString("actionType");
                String userType = rs.getString("userType");
                String username = rs.getString("username");
                Timestamp timestamp = rs.getTimestamp("timestamp");

                OrdersLog obj = new OrdersLog(orderLogID, orderID, orderDate, orderOwner, storeCode, productFamily, orderQuantity, shippingDate, shippingMethod, orderStatus, orderComments, priority, eventID, trackingNumber, dateCompleted, orderNumber, actionType, userType, username, timestamp);
                results.add(obj);
            }

        } catch (SQLException e) {
            System.out.println(e.getMessage());
        } finally {
            ConnectionManager.close(conn, stmt, rs);

        }
        return results;
    }
    
    public static String createOrderLogID() {
        List<OrdersLog> results = retrieveOrdersLog();
        List<Integer> OrdersLogID = new ArrayList<>(); 
        for (OrdersLog orderLog : results) {
            String s = orderLog.getOrderLogID();
            if (s.matches("OL\\d*(\\d)?")) {
                Integer i = Integer.parseInt(s.substring(2));
                OrdersLogID.add(i);            
            }                
        }
        Integer min = 1;
        Integer found = 0;
        while (found == 0){
            if (OrdersLogID.contains(min)) {
                min = min + 1;
            }
            else {
                found = 1;
            }
        }
        return ("OL"+String.valueOf(min));
    }
} 
