package controller;

import model.CartItem;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

/**
 * Servlet xử lý cập nhật số lượng sản phẩm trong giỏ hàng
 * 
 * Chức năng:
 * - Tăng số lượng sản phẩm (+1)
 * - Giảm số lượng sản phẩm (-1, tối thiểu 1)
 * - Set số lượng cụ thể
 * 
 * URL Pattern: /cart/updateQuantity
 * Parameters:
 * - index: Index của sản phẩm trong giỏ hàng (required)
 * - action: "increase" hoặc "decrease" (required)
 * 
 * @author SmartPhone Store Team
 * @version 1.0
 */
@WebServlet(name = "UpdateQuantityServlet", urlPatterns = {
    "/cart/updateQuantity"
})
public class UpdateQuantityServlet extends HttpServlet {
    
    /**
     * Xử lý POST request - Cập nhật số lượng
     * 
     * @param request HttpServletRequest
     * @param response HttpServletResponse
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Set encoding
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        
        HttpSession session = request.getSession();
        
        try {
            // Lấy parameters từ request
            String indexParam = request.getParameter("index");
            String action = request.getParameter("action");
            
            // Validate parameters
            if (indexParam == null || action == null) {
                session.setAttribute("cartMessage", "Thông tin không hợp lệ!");
                session.setAttribute("cartMessageType", "error");
                response.sendRedirect(request.getContextPath() + "/cart");
                return;
            }
            
            int index = Integer.parseInt(indexParam);
            
            // Lấy giỏ hàng từ session
            @SuppressWarnings("unchecked")
            List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
            
            if (cart == null || index < 0 || index >= cart.size()) {
                session.setAttribute("cartMessage", "Sản phẩm không tồn tại trong giỏ hàng!");
                session.setAttribute("cartMessageType", "error");
                response.sendRedirect(request.getContextPath() + "/cart");
                return;
            }
            
            // Lấy cart item
            CartItem item = cart.get(index);
            
            // Xử lý action
            switch (action) {
                case "increase":
                    item.incrementQuantity();
                    System.out.println("✅ Increased quantity for: " + item.getProduct().getName() + " to " + item.getQuantity());
                    break;
                    
                case "decrease":
                    item.decrementQuantity();
                    System.out.println("✅ Decreased quantity for: " + item.getProduct().getName() + " to " + item.getQuantity());
                    break;
                    
                default:
                    session.setAttribute("cartMessage", "Hành động không hợp lệ!");
                    session.setAttribute("cartMessageType", "error");
                    response.sendRedirect(request.getContextPath() + "/cart");
                    return;
            }
            
            // Cập nhật session
            session.setAttribute("cart", cart);
            
            // Redirect về trang cart
            response.sendRedirect(request.getContextPath() + "/cart");
            
        } catch (NumberFormatException e) {
            System.err.println("❌ Invalid index format: " + e.getMessage());
            session.setAttribute("cartMessage", "Thông tin không hợp lệ!");
            session.setAttribute("cartMessageType", "error");
            response.sendRedirect(request.getContextPath() + "/cart");
        } catch (Exception e) {
            System.err.println("❌ Error updating quantity: " + e.getMessage());
            e.printStackTrace();
            session.setAttribute("cartMessage", "Có lỗi xảy ra: " + e.getMessage());
            session.setAttribute("cartMessageType", "error");
            response.sendRedirect(request.getContextPath() + "/cart");
        }
    }
    
    /**
     * Cho phép GET request redirect về POST
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request, response);
    }
}

