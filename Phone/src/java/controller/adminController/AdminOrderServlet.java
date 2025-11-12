package controller;

import dao.OrderDAO;
import model.Order;
import model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "AdminOrderServlet", urlPatterns = {
    "/admin/orders", 
    "/Admin/Orders"
})
public class AdminOrderServlet extends HttpServlet {
    
    private OrderDAO orderDAO;
    
    @Override
    public void init() throws ServletException {
        orderDAO = new OrderDAO();
        System.out.println("🔧 AdminOrderServlet initialized");
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        System.out.println("👨‍💼 AdminOrderServlet called");
        
        // Kiểm tra quyền admin
        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("user");
        
        if (currentUser == null) {
            System.out.println("❌ User not logged in, redirecting to login");
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        if (!"ADMIN".equals(currentUser.getRole())) {
            System.out.println("❌ User not admin: " + currentUser.getRole());
            response.sendRedirect(request.getContextPath() + "/home");
            return;
        }
        
        try {
            // Load danh sách đơn hàng từ database
            List<Order> orders = orderDAO.getAllOrders();
            System.out.println("✅ Loaded " + orders.size() + " orders for admin");
            
            // Set data vào request
            request.setAttribute("orders", orders);
            request.setAttribute("currentUser", currentUser);
            
            // Lấy thông báo từ session (nếu có)
            String messageType = (String) session.getAttribute("messageType");
            String message = (String) session.getAttribute("message");
            
            if (message != null) {
                request.setAttribute("messageType", messageType);
                request.setAttribute("message", message);
                
                // Xóa thông báo khỏi session sau khi đã sử dụng
                session.removeAttribute("messageType");
                session.removeAttribute("message");
            }
            
            // Forward to JSP
            request.getRequestDispatcher("/admin/adminOrders.jsp").forward(request, response);
            
        } catch (Exception e) {
            System.err.println("❌ Error loading orders: " + e.getMessage());
            e.printStackTrace();
            
            // Set error message
            request.setAttribute("error", "Có lỗi xảy ra khi tải danh sách đơn hàng: " + e.getMessage());
            request.getRequestDispatcher("/admin/adminOrders.jsp").forward(request, response);
        }
    }
    
    @Override
    public void destroy() {
        if (orderDAO != null) {
            orderDAO.closeConnection();
        }
        System.out.println("🔧 AdminOrderServlet destroyed");
    }
}