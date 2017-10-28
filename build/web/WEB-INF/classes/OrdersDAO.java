/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import connection.ConnectionManager;
import entity.Orders;
import java.io.BufferedReader;
import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author HP
 */
public class OrdersDAO {

    //initiate table name
    private static final String TBLNAME = "orders";

    public static void insertOrders(Orders order) {

        String orderID = order.getOrderID();
        Date orderDate = order.getOrderDate();
        String orderOwner = order.getOrderOwner();
        String storeCode = order.getStoreCode();
        String productFamily = order.getProductFamily();
        int orderQuantity = order.getOrderQuantity();
        Date shippingDate = order.getShippingDate();
        String shippingMethod = order.getShippingMethod();
        String orderStatus = order.getOrderStatus();
        String orderComments = order.getOrderComments();
        String priority = order.getPriority();
        //This is required because orders is a subset of tasks
        String eventID = order.getEventID();
        String trackingNumber = order.getTrackingNumber();
        Date dateCompleted = order.getDateCompleted();
        String orderNumber = order.getOrderNumber();

        try {
            Connection conn = ConnectionManager.getConnection();
            PreparedStatement ps;
            String insertOrder = "insert into orders(orderID, orderDate, orderOwner, storeCode, productFamily, orderQuantity, shippingDate, shippingMethod, orderStatus, orderComments, priority, eventID, trackingNumber, dateCompleted, orderNumber) Values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?);";

            ps = conn.prepareStatement(insertOrder);
            ps.setString(1, orderID);
            ps.setDate(2, orderDate);
            ps.setString(3, orderOwner);
            ps.setString(4, storeCode);
            ps.setString(5, productFamily);
            ps.setInt(6, orderQuantity);
            ps.setDate(7, shippingDate);
            ps.setString(8, shippingMethod);
            ps.setString(9, orderStatus);
            ps.setString(10, orderComments);
            ps.setString(11, priority);
            ps.setString(12, eventID);
            ps.setString(13, trackingNumber);
            ps.setDate(14, dateCompleted);
            ps.setString(15, orderNumber);
            ps.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
    }

    public static void deleteOrders(String orderID) {
        Connection conn = null;
        PreparedStatement stmt = null;
        String sql = "";
        try {
            conn = ConnectionManager.getConnection();

            sql = "DELETE FROM " + TBLNAME + " where orderID = ? ";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, orderID);
            stmt.executeUpdate();

        } catch (SQLException e) {
            System.out.println(e.getMessage());
        } finally {
            ConnectionManager.close(conn, stmt);
        }
    }

