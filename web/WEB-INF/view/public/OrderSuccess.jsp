<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Đặt hàng thành công - Phone Shop</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/css/style.css" rel="stylesheet">
</head>
<body>
    <jsp:include page="Header.jsp"/>
    
    <div class="container my-5">
        <div class="text-center">
            <div class="mb-4">
                <i class="bi bi-check-circle text-success" style="font-size: 4rem;">✓</i>
            </div>
            <h1 class="text-success mb-3">Đặt hàng thành công!</h1>
            <p class="lead">Cảm ơn bạn đã đặt hàng tại Phone Shop</p>
            
            <c:if test="${order != null}">
                <div class="card mt-4 mx-auto" style="max-width: 600px;">
                    <div class="card-body">
                        <h5>Mã đơn hàng: #${order.orderId}</h5>
                        <p>Tổng tiền: <strong class="text-danger">
                            <fmt:formatNumber value="${order.totalAmount}" type="currency" currencyCode="VND"/>
                        </strong></p>
                        <p>Trạng thái: <span class="badge bg-warning">${order.status}</span></p>
                    </div>
                </div>
            </c:if>
            
            <div class="mt-4">
                <a href="${pageContext.request.contextPath}/order-history" class="btn btn-primary">
                    Xem lịch sử đơn hàng
                </a>
                <a href="${pageContext.request.contextPath}/products" class="btn btn-outline-primary">
                    Tiếp tục mua sắm
                </a>
            </div>
        </div>
    </div>
    
    <jsp:include page="Footer.jsp"/>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

