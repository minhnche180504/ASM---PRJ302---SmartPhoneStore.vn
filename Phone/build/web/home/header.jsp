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
        white-space: nowrap; /* Ngăn không cho xuống dòng */
    }
    .header-container {
        max-width: 1400px; /* Tăng max-width */
        margin: 0 auto;
        display: flex;
        flex-direction: column;
        justify-content: flex-start;
        align-items: stretch;
        padding: 12px 20px;
        min-height: 60px;
    }
    .header-row-top {
        display: flex;
        justify-content: space-between;
        align-items: center;
        width: 100%;
    }
    .header-row-bottom {
        display: flex;
        align-items: flex-start;
        width: 100%;
        gap: 18px;
        position: relative;
        margin-top: 8px;
        z-index: 10;
    }
    #category-dropdown {
        z-index: 9999 !important;
        pointer-events: auto;
    }
    .logo {
        font-size: 1.5rem;
        font-weight: bold;
        color: #007bff;
        text-decoration: none;
        flex-shrink: 0; /* Không cho logo co lại */
        min-width: fit-content;
    }
    .nav-menu {
        display: flex;
        list-style: none;
        margin: 0;
        padding: 0;
        gap: 20px; /* Giảm gap để tiết kiệm không gian */
        flex-shrink: 0; /* Không cho menu co lại */
        white-space: nowrap;
    }
    .nav-menu a {
        text-decoration: none;
        color: #333;
        font-weight: 500;
        padding: 8px 12px;
        border-radius: 4px;
        transition: background 0.2s;
        white-space: nowrap; /* Ngăn text xuống dòng */
    }
    .nav-menu a:hover {
        background: #f8f9fa;
    }
    .header-actions {
        display: flex;
        align-items: center;
        gap: 12px; /* Giảm gap */
        flex-shrink: 0; /* Không cho actions co lại */
        white-space: nowrap;
    }
    .cart-info {
        color: #666;
        font-size: 0.9rem; /* Giảm font size */
        white-space: nowrap;
    }
    .login-btn, .cart-btn, .logout-btn {
        background: #007bff;
        color: #fff;
        text-decoration: none;
        padding: 6px 12px; /* Giảm padding */
        border-radius: 4px;
        font-weight: 500;
        transition: background 0.2s;
        border: none;
        cursor: pointer;
        white-space: nowrap;
        font-size: 0.9rem; /* Giảm font size */
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
        white-space: nowrap;
        font-size: 0.9rem; /* Giảm font size */
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
        white-space: nowrap;
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
        font-size: 0.65rem;
        padding: 2px 4px;
        border-radius: 3px;
        margin-left: 5px;
    }
    
    /* Media queries được điều chỉnh */
    @media (max-width: 1200px) {
        .header-container {
            max-width: 100%;
            padding: 12px 15px;
        }
        .nav-menu {
            gap: 16px;
        }
        .header-actions {
            gap: 10px;
        }
    }
    
    @media (max-width: 992px) {
        .nav-menu {
            gap: 12px;
        }
        .nav-menu a {
            padding: 6px 8px;
            font-size: 0.9rem;
        }
        .header-actions {
            gap: 8px;
        }
    }
    
    /* Chỉ cho phép xuống dòng khi màn hình rất nhỏ */
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
        <div class="header-row-top">
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
        </div>
        <div class="header-row-bottom">
            <div style="position: relative; margin-right: 0;">
                <button type="button" id="category-btn" style="padding: 6px 14px; border: none; background: #28a745; color: #fff; border-radius: 4px; font-size: 0.98rem; cursor: pointer;">Danh mục ▼</button>
                <div id="category-dropdown" style="display: none; position: absolute; left: 0; top: 110%; background: #fff; box-shadow: 0 2px 8px rgba(0,0,0,0.12); border-radius: 4px; min-width: 180px; z-index: 9999;">
                    <% 
                        List<String> categories = (List<String>) request.getAttribute("categories");
                        if (categories != null) {
                            for (String cat : categories) {
                    %>
                        <a href="<%= request.getContextPath() %>/products?category=<%= java.net.URLEncoder.encode(cat, "UTF-8") %>" style="display:block; padding:10px 18px; color:#333; text-decoration:none;"> <%= cat %> </a>
                    <%      }
                        }
                    %>
                </div>
            </div>
            <form action="<%= request.getContextPath() %>/products" method="get" style="margin-right: 24px; display: flex; align-items: center;">
                <input type="text" name="search" placeholder="Tìm kiếm sản phẩm..." style="padding: 6px 10px; border: 1px solid #ccc; border-radius: 4px 0 0 4px; outline: none; font-size: 0.98rem; min-width: 180px;">
                <button type="submit" style="padding: 6px 14px; border: none; background: #007bff; color: #fff; border-radius: 0 4px 4px 0; font-size: 0.98rem; cursor: pointer;">Tìm</button>
            </form>
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

<script>
document.addEventListener('DOMContentLoaded', function() {
    var btn = document.getElementById('category-btn');
    var dropdown = document.getElementById('category-dropdown');
    if (!btn || !dropdown) return;

    btn.onclick = function(e) {
        e.stopPropagation();
        dropdown.style.display = (dropdown.style.display === 'block') ? 'none' : 'block';
    };
    // Đóng dropdown khi click ra ngoài, nhưng KHÔNG đóng khi click vào link bên trong dropdown
    document.addEventListener('click', function(e) {
        if (dropdown.style.display === 'block' && !dropdown.contains(e.target) && e.target !== btn) {
            dropdown.style.display = 'none';
        }
    });
    // Đóng dropdown khi cuộn trang
    window.addEventListener('scroll', function() {
        dropdown.style.display = 'none';
    });
});
</script>