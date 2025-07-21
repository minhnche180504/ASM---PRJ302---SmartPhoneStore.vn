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
     * Tạo đơn hàng mới và lưu chi tiết sản phẩm
     */
    public boolean createOrder(Order order, List<model.Product> cart) {
        String orderSql = "INSERT INTO orders (user_id, user_name, total, status, customer_name, customer_phone, customer_address, order_date, updated_at) VALUES (?, ?, ?, ?, ?, ?, ?, GETDATE(), GETDATE())";
        String orderItemSql = "INSERT INTO order_items (order_id, product_id, product_name, price, quantity, subtotal) VALUES (?, ?, ?, ?, ?, ?)";
        try {
            if (connection == null) {
                System.err.println("❌ Database connection is null");
                return false;
            }
            connection.setAutoCommit(false);
            // 1. Insert order
            PreparedStatement psOrder = connection.prepareStatement(orderSql, Statement.RETURN_GENERATED_KEYS);
            psOrder.setInt(1, order.getUserId());
            psOrder.setString(2, order.getUserName());
            psOrder.setDouble(3, order.getTotal());
            psOrder.setString(4, order.getStatus());
            psOrder.setString(5, order.getCustomerName());
            psOrder.setString(6, order.getCustomerPhone());
            psOrder.setString(7, order.getCustomerAddress());
            int result = psOrder.executeUpdate();
            if (result == 0) {
                connection.rollback();
                psOrder.close();
                return false;
            }
            ResultSet generatedKeys = psOrder.getGeneratedKeys();
            int orderId = -1;
            if (generatedKeys.next()) {
                orderId = generatedKeys.getInt(1);
            } else {
                connection.rollback();
                psOrder.close();
                return false;
            }
            psOrder.close();
            // 2. Insert order items
            PreparedStatement psItem = connection.prepareStatement(orderItemSql);
            for (model.Product product : cart) {
                psItem.setInt(1, orderId);
                psItem.setInt(2, product.getId());
                psItem.setString(3, product.getName());
                psItem.setDouble(4, product.getPrice());
                psItem.setInt(5, 1); // quantity = 1 (nếu có quantity thì lấy đúng)
                psItem.setDouble(6, product.getPrice());
                psItem.addBatch();
            }
            psItem.executeBatch();
            psItem.close();
            connection.commit();
            System.out.println("✅ Order and items created successfully for user: " + order.getUserName());
            return true;
        } catch (SQLException e) {
            try { connection.rollback(); } catch (Exception ex) {}
            System.err.println("❌ Error creating order with items: " + e.getMessage());
            e.printStackTrace();
        } finally {
            try { connection.setAutoCommit(true); } catch (Exception ex) {}
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