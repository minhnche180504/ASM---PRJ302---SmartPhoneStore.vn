<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Product" %>
<%@ page import="model.User" %>
<jsp:include page="header.jsp" />

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Giỏ hàng - SmartPhoneStore.vn</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: #f9f9f9;
            margin: 0;
            padding: 0;
        }
        .cart-container {
            max-width: 1000px;
            margin: 30px auto;
            background: white;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        .cart-title {
            font-size: 2rem;
            color: #2c3e50;
            margin-bottom: 20px;
            border-bottom: 3px solid #3498db;
            padding-bottom: 10px;
        }
        .cart-table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
        }
        .cart-table th,
        .cart-table td {
            border: 1px solid #ddd;
            padding: 12px;
            text-align: left;
        }
        .cart-table th {
            background: #f8f9fa;
            font-weight: bold;
        }
        .cart-table img {
            width: 60px;
            height: 60px;
            object-fit: cover;
            border-radius: 4px;
        }
        .cart-total {
            text-align: right;
            font-size: 1.3rem;
            font-weight: bold;
            color: #e74c3c;
            margin: 20px 0;
            padding: 15px;
            background: #f8f9fa;
            border-radius: 4px;
        }
        .cart-actions {
            display: flex;
            gap: 15px;
            justify-content: flex-end;
            margin-top: 20px;
            flex-wrap: wrap;
        }
        .btn {
            padding: 12px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 1rem;
            text-decoration: none;
            display: inline-block;
            text-align: center;
            transition: all 0.3s ease;
        }
        .btn-primary {
            background: #007bff;
            color: white;
        }
        .btn-success {
            background: #28a745;
            color: white;
        }
        .btn-danger {
            background: #dc3545;
            color: white;
        }
        .btn-secondary {
            background: #6c757d;
            color: white;
        }
        .btn-warning {
            background: #ffc107;
            color: #212529;
        }
        .btn-info {
            background: #17a2b8;
            color: white;
        }
        .btn:hover {
            opacity: 0.9;
            transform: translateY(-2px);
        }
        .empty-cart {
            text-align: center;
            color: #666;
            font-size: 1.1rem;
            padding: 40px;
        }
        .remove-btn {
            background: #dc3545;
            color: white;
            border: none;
            padding: 6px 12px;
            border-radius: 4px;
            cursor: pointer;
            font-size: 0.9rem;
        }
        .remove-btn:hover {
            background: #c82333;
        }
        .cart-message {
            padding: 12px 20px;
            margin-bottom: 20px;
            border-radius: 4px;
            border: 1px solid transparent;
        }
        .cart-message.success {
            color: #155724;
            background-color: #d4edda;
            border-color: #c3e6cb;
        }
        .cart-message.error {
            color: #721c24;
            background-color: #f8d7da;
            border-color: #f5c6cb;
        }
        .cart-summary {
            background: #f8f9fa;
            padding: 20px;
            border-radius: 8px;
            margin: 20px 0;
            border-left: 4px solid #007bff;
        }
        .summary-row {
            display: flex;
            justify-content: space-between;
            margin-bottom: 10px;
            padding: 5px 0;
        }
        .login-notice {
            background: #fff3cd;
            border: 1px solid #ffeaa7;
            padding: 20px;
            border-radius: 8px;
            text-align: center;
            margin: 20px 0;
        }
        .login-notice p {
            margin-bottom: 15px;
            color: #856404;
            font-weight: 500;
        }
        .suggested-products {
            margin-top: 40px;
            padding: 20px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border-radius: 12px;
            color: white;
            text-align: center;
        }
        .suggested-products h3 {
            margin-bottom: 10px;
            font-size: 1.5rem;
        }
        .suggestion-note p {
            margin-bottom: 15px;
            opacity: 0.9;
        }
        .btn-outline {
            background: transparent;
            border: 2px solid #007bff;
            color: #007bff;
        }
        .btn-outline:hover {
            background: #007bff;
            color: white;
        }
        .cart-support {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 20px;
            margin-top: 30px;
            padding: 20px 0;
            border-top: 1px solid #dee2e6;
        }
        .support-item {
            display: flex;
            align-items: center;
            gap: 15px;
            padding: 15px;
            background: #f8f9fa;
            border-radius: 8px;
            transition: all 0.3s ease;
        }
        .support-item:hover {
            background: #e9ecef;
            transform: translateY(-2px);
        }
        .support-icon {
            font-size: 2rem;
            flex-shrink: 0;
        }
        .support-text strong {
            display: block;
            color: #2c3e50;
            margin-bottom: 5px;
        }
        .support-text p {
            margin: 0;
            color: #6c757d;
            font-size: 0.9rem;
        }
        
        @media (max-width: 768px) {
            .cart-actions {
                flex-direction: column;
                align-items: stretch;
            }
            .cart-table {
                font-size: 0.9rem;
            }
            .cart-table img {
                width: 40px;
                height: 40px;
            }
            .cart-support {
                grid-template-columns: 1fr;
                gap: 15px;
            }
        }
    </style>
