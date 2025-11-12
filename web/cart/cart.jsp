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
    <title>Giỏ hàng - SmartPhoneStore.vn</title>
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
        
        .cart-wrapper {
            max-width: 1400px;
            margin: 40px auto;
            padding: 0 40px;
        }
        
        .cart-header {
            background: linear-gradient(135deg, #a78bfa 0%, #c4b5fd 100%);
            color: #ffffff;
            padding: 40px;
            border-radius: 24px;
            margin-bottom: 40px;
            box-shadow: 0 8px 32px rgba(167, 139, 250, 0.3);
            text-align: center;
        }
        
        .cart-header h1 {
            font-size: 2.8rem;
            font-weight: 800;
            margin-bottom: 10px;
            text-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }
        
        .cart-header p {
            font-size: 1.1rem;
            opacity: 0.95;
            font-weight: 500;
        }
        
        .cart-message {
            padding: 18px 24px;
            margin-bottom: 30px;
            border-radius: 14px;
            font-weight: 500;
            animation: slideDown 0.5s ease;
            border: 2px solid;
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
        
        .cart-message.success {
            color: #155724;
            background: linear-gradient(135deg, #d4edda 0%, #c3e6cb 100%);
            border-color: #b6e2b6;
        }
        
        .cart-message.error {
            color: #721c24;
            background: linear-gradient(135deg, #f8d7da 0%, #f5c6cb 100%);
            border-color: #f5c2c7;
        }
        
        .empty-cart {
            background: #ffffff;
            border-radius: 24px;
            padding: 80px 40px;
            text-align: center;
            box-shadow: 0 8px 32px rgba(167, 139, 250, 0.1);
            margin-bottom: 40px;
        }
        
        .empty-cart-icon {
            font-size: 6rem;
            margin-bottom: 24px;
            opacity: 0.7;
        }
        
        .empty-cart h2 {
            font-size: 2rem;
            color: #4a5568;
            margin-bottom: 16px;
            font-weight: 700;
        }
        
        .empty-cart p {
            font-size: 1.1rem;
            color: #718096;
            margin-bottom: 32px;
        }
        
        .empty-cart-actions {
            display: flex;
            gap: 16px;
            justify-content: center;
            flex-wrap: wrap;
        }
        
        .cart-container {
            display: grid;
            grid-template-columns: 1fr 400px;
            gap: 30px;
            margin-bottom: 40px;
        }
        
        .cart-items {
            background: #ffffff;
            border-radius: 24px;
            padding: 40px;
            box-shadow: 0 8px 32px rgba(167, 139, 250, 0.1);
            position: relative;
            overflow: hidden;
        }
        
        .cart-items::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 5px;
            background: linear-gradient(90deg, #e0c3fc 0%, #8ec5fc 50%, #b8e6e6 100%);
        }
        
        .cart-items-header {
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-bottom: 30px;
            padding-bottom: 20px;
            border-bottom: 2px solid #e9d8fd;
        }
        
        .cart-items-title {
            font-size: 1.8rem;
            font-weight: 700;
            color: #2d3748;
            display: flex;
            align-items: center;
            gap: 12px;
        }
        
        .cart-item {
            display: flex;
            align-items: center;
            gap: 24px;
            padding: 24px;
            background: linear-gradient(135deg, #faf5ff 0%, #f3f0f7 100%);
            border-radius: 16px;
            margin-bottom: 20px;
            transition: all 0.3s ease;
            border: 2px solid transparent;
        }
        
        .cart-item:hover {
            border-color: #e9d8fd;
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(167, 139, 250, 0.15);
        }
        
        .cart-item-image {
            width: 120px;
            height: 120px;
            flex-shrink: 0;
            display: flex;
            align-items: center;
            justify-content: center;
            background: #ffffff;
            border-radius: 14px;
            overflow: hidden;
            box-shadow: 0 4px 12px rgba(167, 139, 250, 0.1);
        }
        
        .cart-item-image img {
            max-width: 100%;
            max-height: 100%;
            width: auto;
            height: auto;
            object-fit: contain;
        }
        
        .cart-item-image-placeholder {
            width: 100%;
            height: 100%;
            background: linear-gradient(135deg, #e0c3fc 0%, #c4b5fd 100%);
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 3rem;
            color: rgba(255, 255, 255, 0.9);
        }
        
        .cart-item-info {
            flex: 1;
            display: flex;
            flex-direction: column;
            gap: 12px;
        }
        
        .cart-item-name {
            font-size: 1.3rem;
            font-weight: 700;
            color: #2d3748;
            margin: 0;
        }
        
        .cart-item-price {
            font-size: 1.5rem;
            font-weight: 800;
            background: linear-gradient(135deg, #7c3aed 0%, #a78bfa 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }
        
        .cart-item-actions {
            display: flex;
            flex-direction: column;
            gap: 16px;
            align-items: flex-end;
        }
        
        .quantity-control {
            display: flex;
            align-items: center;
            gap: 12px;
            background: #ffffff;
            padding: 8px 16px;
            border-radius: 12px;
            border: 2px solid #e9d8fd;
        }
        
        .quantity-btn {
            width: 36px;
            height: 36px;
            background: linear-gradient(135deg, #a78bfa 0%, #c4b5fd 100%);
            color: #ffffff;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            font-size: 1.2rem;
            font-weight: 700;
            transition: all 0.2s ease;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        
        .quantity-btn:hover {
            transform: scale(1.1);
            background: linear-gradient(135deg, #8b5cf6 0%, #a78bfa 100%);
            box-shadow: 0 4px 12px rgba(167, 139, 250, 0.4);
        }
        
        .quantity-btn:active {
            transform: scale(0.95);
        }
        
        .quantity-btn:disabled {
            opacity: 0.5;
            cursor: not-allowed;
            transform: none;
        }
        
        .quantity-display {
            min-width: 40px;
            text-align: center;
            font-size: 1.1rem;
            font-weight: 700;
            color: #2d3748;
        }
        
        .remove-btn {
            padding: 10px 20px;
            background: linear-gradient(135deg, #ef4444 0%, #dc2626 100%);
            color: #ffffff;
            border: none;
            border-radius: 12px;
            cursor: pointer;
            font-size: 0.95rem;
            font-weight: 600;
            transition: all 0.3s ease;
            box-shadow: 0 4px 12px rgba(239, 68, 68, 0.3);
        }
        
        .remove-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 16px rgba(239, 68, 68, 0.4);
            background: linear-gradient(135deg, #dc2626 0%, #b91c1c 100%);
        }
        
        .cart-summary {
            background: #ffffff;
            border-radius: 24px;
            padding: 40px;
            box-shadow: 0 8px 32px rgba(167, 139, 250, 0.1);
            height: fit-content;
            position: sticky;
            top: 100px;
            position: relative;
            overflow: hidden;
        }
        
        .cart-summary::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 5px;
            background: linear-gradient(90deg, #e0c3fc 0%, #8ec5fc 50%, #b8e6e6 100%);
        }
        
        .cart-summary-title {
            font-size: 1.6rem;
            font-weight: 700;
            color: #2d3748;
            margin-bottom: 24px;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        
        .summary-row {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 16px 0;
            border-bottom: 1px solid #e9d8fd;
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
            font-size: 1.1rem;
            color: #2d3748;
            font-weight: 600;
        }
        
        .summary-total {
            margin-top: 20px;
            padding-top: 20px;
            border-top: 2px solid #a78bfa;
        }
        
        .summary-total .summary-label {
            font-size: 1.3rem;
            font-weight: 700;
            color: #2d3748;
        }
        
        .summary-total .summary-value {
            font-size: 1.8rem;
            font-weight: 800;
            background: linear-gradient(135deg, #7c3aed 0%, #a78bfa 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }
        
        .cart-actions {
            display: flex;
            flex-direction: column;
            gap: 16px;
            margin-top: 30px;
        }
        
        .btn {
            padding: 16px 32px;
            border: none;
            border-radius: 14px;
            font-size: 1.1rem;
            font-weight: 700;
            cursor: pointer;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            text-align: center;
            position: relative;
            overflow: hidden;
            letter-spacing: 0.3px;
        }
        
        .btn-primary {
            background: linear-gradient(135deg, #a78bfa 0%, #c4b5fd 100%);
            color: #ffffff;
            box-shadow: 0 8px 24px rgba(167, 139, 250, 0.4);
        }
        
        .btn-primary::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.4), transparent);
            transition: left 0.6s ease;
        }
        
        .btn-primary:hover::before {
            left: 100%;
        }
        
        .btn-primary:hover {
            transform: translateY(-3px);
            box-shadow: 0 12px 32px rgba(167, 139, 250, 0.5);
            background: linear-gradient(135deg, #8b5cf6 0%, #a78bfa 100%);
        }
        
        .btn-success {
            background: linear-gradient(135deg, #10b981 0%, #059669 100%);
            color: #ffffff;
            box-shadow: 0 8px 24px rgba(16, 185, 129, 0.4);
        }
        
        .btn-success:hover {
            transform: translateY(-3px);
            box-shadow: 0 12px 32px rgba(16, 185, 129, 0.5);
            background: linear-gradient(135deg, #059669 0%, #047857 100%);
        }
        
        .btn-secondary {
            background: #ffffff;
            color: #4a5568;
            border: 2px solid #e9d8fd;
            box-shadow: 0 4px 12px rgba(167, 139, 250, 0.1);
        }
        
        .btn-secondary:hover {
            background: #faf5ff;
            border-color: #c4b5fd;
            transform: translateY(-3px);
            box-shadow: 0 8px 20px rgba(167, 139, 250, 0.2);
        }
        
        .btn-danger {
            background: linear-gradient(135deg, #ef4444 0%, #dc2626 100%);
            color: #ffffff;
            box-shadow: 0 4px 12px rgba(239, 68, 68, 0.3);
        }
        
        .btn-danger:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 20px rgba(239, 68, 68, 0.4);
            background: linear-gradient(135deg, #dc2626 0%, #b91c1c 100%);
        }
        
        .btn:active {
            transform: translateY(-1px);
        }
        
        .login-notice {
            background: linear-gradient(135deg, #fff3cd 0%, #ffeaa7 100%);
            border: 2px solid #fcd34d;
            padding: 24px;
            border-radius: 16px;
            text-align: center;
            margin-top: 20px;
        }
        
        .login-notice p {
            color: #856404;
            font-weight: 600;
            font-size: 1.1rem;
            margin-bottom: 20px;
        }
        
        .login-notice-actions {
            display: flex;
            gap: 12px;
            justify-content: center;
            flex-wrap: wrap;
        }
        
        .btn-warning {
            background: linear-gradient(135deg, #f59e0b 0%, #d97706 100%);
            color: #ffffff;
            box-shadow: 0 4px 12px rgba(245, 158, 11, 0.3);
        }
        
        .btn-warning:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 20px rgba(245, 158, 11, 0.4);
            background: linear-gradient(135deg, #d97706 0%, #b45309 100%);
        }
        
        .btn-info {
            background: linear-gradient(135deg, #3b82f6 0%, #2563eb 100%);
            color: #ffffff;
            box-shadow: 0 4px 12px rgba(59, 130, 246, 0.3);
        }
        
        .btn-info:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 20px rgba(59, 130, 246, 0.4);
            background: linear-gradient(135deg, #2563eb 0%, #1d4ed8 100%);
        }
        
        .cart-support {
            background: #ffffff;
            border-radius: 24px;
            padding: 40px;
            box-shadow: 0 8px 32px rgba(167, 139, 250, 0.1);
            margin-bottom: 40px;
        }
        
        .cart-support-title {
            font-size: 1.8rem;
            font-weight: 700;
            color: #2d3748;
            margin-bottom: 30px;
            text-align: center;
        }
        
        .support-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 24px;
        }
        
        .support-item {
            display: flex;
            align-items: center;
            gap: 20px;
            padding: 24px;
            background: linear-gradient(135deg, #faf5ff 0%, #f3f0f7 100%);
            border-radius: 16px;
            transition: all 0.3s ease;
            border: 2px solid transparent;
        }
        
        .support-item:hover {
            border-color: #e9d8fd;
            transform: translateY(-4px);
            box-shadow: 0 8px 20px rgba(167, 139, 250, 0.15);
        }
        
        .support-icon {
            font-size: 3rem;
            flex-shrink: 0;
        }
        
        .support-text strong {
            display: block;
            color: #2d3748;
            font-size: 1.1rem;
            font-weight: 700;
            margin-bottom: 6px;
        }
        
        .support-text p {
            margin: 0;
            color: #718096;
            font-size: 0.95rem;
        }
        
        @media (max-width: 1024px) {
            .cart-container {
                grid-template-columns: 1fr;
            }
            
            .cart-summary {
                position: static;
            }
        }
        
        @media (max-width: 768px) {
            .cart-wrapper {
                padding: 0 20px;
            }
            
            .cart-header {
                padding: 30px 20px;
            }
            
            .cart-header h1 {
                font-size: 2rem;
            }
            
            .cart-items,
            .cart-summary {
                padding: 30px 20px;
            }
            
            .cart-item {
                flex-direction: column;
                align-items: flex-start;
                gap: 16px;
            }
            
            .cart-item-image {
                width: 100%;
                height: 200px;
            }
            
            .cart-item-actions {
                width: 100%;
                align-items: stretch;
            }
            
            .remove-btn {
                width: 100%;
            }
            
            .support-grid {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>
    <div class="cart-wrapper">
        <div class="cart-header">
            <h1>🛒 Giỏ hàng của bạn</h1>
            <p>Xem và quản lý các sản phẩm trong giỏ hàng</p>
        </div>
        
        <%
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
            
            // Kiểm tra xem cart đang dùng format cũ (List<Product>) hay mới (List<CartItem>)
            Object cartObj = session.getAttribute("cart");
            List<CartItem> cart = null;
            
            if (cartObj instanceof List) {
                @SuppressWarnings("unchecked")
                List<?> tempList = (List<?>) cartObj;
                if (!tempList.isEmpty()) {
                    if (tempList.get(0) instanceof Product) {
                        // Convert từ List<Product> sang List<CartItem> (backward compatibility)
                        cart = new java.util.ArrayList<>();
                        for (Object obj : tempList) {
                            cart.add(new CartItem((Product) obj, 1));
                        }
                        session.setAttribute("cart", cart); // Update session with new format
                    } else if (tempList.get(0) instanceof CartItem) {
                        @SuppressWarnings("unchecked")
                        List<CartItem> temp = (List<CartItem>) tempList;
                        cart = temp;
                    }
                } else {
                    @SuppressWarnings("unchecked")
                    List<CartItem> temp = (List<CartItem>) tempList;
                    cart = temp;
                }
            }
            
            User currentUser = (User) session.getAttribute("user");
            
            if (cart == null || cart.isEmpty()) {
        %>
            <div class="empty-cart">
                <div class="empty-cart-icon">🛒</div>
                <h2>Giỏ hàng của bạn đang trống</h2>
                <p>Hãy khám phá những sản phẩm tuyệt vời của chúng tôi!</p>
                <div class="empty-cart-actions">
                    <a href="<%= request.getContextPath() %>/home" class="btn btn-primary">
                        🏠 Tiếp tục mua sắm
                    </a>
                    <a href="<%= request.getContextPath() %>/products" class="btn btn-secondary">
                        📱 Xem tất cả sản phẩm
                    </a>
                </div>
            </div>
        <%
            } else {
                double total = 0;
                int totalItems = 0;
                
                // Tính tổng tiền và tổng số lượng
                for (CartItem item : cart) {
                    total += item.getSubtotal();
                    totalItems += item.getQuantity();
                }
        %>
            <div class="cart-container">
                <div class="cart-items">
                    <div class="cart-items-header">
                        <h2 class="cart-items-title">📦 Sản phẩm (<%= cart.size() %> loại, <%= totalItems %> sản phẩm)</h2>
                    </div>
                    
                    <%
                        for (int i = 0; i < cart.size(); i++) {
                            CartItem item = cart.get(i);
                            Product product = item.getProduct();
                            int quantity = item.getQuantity();
                    %>
                        <div class="cart-item">
                            <div class="cart-item-image">
                                <% if (product.getImage() != null && !product.getImage().isEmpty() && !product.getImage().equals("null")) { %>
                                    <img src="<%= product.getImage() %>" alt="<%= product.getName() %>" onerror="this.style.display='none'; this.nextElementSibling.style.display='flex';">
                                    <div class="cart-item-image-placeholder" style="display: none;">📱</div>
                                <% } else { %>
                                    <div class="cart-item-image-placeholder">📱</div>
                                <% } %>
                            </div>
                            <div class="cart-item-info">
                                <h3 class="cart-item-name"><%= product.getName() %></h3>
                                <div class="cart-item-price"><%= String.format("%,.0f", product.getPrice()) %> ₫ / sản phẩm</div>
                                <div style="color: #2d3748; font-size: 1.05rem; font-weight: 600; margin-top: 8px;">
                                    Thành tiền: <span style="color: #7c3aed;"><%= String.format("%,.0f", item.getSubtotal()) %> ₫</span>
                                </div>
                            </div>
                            <div class="cart-item-actions">
                                <!-- Quantity Control -->
                                <div class="quantity-control">
                                    <form action="<%= request.getContextPath() %>/cart/updateQuantity" method="post" style="margin: 0;">
                                        <input type="hidden" name="index" value="<%= i %>">
                                        <input type="hidden" name="action" value="decrease">
                                        <button type="submit" class="quantity-btn" <%= quantity <= 1 ? "disabled" : "" %> title="Giảm số lượng">
                                            −
                                        </button>
                                    </form>
                                    
                                    <div class="quantity-display"><%= quantity %></div>
                                    
                                    <form action="<%= request.getContextPath() %>/cart/updateQuantity" method="post" style="margin: 0;">
                                        <input type="hidden" name="index" value="<%= i %>">
                                        <input type="hidden" name="action" value="increase">
                                        <button type="submit" class="quantity-btn" title="Tăng số lượng">
                                            +
                                        </button>
                                    </form>
                                </div>
                                
                                <!-- Remove Button -->
                                <form action="<%= request.getContextPath() %>/cart/remove" method="post" style="margin: 0;">
                                    <input type="hidden" name="productIndex" value="<%= i %>">
                                    <button type="submit" class="remove-btn" onclick="return confirm('Bạn có chắc muốn xóa sản phẩm này?')">
                                        🗑️ Xóa
                                    </button>
                                </form>
                            </div>
                        </div>
                    <%
                        }
                    %>
                </div>
                
                <div class="cart-summary">
                    <h2 class="cart-summary-title">💰 Tóm tắt đơn hàng</h2>
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
                    
                    <div class="cart-actions">
                        <% if (currentUser != null) { %>
                            <a href="<%= request.getContextPath() %>/checkout" class="btn btn-success">
                                💳 Thanh toán ngay
                            </a>
                        <% } else { %>
                            <div class="login-notice">
                                <p>⚠️ Vui lòng đăng nhập để tiếp tục thanh toán</p>
                                <div class="login-notice-actions">
                                    <a href="<%= request.getContextPath() %>/login" class="btn btn-warning">
                                        🔐 Đăng nhập
                                    </a>
                                    <a href="<%= request.getContextPath() %>/register" class="btn btn-info">
                                        📝 Đăng ký
                                    </a>
                                </div>
                            </div>
                        <% } %>
                        
                        <a href="<%= request.getContextPath() %>/home" class="btn btn-primary">
                            🏠 Tiếp tục mua sắm
                        </a>
                        
                        <a href="<%= request.getContextPath() %>/products" class="btn btn-secondary">
                            📱 Xem tất cả sản phẩm
                        </a>
                        
                        <form action="<%= request.getContextPath() %>/cart/clear" method="post" style="margin: 0;">
                            <button type="submit" class="btn btn-danger" onclick="return confirm('Bạn có chắc muốn xóa toàn bộ giỏ hàng?')">
                                🗑️ Xóa giỏ hàng
                            </button>
                        </form>
                    </div>
                </div>
            </div>
            
            <div class="cart-support">
                <h2 class="cart-support-title">✨ Dịch vụ của chúng tôi</h2>
                <div class="support-grid">
                    <div class="support-item">
                        <div class="support-icon">🚚</div>
                        <div class="support-text">
                            <strong>Miễn phí vận chuyển</strong>
                            <p>Đơn hàng từ 500.000 ₫</p>
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
        <%
            }
        %>
    </div>
    
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            // Auto hide cart messages sau 5 giây
            const cartMessages = document.querySelectorAll('.cart-message');
            cartMessages.forEach(message => {
                setTimeout(() => {
                    message.style.opacity = '0';
                    message.style.transition = 'opacity 0.5s ease';
                    setTimeout(() => {
                        message.style.display = 'none';
                    }, 500);
                }, 5000);
            });
            
            // Loading effect khi submit form
            const forms = document.querySelectorAll('form');
            forms.forEach(form => {
                form.addEventListener('submit', function(e) {
                    const submitBtn = form.querySelector('button[type="submit"]');
                    if (submitBtn && !submitBtn.disabled) {
                        const originalText = submitBtn.innerHTML;
                        submitBtn.innerHTML = '⏳ Đang xử lý...';
                        submitBtn.disabled = true;
                        
                        // Re-enable sau 3 giây nếu form không submit được
                        setTimeout(() => {
                            submitBtn.innerHTML = originalText;
                            submitBtn.disabled = false;
                        }, 3000);
                    }
                });
            });
        });
    </script>
    <jsp:include page="/home/footer.jsp" />
</body>
</html>
