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
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 * Admin Statistics Controller
 * Điều khiển trang thống kê
 */
@WebServlet("/admin/statistics")
public class AdminStatisticsController extends HttpServlet {
    
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
            List<Order> orders = orderService.getAllOrders();
            List<Product> products = productService.getAllProducts();
            
            // Revenue by month
            Map<String, BigDecimal> revenueByMonth = new HashMap<>();
            for (Order order : orders) {
                if ("DELIVERED".equals(order.getStatus())) {
                    String month = order.getOrderDate().toString().substring(0, 7); // YYYY-MM
                    revenueByMonth.put(month, 
                        revenueByMonth.getOrDefault(month, BigDecimal.ZERO)
                            .add(order.getTotalAmount()));
                }
            }
            
            // Top selling products
            List<Product> topSelling = productService.getBestSellers(10);
            
            // Status distribution
            Map<String, Integer> statusCount = new HashMap<>();
            for (Order order : orders) {
                statusCount.put(order.getStatus(), 
                    statusCount.getOrDefault(order.getStatus(), 0) + 1);
            }
            
            request.setAttribute("revenueByMonth", revenueByMonth);
            request.setAttribute("topSelling", topSelling);
            request.setAttribute("statusCount", statusCount);
            
            request.getRequestDispatcher("/WEB-INF/view/admin/Statistics.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }
}

