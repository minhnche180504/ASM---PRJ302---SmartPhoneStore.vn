package controller;

import model.Order;
import model.OrderItem;
import model.User;
import service.OrderService;
import service.PromotionService;
import service.impl.OrderServiceImpl;
import service.impl.PromotionServiceImpl;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 * Checkout Controller
 * Điều khiển thanh toán
 */
@WebServlet("/checkout")
public class CheckoutController extends HttpServlet {
    
    private OrderService orderService;
    private PromotionService promotionService;
    
    @Override
    public void init() throws ServletException {
        orderService = new OrderServiceImpl();
        promotionService = new PromotionServiceImpl();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        @SuppressWarnings("unchecked")
        List<CartController.CartItem> cart = (List<CartController.CartItem>) session.getAttribute("cart");
        if (cart == null || cart.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/cart");
            return;
        }
        
        BigDecimal total = calculateTotal(cart);
        request.setAttribute("cart", cart);
        request.setAttribute("total", total);
        request.setAttribute("user", user);
        
        request.getRequestDispatcher("/WEB-INF/view/public/Checkout.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        @SuppressWarnings("unchecked")
        List<CartController.CartItem> cart = (List<CartController.CartItem>) session.getAttribute("cart");
        if (cart == null || cart.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/cart");
            return;
        }
        
        try {
            String shippingName = request.getParameter("shippingName");
            String shippingPhone = request.getParameter("shippingPhone");
            String shippingAddress = request.getParameter("shippingAddress");
            String paymentMethod = request.getParameter("paymentMethod");
            String promoCode = request.getParameter("promoCode");
            
            BigDecimal total = calculateTotal(cart);
            
            // Apply promotion discount if provided
            BigDecimal discount = BigDecimal.ZERO;
            if (promoCode != null && !promoCode.trim().isEmpty()) {
                discount = promotionService.calculateDiscount(promoCode, total);
            }
            total = total.subtract(discount);
            
            // Create order
            Order order = new Order();
            order.setUserId(user.getUserId());
            order.setTotalAmount(total);
            order.setStatus("PENDING");
            order.setPaymentMethod(paymentMethod);
            order.setShippingName(shippingName);
            order.setShippingPhone(shippingPhone);
            order.setShippingAddress(shippingAddress);
            
            // Create order items
            List<OrderItem> orderItems = new ArrayList<>();
            for (CartController.CartItem cartItem : cart) {
                OrderItem item = new OrderItem();
                item.setProductId(cartItem.getProduct().getPId());
                item.setQuantity(cartItem.getQuantity());
                item.setPrice(cartItem.getProduct().getPrice());
                item.setSubtotal(cartItem.getSubtotal());
                orderItems.add(item);
            }
            order.setOrderItems(orderItems);
            
            // Save order
            if (orderService.createOrder(order)) {
                // Clear cart
                session.removeAttribute("cart");
                response.sendRedirect(request.getContextPath() + "/order-success?id=" + order.getOrderId());
            } else {
                request.setAttribute("error", "Đặt hàng thất bại. Vui lòng thử lại!");
                doGet(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Có lỗi xảy ra. Vui lòng thử lại!");
            doGet(request, response);
        }
    }
    
    private BigDecimal calculateTotal(List<CartController.CartItem> cart) {
        BigDecimal total = BigDecimal.ZERO;
        for (CartController.CartItem item : cart) {
            total = total.add(item.getSubtotal());
        }
        return total;
    }
}

