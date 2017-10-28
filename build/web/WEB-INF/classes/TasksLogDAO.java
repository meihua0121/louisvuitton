/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import connection.ConnectionManager;
import entity.Orders;
import entity.Tasks;
import entity.TasksLog;
import entity.User;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

/**
 *
 * @author HP
 */
public class TasksLogDAO {

    //initiate table name
    private static final String TBLNAME = "tasksLog";

    public static void insertTasksLog(TasksLog taskLog) {
        
        String taskLogID = taskLog.getTaskLogID();
        String taskID = taskLog.getTaskID();
        Date taskDate = taskLog.getTaskDate();
        String taskOwner = taskLog.getTaskOwner();
        String priority = taskLog.getPriority();
        String orderID = taskLog.getOrderID();
        Date taskDeadline = taskLog.getTaskDeadline();
        String taskProcessStatus = taskLog.getTaskProcessStatus();
        String taskDescription = taskLog.getTaskDescription();
        String taskComments = taskLog.getTaskComments();
        String actionType = taskLog.getActionType();
        String userType = taskLog.getUserType();
        String username = taskLog.getUsername();
        Timestamp timestamp = taskLog.getTimestamp();
        
        try {
            Connection conn = ConnectionManager.getConnection();
            PreparedStatement ps;
            String insertTask = "insert into tasksLog(taskLogID, taskID, taskDate, taskOwner, priority, orderID, taskDeadline, taskProcessStatus, taskDescription, taskComments, actionType, userType, username, timestamp) Values(?,?,?,?,?,?,?,?,?,?,?,?,?,?);";
            ps = conn.prepareStatement(insertTask);
            ps.setString(1, taskLogID);
            ps.setString(2, taskID);
            ps.setDate(3, taskDate);
            ps.setString(4, taskOwner);
            ps.setString(5, priority);
            ps.setString(6, orderID);
            ps.setDate(7, taskDeadline);
            ps.setString(8, taskProcessStatus);
            ps.setString(9, taskDescription);
            ps.setString(10, taskComments);
            ps.setString(11, actionType);
            ps.setString(12, userType);
            ps.setString(13, username);
            ps.setTimestamp(14, timestamp);
            ps.executeUpdate();

        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
    }

    public static List<TasksLog> retrieveTasksLog() {
        //These are for connection to mySQL database
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        List<TasksLog> results = new ArrayList<>();

        try {
            conn = ConnectionManager.getConnection();

            String sql = "SELECT taskLogID, taskID, taskDate, taskOwner, priority, orderID, taskDeadline, taskProcessStatus, taskDescription, taskComments, actionType, userType, username, timestamp FROM " + TBLNAME;
            stmt = conn.prepareStatement(sql);

            rs = stmt.executeQuery();

            while (rs.next()) {
                //Retrieve by column name
                String taskLogID = rs.getString("taskLogID");
                String taskID = rs.getString("taskID");
                Date taskDate = rs.getDate("taskDate");
                String taskOwner = rs.getString("taskOwner");
                String taskPriority = rs.getString("priority");
                String orderID = rs.getString("orderID");
                Date taskDeadline = rs.getDate("taskDeadline");
                String taskProcessStatus = rs.getString("taskProcessStatus");
                String taskDescription = rs.getString("taskDescription");
                String taskComments = rs.getString("taskComments");
                String actionType = rs.getString("actionType");
                String userType = rs.getString("userType");
                String username = rs.getString("username");
                Timestamp timestamp = rs.getTimestamp("timestamp");

                TasksLog obj = new TasksLog(taskLogID, taskID, taskDate, taskOwner, taskPriority, orderID, taskDeadline, taskProcessStatus, taskDescription, taskComments, actionType, userType, username, timestamp);
                results.add(obj);
            }

        } catch (SQLException e) {
            System.out.println(e.getMessage());
        } finally {
            ConnectionManager.close(conn, stmt, rs);

        }
        return results;
    }

    public static TasksLog searchTasksLog(String searchText) {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        TasksLog obj = null;
        try {
            conn = ConnectionManager.getConnection();

            String sql = "SELECT taskLogID, taskID, taskDate, taskOwner, priority, orderID, taskDeadline, taskProcessStatus, taskDescription, taskComments, actionType, userType, username, timestamp FROM " + TBLNAME + " WHERE taskLogID LIKE ?";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, "%" + searchText + "%");
            System.out.println(sql);
            rs = stmt.executeQuery();
            while (rs.next()) {

                String taskLogID = rs.getString("taskLogID");
                String taskID = rs.getString("taskID");
                Date taskDate = rs.getDate("taskDate");
                String taskOwner = rs.getString("taskOwner");
                String taskPriority = rs.getString("priority");
                String orderID = rs.getString("orderID");
                Date taskDeadline = rs.getDate("taskDeadline");
                String taskProcessStatus = rs.getString("taskProcessStatus");
                String taskDescription = rs.getString("taskDescription");
                String taskComments = rs.getString("taskComments");
                String actionType = rs.getString("actionType");
                String userType = rs.getString("userType");
                String username = rs.getString("username");
                Timestamp timestamp = rs.getTimestamp("timestamp");

                obj = new TasksLog(taskLogID, taskID, taskDate, taskOwner, taskPriority, orderID, taskDeadline, taskProcessStatus, taskDescription, taskComments, actionType, userType, username, timestamp);
            }

        } catch (SQLException e) {
            System.out.println(e.getMessage());
        } finally {
            ConnectionManager.close(conn, stmt);
        }
        return obj;
    }
    
