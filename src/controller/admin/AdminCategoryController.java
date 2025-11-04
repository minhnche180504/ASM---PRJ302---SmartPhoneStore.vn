package controller.admin;

import model.Category;
import model.User;
import service.CategoryService;
import service.impl.CategoryServiceImpl;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 * Admin Category Controller
 * Điều khiển quản lý danh mục
 */
@WebServlet("/admin/categories")
public class AdminCategoryController extends HttpServlet {
    
    private CategoryService categoryService;
    
    @Override
    public void init() throws ServletException {
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
            String catId = request.getParameter("id");
            if (catId != null) {
                Category category = categoryService.getCategoryById(Integer.parseInt(catId));
                request.setAttribute("category", category);
            }
            request.getRequestDispatcher("/WEB-INF/view/admin/CategoryForm.jsp").forward(request, response);
        } else {
            request.setAttribute("categories", categoryService.getAllCategories());
            request.getRequestDispatcher("/WEB-INF/view/admin/CategoryManagement.jsp").forward(request, response);
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
            String catId = request.getParameter("catId");
            String catName = request.getParameter("catName");
            String description = request.getParameter("description");
            
            Category category = new Category();
            category.setCatName(catName);
            category.setDescription(description);
            
            boolean success = false;
            if ("update".equals(action) && catId != null && !catId.isEmpty()) {
                category.setCatId(Integer.parseInt(catId));
                success = categoryService.updateCategory(category);
            } else {
                success = categoryService.createCategory(category);
            }
            
            if (success) {
                response.sendRedirect(request.getContextPath() + "/admin/categories?success=true");
            } else {
                request.setAttribute("error", "Lỗi khi lưu danh mục!");
                request.getRequestDispatcher("/WEB-INF/view/admin/CategoryForm.jsp").forward(request, response);
            }
        } else if ("delete".equals(action)) {
            String catId = request.getParameter("id");
            if (catId != null) {
                categoryService.deleteCategory(Integer.parseInt(catId));
            }
            response.sendRedirect(request.getContextPath() + "/admin/categories");
        }
    }
}

