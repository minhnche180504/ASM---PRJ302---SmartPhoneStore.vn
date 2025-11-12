package controller;

import dao.ProductDAO;
import model.Product;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "ProductDetailServlet", urlPatterns = {"/products/detail", "/productDetail"})
public class ProductDetailServlet extends HttpServlet {
    
    private ProductDAO productDAO = new ProductDAO();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String productIdStr = request.getParameter("id");
        
        if (productIdStr != null && !productIdStr.trim().isEmpty()) {
            try {
                int productId = Integer.parseInt(productIdStr);
                
                // Lấy sản phẩm từ database
                Product product = productDAO.getProductById(productId);
                
                if (product != null) {
                    // Đặt sản phẩm vào request
                    request.setAttribute("product", product);
                } else {
                    request.setAttribute("error", "Không tìm thấy sản phẩm với ID: " + productId);
                }
                
            } catch (NumberFormatException e) {
                request.setAttribute("error", "ID sản phẩm không hợp lệ: " + productIdStr);
            } catch (Exception e) {
                System.err.println("Lỗi trong ProductDetailServlet: " + e.getMessage());
                e.printStackTrace();
                request.setAttribute("error", "Có lỗi xảy ra khi tải thông tin sản phẩm!");
            }
        } else {
            request.setAttribute("error", "Thiếu thông tin ID sản phẩm!");
        }
        
        // Chuyển tiếp đến trang JSP
        request.getRequestDispatcher("productDetail.jsp").forward(request, response);
    }
}