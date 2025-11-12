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

@WebServlet(name = "ProductCrudServlet", urlPatterns = {
    "/admin/products/add",
    "/admin/products/edit", 
    "/admin/products/delete",
    "/admin/products/update"
})
public class ProductCrudServlet extends HttpServlet {
    
    private ProductDAO productDAO;
    
    @Override
    public void init() throws ServletException {
        productDAO = new ProductDAO();
        System.out.println("🔧 ProductCrudServlet initialized");
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Kiểm tra quyền admin
        if (!isAdmin(request, response)) {
            return;
        }
        
        String action = getAction(request.getRequestURI());
        System.out.println("👨‍💼 ProductCrudServlet GET action: " + action);
        
        switch (action) {
            case "edit":
                handleEditGet(request, response);
                break;
            case "delete":
                handleDelete(request, response);
                break;
            default:
                response.sendRedirect(request.getContextPath() + "/admin/products");
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
        System.out.println("👨‍💼 ProductCrudServlet POST action: " + action);
        
        switch (action) {
            case "add":
                handleAdd(request, response);
                break;
            case "update":
                handleUpdate(request, response);
                break;
            default:
                response.sendRedirect(request.getContextPath() + "/admin/products");
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
            String name = request.getParameter("name");
            String priceStr = request.getParameter("price");
            String description = request.getParameter("description");
            String image = request.getParameter("image");
            
            // Validate input
            if (name == null || name.trim().isEmpty()) {
                setMessage(request, "error", "Tên sản phẩm không được để trống!");
                response.sendRedirect(request.getContextPath() + "/admin/products");
                return;
            }
            
            if (priceStr == null || priceStr.trim().isEmpty()) {
                setMessage(request, "error", "Giá sản phẩm không được để trống!");
                response.sendRedirect(request.getContextPath() + "/admin/products");
                return;
            }
            
            double price;
            try {
                price = Double.parseDouble(priceStr);
                if (price < 0) {
                    setMessage(request, "error", "Giá sản phẩm phải lớn hơn 0!");
                    response.sendRedirect(request.getContextPath() + "/admin/products");
                    return;
                }
            } catch (NumberFormatException e) {
                setMessage(request, "error", "Giá sản phẩm không hợp lệ!");
                response.sendRedirect(request.getContextPath() + "/admin/products");
                return;
            }
            
            // Tạo sản phẩm mới
            Product newProduct = new Product();
            newProduct.setName(name.trim());
            newProduct.setPrice(price);
            newProduct.setDescription(description != null ? description.trim() : "");
            newProduct.setImage(image != null ? image.trim() : "");
            
            boolean success = productDAO.addProduct(newProduct);
            
            if (success) {
                System.out.println("✅ Product added successfully: " + name);
                setMessage(request, "success", "Thêm sản phẩm thành công!");
            } else {
                setMessage(request, "error", "Có lỗi xảy ra khi thêm sản phẩm!");
            }
            
        } catch (Exception e) {
            System.err.println("❌ Error adding product: " + e.getMessage());
            e.printStackTrace();
            setMessage(request, "error", "Có lỗi xảy ra: " + e.getMessage());
        }
        
        response.sendRedirect(request.getContextPath() + "/admin/products");
    }
    
    private void handleEditGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        try {
            String productIdStr = request.getParameter("id");
            if (productIdStr == null) {
                setMessage(request, "error", "ID sản phẩm không hợp lệ!");
                response.sendRedirect(request.getContextPath() + "/admin/products");
                return;
            }
            
            int productId = Integer.parseInt(productIdStr);
            Product product = productDAO.getProductById(productId);
            
            if (product != null) {
                request.setAttribute("editProduct", product);
                request.getRequestDispatcher("/admin/products").forward(request, response);
            } else {
                setMessage(request, "error", "Không tìm thấy sản phẩm!");
                response.sendRedirect(request.getContextPath() + "/admin/products");
            }
            
        } catch (NumberFormatException e) {
            setMessage(request, "error", "ID sản phẩm không hợp lệ!");
            response.sendRedirect(request.getContextPath() + "/admin/products");
        } catch (Exception e) {
            System.err.println("❌ Error getting product for edit: " + e.getMessage());
            setMessage(request, "error", "Có lỗi xảy ra: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/admin/products");
        }
    }
    
