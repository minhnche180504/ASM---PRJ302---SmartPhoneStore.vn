<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>${product != null ? 'Sửa' : 'Thêm'} sản phẩm - Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/css/style.css" rel="stylesheet">
</head>
<body>
    <jsp:include page="AdminHeader.jsp"/>
    
    <div class="container my-4">
        <h1>${product != null ? 'Sửa' : 'Thêm'} sản phẩm</h1>
        
        <c:if test="${not empty error}">
            <div class="alert alert-danger">${error}</div>
        </c:if>
        
        <div class="card">
            <div class="card-body">
                <form method="post" action="${pageContext.request.contextPath}/admin/products">
                    <input type="hidden" name="action" value="${product != null ? 'update' : 'create'}">
                    <c:if test="${product != null}">
                        <input type="hidden" name="productId" value="${product.pId}">
                    </c:if>
                    
                    <div class="mb-3">
                        <label class="form-label">Tên sản phẩm *</label>
                        <input type="text" name="pName" class="form-control" value="${product.pName}" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Thương hiệu *</label>
                        <input type="text" name="brand" class="form-control" value="${product.brand}" required>
                    </div>
                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label class="form-label">Giá *</label>
                            <input type="number" name="price" class="form-control" value="${product.price}" step="0.01" required>
                        </div>
                        <div class="col-md-6 mb-3">
                            <label class="form-label">Tồn kho *</label>
                            <input type="number" name="stock" class="form-control" value="${product.stock}" required>
                        </div>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Danh mục *</label>
                        <select name="catId" class="form-select" required>
                            <option value="">Chọn danh mục</option>
                            <c:forEach var="cat" items="${categories}">
                                <option value="${cat.catId}" ${product.catId == cat.catId ? 'selected' : ''}>
                                    ${cat.catName}
                                </option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">URL hình ảnh</label>
                        <input type="text" name="imageUrl" class="form-control" value="${product.imageUrl}">
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Mô tả</label>
                        <textarea name="description" class="form-control" rows="5">${product.description}</textarea>
                    </div>
                    <button type="submit" class="btn btn-primary">Lưu</button>
                    <a href="${pageContext.request.contextPath}/admin/products" class="btn btn-secondary">Hủy</a>
                </form>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

