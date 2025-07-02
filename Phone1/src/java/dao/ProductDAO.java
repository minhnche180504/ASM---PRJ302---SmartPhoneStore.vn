package dao;

import model.Product;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * Data Access Object cho Product - Complete CRUD version
 */
public class ProductDAO extends DBConnect {
    
    /**
     * Lấy tất cả sản phẩm từ database
     */
    public List<Product> getAllProducts() {
        List<Product> products = new ArrayList<>();
        String sql = "SELECT * FROM products ORDER BY created_at DESC";
        
        try {
            if (connection == null) {
                System.err.println("❌ Database connection is null, using fallback data");
                return getFallbackProducts();
            }
            
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            
            while (rs.next()) {
                Product product = new Product();
                product.setId(rs.getInt("id"));
                product.setName(rs.getString("name"));
                product.setPrice(rs.getDouble("price"));
                product.setDescription(rs.getString("description"));
                product.setImage(rs.getString("image"));
                
                products.add(product);
            }
            
            rs.close();
            ps.close();
            
            System.out.println("✅ Loaded " + products.size() + " products from database");
            
        } catch (SQLException e) {
            System.err.println("❌ Error getting products: " + e.getMessage());
            e.printStackTrace();
            
            // Fallback: trả về dữ liệu mẫu nếu lỗi database
            return getFallbackProducts();
        }
        
        return products;
    }
    
    /**
     * Lấy sản phẩm theo ID
     */
    public Product getProductById(int id) {
        String sql = "SELECT * FROM products WHERE id = ?";
        
        try {
            if (connection == null) {
                System.err.println("❌ Database connection is null");
                return getFallbackProductById(id);
            }
            
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                Product product = new Product();
                product.setId(rs.getInt("id"));
                product.setName(rs.getString("name"));
                product.setPrice(rs.getDouble("price"));
                product.setDescription(rs.getString("description"));
                product.setImage(rs.getString("image"));
                
                rs.close();
                ps.close();
                
                System.out.println("✅ Found product: " + product.getName());
                return product;
            }
            
            rs.close();
            ps.close();
            
        } catch (SQLException e) {
            System.err.println("❌ Error getting product by ID: " + e.getMessage());
            e.printStackTrace();
            return getFallbackProductById(id);
        }
        
