package controller.cartController;

import model.Product;
import model.CartItem;
import model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

/**
 * Servlet xử lý trang thanh toán
 * Kiểm tra đăng nhập, giỏ hàng và hiển thị form checkout
 * 
 * @author SmartPhone Store Team
 * @version 2.0 (Updated to support CartItem)
 */
@WebServlet(name = "CheckoutServlet", urlPatterns = {
    "/checkout",
    "/cart/checkout"
})
public class CheckoutServlet extends HttpServlet {
    
    /**
     * Xử lý GET request - Hiển thị trang checkout
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("user");
        
        // Bước 1: Kiểm tra đăng nhập
        if (currentUser == null) {
            session.setAttribute("cartMessage", "Vui lòng đăng nhập để tiếp tục thanh toán!");
            session.setAttribute("cartMessageType", "error");
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        // Bước 2: Lấy giỏ hàng và xử lý backward compatibility
        Object cartObj = session.getAttribute("cart");
        List<CartItem> cart = null;
        
        if (cartObj instanceof List) {
            @SuppressWarnings("unchecked")
            List<?> tempList = (List<?>) cartObj;
            
            if (!tempList.isEmpty()) {
                if (tempList.get(0) instanceof Product) {
                    // Convert từ format cũ sang format mới
                    cart = new ArrayList<>();
                    for (Object obj : tempList) {
                        cart.add(new CartItem((Product) obj, 1));
                    }
                    session.setAttribute("cart", cart); // Update session
                } else if (tempList.get(0) instanceof CartItem) {
                    @SuppressWarnings("unchecked")
                    List<CartItem> temp = (List<CartItem>) tempList;
                    cart = temp;
                }
            } else {
                cart = new ArrayList<>();
            }
        }
        
        // Bước 3: Kiểm tra giỏ hàng có sản phẩm không
        if (cart == null || cart.isEmpty()) {
            session.setAttribute("cartMessage", "Giỏ hàng trống! Vui lòng thêm sản phẩm trước khi thanh toán.");
            session.setAttribute("cartMessageType", "error");
            response.sendRedirect(request.getContextPath() + "/cart");
            return;
        }
        
        // Bước 4: Tính tổng tiền
        double total = 0;
        int totalItems = 0;
        for (CartItem item : cart) {
            total += item.getSubtotal();
            totalItems += item.getQuantity();
        }
        
        // Bước 5: Set attributes và forward đến trang checkout
        request.setAttribute("cart", cart);
        request.setAttribute("total", total);
        request.setAttribute("totalItems", totalItems);
        request.setAttribute("user", currentUser);
        
        // Forward đến trang checkout
        request.getRequestDispatcher("/cart/checkout.jsp").forward(request, response);
    }
    
    /**
     * Xử lý POST request - Forward đến OrderServlet để xử lý đặt hàng
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Set encoding để xử lý tiếng Việt
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        
        System.out.println("💳 CheckoutServlet.doPost() called - Forwarding to OrderServlet");
        
        // Form checkout gửi POST, forward đến OrderServlet để xử lý đơn hàng
        // OrderServlet xử lý tại /checkout/process
        try {
            request.getRequestDispatcher("/checkout/process").forward(request, response);
        } catch (Exception e) {
            System.err.println("❌ Error forwarding to OrderServlet: " + e.getMessage());
            e.printStackTrace();
            // Fallback: redirect về GET /checkout nếu có lỗi
            response.sendRedirect(request.getContextPath() + "/checkout");
        }
    }
}

