package dao;

import entity.Mail;
import java.util.Date;
import java.util.Properties;
import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

/**
 *
 * @author HP
 */
public class EmailDAO {

    public boolean sendMail(String to, String from, String smtpServ, String subject, String message) {
        try {
            Properties props = System.getProperties();
            // -- Attaching to default Session, or we could start a new one --
            props.put("mail.transport.protocol", "smtp");
            props.put("mail.smtp.starttls.enable", "true");
            props.put("mail.smtp.host", smtpServ);
            props.put("mail.smtp.auth", "true");

            Authenticator auth = new EmailDAO.SMTPAuthenticator();
            Session session = Session.getInstance(props, auth);
            //Session session = Session.getDefaultInstance(props);
            // -- Create a new message --
            Message msg = new MimeMessage(session);
            // -- Set the FROM and TO fields --
            msg.setFrom(new InternetAddress(from));
            msg.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to, false));
            msg.setSubject(subject);
            msg.setText(message);
            // -- Set some other header information --
            msg.setHeader("MyMail", "Mr. XYZ");
            msg.setSentDate(new Date());

            // -- Send the message --
            Transport.send(msg);
            System.out.println("Message sent to" + to + " OK.");
            return true;
        } catch (Exception ex) {
            ex.printStackTrace();
            System.out.println("Exception " + ex);
            return false;
        }
    }

    // Also include an inner class that is used for authentication purposes
    private class SMTPAuthenticator extends javax.mail.Authenticator {

        @Override
        public PasswordAuthentication getPasswordAuthentication() {
            String username = "LVSystem123@gmail.com";           // specify your email id here (sender's email id)
            String password = "AceConsulting";                                      // specify your password here
            return new PasswordAuthentication(username, password);
        }
    }
}
