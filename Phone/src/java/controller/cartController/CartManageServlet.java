package controller.cartController;

import model.Product;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "CartManageServlet", urlPatterns = {
    "/cart/remove",
    "/cart/clear"
})
public class CartManageServlet extends HttpServlet {
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String requestURI = request.getRequestURI();
        HttpSession session = request.getSession();
        
        try {
            if (requestURI.endsWith("/cart/remove")) {
                handleRemoveItem(request, session);
            } else if (requestURI.endsWith("/cart/clear")) {
                handleClearCart(session);
            }
        } catch (Exception e) {
            System.err.println("❌ Error in CartManageServlet: " + e.getMessage());
            e.printStackTrace();
            session.setAttribute("cartMessage", "Có lỗi xảy ra khi xử lý giỏ hàng!");
            session.setAttribute("cartMessageType", "error");
        }
        
        // Redirect về trang giỏ hàng
        response.sendRedirect(request.getContextPath() + "/cart");
    }
    
    private void handleRemoveItem(HttpServletRequest request, HttpSession session) {
        String productIndexStr = request.getParameter("productIndex");
        
        if (productIndexStr != null) {
            try {
                int productIndex = Integer.parseInt(productIndexStr);
                
                @SuppressWarnings("unchecked")
                List<Product> cart = (List<Product>) session.getAttribute("cart");
                
                if (cart != null && productIndex >= 0 && productIndex < cart.size()) {
                    Product removedProduct = cart.remove(productIndex);
                    
                    session.setAttribute("cart", cart);
                    session.setAttribute("cartMessage", "Đã xóa " + removedProduct.getName() + " khỏi giỏ hàng!");
                    session.setAttribute("cartMessageType", "success");
                    
                    System.out.println("✅ Removed product from cart: " + removedProduct.getName());
                } else {
                    session.setAttribute("cartMessage", "Sản phẩm không tồn tại trong giỏ hàng!");
                    session.setAttribute("cartMessageType", "error");
                }
                
            } catch (NumberFormatException e) {
                session.setAttribute("cartMessage", "Thông tin sản phẩm không hợp lệ!");
                session.setAttribute("cartMessageType", "error");
            }
        }
    }
    
    private void handleClearCart(HttpSession session) {
        @SuppressWarnings("unchecked")
        List<Product> cart = (List<Product>) session.getAttribute("cart");
        
        if (cart != null && !cart.isEmpty()) {
            int itemCount = cart.size();
            cart.clear();
            session.setAttribute("cart", cart);
            
            session.setAttribute("cartMessage", "Đã xóa " + itemCount + " sản phẩm khỏi giỏ hàng!");
            session.setAttribute("cartMessageType", "success");
            
            System.out.println("✅ Cleared cart: " + itemCount + " items removed");
        } else {
            session.setAttribute("cartMessage", "Giỏ hàng đã trống!");
            session.setAttribute("cartMessageType", "error");
        }
    }
}