<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.User" %>
<%@ page import="model.Order" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%
    // Kiểm tra quyền admin
    User currentUser = (User) session.getAttribute("user");
    if (currentUser == null || !"ADMIN".equals(currentUser.getRole())) {
        response.sendRedirect(request.getContextPath() + "/login");
        return;
    }
    
    // Lấy danh sách đơn hàng từ request attribute
    List<Order> orders = (List<Order>) request.getAttribute("orders");
    
    // Lấy thông báo từ request
    String messageType = (String) request.getAttribute("messageType");
    String message = (String) request.getAttribute("message");
    
    // Format date
    SimpleDateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy HH:mm");
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Quản lý đơn hàng - Admin Dashboard</title>
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
        
        .order-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        .order-table th,
        .order-table td {
            border: 1px solid #ddd;
            padding: 12px;
            text-align: left;
        }
        .order-table th {
            background: #f8f9fa;
            font-weight: bold;
            color: #2c3e50;
        }
        .order-table tr:nth-child(even) {
            background: #f8f9fa;
        }
        .order-table tr:hover {
            background: #e8f4f8;
        }
        .status-badge {
            padding: 4px 8px;
            border-radius: 4px;
            font-size: 0.85rem;
            font-weight: bold;
        }
        .status-pending {
            background: #fff3cd;
            color: #856404;
        }
        .status-completed {
            background: #d4edda;
            color: #155724;
        }
        .status-cancelled {
            background: #f8d7da;
            color: #721c24;
        }
        .action-btn {
            padding: 6px 12px;
            margin: 2px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 0.9rem;
        }
        .view-btn {
            background: #17a2b8;
            color: white;
        }
        .complete-btn {
            background: #28a745;
            color: white;
        }
        .cancel-btn {
            background: #dc3545;
            color: white;
        }
        .view-btn:hover {
            background: #138496;
        }
        .complete-btn:hover {
            background: #218838;
        }
        .cancel-btn:hover {
            background: #c82333;
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
            max-width: 600px;
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
        .order-detail {
            line-height: 1.6;
        }
        .order-detail strong {
            color: #2c3e50;
        }
    </style>
</head>
<body>
    <header class="admin-header">
        <div class="admin-title">Admin Dashboard - SmartPhoneStore.vn</div>
        <nav class="admin-nav">
            <a href="<%= request.getContextPath() %>/admin/products">Sản phẩm</a>
            <a href="<%= request.getContextPath() %>/admin/orders" class="active">Đơn hàng</a>
            <a href="<%= request.getContextPath() %>/admin/users">Người dùng</a>
            <a href="<%= request.getContextPath() %>/home">Về trang chủ</a>
            <a href="<%= request.getContextPath() %>/logout" class="logout-btn">Đăng xuất</a>
        </nav>
    </header>

    <div class="admin-container">
        <div class="admin-content">
            <h1 class="section-title">Quản lý đơn hàng</h1>
            
            <!-- Hiển thị thông báo -->
            <% if (message != null) { %>
                <div class="alert alert-<%= messageType %>">
                    <%= message %>
                </div>
            <% } %>

            <table class="order-table">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Người đặt</th>
                        <th>Khách hàng</th>
                        <th>Tổng tiền</th>
                        <th>Trạng thái</th>
                        <th>Ngày đặt</th>
                        <th>Thao tác</th>
                    </tr>
                </thead>
                <tbody>
                    <% if (orders != null && !orders.isEmpty()) { %>
                        <% for (Order order : orders) { %>
                            <tr>
                                <td><%= order.getId() %></td>
                                <td><%= order.getUserName() != null ? order.getUserName() : "N/A" %></td>
                                <td><%= order.getCustomerName() != null ? order.getCustomerName() : "N/A" %></td>
                                <td><%= String.format("%,.0f", order.getTotal()) %> VND</td>
                                <td>
                                    <% 
                                        String status = order.getStatus();
                                        String statusClass = "";
                                        String statusText = "";
                                        if ("Pending".equals(status)) {
                                            statusClass = "status-pending";
                                            statusText = "Đang xử lý";
                                        } else if ("Completed".equals(status)) {
                                            statusClass = "status-completed";
                                            statusText = "Hoàn thành";
                                        } else if ("Cancelled".equals(status)) {
                                            statusClass = "status-cancelled";
                                            statusText = "Đã hủy";
                                        } else {
                                            statusClass = "status-pending";
                                            statusText = status;
                                        }
                                    %>
                                    <span class="status-badge <%= statusClass %>"><%= statusText %></span>
                                </td>
                                <td><%= order.getOrderDate() != null ? dateFormat.format(order.getOrderDate()) : "N/A" %></td>
                                <td>
                                    <button class="action-btn view-btn" onclick="viewOrderDetail(<%= order.getId() %>, '<%= order.getUserName() != null ? order.getUserName().replaceAll("'", "\\\\'") : "N/A" %>', '<%= order.getCustomerName() != null ? order.getCustomerName().replaceAll("'", "\\\\'") : "N/A" %>', '<%= order.getCustomerPhone() != null ? order.getCustomerPhone().replaceAll("'", "\\\\'") : "N/A" %>', '<%= order.getCustomerAddress() != null ? order.getCustomerAddress().replaceAll("'", "\\\\'") : "N/A" %>', '<%= String.format("%,.0f", order.getTotal()) %>', '<%= statusText %>', '<%= order.getOrderDate() != null ? dateFormat.format(order.getOrderDate()) : "N/A" %>')">
                                        Chi tiết
                                    </button>
                                    <% if ("Pending".equals(status)) { %>
                                        <button class="action-btn complete-btn" onclick="updateOrderStatus(<%= order.getId() %>, 'Completed')">
                                            Hoàn thành
                                        </button>
                                        <button class="action-btn cancel-btn" onclick="updateOrderStatus(<%= order.getId() %>, 'Cancelled')">
                                            Hủy
                                        </button>
                                    <% } %>
                                </td>
                            </tr>
                        <% } %>
                    <% } else { %>
                        <tr>
                            <td colspan="7" style="text-align: center; padding: 20px; color: #666;">
                                Không có đơn hàng nào
                            </td>
                        </tr>
                    <% } %>
                </tbody>
            </table>
        </div>
    </div>

    <!-- Modal chi tiết đơn hàng -->
    <div id="orderDetailModal" class="modal">
        <div class="modal-content">
            <div class="modal-header">
                <h2 class="modal-title">Chi tiết đơn hàng</h2>
                <span class="close" onclick="closeModal('orderDetailModal')">&times;</span>
            </div>
            <div class="order-detail" id="orderDetailContent">
                <!-- Nội dung chi tiết đơn hàng sẽ được điền bằng JavaScript -->
            </div>
        </div>
    </div>

    <script>
        function viewOrderDetail(id, userName, customerName, customerPhone, customerAddress, total, status, orderDate) {
            const content = `
                <p><strong>Mã đơn hàng:</strong> #${id}</p>
                <p><strong>Người đặt hàng:</strong> ${userName}</p>
                <p><strong>Tên khách hàng:</strong> ${customerName}</p>
                <p><strong>Số điện thoại:</strong> ${customerPhone}</p>
                <p><strong>Địa chỉ giao hàng:</strong> ${customerAddress}</p>
                <p><strong>Tổng tiền:</strong> ${total} VND</p>
                <p><strong>Trạng thái:</strong> ${status}</p>
                <p><strong>Ngày đặt:</strong> ${orderDate}</p>
            `;
            
            document.getElementById('orderDetailContent').innerHTML = content;
            document.getElementById('orderDetailModal').style.display = 'block';
        }
        
        function updateOrderStatus(orderId, newStatus) {
            const statusText = newStatus === 'Completed' ? 'hoàn thành' : 'hủy';
            if (confirm(`Bạn có chắc muốn ${statusText} đơn hàng #${orderId}?`)) {
                // Tạo form và submit
                const form = document.createElement('form');
                form.method = 'POST';
                form.action = '<%= request.getContextPath() %>/admin/orders/updateStatus';
                
                const orderIdInput = document.createElement('input');
                orderIdInput.type = 'hidden';
                orderIdInput.name = 'orderId';
                orderIdInput.value = orderId;
                
                const statusInput = document.createElement('input');
                statusInput.type = 'hidden';
                statusInput.name = 'status';
                statusInput.value = newStatus;
                
                form.appendChild(orderIdInput);
                form.appendChild(statusInput);
                document.body.appendChild(form);
                form.submit();
            }
        }
        
        function closeModal(modalId) {
            document.getElementById(modalId).style.display = 'none';
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