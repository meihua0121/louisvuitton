/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import connection.ConnectionManager;
import entity.User;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Hashtable;
import java.util.Set;

//import java.util.ArrayList;
/**
 *
 * @author HP
 */
public class LoginDAO {

    //initiate table name
    private static final String TBLNAME = "user";

    public static void newLoginDAO() {
    }

    public static Hashtable<String, User> retrieveUsers() {

        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        String sql = "";
        Hashtable<String, User> accounts_dict = new Hashtable();
        try {
            conn = ConnectionManager.getConnection();

            sql = "SELECT * FROM " + TBLNAME;
            stmt = conn.prepareStatement(sql);

            rs = stmt.executeQuery();

            while (rs.next()) {
                //Retrieve by column name
                String email = rs.getString("email");
                String userName = rs.getString("userName");
                String password = rs.getString("password");
                String phoneNumber = rs.getString("phoneNumber");
                String userType = rs.getString("userType");
                String fileName = rs.getString("fileName");

                User myUser = new User(email, userName, password, phoneNumber, userType, fileName);
                accounts_dict.put(email, myUser);
            }

        } catch (SQLException e) {
            System.out.println(e.getMessage());
        } finally {
            ConnectionManager.close(conn, stmt, rs);

        }
        return accounts_dict;
    }

    public static boolean addUser(User user) {

        Connection conn = null;
        Statement stmt = null;

        try {

            conn = ConnectionManager.getConnection();
            //prepare sql
            String email = user.getEmail();
            String username = user.getUserName();
            String password = user.getPassword();
            String phonenumber = user.getPassword();
            String userType = user.getType();
            String filename = user.getFileName();

            PreparedStatement ps;
            String insertUser = "insert into " + TBLNAME + "(email, userName, password, phoneNumber, userType, fileName) Values(?,?,?,?,?,?);";

            ps = conn.prepareStatement(insertUser);
            ps.setString(1, email);
            ps.setString(2, username);
            ps.setString(3, password);
            ps.setString(4, phonenumber);
            ps.setString(5, userType);
            ps.setString(6, filename);
            ps.executeUpdate();

            return true;

        } catch (SQLException e) {
            System.out.println(e.getMessage());
            return false;
        } finally {
            ConnectionManager.close(conn, stmt);
        }
    }

    public static boolean authUser(String email, String password) {

        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            conn = ConnectionManager.getConnection();

            String sql = "SELECT * FROM " + TBLNAME + " WHERE email = ? AND password= ? ";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, email);
            stmt.setString(2, password);
            rs = stmt.executeQuery();

            if (rs.next()) {
                return true;
            } else {
                return false;
            }

        } catch (SQLException e) {
            System.out.println(e.getMessage());
        } finally {
            ConnectionManager.close(conn, stmt, rs);
        }
        return false;
    }

    public static void delUser(String email) {

        Connection conn = null;
        PreparedStatement stmt = null;

        try {
            conn = ConnectionManager.getConnection();

            String sql = "DELETE FROM " + TBLNAME + " WHERE email = ? ";

            stmt = conn.prepareStatement(sql);
            stmt.setString(1, email);
            stmt.executeUpdate();

        } catch (SQLException e) {
            System.out.println(e.getMessage());
        } finally {
            ConnectionManager.close(conn, stmt);

        }

    }

    public User searchUser(String email) {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        User theUser = null;
        try {
            conn = ConnectionManager.getConnection();

            String sql = "SELECT * FROM " + TBLNAME + " WHERE email = ?";

            stmt = conn.prepareStatement(sql);
            stmt.setString(1, email);
            rs = stmt.executeQuery();

            if (rs.next()) {
                String username = rs.getString("username");
                String phonenumber = rs.getString("phoneNumber");
                String userType = rs.getString("userType");
                String fileName = rs.getString("fileName");
                String password = rs.getString("password");

                theUser = new User(email, username, password, phonenumber, userType, fileName);
            }
            return theUser;

        } catch (SQLException e) {
            System.out.println(e.getMessage());
            return theUser;
        } finally {
            ConnectionManager.close(conn, stmt);
        }
    }
    
    public static void updateUser(User user) {
        Connection conn = null;
        PreparedStatement stmt = null;
        String sql = "";
        try {
            conn = ConnectionManager.getConnection();

            sql = "UPDATE " + TBLNAME + " set email=?, username=?, password=?, phoneNumber=?, userType=?, fileName=? " + " where email = ? ";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, user.getEmail());
            stmt.setString(2, user.getUserName());
            stmt.setString(3, user.getPassword());
            stmt.setString(4, user.getPhoneNumber());
            stmt.setString(5, user.getType());
            stmt.setString(6, user.getFileName());
            stmt.setString(7, user.getEmail());
            stmt.executeUpdate();

        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        } finally {
            ConnectionManager.close(conn, stmt);
        }
    }

    public static ArrayList<User> returnpecifiedUserTypes(Hashtable<String, User> listOfUsers , String userType) {
        ArrayList<User> listOfSpecifiedUsers = new ArrayList<>();
        Set<String> keys = listOfUsers.keySet();
        for (String key : keys) {
            User theUser = listOfUsers.get(key);
            if(theUser.getType().equals(userType)){
                listOfSpecifiedUsers.add(theUser);
            }
        }
        return listOfSpecifiedUsers;
    }
}
