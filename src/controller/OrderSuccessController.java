package controller;

import model.Order;
import model.User;
import service.OrderService;
import service.impl.OrderServiceImpl;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 * Order Success Controller
 * Điều khiển trang thành công đặt hàng
 */
@WebServlet("/order-success")
public class OrderSuccessController extends HttpServlet {
    
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
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        String orderId = request.getParameter("id");
        if (orderId != null && !orderId.isEmpty()) {
            Order order = orderService.getOrderById(Integer.parseInt(orderId));
            if (order != null && order.getUserId() == user.getUserId()) {
                request.setAttribute("order", order);
                request.getRequestDispatcher("/WEB-INF/view/public/OrderSuccess.jsp").forward(request, response);
                return;
            }
        }
        
        response.sendRedirect(request.getContextPath() + "/order-history");
    }
}

