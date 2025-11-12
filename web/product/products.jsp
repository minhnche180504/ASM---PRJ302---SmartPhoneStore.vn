<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Product" %>
<jsp:include page="/home/header.jsp" />

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sản phẩm - SmartPhoneStore.vn</title>
    <link rel="shortcut icon" href="//theme.hstatic.net/1000090299/1000362108/14/favicon.png?v=1134" type="image/png">
    <style>
        /* General Reset & Body */
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

        /* Products Container */
        .products-container {
            max-width: 1400px;
            margin: 60px auto;
            padding: 0 20px;
        }

        /* Products Header */
        .products-header {
            background: linear-gradient(135deg, #6b46c1 0%, #8b5cf6 100%);
            color: white;
            padding: 50px 40px;
            border-radius: 24px;
            margin-bottom: 40px;
            box-shadow: 0 12px 40px rgba(107, 70, 193, 0.3);
            text-align: center;
            position: relative;
            overflow: hidden;
        }

        .products-header::before {
            content: '';
            position: absolute;
            top: -50px;
            right: -50px;
            width: 200px;
            height: 200px;
            background: rgba(255, 255, 255, 0.1);
            border-radius: 50%;
            filter: blur(40px);
        }

        .products-header::after {
            content: '';
            position: absolute;
            bottom: -50px;
            left: -50px;
            width: 150px;
            height: 150px;
            background: rgba(255, 255, 255, 0.1);
            border-radius: 50%;
            filter: blur(40px);
        }

        .products-header h1 {
            font-size: 3rem;
            font-weight: 800;
            margin-bottom: 15px;
            position: relative;
            z-index: 1;
            text-shadow: 0 4px 15px rgba(0,0,0,0.2);
        }

        .products-header p {
            font-size: 1.2rem;
            opacity: 0.95;
            position: relative;
            z-index: 1;
            font-weight: 500;
        }

        /* Products Controls */
        .products-controls {
            background: #ffffff;
            padding: 30px;
            border-radius: 20px;
            margin-bottom: 30px;
            box-shadow: 0 8px 25px rgba(142, 197, 252, 0.15);
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 20px;
            border: 1px solid #e2e8f0;
        }

        .search-result {
            font-size: 1.2rem;
            color: #4a5568;
            font-weight: 700;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .search-result .keyword {
            color: #8b5cf6;
            font-weight: 800;
            background: linear-gradient(135deg, #8b5cf6 0%, #c4b5fd 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }

        .products-controls form {
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .products-controls select {
            padding: 12px 20px;
            border: 2px solid #e2e8f0;
            border-radius: 12px;
            font-size: 1rem;
            background: #f7fafc;
            color: #2d3748;
            cursor: pointer;
            outline: none;
            transition: all 0.3s ease;
            font-weight: 600;
            min-width: 200px;
        }

        .products-controls select:focus {
            border-color: #a78bfa;
            background: #fff;
            box-shadow: 0 0 0 4px rgba(167, 139, 250, 0.2);
        }

        .products-controls select:hover {
            border-color: #c4b5fd;
        }

        /* Product List */
        .product-list {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            gap: 30px;
            margin-bottom: 60px;
        }

        /* Product Card */
        .product-card {
            background: #ffffff;
            border-radius: 20px;
            box-shadow: 0 8px 25px rgba(142, 197, 252, 0.15);
            padding: 0;
            display: flex;
            flex-direction: column;
            transition: all 0.4s ease;
            position: relative;
            overflow: hidden;
            border: 1px solid #e2e8f0;
        }

        .product-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 4px;
            background: linear-gradient(90deg, #e0c3fc 0%, #8ec5fc 100%);
            transform: scaleX(0);
            transition: transform 0.4s ease;
            z-index: 1;
        }

        .product-card:hover {
            box-shadow: 0 16px 40px rgba(142, 197, 252, 0.3);
            transform: translateY(-8px);
            border-color: #c4b5fd;
        }

        .product-card:hover::before {
            transform: scaleX(1);
        }

        .product-image-wrapper {
            width: 100%;
            height: 280px;
            display: flex;
            align-items: center;
            justify-content: center;
            background: linear-gradient(135deg, #faf5ff 0%, #f3f0f7 100%);
            padding: 25px;
            position: relative;
            overflow: hidden;
        }

        .product-card img {
            max-width: 85%;
            max-height: 85%;
            width: auto;
            height: auto;
            object-fit: contain;
            transition: transform 0.4s ease;
            filter: drop-shadow(0 8px 16px rgba(107, 70, 193, 0.1));
            z-index: 1;
        }

        .product-card:hover img {
            transform: scale(1.1) rotate(2deg);
        }

        .product-image-placeholder {
            width: 100%;
            height: 100%;
            background: linear-gradient(135deg, #e0c3fc 0%, #c4b5fd 100%);
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 5rem;
            border-radius: 0;
            opacity: 0.9;
        }

        .product-info {
            padding: 25px;
            display: flex;
            flex-direction: column;
            flex: 1;
        }

        .product-category {
            font-size: 0.85rem;
            font-weight: 600;
            color: #8b5cf6;
            text-transform: uppercase;
            margin-bottom: 10px;
            letter-spacing: 1px;
        }

        .product-name {
            font-size: 1.3rem;
            font-weight: 700;
            color: #2d3748;
            margin-bottom: 12px;
            line-height: 1.4;
            min-height: 56px;
            display: flex;
            align-items: center;
        }

        .product-name a {
            color: inherit;
            text-decoration: none;
            transition: color 0.3s ease;
        }

        .product-name a:hover {
            color: #8b5cf6;
        }

        .product-price {
            color: #ef4444;
            font-size: 1.6rem;
            font-weight: 800;
            margin-bottom: 15px;
            letter-spacing: 0.5px;
        }

        .product-desc {
            font-size: 0.95rem;
            color: #4a5568;
            margin-bottom: 20px;
            line-height: 1.6;
            min-height: 72px;
            max-height: 72px;
            overflow: hidden;
            text-overflow: ellipsis;
            display: -webkit-box;
            -webkit-line-clamp: 3;
            line-clamp: 3;
            -webkit-box-orient: vertical;
        }

        .product-actions {
            width: 100%;
            display: flex;
            gap: 12px;
            margin-top: auto;
        }

        .btn {
            flex: 1;
            padding: 14px 20px;
            border: none;
            border-radius: 12px;
            font-size: 1rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            text-decoration: none;
            text-align: center;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
        }

        .btn-primary {
            background: linear-gradient(135deg, #8b5cf6 0%, #a78bfa 100%);
            color: white;
        }

        .btn-primary:hover {
            background: linear-gradient(135deg, #a78bfa 0%, #8b5cf6 100%);
            transform: translateY(-3px);
            box-shadow: 0 8px 25px rgba(139, 92, 246, 0.4);
        }

        .btn-secondary {
            background: #f7fafc;
            color: #4a5568;
            border: 2px solid #e2e8f0;
        }

        .btn-secondary:hover {
            background: #f0f4f8;
            border-color: #c4b5fd;
            color: #8b5cf6;
            transform: translateY(-3px);
            box-shadow: 0 8px 25px rgba(160, 174, 192, 0.2);
        }

        .btn:active {
            transform: translateY(0);
        }

        /* Empty Products */
        .empty-products {
            grid-column: 1 / -1;
            text-align: center;
            padding: 80px 40px;
            background: #ffffff;
            border-radius: 24px;
            box-shadow: 0 12px 40px rgba(142, 197, 252, 0.15);
            border: 1px solid #e2e8f0;
        }

        .empty-products-icon {
            font-size: 6rem;
            margin-bottom: 25px;
            opacity: 0.7;
            color: #a0aec0;
        }

        .empty-products h3 {
            margin: 0 0 15px 0;
            color: #4a5568;
            font-size: 2rem;
            font-weight: 700;
        }

        .empty-products p {
            margin: 0 0 30px 0;
            font-size: 1.1rem;
            color: #718096;
            line-height: 1.6;
        }

        .empty-products .btn {
            max-width: 250px;
            margin: 0 auto;
        }

        /* Responsive */
        @media (max-width: 1200px) {
            .product-list {
                grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
                gap: 25px;
            }
        }

        @media (max-width: 900px) {
            .products-container {
                margin: 40px auto;
                padding: 0 15px;
            }

            .products-header {
                padding: 35px 30px;
                border-radius: 20px;
            }

            .products-header h1 {
                font-size: 2.2rem;
            }

            .products-header p {
                font-size: 1.1rem;
            }

            .products-controls {
                flex-direction: column;
                align-items: stretch;
                padding: 25px;
            }

            .products-controls form {
                width: 100%;
            }

            .products-controls select {
                width: 100%;
                min-width: auto;
            }

            .product-list {
                grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
                gap: 20px;
            }

            .product-image-wrapper {
                height: 240px;
            }
        }

        @media (max-width: 600px) {
            .products-container {
                margin: 20px auto;
                padding: 0 10px;
            }

            .products-header {
                padding: 30px 20px;
                border-radius: 18px;
            }

            .products-header h1 {
                font-size: 1.8rem;
            }

            .products-header p {
                font-size: 1rem;
            }

            .products-controls {
                padding: 20px;
                border-radius: 15px;
            }

            .search-result {
                font-size: 1rem;
            }

            .product-list {
                grid-template-columns: 1fr;
                gap: 20px;
            }

            .product-image-wrapper {
                height: 220px;
                padding: 20px;
            }

            .product-info {
                padding: 20px;
            }

            .product-name {
                font-size: 1.2rem;
                min-height: auto;
            }

            .product-price {
                font-size: 1.4rem;
            }

            .product-desc {
                font-size: 0.9rem;
                min-height: auto;
                max-height: none;
            }

            .product-actions {
                flex-direction: column;
            }

            .btn {
                width: 100%;
            }

            .empty-products {
                padding: 60px 25px;
                border-radius: 20px;
            }

            .empty-products-icon {
                font-size: 4rem;
            }

            .empty-products h3 {
                font-size: 1.6rem;
            }

            .empty-products p {
                font-size: 1rem;
            }
        }

        @media (max-width: 480px) {
            .products-header {
                padding: 25px 15px;
            }

            .products-header h1 {
                font-size: 1.5rem;
            }

            .products-header p {
                font-size: 0.9rem;
            }

            .product-image-wrapper {
                height: 200px;
                padding: 15px;
            }

            .product-image-placeholder {
                font-size: 4rem;
            }

            .product-info {
                padding: 15px;
            }

            .product-name {
                font-size: 1.1rem;
            }

            .product-price {
                font-size: 1.3rem;
            }

            .product-desc {
                font-size: 0.85rem;
            }

            .btn {
                padding: 12px 18px;
                font-size: 0.95rem;
            }
        }
    </style>
</head>
<body>
    <div class="products-container">
        <div class="products-header">
            <h1>📱 Sản phẩm</h1>
            <p>Khám phá bộ sưu tập điện thoại và phụ kiện chất lượng cao của chúng tôi</p>
        </div>
        
        <div class="products-controls">
            <% 
                String searchKeyword = (String) request.getAttribute("searchKeyword");
                String selectedCategory = (String) request.getAttribute("selectedCategory");
            %>
            <% if (searchKeyword != null && !searchKeyword.isEmpty()) { %>
                <div class="search-result">
                    🔍 Kết quả tìm kiếm cho: <span class="keyword">"<%= searchKeyword %>"</span>
                </div>
            <% } else if (selectedCategory != null && !selectedCategory.isEmpty()) { %>
                <div class="search-result">
                    📂 Danh mục: <span class="keyword"><%= selectedCategory %></span>
                </div>
            <% } else { %>
                <div class="search-result">
                    📱 Tất cả sản phẩm
                </div>
            <% } %>
            
            <form method="get" class="sort-form">
                <% if (searchKeyword != null && !searchKeyword.isEmpty()) { %>
                    <input type="hidden" name="search" value="<%= searchKeyword %>">
                <% } %>
                <% if (selectedCategory != null && !selectedCategory.isEmpty()) { %>
                    <input type="hidden" name="category" value="<%= selectedCategory %>">
                <% } %>
                <select name="sort" onchange="this.form.submit()">
                    <option value="">🔄 Sắp xếp theo giá</option>
                    <option value="asc" <%= "asc".equals(request.getParameter("sort")) ? "selected" : "" %>>💰 Giá tăng dần</option>
                    <option value="desc" <%= "desc".equals(request.getParameter("sort")) ? "selected" : "" %>>💎 Giá giảm dần</option>
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
                        <a href="<%= request.getContextPath() %>/productDetail?id=<%= p.getId() %>" style="width: 100%; height: 100%; display: flex; align-items: center; justify-content: center;">
                            <img src="<%= imageUrl %>" alt="<%= p.getName() != null ? p.getName() : "Product" %>" onerror="this.style.display='none'; this.parentElement.nextElementSibling.style.display='flex';">
                        </a>
                        <div class="product-image-placeholder" style="display: none;">📱</div>
                    <% } else { %>
                        <div class="product-image-placeholder">📱</div>
                    <% } %>
                </div>
                <div class="product-info">
                    <% if (p.getCategory() != null && !p.getCategory().isEmpty()) { %>
                        <div class="product-category"><%= p.getCategory() %></div>
                    <% } else { %>
                        <div class="product-category">Điện thoại</div>
                    <% } %>
                    <div class="product-name">
                        <a href="<%= request.getContextPath() %>/productDetail?id=<%= p.getId() %>">
                            <%= p.getName() != null ? p.getName() : "Sản phẩm" %>
                        </a>
                    </div>
                    <div class="product-price"><%= String.format("%,.0f", p.getPrice()) %> ₫</div>
                    <div class="product-desc"><%= p.getDescription() != null ? p.getDescription() : "Sản phẩm chất lượng cao với công nghệ hiện đại" %></div>
                    <div class="product-actions">
                        <a href="<%= request.getContextPath() %>/productDetail?id=<%= p.getId() %>" class="btn btn-secondary">🔍 Chi tiết</a>
                        <form action="<%= request.getContextPath() %>/addToCart" method="post" style="flex: 1; margin: 0;">
                            <input type="hidden" name="productId" value="<%= p.getId() %>">
                            <button type="submit" class="btn btn-primary">🛒 Thêm</button>
                        </form>
                    </div>
                </div>
            </div>
            <%
                    }
                } else {
            %>
            <div class="empty-products">
                <div class="empty-products-icon">📦</div>
                <h3>Không tìm thấy sản phẩm</h3>
                <p>Hiện chưa có sản phẩm nào phù hợp với tiêu chí của bạn. Vui lòng thử lại sau hoặc xem tất cả sản phẩm!</p>
                <a href="<%= request.getContextPath() %>/products" class="btn btn-primary">📱 Xem tất cả sản phẩm</a>
                <a href="<%= request.getContextPath() %>/home" class="btn btn-secondary" style="margin-top: 15px;">🏠 Về trang chủ</a>
            </div>
            <%
                }
            %>
        </div>
    </div>
    
    <jsp:include page="/home/footer.jsp" />
</body>
</html>
