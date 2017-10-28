/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package entity;

import java.sql.Date;
import java.sql.Timestamp;

/**
 *
 * @author Quentin the Frenchy
 */
public class TasksLog {

    private String taskLogID;
    private String taskID;
    private Date taskDate;
    private String taskOwner;
    private String priority;
    private String orderID;
    private Date taskDeadline;
    private String taskProcessStatus;
    private String taskDescription;
    private String taskComments;
    private String actionType;
    private String userType;
    private String username;
    private Timestamp timestamp;

    public TasksLog(String taskLogID, String taskID, Date taskDate, String taskOwner, String priority, String orderID, Date taskDeadline, String taskProcessStatus, String taskDescription, String taskComments, String actionType, String userType, String username, Timestamp timestamp) {
        this.taskLogID = taskLogID;
        this.taskID = taskID;
        this.taskDate = taskDate;
        this.taskOwner = taskOwner;
        this.priority = priority;
        this.orderID = orderID;
        this.taskDeadline = taskDeadline;
        this.taskProcessStatus = taskProcessStatus;
        this.taskDescription = taskDescription;
        this.taskComments = taskComments;
        this.actionType = actionType;
        this.userType = userType;
        this.username = username;
        this.timestamp = timestamp;
    }

    public String getTaskLogID() {
        return taskLogID;
    }

    public void setTaskLogID(String taskLogID) {
        this.taskLogID = taskLogID;
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

    public String getActionType() {
        return actionType;
    }

    public void setActionType(String actionType) {
        this.actionType = actionType;
    }

    public String getUserType() {
        return userType;
    }

    public void setUserType(String userType) {
        this.userType = userType;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public Timestamp getTimestamp() {
        return timestamp;
    }

    public void setTimestamp(Timestamp timestamp) {
        this.timestamp = timestamp;
    }
}

