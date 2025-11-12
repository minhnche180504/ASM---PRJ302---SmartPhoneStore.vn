package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnect {
    protected Connection connection;
    
    public DBConnect() {
        try {
            // Cập nhật URL, username, password theo SQL Server của bạn
            String url = "jdbc:sqlserver://localhost\\MINDTHEMINH:1433;databaseName=SmartPhoneStore;trustServerCertificate=true;";
            String username = "sa";
            String password = "admin";
            
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            connection = DriverManager.getConnection(url, username, password);
            
            if (connection != null) {
                System.out.println("✅ Database connected successfully!");
            }
            
        } catch (ClassNotFoundException | SQLException ex) {
            System.err.println("❌ Database connection failed: " + ex.getMessage());
            connection = null;
        }
    }
    
    public Connection getConnection() {
        return connection;
    }
    
    public void closeConnection() {
        try {
            if (connection != null && !connection.isClosed()) {
                connection.close();
                System.out.println("📴 Database connection closed");
            }
        } catch (SQLException e) {
            System.err.println("❌ Error closing connection: " + e.getMessage());
        }
    }
    
    public static void main(String[] args) {
        DBConnect d = new DBConnect();
        Connection connection = d.getConnection();
        
        if (connection != null) {
            System.out.println("Kết nối cơ sở dữ liệu thành công.");
            d.closeConnection();
        } else {
            System.out.println("Không thể kết nối đến cơ sở dữ liệu.");
        }
    }
}