package service;

import model.Promotion;
import java.math.BigDecimal;
import java.util.List;

/**
 * Promotion Service Interface
 * Giao diện Service cho khuyến mãi
 */
public interface PromotionService {
    Promotion getPromotionById(int promoId);
    Promotion getPromotionByCode(String promoCode);
    List<Promotion> getAllPromotions();
    List<Promotion> getActivePromotions();
    boolean createPromotion(Promotion promotion);
    boolean updatePromotion(Promotion promotion);
    boolean deletePromotion(int promoId);
    BigDecimal calculateDiscount(String promoCode, BigDecimal totalAmount);
}

