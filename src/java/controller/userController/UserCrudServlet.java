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

@WebServlet(name = "UserCrudServlet", urlPatterns = {
    "/admin/users/add",
    "/admin/users/edit", 
    "/admin/users/delete",
    "/admin/users/update"
})
public class UserCrudServlet extends HttpServlet {
    
    private UserDAO userDAO;
    
    @Override
    public void init() throws ServletException {
        userDAO = new UserDAO();
        System.out.println("🔧 UserCrudServlet initialized");
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Kiểm tra quyền admin
        if (!isAdmin(request, response)) {
            return;
        }
        
        String action = getAction(request.getRequestURI());
        System.out.println("👨‍💼 UserCrudServlet GET action: " + action);
        
        switch (action) {
            case "edit":
                handleEditGet(request, response);
                break;
            case "delete":
                handleDelete(request, response);
                break;
            default:
                response.sendRedirect(request.getContextPath() + "/admin/users");
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Kiểm tra quyền admin
        if (!isAdmin(request, response)) {
            return;
        }
        
        // Set encoding
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        
        String action = getAction(request.getRequestURI());
        System.out.println("👨‍💼 UserCrudServlet POST action: " + action);
        
        switch (action) {
            case "add":
                handleAdd(request, response);
                break;
            case "update":
                handleUpdate(request, response);
                break;
            default:
                response.sendRedirect(request.getContextPath() + "/admin/users");
        }
    }
    
    private boolean isAdmin(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("user");
        
        if (currentUser == null || !"ADMIN".equals(currentUser.getRole())) {
            response.sendRedirect(request.getContextPath() + "/login");
            return false;
        }
        return true;
    }
    
    private String getAction(String requestURI) {
        String[] parts = requestURI.split("/");
        return parts[parts.length - 1];
    }
    
    private void handleAdd(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        try {
            String username = request.getParameter("username");
            String password = request.getParameter("password");
            String email = request.getParameter("email");
            String fullName = request.getParameter("fullName");
            String phone = request.getParameter("phone");
            String address = request.getParameter("address");
            String role = request.getParameter("role");
            
            // Validate input
            if (username == null || username.trim().isEmpty()) {
                setMessage(request, "error", "Tên đăng nhập không được để trống!");
                response.sendRedirect(request.getContextPath() + "/admin/users");
                return;
            }
            
            if (password == null || password.trim().isEmpty()) {
                setMessage(request, "error", "Mật khẩu không được để trống!");
                response.sendRedirect(request.getContextPath() + "/admin/users");
                return;
            }
            
            // Kiểm tra username đã tồn tại
            if (userDAO.isUsernameExists(username.trim())) {
                setMessage(request, "error", "Tên đăng nhập đã tồn tại!");
                response.sendRedirect(request.getContextPath() + "/admin/users");
                return;
            }
            
            // Kiểm tra email nếu có
            if (email != null && !email.trim().isEmpty() && userDAO.isEmailExists(email.trim())) {
                setMessage(request, "error", "Email đã tồn tại!");
                response.sendRedirect(request.getContextPath() + "/admin/users");
                return;
            }
            
            // Tạo user mới
            User newUser = new User();
            newUser.setUsername(username.trim());
            newUser.setPassword(password); // Trong thực tế nên hash password
            newUser.setEmail(email != null ? email.trim() : "");
            newUser.setFullName(fullName != null ? fullName.trim() : "");
            newUser.setPhone(phone != null ? phone.trim() : "");
            newUser.setAddress(address != null ? address.trim() : "");
            newUser.setRole(role != null ? role : "USER");
            
            boolean success = userDAO.register(newUser);
            
            if (success) {
                System.out.println("✅ User added successfully: " + username);
                setMessage(request, "success", "Thêm người dùng thành công!");
            } else {
                setMessage(request, "error", "Có lỗi xảy ra khi thêm người dùng!");
            }
            
        } catch (Exception e) {
            System.err.println("❌ Error adding user: " + e.getMessage());
            e.printStackTrace();
            setMessage(request, "error", "Có lỗi xảy ra: " + e.getMessage());
        }
        
        response.sendRedirect(request.getContextPath() + "/admin/users");
    }
    
    private void handleEditGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        try {
            String userIdStr = request.getParameter("id");
            if (userIdStr == null) {
                setMessage(request, "error", "ID người dùng không hợp lệ!");
                response.sendRedirect(request.getContextPath() + "/admin/users");
                return;
            }
            
            int userId = Integer.parseInt(userIdStr);
            User user = userDAO.getUserById(userId);
            
            if (user != null) {
                request.setAttribute("editUser", user);
                request.getRequestDispatcher("/admin/users").forward(request, response);
            } else {
                setMessage(request, "error", "Không tìm thấy người dùng!");
                response.sendRedirect(request.getContextPath() + "/admin/users");
            }
            
        } catch (NumberFormatException e) {
            setMessage(request, "error", "ID người dùng không hợp lệ!");
            response.sendRedirect(request.getContextPath() + "/admin/users");
        } catch (Exception e) {
            System.err.println("❌ Error getting user for edit: " + e.getMessage());
            setMessage(request, "error", "Có lỗi xảy ra: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/admin/users");
        }
    }
    
