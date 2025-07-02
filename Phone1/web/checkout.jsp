<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Product" %>
<%@ page import="model.User" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Thanh toán - SmartPhoneStore.vn</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
            background: #f5f5f5;
        }
        .container {
            max-width: 800px;
            margin: 0 auto;
            background: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        .header {
            background: #007bff;
            color: white;
            padding: 10px 20px;
            margin: -20px -20px 20px -20px;
            border-radius: 8px 8px 0 0;
        }
        .form-group {
            margin-bottom: 15px;
        }
        label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
        }
        input, textarea {
            width: 100%;
            padding: 8px;
            border: 1px solid #ddd;
            border-radius: 4px;
            box-sizing: border-box;
        }
        textarea {
            height: 80px;
            resize: vertical;
        }
        .btn {
            background: #28a745;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
            margin-right: 10px;
        }
        .btn:hover {
            background: #218838;
        }
        .btn-secondary {
            background: #6c757d;
        }
        .btn-secondary:hover {
            background: #545b62;
        }
        .cart-summary {
            background: #f8f9fa;
            padding: 15px;
            border-radius: 4px;
            margin-bottom: 20px;
            border-left: 4px solid #007bff;
        }
        .error {
            color: #dc3545;
            background: #f8d7da;
            padding: 10px;
            border-radius: 4px;
            margin-bottom: 20px;
        }
        .empty-cart {
            text-align: center;
            color: #666;
            padding: 40px;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>💳 Thanh toán đơn hàng</h1>
        </div>
        
        <%
            System.out.println("🔍 checkout.jsp is loading...");
            
            // Lấy thông tin từ session
            @SuppressWarnings("unchecked")
            List<Product> cart = (List<Product>) session.getAttribute("cart");
            User currentUser = (User) session.getAttribute("user");
            String error = (String) request.getAttribute("error");
            
            System.out.println("Cart size: " + (cart != null ? cart.size() : "null"));
            System.out.println("Current user: " + (currentUser != null ? currentUser.getUsername() : "null"));
            
            if (error != null) {
        %>
            <div class="error">⚠️ <%= error %></div>
        <%
            }
            
            if (currentUser == null) {
        %>
            <div class="error">
                ⚠️ Bạn cần đăng nhập để thanh toán!
                <br><br>
                <a href="<%= request.getContextPath() %>/login" class="btn">🔐 Đăng nhập</a>
                <a href="<%= request.getContextPath() %>/cart" class="btn btn-secondary">⬅️ Quay lại giỏ hàng</a>
            </div>
        <%
            } else if (cart == null || cart.isEmpty()) {
        %>
            <div class="empty-cart">
                <h3>🛒 Giỏ hàng trống</h3>
                <p>Bạn chưa có sản phẩm nào trong giỏ hàng.</p>
                <a href="<%= request.getContextPath() %>/products" class="btn">📱 Mua sắm ngay</a>
                <a href="<%= request.getContextPath() %>/cart" class="btn btn-secondary">⬅️ Quay lại giỏ hàng</a>
            </div>
        <%
            } else {
                double total = 0;
                for (Product product : cart) {
                    total += product.getPrice();
                }
        %>
            <!-- Tóm tắt đơn hàng -->
            <div class="cart-summary">
                <h3>📦 Thông tin đơn hàng</h3>
                <p><strong>Số lượng sản phẩm:</strong> <%= cart.size() %> sản phẩm</p>
                
                <div style="margin: 10px 0;">
                    <strong>Danh sách sản phẩm:</strong>
                    <ul>
                        <%
                            for (Product product : cart) {
                        %>
                        <li><%= product.getName() %> - <%= String.format("%,.0f", product.getPrice()) %> VND</li>
                        <%
                            }
                        %>
                    </ul>
                </div>
                
                <p><strong>Tổng tiền:</strong> <span style="color: #dc3545; font-size: 1.2em;"><%= String.format("%,.0f", total) %> VND</span></p>
            </div>
            
            <!-- Form thông tin giao hàng -->
            <form action="<%= request.getContextPath() %>/checkout" method="post">
                <h3>🚚 Thông tin giao hàng</h3>
                
                <div class="form-group">
                    <label for="customerName">Họ tên người nhận *</label>
                    <input type="text" id="customerName" name="customerName" 
                           value="<%= currentUser.getFullName() != null ? currentUser.getFullName() : "" %>" 
                           required>
                </div>
                
                <div class="form-group">
                    <label for="customerPhone">Số điện thoại *</label>
                    <input type="tel" id="customerPhone" name="customerPhone" 
                           value="<%= currentUser.getPhone() != null ? currentUser.getPhone() : "" %>" 
                           required>
                </div>
                
                <div class="form-group">
                    <label for="customerEmail">Email</label>
                    <input type="email" id="customerEmail" name="customerEmail" 
                           value="<%= currentUser.getEmail() != null ? currentUser.getEmail() : "" %>">
                </div>
                
                <div class="form-group">
                    <label for="customerAddress">Địa chỉ giao hàng *</label>
                    <textarea id="customerAddress" name="customerAddress" required><%= currentUser.getAddress() != null ? currentUser.getAddress() : "" %></textarea>
                </div>
                
                <div class="form-group">
                    <label for="orderNote">Ghi chú đơn hàng</label>
                    <textarea id="orderNote" name="orderNote" placeholder="Ghi chú về đơn hàng (không bắt buộc)"></textarea>
                </div>
                
                <div style="margin-top: 20px;">
                    <a href="<%= request.getContextPath() %>/cart" class="btn btn-secondary">⬅️ Quay lại giỏ hàng</a>
                    <button type="submit" class="btn">✅ Đặt hàng ngay</button>
                </div>
            </form>
        <%
            }
        %>
        
        <div style="margin-top: 30px; padding-top: 20px; border-top: 1px solid #ddd; text-align: center; color: #666;">
            <p>📞 Hỗ trợ: 0917.509.195 | 📧 support@smartphonestore.vn</p>
            <p><small>Debug: checkout.jsp loaded successfully at <%= new java.util.Date() %></small></p>
        </div>
    </div>

    <script>
        console.log('✅ checkout.jsp JavaScript loaded');
        
        // Simple form validation
        document.querySelector('form').addEventListener('submit', function(e) {
            const name = document.getElementById('customerName').value.trim();
            const phone = document.getElementById('customerPhone').value.trim();
            const address = document.getElementById('customerAddress').value.trim();
            
            if (!name || !phone || !address) {
                alert('⚠️ Vui lòng điền đầy đủ thông tin bắt buộc!');
                e.preventDefault();
                return false;
            }
            
            if (!confirm('🛒 Xác nhận đặt hàng?')) {
                e.preventDefault();
                return false;
            }
        });
    </script>
</body>
</html>