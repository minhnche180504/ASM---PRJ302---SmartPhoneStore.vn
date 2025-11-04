<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Quản lý khuyến mãi - Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/css/style.css" rel="stylesheet">
</head>
<body>
    <jsp:include page="AdminHeader.jsp"/>
    
    <div class="container-fluid my-4">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h1>Quản lý khuyến mãi</h1>
            <a href="${pageContext.request.contextPath}/admin/promotions?action=add" class="btn btn-primary">
                + Thêm khuyến mãi
            </a>
        </div>
        
        <c:if test="${param.success != null}">
            <div class="alert alert-success">Thao tác thành công!</div>
        </c:if>
        
        <div class="card">
            <div class="card-body">
                <div class="table-responsive">
                    <table class="table table-striped">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Mã khuyến mãi</th>
                                <th>Giảm giá (%)</th>
                                <th>Ngày bắt đầu</th>
                                <th>Ngày kết thúc</th>
                                <th>Mô tả</th>
                                <th>Trạng thái</th>
                                <th>Thao tác</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="promo" items="${promotions}">
                                <tr>
                                    <td>${promo.promoId}</td>
                                    <td><strong>${promo.promoCode}</strong></td>
                                    <td>${promo.discountPercent}%</td>
                                    <td>${promo.startDate}</td>
                                    <td>${promo.endDate}</td>
                                    <td>${promo.description}</td>
                                    <td>
                                        <span class="badge ${promo.active ? 'bg-success' : 'bg-secondary'}">
                                            ${promo.active ? 'Hoạt động' : 'Tắt'}
                                        </span>
                                    </td>
                                    <td>
                                        <a href="${pageContext.request.contextPath}/admin/promotions?action=edit&id=${promo.promoId}" 
                                           class="btn btn-sm btn-warning">Sửa</a>
                                        <form method="post" action="${pageContext.request.contextPath}/admin/promotions" class="d-inline">
                                            <input type="hidden" name="action" value="delete">
                                            <input type="hidden" name="id" value="${promo.promoId}">
                                            <button type="submit" class="btn btn-sm btn-danger" 
                                                    onclick="return confirm('Bạn có chắc muốn xóa?')">Xóa</button>
                                        </form>
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

