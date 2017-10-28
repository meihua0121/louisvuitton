/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import connection.ConnectionManager;
import entity.Tasks;
import entity.User;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author HP
 */
public class TasksDAO {

    //initiate table name
    private static final String TBLNAME = "tasks";

    public static void insertTasks(Tasks task) {

        String taskID = task.getTaskID();
        Date taskDate = task.getTaskDate();
        String taskOwner = task.getTaskOwner();
        String priority = task.getPriority();
        //This is required because tasks is a subset of orders
        String orderID = task.getOrderID();
        Date taskDeadline = task.getTaskDeadline();
        String taskProcessStatus = task.getTaskProcessStatus();
        String taskDescription = task.getTaskDescription();
        String taskComments = task.getTaskComments();
        try {
            Connection conn = ConnectionManager.getConnection();
            PreparedStatement ps;
            String insertTask = "insert into tasks(taskID, taskDate, taskOwner, priority, orderID, taskDeadline, taskProcessStatus, taskDescription, taskComments) Values(?,?,?,?,?,?,?,?,?);";
            ps = conn.prepareStatement(insertTask);
            ps.setString(1, taskID);
            ps.setDate(2, taskDate);
            ps.setString(3, taskOwner);
            ps.setString(4, priority);
            ps.setString(5, orderID);
            ps.setDate(6, taskDeadline);
            ps.setString(7, taskProcessStatus);
            ps.setString(8, taskDescription);
            ps.setString(9, taskComments);
            ps.executeUpdate();

        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
    }

    public static void deleteTasks(String taskID) {
        Connection conn = null;
        PreparedStatement stmt = null;
        try {
            conn = ConnectionManager.getConnection();

            String sql = "DELETE FROM " + TBLNAME + " where taskID = ? ";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, taskID);
            stmt.executeUpdate();

        } catch (SQLException e) {
            System.out.println(e.getMessage());
        } finally {
            ConnectionManager.close(conn, stmt);
        }
    }

