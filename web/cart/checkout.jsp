<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Product" %>
<%@ page import="model.CartItem" %>
<%@ page import="model.User" %>
<jsp:include page="/home/header.jsp" />

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thanh toán - SmartPhoneStore.vn</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: 'Inter', 'Segoe UI', -apple-system, BlinkMacSystemFont, sans-serif;
            background: linear-gradient(135deg, #fdfbfb 0%, #f7f4f9 50%, #faf8fc 100%);
            background-attachment: fixed;
            color: #2d3748;
            min-height: 100vh;
        }
        
        .checkout-wrapper {
            max-width: 1400px;
            margin: 40px auto 80px;
            padding: 0 40px;
        }
        
        /* Header */
        .checkout-header {
            background: linear-gradient(135deg, #a78bfa 0%, #c4b5fd 100%);
            color: #ffffff;
            padding: 40px;
            border-radius: 24px;
            margin-bottom: 40px;
            box-shadow: 0 8px 32px rgba(167, 139, 250, 0.3);
            text-align: center;
        }
        
        .checkout-header h1 {
            font-size: 2.8rem;
            font-weight: 800;
            margin-bottom: 10px;
            text-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }
        
        .checkout-header p {
            font-size: 1.1rem;
            opacity: 0.95;
            font-weight: 500;
        }
        
        /* Error Message */
        .error-message {
            background: linear-gradient(135deg, #fee2e2 0%, #fecaca 100%);
            color: #dc2626;
            padding: 18px 24px;
            border-radius: 14px;
            margin-bottom: 30px;
            font-weight: 600;
            border: 2px solid #fca5a5;
            box-shadow: 0 4px 12px rgba(220, 38, 38, 0.15);
            animation: slideDown 0.4s ease;
        }
        
        @keyframes slideDown {
            from {
                opacity: 0;
                transform: translateY(-20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
        
        /* Container */
        .checkout-container {
            display: grid;
            grid-template-columns: 1fr 500px;
            gap: 30px;
            margin-bottom: 40px;
        }
        
        /* Form Card */
        .checkout-form-card {
            background: #ffffff;
            border-radius: 24px;
            padding: 40px;
            box-shadow: 0 8px 32px rgba(167, 139, 250, 0.1);
            position: relative;
            overflow: hidden;
        }
        
        .checkout-form-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 5px;
            background: linear-gradient(90deg, #e0c3fc 0%, #8ec5fc 50%, #b8e6e6 100%);
        }
        
        .checkout-form-title {
            font-size: 1.8rem;
            font-weight: 700;
            color: #2d3748;
            margin-bottom: 30px;
            display: flex;
            align-items: center;
            gap: 12px;
        }
        
        /* Form */
        .form-group {
            margin-bottom: 24px;
        }
        
        .form-label {
            display: block;
            margin-bottom: 10px;
            color: #4a5568;
            font-weight: 600;
            font-size: 0.95rem;
        }
        
        .form-input {
            width: 100%;
            padding: 16px 20px;
            border: 2px solid #e9d8fd;
            border-radius: 14px;
            font-size: 1rem;
            background: #faf5ff;
            color: #2d3748;
            transition: all 0.3s ease;
            font-family: inherit;
        }
        
        .form-input:focus {
            outline: none;
            border-color: #a78bfa;
            background: #ffffff;
            box-shadow: 0 0 0 4px rgba(167, 139, 250, 0.1);
        }
        
        textarea.form-input {
            min-height: 100px;
            resize: vertical;
        }
        
        /* Payment Method */
        .payment-method {
            margin-top: 30px;
            padding: 20px;
            background: linear-gradient(135deg, #e0f2fe 0%, #dbeafe 100%);
            border-radius: 14px;
            border: 2px solid #bfdbfe;
        }
        
        .payment-method-title {
            font-size: 1.1rem;
            font-weight: 700;
            color: #1e40af;
            margin-bottom: 12px;
            display: flex;
            align-items: center;
            gap: 8px;
        }
        
        .payment-method-desc {
            color: #1e40af;
            font-size: 0.95rem;
            line-height: 1.6;
        }
        
        /* Actions */
        .checkout-actions {
            margin-top: 30px;
            display: flex;
            gap: 16px;
        }
        
        /* Summary Card */
        .checkout-summary-card {
            background: #ffffff;
            border-radius: 24px;
            padding: 40px;
            box-shadow: 0 8px 32px rgba(167, 139, 250, 0.1);
            height: fit-content;
            position: sticky;
            top: 100px;
            overflow: hidden;
        }
        
        .checkout-summary-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 5px;
            background: linear-gradient(90deg, #e0c3fc 0%, #8ec5fc 50%, #b8e6e6 100%);
        }
        
        .checkout-summary-title {
            font-size: 1.6rem;
            font-weight: 700;
            color: #2d3748;
            margin-bottom: 24px;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        
        /* Order Items */
        .order-items {
            max-height: 400px;
            overflow-y: auto;
            margin-bottom: 24px;
            padding-right: 8px;
        }
        
        .order-items::-webkit-scrollbar {
            width: 6px;
        }
        
        .order-items::-webkit-scrollbar-track {
            background: #f1f5f9;
            border-radius: 3px;
        }
        
        .order-items::-webkit-scrollbar-thumb {
            background: #cbd5e1;
            border-radius: 3px;
        }
        
        .order-item {
            display: flex;
            gap: 16px;
            padding: 16px;
            background: #faf5ff;
            border-radius: 12px;
            margin-bottom: 16px;
            border: 2px solid #e9d8fd;
        }
        
        .order-item-image {
            width: 80px;
            height: 80px;
            border-radius: 12px;
            overflow: hidden;
            flex-shrink: 0;
            border: 2px solid #e9d8fd;
        }
        
        .order-item-image img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }
        
        .order-item-image-placeholder {
            width: 100%;
            height: 100%;
            background: linear-gradient(135deg, #e0c3fc 0%, #c4b5fd 100%);
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 2rem;
        }
        
        .order-item-info {
            flex: 1;
        }
        
        .order-item-name {
            font-size: 1rem;
            font-weight: 700;
            color: #2d3748;
            margin-bottom: 8px;
        }
        
        .order-item-price {
            font-size: 0.95rem;
            color: #64748b;
            font-weight: 600;
        }
        
        .order-item-quantity {
            display: inline-block;
            background: linear-gradient(135deg, #a78bfa 0%, #c4b5fd 100%);
            color: #fff;
            padding: 4px 12px;
            border-radius: 8px;
            font-size: 0.85rem;
            font-weight: 700;
            margin-left: 8px;
        }
        
        .order-item-subtotal {
            font-size: 1.1rem;
            font-weight: 800;
            color: #7c3aed;
            margin-top: 8px;
        }
        
        /* Summary */
        .order-summary {
            border-top: 2px solid #e9d8fd;
            padding-top: 20px;
        }
        
        .summary-row {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 12px 0;
            border-bottom: 1px solid #f1f5f9;
        }
        
        .summary-row:last-child {
            border-bottom: none;
        }
        
        .summary-label {
            font-size: 1rem;
            color: #4a5568;
            font-weight: 500;
        }
        
        .summary-value {
            font-size: 1.05rem;
            color: #2d3748;
            font-weight: 600;
        }
        
        .summary-total {
            margin-top: 16px;
            padding-top: 16px;
            border-top: 2px solid #a78bfa;
        }
        
        .summary-total .summary-label {
            font-size: 1.25rem;
            font-weight: 700;
            color: #2d3748;
        }
        
        .summary-total .summary-value {
            font-size: 1.6rem;
            font-weight: 800;
            background: linear-gradient(135deg, #7c3aed 0%, #a78bfa 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }
        
        /* Buttons */
        .btn {
            padding: 16px 32px;
            border: none;
            border-radius: 14px;
            font-size: 1rem;
            font-weight: 700;
            cursor: pointer;
            transition: all 0.3s ease;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            justify-content: center;
        }
        
        .btn-primary {
            background: linear-gradient(135deg, #8b5cf6 0%, #a78bfa 100%);
            color: #ffffff;
            box-shadow: 0 8px 25px rgba(139, 92, 246, 0.3);
            flex: 1;
        }
        
        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 12px 35px rgba(139, 92, 246, 0.4);
            background: linear-gradient(135deg, #7c3aed 0%, #8b5cf6 100%);
        }
        
        .btn-secondary {
            background: #e2e8f0;
            color: #475569;
        }
        
        .btn-secondary:hover {
            background: #cbd5e1;
        }
        
        /* Responsive */
        @media (max-width: 1024px) {
            .checkout-container {
                grid-template-columns: 1fr;
            }
            
            .checkout-summary-card {
                position: static;
            }
        }
        
        @media (max-width: 768px) {
            .checkout-wrapper {
                padding: 0 20px;
                margin: 20px auto 40px;
            }
            
            .checkout-header h1 {
                font-size: 2rem;
            }
            
            .checkout-form-card,
            .checkout-summary-card {
                padding: 24px;
            }
            
            .checkout-actions {
                flex-direction: column;
            }
            
            .btn {
                width: 100%;
            }
        }
    </style>
</head>
<body>
    <div class="checkout-wrapper">
        <!-- Header -->
        <div class="checkout-header">
            <h1>💳 Thanh toán đơn hàng</h1>
            <p>Vui lòng điền thông tin giao hàng</p>
        </div>
        
        <%
            // Lấy dữ liệu từ request
            @SuppressWarnings("unchecked")
            List<CartItem> cart = (List<CartItem>) request.getAttribute("cart");
            User user = (User) request.getAttribute("user");
            Double total = (Double) request.getAttribute("total");
            Integer totalItems = (Integer) request.getAttribute("totalItems");
            String error = (String) request.getAttribute("error");
            
            // Lấy user hiện tại từ session nếu chưa có
            if (user == null) {
                user = (User) session.getAttribute("user");
            }
            
            // Tính lại nếu chưa có
            if (cart != null && !cart.isEmpty()) {
                if (total == null) {
                    total = 0.0;
                    for (CartItem item : cart) {
                        total += item.getSubtotal();
                    }
                }
                
                if (totalItems == null) {
                    totalItems = 0;
                    for (CartItem item : cart) {
                        totalItems += item.getQuantity();
                    }
                }
            }
            
            // Hiển thị thông báo lỗi
            if (error != null) {
        %>
            <div class="error-message">
                ⚠️ <%= error %>
            </div>
        <%
            }
            
            // Kiểm tra giỏ hàng
            if (cart == null || cart.isEmpty()) {
        %>
            <div style="background: #fff; padding: 60px 40px; border-radius: 24px; text-align: center; box-shadow: 0 8px 32px rgba(167, 139, 250, 0.1);">
                <div style="font-size: 5rem; margin-bottom: 20px;">🛒</div>
                <h2 style="font-size: 1.8rem; font-weight: 700; color: #2d3748; margin-bottom: 16px;">
                    Giỏ hàng trống
                </h2>
                <p style="color: #64748b; margin-bottom: 30px;">
                    Vui lòng thêm sản phẩm vào giỏ hàng trước khi thanh toán
                </p>
                <a href="<%= request.getContextPath() %>/cart" class="btn btn-secondary">
                    ⬅️ Quay lại giỏ hàng
                </a>
            </div>
        <%
            } else {
        %>
            <div class="checkout-container">
                <!-- Form Section -->
                <div class="checkout-form-card">
                    <h2 class="checkout-form-title">🚚 Thông tin giao hàng</h2>
                    
                    <form action="<%= request.getContextPath() %>/checkout" method="post">
                        <div class="form-group">
                            <label for="customerName" class="form-label">Họ tên người nhận *</label>
                            <input 
                                type="text" 
                                id="customerName" 
                                name="customerName" 
                                class="form-input" 
                                value="<%= user != null && user.getFullName() != null ? user.getFullName() : "" %>" 
                                required 
                                placeholder="Nhập họ tên người nhận"
                                autofocus>
                        </div>
                        
                        <div class="form-group">
                            <label for="customerPhone" class="form-label">Số điện thoại *</label>
                            <input 
                                type="tel" 
                                id="customerPhone" 
                                name="customerPhone" 
                                class="form-input" 
                                value="<%= user != null && user.getPhone() != null ? user.getPhone() : "" %>" 
                                required 
                                placeholder="Nhập số điện thoại (10-11 số)"
                                pattern="[0-9]{10,11}">
                        </div>
                        
                        <div class="form-group">
                            <label for="customerEmail" class="form-label">Email</label>
                            <input 
                                type="email" 
                                id="customerEmail" 
                                name="customerEmail" 
                                class="form-input" 
                                value="<%= user != null && user.getEmail() != null ? user.getEmail() : "" %>" 
                                placeholder="Nhập email (không bắt buộc)">
                        </div>
                        
                        <div class="form-group">
                            <label for="customerAddress" class="form-label">Địa chỉ giao hàng *</label>
                            <textarea 
                                id="customerAddress" 
                                name="customerAddress" 
                                class="form-input" 
                                required 
                                placeholder="Nhập địa chỉ giao hàng chi tiết (số nhà, đường, phường/xã, quận/huyện, tỉnh/thành phố)"><%= user != null && user.getAddress() != null ? user.getAddress() : "" %></textarea>
                        </div>
                        
                        <div class="form-group">
                            <label for="orderNote" class="form-label">Ghi chú đơn hàng</label>
                            <textarea 
                                id="orderNote" 
                                name="orderNote" 
                                class="form-input" 
                                placeholder="Ghi chú về đơn hàng, yêu cầu đặc biệt (không bắt buộc)"></textarea>
                        </div>
                        
                        <!-- Payment Method Info -->
                        <div class="payment-method">
                            <div class="payment-method-title">💵 Phương thức thanh toán</div>
                            <div class="payment-method-desc">
                                <strong>Thanh toán khi nhận hàng (COD)</strong><br>
                                Bạn sẽ thanh toán tiền mặt cho nhân viên giao hàng khi nhận được sản phẩm.
                            </div>
                        </div>
                        
                        <!-- Actions -->
                        <div class="checkout-actions">
                            <a href="<%= request.getContextPath() %>/cart" class="btn btn-secondary">
                                ⬅️ Quay lại giỏ hàng
                            </a>
                            <button type="submit" class="btn btn-primary">
                                ✅ Đặt hàng ngay
                            </button>
                        </div>
                    </form>
                </div>
                
                <!-- Summary Section -->
                <div class="checkout-summary-card">
                    <h2 class="checkout-summary-title">📦 Tóm tắt đơn hàng</h2>
                    
                    <!-- Order Items -->
                    <div class="order-items">
                        <%
                            for (CartItem item : cart) {
                                Product product = item.getProduct();
                                int quantity = item.getQuantity();
                        %>
                            <div class="order-item">
                                <div class="order-item-image">
                                    <% if (product.getImage() != null && !product.getImage().isEmpty() && !product.getImage().equals("null")) { %>
                                        <img src="<%= product.getImage() %>" alt="<%= product.getName() %>" onerror="this.style.display='none'; this.nextElementSibling.style.display='flex';">
                                        <div class="order-item-image-placeholder" style="display: none;">📱</div>
                                    <% } else { %>
                                        <div class="order-item-image-placeholder">📱</div>
                                    <% } %>
                                </div>
                                <div class="order-item-info">
                                    <div class="order-item-name"><%= product.getName() %></div>
                                    <div class="order-item-price">
                                        <%= String.format("%,.0f", product.getPrice()) %> ₫
                                        <span class="order-item-quantity">×<%= quantity %></span>
                                    </div>
                                    <div class="order-item-subtotal">
                                        = <%= String.format("%,.0f", item.getSubtotal()) %> ₫
                                    </div>
                                </div>
                            </div>
                        <%
                            }
                        %>
                    </div>
                    
                    <!-- Summary -->
                    <div class="order-summary">
                        <div class="summary-row">
                            <span class="summary-label">Số loại sản phẩm:</span>
                            <span class="summary-value"><%= cart.size() %> loại</span>
                        </div>
                        <div class="summary-row">
                            <span class="summary-label">Tổng số lượng:</span>
                            <span class="summary-value"><%= totalItems %> sản phẩm</span>
                        </div>
                        <div class="summary-row">
                            <span class="summary-label">Tạm tính:</span>
                            <span class="summary-value"><%= String.format("%,.0f", total) %> ₫</span>
                        </div>
                        <div class="summary-row">
                            <span class="summary-label">Phí vận chuyển:</span>
                            <span class="summary-value" style="color: #10b981; font-weight: 700;">Miễn phí</span>
                        </div>
                        <div class="summary-row summary-total">
                            <span class="summary-label">Tổng cộng:</span>
                            <span class="summary-value"><%= String.format("%,.0f", total) %> ₫</span>
                        </div>
                    </div>
                </div>
            </div>
        <%
            }
        %>
    </div>
    
    <jsp:include page="/home/footer.jsp" />
</body>
</html>
