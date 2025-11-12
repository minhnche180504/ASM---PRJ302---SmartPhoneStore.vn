package controller.admin;

import model.Order;
import model.Product;
import model.User;
import service.OrderService;
import service.ProductService;
import service.UserService;
import service.impl.OrderServiceImpl;
import service.impl.ProductServiceImpl;
import service.impl.UserServiceImpl;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 * Admin Dashboard Controller
 * Điều khiển trang quản trị tổng quan
 */
@WebServlet("/admin/dashboard")
public class AdminDashboardController extends HttpServlet {
    
    private ProductService productService;
    private OrderService orderService;
    private UserService userService;
    
    @Override
    public void init() throws ServletException {
        productService = new ProductServiceImpl();
        orderService = new OrderServiceImpl();
        userService = new UserServiceImpl();
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
        
        try {
            // Get statistics
            List<Product> products = productService.getAllProducts();
            List<Order> orders = orderService.getAllOrders();
            List<User> users = userService.getAllUsers();
            
            int totalProducts = products.size();
            int totalOrders = orders.size();
            int totalUsers = users.size();
            
            // Calculate total revenue
            BigDecimal totalRevenue = BigDecimal.ZERO;
            for (Order order : orders) {
                if ("DELIVERED".equals(order.getStatus())) {
                    totalRevenue = totalRevenue.add(order.getTotalAmount());
                }
            }
            
            // Get pending orders
            List<Order> pendingOrders = orderService.getOrdersByStatus("PENDING");
            
            request.setAttribute("totalProducts", totalProducts);
            request.setAttribute("totalOrders", totalOrders);
            request.setAttribute("totalUsers", totalUsers);
            request.setAttribute("totalRevenue", totalRevenue);
            request.setAttribute("pendingOrders", pendingOrders.size());
            request.setAttribute("recentOrders", orders.size() > 10 ? orders.subList(0, 10) : orders);
            
            request.getRequestDispatcher("/WEB-INF/view/admin/AdminDashboard.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }
}