        return null;
    }
    
    /**
     * Thêm sản phẩm mới
     */
    public boolean addProduct(Product product) {
        String sql = "INSERT INTO products (name, price, description, image, created_at, updated_at) VALUES (?, ?, ?, ?, GETDATE(), GETDATE())";
        
        try {
            if (connection == null) {
                System.err.println("❌ Database connection is null");
                return false;
            }
            
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, product.getName());
            ps.setDouble(2, product.getPrice());
            ps.setString(3, product.getDescription());
            ps.setString(4, product.getImage());
            
            int result = ps.executeUpdate();
            ps.close();
            
            if (result > 0) {
                System.out.println("✅ Product added successfully: " + product.getName());
                return true;
            }
            
        } catch (SQLException e) {
            System.err.println("❌ Error adding product: " + e.getMessage());
            e.printStackTrace();
        }
        
        return false;
    }
    
    /**
     * Cập nhật thông tin sản phẩm
     */
    public boolean updateProduct(Product product) {
        String sql = "UPDATE products SET name = ?, price = ?, description = ?, image = ?, updated_at = GETDATE() WHERE id = ?";
        
        try {
            if (connection == null) {
                System.err.println("❌ Database connection is null");
                return false;
            }
            
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, product.getName());
            ps.setDouble(2, product.getPrice());
            ps.setString(3, product.getDescription());
            ps.setString(4, product.getImage());
            ps.setInt(5, product.getId());
            
            int result = ps.executeUpdate();
            ps.close();
            
            if (result > 0) {
                System.out.println("✅ Product updated successfully: " + product.getName());
                return true;
            }
            
        } catch (SQLException e) {
            System.err.println("❌ Error updating product: " + e.getMessage());
            e.printStackTrace();
        }
        
        return false;
    }
    
    /**
     * Xóa sản phẩm theo ID
     */
    public boolean deleteProduct(int productId) {
        // Bắt đầu transaction để đảm bảo tính toàn vẹn dữ liệu
        try {
            if (connection == null) {
                System.err.println("❌ Database connection is null");
                return false;
            }
            
            connection.setAutoCommit(false);
            
            // 1. Xóa order_items có chứa sản phẩm này (nếu có)
            String deleteOrderItemsSql = "DELETE FROM order_items WHERE product_id = ?";
            try (PreparedStatement ps1 = connection.prepareStatement(deleteOrderItemsSql)) {
                ps1.setInt(1, productId);
                int orderItemsDeleted = ps1.executeUpdate();
                System.out.println("🗑️ Deleted " + orderItemsDeleted + " order items for product " + productId);
            }
            
            // 2. Xóa sản phẩm
            String deleteProductSql = "DELETE FROM products WHERE id = ?";
            try (PreparedStatement ps2 = connection.prepareStatement(deleteProductSql)) {
                ps2.setInt(1, productId);
                int productDeleted = ps2.executeUpdate();
                
                if (productDeleted > 0) {
                    // Commit transaction nếu thành công
                    connection.commit();
                    System.out.println("✅ Product deleted successfully with ID: " + productId);
                    return true;
                } else {
                    // Rollback nếu không xóa được sản phẩm
                    connection.rollback();
                    System.out.println("❌ Product not found: " + productId);
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
            System.err.println("❌ Error deleting product: " + e.getMessage());
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
     * Kiểm tra tên sản phẩm đã tồn tại chưa
     */
    public boolean isProductNameExists(String name) {
        String sql = "SELECT COUNT(*) FROM products WHERE name = ?";
        
        try {
            if (connection == null) {
                System.err.println("❌ Database connection is null");
                return false;
            }
            
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, name);
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                boolean exists = rs.getInt(1) > 0;
                rs.close();
                ps.close();
                return exists;
            }
            
            rs.close();
            ps.close();
            
        } catch (SQLException e) {
            System.err.println("❌ Error checking product name exists: " + e.getMessage());
        }
        
        return false;
    }
    
    /**
     * Tìm kiếm sản phẩm theo tên
     */
    public List<Product> searchProductsByName(String keyword) {
        List<Product> products = new ArrayList<>();
        String sql = "SELECT * FROM products WHERE name LIKE ? ORDER BY name";
        
        try {
            if (connection == null) {
                System.err.println("❌ Database connection is null");
                return products;
            }
            
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, "%" + keyword + "%");
            ResultSet rs = ps.executeQuery();
            
            while (rs.next()) {
                Product product = new Product();
                product.setId(rs.getInt("id"));
                product.setName(rs.getString("name"));
                product.setPrice(rs.getDouble("price"));
                product.setDescription(rs.getString("description"));
                product.setImage(rs.getString("image"));
                
                products.add(product);
            }
            
            rs.close();
            ps.close();
            
            System.out.println("✅ Found " + products.size() + " products matching: " + keyword);
            
        } catch (SQLException e) {
            System.err.println("❌ Error searching products: " + e.getMessage());
        }
        
        return products;
    }
    
    /**
     * Lấy sản phẩm theo khoảng giá
     */
    public List<Product> getProductsByPriceRange(double minPrice, double maxPrice) {
        List<Product> products = new ArrayList<>();
        String sql = "SELECT * FROM products WHERE price BETWEEN ? AND ? ORDER BY price";
        
        try {
            if (connection == null) {
                System.err.println("❌ Database connection is null");
                return products;
            }
            
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setDouble(1, minPrice);
            ps.setDouble(2, maxPrice);
            ResultSet rs = ps.executeQuery();
            
            while (rs.next()) {
                Product product = new Product();
                product.setId(rs.getInt("id"));
                product.setName(rs.getString("name"));
                product.setPrice(rs.getDouble("price"));
                product.setDescription(rs.getString("description"));
                product.setImage(rs.getString("image"));
                
                products.add(product);
            }
            
            rs.close();
            ps.close();
            
        } catch (SQLException e) {
            System.err.println("❌ Error getting products by price range: " + e.getMessage());
        }
        
        return products;
    }
    
    /**
     * Đếm tổng số sản phẩm
     */
    public int getTotalProducts() {
        String sql = "SELECT COUNT(*) FROM products";
        
        try {
            if (connection == null) {
                System.err.println("❌ Database connection is null");
                return 0;
            }
            
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                int count = rs.getInt(1);
                rs.close();
                ps.close();
                return count;
            }
            
            rs.close();
            ps.close();
            
        } catch (SQLException e) {
            System.err.println("❌ Error counting products: " + e.getMessage());
        }
        
        return 0;
    }
    
    /**
     * Dữ liệu sản phẩm mẫu (fallback khi lỗi database)
     */
    private List<Product> getFallbackProducts() {
        List<Product> products = new ArrayList<>();
        products.add(new Product(1, "iPhone 15 Pro", 34990000, "Flagship mới nhất từ Apple với chip A17 Pro", "https://cdn.tgdd.vn/Products/Images/42/305658/iphone-15-pro-natural-titanium-1-2.jpg"));
        products.add(new Product(2, "Samsung Galaxy S24 Ultra", 29990000, "Camera siêu nét với S Pen tích hợp", "https://cdn.tgdd.vn/Products/Images/42/307174/samsung-galaxy-s24-ultra-grey-1-2.jpg"));
        products.add(new Product(3, "iPad Pro M4", 25990000, "Màn hình Liquid Retina XDR với chip M4", "https://cdn.tgdd.vn/Products/Images/522/329149/ipad-pro-13-inch-m4-wifi-silver-1-2.jpg"));
        products.add(new Product(4, "MacBook Air M3", 28990000, "Mỏng nhẹ, hiệu năng mạnh mẽ", "https://cdn.tgdd.vn/Products/Images/44/309017/macbook-air-13-inch-m3-2024-midnight-1-2.jpg"));
        products.add(new Product(5, "iPhone 14 Pro Max", 31990000, "iPhone 14 Pro Max với Dynamic Island", "/images/iphone14promax.jpg"));
        products.add(new Product(6, "Galaxy Watch 6", 7990000, "Smartwatch cao cấp từ Samsung", "/images/galaxywatch6.jpg"));
        products.add(new Product(7, "AirPods Pro 2", 6990000, "Tai nghe không dây với chống ồn chủ động", "/images/airpodspro2.jpg"));
        products.add(new Product(8, "iPad Air M2", 18990000, "iPad Air với chip M2 mạnh mẽ", "/images/ipadair.jpg"));
        
        System.out.println("🔄 Using fallback product data (" + products.size() + " products)");
        return products;
    }
    
    /**
     * Lấy sản phẩm fallback theo ID
     */
    private Product getFallbackProductById(int id) {
        List<Product> products = getFallbackProducts();
        for (Product product : products) {
            if (product.getId() == id) {
                return product;
            }
        }
        return null;
    }
}