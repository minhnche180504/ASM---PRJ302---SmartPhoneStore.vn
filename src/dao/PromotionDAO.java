package dao;

import model.Promotion;
import java.util.List;

/**
 * Promotion DAO Interface
 * Giao diện DAO cho khuyến mãi
 */
public interface PromotionDAO {
    Promotion getPromotionById(int promoId);
    Promotion getPromotionByCode(String promoCode);
    List<Promotion> getAllPromotions();
    List<Promotion> getActivePromotions();
    boolean createPromotion(Promotion promotion);
    boolean updatePromotion(Promotion promotion);
    boolean deletePromotion(int promoId);
}

