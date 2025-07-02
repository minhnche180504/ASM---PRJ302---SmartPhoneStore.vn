<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.User" %>
<%@ page import="model.Product" %>
<%@ page import="java.util.List" %>
<%
    // Kiểm tra quyền admin
    User currentUser = (User) session.getAttribute("user");
    if (currentUser == null || !"ADMIN".equals(currentUser.getRole())) {
        response.sendRedirect(request.getContextPath() + "/login");
        return;
    }
    
    // Lấy danh sách sản phẩm từ request attribute
    List<Product> products = (List<Product>) request.getAttribute("products");
    
    // Lấy thông báo từ request/session
    String messageType = (String) request.getAttribute("messageType");
    String message = (String) request.getAttribute("message");
    
    // Lấy sản phẩm đang edit (nếu có)
    Product editProduct = (Product) request.getAttribute("editProduct");
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Quản lý sản phẩm - Admin Dashboard</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: #f4f6f9;
            margin: 0;
            padding: 0;
        }
        .admin-header {
            background: #2c3e50;
            color: white;
            padding: 15px 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .admin-title {
            font-size: 1.5rem;
            font-weight: bold;
        }
        .admin-nav {
            display: flex;
            gap: 20px;
        }
        .admin-nav a {
            color: white;
            text-decoration: none;
            padding: 8px 16px;
            border-radius: 4px;
            transition: background 0.2s;
        }
        .admin-nav a:hover, .admin-nav a.active {
            background: #34495e;
        }
        .admin-container {
            max-width: 1200px;
            margin: 20px auto;
            padding: 0 20px;
        }
        .admin-content {
            background: white;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            padding: 30px;
        }
        .section-title {
            font-size: 2rem;
            color: #2c3e50;
            margin-bottom: 20px;
            border-bottom: 3px solid #3498db;
            padding-bottom: 10px;
        }
        
        /* Alert styles */
        .alert {
            padding: 12px 20px;
            margin-bottom: 20px;
            border-radius: 4px;
            border: 1px solid transparent;
        }
        .alert-success {
            color: #155724;
            background-color: #d4edda;
            border-color: #c3e6cb;
        }
        .alert-error {
            color: #721c24;
            background-color: #f8d7da;
            border-color: #f5c6cb;
        }
        
        .add-product-btn {
            background: #27ae60;
            color: white;
            padding: 12px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 1rem;
            margin-bottom: 20px;
        }
        .add-product-btn:hover {
            background: #219a52;
        }
        .product-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        .product-table th,
        .product-table td {
            border: 1px solid #ddd;
            padding: 12px;
            text-align: left;
        }
        .product-table th {
            background: #f8f9fa;
            font-weight: bold;
            color: #2c3e50;
        }
        .product-table tr:nth-child(even) {
            background: #f8f9fa;
        }
        .product-table tr:hover {
            background: #e8f4f8;
        }
        .action-btn {
            padding: 6px 12px;
            margin: 2px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 0.9rem;
        }
        .edit-btn {
            background: #3498db;
            color: white;
        }
        .delete-btn {
            background: #e74c3c;
            color: white;
        }
        .edit-btn:hover {
            background: #2980b9;
        }
        .delete-btn:hover {
            background: #c0392b;
        }
        .logout-btn {
            background: #e74c3c;
            color: white;
            padding: 8px 16px;
            text-decoration: none;
            border-radius: 4px;
        }
        .logout-btn:hover {
            background: #c0392b;
        }
        
        /* Modal styles */
        .modal {
            display: none;
            position: fixed;
            z-index: 1000;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0,0,0,0.5);
        }
        .modal-content {
            background-color: white;
            margin: 5% auto;
            padding: 20px;
            border-radius: 8px;
            width: 90%;
            max-width: 500px;
            position: relative;
        }
        .modal-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
            padding-bottom: 10px;
            border-bottom: 1px solid #ddd;
        }
        .modal-title {
            font-size: 1.5rem;
            color: #2c3e50;
            margin: 0;
        }
        .close {
            color: #aaa;
            font-size: 28px;
            font-weight: bold;
            cursor: pointer;
        }
        .close:hover {
            color: #000;
        }
        .form-group {
            margin-bottom: 15px;
        }
        .form-group label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
            color: #2c3e50;
        }
        .form-group input,
        .form-group textarea {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 14px;
            box-sizing: border-box;
        }
        .form-group textarea {
            height: 80px;
            resize: vertical;
        }
        .form-buttons {
            display: flex;
            gap: 10px;
            justify-content: flex-end;
            margin-top: 20px;
        }
        .btn {
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 14px;
        }
        .btn-primary {
            background: #3498db;
            color: white;
        }
        .btn-primary:hover {
            background: #2980b9;
        }
        .btn-secondary {
            background: #6c757d;
            color: white;
        }
        .btn-secondary:hover {
            background: #545b62;
        }
        .product-image {
            width: 60px;
            height: 60px;
            object-fit: cover;
            border-radius: 4px;
        }
    </style>
