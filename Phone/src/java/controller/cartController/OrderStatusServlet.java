package controller;

import dao.OrderDAO;
import model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(name = "OrderStatusServlet", urlPatterns = {
    "/admin/orders/updateStatus"
})
public class OrderStatusServlet extends HttpServlet {
    
    private OrderDAO orderDAO;
    
    @Override
    public void init() throws ServletException {
        orderDAO = new OrderDAO();
        System.out.println("🔧 OrderStatusServlet initialized");
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Set encoding
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        
        // Kiểm tra quyền admin
        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("user");
        
        if (currentUser == null || !"ADMIN".equals(currentUser.getRole())) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        try {
            String orderIdStr = request.getParameter("orderId");
            String newStatus = request.getParameter("status");
            
            if (orderIdStr == null || newStatus == null) {
                setMessage(session, "error", "Thông tin không hợp lệ!");
                response.sendRedirect(request.getContextPath() + "/admin/orders");
                return;
            }
            
            int orderId = Integer.parseInt(orderIdStr);
            
            // Validate status
            if (!"Pending".equals(newStatus) && !"Completed".equals(newStatus) && !"Cancelled".equals(newStatus)) {
                setMessage(session, "error", "Trạng thái không hợp lệ!");
                response.sendRedirect(request.getContextPath() + "/admin/orders");
                return;
            }
            
            boolean success = orderDAO.updateOrderStatus(orderId, newStatus);
            
            if (success) {
                String statusText = "";
                switch (newStatus) {
                    case "Completed":
                        statusText = "hoàn thành";
                        break;
                    case "Cancelled":
                        statusText = "hủy";
                        break;
                    default:
                        statusText = "cập nhật";
                }
                
                System.out.println("✅ Order status updated: " + orderId + " -> " + newStatus);
                setMessage(session, "success", "Đã " + statusText + " đơn hàng #" + orderId + " thành công!");
            } else {
                setMessage(session, "error", "Có lỗi xảy ra khi cập nhật trạng thái đơn hàng!");
            }
            
        } catch (NumberFormatException e) {
            setMessage(session, "error", "ID đơn hàng không hợp lệ!");
        } catch (Exception e) {
            System.err.println("❌ Error updating order status: " + e.getMessage());
            e.printStackTrace();
            setMessage(session, "error", "Có lỗi xảy ra: " + e.getMessage());
        }
        
        response.sendRedirect(request.getContextPath() + "/admin/orders");
    }
    
    private void setMessage(HttpSession session, String type, String message) {
        session.setAttribute("messageType", type);
        session.setAttribute("message", message);
    }
    
    @Override
    public void destroy() {
        if (orderDAO != null) {
            orderDAO.closeConnection();
        }
        System.out.println("🔧 OrderStatusServlet destroyed");
    }
}