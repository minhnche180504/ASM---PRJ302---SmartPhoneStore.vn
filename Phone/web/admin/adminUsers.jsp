<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.User" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%
    // Kiểm tra quyền admin
    User currentUser = (User) session.getAttribute("user");
    if (currentUser == null || !"ADMIN".equals(currentUser.getRole())) {
        response.sendRedirect(request.getContextPath() + "/login");
        return;
    }
    
    // Lấy danh sách users từ request attribute
    List<User> users = (List<User>) request.getAttribute("users");
    
    // Lấy thông báo từ session
    String messageType = (String) session.getAttribute("messageType");
    String message = (String) session.getAttribute("message");
    
    // Xóa thông báo khỏi session sau khi lấy
    if (message != null) {
        session.removeAttribute("messageType");
        session.removeAttribute("message");
    }
    
    // Format date
    SimpleDateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy");
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Quản lý người dùng - Admin Dashboard</title>
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
        .alert-warning {
            color: #856404;
            background-color: #fff3cd;
            border-color: #ffeaa7;
        }
        
        .user-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        .user-table th,
        .user-table td {
            border: 1px solid #ddd;
            padding: 12px;
            text-align: left;
        }
        .user-table th {
            background: #f8f9fa;
            font-weight: bold;
            color: #2c3e50;
        }
        .user-table tr:nth-child(even) {
            background: #f8f9fa;
        }
        .user-table tr:hover {
            background: #e8f4f8;
        }
        .role-badge {
            padding: 4px 8px;
            border-radius: 4px;
            font-size: 0.85rem;
            font-weight: bold;
        }
        .role-admin {
            background: #dc3545;
            color: white;
        }
        .role-user {
            background: #28a745;
            color: white;
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
        .add-user-btn {
            background: #27ae60;
            color: white;
            padding: 12px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 1rem;
            margin-bottom: 20px;
        }
        .add-user-btn:hover {
            background: #219a52;
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
        .form-group select,
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
    </style>
</head>
<body>
    <header class="admin-header">
        <div class="admin-title">Admin Dashboard - SmartPhoneStore.vn</div>
        <nav class="admin-nav">
            <a href="<%= request.getContextPath() %>/admin/products">Sản phẩm</a>
            <a href="<%= request.getContextPath() %>/admin/orders">Đơn hàng</a>
            <a href="<%= request.getContextPath() %>/admin/users" class="active">Người dùng</a>
            <a href="<%= request.getContextPath() %>/home">Về trang chủ</a>
            <a href="<%= request.getContextPath() %>/logout" class="logout-btn">Đăng xuất</a>
        </nav>
    </header>

    <div class="admin-container">
        <div class="admin-content">
            <h1 class="section-title">Quản lý người dùng</h1>
            
            <!-- Hiển thị thông báo -->
            <% if (message != null) { %>
                <div class="alert alert-<%= messageType %>">
                    <%= message %>
                </div>
            <% } %>
            
            <button class="add-user-btn" onclick="openAddUserModal()">
                + Thêm người dùng mới
            </button>

            <table class="user-table">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Tên đăng nhập</th>
                        <th>Email</th>
                        <th>Họ tên</th>
                        <th>Số điện thoại</th>
                        <th>Vai trò</th>
                        <th>Ngày tạo</th>
                        <th>Thao tác</th>
                    </tr>
                </thead>
                <tbody>
                    <% if (users != null && !users.isEmpty()) { %>
                        <% for (User user : users) { %>
                            <tr>
                                <td><%= user.getId() %></td>
                                <td><%= user.getUsername() %></td>
                                <td><%= user.getEmail() != null ? user.getEmail() : "" %></td>
                                <td><%= user.getFullName() != null ? user.getFullName() : "" %></td>
                                <td><%= user.getPhone() != null ? user.getPhone() : "" %></td>
                                <td>
                                    <span class="role-badge <%= "ADMIN".equals(user.getRole()) ? "role-admin" : "role-user" %>">
                                        <%= user.getRole() %>
                                    </span>
                                </td>
                                <td><%= user.getCreatedAt() != null ? dateFormat.format(user.getCreatedAt()) : "" %></td>
                                <td>
                                    <button class="action-btn edit-btn" onclick="openEditUserModal(<%= user.getId() %>, '<%= user.getUsername() %>', '<%= user.getEmail() != null ? user.getEmail() : "" %>', '<%= user.getFullName() != null ? user.getFullName() : "" %>', '<%= user.getPhone() != null ? user.getPhone() : "" %>', '<%= user.getAddress() != null ? user.getAddress() : "" %>', '<%= user.getRole() %>')">
                                        Sửa
                                    </button>
                                    <% if (user.getId() != currentUser.getId()) { %>
                                        <button class="action-btn delete-btn" onclick="deleteUser(<%= user.getId() %>, '<%= user.getUsername() %>')">
                                            Xóa
                                        </button>
                                    <% } %>
                                </td>
                            </tr>
                        <% } %>
                    <% } else { %>
                        <tr>
                            <td colspan="8" style="text-align: center; padding: 20px; color: #666;">
                                Không có dữ liệu người dùng
                            </td>
                        </tr>
                    <% } %>
                </tbody>
            </table>
        </div>
    </div>

    <!-- Modal thêm user -->
    <div id="addUserModal" class="modal">
        <div class="modal-content">
            <div class="modal-header">
                <h2 class="modal-title">Thêm người dùng mới</h2>
                <span class="close" onclick="closeModal('addUserModal')">&times;</span>
            </div>
            <form action="<%= request.getContextPath() %>/admin/users/add" method="post">
                <div class="form-group">
                    <label for="username">Tên đăng nhập *</label>
                    <input type="text" id="username" name="username" required>
                </div>
                <div class="form-group">
                    <label for="password">Mật khẩu *</label>
                    <input type="password" id="password" name="password" required>
                </div>
                <div class="form-group">
                    <label for="email">Email</label>
                    <input type="email" id="email" name="email">
                </div>
                <div class="form-group">
                    <label for="fullName">Họ tên</label>
                    <input type="text" id="fullName" name="fullName">
                </div>
                <div class="form-group">
                    <label for="phone">Số điện thoại</label>
                    <input type="text" id="phone" name="phone">
                </div>
                <div class="form-group">
                    <label for="address">Địa chỉ</label>
                    <textarea id="address" name="address"></textarea>
                </div>
                <div class="form-group">
                    <label for="role">Vai trò</label>
                    <select id="role" name="role">
                        <option value="USER">USER</option>
                        <option value="ADMIN">ADMIN</option>
                    </select>
                </div>
                <div class="form-buttons">
                    <button type="button" class="btn btn-secondary" onclick="closeModal('addUserModal')">Hủy</button>
                    <button type="submit" class="btn btn-primary">Thêm</button>
                </div>
            </form>
        </div>
    </div>

    <!-- Modal sửa user -->
    <div id="editUserModal" class="modal">
        <div class="modal-content">
            <div class="modal-header">
                <h2 class="modal-title">Sửa thông tin người dùng</h2>
                <span class="close" onclick="closeModal('editUserModal')">&times;</span>
            </div>
            <form action="<%= request.getContextPath() %>/admin/users/update" method="post">
                <input type="hidden" id="editUserId" name="userId">
                <div class="form-group">
                    <label for="editUsername">Tên đăng nhập</label>
                    <input type="text" id="editUsername" name="username" readonly style="background: #f8f9fa;">
                </div>
                <div class="form-group">
                    <label for="editEmail">Email</label>
                    <input type="email" id="editEmail" name="email">
                </div>
                <div class="form-group">
                    <label for="editFullName">Họ tên</label>
                    <input type="text" id="editFullName" name="fullName">
                </div>
                <div class="form-group">
                    <label for="editPhone">Số điện thoại</label>
                    <input type="text" id="editPhone" name="phone">
                </div>
                <div class="form-group">
                    <label for="editAddress">Địa chỉ</label>
                    <textarea id="editAddress" name="address"></textarea>
                </div>
                <div class="form-group">
                    <label for="editRole">Vai trò</label>
                    <select id="editRole" name="role">
                        <option value="USER">USER</option>
                        <option value="ADMIN">ADMIN</option>
                    </select>
                </div>
                <div class="form-buttons">
                    <button type="button" class="btn btn-secondary" onclick="closeModal('editUserModal')">Hủy</button>
                    <button type="submit" class="btn btn-primary">Cập nhật</button>
                </div>
            </form>
        </div>
    </div>

    <script>
        function openAddUserModal() {
            document.getElementById('addUserModal').style.display = 'block';
        }
        
        function openEditUserModal(id, username, email, fullName, phone, address, role) {
            document.getElementById('editUserId').value = id;
            document.getElementById('editUsername').value = username;
            document.getElementById('editEmail').value = email;
            document.getElementById('editFullName').value = fullName;
            document.getElementById('editPhone').value = phone;
            document.getElementById('editAddress').value = address;
            document.getElementById('editRole').value = role;
            
            document.getElementById('editUserModal').style.display = 'block';
        }
        
        function closeModal(modalId) {
            document.getElementById(modalId).style.display = 'none';
        }
        
        function deleteUser(userId, username) {
            if (confirm('Bạn có chắc muốn xóa người dùng "' + username + '"?')) {
                window.location.href = '<%= request.getContextPath() %>/admin/users/delete?id=' + userId;
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