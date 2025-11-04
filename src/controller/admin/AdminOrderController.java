package controller.admin;

import model.Order;
import model.User;
import service.OrderService;
import service.impl.OrderServiceImpl;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 * Admin Order Controller
 * Điều khiển quản lý đơn hàng
 */
@WebServlet("/admin/orders")
public class AdminOrderController extends HttpServlet {
    
    private OrderService orderService;
    
    @Override
    public void init() throws ServletException {
        orderService = new OrderServiceImpl();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        if (user == null || !user.isAdmin()) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        String status = request.getParameter("status");
        List<Order> orders;
        
        if (status != null && !status.isEmpty()) {
            orders = orderService.getOrdersByStatus(status);
        } else {
            orders = orderService.getAllOrders();
        }
        
        request.setAttribute("orders", orders);
        request.getRequestDispatcher("/WEB-INF/view/admin/OrderManagement.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        if (user == null || !user.isAdmin()) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        String action = request.getParameter("action");
        String orderId = request.getParameter("orderId");
        String status = request.getParameter("status");
        
        if ("updateStatus".equals(action) && orderId != null && status != null) {
            orderService.updateOrderStatus(Integer.parseInt(orderId), status);
        }
        
        response.sendRedirect(request.getContextPath() + "/admin/orders");
    }
}

