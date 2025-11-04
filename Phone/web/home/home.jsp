<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Product" %>
<jsp:include page="header.jsp" />

<!DOCTYPE html>
<html>
<head>
    <title>SmartPhoneStore.vn - Trang chủ</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 30px;
            background: #f9f9f9;
        }
        .main-banner {
            width: 100%;
            max-width: 1200px;
            margin: 0 auto 40px auto;
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 2px 12px rgba(0,0,0,0.08);
        }
        .main-banner img {
            width: 100%;
            display: block;
        }
        .section-title {
            font-size: 2rem;
            color: #222;
            margin-bottom: 18px;
            margin-top: 0;
        }
        .product-list {
            display: flex;
            flex-wrap: wrap;
            gap: 24px;
            max-width: 1200px;
            margin: 0 auto 40px auto;
        }
        .product-card {
            background: #fff;
            border-radius: 8px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.04);
            width: calc(25% - 18px);
            min-width: 220px;
            padding: 18px 14px 16px 14px;
            display: flex;
            flex-direction: column;
            align-items: center;
            transition: box-shadow 0.2s;
        }
        .product-card:hover {
            box-shadow: 0 4px 16px rgba(0,0,0,0.10);
        }
        .product-card img {
            max-width: 120px;
            max-height: 120px;
            margin-bottom: 12px;
        }
        .product-name {
            font-size: 1.1rem;
            font-weight: bold;
            color: #222;
            margin-bottom: 8px;
            text-align: center;
        }
        .product-price {
            color: #e53935;
            font-size: 1.1rem;
            margin-bottom: 10px;
        }
        .product-desc {
            font-size: 0.95rem;
            color: #666;
            margin-bottom: 12px;
            text-align: center;
            min-height: 38px;
        }
        .add-cart-btn {
            background: #007bff;
            color: #fff;
            border: none;
            border-radius: 4px;
            padding: 7px 18px;
            cursor: pointer;
            font-size: 1rem;
            transition: background 0.2s;
        }
        .add-cart-btn:hover {
            background: #0056b3;
        }
        @media (max-width: 900px) {
            .product-card { width: calc(33.33% - 16px);}
        }
        @media (max-width: 600px) {
            .product-list { flex-direction: column; gap: 18px;}
            .product-card { width: 100%;}
        }
    </style>
</head>
<body>
    <div class="main-banner">
        <img src="https://theme.hstatic.net/1000090299/1000362108/14/slider_item_1_image.jpg?v=1134" alt="SmartPhoneStore.vn Banner">
    </div>
    <div style="display: flex; align-items: center; justify-content: center; gap: 18px; margin-bottom: 18px;">
        <h2 class="section-title" style="margin: 0;">Sản phẩm nổi bật</h2>
        <form method="get" style="margin-left: 18px;">
            <select name="sort" onchange="this.form.submit()" style="padding: 6px 12px; border-radius: 4px; border: 1px solid #ccc; font-size: 1rem;">
                <option value="">Sắp xếp theo giá</option>
                <option value="asc" <%= "asc".equals(request.getParameter("sort")) ? "selected" : "" %>>Giá tăng dần</option>
                <option value="desc" <%= "desc".equals(request.getParameter("sort")) ? "selected" : "" %>>Giá giảm dần</option>
            </select>
        </form>
    </div>
    <div class="product-list">
        <%
            // Lấy danh sách sản phẩm từ request attribute (giả sử đã được set ở servlet)
            List<Product> products = (List<Product>) request.getAttribute("products");
            if (products != null && !products.isEmpty()) {
                for (Product p : products) {
        %>
        <div class="product-card">
            <img src="<%= p.getImage() %>" alt="<%= p.getName() %>">
            <div class="product-name"><%= p.getName() %></div>
            <div class="product-price"><%= String.format("%,.0f", p.getPrice()) %> VND</div>
            <div class="product-desc"><%= p.getDescription() %></div>
            <form action="addToCart" method="post" style="margin:0;">
                <input type="hidden" name="productId" value="<%= p.getId() %>">
                <button type="submit" class="add-cart-btn">Thêm vào giỏ</button>
            </form>
        </div>
        <%
                }
            } else {
        %>
        <div style="color:#888; font-size:1.1rem;">Hiện chưa có sản phẩm nào.</div>
        <%
            }
        %>
    </div>
</body>
</html>