package dao;

import model.Order;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * Data Access Object cho Order - Fixed version
 */
public class OrderDAO extends DBConnect {
    
    /**
     * Tạo đơn hàng mới
     */
    public boolean createOrder(Order order) {
        String sql = "INSERT INTO orders (user_id, user_name, total, status, customer_name, customer_phone, customer_address, order_date, updated_at) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?, GETDATE(), GETDATE())";
        
        try {
            if (connection == null) {
                System.err.println("❌ Database connection is null");
                return false;
            }
            
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, order.getUserId());
            ps.setString(2, order.getUserName());
            ps.setDouble(3, order.getTotal());
            ps.setString(4, order.getStatus());
            ps.setString(5, order.getCustomerName());
            ps.setString(6, order.getCustomerPhone());
            ps.setString(7, order.getCustomerAddress());
            
            int result = ps.executeUpdate();
            ps.close();
            
            if (result > 0) {
                System.out.println("✅ Order created successfully for user: " + order.getUserName());
                return true;
            }
            
        } catch (SQLException e) {
            System.err.println("❌ Error creating order: " + e.getMessage());
            e.printStackTrace();
        }
        
        return false;
    }
    
    /**
     * Lấy tất cả đơn hàng (cho admin)
     */
    public List<Order> getAllOrders() {
        List<Order> orders = new ArrayList<>();
        String sql = "SELECT * FROM orders ORDER BY order_date DESC";
        
        try {
            if (connection == null) {
                System.err.println("❌ Database connection is null");
                return orders;
            }
            
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            
            while (rs.next()) {
                Order order = new Order();
                order.setId(rs.getInt("id"));
                order.setUserId(rs.getInt("user_id"));
                order.setUserName(rs.getString("user_name"));
                order.setTotal(rs.getDouble("total"));
                order.setStatus(rs.getString("status"));
                order.setCustomerName(rs.getString("customer_name"));
                order.setCustomerPhone(rs.getString("customer_phone"));
                order.setCustomerAddress(rs.getString("customer_address"));
                order.setOrderDate(rs.getTimestamp("order_date"));
                order.setUpdatedAt(rs.getTimestamp("updated_at"));
                
                orders.add(order);
            }
            
            rs.close();
            ps.close();
            
            System.out.println("✅ Loaded " + orders.size() + " orders");
            
        } catch (SQLException e) {
            System.err.println("❌ Error getting all orders: " + e.getMessage());
            e.printStackTrace();
        }
        
        return orders;
    }
    
    /**
     * Lấy đơn hàng theo user ID
     */
    public List<Order> getOrdersByUserId(int userId) {
        List<Order> orders = new ArrayList<>();
        String sql = "SELECT * FROM orders WHERE user_id = ? ORDER BY order_date DESC";
        
        try {
            if (connection == null) {
                System.err.println("❌ Database connection is null");
                return orders;
            }
            
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            
            while (rs.next()) {
                Order order = new Order();
                order.setId(rs.getInt("id"));
                order.setUserId(rs.getInt("user_id"));
                order.setUserName(rs.getString("user_name"));
                order.setTotal(rs.getDouble("total"));
                order.setStatus(rs.getString("status"));
                order.setCustomerName(rs.getString("customer_name"));
                order.setCustomerPhone(rs.getString("customer_phone"));
                order.setCustomerAddress(rs.getString("customer_address"));
                order.setOrderDate(rs.getTimestamp("order_date"));
                order.setUpdatedAt(rs.getTimestamp("updated_at"));
                
                orders.add(order);
            }
            
            rs.close();
            ps.close();
            
        } catch (SQLException e) {
            System.err.println("❌ Error getting orders by user: " + e.getMessage());
            e.printStackTrace();
        }
        
        return orders;
    }
    
    /**
     * Cập nhật trạng thái đơn hàng
     */
    public boolean updateOrderStatus(int orderId, String status) {
        String sql = "UPDATE orders SET status = ?, updated_at = GETDATE() WHERE id = ?";
        
        try {
            if (connection == null) {
                System.err.println("❌ Database connection is null");
                return false;
            }
            
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, status);
            ps.setInt(2, orderId);
            
            int result = ps.executeUpdate();
            ps.close();
            
            if (result > 0) {
                System.out.println("✅ Order status updated: " + orderId + " -> " + status);
                return true;
            }
            
        } catch (SQLException e) {
            System.err.println("❌ Error updating order status: " + e.getMessage());
            e.printStackTrace();
        }
        
        return false;
    }
    
    /**
     * Lấy đơn hàng theo ID
     */
    public Order getOrderById(int id) {
        String sql = "SELECT * FROM orders WHERE id = ?";
        
        try {
            if (connection == null) {
                System.err.println("❌ Database connection is null");
                return null;
            }
            
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                Order order = new Order();
                order.setId(rs.getInt("id"));
                order.setUserId(rs.getInt("user_id"));
                order.setUserName(rs.getString("user_name"));
                order.setTotal(rs.getDouble("total"));
                order.setStatus(rs.getString("status"));
                order.setCustomerName(rs.getString("customer_name"));
                order.setCustomerPhone(rs.getString("customer_phone"));
                order.setCustomerAddress(rs.getString("customer_address"));
                order.setOrderDate(rs.getTimestamp("order_date"));
                order.setUpdatedAt(rs.getTimestamp("updated_at"));
                
                rs.close();
                ps.close();
                
                return order;
            }
            
            rs.close();
            ps.close();
            
        } catch (SQLException e) {
            System.err.println("❌ Error getting order by ID: " + e.getMessage());
            e.printStackTrace();
        }
        
        return null;
    }
}