package dao;

import model.OrderItem;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * Data Access Object cho OrderItem
 */
public class OrderItemDAO extends DBConnect {
    
    /**
     * Lấy tất cả sản phẩm trong đơn hàng
     */
    public List<OrderItem> getOrderItemsByOrderId(int orderId) {
        List<OrderItem> items = new ArrayList<>();
        String sql = "SELECT * FROM order_items WHERE order_id = ?";
        
        try {
            if (connection == null) {
                System.err.println("❌ Database connection is null");
                return items;
            }
            
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, orderId);
            ResultSet rs = ps.executeQuery();
            
            while (rs.next()) {
                OrderItem item = new OrderItem();
                item.setId(rs.getInt("id"));
                item.setOrderId(rs.getInt("order_id"));
                item.setProductId(rs.getInt("product_id"));
                item.setProductName(rs.getString("product_name"));
                item.setPrice(rs.getDouble("price"));
                item.setQuantity(rs.getInt("quantity"));
                item.setSubtotal(rs.getDouble("subtotal"));
                
                items.add(item);
            }
            
            rs.close();
            ps.close();
            
            System.out.println("✅ Loaded " + items.size() + " items for order: " + orderId);
            
        } catch (SQLException e) {
            System.err.println("❌ Error getting order items: " + e.getMessage());
            e.printStackTrace();
        }
        
        return items;
    }
    
    /**
     * Thêm một sản phẩm vào đơn hàng
     */
    public boolean addOrderItem(OrderItem item) {
        String sql = "INSERT INTO order_items (order_id, product_id, product_name, price, quantity, subtotal) VALUES (?, ?, ?, ?, ?, ?)";
        
        try {
            if (connection == null) {
                System.err.println("❌ Database connection is null");
                return false;
            }
            
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, item.getOrderId());
            ps.setInt(2, item.getProductId());
            ps.setString(3, item.getProductName());
            ps.setDouble(4, item.getPrice());
            ps.setInt(5, item.getQuantity());
            ps.setDouble(6, item.getSubtotal());
            
            int result = ps.executeUpdate();
            ps.close();
            
            if (result > 0) {
                System.out.println("✅ Order item added successfully");
                return true;
            }
            
        } catch (SQLException e) {
            System.err.println("❌ Error adding order item: " + e.getMessage());
            e.printStackTrace();
        }
        
        return false;
    }
}

