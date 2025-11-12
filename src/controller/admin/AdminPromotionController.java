package controller.admin;

import model.Promotion;
import model.User;
import service.PromotionService;
import service.impl.PromotionServiceImpl;
import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Date;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 * Admin Promotion Controller
 * Điều khiển quản lý khuyến mãi
 */
@WebServlet("/admin/promotions")
public class AdminPromotionController extends HttpServlet {
    
    private PromotionService promotionService;
    
    @Override
    public void init() throws ServletException {
        promotionService = new PromotionServiceImpl();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        if (user == null || !user.isAdmin()) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        String action = request.getParameter("action");
        
        if ("edit".equals(action)) {
            String promoId = request.getParameter("id");
            if (promoId != null) {
                Promotion promotion = promotionService.getPromotionById(Integer.parseInt(promoId));
                request.setAttribute("promotion", promotion);
            }
            request.getRequestDispatcher("/WEB-INF/view/admin/PromotionForm.jsp").forward(request, response);
        } else {
            request.setAttribute("promotions", promotionService.getAllPromotions());
            request.getRequestDispatcher("/WEB-INF/view/admin/PromotionManagement.jsp").forward(request, response);
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        if (user == null || !user.isAdmin()) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        String action = request.getParameter("action");
        
        if ("create".equals(action) || "update".equals(action)) {
            String promoId = request.getParameter("promoId");
            String promoCode = request.getParameter("promoCode");
            String discountPercent = request.getParameter("discountPercent");
            String startDate = request.getParameter("startDate");
            String endDate = request.getParameter("endDate");
            String description = request.getParameter("description");
            String isActive = request.getParameter("isActive");
            
            Promotion promotion = new Promotion();
            promotion.setPromoCode(promoCode);
            promotion.setDiscountPercent(new BigDecimal(discountPercent));
            promotion.setStartDate(Date.valueOf(startDate));
            promotion.setEndDate(Date.valueOf(endDate));
            promotion.setDescription(description);
            promotion.setActive(isActive != null && "on".equals(isActive));
            
            boolean success = false;
            if ("update".equals(action) && promoId != null && !promoId.isEmpty()) {
                promotion.setPromoId(Integer.parseInt(promoId));
                success = promotionService.updatePromotion(promotion);
            } else {
                success = promotionService.createPromotion(promotion);
            }
            
            if (success) {
                response.sendRedirect(request.getContextPath() + "/admin/promotions?success=true");
            } else {
                request.setAttribute("error", "Lỗi khi lưu khuyến mãi!");
                request.getRequestDispatcher("/WEB-INF/view/admin/PromotionForm.jsp").forward(request, response);
            }
        } else if ("delete".equals(action)) {
            String promoId = request.getParameter("id");
            if (promoId != null) {
                promotionService.deletePromotion(Integer.parseInt(promoId));
            }
            response.sendRedirect(request.getContextPath() + "/admin/promotions");
        }
    }
}

