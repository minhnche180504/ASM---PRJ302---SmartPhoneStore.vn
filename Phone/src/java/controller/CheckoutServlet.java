//package controller;
//
//import model.Product;
//import model.User;
//import jakarta.servlet.ServletException;
//import jakarta.servlet.annotation.WebServlet;
//import jakarta.servlet.http.HttpServlet;
//import jakarta.servlet.http.HttpServletRequest;
//import jakarta.servlet.http.HttpServletResponse;
//import jakarta.servlet.http.HttpSession;
//import java.io.IOException;
//import java.util.List;
//
//@WebServlet(name = "CheckoutServlet", urlPatterns = {
//    "/cart/checkout", 
//    "/checkout",
//    "/Checkout",
//    "/order/success"
//})
//public class CheckoutServlet extends HttpServlet {
//    
//    @Override
//    protected void doGet(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//        
//        String requestURI = request.getRequestURI();
//        System.out.println("💳 CheckoutServlet GET called: " + requestURI);
//        
//        if (requestURI.endsWith("/order/success")) {
//            // Hiển thị trang thành công
//            request.getRequestDispatcher("/orderSuccess.jsp").forward(request, response);
//        } else {
//            // Hiển thị trang checkout
//            HttpSession session = request.getSession();
//            User currentUser = (User) session.getAttribute("user");
//            
//            // Kiểm tra đăng nhập
//            if (currentUser == null) {
//                session.setAttribute("cartMessage", "Vui lòng đăng nhập để tiếp tục thanh toán!");
//                session.setAttribute("cartMessageType", "error");
//                response.sendRedirect(request.getContextPath() + "/login");
//                return;
//            }
//            
//            // Kiểm tra giỏ hàng
//            @SuppressWarnings("unchecked")
//            List<Product> cart = (List<Product>) session.getAttribute("cart");
//            
//            if (cart == null || cart.isEmpty()) {
//                session.setAttribute("cartMessage", "Giỏ hàng trống! Vui lòng thêm sản phẩm trước khi thanh toán.");
//                session.setAttribute("cartMessageType", "error");
//                response.sendRedirect(request.getContextPath() + "/cart");
//                return;
//            }
//            
//            request.getRequestDispatcher("/checkout.jsp").forward(request, response);
//        }
//    }
//    
//    @Override
//    protected void doPost(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//        
//        // Set encoding
//        request.setCharacterEncoding("UTF-8");
//        response.setCharacterEncoding("UTF-8");
//        
//        HttpSession session = request.getSession();
//        User currentUser = (User) session.getAttribute("user");
//        
//        System.out.println("💳 CheckoutServlet POST - Processing order");
//        
//        // Kiểm tra đăng nhập
//        if (currentUser == null) {
//            session.setAttribute("cartMessage", "Vui lòng đăng nhập để đặt hàng!");
//            session.setAttribute("cartMessageType", "error");
//            response.sendRedirect(request.getContextPath() + "/login");
//            return;
//        }
//        
//        try {
//            // Lấy giỏ hàng
//            @SuppressWarnings("unchecked")
//            List<Product> cart = (List<Product>) session.getAttribute("cart");
//            
//            if (cart == null || cart.isEmpty()) {
//                request.setAttribute("error", "Giỏ hàng trống, không thể đặt hàng!");
//                request.getRequestDispatcher("/checkout.jsp").forward(request, response);
//                return;
//            }
//            
//            // Lấy thông tin từ form
//            String customerName = request.getParameter("customerName");
//            String customerPhone = request.getParameter("customerPhone");
//            String customerEmail = request.getParameter("customerEmail");
//            String customerAddress = request.getParameter("customerAddress");
//            String orderNote = request.getParameter("orderNote");
//            
//            // Validate input
//            if (customerName == null || customerName.trim().isEmpty()) {
//                request.setAttribute("error", "Vui lòng nhập họ tên người nhận!");
//                request.getRequestDispatcher("/checkout.jsp").forward(request, response);
//                return;
//            }
//            
//            if (customerPhone == null || customerPhone.trim().isEmpty()) {
//                request.setAttribute("error", "Vui lòng nhập số điện thoại!");
//                request.getRequestDispatcher("/checkout.jsp").forward(request, response);
//                return;
//            }
//            
//            if (customerAddress == null || customerAddress.trim().isEmpty()) {
//                request.setAttribute("error", "Vui lòng nhập địa chỉ giao hàng!");
//                request.getRequestDispatcher("/checkout.jsp").forward(request, response);
//                return;
//            }
//            
//            // Validate phone number
//            String phoneClean = customerPhone.trim().replaceAll("\\s+", "");
//            if (!phoneClean.matches("^[0-9]{10,11}$")) {
//                request.setAttribute("error", "Số điện thoại không hợp lệ! Vui lòng nhập 10-11 chữ số.");
//                request.getRequestDispatcher("/checkout.jsp").forward(request, response);
//                return;
//            }
//            
//            // Tính tổng tiền
//            double total = 0;
//            StringBuilder orderDetails = new StringBuilder();
//            orderDetails.append("Chi tiết đơn hàng:\n");
//            
//            for (int i = 0; i < cart.size(); i++) {
//                Product product = cart.get(i);
//                total += product.getPrice();
//                orderDetails.append(String.format("%d. %s - %,.0f VND\n", 
//                    i + 1, product.getName(), product.getPrice()));
//            }
//            
//            // Tạo mã đơn hàng unique
//            String orderId = "ORD" + System.currentTimeMillis();
//            
//            // Lưu thông tin đơn hàng vào session
//            session.setAttribute("lastOrderId", orderId);
//            session.setAttribute("lastOrderTotal", total);
//            session.setAttribute("lastOrderDetails", orderDetails.toString());
//            session.setAttribute("lastCustomerName", customerName.trim());
//            session.setAttribute("lastCustomerPhone", phoneClean);
//            session.setAttribute("lastCustomerEmail", customerEmail != null ? customerEmail.trim() : "");
//            session.setAttribute("lastCustomerAddress", customerAddress.trim());
//            session.setAttribute("lastOrderNote", orderNote != null ? orderNote.trim() : "");
//            session.setAttribute("lastOrderDate", new java.util.Date());
//            
//            // Log chi tiết đơn hàng
//            System.out.println("✅ ORDER PLACED SUCCESSFULLY:");
//            System.out.println("   Order ID: " + orderId);
//            System.out.println("   User: " + currentUser.getUsername() + " (ID: " + currentUser.getId() + ")");
//            System.out.println("   Customer Name: " + customerName.trim());
//            System.out.println("   Phone: " + phoneClean);
//            System.out.println("   Email: " + (customerEmail != null ? customerEmail.trim() : "N/A"));
//            System.out.println("   Address: " + customerAddress.trim());
//            System.out.println("   Total Amount: " + String.format("%,.0f", total) + " VND");
//            System.out.println("   Number of Items: " + cart.size());
//            System.out.println("   Order Note: " + (orderNote != null && !orderNote.trim().isEmpty() ? orderNote.trim() : "N/A"));
//            System.out.println("   Order Time: " + new java.util.Date());
//            System.out.println("   Products:");
//            for (Product product : cart) {
//                System.out.println("     - " + product.getName() + " (" + String.format("%,.0f", product.getPrice()) + " VND)");
//            }
//            System.out.println("=====================================");
//            
//            // Xóa giỏ hàng sau khi đặt hàng thành công
//            cart.clear();
//            session.setAttribute("cart", cart);
//            
//            // Set thông báo thành công
//            session.setAttribute("orderSuccessMessage", 
//                "Đặt hàng thành công! Mã đơn hàng: " + orderId + 
//                ". Tổng tiền: " + String.format("%,.0f", total) + " VND. " +
//                "Chúng tôi sẽ liên hệ với bạn trong thời gian sớm nhất để xác nhận đơn hàng!");
//            
//            // Chuyển đến trang xác nhận đơn hàng
//            response.sendRedirect(request.getContextPath() + "/order/success");
//            
//        } catch (Exception e) {
//            System.err.println("❌ Error processing checkout: " + e.getMessage());
//            e.printStackTrace();
//            
//            request.setAttribute("error", "Có lỗi xảy ra khi xử lý đơn hàng: " + e.getMessage() + 
//                ". Vui lòng thử lại hoặc liên hệ hỗ trợ.");
//            request.getRequestDispatcher("/checkout.jsp").forward(request, response);
//        }
//    }
//}