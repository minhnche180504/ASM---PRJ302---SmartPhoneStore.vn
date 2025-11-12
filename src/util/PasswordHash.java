package util;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

/**
 * Password Hashing Utility
 * Lớp tiện ích mã hóa mật khẩu
 */
public class PasswordHash {
    
    /**
     * Hash password using SHA-256
     * Mã hóa mật khẩu bằng SHA-256
     */
    public static String hashPassword(String password) {
        try {
            MessageDigest md = MessageDigest.getInstance("SHA-256");
            byte[] hashBytes = md.digest(password.getBytes());
            
            // Convert bytes to hexadecimal string
            StringBuilder sb = new StringBuilder();
            for (byte b : hashBytes) {
                sb.append(String.format("%02x", b));
            }
            return sb.toString();
        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException("SHA-256 algorithm not found", e);
        }
    }
    
    /**
     * Verify password
     * Xác thực mật khẩu
     */
    public static boolean verifyPassword(String password, String hash) {
        String hashedPassword = hashPassword(password);
        return hashedPassword.equals(hash);
    }
}

