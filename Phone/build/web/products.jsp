<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Product" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Danh sách sản phẩm - SmartPhoneStore.vn</title>
    <style>
        body {
            font-family: 'Segoe UI', Arial, sans-serif;
            background: #f7f7f7;
            margin: 0;
            padding: 0;
        }
        .section-title {
            text-align: center;
            font-size: 2rem;
            margin: 36px 0 24px 0;
            color: #222;
            letter-spacing: 1px;
        }
        .product-list {
            display: flex;
            flex-wrap: wrap;
            gap: 24px;
            max-width: 1200px;
            margin: 0 auto 60px auto;
            justify-content: flex-start;
        }
        .product-card {
            background: #fff;
            border-radius: 10px;
            box-shadow: 0 2px 12px rgba(0,0,0,0.07);
            padding: 22px 18px 18px 18px;
            width: calc(25% - 18px);
            min-width: 240px;
            box-sizing: border-box;
            display: flex;
            flex-direction: column;
            align-items: center;
            transition: box-shadow 0.2s;
        }
        .product-card:hover {
            box-shadow: 0 4px 18px rgba(0,0,0,0.13);
        }
        .product-card img {
            width: 100%;
            max-width: 180px;
            height: 180px;
            object-fit: contain;
            margin-bottom: 16px;
        }
        .product-name {
            font-size: 1.15rem;
            font-weight: 600;
            margin-bottom: 8px;
            color: #222;
            text-align: center;
        }
        .product-price {
            color: #e53935;
            font-size: 1.1rem;
            font-weight: 500;
            margin-bottom: 8px;
        }
        .product-desc {
            color: #666;
            font-size: 0.98rem;
            margin-bottom: 14px;
            text-align: center;
            min-height: 38px;
        }
        .add-cart-btn {
            background: #007bff;
            color: #fff;
            border: none;
            border-radius: 5px;
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
    <%@ include file="header.jsp" %>
    <h2 class="section-title">Tất cả sản phẩm</h2>
    <div class="product-list">
        <%
            // Lấy danh sách sản phẩm từ request attribute (giả sử đã được set ở servlet)
            List<Product> products = (List<Product>) request.getAttribute("products");
            if (products != null && !products.isEmpty()) {
                for (Product p : products) {
        %>
        <div class="product-card">
            <a href="productDetail?id=<%= p.getId() %>">
                <img src="<%= p.getImage() %>" alt="<%= p.getName() %>">
            </a>
            <div class="product-name">
                <a href="productDetail?id=<%= p.getId() %>" style="color:inherit; text-decoration:none;">
                    <%= p.getName() %>
                </a>
            </div>
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
