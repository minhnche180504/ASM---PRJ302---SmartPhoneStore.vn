package dao.impl;

import dao.PromotionDAO;
import model.Promotion;
import util.DBConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * Promotion DAO Implementation
 * Triển khai DAO cho khuyến mãi
 */
public class PromotionDAOImpl implements PromotionDAO {
    
    @Override
    public Promotion getPromotionById(int promoId) {
        String sql = "SELECT * FROM promotions WHERE promo_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, promoId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return mapResultSetToPromotion(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    
    @Override
    public Promotion getPromotionByCode(String promoCode) {
        String sql = "SELECT * FROM promotions WHERE promo_code = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, promoCode);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return mapResultSetToPromotion(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    
    @Override
    public List<Promotion> getAllPromotions() {
        List<Promotion> promotions = new ArrayList<>();
        String sql = "SELECT * FROM promotions ORDER BY created_at DESC";
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                promotions.add(mapResultSetToPromotion(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return promotions;
    }
    
    @Override
    public List<Promotion> getActivePromotions() {
        List<Promotion> promotions = new ArrayList<>();
        String sql = "SELECT * FROM promotions WHERE is_active = TRUE AND start_date <= CURDATE() AND end_date >= CURDATE() ORDER BY created_at DESC";
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                promotions.add(mapResultSetToPromotion(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return promotions;
    }
    
    @Override
    public boolean createPromotion(Promotion promotion) {
        String sql = "INSERT INTO promotions (promo_code, discount_percent, start_date, end_date, description, is_active) VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, promotion.getPromoCode());
            ps.setBigDecimal(2, promotion.getDiscountPercent());
            ps.setDate(3, promotion.getStartDate());
            ps.setDate(4, promotion.getEndDate());
            ps.setString(5, promotion.getDescription());
            ps.setBoolean(6, promotion.isActive());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    @Override
    public boolean updatePromotion(Promotion promotion) {
        String sql = "UPDATE promotions SET promo_code = ?, discount_percent = ?, start_date = ?, end_date = ?, description = ?, is_active = ? WHERE promo_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, promotion.getPromoCode());
            ps.setBigDecimal(2, promotion.getDiscountPercent());
            ps.setDate(3, promotion.getStartDate());
            ps.setDate(4, promotion.getEndDate());
            ps.setString(5, promotion.getDescription());
            ps.setBoolean(6, promotion.isActive());
            ps.setInt(7, promotion.getPromoId());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    @Override
    public boolean deletePromotion(int promoId) {
        String sql = "DELETE FROM promotions WHERE promo_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, promoId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    private Promotion mapResultSetToPromotion(ResultSet rs) throws SQLException {
        Promotion promotion = new Promotion();
        promotion.setPromoId(rs.getInt("promo_id"));
        promotion.setPromoCode(rs.getString("promo_code"));
        promotion.setDiscountPercent(rs.getBigDecimal("discount_percent"));
        promotion.setStartDate(rs.getDate("start_date"));
        promotion.setEndDate(rs.getDate("end_date"));
        promotion.setDescription(rs.getString("description"));
        promotion.setActive(rs.getBoolean("is_active"));
        promotion.setCreatedAt(rs.getTimestamp("created_at"));
        promotion.setUpdatedAt(rs.getTimestamp("updated_at"));
        return promotion;
    }
}

