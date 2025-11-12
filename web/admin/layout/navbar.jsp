<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.User" %>
<%
    User currentUser = (User) session.getAttribute("user");
    if (currentUser == null) {
        currentUser = (User) request.getAttribute("currentUser");
    }
%>
<!-- Top Navbar -->
<nav class="top-navbar">
    <div class="navbar-container">
        <div class="navbar-left">
            <button id="sidebarToggle" class="sidebar-toggle" title="Toggle Sidebar">
                ☰
            </button>
            
        </div>
        
        <div class="navbar-right">
            <div class="user-dropdown">
                <div class="user-info" onclick="toggleUserDropdown()">
                    <div class="user-avatar">
                        <%= currentUser != null ? currentUser.getUsername().substring(0, 1).toUpperCase() : "A" %>
                    </div>
                    <div class="user-details">
                        <div class="user-name"><%= currentUser != null ? currentUser.getUsername() : "Admin" %></div>
                        <div class="user-role">Administrator</div>
                    </div>
                    <span class="dropdown-arrow">▼</span>
                </div>
                <div class="dropdown-menu" id="userDropdownMenu">
                    <a class="dropdown-item" href="<%= request.getContextPath() %>/account/profile">
                        <span class="item-icon">👤</span>
                        <span>Hồ sơ cá nhân</span>
                    </a>
                    <a class="dropdown-item" href="<%= request.getContextPath() %>/account/orders">
                        <span class="item-icon">📋</span>
                        <span>Đơn hàng của tôi</span>
                    </a>
                    <div class="dropdown-divider"></div>
                    <a class="dropdown-item logout" href="<%= request.getContextPath() %>/logout">
                        <span class="item-icon">🚪</span>
                        <span>Đăng xuất</span>
                    </a>
                </div>
            </div>
        </div>
    </div>
</nav>

