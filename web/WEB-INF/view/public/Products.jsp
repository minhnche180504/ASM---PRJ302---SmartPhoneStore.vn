<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Sản phẩm - Phone Shop</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/css/style.css" rel="stylesheet">
</head>
<body>
    <jsp:include page="Header.jsp"/>
    
    <div class="container my-5">
        <h1 class="mb-4">Danh sách sản phẩm</h1>
        
        <!-- Filter Section -->
        <div class="card mb-4">
            <div class="card-body">
                <form method="get" action="${pageContext.request.contextPath}/products" class="row g-3">
                    <div class="col-md-3">
                        <label class="form-label">Danh mục</label>
                        <select name="category" class="form-select">
                            <option value="">Tất cả</option>
                            <c:forEach var="cat" items="${categories}">
                                <option value="${cat.catId}" ${selectedCategory == cat.catId ? 'selected' : ''}>
                                    ${cat.catName}
                                </option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="col-md-3">
                        <label class="form-label">Thương hiệu</label>
                        <input type="text" name="brand" class="form-control" placeholder="Apple, Samsung..." 
                               value="${selectedBrand}">
                    </div>
                    <div class="col-md-2">
                        <label class="form-label">Giá từ</label>
                        <input type="number" name="minPrice" class="form-control" placeholder="0" 
                               value="${minPrice}">
                    </div>
                    <div class="col-md-2">
                        <label class="form-label">Giá đến</label>
                        <input type="number" name="maxPrice" class="form-control" placeholder="50000000" 
                               value="${maxPrice}">
                    </div>
                    <div class="col-md-2">
                        <label class="form-label">&nbsp;</label>
                        <button type="submit" class="btn btn-primary w-100">Lọc</button>
                    </div>
                </form>
                <form method="get" action="${pageContext.request.contextPath}/products" class="mt-3">
                    <div class="input-group">
                        <input type="text" name="search" class="form-control" placeholder="Tìm kiếm sản phẩm..." 
                               value="${searchQuery}">
                        <button type="submit" class="btn btn-outline-secondary">Tìm kiếm</button>
                    </div>
                </form>
            </div>
        </div>
        
        <!-- Products Grid -->
        <div class="row">
            <c:forEach var="product" items="${products}">
                <div class="col-md-3 mb-4">
                    <div class="card h-100">
                        <img src="${product.imageUrl}" class="card-img-top" alt="${product.pName}" 
                             style="height: 200px; object-fit: cover;"
                             onerror="this.src='${pageContext.request.contextPath}/assets/img/placeholder.jpg'">
                        <div class="card-body">
                            <h5 class="card-title">${product.pName}</h5>
                            <p class="text-muted">${product.brand}</p>
                            <p class="text-danger fw-bold">
                                <fmt:formatNumber value="${product.price}" type="currency" currencyCode="VND"/>
                            </p>
                            <c:if test="${product.stock > 0}">
                                <span class="badge bg-success">Còn ${product.stock} sản phẩm</span>
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
        
        <c:if test="${empty products}">
            <div class="alert alert-info text-center">
                <h4>Không tìm thấy sản phẩm nào</h4>
                <p>Vui lòng thử lại với bộ lọc khác</p>
            </div>
        </c:if>
    </div>
    
    <jsp:include page="Footer.jsp"/>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

