<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>${promotion != null ? 'Sửa' : 'Thêm'} khuyến mãi - Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/css/style.css" rel="stylesheet">
</head>
<body>
    <jsp:include page="AdminHeader.jsp"/>
    
    <div class="container my-4">
        <h1>${promotion != null ? 'Sửa' : 'Thêm'} khuyến mãi</h1>
        
        <c:if test="${not empty error}">
            <div class="alert alert-danger">${error}</div>
        </c:if>
        
        <div class="card">
            <div class="card-body">
                <form method="post" action="${pageContext.request.contextPath}/admin/promotions">
                    <input type="hidden" name="action" value="${promotion != null ? 'update' : 'create'}">
                    <c:if test="${promotion != null}">
                        <input type="hidden" name="promoId" value="${promotion.promoId}">
                    </c:if>
                    
                    <div class="mb-3">
                        <label class="form-label">Mã khuyến mãi *</label>
                        <input type="text" name="promoCode" class="form-control" value="${promotion.promoCode}" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Phần trăm giảm giá *</label>
                        <input type="number" name="discountPercent" class="form-control" 
                               value="${promotion.discountPercent}" step="0.01" min="0" max="100" required>
                    </div>
                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label class="form-label">Ngày bắt đầu *</label>
                            <input type="date" name="startDate" class="form-control" 
                                   value="${promotion.startDate}" required>
                        </div>
                        <div class="col-md-6 mb-3">
                            <label class="form-label">Ngày kết thúc *</label>
                            <input type="date" name="endDate" class="form-control" 
                                   value="${promotion.endDate}" required>
                        </div>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Mô tả</label>
                        <textarea name="description" class="form-control" rows="3">${promotion.description}</textarea>
                    </div>
                    <div class="mb-3 form-check">
                        <input type="checkbox" name="isActive" class="form-check-input" 
                               ${promotion != null && promotion.active ? 'checked' : ''}>
                        <label class="form-check-label">Kích hoạt</label>
                    </div>
                    <button type="submit" class="btn btn-primary">Lưu</button>
                    <a href="${pageContext.request.contextPath}/admin/promotions" class="btn btn-secondary">Hủy</a>
                </form>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

