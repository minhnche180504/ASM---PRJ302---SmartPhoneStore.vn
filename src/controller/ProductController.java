package controller;

import model.Category;
import model.Product;
import service.CategoryService;
import service.ProductService;
import service.impl.CategoryServiceImpl;
import service.impl.ProductServiceImpl;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * Product Controller
 * Điều khiển trang sản phẩm
 */
@WebServlet("/products")
public class ProductController extends HttpServlet {
    
    private ProductService productService;
    private CategoryService categoryService;
    
    @Override
    public void init() throws ServletException {
        productService = new ProductServiceImpl();
        categoryService = new CategoryServiceImpl();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String categoryId = request.getParameter("category");
            String brand = request.getParameter("brand");
            String minPrice = request.getParameter("minPrice");
            String maxPrice = request.getParameter("maxPrice");
            String search = request.getParameter("search");
            
            List<Product> products;
            
            if (search != null && !search.trim().isEmpty()) {
                // Search products
                products = productService.searchProducts(search);
                request.setAttribute("searchQuery", search);
            } else if (categoryId != null && !categoryId.isEmpty()) {
                // Filter by category
                products = productService.getProductsByCategory(Integer.parseInt(categoryId));
                request.setAttribute("selectedCategory", categoryId);
            } else if (brand != null && !brand.isEmpty()) {
                // Filter by brand
                products = productService.getProductsByBrand(brand);
                request.setAttribute("selectedBrand", brand);
            } else if (minPrice != null && maxPrice != null && !minPrice.isEmpty() && !maxPrice.isEmpty()) {
                // Filter by price range
                products = productService.getProductsByPriceRange(
                    new BigDecimal(minPrice), 
                    new BigDecimal(maxPrice)
                );
                request.setAttribute("minPrice", minPrice);
                request.setAttribute("maxPrice", maxPrice);
            } else {
                // Get all products
                products = productService.getAllProducts();
            }
            
            // Get all categories for filter
            List<Category> categories = categoryService.getAllCategories();
            request.setAttribute("categories", categories);
            request.setAttribute("products", products);
            
            request.getRequestDispatcher("/WEB-INF/view/public/Products.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }
}

