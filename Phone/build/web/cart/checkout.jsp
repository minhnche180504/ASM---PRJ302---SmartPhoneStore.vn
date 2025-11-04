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
            font-family: 'Segoe UI', Arial, sans-serif;
            margin: 0;
            background: #f5f5f5;
        }
        .checkout-container {
            max-width: 980px;
            margin: 40px auto;
            background: #fff;
            border-radius: 14px;
            box-shadow: 0 4px 32px rgba(0,0,0,0.10);
            padding: 0;
            overflow: hidden;
        }
        .checkout-header {
            background: linear-gradient(90deg, #007bff 60%, #00c6ff 100%);
            color: white;
            padding: 28px 40px 18px 40px;
            border-radius: 14px 14px 0 0;
            font-size: 2rem;
            font-weight: 600;
            letter-spacing: 1px;
        }
        .checkout-content {
            display: flex;
            gap: 36px;
            padding: 36px 40px 32px 40px;
        }
        .checkout-form {
            flex: 1.2;
        }
        .checkout-summary {
            flex: 1;
            background: #f8fafd;
            border-radius: 10px;
            box-shadow: 0 2px 12px rgba(0,0,0,0.04);
            padding: 28px 24px 18px 24px;
            margin-top: 0;
            min-width: 260px;
        }
        .form-group {
            margin-bottom: 18px;
        }
        label {
            display: block;
            margin-bottom: 7px;
            font-weight: 600;
            color: #222;
        }
        input, textarea {
            width: 100%;
            padding: 10px 12px;
            border: 1px solid #d0d7de;
            border-radius: 5px;
            font-size: 1rem;
            background: #f9f9f9;
            transition: border 0.2s;
        }
        input:focus, textarea:focus {
            border: 1.5px solid #007bff;
            outline: none;
            background: #fff;
        }
        textarea {
            height: 80px;
            resize: vertical;
        }
        .btn {
            background: linear-gradient(90deg, #28a745 60%, #00c851 100%);
            color: white;
            padding: 12px 32px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 1.1rem;
            font-weight: 600;
            margin-right: 10px;
            box-shadow: 0 2px 8px rgba(40,167,69,0.08);
            transition: background 0.2s, box-shadow 0.2s;
        }
        .btn:hover {
            background: linear-gradient(90deg, #218838 60%, #00b44b 100%);
            box-shadow: 0 4px 16px rgba(40,167,69,0.13);
        }
        .btn-secondary {
            background: #6c757d;
            color: white;
            padding: 12px 24px;
        }
        .btn-secondary:hover {
            background: #545b62;
        }
        .checkout-summary h3 {
            color: #007bff;
            font-size: 1.2rem;
            margin-bottom: 12px;
        }
        .checkout-summary ul {
            padding-left: 18px;
            margin: 8px 0 16px 0;
        }
        .checkout-summary li {
            margin-bottom: 4px;
            color: #333;
        }
        .checkout-summary .total {
            color: #e53935;
            font-size: 1.25rem;
            font-weight: 600;
        }
        .error {
            color: #dc3545;
            background: #f8d7da;
            padding: 12px 18px;
            border-radius: 5px;
            margin-bottom: 20px;
            font-size: 1.05rem;
        }
        .empty-cart {
            text-align: center;
            color: #666;
            padding: 60px 0;
        }
        @media (max-width: 900px) {
            .checkout-content {
                flex-direction: column;
                gap: 18px;
                padding: 24px 10px 18px 10px;
            }
            .checkout-header {
                padding: 18px 10px 12px 10px;
                font-size: 1.3rem;
            }
        }
    </style>
</head>
<body>
    <div class="checkout-container">
        <div class="checkout-header">
            💳 Thanh toán đơn hàng
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
                ⚠️ Bạn cần đăng nhập để thanh toán!<br><br>
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
        <div class="checkout-content">
            <form class="checkout-form" action="<%= request.getContextPath() %>/checkout" method="post">
                <h3 style="color:#007bff; margin-bottom:18px;">🚚 Thông tin giao hàng</h3>
                <div class="form-group">
                    <label for="customerName">Họ tên người nhận *</label>
                    <input type="text" id="customerName" name="customerName" value="<%= currentUser.getFullName() != null ? currentUser.getFullName() : "" %>" required>
                </div>
                <div class="form-group">
                    <label for="customerPhone">Số điện thoại *</label>
                    <input type="tel" id="customerPhone" name="customerPhone" value="<%= currentUser.getPhone() != null ? currentUser.getPhone() : "" %>" required>
                </div>
                <div class="form-group">
                    <label for="customerEmail">Email</label>
                    <input type="email" id="customerEmail" name="customerEmail" value="<%= currentUser.getEmail() != null ? currentUser.getEmail() : "" %>">
                </div>
                <div class="form-group">
                    <label for="customerAddress">Địa chỉ giao hàng *</label>
                    <textarea id="customerAddress" name="customerAddress" required><%= currentUser.getAddress() != null ? currentUser.getAddress() : "" %></textarea>
                </div>
                <div class="form-group">
                    <label for="orderNote">Ghi chú đơn hàng</label>
                    <textarea id="orderNote" name="orderNote" placeholder="Ghi chú về đơn hàng (không bắt buộc)"></textarea>
                </div>
                <div style="margin-top: 24px; display: flex; gap: 12px;">
                    <a href="<%= request.getContextPath() %>/cart" class="btn btn-secondary">⬅️ Quay lại giỏ hàng</a>
                    <button type="submit" class="btn">✅ Đặt hàng ngay</button>
                </div>
            </form>
            <div class="checkout-summary">
                <h3>📦 Thông tin đơn hàng</h3>
                <p><strong>Số lượng sản phẩm:</strong> <%= cart.size() %> sản phẩm</p>
                <div style="margin: 10px 0 0 0;">
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
                <p style="margin-top: 18px;"><strong>Tổng tiền:</strong> <span class="total"><%= String.format("%,.0f", total) %> VND</span></p>
            </div>
        </div>
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