    public static void updateOrders(Orders order) {
        Connection conn = null;
        PreparedStatement stmt = null;
        String sql = "";
        try {
            conn = ConnectionManager.getConnection();

            sql = "UPDATE " + TBLNAME + " set orderID=?, orderDate=?, orderOwner=?, storeCode=?, productFamily=?, orderQuantity=?, shippingDate=?, shippingMethod=?, orderStatus=?, orderComments=?, priority=?, eventID=?, trackingNumber=?, dateCompleted=?, orderNumber=? " + " where orderID = ? ";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, order.getOrderID());
            stmt.setDate(2, order.getOrderDate());
            stmt.setString(3, order.getOrderOwner());
            stmt.setString(4, order.getStoreCode());
            stmt.setString(5, order.getProductFamily());
            stmt.setInt(6, order.getOrderQuantity());
            stmt.setDate(7, order.getShippingDate());
            stmt.setString(8, order.getShippingMethod());
            stmt.setString(9, order.getOrderStatus());
            stmt.setString(10, order.getOrderComments());
            stmt.setString(11, order.getPriority());
            stmt.setString(12, order.getEventID());
            stmt.setString(11, order.getPriority());
            stmt.setString(12, order.getEventID());
            stmt.setString(13, order.getTrackingNumber());
            stmt.setDate(14, order.getDateCompleted());
            stmt.setString(15, order.getOrderNumber());
            stmt.setString(16, order.getOrderID());
            stmt.executeUpdate();

        } catch (SQLException ex) {
            //
        } finally {
            ConnectionManager.close(conn, stmt);
        }
    }

    public static List<Orders> retrieveOrders() {
        //These are for connection to mySQL database
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        String sql = "";
        List<Orders> results = new ArrayList<>();

        try {
            conn = ConnectionManager.getConnection();

            sql = "SELECT orderID, orderDate, orderOwner, storeCode, productFamily, orderQuantity, shippingDate, shippingMethod, orderStatus, orderComments, priority, eventID, trackingNumber, dateCompleted, orderNumber FROM " + TBLNAME;
            stmt = conn.prepareStatement(sql);

            rs = stmt.executeQuery();

            while (rs.next()) {
                //Retrieve by column name
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

                Orders obj = new Orders(orderID, orderDate, orderOwner, storeCode, productFamily, orderQuantity, shippingDate, shippingMethod, orderStatus, orderComments, priority, eventID, trackingNumber, dateCompleted, orderNumber);
                results.add(obj);
            }

        } catch (SQLException e) {
            System.out.println(e.getMessage());
        } finally {
            ConnectionManager.close(conn, stmt, rs);

        }
        return results;
    }

    public static Orders searchOrders(String searchText) {
        Connection conn = null;
        PreparedStatement stmt = null;
        String sql = "";
        ResultSet rs = null;
        Orders obj = null;
        try {
            conn = ConnectionManager.getConnection();

            sql = "SELECT orderID, orderDate, orderOwner, storeCode, productFamily, orderQuantity, shippingDate, shippingMethod, orderStatus, orderComments, eventID, priority, trackingNumber, dateCompleted, orderNumber FROM " + TBLNAME + " WHERE orderID LIKE ?";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, "%" + searchText + "%");
            System.out.println(sql);
            rs = stmt.executeQuery();
            while (rs.next()) {

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

                obj = new Orders(orderID, orderDate, orderOwner, storeCode, productFamily, orderQuantity, shippingDate, shippingMethod, orderStatus, orderComments, priority, eventID, trackingNumber, dateCompleted, orderNumber);
            }

        } catch (SQLException e) {
            System.out.println(e.getMessage());
        } finally {
            ConnectionManager.close(conn, stmt);
        }
        return obj;
    }

    public static List<Orders> filterOrders(String attribute, String value) {
        //These are for connection to mySQL database
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        String sql = "";
        List<Orders> results = new ArrayList<>();

        try {
            conn = ConnectionManager.getConnection();

            sql = "SELECT orderID, orderDate, orderOwner, storeCode, productFamily, orderQuantity, shippingDate, shippingMethod, orderStatus, orderComments, priority, eventID, trackingNumber, dateCompleted, orderNumber FROM " + TBLNAME + " WHERE " + attribute + " LIKE ?";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, value);
            rs = stmt.executeQuery();

            while (rs.next()) {
                //Retrieve by column name
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
                String eventID = rs.getString("eventID");
                String priority = rs.getString("priority");
                String trackingNumber = rs.getString("trackingNumber");
                Date dateCompleted = rs.getDate("dateCompleted");
                String orderNumber = rs.getString("orderNumber");

                Orders obj = new Orders(orderID, orderDate, orderOwner, storeCode, productFamily, orderQuantity, shippingDate, shippingMethod, orderStatus, orderComments, priority, eventID, trackingNumber, dateCompleted, orderNumber);
                results.add(obj);
            }

        } catch (SQLException e) {
            System.out.println(e.getMessage());
        } finally {
            ConnectionManager.close(conn, stmt, rs);

        }
        return results;
    }

    public static List<Orders> filterOrdersBetween(String attribute, String value1, String value2) {
        //These are for connection to mySQL database
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        String sql = "";
        List<Orders> results = new ArrayList<>();

        try {
            conn = ConnectionManager.getConnection();

            sql = "SELECT orderID, orderDate, orderOwner, storeCode, productFamily, orderQuantity, shippingDate, shippingMethod, orderStatus, orderComments, priority, eventID, trackingNumber, dateCompleted, orderNumber FROM " + TBLNAME + " WHERE " + attribute + " BETWEEN ? AND ?";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, value1);
            stmt.setString(2, value2);
            rs = stmt.executeQuery();

            while (rs.next()) {
                //Retrieve by column name
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
                String eventID = rs.getString("eventID");
                String priority = rs.getString("priority");
                String trackingNumber = rs.getString("trackingNumber");
                Date dateCompleted = rs.getDate("dateCompleted");
                String orderNumber = rs.getString("orderNumber");

                Orders obj = new Orders(orderID, orderDate, orderOwner, storeCode, productFamily, orderQuantity, shippingDate, shippingMethod, orderStatus, orderComments, priority, eventID, trackingNumber, dateCompleted, orderNumber);
                results.add(obj);
            }

        } catch (SQLException e) {
            System.out.println(e.getMessage());
        } finally {
            ConnectionManager.close(conn, stmt, rs);

        }
        return results;
    }

    public static List<Orders> filterOrdersBetweenDates(Date date1, Date date2) {
        //These are for connection to mySQL database
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        String sql = "";
        List<Orders> results = new ArrayList<>();

        try {
            conn = ConnectionManager.getConnection();

            sql = "SELECT orderID, orderDate, orderOwner, storeCode, productFamily, orderQuantity, shippingDate, shippingMethod, orderStatus, orderComments, priority, eventID, trackingNumber, dateCompleted, orderNumber FROM " + TBLNAME + " WHERE shippingDate >= ? AND orderDate <= ?";
            stmt = conn.prepareStatement(sql);
            stmt.setDate(1, date1);
            stmt.setDate(2, date2);
            rs = stmt.executeQuery();

            while (rs.next()) {
                //Retrieve by column name
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
                String eventID = rs.getString("eventID");
                String priority = rs.getString("priority");
                String trackingNumber = rs.getString("trackingNumber");
                Date dateCompleted = rs.getDate("dateCompleted");
                String orderNumber = rs.getString("orderNumber");

                Orders obj = new Orders(orderID, orderDate, orderOwner, storeCode, productFamily, orderQuantity, shippingDate, shippingMethod, orderStatus, orderComments, priority, eventID, trackingNumber, dateCompleted, orderNumber);
                results.add(obj);
            }

        } catch (SQLException e) {
            System.out.println(e.getMessage());
        } finally {
            ConnectionManager.close(conn, stmt, rs);

        }
        return results;
    }

    public static String createOrderID() {
        List<Orders> results = retrieveOrders();
        List<Integer> OrdersID = new ArrayList<>();
        for (Orders order : results) {
            String s = order.getOrderID();
            if (s.matches("O\\d*(\\d)?")) {
                Integer i = Integer.parseInt(s.substring(1));
                OrdersID.add(i);
            }
        }
        Integer min = 1;
        Integer found = 0;
        while (found == 0) {
            if (OrdersID.contains(min)) {
                min = min + 1;
            } else {
                found = 1;
            }
        }
        return ("O" + String.valueOf(min));
    }

    public static Date least(Date a, Date b) {
        return a == null ? b : (b == null ? a : (a.before(b) ? a : b));
    }

    public static String stringOrdersforCalendar(List<Orders> results) {
        String finalString = "[";
        if (!results.isEmpty()) {
            for (Orders order : results) {
                finalString += "{title: '" + order.getOrderID() + "', ";
                Date date = order.getOrderDate();
                finalString += "start: new Date(" + String.valueOf(1900 + date.getYear()) + ", " + String.valueOf(date.getMonth()) + ", " + String.valueOf(date.getDate()) + "), ";
                Date date2 = order.getShippingDate();
                Date date3 = order.getDateCompleted();
                if (least(date2, date3) == date3) {
                    date2 = date3;
                }
                finalString += "end: new Date(" + String.valueOf(1900 + date2.getYear()) + ", " + String.valueOf(date2.getMonth()) + ", " + String.valueOf(date2.getDate()) + "), ";
                finalString += "id: '" + order.getEventID() + "',";
                finalString += "backgroundColor: 'orange',";
                finalString += "allDay: true}, ";
            }
            finalString = finalString.substring(0, finalString.length() - 2);
            finalString += "]";
            return finalString;
        } else {
            finalString += "]";
            return finalString;
        }
    }

    protected static ArrayList<String[]> ReadManualDataLog(String fileName) {
        ArrayList<String[]> manualDataLog = new ArrayList<String[]>();
        Path pathToFile = Paths.get(fileName);

        try (BufferedReader br = Files.newBufferedReader(pathToFile, StandardCharsets.US_ASCII)) {

            String line = br.readLine();
            line = br.readLine();
            while (line != null) {

                String[] attributes = line.split(",");
                System.out.println(attributes[1]);
                String orderID = OrdersDAO.createOrderID();
                
                String orderOwner = attributes[8];
                String storeCode = attributes[0];
                String productFamily = attributes[1];
                int orderQuantity = Integer.parseInt(attributes[3]);
                
                //Get Shippingdate
                String[] ddMMYYYY_shippingDate = attributes[4].split("-");
                String[] ddMMYYYY_orderDate = attributes[7].split("-");
                String[] ddMMYYYY_endDate = attributes[10].split("-");
                SimpleDateFormat format = new SimpleDateFormat("yyyyMMdd");
                java.util.Date parsed_shipping = null;
                java.util.Date parsed_order = null;
                java.util.Date parsed_endDate = null;
                
                try{
                    parsed_shipping = format.parse(ddMMYYYY_shippingDate[0] + ddMMYYYY_shippingDate[1] + ddMMYYYY_shippingDate[2]);
                    parsed_order = format.parse(ddMMYYYY_orderDate[0] + ddMMYYYY_orderDate[1] + ddMMYYYY_orderDate[2]);
                    parsed_endDate = format.parse(ddMMYYYY_endDate[0] + ddMMYYYY_endDate[1] + ddMMYYYY_endDate[2]);
                }catch(Exception e){
                    
                }
                
               java.sql.Date shippingDate = new java.sql.Date(parsed_shipping.getTime());
               java.sql.Date orderDate = new java.sql.Date(parsed_shipping.getTime());
               java.sql.Date endDate = new java.sql.Date(parsed_shipping.getTime());
               
               String shippingMethod = attributes[5];
               String orderStatus = "100";
               String orderComment = attributes[6];
               String orderPriority = "High";
               String eventID = "None";
               String trackingNumber = attributes[9];
               String orderNumber = attributes[2];
                
               Orders newOrder = new Orders(orderID, orderDate, orderOwner, storeCode, productFamily, orderQuantity, shippingDate, shippingMethod, orderStatus, orderComment, orderPriority, eventID, trackingNumber, endDate, orderNumber);
               OrdersDAO.insertOrders(newOrder);
               manualDataLog.add(attributes);
               line = br.readLine();
               
            }

        } catch (IOException ioe) {
            ioe.printStackTrace();
        }
        return manualDataLog;
    }
    
    public static String stringOrdersforTemplate(List<Orders> results) {
        String finalString = "[";
        if (!results.isEmpty()) {
            for (Orders order : results) {
                finalString += "{number: '" + order.getOrderNumber() + "', ";
                finalString += "owner: '" + order.getOrderOwner() + "', ";
                finalString += "storeCode: '" + order.getStoreCode() + "', ";
                finalString += "productFamily: '" + order.getProductFamily() + "', ";
                finalString += "quantity: '" + String.valueOf(order.getOrderQuantity()) + "', ";
                finalString += "priority: '" + order.getPriority() + "', ";
                finalString += "shippingMethod: '" + order.getShippingMethod() + "', ";
                finalString += "comments: '" + order.getOrderComments() + "', ";
                Date date = order.getShippingDate();
                String Month = String.valueOf(date.getMonth()+ 1);
                if (Month.length() == 1) {
                    Month = "0" + Month;
                }
                String Date = String.valueOf(date.getDate());
                if (Date.length() == 1) {
                    Date = "0" + Date;
                }
                finalString += "shippingDate: '" + String.valueOf(1900 + date.getYear()) + "-" + Month + "-" + Date + "', ";
                finalString += "id: '" + order.getOrderID() + "', ";
                finalString += "allDay: true}, ";
            }
            finalString = finalString.substring(0, finalString.length() - 2);
            finalString += "]";
            return finalString;
        } else {
            finalString += "]";
            return finalString.replace("\n", "");
        }
    }
    
}