    public static void updateTasks(Tasks task) {
        Connection conn = null;
        PreparedStatement stmt = null;
        try {
            conn = ConnectionManager.getConnection();

            String sql = "UPDATE " + TBLNAME + " set taskID=?, taskDate=?, taskOwner=?, priority=?, orderID=?, taskDeadline=?, taskProcessStatus=?, taskDescription=?, taskComments=? " + " where taskID = ? ";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, task.getTaskID());
            stmt.setDate(2, task.getTaskDate());
            stmt.setString(3, task.getTaskOwner());
            stmt.setString(4, task.getPriority());
            stmt.setString(5, task.getOrderID());
            stmt.setDate(6, task.getTaskDeadline());
            stmt.setString(7, task.getTaskProcessStatus());
            stmt.setString(8, task.getTaskDescription());
            stmt.setString(9, task.getTaskComments());
            stmt.setString(10, task.getTaskID());
            stmt.executeUpdate();

        } catch (SQLException ex) {
            //
            System.out.println(ex.getMessage());
        } finally {
            ConnectionManager.close(conn, stmt);
        }
    }

    public static List<Tasks> retrieveTasks() {
        //These are for connection to mySQL database
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        List<Tasks> results = new ArrayList<>();

        try {
            conn = ConnectionManager.getConnection();

            String sql = "SELECT taskID, taskDate, taskOwner, priority, orderID, taskDeadline, taskProcessStatus, taskDescription, taskComments FROM " + TBLNAME;
            stmt = conn.prepareStatement(sql);

            rs = stmt.executeQuery();

            while (rs.next()) {
                //Retrieve by column name
                String taskID = rs.getString("taskID");
                Date taskDate = rs.getDate("taskDate");
                String taskOwner = rs.getString("taskOwner");
                String taskPriority = rs.getString("priority");
                String orderID = rs.getString("orderID");
                Date taskDeadline = rs.getDate("taskDeadline");
                String taskProcessStatus = rs.getString("taskProcessStatus");
                String taskDescription = rs.getString("taskDescription");
                String taskComments = rs.getString("taskComments");

                Tasks obj = new Tasks(taskID, taskDate, taskOwner, taskPriority, orderID, taskDeadline, taskProcessStatus, taskDescription, taskComments);
                results.add(obj);
            }

        } catch (SQLException e) {
            System.out.println(e.getMessage());
        } finally {
            ConnectionManager.close(conn, stmt, rs);

        }
        return results;
    }

    public static Tasks searchTasks(String searchText) {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        Tasks obj = null;
        try {
            conn = ConnectionManager.getConnection();

            String sql = "SELECT taskID, taskDate, taskOwner, priority, orderID, taskDeadline, taskProcessStatus, taskDescription, taskComments FROM " + TBLNAME + " WHERE taskID LIKE ?";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, "%" + searchText + "%");
            System.out.println(sql);
            rs = stmt.executeQuery();
            while (rs.next()) {

                String taskID = rs.getString("taskID");
                Date taskDate = rs.getDate("taskDate");
                String taskOwner = rs.getString("taskOwner");
                String taskPriority = rs.getString("priority");
                String orderID = rs.getString("orderID");
                Date taskDeadline = rs.getDate("taskDeadline");
                String taskProcessStatus = rs.getString("taskProcessStatus");
                String taskDescription = rs.getString("taskDescription");
                String taskComments = rs.getString("taskComments");

                obj = new Tasks(taskID, taskDate, taskOwner, taskPriority, orderID, taskDeadline, taskProcessStatus, taskDescription, taskComments);

            }

        } catch (SQLException e) {
            System.out.println(e.getMessage());
        } finally {
            ConnectionManager.close(conn, stmt);
        }
        return obj;
    }
    
    public static List<Tasks> filterTasks(String attribute, String value) {
        Connection conn = null;
        PreparedStatement stmt = null;
        String sql = "";
        ResultSet rs = null;
        Tasks obj = null;
        List<Tasks> results = new ArrayList<>();
        
        try {
            conn = ConnectionManager.getConnection();

            sql = "SELECT taskID, taskDate, taskOwner, priority, orderID, taskDeadline, taskProcessStatus, taskDescription, taskComments FROM " + TBLNAME + " WHERE " + attribute + " LIKE ?";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, value);
            rs = stmt.executeQuery();
            while (rs.next()) {

                String taskID = rs.getString("taskID");
                Date taskDate = rs.getDate("taskDate");
                String taskOwner = rs.getString("taskOwner");
                String priority = rs.getString("priority");
                String orderID = rs.getString("orderID");
                Date taskDeadline = rs.getDate("taskDeadline");
                String taskProcessStatus = rs.getString("taskProcessStatus");
                String taskDescription = rs.getString("taskDescription");
                String taskComments = rs.getString("taskComments");

                obj = new Tasks(taskID, taskDate, taskOwner, priority, orderID, taskDeadline, taskProcessStatus, taskDescription, taskComments);
                results.add(obj);
            }

        } catch (SQLException e) {
            System.out.println(e.getMessage());
        } finally {
            ConnectionManager.close(conn, stmt);
        }
        return results;
    }
    
    public static List<Tasks> retrieveTasksOfUser(String userEmail) {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        List<Tasks> results = new ArrayList<>();

        try {
            conn = ConnectionManager.getConnection();

            String sql = "SELECT taskID, taskDate, taskOwner, priority, orderID, taskDeadline, taskProcessStatus, taskDescription, taskComments FROM " + TBLNAME + " WHERE taskOwner LIKE ? ";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, userEmail);
            rs = stmt.executeQuery();

            while (rs.next()) {
                //Retrieve by column name
                String taskID = rs.getString("taskID");
                Date taskDate = rs.getDate("taskDate");
                String taskOwner = rs.getString("taskOwner");
                String taskPriority = rs.getString("priority");
                String orderID = rs.getString("orderID");
                Date taskDeadline = rs.getDate("taskDeadline");
                String taskProcessStatus = rs.getString("taskProcessStatus");
                String taskDescription = rs.getString("taskDescription");
                String taskComments = rs.getString("taskComments");

                Tasks obj = new Tasks(taskID, taskDate, taskOwner, taskPriority, orderID, taskDeadline, taskProcessStatus, taskDescription, taskComments);
                results.add(obj);
            }

        } catch (SQLException e) {
            System.out.println(e.getMessage());
        } finally {
            ConnectionManager.close(conn, stmt, rs);

        }
        return results;
    }
    
    public static String createTaskID() {
        List<Tasks> results = retrieveTasks();
        List<Integer> TasksID = new ArrayList<>(); 
        for (Tasks task : results) {
            String s = task.getTaskID();
            if (s.matches("T\\d*(\\d)?")) {
                Integer i = Integer.parseInt(s.substring(1));
                TasksID.add(i);            
            }                
        }
        Integer min = 1;
        Integer found = 0;
        while (found == 0){
            if (TasksID.contains(min)) {
                min = min + 1;
            }
            else {
                found = 1;
            }
        }
        return ("T"+String.valueOf(min));
    }
       
    public static String stringTasksforCalendar(List<Tasks> results) {
        String finalString = "[";
        if (!results.isEmpty()) {
            for (Tasks task : results) {
                finalString += "{title: '" + task.getTaskDescription()+"', ";
                Date date = task.getTaskDate();
                finalString += "start: new Date(" + String.valueOf(1900+date.getYear())+", " + String.valueOf(date.getMonth())+", "+ String.valueOf(date.getDate())+"), ";
                Date date2 = task.getTaskDeadline();
                finalString += "end: new Date(" + String.valueOf(1900+date2.getYear())+", " + String.valueOf(date2.getMonth())+", "+ String.valueOf(date2.getDate())+"), ";
                finalString += "id: '" + task.getOrderID()+"',";
                finalString += "className: '" + task.getTaskOwner() + "',";
                finalString += "allDay: true}, ";
            }
            finalString = finalString.substring(0, finalString.length()- 2);
            finalString += "]";
            return finalString;
        }
        else {
            finalString += "]";
            return finalString;
        }
    }
}
