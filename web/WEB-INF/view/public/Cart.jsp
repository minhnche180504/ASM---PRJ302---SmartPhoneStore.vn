<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Giỏ hàng - Phone Shop</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/css/style.css" rel="stylesheet">
</head>
<body>
    <jsp:include page="Header.jsp"/>
    
    <div class="container my-5">
        <h1 class="mb-4">Giỏ hàng của bạn</h1>
        
        <c:if test="${empty cart}">
            <div class="alert alert-info text-center">
                <h4>Giỏ hàng trống</h4>
                <a href="${pageContext.request.contextPath}/products" class="btn btn-primary">Tiếp tục mua sắm</a>
            </div>
        </c:if>
        
        <c:if test="${not empty cart}">
            <div class="row">
                <div class="col-md-8">
                    <table class="table">
                        <thead>
                            <tr>
                                <th>Sản phẩm</th>
                                <th>Giá</th>
                                <th>Số lượng</th>
                                <th>Thành tiền</th>
                                <th>Thao tác</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="item" items="${cart}">
                                <tr>
                                    <td>
                                        <img src="${item.product.imageUrl}" alt="${item.product.pName}" 
                                             style="width: 50px; height: 50px; object-fit: cover;"
                                             onerror="this.src='${pageContext.request.contextPath}/assets/img/placeholder.jpg'">
                                        <strong>${item.product.pName}</strong>
                                    </td>
                                    <td>
                                        <fmt:formatNumber value="${item.product.price}" type="currency" currencyCode="VND"/>
                                    </td>
                                    <td>
                                        <form method="post" action="${pageContext.request.contextPath}/cart" class="d-inline">
                                            <input type="hidden" name="action" value="update">
                                            <input type="hidden" name="productId" value="${item.product.pId}">
                                            <input type="number" name="quantity" value="${item.quantity}" min="1" 
                                                   max="${item.product.stock}" class="form-control" style="width: 80px;" 
                                                   onchange="this.form.submit()">
                                        </form>
                                    </td>
                                    <td>
                                        <strong><fmt:formatNumber value="${item.subtotal}" type="currency" currencyCode="VND"/></strong>
                                    </td>
                                    <td>
                                        <form method="post" action="${pageContext.request.contextPath}/cart" class="d-inline">
                                            <input type="hidden" name="action" value="remove">
                                            <input type="hidden" name="productId" value="${item.product.pId}">
                                            <button type="submit" class="btn btn-danger btn-sm">Xóa</button>
                                        </form>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
                <div class="col-md-4">
                    <div class="card">
                        <div class="card-body">
                            <h5 class="card-title">Tổng cộng</h5>
                            <hr>
                            <p class="d-flex justify-content-between">
                                <span>Tạm tính:</span>
                                <strong><fmt:formatNumber value="${total}" type="currency" currencyCode="VND"/></strong>
                            </p>
                            <hr>
                            <p class="d-flex justify-content-between">
                                <span><strong>Tổng tiền:</strong></span>
                                <strong class="text-danger"><fmt:formatNumber value="${total}" type="currency" currencyCode="VND"/></strong>
                            </p>
                            <a href="${pageContext.request.contextPath}/checkout" class="btn btn-primary w-100 mt-3">
                                Thanh toán
                            </a>
                            <a href="${pageContext.request.contextPath}/products" class="btn btn-outline-secondary w-100 mt-2">
                                Tiếp tục mua sắm
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </c:if>
    </div>
    
    <jsp:include page="Footer.jsp"/>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

