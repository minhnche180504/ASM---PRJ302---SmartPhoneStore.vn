package controller;

import dao.OrderDAO;
import model.Order;
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
 * Servlet xử lý đặt hàng
 * Nhận thông tin từ form checkout, tạo đơn hàng và lưu vào database
 * 
 * @author SmartPhone Store Team
 * @version 2.0 (Updated to support CartItem)
 */
@WebServlet(name = "OrderServlet", urlPatterns = {
    "/order/place",
    "/checkout/process",
    "/cart/orderSuccess"
})
public class OrderServlet extends HttpServlet {
    
    /**
     * Xử lý POST request - Tạo đơn hàng mới
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Set encoding để xử lý tiếng Việt
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        
        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("user");
        
        // Bước 1: Kiểm tra đăng nhập
        if (currentUser == null) {
            session.setAttribute("cartMessage", "Vui lòng đăng nhập để đặt hàng!");
            session.setAttribute("cartMessageType", "error");
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        try {
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
                        session.setAttribute("cart", cart);
                    } else if (tempList.get(0) instanceof CartItem) {
                        @SuppressWarnings("unchecked")
                        List<CartItem> temp = (List<CartItem>) tempList;
                        cart = temp;
                    }
                } else {
                    cart = new ArrayList<>();
                }
            }
            
            // Kiểm tra giỏ hàng
            if (cart == null || cart.isEmpty()) {
                session.setAttribute("cartMessage", "Giỏ hàng trống, không thể đặt hàng!");
                session.setAttribute("cartMessageType", "error");
                response.sendRedirect(request.getContextPath() + "/cart");
                return;
            }
            
            // Bước 3: Lấy thông tin từ form checkout
            String customerName = request.getParameter("customerName");
            String customerPhone = request.getParameter("customerPhone");
            String customerEmail = request.getParameter("customerEmail");
            String customerAddress = request.getParameter("customerAddress");
            String orderNote = request.getParameter("orderNote");
            
            // Bước 4: Validate dữ liệu đầu vào
            if (customerName == null || customerName.trim().isEmpty()) {
                request.setAttribute("error", "Vui lòng nhập họ tên người nhận!");
                request.getRequestDispatcher("/cart/checkout.jsp").forward(request, response);
                return;
            }
            
            if (customerPhone == null || customerPhone.trim().isEmpty()) {
                request.setAttribute("error", "Vui lòng nhập số điện thoại!");
                request.getRequestDispatcher("/cart/checkout.jsp").forward(request, response);
                return;
            }
            
            if (customerAddress == null || customerAddress.trim().isEmpty()) {
                request.setAttribute("error", "Vui lòng nhập địa chỉ giao hàng!");
                request.getRequestDispatcher("/cart/checkout.jsp").forward(request, response);
                return;
            }
            
            // Bước 5: Validate format số điện thoại
            String phoneClean = customerPhone.trim().replaceAll("\\s+", "");
            if (!phoneClean.matches("^[0-9]{10,11}$")) {
                request.setAttribute("error", "Số điện thoại không hợp lệ! Vui lòng nhập 10-11 chữ số.");
                request.getRequestDispatcher("/cart/checkout.jsp").forward(request, response);
                return;
            }
            
            // Bước 6: Tính tổng tiền và tổng số lượng
            double total = 0;
            int totalItems = 0;
            StringBuilder orderDetails = new StringBuilder();
            
            // Convert CartItem sang Product cho OrderDAO (vì createOrder nhận List<Product>)
            List<Product> products = new ArrayList<>();
            for (CartItem item : cart) {
                total += item.getSubtotal();
                totalItems += item.getQuantity();
                
                // Thêm product vào list với số lượng tương ứng
                for (int i = 0; i < item.getQuantity(); i++) {
                    products.add(item.getProduct());
                }
                
                orderDetails.append("- ").append(item.getProduct().getName())
                           .append(" x").append(item.getQuantity())
                           .append(" (").append(String.format("%,.0f", item.getSubtotal()))
                           .append(" VND)\n");
            }
            
            // Bước 7: Tạo object Order
            Order order = new Order();
            order.setUserId(currentUser.getId());
            order.setUserName(currentUser.getUsername());
            order.setTotal(total);
            order.setStatus("Pending");
            order.setCustomerName(customerName.trim());
            order.setCustomerPhone(phoneClean);
            order.setCustomerAddress(customerAddress.trim());
            
            // Bước 8: Lưu vào database
            OrderDAO orderDAO = new OrderDAO();
            boolean success = orderDAO.createOrder(order, products);
            if (!success) {
                // Lưu thất bại - hiển thị lỗi
                request.setAttribute("error", "Có lỗi xảy ra khi lưu đơn hàng. Vui lòng thử lại hoặc liên hệ hỗ trợ!");
                request.getRequestDispatcher("/cart/checkout.jsp").forward(request, response);
                return;
            }
            
            // Bước 9: Xóa giỏ hàng sau khi đặt hàng thành công
            cart.clear();
            session.setAttribute("cart", cart);
            
            // Bước 10: Log đơn hàng để theo dõi và debug
            System.out.println("✅ Order placed successfully:");
            System.out.println("   Order ID: " + order.getId());
            System.out.println("   Customer: " + customerName + " (" + currentUser.getUsername() + ")");
            System.out.println("   Phone: " + phoneClean);
            System.out.println("   Total: " + String.format("%,.0f", total) + " VND");
            System.out.println("   Total Items: " + totalItems + " products");
            System.out.println("   Details:\n" + orderDetails.toString());
            
            // Bước 11: Set thông báo thành công
            session.setAttribute("orderSuccessMessage", 
                "Đặt hàng thành công! Mã đơn hàng: " + order.getId() + 
                ". Tổng tiền: " + String.format("%,.0f", total) + " VND. " +
                "Chúng tôi sẽ liên hệ với bạn trong thời gian sớm nhất!");
            
            // Bước 12: Chuyển đến trang xác nhận đơn hàng
            response.sendRedirect(request.getContextPath() + "/cart/orderSuccess");
            
        } catch (Exception e) {
            System.err.println("❌ Error processing order: " + e.getMessage());
            e.printStackTrace();
            
            request.setAttribute("error", "Có lỗi xảy ra khi xử lý đơn hàng: " + e.getMessage());
            request.getRequestDispatcher("/cart/checkout.jsp").forward(request, response);
        }
    }
    
    /**
     * Xử lý GET request - Hiển thị trang order success
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String requestURI = request.getRequestURI();
        
        if (requestURI.endsWith("/cart/orderSuccess") || requestURI.endsWith("/orderSuccess")) {
            // Hiển thị trang đặt hàng thành công
            request.getRequestDispatcher("/cart/orderSuccess.jsp").forward(request, response);
        } else {
            // Các request khác redirect về checkout
            response.sendRedirect(request.getContextPath() + "/checkout");
        }
    }
}