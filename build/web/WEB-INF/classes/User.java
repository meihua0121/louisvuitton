/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package entity;


import java.io.IOException;
import java.sql.SQLException;

public class User {
    private String email;
    private String userName;
    private String password;
    private String phoneNumber;
    private String type;
    private String fileName;
    
    public static void main(String[] args) throws ClassNotFoundException, SQLException, IOException {
    }
    public User(){  }
    
    public User(String email, String userName, String password, String phoneNumber, String type, String fileName){
        this.email = email;
        this.userName = userName;
        this.password = password;
        this.phoneNumber = phoneNumber;
        this.type = type;
        this.fileName = fileName;
    }
    
    public String getEmail(){
        return this.email;
    }
    public String getUserName(){
        return this.userName;
    }
    
    public String getPassword(){
        return this.password;
    }
    public String getType(){
        return this.type;
    }
    public String getPhoneNumber(){
        return this.phoneNumber;
    }
    /*
    public File getImage(){
        return this.image;
    }*/
    
    public void setUserName(String userName){
        this.userName = userName;
    }
    
    public void setPassword(String password){
        this.password = password;
    }
    
    public void setPhoneNumber(String phoneNumber){
        this.phoneNumber = phoneNumber;
    }
    public String getFileName(){
        return this.fileName;
    }
    public void setFilePath(String fileName){
        this.fileName = fileName;
    }
}