    private void handleUpdate(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        try {
            String userIdStr = request.getParameter("userId");
            if (userIdStr == null) {
                setMessage(request, "error", "ID người dùng không hợp lệ!");
                response.sendRedirect(request.getContextPath() + "/admin/users");
                return;
            }
            
            int userId = Integer.parseInt(userIdStr);
            User user = userDAO.getUserById(userId);
            
            if (user == null) {
                setMessage(request, "error", "Không tìm thấy người dùng!");
                response.sendRedirect(request.getContextPath() + "/admin/users");
                return;
            }
            
            // Cập nhật thông tin
            String email = request.getParameter("email");
            String fullName = request.getParameter("fullName");
            String phone = request.getParameter("phone");
            String address = request.getParameter("address");
            String role = request.getParameter("role");
            
            // Kiểm tra email nếu thay đổi
            if (email != null && !email.trim().isEmpty() && !email.equals(user.getEmail())) {
                if (userDAO.isEmailExists(email.trim())) {
                    setMessage(request, "error", "Email đã tồn tại!");
                    response.sendRedirect(request.getContextPath() + "/admin/users");
                    return;
                }
            }
            
            user.setEmail(email != null ? email.trim() : "");
            user.setFullName(fullName != null ? fullName.trim() : "");
            user.setPhone(phone != null ? phone.trim() : "");
            user.setAddress(address != null ? address.trim() : "");
            user.setRole(role != null ? role : "USER");
            
            boolean success = userDAO.updateUser(user);
            
            if (success) {
                System.out.println("✅ User updated successfully: " + user.getUsername());
                setMessage(request, "success", "Cập nhật người dùng thành công!");
            } else {
                setMessage(request, "error", "Có lỗi xảy ra khi cập nhật người dùng!");
            }
            
        } catch (NumberFormatException e) {
            setMessage(request, "error", "ID người dùng không hợp lệ!");
        } catch (Exception e) {
            System.err.println("❌ Error updating user: " + e.getMessage());
            e.printStackTrace();
            setMessage(request, "error", "Có lỗi xảy ra: " + e.getMessage());
        }
        
        response.sendRedirect(request.getContextPath() + "/admin/users");
    }
    
    private void handleDelete(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        try {
            String userIdStr = request.getParameter("id");
            if (userIdStr == null) {
                setMessage(request, "error", "ID người dùng không hợp lệ!");
                response.sendRedirect(request.getContextPath() + "/admin/users");
                return;
            }
            
            int userId = Integer.parseInt(userIdStr);
            
            // Không cho phép xóa chính mình
            HttpSession session = request.getSession();
            User currentUser = (User) session.getAttribute("user");
            if (currentUser.getId() == userId) {
                setMessage(request, "error", "Không thể xóa chính mình!");
                response.sendRedirect(request.getContextPath() + "/admin/users");
                return;
            }
            
            User userToDelete = userDAO.getUserById(userId);
            if (userToDelete == null) {
                setMessage(request, "error", "Không tìm thấy người dùng!");
                response.sendRedirect(request.getContextPath() + "/admin/users");
                return;
            }
            
            // Thực hiện xóa user
            boolean success = userDAO.deleteUser(userId);
            
            if (success) {
                System.out.println("✅ User deleted successfully: " + userToDelete.getUsername());
                setMessage(request, "success", "Xóa người dùng thành công!");
            } else {
                setMessage(request, "error", "Có lỗi xảy ra khi xóa người dùng!");
            }
            
        } catch (NumberFormatException e) {
            setMessage(request, "error", "ID người dùng không hợp lệ!");
        } catch (Exception e) {
            System.err.println("❌ Error deleting user: " + e.getMessage());
            setMessage(request, "error", "Có lỗi xảy ra: " + e.getMessage());
        }
        
        response.sendRedirect(request.getContextPath() + "/admin/users");
    }
    
    private void setMessage(HttpServletRequest request, String type, String message) {
        HttpSession session = request.getSession();
        session.setAttribute("messageType", type);
        session.setAttribute("message", message);
    }
    
    @Override
    public void destroy() {
        if (userDAO != null) {
            userDAO.closeConnection();
        }
        System.out.println("🔧 UserCrudServlet destroyed");
    }
}