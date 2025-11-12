<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.User" %>
<%@ page import="model.Order" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%
    User currentUser = (User) session.getAttribute("user");
    if (currentUser == null || !"ADMIN".equals(currentUser.getRole())) {
        response.sendRedirect(request.getContextPath() + "/login");
        return;
    }
    
    List<Order> orders = (List<Order>) request.getAttribute("orders");
    String messageType = (String) request.getAttribute("messageType");
    String message = (String) request.getAttribute("message");
    SimpleDateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy HH:mm");
    String activePage = "orders";
    String pageTitle = "Quản lý Đơn hàng";
    
    request.setAttribute("activePage", activePage);
    request.setAttribute("pageTitle", pageTitle);
%>
<jsp:include page="/admin/layout/header.jsp" />
<div id="wrapper">
    <jsp:include page="/admin/layout/sidebar.jsp" />
    
    <!-- Content Wrapper -->
    <div id="content-wrapper">
        <jsp:include page="/admin/layout/navbar.jsp" />
        
        <!-- Main Content -->
        <div class="container-fluid">
                <!-- Page Header -->
                <div class="page-header">
                    <h1 class="page-title">🛒 Quản lý Đơn hàng</h1>
                </div>
                
                <!-- Breadcrumb -->
                <nav class="breadcrumb">
                    <div class="breadcrumb-item"><a href="<%= request.getContextPath() %>/admin/products">Dashboard</a></div>
                    <div class="breadcrumb-item active">Đơn hàng</div>
                </nav>
                
                <!-- Alert Messages -->
                <% if (message != null) { %>
                    <div class="alert alert-<%= "success".equals(messageType) ? "success" : "danger" %>">
                        <%= message %>
                        <button class="close" onclick="this.parentElement.style.display='none'">&times;</button>
                    </div>
                <% } %>
                
                <!-- Orders Table Card -->
                <div class="card">
                    <div class="card-header">
                        <span style="font-size: 1.5rem;">📊</span>
                        <h2 class="card-title">Danh sách Đơn hàng</h2>
                    </div>
                    <div class="card-body">
                        <div class="table-responsive">
                            <table id="ordersTable" class="table">
                                <thead>
                                    <tr>
                                        <th>ID</th>
                                        <th>Người đặt</th>
                                        <th>Khách hàng</th>
                                        <th>Số điện thoại</th>
                                        <th>Tổng tiền (₫)</th>
                                        <th>Trạng thái</th>
                                        <th>Ngày đặt</th>
                                        <th>Thao tác</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <% if (orders != null && !orders.isEmpty()) { %>
                                        <% for (Order order : orders) { %>
                                            <tr>
                                                <td><strong>#<%= order.getId() %></strong></td>
                                                <td><%= order.getUserName() != null ? order.getUserName() : "N/A" %></td>
                                                <td><strong><%= order.getCustomerName() != null ? order.getCustomerName() : "N/A" %></strong></td>
                                                <td><%= order.getCustomerPhone() != null ? order.getCustomerPhone() : "N/A" %></td>
                                                <td data-order="<%= order.getTotal() %>"><strong><%= String.format("%,.0f", order.getTotal()) %> ₫</strong></td>
                                                <td>
                                                    <% 
                                                        String status = order.getStatus();
                                                        String statusClass = "badge-warning";
                                                        String statusText = "Đang xử lý";
                                                        if ("Completed".equals(status)) {
                                                            statusClass = "badge-success";
                                                            statusText = "Hoàn thành";
                                                        } else if ("Cancelled".equals(status)) {
                                                            statusClass = "badge-danger";
                                                            statusText = "Đã hủy";
                                                        }
                                                    %>
                                                    <span class="badge <%= statusClass %>"><%= statusText %></span>
                                                </td>
                                                <td data-order="<%= order.getOrderDate() != null ? order.getOrderDate().getTime() : 0 %>"><%= order.getOrderDate() != null ? dateFormat.format(order.getOrderDate()) : "N/A" %></td>
                                                <td>
                                                    <div class="btn-group">
                                                        <a href="<%= request.getContextPath() %>/admin/orders/detail?id=<%= order.getId() %>" class="btn btn-info btn-sm" title="Xem chi tiết">
                                                            👁️ Chi tiết
                                                        </a>
                                                        <a href="<%= request.getContextPath() %>/admin/orders/detail?id=<%= order.getId() %>&edit=true" class="btn btn-primary btn-sm" title="Chỉnh sửa">
                                                            ✏️ Sửa
                                                        </a>
                                                    </div>
                                                </td>
                                            </tr>
                                        <% } %>
                                    <% } else { %>
                                        <tr>
                                            <td colspan="8" style="text-align: center; padding: 3rem; color: #94a3b8;">
                                                <div style="font-size: 3rem; margin-bottom: 1rem;">📦</div>
                                                <p style="font-size: 1.125rem; font-weight: 600; margin: 0;">Chưa có đơn hàng nào</p>
                                            </td>
                                        </tr>
                                    <% } %>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <script>
        // Initialize DataTables with improved search and pagination
        $(document).ready(function() {
            var table = $('#ordersTable').DataTable({
                "language": {
                    "lengthMenu": "Hiển thị _MENU_ đơn hàng",
                    "zeroRecords": "Không tìm thấy đơn hàng nào",
                    "info": "Hiển thị _START_ đến _END_ của _TOTAL_ đơn hàng",
                    "infoEmpty": "Không có dữ liệu",
                    "infoFiltered": "(lọc từ _MAX_ đơn hàng)",
                    "search": "Tìm kiếm:",
                    "paginate": {
                        "first": "⏮ Đầu",
                        "last": "Cuối ⏭",
                        "next": "Sau ▶",
                        "previous": "◀ Trước"
                    },
                    "emptyTable": "Không có dữ liệu trong bảng",
                    "loadingRecords": "Đang tải...",
                    "processing": "Đang xử lý...",
                    "searchPlaceholder": "Tìm kiếm đơn hàng..."
                },
                "pageLength": 10,
                "lengthMenu": [[10, 25, 50, 100, -1], [10, 25, 50, 100, "Tất cả"]],
                "order": [[ 0, "desc" ]],
                "columnDefs": [
                    { "orderable": false, "targets": [7] },
                    { "type": "num", "targets": [0, 4] },
                    { "type": "date", "targets": [6] }
                ],
                "dom": "<'row'<'col-sm-12 col-md-6'l><'col-sm-12 col-md-6'f>>" +
                       "<'row'<'col-sm-12'tr>>" +
                       "<'row'<'col-sm-12 col-md-5'i><'col-sm-12 col-md-7'p>>",
                "responsive": true,
                "autoWidth": false
            });
            
            // Link navbar search to DataTables search
            $('#globalSearch').on('keyup', function() {
                table.search(this.value).draw();
            });
        });
    </script>
    
<jsp:include page="/admin/layout/footer.jsp" />
