package dao;

/**
 *
 * @author HP
 */
import connection.ConnectionManager;
import entity.EventsLog;
import java.sql.Connection;
import java.sql.Date;
import java.sql.Timestamp;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class EventsLogDAO {

    //initiate table name
    private static final String TBLNAME = "eventsLog";

    public static void insertEventsLog(EventsLog eventLog) {
        
        String eventLogID = eventLog.getEventLogID();
        String eventID = eventLog.getEventID();
        String eventName = eventLog.getEventName();
        Date eventDate = eventLog.getEventDate();
        String eventOwner = eventLog.getEventOwner();
        String priority = eventLog.getPriority();
        String eventProcessStatus = eventLog.getEventProcessStatus();
        String eventLocation = eventLog.getEventLocation();
        Date eventDeadline = eventLog.getEventDeadline();
        String comments = eventLog.getComments();
        String actionType = eventLog.getActionType();
        String userType = eventLog.getUserType();
        String username = eventLog.getUsername();
        Timestamp timestamp = eventLog.getTimestamp();

    
        try {
            Connection conn = ConnectionManager.getConnection();
            PreparedStatement ps;
            String insertEventLog = "insert into eventsLog(eventLogID, eventID, eventName, eventDate, eventOwner, eventPriority, eventDeadline, eventProcessStatus, eventLocation, comments, actionType, userType, username, timestamp) Values(?,?,?,?,?,?,?,?,?,?,?,?,?,?);";
            ps = conn.prepareStatement(insertEventLog);
            ps.setString(1, eventLogID);
            ps.setString(2,eventID);
            ps.setString(3, eventName);
            ps.setDate(4, eventDate);
            ps.setString(5, eventOwner);
            ps.setString(6, priority);
            ps.setDate(7, eventDeadline);
            ps.setString(8, eventProcessStatus);
            ps.setString(9, eventLocation);
            ps.setString(10, comments);
            ps.setString(11, actionType);
            ps.setString(12, userType);
            ps.setString(13, username);
            ps.setTimestamp(14, timestamp);
            ps.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
    }
    
    public static List<EventsLog> retrieveEventsLog() {
        //These are for connection to mySQL database
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        String sql = "";
        List<EventsLog> results = new ArrayList<>();

        try {
            conn = ConnectionManager.getConnection();

            sql = "SELECT eventLogID, eventID, eventName, eventDate, eventOwner, eventPriority, eventDeadline, eventProcessStatus, eventLocation, comments, actionType, userType, username, timestamp FROM " + TBLNAME;
            stmt = conn.prepareStatement(sql);

            rs = stmt.executeQuery();

            while (rs.next()) {
                //Retrieve by column name
                String eventLogID = rs.getString("eventLogID");
                String eventID = rs.getString("eventID");
                String eventName = rs.getString("eventName");
                Date eventDate = rs.getDate("eventDate");
                String eventOwner = rs.getString("eventOwner");
                String eventPriority = rs.getString("eventPriority");
                Date eventDeadline = rs.getDate("eventDeadline");
                String eventProcessStatus = rs.getString("eventProcessStatus");
                String eventLocation = rs.getString("eventLocation");
                String comments = rs.getString("comments");
                String actionType = rs.getString("actionType");
                String userType = rs.getString("userType");
                String username = rs.getString("username");
                Timestamp timestamp = rs.getTimestamp("timestamp");

                EventsLog obj = new EventsLog(eventLogID, eventID, eventName, eventDate, eventOwner, eventPriority, eventDeadline, eventProcessStatus, eventLocation, comments, actionType, userType, username, timestamp);
                results.add(obj);
            }

        } catch (SQLException e) {
            System.out.println(e.getMessage());
        } finally {
            ConnectionManager.close(conn, stmt, rs);
        }
        return results;
    }

    public static EventsLog searchEventsLog(String searchText) {
        Connection conn = null;
        PreparedStatement stmt = null;
        String sql = "";
        ResultSet rs = null;
        EventsLog obj = null;
        try {
            conn = ConnectionManager.getConnection();

            sql = "SELECT eventLogID, eventID, eventName, eventDate, eventOwner, eventPriority, eventDeadline, eventProcessStatus, eventLocation, comments, actionType, userType, username, timestamp FROM " + TBLNAME + " WHERE eventLogID LIKE ?";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, "%" + searchText + "%");
            System.out.println(sql);
            rs = stmt.executeQuery();
            while (rs.next()) {
                //Retrieve by column name
                String eventLogID = rs.getString("eventLogID");
                String eventID = rs.getString("eventID");
                String eventName = rs.getString("eventName");
                Date eventDate = rs.getDate("eventDate");
                String eventOwner = rs.getString("eventOwner");
                String eventPriority = rs.getString("eventPriority");
                Date eventDeadline = rs.getDate("eventDeadline");
                String eventProcessStatus = rs.getString("eventProcessStatus");
                String eventLocation = rs.getString("eventLocation");
                String comments = rs.getString("comments");
                String actionType = rs.getString("actionType");
                String userType = rs.getString("userType");
                String username = rs.getString("username");
                Timestamp timestamp = rs.getTimestamp("timestamp");

                obj = new EventsLog(eventLogID, eventID, eventName, eventDate, eventOwner, eventPriority, eventDeadline, eventProcessStatus, eventLocation, comments, actionType, userType, username, timestamp);
            }

        } catch (SQLException e) {
            System.out.println(e.getMessage());
        } finally {
            ConnectionManager.close(conn, stmt);
        }
        return obj;
    }

    //Return number of Events
    public static int numberOfEventsLog() {
        List<EventsLog> listOfEvents = retrieveEventsLog();
        if (listOfEvents != null) {
            return listOfEvents.size();
        } else {
            return 0;
        }
    }

    public static List<EventsLog> filterEventsLog(String attribute, String value) {
        Connection conn = null;
        PreparedStatement stmt = null;
        String sql = "";
        ResultSet rs = null;
        EventsLog obj = null;
        List<EventsLog> results = new ArrayList<>();

        try {
            conn = ConnectionManager.getConnection();

            sql = "SELECT eventLogID, eventID, eventName, eventDate, eventOwner, eventPriority, eventDeadline, eventProcessStatus, eventLocation, comments, actionType, userType, username, timestamp FROM " + TBLNAME + " WHERE " + attribute + " LIKE ?";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, value);
            rs = stmt.executeQuery();
            while (rs.next()) {
                //Retrieve by column name
                String eventLogID = rs.getString("eventLogID");
                String eventID = rs.getString("eventID");
                String eventName = rs.getString("eventName");
                Date eventDate = rs.getDate("eventDate");
                String eventOwner = rs.getString("eventOwner");
                String eventPriority = rs.getString("eventPriority");
                Date eventDeadline = rs.getDate("eventDeadline");
                String eventProcessStatus = rs.getString("eventProcessStatus");
                String eventLocation = rs.getString("eventLocation");
                String comments = rs.getString("comments");
                String actionType = rs.getString("actionType");
                String userType = rs.getString("userType");
                String username = rs.getString("username");
                Timestamp timestamp = rs.getTimestamp("timestamp");

                obj = new EventsLog(eventLogID, eventID, eventName, eventDate, eventOwner, eventPriority, eventDeadline, eventProcessStatus, eventLocation, comments, actionType, userType, username, timestamp);
                results.add(obj);
            }

        } catch (SQLException e) {
            System.out.println(e.getMessage());
        } finally {
            ConnectionManager.close(conn, stmt);
        }
        return results;
    }

    public static String createEventLogID() {
        List<EventsLog> results = retrieveEventsLog();
        List<Integer> EventsLogID = new ArrayList<>();
        for (EventsLog eventLog : results) {
            String s = eventLog.getEventLogID();
            if (s.matches("EL\\d*(\\d)?")) {
                Integer i = Integer.parseInt(s.substring(2));
                EventsLogID.add(i);
            }
        }
        Integer min = 1;
        Integer found = 0;
        while (found == 0) {
            if (EventsLogID.contains(min)) {
                min = min + 1;
            } else {
                found = 1;
            }
        }
        return ("EL" + String.valueOf(min));
    }
    
}

