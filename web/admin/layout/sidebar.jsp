<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.User" %>
<%
    User currentUser = (User) session.getAttribute("user");
    if (currentUser == null) {
        currentUser = (User) request.getAttribute("currentUser");
    }
    String activePage = (String) request.getAttribute("activePage");
    if (activePage == null) {
        activePage = "";
    }
%>
<!-- Sidebar -->
<aside id="sidebar">
    <div class="sidebar-brand">
        <div class="sidebar-brand-icon">📱</div>
        <div class="sidebar-brand-text">SmartPhone Admin</div>
    </div>
    
    <hr class="sidebar-divider">
    
    <nav class="sidebar-nav">
        <a href="<%= request.getContextPath() %>/admin/products" class="nav-link <%= "products".equals(activePage) ? "active" : "" %>">
            <span class="nav-icon">📦</span>
            <span class="nav-text">Quản lý Sản phẩm</span>
        </a>
        
        <a href="<%= request.getContextPath() %>/admin/orders" class="nav-link <%= "orders".equals(activePage) ? "active" : "" %>">
            <span class="nav-icon">🛒</span>
            <span class="nav-text">Quản lý Đơn hàng</span>
        </a>
        
        <a href="<%= request.getContextPath() %>/admin/users" class="nav-link <%= "users".equals(activePage) ? "active" : "" %>">
            <span class="nav-icon">👥</span>
            <span class="nav-text">Quản lý Người dùng</span>
        </a>
        
        <hr class="sidebar-divider">
        
        <a href="<%= request.getContextPath() %>/home" class="nav-link">
            <span class="nav-icon">🏠</span>
            <span class="nav-text">Về trang chủ</span>
        </a>
    </nav>
</aside>

