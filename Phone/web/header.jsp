<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Product" %>
<%@ page import="model.User" %>

<style>
    .header {
        background: #fff;
        box-shadow: 0 2px 8px rgba(0,0,0,0.1);
        position: sticky;
        top: 0;
        z-index: 1000;
        margin-bottom: 20px;
    }
    .header-container {
        max-width: 1200px;
        margin: 0 auto;
        display: flex;
        justify-content: space-between;
        align-items: center;
        padding: 12px 20px;
    }
    .logo {
        font-size: 1.5rem;
        font-weight: bold;
        color: #007bff;
        text-decoration: none;
    }
    .nav-menu {
        display: flex;
        list-style: none;
        margin: 0;
        padding: 0;
        gap: 24px;
    }
    .nav-menu a {
        text-decoration: none;
        color: #333;
        font-weight: 500;
        padding: 8px 12px;
        border-radius: 4px;
        transition: background 0.2s;
    }
    .nav-menu a:hover {
        background: #f8f9fa;
    }
    .header-actions {
        display: flex;
        align-items: center;
        gap: 16px;
    }
    .cart-info {
        color: #666;
        font-size: 0.95rem;
    }
    .login-btn, .cart-btn, .logout-btn {
        background: #007bff;
        color: #fff;
        text-decoration: none;
        padding: 8px 16px;
        border-radius: 4px;
        font-weight: 500;
        transition: background 0.2s;
        border: none;
        cursor: pointer;
    }
    .login-btn:hover, .cart-btn:hover, .logout-btn:hover {
        background: #0056b3;
        color: #fff;
    }
    .cart-btn {
        background: #28a745;
    }
    .cart-btn:hover {
        background: #1e7e34;
    }
    .logout-btn {
        background: #dc3545;
    }
    .logout-btn:hover {
        background: #c82333;
    }
    .user-info {
        color: #333;
        font-weight: 500;
    }
    .user-dropdown {
        position: relative;
        display: inline-block;
    }
    .dropdown-content {
        display: none;
        position: absolute;
        background-color: #f9f9f9;
        min-width: 180px;
        box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
        z-index: 1;
        right: 0;
        border-radius: 4px;
    }
    .dropdown-content a {
        color: black;
        padding: 12px 16px;
        text-decoration: none;
        display: block;
    }
    .dropdown-content a:hover {
        background-color: #f1f1f1;
    }
    .user-dropdown:hover .dropdown-content {
        display: block;
    }
    .admin-badge {
        background: #dc3545;
        color: white;
        font-size: 0.7rem;
        padding: 2px 6px;
        border-radius: 3px;
        margin-left: 5px;
    }
    @media (max-width: 768px) {
        .header-container {
            flex-direction: column;
            gap: 12px;
        }
        .nav-menu {
            gap: 16px;
        }
        .header-actions {
            flex-wrap: wrap;
            justify-content: center;
        }
    }
</style>

<header class="header">
    <div class="header-container">
        <a href="<%= request.getContextPath() %>/home" class="logo">SmartPhoneStore.vn</a>
        
        <nav>
            <ul class="nav-menu">
                <li><a href="<%= request.getContextPath() %>/home">Trang chủ</a></li>
                <li><a href="<%= request.getContextPath() %>/products">Sản phẩm</a></li>
                <%
                    // Kiểm tra user role để hiển thị menu admin
                    User currentUser = (User) session.getAttribute("user");
                    if (currentUser != null && "ADMIN".equals(currentUser.getRole())) {
                %>
                <li><a href="<%= request.getContextPath() %>/admin/products">Quản lý SP</a></li>
                <li><a href="<%= request.getContextPath() %>/admin/orders">Quản lý ĐH</a></li>
                <li><a href="<%= request.getContextPath() %>/admin/users">Quản lý User</a></li>
                <%
                    }
                %>
            </ul>
        </nav>
        
        <div class="header-actions">
            <%
                // Kiểm tra số lượng sản phẩm trong giỏ hàng
                @SuppressWarnings("unchecked")
                List<Product> cart = (List<Product>) session.getAttribute("cart");
                int cartCount = (cart != null) ? cart.size() : 0;
            %>
            <span class="cart-info">Giỏ hàng: <%= cartCount %> sản phẩm</span>
            <a href="<%= request.getContextPath() %>/cart" class="cart-btn">Xem giỏ hàng</a>
            
            <%
                // Kiểm tra trạng thái đăng nhập
                if (currentUser != null) {
                    // Đã đăng nhập
            %>
            <div class="user-dropdown">
                <span class="user-info">
                    Xin chào, <%= currentUser.getUsername() %>!
                    <% if ("ADMIN".equals(currentUser.getRole())) { %>
                        <span class="admin-badge">ADMIN</span>
                    <% } %>
                </span>
                <div class="dropdown-content">
                    <a href="<%= request.getContextPath() %>/account/profile">Thông tin cá nhân</a>
                    <a href="<%= request.getContextPath() %>/account/orders">Đơn hàng của tôi</a>
                    <% if ("ADMIN".equals(currentUser.getRole())) { %>
                        <a href="<%= request.getContextPath() %>/admin/users">Quản lý hệ thống</a>
                    <% } %>
                    <a href="<%= request.getContextPath() %>/logout">Đăng xuất</a>
                </div>
            </div>
            <%
                } else {
                    // Chưa đăng nhập
            %>
            <a href="<%= request.getContextPath() %>/login" class="login-btn">Đăng nhập</a>
            <a href="<%= request.getContextPath() %>/register" class="login-btn">Đăng ký</a>
            <%
                }
            %>
        </div>
    </div>
</header>