package emailsending;

import java.util.Properties;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

public class Email {

	public static String sendEmail(String subject,String msg, String to) {      
	      final String from = "hopetolivegroup3adb@gmail.com";
        final String password = "group3adb@";
        String host = "smtp.gmail.com";
        Properties props = System.getProperties();
        props.put("mail.host", host);
        props.put("mail.user", from);
        props.put("mail.smtp.password", password);
        props.put("mail.defaultEncoding", "UTF-8");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.required", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
        props.put("mail.smtp.socketFactory.fallback", "true");
        props.put("mail.smtp.port", "587");
        props.put("mail.smtp.socketFactory.port", "465");
        props.setProperty("mail.smtp.ssl.trust", host);
        Session session = Session.getInstance(props, new javax.mail.Authenticator() {
      	    protected PasswordAuthentication getPasswordAuthentication() {
      	        return new PasswordAuthentication(from, password);
      	    }
      	});

	      try {
	         // Create a default MimeMessage object.
	         MimeMessage message = new MimeMessage(session);

	         // Set From: header field of the header.
	         message.setFrom(new InternetAddress(from));

	         // Set To: header field of the header.
	         message.addRecipient(Message.RecipientType.TO, new InternetAddress(to));

	         // Set Subject: header field
	         message.setSubject(subject);

	         // Now set the actual message
	         message.setText(msg);

	         // Send message
	         Transport.send(message);
	         System.out.println("Sent message successfully....");
	         return "Sent message successfully";
	      } catch (MessagingException mex) {
	         mex.printStackTrace();
	         return "Email sending failed";
	      }
	}

	public static void main(String[] args) {
		sendEmail("hii", "hello", "hopetolivegroup3adb@gmail.com");
	}
}
