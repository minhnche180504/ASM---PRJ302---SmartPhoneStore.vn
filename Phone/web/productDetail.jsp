<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.Product" %>
<%@ page import="java.text.DecimalFormat" %>
<%@ include file="header.jsp" %>
<%
    // Lấy sản phẩm từ request attribute (giả sử đã được set ở servlet)
    Product p = (Product) request.getAttribute("product");
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>
        <%= (p != null) ? p.getName() + " - SmartPhoneStore.vn" : "Chi tiết sản phẩm - SmartPhoneStore.vn" %>
    </title>
    <meta name="description" content="Chi tiết sản phẩm tại SmartPhoneStore.vn">
    <meta content="width=device-width, initial-scale=1.0, maximum-scale=2.0, user-scalable=0" name="viewport">
    <style>
        .product-detail-container {
            max-width: 1100px;
            margin: 40px auto 40px auto;
            background: #fff;
            border-radius: 8px;
            box-shadow: 0 2px 12px rgba(0,0,0,0.07);
            display: flex;
            gap: 40px;
            padding: 36px 32px;
        }
        .product-detail-image {
            flex: 0 0 350px;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .product-detail-image img {
            max-width: 100%;
            max-height: 350px;
            border-radius: 8px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.04);
            background: #f7f7f7;
        }
        .product-detail-info {
            flex: 1;
            display: flex;
            flex-direction: column;
            justify-content: flex-start;
        }
        .product-detail-name {
            font-size: 2.1rem;
            font-weight: bold;
            margin-bottom: 18px;
            color: #222;
        }
        .product-detail-price {
            font-size: 1.5rem;
            color: #e53935;
            font-weight: bold;
            margin-bottom: 18px;
        }
        .product-detail-desc {
            font-size: 1.1rem;
            color: #444;
            margin-bottom: 28px;
            line-height: 1.6;
        }
        .add-cart-btn {
            background: #007bff;
            color: #fff;
            border: none;
            border-radius: 5px;
            padding: 12px 32px;
            cursor: pointer;
            font-size: 1.1rem;
            font-weight: 500;
            transition: background 0.2s;
        }
        .add-cart-btn:hover {
            background: #0056b3;
        }
        @media (max-width: 900px) {
            .product-detail-container {
                flex-direction: column;
                gap: 24px;
                padding: 24px 10px;
            }
            .product-detail-image {
                justify-content: flex-start;
            }
        }
    </style>
</head>
<body>
<%
    if (p != null) {
%>
    <div class="product-detail-container">
        <div class="product-detail-image">
            <img src="<%= p.getImage() %>" alt="<%= p.getName() %>">
        </div>
        <div class="product-detail-info">
            <div class="product-detail-name"><%= p.getName() %></div>
            <div class="product-detail-price"><%= String.format("%,.0f", p.getPrice()) %> VND</div>
            <div class="product-detail-desc"><%= p.getDescription() %></div>
            <form action="addToCart" method="post" style="margin-top:18px;">
                <input type="hidden" name="productId" value="<%= p.getId() %>">
                <button type="submit" class="add-cart-btn">Thêm vào giỏ hàng</button>
            </form>
        </div>
    </div>
<%
    } else {
%>
    <div style="max-width:700px; margin:60px auto; color:#888; font-size:1.2rem; text-align:center;">
        Không tìm thấy sản phẩm.
    </div>
<%
    }
%>
</body>
</html>
