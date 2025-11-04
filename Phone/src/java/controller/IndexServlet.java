package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Servlet xử lý route mặc định - chuyển hướng về trang home
 */
@WebServlet(name = "IndexServlet", urlPatterns = {"", "/", "/index"})
public class IndexServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Chuyển hướng về trang home khi truy cập root URL
        response.sendRedirect(request.getContextPath() + "/home");
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // POST cũng chuyển về home
        doGet(request, response);
    }
}