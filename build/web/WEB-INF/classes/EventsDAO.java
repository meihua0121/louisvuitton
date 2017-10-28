package dao;

/**
 *
 * @author HP
 */
import connection.ConnectionManager;
import entity.Events;
import entity.User;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.JSONValue;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class EventsDAO {

    //initiate table name
    private static final String TBLNAME = "event";

    public static void insertEvents(Events event) {

        String eventID = event.getEventID();
        String eventName = event.getEventName();
        Date eventDate = event.getEventDate();
        String eventOwner = event.getEventOwner();
        String priority = event.getPriority();
        //This is required because orders is a subset of tasks
        Date eventDeadline = event.getEventDeadline();
        String eventProcessStatus = event.getEventProcessStatus();
        String eventLocation = event.getEventLocation();
        String comments = event.getComments();

        try {
            Connection conn = ConnectionManager.getConnection();
            PreparedStatement ps;
            String insertEvent = "insert into event(eventID, eventName, eventDate, eventOwner, eventPriority, eventDeadline, eventProcessStatus,eventLocation,comments) Values(?,?,?,?,?,?,?,?,?);";
            ps = conn.prepareStatement(insertEvent);
            ps.setString(1, eventID);
            ps.setString(2, eventName);
            ps.setDate(3, eventDate);
            ps.setString(4, eventOwner);
            ps.setString(5, priority);
            ps.setDate(6, eventDeadline);
            ps.setString(7, eventProcessStatus);
            ps.setString(8, eventLocation);
            ps.setString(9, comments);
            ps.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
    }

    public static void deleteEvents(String eventID) {
        Connection conn = null;
        PreparedStatement stmt = null;
        String sql = "";
        try {
            conn = ConnectionManager.getConnection();

            sql = "DELETE FROM " + TBLNAME + " where eventID = ? ";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, eventID);
            stmt.executeUpdate();

        } catch (SQLException e) {
            System.out.println(e.getMessage());
        } finally {
            ConnectionManager.close(conn, stmt);
        }
    }

    public static void updateEvents(Events event) {
        Connection conn = null;
        PreparedStatement stmt = null;
        String sql = "";
        try {
            conn = ConnectionManager.getConnection();

            sql = "UPDATE " + TBLNAME + " SET eventID=?, eventName=?, eventDate=?, eventOwner=?, eventPriority=?, eventDeadline=?, eventProcessStatus=?, eventLocation=?, comments=? " + " where eventID= ? ";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, event.getEventID());
            stmt.setString(2, event.getEventName());
            stmt.setDate(3, event.getEventDate());
            stmt.setString(4, event.getEventOwner());
            stmt.setString(5, event.getPriority());
            stmt.setDate(6, event.getEventDeadline());
            stmt.setString(7, event.getEventProcessStatus());
            stmt.setString(8, event.getEventLocation());
            stmt.setString(9, event.getComments());
            stmt.setString(10, event.getEventID());
            stmt.executeUpdate();

        } catch (SQLException ex) {
            //
        } finally {
            ConnectionManager.close(conn, stmt);
        }
    }

    public static List<Events> retrieveEvents() {
        //These are for connection to mySQL database
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        String sql = "";
        List<Events> results = new ArrayList<>();

        try {
            conn = ConnectionManager.getConnection();

            sql = "SELECT eventID, eventName, eventDate, eventOwner, eventPriority, eventDeadline, eventProcessStatus, eventLocation, comments FROM " + TBLNAME;
            stmt = conn.prepareStatement(sql);

            rs = stmt.executeQuery();

            while (rs.next()) {
                //Retrieve by column name
                String eventID = rs.getString("eventID");
                String eventName = rs.getString("eventName");
                Date eventDate = rs.getDate("eventDate");
                String eventOwner = rs.getString("eventOwner");
                String eventPriority = rs.getString("eventPriority");
                Date eventDeadline = rs.getDate("eventDeadline");
                String eventProcessStatus = rs.getString("eventProcessStatus");
                String eventLocation = rs.getString("eventLocation");
                String comments = rs.getString("comments");

                Events obj = new Events(eventID, eventName, eventDate, eventOwner, eventPriority, eventDeadline, eventProcessStatus, eventLocation, comments);
                results.add(obj);
            }

        } catch (SQLException e) {
            System.out.println(e.getMessage());
        } finally {
            ConnectionManager.close(conn, stmt, rs);

        }
        return results;
    }

    public static Events searchEvents(String searchText) {
        Connection conn = null;
        PreparedStatement stmt = null;
        String sql = "";
        ResultSet rs = null;
        Events obj = null;
        try {
            conn = ConnectionManager.getConnection();

            sql = "SELECT eventID, eventName, eventDate, eventOwner, eventPriority, eventDeadline, eventProcessStatus, eventLocation, comments FROM " + TBLNAME + " WHERE eventID LIKE ?";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, "%" + searchText + "%");
            System.out.println(sql);
            rs = stmt.executeQuery();
            while (rs.next()) {

                String eventID = rs.getString("eventID");
                String eventName = rs.getString("eventName");
                Date eventDate = rs.getDate("eventDate");
                String eventOwner = rs.getString("eventOwner");
                String eventPriority = rs.getString("eventPriority");
                Date eventDeadline = rs.getDate("eventDeadline");
                String eventProcessStatus = rs.getString("eventProcessStatus");
                String eventLocation = rs.getString("eventLocation");
                String comments = rs.getString("comments");

                obj = new Events(eventID, eventName, eventDate, eventOwner, eventPriority, eventDeadline, eventProcessStatus, eventLocation, comments);
            }

        } catch (SQLException e) {
            System.out.println(e.getMessage());
        } finally {
            ConnectionManager.close(conn, stmt);
        }
        return obj;
    }

    //Return number of Events
    public static int numberOfEvents() {
        List<Events> listOfEvents = retrieveEvents();
        if (listOfEvents != null) {
            return listOfEvents.size();
        } else {
            return 0;
        }
    }

    public static List<Events> filterEvents(String attribute, String value) {
        Connection conn = null;
        PreparedStatement stmt = null;
        String sql = "";
        ResultSet rs = null;
        Events obj = null;
        List<Events> results = new ArrayList<>();

        try {
            conn = ConnectionManager.getConnection();

            sql = "SELECT eventID, eventName, eventDate, eventOwner, eventPriority, eventDeadline, eventProcessStatus, eventLocation, comments FROM " + TBLNAME + " WHERE " + attribute + " LIKE ?";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, value);
            rs = stmt.executeQuery();
            while (rs.next()) {

                String eventID = rs.getString("eventID");
                String eventName = rs.getString("eventName");
                Date eventDate = rs.getDate("eventDate");
                String eventOwner = rs.getString("eventOwner");
                String eventPriority = rs.getString("eventPriority");
                Date eventDeadline = rs.getDate("eventDeadline");
                String eventProcessStatus = rs.getString("eventProcessStatus");
                String eventLocation = rs.getString("eventLocation");
                String comments = rs.getString("comments");

                obj = new Events(eventID, eventName, eventDate, eventOwner, eventPriority, eventDeadline, eventProcessStatus, eventLocation, comments);
                results.add(obj);
            }

        } catch (SQLException e) {
            System.out.println(e.getMessage());
        } finally {
            ConnectionManager.close(conn, stmt);
        }
        return results;
    }

    public static String createEventID() {
        List<Events> results = retrieveEvents();
        List<Integer> EventsID = new ArrayList<>();
        for (Events event : results) {
            String s = event.getEventID();
            if (s.matches("E\\d*(\\d)?")) {
                Integer i = Integer.parseInt(s.substring(1));
                EventsID.add(i);
            }
        }
        Integer min = 1;
        Integer found = 0;
        while (found == 0) {
            if (EventsID.contains(min)) {
                min = min + 1;
            } else {
                found = 1;
            }
        }
        return ("E" + String.valueOf(min));
    }

    public static String stringEventsforCalendar(List<Events> results) {
        String finalString = "[";
        if (!results.isEmpty()) {
            for (Events event : results) {
                finalString += "{title: ' " + event.getEventName() + "', ";
                Date date = event.getEventDate();
                finalString += "start: new Date(" + String.valueOf(1900 + date.getYear()) + ", " + String.valueOf(date.getMonth()) + ", " + String.valueOf(date.getDate()) + "), ";
                Date date2 = event.getEventDeadline();
                finalString += "end: new Date(" + String.valueOf(1900 + date2.getYear()) + ", " + String.valueOf(date2.getMonth()) + ", " + String.valueOf(date2.getDate()) + "), ";
                finalString += "id: '" + event.getEventID() + "', ";
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

    public static JSONArray jsonTry() {
        JSONObject eventJSON = new JSONObject();
        eventJSON.put("title", "eee");
        eventJSON.put("start", new Date(117, 1, 6));
        eventJSON.put("end", new Date(117, 1, 10));
        eventJSON.put("allday", true);
        JSONArray ja = new JSONArray();
        ja.add(eventJSON);
        return (ja);
    }
    
    
    public static String stringEventsforTemplate(List<Events> results) {
        String finalString = "[";
        if (!results.isEmpty()) {
            for (Events event : results) {
                finalString += "{name: '" + event.getEventName() + "', ";
                finalString += "owner: '" + event.getEventOwner() + "', ";
                finalString += "priority: '" + event.getPriority() + "', ";
                finalString += "location: '" + event.getEventLocation() + "', ";
                finalString += "comments: '" + event.getComments() + "', ";
                Date date = event.getEventDate();
                finalString += "start: new Date(" + String.valueOf(1900 + date.getYear()) + ", " + String.valueOf(date.getMonth()) + ", " + String.valueOf(date.getDate()) + "), ";
                Date date2 = event.getEventDeadline();
                finalString += "end: new Date(" + String.valueOf(1900 + date2.getYear()) + ", " + String.valueOf(date2.getMonth()) + ", " + String.valueOf(date2.getDate()) + "), ";
                finalString += "id: '" + event.getEventID() + "', ";
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
}