    private void handleUpdate(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        try {
            String productIdStr = request.getParameter("productId");
            if (productIdStr == null) {
                setMessage(request, "error", "ID sản phẩm không hợp lệ!");
                response.sendRedirect(request.getContextPath() + "/admin/products");
                return;
            }
            
            int productId = Integer.parseInt(productIdStr);
            Product product = productDAO.getProductById(productId);
            
            if (product == null) {
                setMessage(request, "error", "Không tìm thấy sản phẩm!");
                response.sendRedirect(request.getContextPath() + "/admin/products");
                return;
            }
            
            // Cập nhật thông tin
            String name = request.getParameter("name");
            String priceStr = request.getParameter("price");
            String description = request.getParameter("description");
            String image = request.getParameter("image");
            
            // Validate input
            if (name == null || name.trim().isEmpty()) {
                setMessage(request, "error", "Tên sản phẩm không được để trống!");
                response.sendRedirect(request.getContextPath() + "/admin/products");
                return;
            }
            
            if (priceStr == null || priceStr.trim().isEmpty()) {
                setMessage(request, "error", "Giá sản phẩm không được để trống!");
                response.sendRedirect(request.getContextPath() + "/admin/products");
                return;
            }
            
            double price;
            try {
                price = Double.parseDouble(priceStr);
                if (price < 0) {
                    setMessage(request, "error", "Giá sản phẩm phải lớn hơn 0!");
                    response.sendRedirect(request.getContextPath() + "/admin/products");
                    return;
                }
            } catch (NumberFormatException e) {
                setMessage(request, "error", "Giá sản phẩm không hợp lệ!");
                response.sendRedirect(request.getContextPath() + "/admin/products");
                return;
            }
            
            product.setName(name.trim());
            product.setPrice(price);
            product.setDescription(description != null ? description.trim() : "");
            product.setImage(image != null ? image.trim() : "");
            
            boolean success = productDAO.updateProduct(product);
            
            if (success) {
                System.out.println("✅ Product updated successfully: " + product.getName());
                setMessage(request, "success", "Cập nhật sản phẩm thành công!");
            } else {
                setMessage(request, "error", "Có lỗi xảy ra khi cập nhật sản phẩm!");
            }
            
        } catch (NumberFormatException e) {
            setMessage(request, "error", "ID sản phẩm không hợp lệ!");
        } catch (Exception e) {
            System.err.println("❌ Error updating product: " + e.getMessage());
            e.printStackTrace();
            setMessage(request, "error", "Có lỗi xảy ra: " + e.getMessage());
        }
        
        response.sendRedirect(request.getContextPath() + "/admin/products");
    }
    
    private void handleDelete(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        try {
            String productIdStr = request.getParameter("id");
            if (productIdStr == null) {
                setMessage(request, "error", "ID sản phẩm không hợp lệ!");
                response.sendRedirect(request.getContextPath() + "/admin/products");
                return;
            }
            
            int productId = Integer.parseInt(productIdStr);
            
            Product productToDelete = productDAO.getProductById(productId);
            if (productToDelete == null) {
                setMessage(request, "error", "Không tìm thấy sản phẩm!");
                response.sendRedirect(request.getContextPath() + "/admin/products");
                return;
            }
            
            // Thực hiện xóa sản phẩm
            boolean success = productDAO.deleteProduct(productId);
            
            if (success) {
                System.out.println("✅ Product deleted successfully: " + productToDelete.getName());
                setMessage(request, "success", "Xóa sản phẩm thành công!");
            } else {
                setMessage(request, "error", "Có lỗi xảy ra khi xóa sản phẩm!");
            }
            
        } catch (NumberFormatException e) {
            setMessage(request, "error", "ID sản phẩm không hợp lệ!");
        } catch (Exception e) {
            System.err.println("❌ Error deleting product: " + e.getMessage());
            setMessage(request, "error", "Có lỗi xảy ra: " + e.getMessage());
        }
        
        response.sendRedirect(request.getContextPath() + "/admin/products");
    }
    
    private void setMessage(HttpServletRequest request, String type, String message) {
        HttpSession session = request.getSession();
        session.setAttribute("messageType", type);
        session.setAttribute("message", message);
    }
    
    @Override
    public void destroy() {
        if (productDAO != null) {
            productDAO.closeConnection();
        }
        System.out.println("🔧 ProductCrudServlet destroyed");
    }
}