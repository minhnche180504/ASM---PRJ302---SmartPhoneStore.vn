package controller.adminController;

import dao.OrderDAO;
import dao.OrderItemDAO;
import model.Order;
import model.OrderItem;
import model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

/**
 * Servlet xử lý chi tiết và chỉnh sửa đơn hàng cho admin
 * 
 * Chức năng:
 * - Xem chi tiết đơn hàng (view mode)
 * - Chỉnh sửa thông tin đơn hàng (edit mode)
 * - Hiển thị danh sách sản phẩm trong đơn hàng
 * 
 * URL Pattern: /admin/orders/detail
 * Parameters:
 * - id: ID của đơn hàng (required)
 * - edit: Chế độ chỉnh sửa (optional, true/false)
 * 
 * @author SmartPhone Store Team
 * @version 1.0
 */
@WebServlet(name = "AdminOrderDetailServlet", urlPatterns = {
    "/admin/orders/detail"
})
public class AdminOrderDetailServlet extends HttpServlet {
    
    // DAO để thao tác với bảng orders
    private OrderDAO orderDAO;
    // DAO để thao tác với bảng order_items
    private OrderItemDAO orderItemDAO;
    
    /**
     * Khởi tạo servlet và các DAO objects
     */
    @Override
    public void init() throws ServletException {
        orderDAO = new OrderDAO();
        orderItemDAO = new OrderItemDAO();
        System.out.println("🔧 AdminOrderDetailServlet initialized");
    }
    
    /**
     * Xử lý GET request - Hiển thị chi tiết đơn hàng
     * 
     * Flow:
     * 1. Kiểm tra quyền admin
     * 2. Lấy order ID từ parameter
     * 3. Load thông tin order và order items từ database
     * 4. Kiểm tra chế độ view/edit
     * 5. Forward đến JSP để hiển thị
     * 
     * @param request HttpServletRequest
     * @param response HttpServletResponse
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Bước 1: Kiểm tra quyền admin
        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("user");
        
        if (currentUser == null || !"ADMIN".equals(currentUser.getRole())) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        try {
            // Bước 2: Lấy order ID từ parameter
            String idParam = request.getParameter("id");
            if (idParam == null || idParam.isEmpty()) {
                // Không có ID -> quay lại danh sách orders
                response.sendRedirect(request.getContextPath() + "/admin/orders");
                return;
            }
            
            int orderId = Integer.parseInt(idParam);
            
            // Bước 3: Lấy thông tin order từ database
            Order order = orderDAO.getOrderById(orderId);
            if (order == null) {
                // Order không tồn tại -> hiển thị lỗi và quay lại
                session.setAttribute("messageType", "danger");
                session.setAttribute("message", "Không tìm thấy đơn hàng!");
                response.sendRedirect(request.getContextPath() + "/admin/orders");
                return;
            }
            
            // Lấy danh sách sản phẩm trong order
            List<OrderItem> orderItems = orderItemDAO.getOrderItemsByOrderId(orderId);
            
            // Bước 4: Check xem có edit mode không
            String editParam = request.getParameter("edit");
            boolean editMode = "true".equals(editParam);
            
            // Bước 5: Set data vào request và forward to JSP
            request.setAttribute("order", order);
            request.setAttribute("orderItems", orderItems);
            request.setAttribute("editMode", editMode);
            request.setAttribute("currentUser", currentUser);
            
            // Forward đến trang chi tiết đơn hàng
            request.getRequestDispatcher("/admin/orderDetail.jsp").forward(request, response);
            
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/admin/orders");
        } catch (Exception e) {
            System.err.println("❌ Error loading order detail: " + e.getMessage());
            e.printStackTrace();
            session.setAttribute("messageType", "danger");
            session.setAttribute("message", "Có lỗi xảy ra: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/admin/orders");
        }
    }
    
    /**
     * Xử lý POST request - Cập nhật thông tin đơn hàng
     * 
     * Flow:
     * 1. Kiểm tra quyền admin
     * 2. Lấy dữ liệu từ form
     * 3. Validate dữ liệu
     * 4. Cập nhật vào database
     * 5. Redirect về trang chi tiết với thông báo
     * 
     * @param request HttpServletRequest chứa form data
     * @param response HttpServletResponse
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Set encoding để xử lý tiếng Việt
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        
        // Bước 1: Kiểm tra quyền admin
        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("user");
        
        if (currentUser == null || !"ADMIN".equals(currentUser.getRole())) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        try {
            // Bước 2: Lấy thông tin từ form
            int orderId = Integer.parseInt(request.getParameter("orderId"));
            String status = request.getParameter("status");
            String customerName = request.getParameter("customerName");
            String customerPhone = request.getParameter("customerPhone");
            String customerAddress = request.getParameter("customerAddress");
            
            // Bước 3: Validate dữ liệu
            if (status == null || status.trim().isEmpty()) {
                // Trạng thái bắt buộc phải có
                session.setAttribute("messageType", "danger");
                session.setAttribute("message", "Vui lòng chọn trạng thái!");
                response.sendRedirect(request.getContextPath() + "/admin/orders/detail?id=" + orderId + "&edit=true");
                return;
            }
            
            // Bước 4: Lấy order từ database và cập nhật thông tin
            Order order = orderDAO.getOrderById(orderId);
            if (order == null) {
                // Order không tồn tại
                session.setAttribute("messageType", "danger");
                session.setAttribute("message", "Không tìm thấy đơn hàng!");
                response.sendRedirect(request.getContextPath() + "/admin/orders");
                return;
            }
            
            // Cập nhật các trường có thể thay đổi
            order.setStatus(status);
            order.setCustomerName(customerName);
            order.setCustomerPhone(customerPhone);
            order.setCustomerAddress(customerAddress);
            
            // Thực hiện update vào database
            boolean success = orderDAO.updateOrder(order);
            
            // Bước 5: Redirect với thông báo kết quả
            if (success) {
                // Cập nhật thành công -> về trang view mode
                session.setAttribute("messageType", "success");
                session.setAttribute("message", "Cập nhật đơn hàng thành công!");
                response.sendRedirect(request.getContextPath() + "/admin/orders/detail?id=" + orderId);
            } else {
                // Cập nhật thất bại -> quay lại edit mode
                session.setAttribute("messageType", "danger");
                session.setAttribute("message", "Cập nhật đơn hàng thất bại!");
                response.sendRedirect(request.getContextPath() + "/admin/orders/detail?id=" + orderId + "&edit=true");
            }
            
        } catch (Exception e) {
            System.err.println("❌ Error updating order: " + e.getMessage());
            e.printStackTrace();
            session.setAttribute("messageType", "danger");
            session.setAttribute("message", "Có lỗi xảy ra: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/admin/orders");
        }
    }
    
    /**
     * Dọn dẹp resources khi servlet bị destroy
     * Đóng các kết nối database
     */
    @Override
    public void destroy() {
        if (orderDAO != null) {
            orderDAO.closeConnection();
        }
        if (orderItemDAO != null) {
            orderItemDAO.closeConnection();
        }
        System.out.println("🔧 AdminOrderDetailServlet destroyed");
    }
}

