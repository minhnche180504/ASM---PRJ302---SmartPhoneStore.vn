package controller.admin;

import model.Category;
import model.Product;
import model.User;
import service.CategoryService;
import service.ProductService;
import service.impl.CategoryServiceImpl;
import service.impl.ProductServiceImpl;
import java.io.IOException;
import java.math.BigDecimal;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 * Admin Product Controller
 * Điều khiển quản lý sản phẩm
 */
@WebServlet("/admin/products")
public class AdminProductController extends HttpServlet {
    
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
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        if (user == null || !user.isAdmin()) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        String action = request.getParameter("action");
        
        if ("edit".equals(action)) {
            String productId = request.getParameter("id");
            if (productId != null) {
                Product product = productService.getProductById(Integer.parseInt(productId));
                request.setAttribute("product", product);
            }
            request.setAttribute("categories", categoryService.getAllCategories());
            request.getRequestDispatcher("/WEB-INF/view/admin/ProductForm.jsp").forward(request, response);
        } else if ("add".equals(action)) {
            request.setAttribute("categories", categoryService.getAllCategories());
            request.getRequestDispatcher("/WEB-INF/view/admin/ProductForm.jsp").forward(request, response);
        } else {
            request.setAttribute("products", productService.getAllProducts());
            request.setAttribute("categories", categoryService.getAllCategories());
            request.getRequestDispatcher("/WEB-INF/view/admin/ProductManagement.jsp").forward(request, response);
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        if (user == null || !user.isAdmin()) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        String action = request.getParameter("action");
        
        if ("create".equals(action) || "update".equals(action)) {
            String productId = request.getParameter("productId");
            String pName = request.getParameter("pName");
            String brand = request.getParameter("brand");
            String price = request.getParameter("price");
            String stock = request.getParameter("stock");
            String description = request.getParameter("description");
            String imageUrl = request.getParameter("imageUrl");
            String catId = request.getParameter("catId");
            
            Product product = new Product();
            product.setPName(pName);
            product.setBrand(brand);
            product.setPrice(new BigDecimal(price));
            product.setStock(Integer.parseInt(stock));
            product.setDescription(description);
            product.setImageUrl(imageUrl);
            product.setCatId(Integer.parseInt(catId));
            
            boolean success = false;
            if ("update".equals(action) && productId != null && !productId.isEmpty()) {
                product.setPId(Integer.parseInt(productId));
                success = productService.updateProduct(product);
            } else {
                success = productService.createProduct(product);
            }
            
            if (success) {
                response.sendRedirect(request.getContextPath() + "/admin/products?success=true");
            } else {
                request.setAttribute("error", "Lỗi khi lưu sản phẩm!");
                request.setAttribute("categories", categoryService.getAllCategories());
                request.getRequestDispatcher("/WEB-INF/view/admin/ProductForm.jsp").forward(request, response);
            }
        } else if ("delete".equals(action)) {
            String productId = request.getParameter("id");
            if (productId != null) {
                productService.deleteProduct(Integer.parseInt(productId));
            }
            response.sendRedirect(request.getContextPath() + "/admin/products");
        }
    }
}