</head>
<body>
    <div class="cart-container">
        <h1 class="cart-title">Giỏ hàng của bạn</h1>
        
        <%
            // Hiển thị thông báo từ session
            String cartMessage = (String) session.getAttribute("cartMessage");
            String cartMessageType = (String) session.getAttribute("cartMessageType");
            
            if (cartMessage != null) {
                session.removeAttribute("cartMessage");
                session.removeAttribute("cartMessageType");
        %>
            <div class="cart-message <%= cartMessageType %>">
                <%= cartMessage %>
            </div>
        <%
            }
            
            @SuppressWarnings("unchecked")
            List<Product> cart = (List<Product>) session.getAttribute("cart");
            User currentUser = (User) session.getAttribute("user");
            
            if (cart == null || cart.isEmpty()) {
        %>
            <div class="empty-cart">
                <h3>🛒 Giỏ hàng của bạn đang trống</h3>
                <p>Hãy khám phá những sản phẩm tuyệt vời của chúng tôi!</p>
                <a href="<%= request.getContextPath() %>/home" class="btn btn-primary">🏠 Tiếp tục mua sắm</a>
                <a href="<%= request.getContextPath() %>/products" class="btn btn-secondary">📱 Xem tất cả sản phẩm</a>
            </div>
        <%
            } else {
                double total = 0;
        %>
            <table class="cart-table">
                <thead>
                    <tr>
                        <th>Hình ảnh</th>
                        <th>Tên sản phẩm</th>
                        <th>Giá</th>
                        <th>Số lượng</th>
                        <th>Thành tiền</th>
                        <th>Thao tác</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        for (int i = 0; i < cart.size(); i++) {
                            Product product = cart.get(i);
                            total += product.getPrice();
                    %>
                    <tr>
                        <td>
                            <% if (product.getImage() != null && !product.getImage().isEmpty()) { %>
                                <img src="<%= product.getImage() %>" alt="<%= product.getName() %>">
                            <% } else { %>
                                <div style="width: 60px; height: 60px; background: #f0f0f0; display: flex; align-items: center; justify-content: center; border-radius: 4px; color: #999; font-size: 0.8rem;">📱</div>
                            <% } %>
                        </td>
                        <td><%= product.getName() %></td>
                        <td><%= String.format("%,.0f", product.getPrice()) %> VND</td>
                        <td>
                            <span>1</span>
                        </td>
                        <td><%= String.format("%,.0f", product.getPrice()) %> VND</td>
                        <td>
                            <form action="<%= request.getContextPath() %>/cart/remove" method="post" style="display: inline;">
                                <input type="hidden" name="productIndex" value="<%= i %>">
                                <button type="submit" class="remove-btn" onclick="return confirm('Bạn có chắc muốn xóa sản phẩm này?')">
                                    🗑️ Xóa
                                </button>
                            </form>
                        </td>
                    </tr>
                    <%
                        }
                    %>
                </tbody>
            </table>
            
            <div class="cart-summary">
                <div class="summary-row">
                    <span>Số lượng sản phẩm:</span>
                    <span><%= cart.size() %> sản phẩm</span>
                </div>
                <div class="summary-row">
                    <span>Tạm tính:</span>
                    <span><%= String.format("%,.0f", total) %> VND</span>
                </div>
                <div class="summary-row">
                    <span>Phí vận chuyển:</span>
                    <span>Miễn phí</span>
                </div>
                <div class="cart-total">
                    <div class="summary-row">
                        <span>Tổng cộng:</span>
                        <span><%= String.format("%,.0f", total) %> VND</span>
                    </div>
                </div>
            </div>
            
            <div class="cart-actions">
                <a href="<%= request.getContextPath() %>/home" class="btn btn-primary">
                    🏠 Tiếp tục mua sắm
                </a>
                
                <a href="<%= request.getContextPath() %>/products" class="btn btn-secondary">
                    📱 Xem tất cả sản phẩm
                </a>
                
                <form action="<%= request.getContextPath() %>/cart/clear" method="post" style="display: inline;">
                    <button type="submit" class="btn btn-danger" onclick="return confirm('Bạn có chắc muốn xóa toàn bộ giỏ hàng?')">
                        🗑️ Xóa giỏ hàng
                    </button>
                </form>
                
                <% if (currentUser != null) { %>
                    <a href="<%= request.getContextPath() %>/checkout" class="btn btn-success btn-checkout">
                        💳 Thanh toán ngay
                    </a>
                <% } else { %>
                    <div class="login-notice">
                        <p>⚠️ Vui lòng đăng nhập để tiếp tục thanh toán</p>
                        <a href="<%= request.getContextPath() %>/login" class="btn btn-warning">
                            🔐 Đăng nhập
                        </a>
                        <span style="margin: 0 10px;">hoặc</span>
                        <a href="<%= request.getContextPath() %>/register" class="btn btn-info">
                            📝 Đăng ký
                        </a>
                    </div>
                <% } %>
            </div>
            
            <!-- Phần gợi ý sản phẩm -->
            <div class="suggested-products">
                <h3>🔥 Có thể bạn quan tâm</h3>
                <div class="suggestion-note">
                    <p>Khám phá thêm các sản phẩm hot nhất tại SmartPhoneStore.vn</p>
                    <a href="<%= request.getContextPath() %>/products" class="btn btn-outline">✨ Xem thêm sản phẩm</a>
                </div>
            </div>
            
        <%
            }
        %>
        
        <!-- Thông tin hỗ trợ -->
        <div class="cart-support">
            <div class="support-item">
                <div class="support-icon">🚚</div>
                <div class="support-text">
                    <strong>Miễn phí vận chuyển</strong>
                    <p>Đơn hàng từ 500.000 VND</p>
                </div>
            </div>
            <div class="support-item">
                <div class="support-icon">🔄</div>
                <div class="support-text">
                    <strong>Đổi trả dễ dàng</strong>
                    <p>Trong vòng 7 ngày</p>
                </div>
            </div>
            <div class="support-item">
                <div class="support-icon">📞</div>
                <div class="support-text">
                    <strong>Hỗ trợ 24/7</strong>
                    <p>Hotline: 0917.509.195</p>
                </div>
            </div>
            <div class="support-item">
                <div class="support-icon">🛡️</div>
                <div class="support-text">
                    <strong>Bảo hành chính hãng</strong>
                    <p>Toàn quốc</p>
                </div>
            </div>
        </div>
    </div>

    <script>
        // Auto hide cart messages sau 5 giây
        document.addEventListener('DOMContentLoaded', function() {
            const cartMessages = document.querySelectorAll('.cart-message');
            cartMessages.forEach(message => {
                setTimeout(() => {
                    message.style.opacity = '0';
                    setTimeout(() => {
                        message.style.display = 'none';
                    }, 500);
                }, 5000);
            });
            
            // Hiệu ứng loading khi submit form
            const forms = document.querySelectorAll('form');
            forms.forEach(form => {
                form.addEventListener('submit', function() {
                    const submitBtn = form.querySelector('button[type="submit"]');
                    if (submitBtn) {
                        submitBtn.innerHTML = '⏳ Đang xử lý...';
                        submitBtn.disabled = true;
                    }
                });
            });
            
            // Hiệu ứng hover cho các button
            const buttons = document.querySelectorAll('.btn');
            buttons.forEach(btn => {
                btn.addEventListener('mouseenter', function() {
                    this.style.transform = 'translateY(-2px)';
                    this.style.boxShadow = '0 4px 8px rgba(0,0,0,0.2)';
                });
                btn.addEventListener('mouseleave', function() {
                    this.style.transform = 'translateY(0)';
                    this.style.boxShadow = 'none';
                });
            });
        });
        
        // Smooth scroll và confirmation
        function confirmRemove(productName) {
            return confirm(`Bạn có chắc muốn xóa "${productName}" khỏi giỏ hàng?`);
        }
    </script>
</body>
</html>