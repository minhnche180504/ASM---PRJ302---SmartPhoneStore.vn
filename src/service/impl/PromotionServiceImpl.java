package service.impl;

import dao.PromotionDAO;
import dao.impl.PromotionDAOImpl;
import model.Promotion;
import service.PromotionService;
import java.math.BigDecimal;
import java.util.List;

/**
 * Promotion Service Implementation
 * Triển khai Service cho khuyến mãi
 */
public class PromotionServiceImpl implements PromotionService {
    
    private PromotionDAO promotionDAO;
    
    public PromotionServiceImpl() {
        this.promotionDAO = new PromotionDAOImpl();
    }
    
    @Override
    public Promotion getPromotionById(int promoId) {
        return promotionDAO.getPromotionById(promoId);
    }
    
    @Override
    public Promotion getPromotionByCode(String promoCode) {
        return promotionDAO.getPromotionByCode(promoCode);
    }
    
    @Override
    public List<Promotion> getAllPromotions() {
        return promotionDAO.getAllPromotions();
    }
    
    @Override
    public List<Promotion> getActivePromotions() {
        return promotionDAO.getActivePromotions();
    }
    
    @Override
    public boolean createPromotion(Promotion promotion) {
        return promotionDAO.createPromotion(promotion);
    }
    
    @Override
    public boolean updatePromotion(Promotion promotion) {
        return promotionDAO.updatePromotion(promotion);
    }
    
    @Override
    public boolean deletePromotion(int promoId) {
        return promotionDAO.deletePromotion(promoId);
    }
    
    @Override
    public BigDecimal calculateDiscount(String promoCode, BigDecimal totalAmount) {
        Promotion promotion = promotionDAO.getPromotionByCode(promoCode);
        if (promotion != null && promotion.isValid()) {
            BigDecimal discount = totalAmount.multiply(promotion.getDiscountPercent())
                    .divide(new BigDecimal("100"));
            return discount;
        }
        return BigDecimal.ZERO;
    }
}

