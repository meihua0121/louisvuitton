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
public class Orders {
    private String orderID;
    private Date orderDate;
    private String orderOwner;
    private String storeCode;
    private String productFamily;
    private int orderQuantity;
    private Date shippingDate;
    private String shippingMethod;
    private String orderStatus;
    private String orderComments;
    private String priority;
    private String eventID;
    private String trackingNumber;
    private Date dateCompleted;
    private String orderNumber;

    public Orders(String orderID, Date orderDate, String orderOwner, String storeCode, String productFamily, int orderQuantity, Date shippingDate, String shippingMethod, String orderStatus, String orderComments, String priority, String eventID, String trackingNumber, Date dateCompleted, String orderNumber) {
        this.orderID = orderID;
        this.orderDate = orderDate;
        this.orderOwner = orderOwner;
        this.storeCode = storeCode;
        this.productFamily = productFamily;
        this.orderQuantity = orderQuantity;
        this.shippingDate = shippingDate;
        this.shippingMethod = shippingMethod;
        this.orderStatus = orderStatus;
        this.orderComments = orderComments;
        this.priority = priority;
        this.eventID = eventID;
        this.trackingNumber = trackingNumber;
        this.dateCompleted = dateCompleted;
        this.orderNumber = orderNumber;
    }

    public String getOrderNumber() {
        return orderNumber;
    }

    public void setOrderNumber(String orderNumber) {
        this.orderNumber = orderNumber;
    }

    public String getOrderID() {
        return orderID;
    }

    public void setOrderID(String orderID) {
        this.orderID = orderID;
    }

    public Date getOrderDate() {
        return orderDate;
    }

    public void setOrderDate(Date orderDate) {
        this.orderDate = orderDate;
    }

    public String getOrderOwner() {
        return orderOwner;
    }

    public void setOrderOwner(String orderOwner) {
        this.orderOwner = orderOwner;
    }

    public String getStoreCode() {
        return storeCode;
    }

    public void setStoreCode(String storeCode) {
        this.storeCode = storeCode;
    }

    public String getProductFamily() {
        return productFamily;
    }

    public void setProductFamily(String productFamily) {
        this.productFamily = productFamily;
    }

    public int getOrderQuantity() {
        return orderQuantity;
    }

    public void setOrderQuantity(int orderQuantity) {
        this.orderQuantity = orderQuantity;
    }

    public Date getShippingDate() {
        return shippingDate;
    }

    public void setShippingDate(Date shippingDate) {
        this.shippingDate = shippingDate;
    }

    public String getShippingMethod() {
        return shippingMethod;
    }

    public void setShippingMethod(String shippingMethod) {
        this.shippingMethod = shippingMethod;
    }

    public String getOrderStatus() {
        return orderStatus;
    }

    public void setOrderStatus(String orderStatus) {
        this.orderStatus = orderStatus;
    }

    public String getOrderComments() {
        return orderComments;
    }

    public void setOrderComments(String orderComments) {
        this.orderComments = orderComments;
    }

    public String getPriority() {
        return priority;
    }

    public void setPriority(String priority) {
        this.priority = priority;
    }

    public String getEventID() {
        return eventID;
    }

    public void setEventID(String eventID) {
        this.eventID = eventID;
    }

    public String getTrackingNumber() {
        return trackingNumber;
    }

    public void setTrackingNumber(String trackingNumber) {
        this.trackingNumber = trackingNumber;
    }

    public Date getDateCompleted() {
        return dateCompleted;
    }

    public void setDateCompleted(Date dateCompleted) {
        this.dateCompleted = dateCompleted;
    }

  
}