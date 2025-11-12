package controller;

import dao.ProductDAO;
import model.Product;
import model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "AdminProductServlet", urlPatterns = {
    "/admin/products", 
    "/Admin/Products"
})
public class AdminProductServlet extends HttpServlet {
    
    private ProductDAO productDAO;
    
    @Override
    public void init() throws ServletException {
        productDAO = new ProductDAO();
        System.out.println("🔧 AdminProductServlet initialized");
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        System.out.println("👨‍💼 AdminProductServlet called");
        
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
            // Load danh sách sản phẩm từ database
            List<Product> products = productDAO.getAllProducts();
            System.out.println("✅ Loaded " + products.size() + " products for admin");
            
            // Set data vào request
            request.setAttribute("products", products);
            request.setAttribute("currentUser", currentUser);
            
            // Lấy thông báo từ session (nếu có)
            String messageType = (String) session.getAttribute("messageType");
            String message = (String) session.getAttribute("message");
            
            if (message != null) {
                request.setAttribute("messageType", messageType);
                request.setAttribute("message", message);
                
                // Xóa thông báo khỏi session sau khi đã sử dụng
                session.removeAttribute("messageType");
                session.removeAttribute("message");
            }
            
            // Forward to JSP
            request.getRequestDispatcher("/admin/adminProducts.jsp").forward(request, response);
            
        } catch (Exception e) {
            System.err.println("❌ Error loading products: " + e.getMessage());
            e.printStackTrace();
            
            // Set error message
            request.setAttribute("error", "Có lỗi xảy ra khi tải danh sách sản phẩm: " + e.getMessage());
            request.getRequestDispatcher("/admin/adminProducts.jsp").forward(request, response);
        }
    }
    
    @Override
    public void destroy() {
        if (productDAO != null) {
            productDAO.closeConnection();
        }
        System.out.println("🔧 AdminProductServlet destroyed");
    }
}