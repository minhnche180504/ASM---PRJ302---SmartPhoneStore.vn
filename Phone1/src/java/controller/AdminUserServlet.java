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
import java.util.List;

@WebServlet(name = "AdminUserServlet", urlPatterns = {
    "/admin/users", 
    "/Admin/Users"
})
public class AdminUserServlet extends HttpServlet {
    
    private UserDAO userDAO;
    
    @Override
    public void init() throws ServletException {
        userDAO = new UserDAO();
        System.out.println("🔧 AdminUserServlet initialized");
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        System.out.println("👨‍💼 AdminUserServlet called");
        
        // Kiểm tra quyền admin
        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("user");
        
        if (currentUser == null) {
            System.out.println("❌ User not logged in, redirecting to login");
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        if (!"ADMIN".equals(currentUser.getRole())) {
            System.out.println("❌ User not admin: " + currentUser.getRole());
            response.sendRedirect(request.getContextPath() + "/home");
            return;
        }
        
        try {
            // Load danh sách users từ database
            List<User> users = userDAO.getAllUsers();
            System.out.println("✅ Loaded " + users.size() + " users for admin");
            
            // Set data vào request
            request.setAttribute("users", users);
            request.setAttribute("currentUser", currentUser);
            
            // Forward to JSP
            request.getRequestDispatcher("/adminUsers.jsp").forward(request, response);
            
        } catch (Exception e) {
            System.err.println("❌ Error loading users: " + e.getMessage());
            e.printStackTrace();
            
            // Set error message
            request.setAttribute("error", "Có lỗi xảy ra khi tải danh sách người dùng: " + e.getMessage());
            request.getRequestDispatcher("/adminUsers.jsp").forward(request, response);
        }
    }
    
    @Override
    public void destroy() {
        if (userDAO != null) {
            userDAO.closeConnection();
        }
        System.out.println("🔧 AdminUserServlet destroyed");
    }
}