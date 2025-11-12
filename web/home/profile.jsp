<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.User" %>
<%
    User user = (User) request.getAttribute("user");
    if (user == null) {
        user = (User) session.getAttribute("user");
    }
    String error = (String) request.getAttribute("error");
    String success = (String) request.getAttribute("success");
%>
<jsp:include page="/home/header.jsp" />
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thông tin cá nhân - SmartPhoneStore.vn</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: #f4f6fb;
            margin: 0;
            padding: 0;
        }
        .profile-container {
            max-width: 1000px;
            margin: 30px auto;
            padding: 0 20px;
        }
        .profile-header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 30px;
            border-radius: 12px;
            margin-bottom: 30px;
            box-shadow: 0 4px 20px rgba(0,0,0,0.1);
        }
        .profile-header h1 {
            margin: 0;
            font-size: 2rem;
            font-weight: 700;
        }
        .profile-header p {
            margin: 10px 0 0 0;
            opacity: 0.9;
        }
        .profile-content {
            background: white;
            border-radius: 12px;
            padding: 30px;
            box-shadow: 0 2px 12px rgba(0,0,0,0.08);
        }
        .profile-tabs {
            display: flex;
            gap: 10px;
            margin-bottom: 30px;
            border-bottom: 2px solid #e9ecef;
        }
        .profile-tab {
            padding: 12px 24px;
            background: none;
            border: none;
            cursor: pointer;
            font-size: 1rem;
            font-weight: 600;
            color: #6c757d;
            border-bottom: 3px solid transparent;
            transition: all 0.3s ease;
        }
        .profile-tab:hover {
            color: #667eea;
        }
        .profile-tab.active {
            color: #667eea;
            border-bottom-color: #667eea;
        }
        .tab-content {
            display: none;
        }
        .tab-content.active {
            display: block;
        }
        .form-group {
            margin-bottom: 24px;
        }
        .form-group label {
            display: block;
            margin-bottom: 8px;
            font-weight: 600;
            color: #333;
            font-size: 0.95rem;
        }
        .form-group input,
        .form-group textarea {
            width: 100%;
            padding: 12px 16px;
            border: 1px solid #d1d5db;
            border-radius: 8px;
            font-size: 1rem;
            transition: border 0.2s;
            box-sizing: border-box;
        }
        .form-group input:focus,
        .form-group textarea:focus {
            outline: none;
            border-color: #667eea;
            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
        }
        .form-group textarea {
            resize: vertical;
            min-height: 100px;
        }
        .btn {
            padding: 12px 24px;
            border: none;
            border-radius: 8px;
            font-size: 1rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
        }
        .btn-primary {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
        }
        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(102, 126, 234, 0.4);
        }
        .alert {
            padding: 14px 18px;
            border-radius: 8px;
            margin-bottom: 20px;
            font-size: 0.95rem;
        }
        .alert-success {
            background: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }
        .alert-error {
            background: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }
        .info-box {
            background: #f8f9fa;
            padding: 20px;
            border-radius: 8px;
            margin-bottom: 24px;
        }
        .info-box p {
            margin: 8px 0;
            color: #666;
        }
        .info-box strong {
            color: #333;
            display: inline-block;
            min-width: 120px;
        }
        @media (max-width: 768px) {
            .profile-container {
                margin: 20px auto;
                padding: 0 16px;
            }
            .profile-header {
                padding: 20px;
            }
            .profile-content {
                padding: 20px;
            }
            .profile-tabs {
                flex-wrap: wrap;
            }
        }
    </style>
</head>
<body>
    <div class="profile-container">
        <div class="profile-header">
            <h1>👤 Thông tin cá nhân</h1>
            <p>Quản lý thông tin tài khoản của bạn</p>
        </div>
        
        <div class="profile-content">
            <% if (error != null) { %>
                <div class="alert alert-error">
                    ⚠️ <%= error %>
                </div>
            <% } %>
            
            <% if (success != null) { %>
                <div class="alert alert-success">
                    ✅ <%= success %>
                </div>
            <% } %>
            
            <div class="profile-tabs">
                <button class="profile-tab active" onclick="showTab('info')">Thông tin cá nhân</button>
                <button class="profile-tab" onclick="showTab('password')">Đổi mật khẩu</button>
            </div>
            
            <!-- Tab: Thông tin cá nhân -->
            <div id="info-tab" class="tab-content active">
                <form action="<%= request.getContextPath() %>/profile" method="post">
                    <input type="hidden" name="action" value="updateProfile">
                    
                    <div class="form-group">
                        <label for="username">Tên đăng nhập:</label>
                        <input type="text" id="username" name="username" value="<%= user != null ? user.getUsername() : "" %>" disabled style="background: #f8f9fa; cursor: not-allowed;">
                        <small style="color: #6c757d; font-size: 0.85rem;">Tên đăng nhập không thể thay đổi</small>
                    </div>
                    
                    <div class="form-group">
                        <label for="email">Email:</label>
                        <input type="email" id="email" name="email" value="<%= user != null && user.getEmail() != null ? user.getEmail() : "" %>" required>
                    </div>
                    
                    <div class="form-group">
                        <label for="fullName">Họ và tên:</label>
                        <input type="text" id="fullName" name="fullName" value="<%= user != null && user.getFullName() != null ? user.getFullName() : "" %>" required>
                    </div>
                    
                    <div class="form-group">
                        <label for="phone">Số điện thoại:</label>
                        <input type="tel" id="phone" name="phone" value="<%= user != null && user.getPhone() != null ? user.getPhone() : "" %>">
                    </div>
                    
                    <div class="form-group">
                        <label for="address">Địa chỉ:</label>
                        <textarea id="address" name="address"><%= user != null && user.getAddress() != null ? user.getAddress() : "" %></textarea>
                    </div>
                    
                    <button type="submit" class="btn btn-primary">💾 Lưu thông tin</button>
                </form>
            </div>
            
            <!-- Tab: Đổi mật khẩu -->
            <div id="password-tab" class="tab-content">
                <form action="<%= request.getContextPath() %>/profile" method="post">
                    <input type="hidden" name="action" value="changePassword">
                    
                    <div class="form-group">
                        <label for="currentPassword">Mật khẩu hiện tại:</label>
                        <input type="password" id="currentPassword" name="currentPassword" required>
                    </div>
                    
                    <div class="form-group">
                        <label for="newPassword">Mật khẩu mới:</label>
                        <input type="password" id="newPassword" name="newPassword" required minlength="6">
                        <small style="color: #6c757d; font-size: 0.85rem;">Mật khẩu phải có ít nhất 6 ký tự</small>
                    </div>
                    
                    <div class="form-group">
                        <label for="confirmPassword">Xác nhận mật khẩu mới:</label>
                        <input type="password" id="confirmPassword" name="confirmPassword" required minlength="6">
                    </div>
                    
                    <button type="submit" class="btn btn-primary">🔒 Đổi mật khẩu</button>
                </form>
            </div>
        </div>
    </div>
    
    <script>
        function showTab(tabName) {
            // Ẩn tất cả các tab content
            document.querySelectorAll('.tab-content').forEach(tab => {
                tab.classList.remove('active');
            });
            
            // Ẩn tất cả các tab button
            document.querySelectorAll('.profile-tab').forEach(btn => {
                btn.classList.remove('active');
            });
            
            // Hiển thị tab được chọn
            document.getElementById(tabName + '-tab').classList.add('active');
            event.target.classList.add('active');
        }
    </script>
    <jsp:include page="/home/footer.jsp" />
</body>
</html>

