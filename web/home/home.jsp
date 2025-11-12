<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Product" %>
<jsp:include page="/home/header.jsp" />

<!DOCTYPE html>
<html>
<head>
    <title>SmartPhoneStore.vn - Trang chủ</title>
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
            overflow-x: hidden;
        }
        
        .main-content {
            max-width: 1600px;
            margin: 0 auto;
            padding: 0;
        }
        
        /* Hero Banner với Màu Pastel Dịu Mắt */
        .main-banner {
            position: relative;
            width: 100%;
            height: 480px;
            margin-bottom: 80px;
            overflow: hidden;
            background: linear-gradient(135deg, #e0c3fc 0%, #8ec5fc 50%, #b8e6e6 100%);
            border-radius: 0 0 40px 40px;
        }
        
        .main-banner::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: 
                radial-gradient(circle at 30% 40%, rgba(224, 195, 252, 0.4) 0%, transparent 60%),
                radial-gradient(circle at 70% 70%, rgba(184, 230, 230, 0.4) 0%, transparent 60%);
            animation: gentle-move 12s ease-in-out infinite;
        }
        
        @keyframes gentle-move {
            0%, 100% { 
                transform: translate(0, 0); 
                opacity: 0.8;
            }
            50% { 
                transform: translate(15px, -15px); 
                opacity: 1;
            }
        }
        
        .main-banner img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            opacity: 0.15;
            mix-blend-mode: soft-light;
        }
        
        .banner-overlay {
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            text-align: center;
            z-index: 10;
            width: 90%;
            max-width: 900px;
        }
        
        .banner-title {
            font-size: 4.2rem;
            font-weight: 800;
            background: linear-gradient(135deg, #6b46c1 0%, #8b5cf6 50%, #a78bfa 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            margin-bottom: 20px;
            animation: slideDown 1s ease-out;
            letter-spacing: -1px;
            filter: drop-shadow(0 2px 8px rgba(107, 70, 193, 0.2));
        }
        
        @keyframes slideDown {
            from {
                opacity: 0;
                transform: translateY(-50px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
        
        .banner-subtitle {
            font-size: 1.3rem;
            color: #6b46c1;
            font-weight: 600;
            letter-spacing: 2px;
            animation: fadeIn 1s ease-out 0.3s both;
            opacity: 0.85;
        }
        
        @keyframes fadeIn {
            from { opacity: 0; }
            to { opacity: 1; }
        }
        
        /* Section Header */
        .section-header {
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin: 0 40px 40px 40px;
            padding: 20px 0;
        }
        
        .section-title {
            font-size: 2.6rem;
            font-weight: 800;
            color: #4a5568;
            display: flex;
            align-items: center;
            gap: 15px;
            position: relative;
        }
        
        .section-title::after {
            content: '';
            position: absolute;
            bottom: -10px;
            left: 0;
            width: 70px;
            height: 4px;
            background: linear-gradient(90deg, #a78bfa 0%, #c4b5fd 100%);
            border-radius: 3px;
        }
        
        .sort-form {
            display: flex;
            align-items: center;
            gap: 12px;
        }
        
        .sort-form select {
            padding: 13px 26px;
            border-radius: 14px;
            border: 2px solid #e9d8fd;
            background: #ffffff;
            color: #4a5568;
            font-size: 0.98rem;
            font-weight: 600;
            cursor: pointer;
            outline: none;
            transition: all 0.3s ease;
            box-shadow: 0 2px 8px rgba(167, 139, 250, 0.08);
        }
        
        .sort-form select:hover {
            border-color: #c4b5fd;
            box-shadow: 0 4px 12px rgba(167, 139, 250, 0.15);
            transform: translateY(-1px);
        }
        
        .sort-form select option {
            background: #ffffff;
            color: #4a5568;
        }
        
        /* Product Grid */
        .product-list {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            gap: 28px;
            padding: 0 40px 80px 40px;
        }
        
        /* Product Card Dịu Mắt */
        .product-card {
            position: relative;
            background: #ffffff;
            border-radius: 26px;
            padding: 28px 22px;
            display: flex;
            flex-direction: column;
            align-items: center;
            transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
            cursor: pointer;
            overflow: hidden;
            border: 1px solid #f3f0f7;
            box-shadow: 
                0 4px 16px rgba(167, 139, 250, 0.06),
                0 2px 4px rgba(0, 0, 0, 0.02);
        }
        
        .product-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 5px;
            background: linear-gradient(90deg, #e0c3fc 0%, #8ec5fc 50%, #b8e6e6 100%);
            transform: scaleX(0);
            transform-origin: left;
            transition: transform 0.4s ease;
        }
        
        .product-card:hover {
            transform: translateY(-10px);
            border-color: #e9d8fd;
            box-shadow: 
                0 16px 32px rgba(167, 139, 250, 0.12),
                0 8px 16px rgba(0, 0, 0, 0.04);
        }
        
        .product-card:hover::before {
            transform: scaleX(1);
        }
        
        .product-image-wrapper {
            position: relative;
            width: 100%;
            height: 220px;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-bottom: 20px;
            background: linear-gradient(135deg, #faf5ff 0%, #f3f0f7 100%);
            border-radius: 18px;
            overflow: hidden;
        }
        
        .product-card img {
            max-width: 82%;
            max-height: 82%;
            width: auto;
            height: auto;
            object-fit: contain;
            transition: transform 0.4s ease;
            filter: drop-shadow(0 6px 12px rgba(107, 70, 193, 0.08));
        }
        
        .product-card:hover img {
            transform: scale(1.08);
        }
        
        .product-image-placeholder {
            width: 100%;
            height: 100%;
            background: linear-gradient(135deg, #e0c3fc 0%, #c4b5fd 100%);
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 3.8rem;
            border-radius: 18px;
            opacity: 0.9;
        }
        
        .product-name {
            font-size: 1.2rem;
            font-weight: 700;
            color: #2d3748;
            margin-bottom: 12px;
            text-align: center;
            line-height: 1.4;
            min-height: 50px;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        
        .product-price {
            background: linear-gradient(135deg, #7c3aed 0%, #a78bfa 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            font-size: 1.55rem;
            font-weight: 800;
            margin-bottom: 12px;
        }
        
        .product-desc {
            font-size: 0.94rem;
            color: #718096;
            margin-bottom: 22px;
            text-align: center;
            line-height: 1.6;
            min-height: 65px;
            max-height: 75px;
            overflow: hidden;
            text-overflow: ellipsis;
            display: -webkit-box;
            -webkit-line-clamp: 3;
            -webkit-box-orient: vertical;
        }
        
        .add-cart-btn {
            position: relative;
            background: linear-gradient(135deg, #a78bfa 0%, #c4b5fd 100%);
            color: #ffffff;
            border: none;
            border-radius: 15px;
            padding: 14px 34px;
            cursor: pointer;
            font-size: 1.02rem;
            font-weight: 700;
            transition: all 0.3s ease;
            width: 100%;
            max-width: 230px;
            overflow: hidden;
            letter-spacing: 0.3px;
            box-shadow: 0 6px 16px rgba(167, 139, 250, 0.25);
        }
        
        .add-cart-btn::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.35), transparent);
            transition: left 0.6s ease;
        }
        
        .add-cart-btn:hover::before {
            left: 100%;
        }
        
        .add-cart-btn:hover {
            background: linear-gradient(135deg, #8b5cf6 0%, #a78bfa 100%);
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(167, 139, 250, 0.3);
        }
        
        .add-cart-btn:active {
            transform: translateY(0);
        }
        
        .empty-products {
            text-align: center;
            padding: 100px 40px;
            background: #ffffff;
            border-radius: 26px;
            margin: 0 40px;
            border: 1px solid #f3f0f7;
            box-shadow: 0 8px 20px rgba(167, 139, 250, 0.08);
        }
        
        .empty-products p:first-child {
            font-size: 3.5rem;
            margin-bottom: 20px;
            opacity: 0.7;
        }
        
        .empty-products p:last-child {
            font-size: 1.15rem;
            color: #718096;
            font-weight: 500;
        }
        
        /* Responsive */
        @media (max-width: 1200px) {
            .product-list {
                grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
                gap: 24px;
            }
            
            .banner-title {
                font-size: 3.4rem;
            }
        }
        
        @media (max-width: 768px) {
            .main-banner {
                height: 340px;
                border-radius: 0 0 30px 30px;
            }
            
            .banner-title {
                font-size: 2.4rem;
            }
            
            .banner-subtitle {
                font-size: 1.05rem;
            }
            
            .section-header {
                flex-direction: column;
                align-items: flex-start;
                gap: 20px;
                margin: 0 20px 30px 20px;
            }
            
            .section-title {
                font-size: 2.1rem;
            }
            
            .product-list {
                grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
                gap: 20px;
                padding: 0 20px 60px 20px;
            }
            
            .empty-products {
                margin: 0 20px;
                padding: 60px 20px;
            }
        }
        
        @media (max-width: 480px) {
            .main-banner {
                height: 280px;
            }
            
            .banner-title {
                font-size: 1.95rem;
            }
            
            .product-list {
                grid-template-columns: 1fr;
            }
            
            .section-title {
                font-size: 1.75rem;
            }
        }
        
        /* Custom Scrollbar Dịu Mắt */
        ::-webkit-scrollbar {
            width: 10px;
        }
        
        ::-webkit-scrollbar-track {
            background: #faf8fc;
        }
        
        ::-webkit-scrollbar-thumb {
            background: linear-gradient(180deg, #c4b5fd 0%, #e0c3fc 100%);
            border-radius: 5px;
        }
        
        ::-webkit-scrollbar-thumb:hover {
            background: linear-gradient(180deg, #a78bfa 0%, #c4b5fd 100%);
        }
    </style>
</head>
<body>
    <div class="main-content">
        <div class="main-banner">
            <img src="<%= request.getContextPath() %>/img/banner.jpg" alt="SmartPhoneStore.vn Banner">
            <div class="banner-overlay">
                <h1 class="banner-title">SmartPhoneStore.vn</h1>
                <p class="banner-subtitle">CÔNG NGHỆ TIÊN TIẾN · TRẢI NGHIỆM ĐỈNH CAO</p>
            </div>
        </div>
        
        <div class="section-header">
            <h2 class="section-title">🔥 Sản phẩm nổi bật</h2>
            <form method="get" class="sort-form">
                <select name="sort" onchange="this.form.submit()">
                    <option value="">Sắp xếp theo giá</option>
                    <option value="asc" <%= "asc".equals(request.getParameter("sort")) ? "selected" : "" %>>Giá tăng dần ↑</option>
                    <option value="desc" <%= "desc".equals(request.getParameter("sort")) ? "selected" : "" %>>Giá giảm dần ↓</option>
                </select>
            </form>
        </div>
        
        <div class="product-list">
            <%
                List<Product> products = (List<Product>) request.getAttribute("products");
                if (products != null && !products.isEmpty()) {
                    for (Product p : products) {
                        String imageUrl = p.getImage();
                        if (imageUrl == null || imageUrl.trim().isEmpty()) {
                            imageUrl = "";
                        }
            %>
            <div class="product-card">
                <div class="product-image-wrapper">
                    <% if (imageUrl != null && !imageUrl.trim().isEmpty() && !imageUrl.equals("null")) { %>
                        <img src="<%= imageUrl %>" alt="<%= p.getName() != null ? p.getName() : "Product" %>" onerror="this.onerror=null; this.style.display='none'; this.parentElement.innerHTML='<div class=\'product-image-placeholder\'>📱</div>';">
                    <% } else { %>
                        <div class="product-image-placeholder">📱</div>
                    <% } %>
                </div>
                <div class="product-name"><%= p.getName() != null ? p.getName() : "Sản phẩm" %></div>
                <div class="product-price"><%= String.format("%,.0f", p.getPrice()) %> ₫</div>
                <div class="product-desc"><%= p.getDescription() != null ? p.getDescription() : "Sản phẩm chất lượng cao với công nghệ hiện đại nhất" %></div>
                <form action="<%= request.getContextPath() %>/addToCart" method="post" style="margin:0; width: 100%; display: flex; justify-content: center;">
                    <input type="hidden" name="productId" value="<%= p.getId() %>">
                    <button type="submit" class="add-cart-btn">🛒 Thêm vào giỏ</button>
                </form>
            </div>
            <%
                    }
                } else {
            %>
            <div class="empty-products">
                <p>📦</p>
                <p>Hiện chưa có sản phẩm nào. Vui lòng quay lại sau!</p>
            </div>
            <%
                }
            %>
        </div>
    </div>
    <jsp:include page="/home/footer.jsp" />
</body>
</html>