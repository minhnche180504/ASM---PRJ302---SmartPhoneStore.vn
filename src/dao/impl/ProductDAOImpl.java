package dao.impl;

import dao.ProductDAO;
import model.Product;
import util.DBConnection;
import java.math.BigDecimal;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * Product DAO Implementation
 * Triển khai DAO cho sản phẩm
 */
public class ProductDAOImpl implements ProductDAO {
    
    @Override
    public Product getProductById(int pId) {
        String sql = "SELECT p.*, c.cat_name FROM products p " +
                     "LEFT JOIN categories c ON p.cat_id = c.cat_id WHERE p.p_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, pId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return mapResultSetToProduct(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    
    @Override
    public List<Product> getAllProducts() {
        List<Product> products = new ArrayList<>();
        String sql = "SELECT p.*, c.cat_name FROM products p " +
                     "LEFT JOIN categories c ON p.cat_id = c.cat_id ORDER BY p.created_at DESC";
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                products.add(mapResultSetToProduct(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return products;
    }
    
    @Override
    public List<Product> getProductsByCategory(int catId) {
        List<Product> products = new ArrayList<>();
        String sql = "SELECT p.*, c.cat_name FROM products p " +
                     "LEFT JOIN categories c ON p.cat_id = c.cat_id WHERE p.cat_id = ? ORDER BY p.created_at DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, catId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                products.add(mapResultSetToProduct(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return products;
    }
    
    @Override
    public List<Product> getProductsByBrand(String brand) {
        List<Product> products = new ArrayList<>();
        String sql = "SELECT p.*, c.cat_name FROM products p " +
                     "LEFT JOIN categories c ON p.cat_id = c.cat_id WHERE p.brand = ? ORDER BY p.created_at DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, brand);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                products.add(mapResultSetToProduct(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return products;
    }
    
    @Override
    public List<Product> searchProducts(String keyword) {
        List<Product> products = new ArrayList<>();
        String sql = "SELECT p.*, c.cat_name FROM products p " +
                     "LEFT JOIN categories c ON p.cat_id = c.cat_id " +
                     "WHERE p.p_name LIKE ? OR p.brand LIKE ? OR p.description LIKE ? ORDER BY p.created_at DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            String searchPattern = "%" + keyword + "%";
            ps.setString(1, searchPattern);
            ps.setString(2, searchPattern);
            ps.setString(3, searchPattern);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                products.add(mapResultSetToProduct(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return products;
    }
    
    @Override
    public List<Product> getProductsByPriceRange(BigDecimal minPrice, BigDecimal maxPrice) {
        List<Product> products = new ArrayList<>();
        String sql = "SELECT p.*, c.cat_name FROM products p " +
                     "LEFT JOIN categories c ON p.cat_id = c.cat_id " +
                     "WHERE p.price BETWEEN ? AND ? ORDER BY p.price";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setBigDecimal(1, minPrice);
            ps.setBigDecimal(2, maxPrice);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                products.add(mapResultSetToProduct(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return products;
    }
    
    @Override
    public List<Product> getBestSellers(int limit) {
        List<Product> products = new ArrayList<>();
        String sql = "SELECT p.*, c.cat_name, SUM(oi.quantity) as total_sold FROM products p " +
                     "LEFT JOIN categories c ON p.cat_id = c.cat_id " +
                     "LEFT JOIN order_items oi ON p.p_id = oi.product_id " +
                     "GROUP BY p.p_id ORDER BY total_sold DESC LIMIT ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, limit);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                products.add(mapResultSetToProduct(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return products;
    }
    
    @Override
    public boolean createProduct(Product product) {
        String sql = "INSERT INTO products (p_name, brand, price, stock, description, image_url, cat_id) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, product.getPName());
            ps.setString(2, product.getBrand());
            ps.setBigDecimal(3, product.getPrice());
            ps.setInt(4, product.getStock());
            ps.setString(5, product.getDescription());
            ps.setString(6, product.getImageUrl());
            ps.setInt(7, product.getCatId());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    @Override
    public boolean updateProduct(Product product) {
        String sql = "UPDATE products SET p_name = ?, brand = ?, price = ?, stock = ?, description = ?, image_url = ?, cat_id = ? WHERE p_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, product.getPName());
            ps.setString(2, product.getBrand());
            ps.setBigDecimal(3, product.getPrice());
            ps.setInt(4, product.getStock());
            ps.setString(5, product.getDescription());
            ps.setString(6, product.getImageUrl());
            ps.setInt(7, product.getCatId());
            ps.setInt(8, product.getPId());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    @Override
    public boolean deleteProduct(int pId) {
        String sql = "DELETE FROM products WHERE p_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, pId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    @Override
    public boolean updateStock(int pId, int quantity) {
        String sql = "UPDATE products SET stock = stock - ? WHERE p_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, quantity);
            ps.setInt(2, pId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    private Product mapResultSetToProduct(ResultSet rs) throws SQLException {
        Product product = new Product();
        product.setPId(rs.getInt("p_id"));
        product.setPName(rs.getString("p_name"));
        product.setBrand(rs.getString("brand"));
        product.setPrice(rs.getBigDecimal("price"));
        product.setStock(rs.getInt("stock"));
        product.setDescription(rs.getString("description"));
        product.setImageUrl(rs.getString("image_url"));
        product.setCatId(rs.getInt("cat_id"));
        product.setCatName(rs.getString("cat_name"));
        product.setCreatedAt(rs.getTimestamp("created_at"));
        product.setUpdatedAt(rs.getTimestamp("updated_at"));
        return product;
    }
}

