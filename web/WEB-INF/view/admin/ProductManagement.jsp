<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Quản lý sản phẩm - Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/css/style.css" rel="stylesheet">
</head>
<body>
    <jsp:include page="AdminHeader.jsp"/>
    
    <div class="container-fluid my-4">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h1>Quản lý sản phẩm</h1>
            <a href="${pageContext.request.contextPath}/admin/products?action=add" class="btn btn-primary">
                + Thêm sản phẩm
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
                                <th>Hình ảnh</th>
                                <th>Tên sản phẩm</th>
                                <th>Thương hiệu</th>
                                <th>Giá</th>
                                <th>Tồn kho</th>
                                <th>Danh mục</th>
                                <th>Thao tác</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="product" items="${products}">
                                <tr>
                                    <td>${product.pId}</td>
                                    <td>
                                        <img src="${product.imageUrl}" alt="${product.pName}" 
                                             style="width: 50px; height: 50px; object-fit: cover;"
                                             onerror="this.src='${pageContext.request.contextPath}/assets/img/placeholder.jpg'">
                                    </td>
                                    <td>${product.pName}</td>
                                    <td>${product.brand}</td>
                                    <td><fmt:formatNumber value="${product.price}" type="currency" currencyCode="VND"/></td>
                                    <td>${product.stock}</td>
                                    <td>${product.catName}</td>
                                    <td>
                                        <a href="${pageContext.request.contextPath}/admin/products?action=edit&id=${product.pId}" 
                                           class="btn btn-sm btn-warning">Sửa</a>
                                        <form method="post" action="${pageContext.request.contextPath}/admin/products" class="d-inline">
                                            <input type="hidden" name="action" value="delete">
                                            <input type="hidden" name="id" value="${product.pId}">
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

