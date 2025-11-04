package controller;

import model.Product;
import model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;
import dao.OrderDAO;
import model.Order;

@WebServlet(name = "OrderServlet", urlPatterns = {
    "/order/place",
    "/checkout/process"
})
public class OrderServlet extends HttpServlet {
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Set encoding
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        
        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("user");
        
        // Kiểm tra đăng nhập
        if (currentUser == null) {
            session.setAttribute("cartMessage", "Vui lòng đăng nhập để đặt hàng!");
            session.setAttribute("cartMessageType", "error");
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        try {
            // Lấy giỏ hàng
            @SuppressWarnings("unchecked")
            List<Product> cart = (List<Product>) session.getAttribute("cart");
            
            if (cart == null || cart.isEmpty()) {
                session.setAttribute("cartMessage", "Giỏ hàng trống, không thể đặt hàng!");
                session.setAttribute("cartMessageType", "error");
                response.sendRedirect(request.getContextPath() + "/cart");
                return;
            }
            
            // Lấy thông tin từ form
            String customerName = request.getParameter("customerName");
            String customerPhone = request.getParameter("customerPhone");
            String customerEmail = request.getParameter("customerEmail");
            String customerAddress = request.getParameter("customerAddress");
            String orderNote = request.getParameter("orderNote");
            
            // Validate input
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
            
            // Validate phone number
            String phoneClean = customerPhone.trim().replaceAll("\\s+", "");
            if (!phoneClean.matches("^[0-9]{10,11}$")) {
                request.setAttribute("error", "Số điện thoại không hợp lệ! Vui lòng nhập 10-11 chữ số.");
                request.getRequestDispatcher("/cart/checkout.jsp").forward(request, response);
                return;
            }
            
            // Tính tổng tiền
            double total = 0;
            StringBuilder orderDetails = new StringBuilder();
            for (Product product : cart) {
                total += product.getPrice();
                orderDetails.append("- ").append(product.getName())
                           .append(" (").append(String.format("%,.0f", product.getPrice()))
                           .append(" VND)\n");
            }
            
            // Tạo object Order
            model.Order order = new model.Order();
            order.setUserId(currentUser.getId());
            order.setUserName(currentUser.getUsername());
            order.setTotal(total);
            order.setStatus("Pending");
            order.setCustomerName(customerName.trim());
            order.setCustomerPhone(phoneClean);
            order.setCustomerAddress(customerAddress.trim());
            // Lưu vào database
            dao.OrderDAO orderDAO = new dao.OrderDAO();
            boolean success = orderDAO.createOrder(order, cart);
            if (!success) {
                request.setAttribute("error", "Có lỗi xảy ra khi lưu đơn hàng. Vui lòng thử lại hoặc liên hệ hỗ trợ!");
                request.getRequestDispatcher("/cart/checkout.jsp").forward(request, response);
                return;
            }
            
            // Xóa giỏ hàng sau khi đặt hàng thành công
            cart.clear();
            session.setAttribute("cart", cart);
            
            // Log đơn hàng
            System.out.println("✅ Order placed successfully:");
            System.out.println("   Order ID: " + order.getId()); // Assuming order has an ID after creation
            System.out.println("   Customer: " + customerName + " (" + currentUser.getUsername() + ")");
            System.out.println("   Phone: " + phoneClean);
            System.out.println("   Total: " + String.format("%,.0f", total) + " VND");
            System.out.println("   Items: " + cart.size() + " products");
            
            // Set thông báo thành công
            session.setAttribute("orderSuccessMessage", 
                "Đặt hàng thành công! Mã đơn hàng: " + order.getId() + 
                ". Tổng tiền: " + String.format("%,.0f", total) + " VND. " +
                "Chúng tôi sẽ liên hệ với bạn trong thời gian sớm nhất!");
            
            // Chuyển đến trang xác nhận đơn hàng
            response.sendRedirect(request.getContextPath() + "/cart/orderSuccess");
            
        } catch (Exception e) {
            System.err.println("❌ Error processing order: " + e.getMessage());
            e.printStackTrace();
            
            request.setAttribute("error", "Có lỗi xảy ra khi xử lý đơn hàng: " + e.getMessage());
            request.getRequestDispatcher("/cart/checkout.jsp").forward(request, response);
        }
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String requestURI = request.getRequestURI();
        
        if (requestURI.endsWith("/order/success")) {
            // Hiển thị trang thành công
            request.getRequestDispatcher("/cart/orderSuccess.jsp").forward(request, response);
        } else {
            // Redirect về checkout
            response.sendRedirect(request.getContextPath() + "/checkout");
        }
    }
}