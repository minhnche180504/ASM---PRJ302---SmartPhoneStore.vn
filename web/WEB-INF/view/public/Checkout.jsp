<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Thanh toán - Phone Shop</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/css/style.css" rel="stylesheet">
</head>
<body>
    <jsp:include page="Header.jsp"/>
    
    <div class="container my-5">
        <h1 class="mb-4">Thanh toán</h1>
        
        <c:if test="${not empty error}">
            <div class="alert alert-danger">${error}</div>
        </c:if>
        
        <form method="post" action="${pageContext.request.contextPath}/checkout">
            <div class="row">
                <div class="col-md-8">
                    <div class="card mb-3">
                        <div class="card-header">
                            <h5>Thông tin giao hàng</h5>
                        </div>
                        <div class="card-body">
                            <div class="mb-3">
                                <label class="form-label">Họ tên *</label>
                                <input type="text" name="shippingName" class="form-control" 
                                       value="${user.name}" required>
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Số điện thoại *</label>
                                <input type="text" name="shippingPhone" class="form-control" 
                                       value="${user.phone}" required>
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Địa chỉ *</label>
                                <textarea name="shippingAddress" class="form-control" rows="3" required>${user.address}</textarea>
                            </div>
                        </div>
                    </div>
                    
                    <div class="card">
                        <div class="card-header">
                            <h5>Phương thức thanh toán</h5>
                        </div>
                        <div class="card-body">
                            <div class="form-check mb-2">
                                <input class="form-check-input" type="radio" name="paymentMethod" 
                                       value="COD" id="cod" checked>
                                <label class="form-check-label" for="cod">
                                    Thanh toán khi nhận hàng (COD)
                                </label>
                            </div>
                            <div class="form-check">
                                <input class="form-check-input" type="radio" name="paymentMethod" 
                                       value="ONLINE" id="online">
                                <label class="form-check-label" for="online">
                                    Thanh toán online
                                </label>
                            </div>
                        </div>
                    </div>
                    
                    <div class="card mt-3">
                        <div class="card-header">
                            <h5>Mã khuyến mãi</h5>
                        </div>
                        <div class="card-body">
                            <input type="text" name="promoCode" class="form-control" 
                                   placeholder="Nhập mã khuyến mãi (nếu có)">
                        </div>
                    </div>
                </div>
                
                <div class="col-md-4">
                    <div class="card">
                        <div class="card-header">
                            <h5>Đơn hàng</h5>
                        </div>
                        <div class="card-body">
                            <c:forEach var="item" items="${cart}">
                                <div class="d-flex justify-content-between mb-2">
                                    <span>${item.product.pName} x${item.quantity}</span>
                                    <span><fmt:formatNumber value="${item.subtotal}" type="currency" currencyCode="VND"/></span>
                                </div>
                            </c:forEach>
                            <hr>
                            <div class="d-flex justify-content-between">
                                <strong>Tổng cộng:</strong>
                                <strong class="text-danger">
                                    <fmt:formatNumber value="${total}" type="currency" currencyCode="VND"/>
                                </strong>
                            </div>
                            <button type="submit" class="btn btn-primary w-100 mt-3">
                                Đặt hàng
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </form>
    </div>
    
    <jsp:include page="Footer.jsp"/>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

