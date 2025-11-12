package controller;

import model.Product;
import service.ProductService;
import service.impl.ProductServiceImpl;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * Product Detail Controller
 * Điều khiển trang chi tiết sản phẩm
 */
@WebServlet("/product-detail")
public class ProductDetailController extends HttpServlet {
    
    private ProductService productService;
    
    @Override
    public void init() throws ServletException {
        productService = new ProductServiceImpl();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String productId = request.getParameter("id");
            if (productId == null || productId.isEmpty()) {
                response.sendRedirect(request.getContextPath() + "/products");
                return;
            }
            
            Product product = productService.getProductById(Integer.parseInt(productId));
            if (product == null) {
                response.sendRedirect(request.getContextPath() + "/products");
                return;
            }
            
            request.setAttribute("product", product);
            request.getRequestDispatcher("/WEB-INF/view/public/ProductDetail.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }
}

