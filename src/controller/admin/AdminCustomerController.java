package controller.admin;

import model.User;
import service.UserService;
import service.impl.UserServiceImpl;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 * Admin Customer Controller
 * Điều khiển quản lý khách hàng
 */
@WebServlet("/admin/customers")
public class AdminCustomerController extends HttpServlet {
    
    private UserService userService;
    
    @Override
    public void init() throws ServletException {
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
        
        request.setAttribute("users", userService.getAllUsers());
        request.getRequestDispatcher("/WEB-INF/view/admin/CustomerManagement.jsp").forward(request, response);
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
        String userId = request.getParameter("userId");
        
        if ("delete".equals(action) && userId != null) {
            userService.deleteUser(Integer.parseInt(userId));
        }
        
        response.sendRedirect(request.getContextPath() + "/admin/customers");
    }
}

