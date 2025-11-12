<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Trang chủ - Phone Shop</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/css/style.css" rel="stylesheet">
</head>
<body>
    <jsp:include page="Header.jsp"/>
    
    <!-- Banner Section -->
    <section class="banner-section bg-primary text-white py-5 mb-5">
        <div class="container text-center">
            <h1 class="display-4">Chào mừng đến Phone Shop</h1>
            <p class="lead">Điện thoại thông minh chính hãng, giá tốt nhất</p>
            <a href="${pageContext.request.contextPath}/products" class="btn btn-light btn-lg">Mua ngay</a>
        </div>
    </section>
    
    <!-- Promotions Section -->
    <c:if test="${not empty promotions}">
        <section class="container mb-5">
            <h2 class="mb-4">🎉 Khuyến mãi đặc biệt</h2>
            <div class="row">
                <c:forEach var="promo" items="${promotions}" begin="0" end="2">
                    <div class="col-md-4 mb-3">
                        <div class="card border-danger">
                            <div class="card-body text-center">
                                <h5 class="card-title text-danger">${promo.promoCode}</h5>
                                <p class="card-text">Giảm <strong>${promo.discountPercent}%</strong></p>
                                <p class="text-muted small">${promo.description}</p>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </section>
    </c:if>
    
    <!-- Best Sellers Section -->
    <section class="container mb-5">
        <h2 class="mb-4">🔥 Sản phẩm bán chạy</h2>
        <div class="row">
            <c:forEach var="product" items="${bestSellers}">
                <div class="col-md-3 mb-4">
                    <div class="card h-100">
                        <img src="${product.imageUrl}" class="card-img-top" alt="${product.pName}" 
                             onerror="this.src='${pageContext.request.contextPath}/assets/img/placeholder.jpg'">
                        <div class="card-body">
                            <h5 class="card-title">${product.pName}</h5>
                            <p class="text-muted">${product.brand}</p>
                            <p class="text-danger fw-bold">
                                <fmt:formatNumber value="${product.price}" type="currency" currencyCode="VND"/>
                            </p>
                            <c:if test="${product.stock > 0}">
                                <span class="badge bg-success">Còn hàng</span>
                            </c:if>
                            <c:if test="${product.stock <= 0}">
                                <span class="badge bg-danger">Hết hàng</span>
                            </c:if>
                        </div>
                        <div class="card-footer">
                            <a href="${pageContext.request.contextPath}/product-detail?id=${product.pId}" 
                               class="btn btn-primary w-100">Xem chi tiết</a>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </section>
    
    <jsp:include page="Footer.jsp"/>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

