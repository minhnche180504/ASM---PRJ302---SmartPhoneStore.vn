package controller;

import model.User;
import service.UserService;
import service.impl.UserServiceImpl;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * Register Controller
 * Điều khiển đăng ký
 */
@WebServlet("/register")
public class RegisterController extends HttpServlet {
    
    private UserService userService;
    
    @Override
    public void init() throws ServletException {
        userService = new UserServiceImpl();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/view/public/Register.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        
        // Validate input
        if (username == null || username.trim().isEmpty()) {
            request.setAttribute("errorMessage", "Vui lòng nhập tên đăng nhập!");
            request.getRequestDispatcher("/WEB-INF/view/public/Register.jsp").forward(request, response);
            return;
        }
        
        if (password == null || password.trim().isEmpty()) {
            request.setAttribute("errorMessage", "Vui lòng nhập mật khẩu!");
            request.getRequestDispatcher("/WEB-INF/view/public/Register.jsp").forward(request, response);
            return;
        }
        
        if (password.length() < 6) {
            request.setAttribute("errorMessage", "Mật khẩu phải có ít nhất 6 ký tự!");
            request.getRequestDispatcher("/WEB-INF/view/public/Register.jsp").forward(request, response);
            return;
        }
        
        if (!password.equals(confirmPassword)) {
            request.setAttribute("errorMessage", "Mật khẩu xác nhận không khớp!");
            request.getRequestDispatcher("/WEB-INF/view/public/Register.jsp").forward(request, response);
            return;
        }
        
        // Check if username already exists (using email field as username)
        if (userService.getUserByUsername(username) != null) {
            request.setAttribute("errorMessage", "Tên đăng nhập đã được sử dụng!");
            request.getRequestDispatcher("/WEB-INF/view/public/Register.jsp").forward(request, response);
            return;
        }
        
        // Create user - use username as email for compatibility
        User user = new User();
        user.setName(username); // Use username as name
        user.setEmail(username); // Store username in email field
        user.setPassword(password);
        user.setRole("CUSTOMER");
        
        if (userService.registerUser(user)) {
            request.setAttribute("successMessage", "Đăng ký thành công! Vui lòng đăng nhập.");
            request.getRequestDispatcher("/WEB-INF/view/public/Login.jsp").forward(request, response);
        } else {
            request.setAttribute("errorMessage", "Có lỗi xảy ra trong quá trình đăng ký!");
            request.getRequestDispatcher("/WEB-INF/view/public/Register.jsp").forward(request, response);
        }
    }
}

