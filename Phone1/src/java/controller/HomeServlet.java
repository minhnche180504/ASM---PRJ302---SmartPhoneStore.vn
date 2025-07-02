package controller;

import dao.ProductDAO;
import model.Product;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "HomeServlet", urlPatterns = {
    "/home", 
    "/Home",
    "/index.html"
})
public class HomeServlet extends HttpServlet {
    
    private ProductDAO productDAO = new ProductDAO();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        System.out.println("🏠 HomeServlet.doGet() called");

        try {
            // Sử dụng ProductDAO thay vì hardcode
            List<Product> productList = productDAO.getAllProducts();
            
            System.out.println("📦 Loaded " + productList.size() + " products");
            
            // Đặt danh sách vào request để truyền qua JSP
            request.setAttribute("products", productList);
            
            // Chuyển tiếp đến trang JSP
            request.getRequestDispatcher("/home.jsp").forward(request, response);
            
        } catch (Exception e) {
            System.err.println("💥 Error in HomeServlet: " + e.getMessage());
            e.printStackTrace();
            
            // Nếu có lỗi, vẫn forward để hiển thị trang
            request.setAttribute("error", "Có lỗi xảy ra khi tải sản phẩm. Vui lòng thử lại sau!");
            request.getRequestDispatcher("/home.jsp").forward(request, response);
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}