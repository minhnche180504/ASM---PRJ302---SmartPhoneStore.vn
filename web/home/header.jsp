<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Product" %>
<%@ page import="model.User" %>

<style>
    * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
    }
    
    .header {
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        box-shadow: 0 4px 20px rgba(0,0,0,0.1);
        position: sticky;
        top: 0;
        z-index: 1000;
    }
    
    .header-container {
        max-width: 1400px;
        margin: 0 auto;
        padding: 0 24px;
    }
    
    /* Main Header */
    .header-main {
        padding: 16px 0;
        display: flex;
        align-items: center;
        gap: 32px;
    }
    
    .logo {
        font-size: 1.75rem;
        font-weight: 800;
        color: #fff;
        text-decoration: none;
        display: flex;
        align-items: center;
        gap: 10px;
        text-shadow: 0 2px 10px rgba(0,0,0,0.2);
        transition: all 0.3s ease;
        white-space: nowrap;
    }
    
    .logo:hover {
        transform: translateY(-2px);
        text-shadow: 0 4px 15px rgba(0,0,0,0.3);
        text-decoration: none;
        color: #fff;
    }
    
    .logo-icon {
        width: 36px;
        height: 36px;
        background: rgba(255,255,255,0.2);
        border-radius: 10px;
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 1.2rem;
    }
    
    /* Search Bar - Prominent */
    .search-form {
        flex: 1;
        max-width: 600px;
        position: relative;
    }
    
    .search-wrapper {
        position: relative;
        display: flex;
        align-items: center;
        background: rgba(255,255,255,0.95);
        border-radius: 50px;
        overflow: hidden;
        box-shadow: 0 4px 15px rgba(0,0,0,0.15);
        transition: all 0.3s ease;
    }
    
    .search-wrapper:focus-within {
        background: #fff;
        box-shadow: 0 6px 25px rgba(0,0,0,0.2);
        transform: translateY(-2px);
    }
    
    .search-input {
        flex: 1;
        padding: 14px 24px;
        border: none;
        outline: none;
        font-size: 0.95rem;
        background: transparent;
        color: #333;
    }
    
    .search-input::placeholder {
        color: #999;
    }
    
    .search-btn {
        padding: 14px 28px;
        border: none;
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        color: #fff;
        font-size: 0.95rem;
        font-weight: 600;
        cursor: pointer;
        transition: all 0.3s ease;
        white-space: nowrap;
    }
    
    .search-btn:hover {
        background: linear-gradient(135deg, #764ba2 0%, #667eea 100%);
    }
    
    /* Header Actions */
    .header-actions {
        display: flex;
        align-items: center;
        gap: 20px;
    }
    
    /* Cart Button */
    .cart-btn {
        position: relative;
        display: flex;
        align-items: center;
        gap: 8px;
        padding: 10px 20px;
        background: rgba(255,255,255,0.2);
        backdrop-filter: blur(10px);
        border: 1px solid rgba(255,255,255,0.3);
        border-radius: 50px;
        color: #fff;
        text-decoration: none;
        font-weight: 600;
        font-size: 0.9rem;
        transition: all 0.3s ease;
        white-space: nowrap;
    }
    
    .cart-btn:hover {
        background: rgba(255,255,255,0.3);
        transform: translateY(-2px);
        box-shadow: 0 4px 15px rgba(0,0,0,0.2);
        color: #fff;
        text-decoration: none;
    }
    
    .cart-icon {
        width: 20px;
        height: 20px;
    }
    
    .cart-badge {
        position: absolute;
        top: -6px;
        right: -6px;
        background: #ff4757;
        color: #fff;
        font-size: 0.7rem;
        font-weight: 700;
        padding: 3px 7px;
        border-radius: 50px;
        min-width: 20px;
        text-align: center;
        box-shadow: 0 2px 8px rgba(255,71,87,0.4);
    }
    
    /* User Section */
    .user-section {
        display: flex;
        align-items: center;
        gap: 12px;
    }
    
    .auth-buttons {
        display: flex;
        gap: 10px;
    }
    
    .login-btn, .register-btn {
        padding: 10px 24px;
        border: 2px solid rgba(255,255,255,0.4);
        background: transparent;
        color: #fff;
        border-radius: 50px;
        font-size: 0.9rem;
        font-weight: 600;
        text-decoration: none;
        cursor: pointer;
        transition: all 0.3s ease;
        white-space: nowrap;
    }
    
    .login-btn:hover {
        background: rgba(255,255,255,0.2);
        border-color: rgba(255,255,255,0.6);
        transform: translateY(-2px);
        color: #fff;
        text-decoration: none;
    }
    
    .register-btn {
        background: rgba(255,255,255,0.95);
        color: #667eea;
        border-color: transparent;
    }
    
    .register-btn:hover {
        background: #fff;
        transform: translateY(-2px);
        box-shadow: 0 4px 15px rgba(0,0,0,0.2);
        color: #667eea;
        text-decoration: none;
    }
    
    /* User Dropdown */
    .user-dropdown {
        position: relative;
    }
    
    .user-button {
        display: flex;
        align-items: center;
        gap: 10px;
        padding: 8px 16px;
        background: rgba(255,255,255,0.2);
        backdrop-filter: blur(10px);
        border: 1px solid rgba(255,255,255,0.3);
        border-radius: 50px;
        color: #fff;
        cursor: pointer;
        transition: all 0.3s ease;
        font-weight: 600;
        font-size: 0.9rem;
        border: none;
        outline: none;
    }
    
    .user-button:hover {
        background: rgba(255,255,255,0.3);
        transform: translateY(-2px);
    }
    
    .user-dropdown.active .user-button {
        background: rgba(255,255,255,0.3);
    }
    
    .user-avatar {
        width: 32px;
        height: 32px;
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        border-radius: 50%;
        display: flex;
        align-items: center;
        justify-content: center;
        font-weight: 700;
        font-size: 0.9rem;
        border: 2px solid #fff;
        box-shadow: 0 2px 8px rgba(0,0,0,0.15);
    }
    
    .admin-badge {
        background: linear-gradient(135deg, #ff6b6b 0%, #ee5a6f 100%);
        color: white;
        font-size: 0.65rem;
        padding: 3px 8px;
        border-radius: 50px;
        font-weight: 700;
        letter-spacing: 0.5px;
        box-shadow: 0 2px 8px rgba(255,107,107,0.3);
    }
    
    .dropdown-content {
        display: none;
        position: absolute;
        right: 0;
        top: calc(100% + 12px);
        background: #fff;
        box-shadow: 0 8px 30px rgba(0,0,0,0.15);
        border-radius: 12px;
        min-width: 220px;
        z-index: 10000;
        overflow: hidden;
        animation: slideDown 0.3s ease;
        pointer-events: auto;
    }
    
    .dropdown-content.show {
        display: block;
    }
    
    @keyframes slideDown {
        from {
            opacity: 0;
            transform: translateY(-10px);
        }
        to {
            opacity: 1;
            transform: translateY(0);
        }
    }
    
    .user-dropdown.active .dropdown-content {
        display: block !important;
    }
    
    .dropdown-content a {
        display: flex;
        align-items: center;
        gap: 10px;
        padding: 14px 20px;
        color: #333;
        text-decoration: none;
        transition: all 0.2s;
        font-size: 0.9rem;
        font-weight: 500;
        border-bottom: 1px solid #f0f0f0;
        cursor: pointer;
        pointer-events: auto;
        position: relative;
        z-index: 10001;
    }
    
    .dropdown-content a:last-child {
        border-bottom: none;
    }
    
    .dropdown-content a:hover {
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        color: #fff;
        text-decoration: none;
    }
    
    .dropdown-content a:active {
        background: linear-gradient(135deg, #5568d3 0%, #653a8f 100%);
        color: #fff;
    }
    
    .dropdown-content a svg {
        width: 18px;
        height: 18px;
        pointer-events: none;
        flex-shrink: 0;
    }
    
    .logout-link:hover {
        background: linear-gradient(135deg, #ff6b6b 0%, #ee5a6f 100%) !important;
        color: #fff !important;
    }
    
    .logout-link:active {
        background: linear-gradient(135deg, #ee5a6f 0%, #dc3545 100%) !important;
    }
    
    /* Bottom Navigation */
    .header-nav {
        background: rgba(0,0,0,0.1);
        backdrop-filter: blur(10px);
        border-top: 1px solid rgba(255,255,255,0.1);
    }
    
    .nav-container {
        max-width: 1400px;
        margin: 0 auto;
        padding: 0 24px;
        display: flex;
        align-items: center;
        gap: 8px;
    }
    
    .category-btn {
        display: flex;
        align-items: center;
        gap: 8px;
        padding: 12px 20px;
        border: none;
        background: rgba(255,255,255,0.15);
        color: #fff;
        border-radius: 8px;
        font-size: 0.9rem;
        font-weight: 600;
        cursor: pointer;
        transition: all 0.3s ease;
        white-space: nowrap;
    }
    
    .category-btn:hover {
        background: rgba(255,255,255,0.25);
    }
    
    .category-wrapper {
        position: relative;
    }
    
    .category-dropdown {
        display: none;
        position: absolute;
        left: 0;
        top: calc(100% + 8px);
        background: #fff;
        box-shadow: 0 8px 30px rgba(0,0,0,0.15);
        border-radius: 12px;
        min-width: 250px;
        z-index: 9999;
        overflow: hidden;
        animation: slideDown 0.3s ease;
    }
    
    .category-dropdown a {
        display: flex;
        align-items: center;
        padding: 14px 20px;
        color: #333;
        text-decoration: none;
        transition: all 0.2s;
        border-bottom: 1px solid #f0f0f0;
        font-weight: 500;
    }
    
    .category-dropdown a:last-child {
        border-bottom: none;
    }
    
    .category-dropdown a:hover {
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        color: #fff;
        padding-left: 28px;
    }
    
    .nav-menu {
        display: flex;
        list-style: none;
        gap: 4px;
        flex: 1;
    }
    
    .nav-menu li {
        margin: 0;
    }
    
    .nav-menu a {
        display: flex;
        align-items: center;
        gap: 6px;
        text-decoration: none;
        color: rgba(255,255,255,0.9);
        font-weight: 600;
        font-size: 0.9rem;
        padding: 12px 18px;
        border-radius: 8px;
        transition: all 0.3s ease;
        white-space: nowrap;
    }
    
    .nav-menu a:hover {
        color: #fff;
        background: rgba(255,255,255,0.15);
    }
    
    .nav-menu a svg {
        width: 16px;
        height: 16px;
    }
    
    /* Responsive */
    @media (max-width: 1200px) {
        .header-main {
            gap: 20px;
        }
        .search-form {
            max-width: 400px;
        }
    }
    
    @media (max-width: 992px) {
        .header-main {
            flex-wrap: wrap;
            gap: 16px;
        }
        .search-form {
            order: 3;
            max-width: 100%;
            width: 100%;
        }
        .topbar-left {
            flex-wrap: wrap;
            gap: 12px;
        }
    }
    
    @media (max-width: 768px) {
        .header-container {
            padding: 0 16px;
        }
        .header-main {
            flex-direction: column;
            align-items: stretch;
        }
        .logo {
            font-size: 1.5rem;
        }
        .header-actions {
            width: 100%;
            justify-content: space-between;
        }
        .search-form {
            order: 2;
        }
        .nav-container {
            padding: 0 16px;
            overflow-x: auto;
            -webkit-overflow-scrolling: touch;
        }
        .nav-menu {
            gap: 8px;
        }
        .nav-menu a {
            padding: 12px 14px;
            font-size: 0.85rem;
        }
    }
</style>

<!-- Main Header -->
<header class="header">
    <div class="header-container">
        <div class="header-main">
            <!-- Logo -->
            <a href="<%= request.getContextPath() %>/home" class="logo">
                <div class="logo-icon">📱</div>
                SmartPhone<span style="font-weight: 400;">Store</span>
            </a>
            
            <!-- Search Form -->
            <form action="<%= request.getContextPath() %>/products" method="get" class="search-form">
                <div class="search-wrapper">
                    <input type="text" name="search" placeholder="Tìm kiếm điện thoại, phụ kiện..." class="search-input" value="<%= request.getParameter("search") != null ? request.getParameter("search") : "" %>">
                    <button type="submit" class="search-btn">
                        <svg fill="none" stroke="currentColor" viewBox="0 0 24 24" style="width: 18px; height: 18px; display: inline-block; vertical-align: middle; margin-right: 4px;">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z"/>
                        </svg>
                        Tìm kiếm
                    </button>
                </div>
            </form>
            
            <!-- Header Actions -->
            <div class="header-actions">
                <!-- Cart -->
                <%
                    @SuppressWarnings("unchecked")
                    List<Product> cart = (List<Product>) session.getAttribute("cart");
                    int cartCount = (cart != null) ? cart.size() : 0;
                %>
                <a href="<%= request.getContextPath() %>/cart" class="cart-btn">
                    <svg class="cart-icon" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 3h2l.4 2M7 13h10l4-8H5.4M7 13L5.4 5M7 13l-2.293 2.293c-.63.63-.184 1.707.707 1.707H17m0 0a2 2 0 100 4 2 2 0 000-4zm-8 2a2 2 0 11-4 0 2 2 0 014 0z"/>
                    </svg>
                    Giỏ hàng
                    <% if (cartCount > 0) { %>
                        <span class="cart-badge"><%= cartCount %></span>
                    <% } %>
                </a>
                
                <!-- User Section -->
                <div class="user-section">
                    <%
                        User currentUser = (User) session.getAttribute("user");
                        if (currentUser != null) {
                    %>
                    <div class="user-dropdown" id="user-dropdown">
                        <button type="button" class="user-button" id="user-button">
                            <div class="user-avatar"><%= currentUser.getUsername().substring(0, 1).toUpperCase() %></div>
                            <span><%= currentUser.getUsername() %></span>
                            <% if ("ADMIN".equals(currentUser.getRole())) { %>
                                <span class="admin-badge">ADMIN</span>
                            <% } %>
                        </button>
                        <div class="dropdown-content" id="user-dropdown-content">
                            <a href="<%= request.getContextPath() %>/account/profile">
                                <svg fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z"/>
                                </svg>
                                Thông tin cá nhân
                            </a>
                            <a href="<%= request.getContextPath() %>/account/orders">
                                <svg fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z"/>
                                </svg>
                                Đơn hàng của tôi
                            </a>
                            <% if ("ADMIN".equals(currentUser.getRole())) { %>
                            <a href="<%= request.getContextPath() %>/admin/users">
                                <svg fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10.325 4.317c.426-1.756 2.924-1.756 3.35 0a1.724 1.724 0 002.573 1.066c1.543-.94 3.31.826 2.37 2.37a1.724 1.724 0 001.065 2.572c1.756.426 1.756 2.924 0 3.35a1.724 1.724 0 00-1.066 2.573c.94 1.543-.826 3.31-2.37 2.37a1.724 1.724 0 00-2.572 1.065c-.426 1.756-2.924 1.756-3.35 0a1.724 1.724 0 00-2.573-1.066c-1.543.94-3.31-.826-2.37-2.37a1.724 1.724 0 00-1.065-2.572c-1.756-.426-1.756-2.924 0-3.35a1.724 1.724 0 001.066-2.573c-.94-1.543.826-3.31 2.37-2.37.996.608 2.296.07 2.572-1.065z"/>
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z"/>
                                </svg>
                                Quản lý hệ thống
                            </a>
                            <% } %>
                            <a href="<%= request.getContextPath() %>/logout" class="logout-link">
                                <svg fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17 16l4-4m0 0l-4-4m4 4H7m6 4v1a3 3 0 01-3 3H6a3 3 0 01-3-3V7a3 3 0 013-3h4a3 3 0 013 3v1"/>
                                </svg>
                                Đăng xuất
                            </a>
                        </div>
                    </div>
                    <%
                        } else {
                    %>
                    <div class="auth-buttons">
                        <a href="<%= request.getContextPath() %>/login" class="login-btn">Đăng nhập</a>
                        <a href="<%= request.getContextPath() %>/register" class="register-btn">Đăng ký</a>
                    </div>
                    <%
                        }
                    %>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Bottom Navigation -->
    <div class="header-nav">
        <div class="nav-container">
            <!-- Category Dropdown -->
            <div class="category-wrapper">
                <button type="button" id="category-btn" class="category-btn">
                    <svg fill="none" stroke="currentColor" viewBox="0 0 24 24" style="width: 18px; height: 18px;">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 6h16M4 12h16M4 18h16"/>
                    </svg>
                    Danh mục
                    <svg fill="currentColor" viewBox="0 0 20 20" style="width: 14px; height: 14px;">
                        <path fill-rule="evenodd" d="M5.293 7.293a1 1 0 011.414 0L10 10.586l3.293-3.293a1 1 0 111.414 1.414l-4 4a1 1 0 01-1.414 0l-4-4a1 1 0 010-1.414z" clip-rule="evenodd"/>
                    </svg>
                </button>
                <div id="category-dropdown" class="category-dropdown">
                    <%
                        List<String> categories = (List<String>) request.getAttribute("categories");
                        if (categories != null && !categories.isEmpty()) {
                            for (String cat : categories) {
                    %>
                        <a href="<%= request.getContextPath() %>/products?category=<%= java.net.URLEncoder.encode(cat, "UTF-8") %>"><%= cat %></a>
                    <%
                            }
                        } else {
                    %>
                        <a href="#" style="color: #999; cursor: default;">Chưa có danh mục</a>
                    <%
                        }
                    %>
                </div>
            </div>
            
            <!-- Main Navigation -->
            <nav>
                <ul class="nav-menu">
                    <li>
                        <a href="<%= request.getContextPath() %>/home">
                            <svg fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 12l2-2m0 0l7-7 7 7M5 10v10a1 1 0 001 1h3m10-11l2 2m-2-2v10a1 1 0 01-1 1h-3m-6 0a1 1 0 001-1v-4a1 1 0 011-1h2a1 1 0 011 1v4a1 1 0 001 1m-6 0h6"/>
                            </svg>
                            Trang chủ
                        </a>
                    </li>
                    <li>
                        <a href="<%= request.getContextPath() %>/products">
                            <svg fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 18h.01M8 21h8a2 2 0 002-2V5a2 2 0 00-2-2H8a2 2 0 00-2 2v14a2 2 0 002 2z"/>
                            </svg>
                            Sản phẩm
                        </a>
                    </li>
                    <%
                        if (currentUser != null && "ADMIN".equals(currentUser.getRole())) {
                    %>
                    <li>
                        <a href="<%= request.getContextPath() %>/admin/products">
                            <svg fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M20 7l-8-4-8 4m16 0l-8 4m8-4v10l-8 4m0-10L4 7m8 4v10M4 7v10l8 4"/>
                            </svg>
                            Quản lý SP
                        </a>
                    </li>
                    <li>
                        <a href="<%= request.getContextPath() %>/admin/orders">
                            <svg fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5H7a2 2 0 00-2 2v12a2 2 0 002 2h10a2 2 0 002-2V7a2 2 0 00-2-2h-2M9 5a2 2 0 002 2h2a2 2 0 002-2M9 5a2 2 0 012-2h2a2 2 0 012 2m-3 7h3m-3 4h3m-6-4h.01M9 16h.01"/>
                            </svg>
                            Quản lý ĐH
                        </a>
                    </li>
                    <li>
                        <a href="<%= request.getContextPath() %>/admin/users">
                            <svg fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4.354a4 4 0 110 5.292M15 21H3v-1a6 6 0 0112 0v1zm0 0h6v-1a6 6 0 00-9-5.197M13 7a4 4 0 11-8 0 4 4 0 018 0z"/>
                            </svg>
                            Quản lý User
                        </a>
                    </li>
                    <%
                        }
                    %>
                </ul>
            </nav>
        </div>
    </div>
</header>

<script>
document.addEventListener('DOMContentLoaded', function() {
    // Category Dropdown
    var categoryBtn = document.getElementById('category-btn');
    var categoryDropdown = document.getElementById('category-dropdown');
    
    if (categoryBtn && categoryDropdown) {
        categoryBtn.addEventListener('click', function(e) {
            e.stopPropagation();
            var isVisible = categoryDropdown.style.display === 'block' || categoryDropdown.classList.contains('show');
            if (isVisible) {
                categoryDropdown.style.display = 'none';
                categoryDropdown.classList.remove('show');
            } else {
                categoryDropdown.style.display = 'block';
                categoryDropdown.classList.add('show');
            }
        });
        
        document.addEventListener('click', function(e) {
            if (!categoryBtn.contains(e.target) && !categoryDropdown.contains(e.target)) {
                categoryDropdown.style.display = 'none';
                categoryDropdown.classList.remove('show');
            }
        });
        
        window.addEventListener('scroll', function() {
            categoryDropdown.style.display = 'none';
            categoryDropdown.classList.remove('show');
        });
    }
    
    // User Dropdown - Simple click toggle
    var userDropdown = document.getElementById('user-dropdown');
    var userButton = document.getElementById('user-button');
    var userDropdownContent = document.getElementById('user-dropdown-content');
    
    if (userButton && userDropdownContent && userDropdown) {
        // Toggle dropdown on button click
        userButton.addEventListener('click', function(e) {
            e.stopPropagation();
            e.preventDefault();
            
            var isOpen = userDropdown.classList.contains('active');
            if (isOpen) {
                // Close dropdown
                userDropdown.classList.remove('active');
                userDropdownContent.classList.remove('show');
                userDropdownContent.style.display = 'none';
            } else {
                // Open dropdown
                userDropdown.classList.add('active');
                userDropdownContent.classList.add('show');
                userDropdownContent.style.display = 'block';
            }
        });
        
        // Close dropdown when clicking outside
        document.addEventListener('click', function(e) {
            // Check if click is outside the dropdown
            if (userDropdown && !userDropdown.contains(e.target) && e.target !== userButton) {
                userDropdown.classList.remove('active');
                userDropdownContent.classList.remove('show');
                userDropdownContent.style.display = 'none';
            }
        });
        
        // Close dropdown on scroll
        window.addEventListener('scroll', function() {
            userDropdown.classList.remove('active');
            userDropdownContent.classList.remove('show');
            userDropdownContent.style.display = 'none';
        });
        
        // Ensure all links are properly styled and clickable
        var dropdownLinks = userDropdownContent.querySelectorAll('a');
        dropdownLinks.forEach(function(link) {
            // Ensure link is clickable
            link.style.pointerEvents = 'auto';
            link.style.cursor = 'pointer';
            link.style.zIndex = '10002';
            link.style.position = 'relative';
            
            // Add click handler to ensure navigation works
            link.addEventListener('click', function(e) {
                console.log('Link clicked, navigating to: ' + this.href);
                // Don't prevent default - let browser navigate
            }, false);
        });
    }
});
</script>