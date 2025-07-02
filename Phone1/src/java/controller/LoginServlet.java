package controller;

import dao.UserDAO;
import model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(name = "LoginServlet", urlPatterns = {
    "/login", 
    "/account/login",
    "/Login",
    "/Account/Login"
})
public class LoginServlet extends HttpServlet {
    
    private UserDAO userDAO;
    
    @Override
    public void init() throws ServletException {
        // Khởi tạo UserDAO khi servlet được tạo
        userDAO = new UserDAO();
        System.out.println("🔧 LoginServlet initialized");
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        System.out.println("🔍 LoginServlet.doGet() called - URL: " + request.getRequestURL());
        
        // Kiểm tra nếu user đã đăng nhập
        HttpSession session = request.getSession(false);
        if (session != null) {
            User currentUser = (User) session.getAttribute("user");
            if (currentUser != null) {
                System.out.println("👤 User already logged in: " + currentUser.getUsername());
                // Đã đăng nhập, chuyển về trang chủ
                response.sendRedirect(request.getContextPath() + "/home");
                return;
            }
        }
        
        // Chưa đăng nhập, hiển thị form login
        request.getRequestDispatcher("/login.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        System.out.println("📝 LoginServlet.doPost() called");
        
        // Đặt encoding cho request
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        
        // Lấy thông tin từ form
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        
        System.out.println("👤 Login attempt - Username: " + username);
        
        // Validate input
        if (username == null || username.trim().isEmpty()) {
            request.setAttribute("error", "Vui lòng nhập tên đăng nhập!");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
            return;
        }
        
        if (password == null || password.trim().isEmpty()) {
            request.setAttribute("error", "Vui lòng nhập mật khẩu!");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
            return;
        }
        
        try {
            // Đảm bảo UserDAO được khởi tạo
            if (userDAO == null) {
                userDAO = new UserDAO();
            }
            
            // Xác thực đăng nhập
            User user = userDAO.login(username.trim(), password);
            
            if (user != null) {
                // Đăng nhập thành công
                System.out.println("✅ Login successful for: " + username + " with role: " + user.getRole());
                
                // Tạo session mới
                HttpSession session = request.getSession(true);
                session.setAttribute("user", user);
                session.setAttribute("userId", user.getId());
                session.setAttribute("username", user.getUsername());
                session.setAttribute("userRole", user.getRole());
                session.setAttribute("fullName", user.getFullName());
                
                // Set session timeout (30 phút)
                session.setMaxInactiveInterval(30 * 60);
                
                System.out.println("🎯 Session created for user: " + user.getUsername());
                
                // Chuyển hướng dựa trên role
                String redirectURL;
                if ("ADMIN".equals(user.getRole())) {
                    redirectURL = request.getContextPath() + "/admin/products";
                    System.out.println("🔐 Redirecting admin to: " + redirectURL);
                } else {
                    redirectURL = request.getContextPath() + "/home";
                    System.out.println("🏠 Redirecting user to: " + redirectURL);
                }
                
                response.sendRedirect(redirectURL);
                
            } else {
                // Đăng nhập thất bại
                System.out.println("❌ Login failed for: " + username);
                request.setAttribute("error", "Tên đăng nhập hoặc mật khẩu không đúng!");
                request.setAttribute("username", username); // Giữ lại username đã nhập
                request.getRequestDispatcher("/login.jsp").forward(request, response);
            }
            
        } catch (Exception e) {
            System.err.println("💥 Error in LoginServlet: " + e.getMessage());
            e.printStackTrace();
            
            request.setAttribute("error", "Có lỗi xảy ra trong quá trình đăng nhập. Vui lòng thử lại!");
            request.setAttribute("username", username); // Giữ lại username đã nhập
            request.getRequestDispatcher("/login.jsp").forward(request, response);
        }
    }
    
    @Override
    public void destroy() {
        // Cleanup khi servlet bị destroy
        if (userDAO != null) {
            userDAO.closeConnection();
        }
        System.out.println("🔧 LoginServlet destroyed");
    }
}