/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package entity;

import java.sql.Date;

/**
 *
 * @author Quentin the Frenchy
 */
public class Tasks {

    private String taskID;
    private Date taskDate;
    private String taskOwner;
    private String priority;
    //This is required because tasks are a subset of orders
    private String orderID;
    private Date taskDeadline;
    private String taskProcessStatus;
    private String taskDescription;
    private String taskComments;

    public Tasks(String taskID, Date taskDate, String taskOwner, String priority, String orderID, Date taskDeadline, String taskProcessStatus, String taskDescription, String taskComments) {
        this.taskID = taskID;
        this.taskDate = taskDate;
        this.taskOwner = taskOwner;
        this.priority = priority;
        this.orderID = orderID;
        this.taskDeadline = taskDeadline;
        this.taskProcessStatus = taskProcessStatus;
        this.taskDescription = taskDescription;
        this.taskComments = taskComments;
    }

    public String getTaskID() {
        return taskID;
    }

    public void setTaskID(String taskID) {
        this.taskID = taskID;
    }

    public Date getTaskDate() {
        return taskDate;
    }

    public void setTaskDate(Date taskDate) {
        this.taskDate = taskDate;
    }

    public String getTaskOwner() {
        return taskOwner;
    }

    public void setTaskOwner(String taskOwner) {
        this.taskOwner = taskOwner;
    }

    public String getPriority() {
        return priority;
    }

    public void setPriority(String priority) {
        this.priority = priority;
    }

    public String getOrderID() {
        return orderID;
    }

    public void setOrderID(String orderID) {
        this.orderID = orderID;
    }

    public Date getTaskDeadline() {
        return taskDeadline;
    }

    public void setTaskDeadline(Date taskDeadline) {
        this.taskDeadline = taskDeadline;
    }

    public String getTaskProcessStatus() {
        return taskProcessStatus;
    }

    public void setTaskProcessStatus(String taskProcessStatus) {
        this.taskProcessStatus = taskProcessStatus;
    }

    public String getTaskDescription() {
        return taskDescription;
    }

    public void setTaskDescription(String taskDescription) {
        this.taskDescription = taskDescription;
    }

    public String getTaskComments() {
        return taskComments;
    }

    public void setTaskComments(String taskComments) {
        this.taskComments = taskComments;
    }

    
       
}

