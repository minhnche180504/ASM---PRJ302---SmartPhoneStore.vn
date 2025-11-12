<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Quản lý đơn hàng - Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/css/style.css" rel="stylesheet">
</head>
<body>
    <jsp:include page="AdminHeader.jsp"/>
    
    <div class="container-fluid my-4">
        <h1 class="mb-4">Quản lý đơn hàng</h1>
        
        <div class="card mb-3">
            <div class="card-body">
                <form method="get" action="${pageContext.request.contextPath}/admin/orders" class="row g-3">
                    <div class="col-md-4">
                        <label class="form-label">Lọc theo trạng thái</label>
                        <select name="status" class="form-select">
                            <option value="">Tất cả</option>
                            <option value="PENDING" ${param.status == 'PENDING' ? 'selected' : ''}>Chờ xử lý</option>
                            <option value="CONFIRMED" ${param.status == 'CONFIRMED' ? 'selected' : ''}>Đã xác nhận</option>
                            <option value="SHIPPING" ${param.status == 'SHIPPING' ? 'selected' : ''}>Đang giao</option>
                            <option value="DELIVERED" ${param.status == 'DELIVERED' ? 'selected' : ''}>Đã giao</option>
                            <option value="CANCELLED" ${param.status == 'CANCELLED' ? 'selected' : ''}>Đã hủy</option>
                        </select>
                    </div>
                    <div class="col-md-2">
                        <label class="form-label">&nbsp;</label>
                        <button type="submit" class="btn btn-primary w-100">Lọc</button>
                    </div>
                </form>
            </div>
        </div>
        
        <div class="card">
            <div class="card-body">
                <div class="table-responsive">
                    <table class="table table-striped">
                        <thead>
                            <tr>
                                <th>Mã đơn</th>
                                <th>Khách hàng</th>
                                <th>Tổng tiền</th>
                                <th>Trạng thái</th>
                                <th>Thanh toán</th>
                                <th>Ngày đặt</th>
                                <th>Thao tác</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="order" items="${orders}">
                                <tr>
                                    <td>#${order.orderId}</td>
                                    <td>${order.userName}</td>
                                    <td><fmt:formatNumber value="${order.totalAmount}" type="currency" currencyCode="VND"/></td>
                                    <td>
                                        <form method="post" action="${pageContext.request.contextPath}/admin/orders" class="d-inline">
                                            <input type="hidden" name="action" value="updateStatus">
                                            <input type="hidden" name="orderId" value="${order.orderId}">
                                            <select name="status" class="form-select form-select-sm" onchange="this.form.submit()">
                                                <option value="PENDING" ${order.status == 'PENDING' ? 'selected' : ''}>Chờ xử lý</option>
                                                <option value="CONFIRMED" ${order.status == 'CONFIRMED' ? 'selected' : ''}>Đã xác nhận</option>
                                                <option value="SHIPPING" ${order.status == 'SHIPPING' ? 'selected' : ''}>Đang giao</option>
                                                <option value="DELIVERED" ${order.status == 'DELIVERED' ? 'selected' : ''}>Đã giao</option>
                                                <option value="CANCELLED" ${order.status == 'CANCELLED' ? 'selected' : ''}>Đã hủy</option>
                                            </select>
                                        </form>
                                    </td>
                                    <td>${order.paymentMethod}</td>
                                    <td><fmt:formatDate value="${order.orderDate}" pattern="dd/MM/yyyy"/></td>
                                    <td>
                                        <a href="${pageContext.request.contextPath}/admin/order-detail?id=${order.orderId}" 
                                           class="btn btn-sm btn-info">Chi tiết</a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