</head>
<body>
    <header class="admin-header">
        <div class="admin-title">Admin Dashboard - SmartPhoneStore.vn</div>
        <nav class="admin-nav">
            <a href="<%= request.getContextPath() %>/admin/products" class="active">Sản phẩm</a>
            <a href="<%= request.getContextPath() %>/admin/orders">Đơn hàng</a>
            <a href="<%= request.getContextPath() %>/admin/users">Người dùng</a>
            <a href="<%= request.getContextPath() %>/home">Về trang chủ</a>
            <a href="<%= request.getContextPath() %>/logout" class="logout-btn">Đăng xuất</a>
        </nav>
    </header>

    <div class="admin-container">
        <div class="admin-content">
            <h1 class="section-title">Quản lý sản phẩm</h1>
            
            <!-- Hiển thị thông báo -->
            <% if (message != null) { %>
                <div class="alert alert-<%= messageType %>">
                    <%= message %>
                </div>
            <% } %>
            
            <button class="add-product-btn" onclick="openAddProductModal()">
                + Thêm sản phẩm mới
            </button>

            <table class="product-table">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Hình ảnh</th>
                        <th>Tên sản phẩm</th>
                        <th>Giá</th>
                        <th>Mô tả</th>
                        <th>Thao tác</th>
                    </tr>
                </thead>
                <tbody>
                    <% if (products != null && !products.isEmpty()) { %>
                        <% for (Product product : products) { %>
                            <tr>
                                <td><%= product.getId() %></td>
                                <td>
                                    <% if (product.getImage() != null && !product.getImage().isEmpty()) { %>
                                        <img src="<%= product.getImage() %>" alt="<%= product.getName() %>" class="product-image">
                                    <% } else { %>
                                        <div class="product-image" style="background: #f0f0f0; display: flex; align-items: center; justify-content: center; color: #999;">No Image</div>
                                    <% } %>
                                </td>
                                <td><%= product.getName() %></td>
                                <td><%= String.format("%,.0f", product.getPrice()) %> VND</td>
                                <td style="max-width: 200px; overflow: hidden; text-overflow: ellipsis; white-space: nowrap;">
                                    <%= product.getDescription() != null ? product.getDescription() : "" %>
                                </td>
                                <td>
                                    <button class="action-btn edit-btn" onclick="openEditProductModal(<%= product.getId() %>, '<%= product.getName().replaceAll("'", "\\\\'") %>', <%= product.getPrice() %>, '<%= product.getDescription() != null ? product.getDescription().replaceAll("'", "\\\\'") : "" %>', '<%= product.getImage() != null ? product.getImage().replaceAll("'", "\\\\'") : "" %>')">
                                        Sửa
                                    </button>
                                    <button class="action-btn delete-btn" onclick="deleteProduct(<%= product.getId() %>, '<%= product.getName().replaceAll("'", "\\\\'") %>')">
                                        Xóa
                                    </button>
                                </td>
                            </tr>
                        <% } %>
                    <% } else { %>
                        <tr>
                            <td colspan="6" style="text-align: center; padding: 20px; color: #666;">
                                Không có sản phẩm nào
                            </td>
                        </tr>
                    <% } %>
                </tbody>
            </table>
        </div>
    </div>

    <!-- Modal thêm sản phẩm -->
    <div id="addProductModal" class="modal">
        <div class="modal-content">
            <div class="modal-header">
                <h2 class="modal-title">Thêm sản phẩm mới</h2>
                <span class="close" onclick="closeModal('addProductModal')">&times;</span>
            </div>
            <form action="<%= request.getContextPath() %>/admin/products/add" method="post">
                <div class="form-group">
                    <label for="name">Tên sản phẩm *</label>
                    <input type="text" id="name" name="name" required>
                </div>
                <div class="form-group">
                    <label for="price">Giá sản phẩm (VND) *</label>
                    <input type="number" id="price" name="price" step="1000" min="0" required>
                </div>
                <div class="form-group">
                    <label for="description">Mô tả</label>
                    <textarea id="description" name="description"></textarea>
                </div>
                <div class="form-group">
                    <label for="image">URL Hình ảnh</label>
                    <input type="url" id="image" name="image" placeholder="https://...">
                </div>
                <div class="form-buttons">
                    <button type="button" class="btn btn-secondary" onclick="closeModal('addProductModal')">Hủy</button>
                    <button type="submit" class="btn btn-primary">Thêm</button>
                </div>
            </form>
        </div>
    </div>

    <!-- Modal sửa sản phẩm -->
    <div id="editProductModal" class="modal">
        <div class="modal-content">
            <div class="modal-header">
                <h2 class="modal-title">Sửa thông tin sản phẩm</h2>
                <span class="close" onclick="closeModal('editProductModal')">&times;</span>
            </div>
            <form action="<%= request.getContextPath() %>/admin/products/update" method="post">
                <input type="hidden" id="editProductId" name="productId">
                <div class="form-group">
                    <label for="editName">Tên sản phẩm *</label>
                    <input type="text" id="editName" name="name" required>
                </div>
                <div class="form-group">
                    <label for="editPrice">Giá sản phẩm (VND) *</label>
                    <input type="number" id="editPrice" name="price" step="1000" min="0" required>
                </div>
                <div class="form-group">
                    <label for="editDescription">Mô tả</label>
                    <textarea id="editDescription" name="description"></textarea>
                </div>
                <div class="form-group">
                    <label for="editImage">URL Hình ảnh</label>
                    <input type="url" id="editImage" name="image" placeholder="https://...">
                </div>
                <div class="form-buttons">
                    <button type="button" class="btn btn-secondary" onclick="closeModal('editProductModal')">Hủy</button>
                    <button type="submit" class="btn btn-primary">Cập nhật</button>
                </div>
            </form>
        </div>
    </div>

    <script>
        // Tự động mở modal edit nếu có editProduct
        <% if (editProduct != null) { %>
            window.onload = function() {
                openEditProductModal(
                    <%= editProduct.getId() %>, 
                    '<%= editProduct.getName().replaceAll("'", "\\\\'") %>', 
                    <%= editProduct.getPrice() %>, 
                    '<%= editProduct.getDescription() != null ? editProduct.getDescription().replaceAll("'", "\\\\'") : "" %>', 
                    '<%= editProduct.getImage() != null ? editProduct.getImage().replaceAll("'", "\\\\'") : "" %>'
                );
            };
        <% } %>
        
        function openAddProductModal() {
            document.getElementById('addProductModal').style.display = 'block';
        }
        
        function openEditProductModal(id, name, price, description, image) {
            document.getElementById('editProductId').value = id;
            document.getElementById('editName').value = name;
            document.getElementById('editPrice').value = price;
            document.getElementById('editDescription').value = description;
            document.getElementById('editImage').value = image;
            
            document.getElementById('editProductModal').style.display = 'block';
        }
        
        function closeModal(modalId) {
            document.getElementById(modalId).style.display = 'none';
        }
        
        function deleteProduct(productId, productName) {
            if (confirm('Bạn có chắc muốn xóa sản phẩm "' + productName + '"?')) {
                window.location.href = '<%= request.getContextPath() %>/admin/products/delete?id=' + productId;
            }
        }
        
        // Đóng modal khi click bên ngoài
        window.onclick = function(event) {
            var modals = document.getElementsByClassName('modal');
            for (var i = 0; i < modals.length; i++) {
                if (event.target == modals[i]) {
                    modals[i].style.display = 'none';
                }
            }
        }
    </script>
</body>
</html>