/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package entity;

import java.sql.Date;
import java.sql.Timestamp;

public class EventsLog {

    private String eventLogID;
    private String eventID;
    private String eventName;
    private Date eventDate;
    private String eventOwner;
    private String priority;
    private String eventLocation;
    private String eventProcessStatus;
    private Date eventDeadline;
    private String comments;
    private String actionType;
    private String userType;
    private String username;
    private Timestamp timestamp;

    public EventsLog(String eventLogID, String eventID, String eventName, Date eventDate, String eventOwner, String priority, Date eventDeadline, String eventProcessStatus, String eventLocation, String comments, String actionType, String userType, String username, Timestamp timestamp) {
        this.eventLogID = eventLogID;
        this.eventID = eventID;
        this.eventName = eventName;
        this.eventDate = eventDate;
        this.eventOwner = eventOwner;
        this.priority = priority;
        this.eventLocation = eventLocation;
        this.eventProcessStatus = eventProcessStatus;
        this.eventDeadline = eventDeadline;
        this.comments = comments;
        this.actionType = actionType;
        this.userType = userType;
        this.username = username;
        this.timestamp = timestamp;
    }

    public String getEventLogID() {
        return eventLogID;
    }

    public void setEventLogID(String eventLogID) {
        this.eventLogID = eventLogID;
    }

    public String getEventID() {
        return eventID;
    }

    public void setEventID(String eventID) {
        this.eventID = eventID;
    }

    public String getEventName() {
        return eventName;
    }

    public void setEventName(String eventName) {
        this.eventName = eventName;
    }

    public Date getEventDate() {
        return eventDate;
    }

    public void setEventDate(Date eventDate) {
        this.eventDate = eventDate;
    }

    public String getEventOwner() {
        return eventOwner;
    }

    public void setEventOwner(String eventOwner) {
        this.eventOwner = eventOwner;
    }

    public String getPriority() {
        return priority;
    }

    public void setPriority(String priority) {
        this.priority = priority;
    }

    public String getEventLocation() {
        return eventLocation;
    }

    public void setEventLocation(String eventLocation) {
        this.eventLocation = eventLocation;
    }

    public String getEventProcessStatus() {
        return eventProcessStatus;
    }

    public void setEventProcessStatus(String eventProcessStatus) {
        this.eventProcessStatus = eventProcessStatus;
    }

    public Date getEventDeadline() {
        return eventDeadline;
    }

    public void setEventDeadline(Date eventDeadline) {
        this.eventDeadline = eventDeadline;
    }

    public String getComments() {
        return comments;
    }

    public void setComments(String comments) {
        this.comments = comments;
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
