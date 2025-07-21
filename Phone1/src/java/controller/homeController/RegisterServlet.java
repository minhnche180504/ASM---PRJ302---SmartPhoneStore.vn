package controller;

import dao.UserDAO;
import model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "RegisterServlet", urlPatterns = {
    "/register", 
    "/account/register", 
    "/Register",
    "/Account/Register"
})
public class RegisterServlet extends HttpServlet {
    
    private UserDAO userDAO = new UserDAO();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        System.out.println("📝 RegisterServlet.doGet() called");
        
        // Hiển thị form đăng ký
        request.getRequestDispatcher("/home/register.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        System.out.println("📤 RegisterServlet.doPost() called");
        
        // Lấy thông tin từ form
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        
        // Validate input
        if (username == null || username.trim().isEmpty()) {
            request.setAttribute("error", "Vui lòng nhập tên đăng nhập!");
            request.getRequestDispatcher("/home/register.jsp").forward(request, response);
            return;
        }
        
        if (password == null || password.trim().isEmpty()) {
            request.setAttribute("error", "Vui lòng nhập mật khẩu!");
            request.getRequestDispatcher("/home/register.jsp").forward(request, response);
            return;
        }
        
        if (confirmPassword == null || !password.equals(confirmPassword)) {
            request.setAttribute("error", "Mật khẩu nhập lại không khớp!");
            request.getRequestDispatcher("/home/register.jsp").forward(request, response);
            return;
        }
        
        if (password.length() < 6) {
            request.setAttribute("error", "Mật khẩu phải có ít nhất 6 ký tự!");
            request.getRequestDispatcher("/home/register.jsp").forward(request, response);
            return;
        }
        
        try {
            // Kiểm tra username đã tồn tại chưa
            if (userDAO.isUsernameExists(username.trim())) {
                request.setAttribute("error", "Tên đăng nhập đã tồn tại!");
                request.getRequestDispatcher("/home/register.jsp").forward(request, response);
                return;
            }
            
            // Tạo user mới
            User newUser = new User();
            newUser.setUsername(username.trim());
            newUser.setPassword(password); // Trong thực tế nên mã hóa password
            newUser.setEmail(""); // Có thể thêm field email vào form
            newUser.setFullName(""); // Có thể thêm field fullName vào form
            newUser.setRole("USER");
            
            // Lưu vào database
            boolean success = userDAO.register(newUser);
            
            if (success) {
                System.out.println("✅ User registered successfully: " + username);
                request.setAttribute("success", "Đăng ký thành công! Vui lòng đăng nhập.");
                request.getRequestDispatcher("/home/login.jsp").forward(request, response);
            } else {
                request.setAttribute("error", "Có lỗi xảy ra trong quá trình đăng ký!");
                request.getRequestDispatcher("/home/register.jsp").forward(request, response);
            }
            
        } catch (Exception e) {
            System.err.println("💥 Error in RegisterServlet: " + e.getMessage());
            e.printStackTrace();
            
            request.setAttribute("error", "Có lỗi xảy ra trong quá trình đăng ký. Vui lòng thử lại!");
            request.getRequestDispatcher("/home/register.jsp").forward(request, response);
        }
    }
}