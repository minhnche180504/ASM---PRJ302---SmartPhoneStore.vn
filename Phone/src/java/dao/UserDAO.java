package dao;

import model.User;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UserDAO extends DBConnect {
    
    public UserDAO() {
        super();
    }
    
    /**
     * Đăng ký user mới
     */
    public boolean register(User user) {
        String sql = "INSERT INTO users (username, password, email, full_name, phone, address, role) VALUES (?, ?, ?, ?, ?, ?, ?)";
        
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, user.getUsername());
            ps.setString(2, user.getPassword()); // Trong thực tế nên hash password
            ps.setString(3, user.getEmail());
            ps.setString(4, user.getFullName());
            ps.setString(5, user.getPhone());
            ps.setString(6, user.getAddress());
            ps.setString(7, user.getRole());
            
            int result = ps.executeUpdate();
            System.out.println("✅ User registered: " + user.getUsername());
            return result > 0;
            
        } catch (SQLException e) {
            System.err.println("❌ Error registering user: " + e.getMessage());
            return false;
        }
    }
    
    /**
     * Đăng nhập - xác thực user
     */
    public User login(String username, String password) {
        String sql = "SELECT * FROM users WHERE username = ? AND password = ?";
        
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, username);
            ps.setString(2, password);
            
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                User user = new User();
                user.setId(rs.getInt("id"));
                user.setUsername(rs.getString("username"));
                user.setPassword(rs.getString("password"));
                user.setEmail(rs.getString("email"));
                user.setFullName(rs.getString("full_name"));
                user.setPhone(rs.getString("phone"));
                user.setAddress(rs.getString("address"));
                user.setRole(rs.getString("role"));
                user.setCreatedAt(rs.getTimestamp("created_at"));
                user.setUpdatedAt(rs.getTimestamp("updated_at"));
                
                System.out.println("✅ Login successful: " + username);
                return user;
            }
            
        } catch (SQLException e) {
            System.err.println("❌ Error during login: " + e.getMessage());
        }
        
        System.out.println("❌ Login failed: " + username);
        return null;
    }
    
    /**
     * Lấy tất cả users (cho admin)
     */
    public List<User> getAllUsers() {
        List<User> users = new ArrayList<>();
        String sql = "SELECT * FROM users ORDER BY created_at DESC";
        
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            
            while (rs.next()) {
                User user = new User();
                user.setId(rs.getInt("id"));
                user.setUsername(rs.getString("username"));
                user.setPassword(rs.getString("password"));
                user.setEmail(rs.getString("email"));
                user.setFullName(rs.getString("full_name"));
                user.setPhone(rs.getString("phone"));
                user.setAddress(rs.getString("address"));
                user.setRole(rs.getString("role"));
                user.setCreatedAt(rs.getTimestamp("created_at"));
                user.setUpdatedAt(rs.getTimestamp("updated_at"));
                
                users.add(user);
            }
            
            System.out.println("✅ Loaded " + users.size() + " users");
            
        } catch (SQLException e) {
            System.err.println("❌ Error getting all users: " + e.getMessage());
        }
        
        return users;
    }
    
    /**
     * Lấy user theo ID
     */
    public User getUserById(int id) {
        String sql = "SELECT * FROM users WHERE id = ?";
        
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                User user = new User();
                user.setId(rs.getInt("id"));
                user.setUsername(rs.getString("username"));
                user.setPassword(rs.getString("password"));
                user.setEmail(rs.getString("email"));
                user.setFullName(rs.getString("full_name"));
                user.setPhone(rs.getString("phone"));
                user.setAddress(rs.getString("address"));
                user.setRole(rs.getString("role"));
                user.setCreatedAt(rs.getTimestamp("created_at"));
                user.setUpdatedAt(rs.getTimestamp("updated_at"));
                
                return user;
            }
            
        } catch (SQLException e) {
            System.err.println("❌ Error getting user by ID: " + e.getMessage());
        }
        
        return null;
    }
    
    /**
     * Lấy user theo username
     */
    public User getUserByUsername(String username) {
        String sql = "SELECT * FROM users WHERE username = ?";
        
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, username);
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                User user = new User();
                user.setId(rs.getInt("id"));
                user.setUsername(rs.getString("username"));
                user.setPassword(rs.getString("password"));
                user.setEmail(rs.getString("email"));
                user.setFullName(rs.getString("full_name"));
                user.setPhone(rs.getString("phone"));
                user.setAddress(rs.getString("address"));
                user.setRole(rs.getString("role"));
                user.setCreatedAt(rs.getTimestamp("created_at"));
                user.setUpdatedAt(rs.getTimestamp("updated_at"));
                
                return user;
            }
            
        } catch (SQLException e) {
            System.err.println("❌ Error getting user by username: " + e.getMessage());
        }
        
        return null;
    }
    
    /**
     * Kiểm tra username đã tồn tại chưa
     */
    public boolean isUsernameExists(String username) {
        String sql = "SELECT COUNT(*) FROM users WHERE username = ?";
        
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, username);
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
            
        } catch (SQLException e) {
            System.err.println("❌ Error checking username exists: " + e.getMessage());
        }
        
        return false;
    }
    
    /**
     * Kiểm tra email đã tồn tại chưa
     */
    public boolean isEmailExists(String email) {
        String sql = "SELECT COUNT(*) FROM users WHERE email = ?";
        
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
            
        } catch (SQLException e) {
            System.err.println("❌ Error checking email exists: " + e.getMessage());
        }
        
        return false;
    }
    
    /**
     * Cập nhật thông tin user
     */
    public boolean updateUser(User user) {
        String sql = "UPDATE users SET email = ?, full_name = ?, phone = ?, address = ?, role = ?, updated_at = GETDATE() WHERE id = ?";
        
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, user.getEmail());
            ps.setString(2, user.getFullName());
            ps.setString(3, user.getPhone());
            ps.setString(4, user.getAddress());
            ps.setString(5, user.getRole());
            ps.setInt(6, user.getId());
            
            int result = ps.executeUpdate();
            System.out.println("✅ User updated: " + user.getUsername());
            return result > 0;
            
        } catch (SQLException e) {
            System.err.println("❌ Error updating user: " + e.getMessage());
            return false;
        }
    }
    
    /**
     * Cập nhật mật khẩu
     */
    public boolean updatePassword(int userId, String newPassword) {
        String sql = "UPDATE users SET password = ?, updated_at = GETDATE() WHERE id = ?";
        
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, newPassword);
            ps.setInt(2, userId);
            
            int result = ps.executeUpdate();
            System.out.println("✅ Password updated for user ID: " + userId);
            return result > 0;
            
        } catch (SQLException e) {
            System.err.println("❌ Error updating password: " + e.getMessage());
            return false;
        }
    }
    
    /**
     * Xóa user và tất cả dữ liệu liên quan (cascade delete)
     */
    public boolean deleteUser(int userId) {
        // Bắt đầu transaction để đảm bảo tính toàn vẹn dữ liệu
        try {
            connection.setAutoCommit(false);
            
            // 1. Xóa order_items trước (do foreign key constraint)
            String deleteOrderItemsSql = "DELETE FROM order_items WHERE order_id IN (SELECT id FROM orders WHERE user_id = ?)";
            try (PreparedStatement ps1 = connection.prepareStatement(deleteOrderItemsSql)) {
                ps1.setInt(1, userId);
                int orderItemsDeleted = ps1.executeUpdate();
                System.out.println("🗑️ Deleted " + orderItemsDeleted + " order items for user " + userId);
            }
            
            // 2. Xóa orders
            String deleteOrdersSql = "DELETE FROM orders WHERE user_id = ?";
            try (PreparedStatement ps2 = connection.prepareStatement(deleteOrdersSql)) {
                ps2.setInt(1, userId);
                int ordersDeleted = ps2.executeUpdate();
                System.out.println("🗑️ Deleted " + ordersDeleted + " orders for user " + userId);
            }
            
            // 3. Xóa user (không cho phép xóa admin)
            String deleteUserSql = "DELETE FROM users WHERE id = ? AND role != 'ADMIN'";
            try (PreparedStatement ps3 = connection.prepareStatement(deleteUserSql)) {
                ps3.setInt(1, userId);
                int userDeleted = ps3.executeUpdate();
                
                if (userDeleted > 0) {
                    // Commit transaction nếu thành công
                    connection.commit();
                    System.out.println("✅ User deleted successfully with ID: " + userId);
                    return true;
                } else {
                    // Rollback nếu không xóa được user
                    connection.rollback();
                    System.out.println("❌ Cannot delete user (may be admin or not found): " + userId);
                    return false;
                }
            }
            
        } catch (SQLException e) {
            try {
                // Rollback transaction nếu có lỗi
                connection.rollback();
                System.err.println("🔄 Transaction rolled back due to error");
            } catch (SQLException rollbackEx) {
                System.err.println("❌ Error during rollback: " + rollbackEx.getMessage());
            }
            System.err.println("❌ Error deleting user: " + e.getMessage());
            return false;
        } finally {
            try {
                // Khôi phục auto-commit
                connection.setAutoCommit(true);
            } catch (SQLException e) {
                System.err.println("❌ Error restoring auto-commit: " + e.getMessage());
            }
        }
    }
    
    /**
     * Soft Delete - Vô hiệu hóa user thay vì xóa thật (AN TOÀN HƠN)
     * Cần thêm cột 'status' vào bảng users trước khi sử dụng
     */
    public boolean softDeleteUser(int userId) {
        // Phương pháp này cần thêm cột status vào bảng users
        // ALTER TABLE users ADD status NVARCHAR(20) DEFAULT 'ACTIVE';
        
        String sql = "UPDATE users SET status = 'DELETED' WHERE id = ? AND role != 'ADMIN'";
        
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, userId);
            
            int result = ps.executeUpdate();
            if (result > 0) {
                System.out.println("✅ User soft deleted with ID: " + userId);
                return true;
            } else {
                System.out.println("❌ Cannot soft delete user (may be admin or not found): " + userId);
                return false;
            }
            
        } catch (SQLException e) {
            System.err.println("❌ Error soft deleting user: " + e.getMessage());
            // Có thể cột status chưa tồn tại, fallback về hard delete
            System.out.println("🔄 Fallback to hard delete...");
            return deleteUser(userId);
        }
    }
    
    /**
     * Đếm tổng số users
     */
    public int getTotalUsers() {
        String sql = "SELECT COUNT(*) FROM users";
        
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                return rs.getInt(1);
            }
            
        } catch (SQLException e) {
            System.err.println("❌ Error counting users: " + e.getMessage());
        }
        
        return 0;
    }
    
    /**
     * Lấy users theo role
     */
    public List<User> getUsersByRole(String role) {
        List<User> users = new ArrayList<>();
        String sql = "SELECT * FROM users WHERE role = ? ORDER BY created_at DESC";
        
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, role);
            ResultSet rs = ps.executeQuery();
            
            while (rs.next()) {
                User user = new User();
                user.setId(rs.getInt("id"));
                user.setUsername(rs.getString("username"));
                user.setPassword(rs.getString("password"));
                user.setEmail(rs.getString("email"));
                user.setFullName(rs.getString("full_name"));
                user.setPhone(rs.getString("phone"));
                user.setAddress(rs.getString("address"));
                user.setRole(rs.getString("role"));
                user.setCreatedAt(rs.getTimestamp("created_at"));
                user.setUpdatedAt(rs.getTimestamp("updated_at"));
                
                users.add(user);
            }
            
        } catch (SQLException e) {
            System.err.println("❌ Error getting users by role: " + e.getMessage());
        }
        
        return users;
    }
    
    /**
     * Test connection
     */
    public void testConnection() {
        if (connection != null) {
            System.out.println("✅ UserDAO - Database connection is active");
        } else {
            System.out.println("❌ UserDAO - Database connection is null");
        }
    }
}