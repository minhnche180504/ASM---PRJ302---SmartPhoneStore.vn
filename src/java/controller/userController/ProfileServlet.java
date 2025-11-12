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

@WebServlet(name = "ProfileServlet", urlPatterns = {
    "/profile",
    "/user/profile",
    "/account/profile"
})
public class ProfileServlet extends HttpServlet {
    
    private UserDAO userDAO;
    
    @Override
    public void init() throws ServletException {
        super.init();
        userDAO = new UserDAO();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        
        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("user");
        
        // Kiểm tra đăng nhập
        if (currentUser == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        // Lấy thông tin user mới nhất từ database
        User user = userDAO.getUserById(currentUser.getId());
        if (user != null) {
            // Cập nhật session với thông tin mới nhất
            session.setAttribute("user", user);
            request.setAttribute("user", user);
        } else {
            request.setAttribute("error", "Không tìm thấy thông tin người dùng");
        }
        
        // Forward đến trang profile
        request.getRequestDispatcher("/home/profile.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        
        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("user");
        
        // Kiểm tra đăng nhập
        if (currentUser == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        String action = request.getParameter("action");
        
        if ("updateProfile".equals(action)) {
            // Cập nhật thông tin cá nhân
            String email = request.getParameter("email");
            String fullName = request.getParameter("fullName");
            String phone = request.getParameter("phone");
            String address = request.getParameter("address");
            
            User user = userDAO.getUserById(currentUser.getId());
            if (user != null) {
                user.setEmail(email);
                user.setFullName(fullName);
                user.setPhone(phone);
                user.setAddress(address);
                
                if (userDAO.updateUser(user)) {
                    // Cập nhật session
                    User updatedUser = userDAO.getUserById(currentUser.getId());
                    session.setAttribute("user", updatedUser);
                    request.setAttribute("success", "Cập nhật thông tin thành công!");
                } else {
                    request.setAttribute("error", "Cập nhật thông tin thất bại!");
                }
            }
            
        } else if ("changePassword".equals(action)) {
            // Đổi mật khẩu
            String currentPassword = request.getParameter("currentPassword");
            String newPassword = request.getParameter("newPassword");
            String confirmPassword = request.getParameter("confirmPassword");
            
            // Kiểm tra mật khẩu hiện tại
            User user = userDAO.login(currentUser.getUsername(), currentPassword);
            if (user == null) {
                request.setAttribute("error", "Mật khẩu hiện tại không đúng!");
            } else if (!newPassword.equals(confirmPassword)) {
                request.setAttribute("error", "Mật khẩu mới không khớp!");
            } else if (newPassword.length() < 6) {
                request.setAttribute("error", "Mật khẩu mới phải có ít nhất 6 ký tự!");
            } else {
                if (userDAO.updatePassword(currentUser.getId(), newPassword)) {
                    request.setAttribute("success", "Đổi mật khẩu thành công!");
                } else {
                    request.setAttribute("error", "Đổi mật khẩu thất bại!");
                }
            }
        }
        
        // Lấy thông tin user mới nhất
        User user = userDAO.getUserById(currentUser.getId());
        if (user != null) {
            session.setAttribute("user", user);
            request.setAttribute("user", user);
        }
        
        // Forward lại trang profile
        request.getRequestDispatcher("/user/profile.jsp").forward(request, response);
    }
}

