package util;

import jakarta.mail.*;
import jakarta.mail.internet.*;
import java.util.Properties;

/**
 * Email Utility Class
 * Lớp tiện ích gửi email
 */
public class EmailUtil {
    
    // Email configuration - Update these with your Gmail credentials
    private static final String FROM_EMAIL = "yourgmail@gmail.com";
    private static final String APP_PASSWORD = "your-app-password"; // 16-character Gmail App Password
    
    /**
     * Send password reset email
     * Gửi email đặt lại mật khẩu
     */
    public static void sendResetEmail(String toEmail, String resetLink) throws MessagingException {
        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");
        props.put("mail.smtp.ssl.trust", "smtp.gmail.com");
        
        Session session = Session.getInstance(props, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(FROM_EMAIL, APP_PASSWORD);
            }
        });
        
        try {
            Message msg = new MimeMessage(session);
            msg.setFrom(new InternetAddress(FROM_EMAIL, "SmartPhoneStore.vn"));
            msg.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail, false));
            msg.setSubject("Đặt lại mật khẩu - SmartPhoneStore.vn");
            
            String htmlContent = "<html><body style='font-family: Arial, sans-serif;'>"
                    + "<div style='max-width: 600px; margin: 0 auto; padding: 20px;'>"
                    + "<h2 style='color: #007bff;'>Đặt lại mật khẩu</h2>"
                    + "<p>Xin chào,</p>"
                    + "<p>Bạn đã yêu cầu đặt lại mật khẩu cho tài khoản SmartPhoneStore.vn.</p>"
                    + "<p>Nhấn vào liên kết bên dưới để đặt lại mật khẩu:</p>"
                    + "<p style='text-align: center; margin: 30px 0;'>"
                    + "<a href='" + resetLink + "' "
                    + "style='background-color: #007bff; color: white; padding: 12px 24px; "
                    + "text-decoration: none; border-radius: 5px; display: inline-block;'>"
                    + "Đặt lại mật khẩu</a>"
                    + "</p>"
                    + "<p>Hoặc sao chép và dán liên kết sau vào trình duyệt:</p>"
                    + "<p style='word-break: break-all; color: #666;'>" + resetLink + "</p>"
                    + "<p><strong>Lưu ý:</strong> Liên kết này sẽ hết hạn sau 15 phút.</p>"
                    + "<p>Nếu bạn không yêu cầu đặt lại mật khẩu, vui lòng bỏ qua email này.</p>"
                    + "<hr style='margin: 20px 0; border: none; border-top: 1px solid #ddd;'>"
                    + "<p style='color: #666; font-size: 12px;'>"
                    + "SmartPhoneStore.vn - Cửa hàng điện thoại uy tín"
                    + "</p>"
                    + "</div></body></html>";
            
            msg.setContent(htmlContent, "text/html; charset=UTF-8");
            Transport.send(msg);
        } catch (MessagingException e) {
            e.printStackTrace();
            throw e;
        }
    }
}

