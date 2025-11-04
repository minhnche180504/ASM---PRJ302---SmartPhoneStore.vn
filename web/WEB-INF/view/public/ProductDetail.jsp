<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>${product.pName} - Phone Shop</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/css/style.css" rel="stylesheet">
</head>
<body>
    <jsp:include page="Header.jsp"/>
    
    <div class="container my-5">
        <c:if test="${product != null}">
            <div class="row">
                <div class="col-md-6">
                    <img src="${product.imageUrl}" class="img-fluid rounded" alt="${product.pName}"
                         onerror="this.src='${pageContext.request.contextPath}/assets/img/placeholder.jpg'">
                </div>
                <div class="col-md-6">
                    <h1>${product.pName}</h1>
                    <p class="text-muted">Thương hiệu: ${product.brand}</p>
                    <p class="text-muted">Danh mục: ${product.catName}</p>
                    <h2 class="text-danger mb-4">
                        <fmt:formatNumber value="${product.price}" type="currency" currencyCode="VND"/>
                    </h2>
                    
                    <c:if test="${product.stock > 0}">
                        <div class="mb-3">
                            <label class="form-label">Số lượng:</label>
                            <input type="number" id="quantity" class="form-control" value="1" min="1" max="${product.stock}" style="width: 100px;">
                            <small class="text-muted">Còn ${product.stock} sản phẩm</small>
                        </div>
                        <form action="${pageContext.request.contextPath}/cart" method="post" class="d-inline">
                            <input type="hidden" name="action" value="add">
                            <input type="hidden" name="productId" value="${product.pId}">
                            <input type="hidden" name="quantity" id="quantityInput" value="1">
                            <button type="submit" class="btn btn-primary btn-lg">Thêm vào giỏ hàng</button>
                        </form>
                    </c:if>
                    <c:if test="${product.stock <= 0}">
                        <button class="btn btn-secondary btn-lg" disabled>Hết hàng</button>
                    </c:if>
                </div>
            </div>
            
            <div class="row mt-5">
                <div class="col-12">
                    <h3>Mô tả sản phẩm</h3>
                    <p>${product.description}</p>
                </div>
            </div>
        </c:if>
    </div>
    
    <jsp:include page="Footer.jsp"/>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        document.getElementById('quantity').addEventListener('change', function() {
            document.getElementById('quantityInput').value = this.value;
        });
    </script>
</body>
</html>

