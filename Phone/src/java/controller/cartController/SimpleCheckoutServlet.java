package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet("/checkout")
public class SimpleCheckoutServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        System.out.println("🔍 SimpleCheckoutServlet - doGet called");
        System.out.println("Request URI: " + request.getRequestURI());
        System.out.println("Context Path: " + request.getContextPath());
        
        try {
            // Thử forward đến checkout.jsp
            request.getRequestDispatcher("/checkout.jsp").forward(request, response);
            System.out.println("✅ Successfully forwarded to checkout.jsp");
        } catch (Exception e) {
            System.err.println("❌ Error forwarding to checkout.jsp: " + e.getMessage());
            e.printStackTrace();
            
            // Fallback: Hiển thị HTML đơn giản
            response.setContentType("text/html;charset=UTF-8");
            PrintWriter out = response.getWriter();
            
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Checkout - Debug</title>");
            out.println("<meta charset='UTF-8'>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>🔧 Checkout Debug Page</h1>");
            out.println("<p>CheckoutServlet is working!</p>");
            out.println("<p>Time: " + new java.util.Date() + "</p>");
            out.println("<p>Request URI: " + request.getRequestURI() + "</p>");
            out.println("<p>Context Path: " + request.getContextPath() + "</p>");
            out.println("<a href='" + request.getContextPath() + "/cart'>← Back to Cart</a>");
            out.println("</body>");
            out.println("</html>");
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        System.out.println("🔍 SimpleCheckoutServlet - doPost called");
        
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        
        out.println("<!DOCTYPE html>");
        out.println("<html>");
        out.println("<head>");
        out.println("<title>Order Processed</title>");
        out.println("<meta charset='UTF-8'>");
        out.println("</head>");
        out.println("<body>");
        out.println("<h1>✅ Order Processed (Debug)</h1>");
        out.println("<p>POST request received successfully!</p>");
        out.println("<p>Time: " + new java.util.Date() + "</p>");
        out.println("<a href='" + request.getContextPath() + "/home'>Go Home</a>");
        out.println("</body>");
        out.println("</html>");
    }
    
    @Override
    public void init() throws ServletException {
        System.out.println("🚀 SimpleCheckoutServlet initialized!");
        super.init();
    }
}