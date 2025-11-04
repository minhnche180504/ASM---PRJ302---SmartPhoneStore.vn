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
            // Lấy danh sách category cho dropdown
            List<String> categories = productDAO.getAllCategories();
            request.setAttribute("categories", categories);

            String keyword = request.getParameter("search");
            String category = request.getParameter("category");
            String sort = request.getParameter("sort");
            List<Product> productList;
            if (category != null && !category.trim().isEmpty()) {
                // Lọc theo category
                productList = productDAO.getProductsByCategory(category.trim());
                request.setAttribute("selectedCategory", category);
            } else if (keyword != null && !keyword.trim().isEmpty()) {
                productList = productDAO.searchProductsByName(keyword.trim());
                request.setAttribute("searchKeyword", keyword);
            } else {
                productList = productDAO.getAllProducts();
            }
            // Sắp xếp theo giá nếu có sort
            if (sort != null && (sort.equals("asc") || sort.equals("desc"))) {
                productList.sort((a, b) -> sort.equals("asc") ? Double.compare(a.getPrice(), b.getPrice()) : Double.compare(b.getPrice(), a.getPrice()));
            }
            request.setAttribute("products", productList);
            request.getRequestDispatcher("/product/products.jsp").forward(request, response);
            
        } catch (Exception e) {
            System.err.println("Lỗi trong ProductServlet: " + e.getMessage());
            e.printStackTrace();
            
            request.setAttribute("error", "Có lỗi xảy ra khi tải danh sách sản phẩm!");
            request.getRequestDispatcher("products.jsp").forward(request, response);
        }
    }
}