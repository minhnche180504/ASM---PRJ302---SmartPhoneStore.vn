package controller.cartController;

import dao.ProductDAO;
import model.Product;
import model.CartItem;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

/**
 * Servlet xử lý thêm sản phẩm vào giỏ hàng
 * 
 * Chức năng:
 * - Thêm sản phẩm mới vào giỏ hàng
 * - Nếu sản phẩm đã có trong giỏ -> tăng số lượng
 * - Nếu sản phẩm chưa có -> thêm mới với số lượng = 1
 * 
 * @author SmartPhone Store Team
 * @version 2.0 (Updated to use CartItem)
 */
@WebServlet("/addToCart")
public class AddToCartServlet extends HttpServlet {
    
    private ProductDAO productDAO = new ProductDAO();
    
    /**
     * Xử lý POST request - Thêm sản phẩm vào giỏ hàng
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Lấy productId từ form
        String productIdStr = request.getParameter("productId");
        
        if (productIdStr != null && !productIdStr.trim().isEmpty()) {
            try {
                int productId = Integer.parseInt(productIdStr);
                
                // Lấy session để lưu giỏ hàng
                HttpSession session = request.getSession();
                
                // Lấy giỏ hàng từ session
                Object cartObj = session.getAttribute("cart");
                List<CartItem> cart = null;
                
                // Xử lý backward compatibility với cart cũ (List<Product>)
                if (cartObj instanceof List) {
                    @SuppressWarnings("unchecked")
                    List<?> tempList = (List<?>) cartObj;
                    
                    if (!tempList.isEmpty() && tempList.get(0) instanceof Product) {
                        // Convert từ format cũ sang format mới
                        cart = new ArrayList<>();
                        for (Object obj : tempList) {
                            cart.add(new CartItem((Product) obj, 1));
                        }
                    } else if (tempList.isEmpty() || tempList.get(0) instanceof CartItem) {
                        @SuppressWarnings("unchecked")
                        List<CartItem> temp = (List<CartItem>) tempList;
                        cart = temp;
                    }
                }
                
                // Nếu cart vẫn null, tạo mới
                if (cart == null) {
                    cart = new ArrayList<>();
                }
                
                // Tìm sản phẩm theo ID từ database
                Product product = productDAO.getProductById(productId);
                if (product != null) {
                    // Kiểm tra xem sản phẩm đã có trong giỏ chưa
                    boolean found = false;
                    for (CartItem item : cart) {
                        if (item.getProduct().getId() == productId) {
                            // Sản phẩm đã có -> tăng số lượng
                            item.incrementQuantity();
                            found = true;
                            session.setAttribute("cartMessage", "Đã thêm " + product.getName() + " vào giỏ hàng! (Số lượng: " + item.getQuantity() + ")");
                            break;
                        }
                    }
                    
                    // Nếu chưa có trong giỏ -> thêm mới
                    if (!found) {
                        cart.add(new CartItem(product, 1));
                        session.setAttribute("cartMessage", "Đã thêm " + product.getName() + " vào giỏ hàng!");
                    }
                    
                    // Cập nhật cart vào session
                    session.setAttribute("cart", cart);
                    session.setAttribute("cartMessageType", "success");
                    
                    System.out.println("✅ Added to cart: " + product.getName() + " (Total items: " + cart.size() + ")");
                } else {
                    session.setAttribute("cartMessage", "Không tìm thấy sản phẩm!");
                    session.setAttribute("cartMessageType", "error");
                }
                
            } catch (NumberFormatException e) {
                HttpSession session = request.getSession();
                session.setAttribute("cartMessage", "ID sản phẩm không hợp lệ!");
                session.setAttribute("cartMessageType", "error");
            } catch (Exception e) {
                System.err.println("Lỗi trong AddToCartServlet: " + e.getMessage());
                e.printStackTrace();
                
                HttpSession session = request.getSession();
                session.setAttribute("cartMessage", "Có lỗi xảy ra khi thêm sản phẩm vào giỏ hàng!");
                session.setAttribute("cartMessageType", "error");
            }
        } else {
            HttpSession session = request.getSession();
            session.setAttribute("cartMessage", "Thiếu thông tin sản phẩm!");
            session.setAttribute("cartMessageType", "error");
        }
        
        // Redirect về trang home (tránh resubmit form)
        response.sendRedirect(request.getContextPath() + "/home");
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // GET request chuyển về home
        response.sendRedirect(request.getContextPath() + "/home");
    }
}