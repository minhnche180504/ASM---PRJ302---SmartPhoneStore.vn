package controller;

import dao.ProductDAO;
import model.Product;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "ProductServlet", urlPatterns = {"/products"})
public class ProductServlet extends HttpServlet {
    
    private ProductDAO productDAO = new ProductDAO();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
            // Lấy danh sách sản phẩm từ database
            List<Product> productList = productDAO.getAllProducts();
            
            // Đặt danh sách vào request
            request.setAttribute("products", productList);
            
            // Chuyển tiếp đến trang products.jsp
            request.getRequestDispatcher("products.jsp").forward(request, response);
            
        } catch (Exception e) {
            System.err.println("Lỗi trong ProductServlet: " + e.getMessage());
            e.printStackTrace();
            
            request.setAttribute("error", "Có lỗi xảy ra khi tải danh sách sản phẩm!");
            request.getRequestDispatcher("products.jsp").forward(request, response);
        }
    }
}