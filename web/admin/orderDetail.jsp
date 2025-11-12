<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.User" %>
<%@ page import="model.Order" %>
<%@ page import="model.OrderItem" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%
    User currentUser = (User) session.getAttribute("user");
    if (currentUser == null || !"ADMIN".equals(currentUser.getRole())) {
        response.sendRedirect(request.getContextPath() + "/login");
        return;
    }
    
    Order order = (Order) request.getAttribute("order");
    List<OrderItem> orderItems = (List<OrderItem>) request.getAttribute("orderItems");
    Boolean editMode = (Boolean) request.getAttribute("editMode");
    if (editMode == null) editMode = false;
    
    SimpleDateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy HH:mm");
    String activePage = "orders";
    String pageTitle = editMode ? "Chỉnh sửa Đơn hàng #" + order.getId() : "Chi tiết Đơn hàng #" + order.getId();
    
    request.setAttribute("activePage", activePage);
    request.setAttribute("pageTitle", pageTitle);
    
    String messageType = (String) session.getAttribute("messageType");
    String message = (String) session.getAttribute("message");
    if (message != null) {
        session.removeAttribute("messageType");
        session.removeAttribute("message");
    }
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
                <h1 class="page-title">
                    📋 <%= editMode ? "Chỉnh sửa" : "Chi tiết" %> Đơn hàng #<%= order.getId() %>
                </h1>
                <div style="display: flex; gap: 0.5rem;">
                    <% if (editMode) { %>
                        <a href="<%= request.getContextPath() %>/admin/orders/detail?id=<%= order.getId() %>" class="btn btn-secondary">
                            ❌ Hủy
                        </a>
                    <% } else { %>
                        <a href="<%= request.getContextPath() %>/admin/orders/detail?id=<%= order.getId() %>&edit=true" class="btn btn-primary">
                            ✏️ Chỉnh sửa
                        </a>
                    <% } %>
                    <a href="<%= request.getContextPath() %>/admin/orders" class="btn btn-secondary">
                        ← Quay lại
                    </a>
                </div>
            </div>
            
            <!-- Breadcrumb -->
            <nav class="breadcrumb">
                <div class="breadcrumb-item"><a href="<%= request.getContextPath() %>/admin/products">Dashboard</a></div>
                <div class="breadcrumb-item"><a href="<%= request.getContextPath() %>/admin/orders">Đơn hàng</a></div>
                <div class="breadcrumb-item active">Chi tiết #<%= order.getId() %></div>
            </nav>
            
            <!-- Alert Messages -->
            <% if (message != null) { %>
                <div class="alert alert-<%= "success".equals(messageType) ? "success" : "danger" %>">
                    <%= message %>
                    <button class="close" onclick="this.parentElement.style.display='none'">&times;</button>
                </div>
            <% } %>
            
            <% if (editMode) { %>
                <!-- Edit Form -->
                <form action="<%= request.getContextPath() %>/admin/orders/detail" method="post">
                    <input type="hidden" name="orderId" value="<%= order.getId() %>">
                    
                    <div class="card">
                        <div class="card-header">
                            <span style="font-size: 1.5rem;">✏️</span>
                            <h2 class="card-title">Chỉnh sửa thông tin đơn hàng</h2>
                        </div>
                        <div class="card-body">
                            <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(300px, 1fr)); gap: 1.5rem;">
                                <div class="form-group">
                                    <label class="form-label">Trạng thái *</label>
                                    <select class="form-control" name="status" required>
                                        <option value="Pending" <%= "Pending".equals(order.getStatus()) ? "selected" : "" %>>Đang xử lý</option>
                                        <option value="Completed" <%= "Completed".equals(order.getStatus()) ? "selected" : "" %>>Hoàn thành</option>
                                        <option value="Cancelled" <%= "Cancelled".equals(order.getStatus()) ? "selected" : "" %>>Đã hủy</option>
                                    </select>
                                </div>
                                
                                <div class="form-group">
                                    <label class="form-label">Tên khách hàng *</label>
                                    <input type="text" class="form-control" name="customerName" value="<%= order.getCustomerName() != null ? order.getCustomerName() : "" %>" required>
                                </div>
                                
                                <div class="form-group">
                                    <label class="form-label">Số điện thoại *</label>
                                    <input type="tel" class="form-control" name="customerPhone" value="<%= order.getCustomerPhone() != null ? order.getCustomerPhone() : "" %>" required>
                                </div>
                                
                                <div class="form-group" style="grid-column: 1 / -1;">
                                    <label class="form-label">Địa chỉ giao hàng *</label>
                                    <textarea class="form-control" name="customerAddress" rows="3" required><%= order.getCustomerAddress() != null ? order.getCustomerAddress() : "" %></textarea>
                                </div>
                            </div>
                            
                            <div style="margin-top: 2rem; display: flex; gap: 1rem; justify-content: flex-end;">
                                <a href="<%= request.getContextPath() %>/admin/orders/detail?id=<%= order.getId() %>" class="btn btn-secondary">
                                    Hủy
                                </a>
                                <button type="submit" class="btn btn-primary">
                                    💾 Lưu thay đổi
                                </button>
                            </div>
                        </div>
                    </div>
                </form>
            <% } else { %>
                <!-- View Mode -->
                <div class="card">
                    <div class="card-header">
                        <span style="font-size: 1.5rem;">ℹ️</span>
                        <h2 class="card-title">Thông tin đơn hàng</h2>
                    </div>
                    <div class="card-body">
                        <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(300px, 1fr)); gap: 2rem;">
                            <div>
                                <div style="color: #64748b; font-size: 0.875rem; margin-bottom: 0.5rem; font-weight: 600;">Mã đơn hàng</div>
                                <div style="font-size: 1.125rem; font-weight: 700; color: #1e293b;">#<%= order.getId() %></div>
                            </div>
                            
                            <div>
                                <div style="color: #64748b; font-size: 0.875rem; margin-bottom: 0.5rem; font-weight: 600;">Người đặt</div>
                                <div style="font-size: 1.125rem; font-weight: 600; color: #1e293b;"><%= order.getUserName() != null ? order.getUserName() : "N/A" %></div>
                            </div>
                            
                            <div>
                                <div style="color: #64748b; font-size: 0.875rem; margin-bottom: 0.5rem; font-weight: 600;">Trạng thái</div>
                                <div>
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
                                    <span class="badge <%= statusClass %>" style="font-size: 1rem; padding: 0.5rem 1rem;"><%= statusText %></span>
                                </div>
                            </div>
                            
                            <div>
                                <div style="color: #64748b; font-size: 0.875rem; margin-bottom: 0.5rem; font-weight: 600;">Ngày đặt</div>
                                <div style="font-size: 1.125rem; font-weight: 600; color: #1e293b;"><%= order.getOrderDate() != null ? dateFormat.format(order.getOrderDate()) : "N/A" %></div>
                            </div>
                            
                            <div>
                                <div style="color: #64748b; font-size: 0.875rem; margin-bottom: 0.5rem; font-weight: 600;">Tên khách hàng</div>
                                <div style="font-size: 1.125rem; font-weight: 600; color: #1e293b;"><%= order.getCustomerName() != null ? order.getCustomerName() : "N/A" %></div>
                            </div>
                            
                            <div>
                                <div style="color: #64748b; font-size: 0.875rem; margin-bottom: 0.5rem; font-weight: 600;">Số điện thoại</div>
                                <div style="font-size: 1.125rem; font-weight: 600; color: #1e293b;"><%= order.getCustomerPhone() != null ? order.getCustomerPhone() : "N/A" %></div>
                            </div>
                            
                            <div style="grid-column: 1 / -1;">
                                <div style="color: #64748b; font-size: 0.875rem; margin-bottom: 0.5rem; font-weight: 600;">Địa chỉ giao hàng</div>
                                <div style="font-size: 1.125rem; font-weight: 600; color: #1e293b;"><%= order.getCustomerAddress() != null ? order.getCustomerAddress() : "N/A" %></div>
                            </div>
                        </div>
                    </div>
                </div>
            <% } %>
            
            <!-- Order Items -->
            <div class="card">
                <div class="card-header">
                    <span style="font-size: 1.5rem;">📦</span>
                    <h2 class="card-title">Sản phẩm trong đơn hàng</h2>
                </div>
                <div class="card-body">
                    <div class="table-responsive">
                        <table class="table">
                            <thead>
                                <tr>
                                    <th style="width: 60px;">STT</th>
                                    <th>Tên sản phẩm</th>
                                    <th style="width: 150px;">Đơn giá</th>
                                    <th style="width: 100px;">Số lượng</th>
                                    <th style="width: 150px;">Thành tiền</th>
                                </tr>
                            </thead>
                            <tbody>
                                <% 
                                    int index = 1;
                                    double totalAmount = 0;
                                    if (orderItems != null && !orderItems.isEmpty()) { 
                                        for (OrderItem item : orderItems) {
                                            totalAmount += item.getSubtotal();
                                %>
                                    <tr>
                                        <td style="text-align: center;"><%= index++ %></td>
                                        <td><strong><%= item.getProductName() %></strong></td>
                                        <td><%= String.format("%,.0f", item.getPrice()) %> ₫</td>
                                        <td style="text-align: center;"><%= item.getQuantity() %></td>
                                        <td><strong><%= String.format("%,.0f", item.getSubtotal()) %> ₫</strong></td>
                                    </tr>
                                <% 
                                        }
                                    } else { 
                                %>
                                    <tr>
                                        <td colspan="5" style="text-align: center; padding: 2rem; color: #94a3b8;">
                                            Không có sản phẩm nào
                                        </td>
                                    </tr>
                                <% } %>
                            </tbody>
                            <tfoot>
                                <tr style="background: #f8fafc;">
                                    <td colspan="4" style="text-align: right; padding: 1rem; font-weight: 700; font-size: 1.125rem;">Tổng cộng:</td>
                                    <td style="padding: 1rem;">
                                        <strong style="font-size: 1.25rem; color: #667eea;"><%= String.format("%,.0f", order.getTotal()) %> ₫</strong>
                                    </td>
                                </tr>
                            </tfoot>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="/admin/layout/footer.jsp" />

