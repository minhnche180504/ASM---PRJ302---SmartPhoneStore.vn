package controller;

import model.Product;
import model.Promotion;
import service.ProductService;
import service.PromotionService;
import service.impl.ProductServiceImpl;
import service.impl.PromotionServiceImpl;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * Home Controller
 * Điều khiển trang chủ
 */
@WebServlet("/home")
public class HomeController extends HttpServlet {
    
    private ProductService productService;
    private PromotionService promotionService;
    
    @Override
    public void init() throws ServletException {
        productService = new ProductServiceImpl();
        promotionService = new PromotionServiceImpl();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Get best sellers
            List<Product> bestSellers = productService.getBestSellers(8);
            request.setAttribute("bestSellers", bestSellers);
            
            // Get active promotions
            List<Promotion> promotions = promotionService.getActivePromotions();
            request.setAttribute("promotions", promotions);
            
            // Get all products for banner/promotion display
            List<Product> allProducts = productService.getAllProducts();
            request.setAttribute("allProducts", allProducts);
            
            request.getRequestDispatcher("/WEB-INF/view/public/Home.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }
}