    public static List<TasksLog> filterTasksLog(String attribute, String value) {
        Connection conn = null;
        PreparedStatement stmt = null;
        String sql = "";
        ResultSet rs = null;
        TasksLog obj = null;
        List<TasksLog> results = new ArrayList<>();
        
        try {
            conn = ConnectionManager.getConnection();

            sql = "SELECT taskLogID, taskID, taskDate, taskOwner, priority, orderID, taskDeadline, taskProcessStatus, taskDescription, taskComments, actionType, userType, username, timestamp FROM " + TBLNAME + " WHERE " + attribute + " LIKE ?";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, value);
            rs = stmt.executeQuery();
            while (rs.next()) {
                String taskLogID = rs.getString("taskLogID");
                String taskID = rs.getString("taskID");
                Date taskDate = rs.getDate("taskDate");
                String taskOwner = rs.getString("taskOwner");
                String taskPriority = rs.getString("priority");
                String orderID = rs.getString("orderID");
                Date taskDeadline = rs.getDate("taskDeadline");
                String taskProcessStatus = rs.getString("taskProcessStatus");
                String taskDescription = rs.getString("taskDescription");
                String taskComments = rs.getString("taskComments");
                String actionType = rs.getString("actionType");
                String userType = rs.getString("userType");
                String username = rs.getString("username");
                Timestamp timestamp = rs.getTimestamp("timestamp");
                
                obj = new TasksLog(taskLogID, taskID, taskDate, taskOwner, taskPriority, orderID, taskDeadline, taskProcessStatus, taskDescription, taskComments, actionType, userType, username, timestamp);
            }

        } catch (SQLException e) {
            System.out.println(e.getMessage());
        } finally {
            ConnectionManager.close(conn, stmt);
        }
        return results;
    }
    
    public static List<TasksLog> retrieveTasksLogOfUser(String userName) {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        List<TasksLog> results = new ArrayList<>();

        try {
            conn = ConnectionManager.getConnection();

            String sql = "SELECT taskLogID, taskID, taskDate, taskOwner, priority, orderID, taskDeadline, taskProcessStatus, taskDescription, taskComments, actionType, userType, username, timestamp FROM " + TBLNAME + " WHERE username LIKE ? ";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, userName);
            rs = stmt.executeQuery();

            while (rs.next()) {
                String taskLogID = rs.getString("taskLogID");
                String taskID = rs.getString("taskID");
                Date taskDate = rs.getDate("taskDate");
                String taskOwner = rs.getString("taskOwner");
                String taskPriority = rs.getString("priority");
                String orderID = rs.getString("orderID");
                Date taskDeadline = rs.getDate("taskDeadline");
                String taskProcessStatus = rs.getString("taskProcessStatus");
                String taskDescription = rs.getString("taskDescription");
                String taskComments = rs.getString("taskComments");
                String actionType = rs.getString("actionType");
                String userType = rs.getString("userType");
                String username = rs.getString("username");
                Timestamp timestamp = rs.getTimestamp("timestamp");
                
                TasksLog obj = new TasksLog(taskLogID, taskID, taskDate, taskOwner, taskPriority, orderID, taskDeadline, taskProcessStatus, taskDescription, taskComments, actionType, userType, username, timestamp);
            }

        } catch (SQLException e) {
            System.out.println(e.getMessage());
        } finally {
            ConnectionManager.close(conn, stmt, rs);

        }
        return results;
    }
    
    public static String createTaskLogID() {
        List<TasksLog> results = retrieveTasksLog();
        List<Integer> TasksLogID = new ArrayList<>(); 
        for (TasksLog taskLog : results) {
            String s = taskLog.getTaskLogID();
            if (s.matches("TL\\d*(\\d)?")) {
                Integer i = Integer.parseInt(s.substring(2));
                TasksLogID.add(i);            
            }                
        }
        Integer min = 1;
        Integer found = 0;
        while (found == 0){
            if (TasksLogID.contains(min)) {
                min = min + 1;
            }
            else {
                found = 1;
            }
        }
        return ("TL"+String.valueOf(min));
    }
}
