/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package entity;


import java.sql.Date;
/**
 *
 * @author HP
 */



public class Events {
    private String eventID;
    private String eventName;
    private Date eventDate;
    private String eventOwner;
    private String priority;
    private String eventLocation;
    private String eventProcessStatus;
    private Date eventDeadline;
    private String comments;
    
    public Events(String eventID, String eventName, Date eventDate, String eventOwner, String priority, Date eventDeadline, String eventProcessStatus, String eventLocation, String comments) {
        this.eventID = eventID;
        this.eventName = eventName;
        this.eventDate = eventDate;
        this.eventOwner = eventOwner;
        this.priority = priority;
        this.eventDeadline = eventDeadline;
        this.eventProcessStatus = eventProcessStatus;
        this.eventLocation=eventLocation;
        this.comments=comments;
    }

    public String getComments() {
        return comments;
    }

    public void setComments(String comments) {
        this.comments = comments;
    }

    public String getEventName() {
        return eventName;
    }

    public void setEventName(String eventName) {
        this.eventName = eventName;
    }
    public String getEventID() {
        return eventID;
    }

    public void setEventID(String eventID) {
        this.eventID = eventID;
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


    public Date getEventDeadline() {
        return eventDeadline;
    }

    public void setEventDeadline(Date eventDeadline) {
        this.eventDeadline = eventDeadline;
    }

    public String getEventProcessStatus() {
        return eventProcessStatus;
    }

    public void setEventProcessStatus(String eventProcessStatus) {
        this.eventProcessStatus = eventProcessStatus;
    }
    
    public void setEventLocation(String eventLocation) {
        this.eventLocation = eventLocation;
    }

    public String getEventLocation() {
        return eventLocation;
    }    
    
    
    
}