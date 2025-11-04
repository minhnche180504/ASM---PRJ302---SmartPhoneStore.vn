package controller;

import dao.ProductDAO;
import model.Product;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/addToCart")
public class AddToCartServlet extends HttpServlet {
    
    private ProductDAO productDAO = new ProductDAO();
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Lấy productId từ form
        String productIdStr = request.getParameter("productId");
        
        if (productIdStr != null && !productIdStr.trim().isEmpty()) {
            try {
                int productId = Integer.parseInt(productIdStr);
                
                // Lấy session để lưu giỏ hàng
                HttpSession session = request.getSession();
                
                // Lấy giỏ hàng từ session (nếu chưa có thì tạo mới)
                @SuppressWarnings("unchecked")
                List<Product> cart = (List<Product>) session.getAttribute("cart");
                if (cart == null) {
                    cart = new ArrayList<>();
                    session.setAttribute("cart", cart);
                }
                
                // Tìm sản phẩm theo ID từ database
                Product product = productDAO.getProductById(productId);
                if (product != null) {
                    // Thêm sản phẩm vào giỏ hàng
                    cart.add(product);
                    
                    // Set thông báo thành công
                    session.setAttribute("cartMessage", "Đã thêm " + product.getName() + " vào giỏ hàng!");
                    session.setAttribute("cartMessageType", "success");
                } else {
                    session.setAttribute("cartMessage", "Không tìm thấy sản phẩm!");
                    session.setAttribute("cartMessageType", "error");
                }
                
            } catch (NumberFormatException e) {
                HttpSession session = request.getSession();
                session.setAttribute("cartMessage", "ID sản phẩm không hợp lệ!");
                session.setAttribute("cartMessageType", "error");
            } catch (Exception e) {
                System.err.println("Lỗi trong AddToCartServlet: " + e.getMessage());
                e.printStackTrace();
                
                HttpSession session = request.getSession();
                session.setAttribute("cartMessage", "Có lỗi xảy ra khi thêm sản phẩm vào giỏ hàng!");
                session.setAttribute("cartMessageType", "error");
            }
        } else {
            HttpSession session = request.getSession();
            session.setAttribute("cartMessage", "Thiếu thông tin sản phẩm!");
            session.setAttribute("cartMessageType", "error");
        }
        
        // Redirect về trang home (tránh resubmit form)
        response.sendRedirect(request.getContextPath() + "/home");
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // GET request chuyển về home
        response.sendRedirect(request.getContextPath() + "/home");
    }
}