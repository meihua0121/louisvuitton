/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package entity;
import javax.mail.*;
import javax.mail.internet.*;
import java.util.*;

/**
 *
 * @author huamei
 */

public class Mail {
    private String to;
    private String from;
    private String message;
    private String subject;
    private String smtpServ;
    public static void main(String [] args) { 
        
    
    }
    /**
     * @return the to
     */
    public String getTo() {
        return to;
    }

    /**
     * @param to the to to set
     */
    public void setTo(String to) {
        this.to = to;
    }

    /**
     * @return the from
     */
    public String getFrom() {
        return from;
    }

    /**
     * @param from the from to set
     */
    public void setFrom(String from) {
        this.from = from;
    }

    /**
     * @return the message
     */
    public String getMessage() {
        return message;
    }

    /**
     * @param message the message to set
     */
    public void setMessage(String message) {
        this.message = message;
    }

    /**
     * @return the subject
     */
    public String getSubject() {
        return subject;
    }

    /**
     * @param subject the subject to set
     */
    public void setSubject(String subject) {
        this.subject = subject;
    }

    /**
     * @return the smtpServ
     */
    public String getSmtpServ() {
        return smtpServ;
    }

    /**
     * @param smtpServ the smtpServ to set
     */
    public void setSmtpServ(String smtpServ) {
        this.smtpServ = smtpServ;
    }
    

}