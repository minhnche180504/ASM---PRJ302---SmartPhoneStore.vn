<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.Product" %>
<%@ page import="java.text.DecimalFormat" %>
<%@ include file="/home/header.jsp" %>
<%
    Product p = (Product) request.getAttribute("product");
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><%= (p != null) ? p.getName() + " - SmartPhoneStore.vn" : "Chi tiết sản phẩm - SmartPhoneStore.vn" %></title>
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
        
        .product-detail-wrapper {
            max-width: 1400px;
            margin: 40px auto;
            padding: 0 40px;
        }
        
        .product-detail-container {
            background: #ffffff;
            border-radius: 28px;
            box-shadow: 
                0 8px 32px rgba(167, 139, 250, 0.1),
                0 4px 16px rgba(0, 0, 0, 0.04);
            padding: 50px;
            display: flex;
            gap: 60px;
            margin-bottom: 40px;
            position: relative;
            overflow: hidden;
        }
        
        .product-detail-container::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 6px;
            background: linear-gradient(90deg, #e0c3fc 0%, #8ec5fc 50%, #b8e6e6 100%);
        }
        
        .product-detail-image {
            flex: 0 0 500px;
            display: flex;
            align-items: center;
            justify-content: center;
            background: linear-gradient(135deg, #faf5ff 0%, #f3f0f7 100%);
            border-radius: 24px;
            padding: 40px;
            position: relative;
            overflow: hidden;
        }
        
        .product-detail-image::before {
            content: '';
            position: absolute;
            top: -50%;
            right: -50%;
            width: 200%;
            height: 200%;
            background: radial-gradient(circle, rgba(224, 195, 252, 0.1) 0%, transparent 70%);
            animation: rotate 20s linear infinite;
        }
        
        @keyframes rotate {
            from { transform: rotate(0deg); }
            to { transform: rotate(360deg); }
        }
        
        .product-detail-image img {
            max-width: 100%;
            max-height: 500px;
            width: auto;
            height: auto;
            object-fit: contain;
            border-radius: 20px;
            position: relative;
            z-index: 1;
            filter: drop-shadow(0 12px 24px rgba(107, 70, 193, 0.15));
            transition: transform 0.4s ease;
        }
        
        .product-detail-image:hover img {
            transform: scale(1.05);
        }
        
        .product-image-placeholder {
            width: 100%;
            height: 100%;
            background: linear-gradient(135deg, #e0c3fc 0%, #c4b5fd 100%);
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 8rem;
            border-radius: 20px;
            color: rgba(255, 255, 255, 0.9);
        }
        
        .product-detail-info {
            flex: 1;
            display: flex;
            flex-direction: column;
            justify-content: flex-start;
        }
        
        .product-category {
            display: inline-block;
            padding: 8px 20px;
            background: linear-gradient(135deg, #a78bfa 0%, #c4b5fd 100%);
            color: #ffffff;
            border-radius: 50px;
            font-size: 0.9rem;
            font-weight: 600;
            margin-bottom: 20px;
            box-shadow: 0 4px 12px rgba(167, 139, 250, 0.3);
        }
        
        .product-detail-name {
            font-size: 2.8rem;
            font-weight: 800;
            color: #2d3748;
            margin-bottom: 24px;
            line-height: 1.2;
            background: linear-gradient(135deg, #4a5568 0%, #2d3748 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }
        
        .product-detail-price {
            font-size: 2.2rem;
            font-weight: 800;
            background: linear-gradient(135deg, #7c3aed 0%, #a78bfa 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            margin-bottom: 30px;
            display: flex;
            align-items: center;
            gap: 12px;
        }
        
        .product-detail-price::before {
            content: '💰';
            font-size: 1.8rem;
            filter: none;
            -webkit-text-fill-color: initial;
        }
        
        .product-detail-desc {
            font-size: 1.1rem;
            color: #4a5568;
            margin-bottom: 40px;
            line-height: 1.8;
            padding: 24px;
            background: linear-gradient(135deg, #faf5ff 0%, #f3f0f7 100%);
            border-radius: 16px;
            border-left: 4px solid #a78bfa;
        }
        
        .product-actions {
            display: flex;
            gap: 20px;
            margin-top: auto;
            flex-wrap: wrap;
        }
        
        .btn {
            padding: 18px 40px;
            border: none;
            border-radius: 16px;
            font-size: 1.1rem;
            font-weight: 700;
            cursor: pointer;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
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
        
        .btn:active {
            transform: translateY(-1px);
        }
        
        .empty-product {
            max-width: 700px;
            margin: 60px auto;
            text-align: center;
            padding: 60px 40px;
            background: #ffffff;
            border-radius: 28px;
            box-shadow: 0 8px 32px rgba(167, 139, 250, 0.1);
        }
        
        .empty-product-icon {
            font-size: 5rem;
            margin-bottom: 20px;
            opacity: 0.6;
        }
        
        .empty-product-text {
            font-size: 1.3rem;
            color: #718096;
            margin-bottom: 30px;
        }
        
        .empty-product-btn {
            padding: 14px 32px;
            background: linear-gradient(135deg, #a78bfa 0%, #c4b5fd 100%);
            color: #ffffff;
            border: none;
            border-radius: 12px;
            font-size: 1rem;
            font-weight: 600;
            cursor: pointer;
            text-decoration: none;
            display: inline-block;
            transition: all 0.3s ease;
        }
        
        .empty-product-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(167, 139, 250, 0.4);
        }
        
        @media (max-width: 1024px) {
            .product-detail-container {
                flex-direction: column;
                gap: 40px;
                padding: 40px 30px;
            }
            
            .product-detail-image {
                flex: none;
                max-width: 100%;
            }
            
            .product-detail-name {
                font-size: 2.2rem;
            }
            
            .product-detail-price {
                font-size: 1.8rem;
            }
        }
        
        @media (max-width: 768px) {
            .product-detail-wrapper {
                padding: 0 20px;
            }
            
            .product-detail-container {
                padding: 30px 20px;
                border-radius: 20px;
            }
            
            .product-detail-image {
                padding: 30px 20px;
            }
            
            .product-detail-name {
                font-size: 1.8rem;
            }
            
            .product-detail-price {
                font-size: 1.6rem;
            }
            
            .product-actions {
                flex-direction: column;
            }
            
            .btn {
                width: 100%;
            }
        }
    </style>
</head>
<body>
    <div class="product-detail-wrapper">
        <%
            if (p != null) {
        %>
        <div class="product-detail-container">
            <div class="product-detail-image">
                <% if (p.getImage() != null && !p.getImage().trim().isEmpty() && !p.getImage().equals("null")) { %>
                    <img src="<%= p.getImage() %>" alt="<%= p.getName() %>" onerror="this.style.display='none'; this.nextElementSibling.style.display='flex';">
                    <div class="product-image-placeholder" style="display: none;">📱</div>
                <% } else { %>
                    <div class="product-image-placeholder">📱</div>
                <% } %>
            </div>
            <div class="product-detail-info">
                <% if (p.getCategory() != null && !p.getCategory().isEmpty()) { %>
                    <span class="product-category"><%= p.getCategory() %></span>
                <% } %>
                <h1 class="product-detail-name"><%= p.getName() != null ? p.getName() : "Sản phẩm" %></h1>
                <div class="product-detail-price"><%= String.format("%,.0f", p.getPrice()) %> ₫</div>
                <div class="product-detail-desc">
                    <%= p.getDescription() != null ? p.getDescription() : "Sản phẩm chất lượng cao với công nghệ hiện đại nhất. Được thiết kế với những tính năng tiên tiến, mang lại trải nghiệm tuyệt vời cho người dùng." %>
                </div>
                <div class="product-actions">
                    <form action="<%= request.getContextPath() %>/addToCart" method="post" style="flex: 1; margin: 0;">
                        <input type="hidden" name="productId" value="<%= p.getId() %>">
                        <button type="submit" class="btn btn-primary">
                            🛒 Thêm vào giỏ hàng
                        </button>
                    </form>
                    <a href="<%= request.getContextPath() %>/products" class="btn btn-secondary">
                        ← Quay lại danh sách
                    </a>
                </div>
            </div>
        </div>
        <%
            } else {
        %>
        <div class="empty-product">
            <div class="empty-product-icon">📦</div>
            <div class="empty-product-text">Không tìm thấy sản phẩm.</div>
            <a href="<%= request.getContextPath() %>/products" class="empty-product-btn">Xem tất cả sản phẩm</a>
        </div>
        <%
            }
        %>
    </div>
    <jsp:include page="/home/footer.jsp" />
</body>
</html>
