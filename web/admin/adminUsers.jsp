<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.User" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%
    User currentUser = (User) session.getAttribute("user");
    if (currentUser == null || !"ADMIN".equals(currentUser.getRole())) {
        response.sendRedirect(request.getContextPath() + "/login");
        return;
    }
    
    List<User> users = (List<User>) request.getAttribute("users");
    String messageType = (String) session.getAttribute("messageType");
    String message = (String) session.getAttribute("message");
    if (message != null) {
        session.removeAttribute("messageType");
        session.removeAttribute("message");
    }
    SimpleDateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy");
    String activePage = "users";
    String pageTitle = "Quản lý Người dùng";
    
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
                    <h1 class="page-title">👥 Quản lý Người dùng</h1>
                    <button class="btn btn-primary" onclick="openAddUserModal()">
                        ➕ Thêm người dùng
                    </button>
                </div>
                
                <!-- Breadcrumb -->
                <nav class="breadcrumb">
                    <div class="breadcrumb-item"><a href="<%= request.getContextPath() %>/admin/products">Dashboard</a></div>
                    <div class="breadcrumb-item active">Người dùng</div>
                </nav>
                
                <!-- Alert Messages -->
                <% if (message != null) { %>
                    <div class="alert alert-<%= "success".equals(messageType) ? "success" : "danger" %>">
                        <%= message %>
                        <button class="close" onclick="this.parentElement.style.display='none'">&times;</button>
                    </div>
                <% } %>
                
                <!-- Users Table Card -->
                <div class="card">
                    <div class="card-header">
                        <span style="font-size: 1.5rem;">📊</span>
                        <h2 class="card-title">Danh sách Người dùng</h2>
                    </div>
                    <div class="card-body">
                        <div class="table-responsive">
                            <table id="usersTable" class="table">
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
                                                <td><strong>#<%= user.getId() %></strong></td>
                                                <td><strong><%= user.getUsername() %></strong></td>
                                                <td><%= user.getEmail() != null ? user.getEmail() : "N/A" %></td>
                                                <td><%= user.getFullName() != null ? user.getFullName() : "N/A" %></td>
                                                <td><%= user.getPhone() != null ? user.getPhone() : "N/A" %></td>
                                                <td>
                                                    <% if ("ADMIN".equals(user.getRole())) { %>
                                                        <span class="badge badge-danger"><%= user.getRole() %></span>
                                                    <% } else { %>
                                                        <span class="badge badge-success"><%= user.getRole() %></span>
                                                    <% } %>
                                                </td>
                                                <td data-order="<%= user.getCreatedAt() != null ? user.getCreatedAt().getTime() : 0 %>"><%= user.getCreatedAt() != null ? dateFormat.format(user.getCreatedAt()) : "N/A" %></td>
                                                <td>
                                                    <div class="btn-group">
                                                        <button class="btn btn-info btn-sm" onclick="openEditUserModal(<%= user.getId() %>, '<%= user.getUsername().replaceAll("'", "\\\\'") %>', '<%= user.getEmail() != null ? user.getEmail().replaceAll("'", "\\\\'") : "" %>', '<%= user.getFullName() != null ? user.getFullName().replaceAll("'", "\\\\'") : "" %>', '<%= user.getPhone() != null ? user.getPhone().replaceAll("'", "\\\\'") : "" %>', '<%= user.getAddress() != null ? user.getAddress().replaceAll("'", "\\\\'").replaceAll("\n", " ").replaceAll("\r", "") : "" %>', '<%= user.getRole() %>')" title="Sửa">
                                                            ✏️
                                                        </button>
                                                        <% if (user.getId() != currentUser.getId()) { %>
                                                            <button class="btn btn-danger btn-sm" onclick="deleteUser(<%= user.getId() %>, '<%= user.getUsername().replaceAll("'", "\\\\'") %>')" title="Xóa">
                                                                🗑️
                                                            </button>
                                                        <% } %>
                                                    </div>
                                                </td>
                                            </tr>
                                        <% } %>
                                    <% } else { %>
                                        <tr>
                                            <td colspan="8" style="text-align: center; padding: 3rem; color: #94a3b8;">
                                                <div style="font-size: 3rem; margin-bottom: 1rem;">👥</div>
                                                <p style="font-size: 1.125rem; font-weight: 600; margin: 0;">Chưa có người dùng nào</p>
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
    
    <!-- Add User Modal -->
    <div id="addUserModal" class="modal">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">➕ Thêm người dùng mới</h5>
                    <button class="close" onclick="closeModal('addUserModal')">&times;</button>
                </div>
                <form action="<%= request.getContextPath() %>/admin/users/add" method="post">
                    <div class="modal-body">
                        <div class="form-group">
                            <label class="form-label" for="username">Tên đăng nhập *</label>
                            <input type="text" class="form-control" id="username" name="username" required placeholder="Nhập tên đăng nhập">
                        </div>
                        <div class="form-group">
                            <label class="form-label" for="password">Mật khẩu *</label>
                            <input type="password" class="form-control" id="password" name="password" required placeholder="Nhập mật khẩu">
                        </div>
                        <div class="form-group">
                            <label class="form-label" for="email">Email</label>
                            <input type="email" class="form-control" id="email" name="email" placeholder="Nhập email">
                        </div>
                        <div class="form-group">
                            <label class="form-label" for="fullName">Họ tên</label>
                            <input type="text" class="form-control" id="fullName" name="fullName" placeholder="Nhập họ tên">
                        </div>
                        <div class="form-group">
                            <label class="form-label" for="phone">Số điện thoại</label>
                            <input type="text" class="form-control" id="phone" name="phone" placeholder="Nhập số điện thoại">
                        </div>
                        <div class="form-group">
                            <label class="form-label" for="address">Địa chỉ</label>
                            <textarea class="form-control" id="address" name="address" rows="3" placeholder="Nhập địa chỉ"></textarea>
                        </div>
                        <div class="form-group">
                            <label class="form-label" for="role">Vai trò</label>
                            <select class="form-control" id="role" name="role">
                                <option value="USER">USER</option>
                                <option value="ADMIN">ADMIN</option>
                            </select>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" onclick="closeModal('addUserModal')">Hủy</button>
                        <button type="submit" class="btn btn-primary">Thêm người dùng</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
    
    <!-- Edit User Modal -->
    <div id="editUserModal" class="modal">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">✏️ Sửa thông tin người dùng</h5>
                    <button class="close" onclick="closeModal('editUserModal')">&times;</button>
                </div>
                <form action="<%= request.getContextPath() %>/admin/users/update" method="post">
                    <input type="hidden" id="editUserId" name="userId">
                    <div class="modal-body">
                        <div class="form-group">
                            <label class="form-label" for="editUsername">Tên đăng nhập</label>
                            <input type="text" class="form-control" id="editUsername" name="username" readonly>
                        </div>
                        <div class="form-group">
                            <label class="form-label" for="editEmail">Email</label>
                            <input type="email" class="form-control" id="editEmail" name="email" placeholder="Nhập email">
                        </div>
                        <div class="form-group">
                            <label class="form-label" for="editFullName">Họ tên</label>
                            <input type="text" class="form-control" id="editFullName" name="fullName" placeholder="Nhập họ tên">
                        </div>
                        <div class="form-group">
                            <label class="form-label" for="editPhone">Số điện thoại</label>
                            <input type="text" class="form-control" id="editPhone" name="phone" placeholder="Nhập số điện thoại">
                        </div>
                        <div class="form-group">
                            <label class="form-label" for="editAddress">Địa chỉ</label>
                            <textarea class="form-control" id="editAddress" name="address" rows="3" placeholder="Nhập địa chỉ"></textarea>
                        </div>
                        <div class="form-group">
                            <label class="form-label" for="editRole">Vai trò</label>
                            <select class="form-control" id="editRole" name="role">
                                <option value="USER">USER</option>
                                <option value="ADMIN">ADMIN</option>
                            </select>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" onclick="closeModal('editUserModal')">Hủy</button>
                        <button type="submit" class="btn btn-primary">Cập nhật</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
    
    <script>
        // Initialize DataTables with improved search and pagination
        $(document).ready(function() {
            var table = $('#usersTable').DataTable({
                "language": {
                    "lengthMenu": "Hiển thị _MENU_ người dùng",
                    "zeroRecords": "Không tìm thấy người dùng nào",
                    "info": "Hiển thị _START_ đến _END_ của _TOTAL_ người dùng",
                    "infoEmpty": "Không có dữ liệu",
                    "infoFiltered": "(lọc từ _MAX_ người dùng)",
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
                    "searchPlaceholder": "Tìm kiếm người dùng..."
                },
                "pageLength": 10,
                "lengthMenu": [[10, 25, 50, 100, -1], [10, 25, 50, 100, "Tất cả"]],
                "order": [[ 0, "desc" ]],
                "columnDefs": [
                    { "orderable": false, "targets": [7] },
                    { "type": "num", "targets": [0] },
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
        
        // Modal functions
        function openAddUserModal() {
            openModal('addUserModal');
        }
        
        function openEditUserModal(id, username, email, fullName, phone, address, role) {
            document.getElementById('editUserId').value = id;
            document.getElementById('editUsername').value = username;
            document.getElementById('editEmail').value = email || '';
            document.getElementById('editFullName').value = fullName || '';
            document.getElementById('editPhone').value = phone || '';
            document.getElementById('editAddress').value = address || '';
            document.getElementById('editRole').value = role || 'USER';
            openModal('editUserModal');
        }
        
        function deleteUser(userId, username) {
            if (confirm('Bạn có chắc muốn xóa người dùng "' + username + '"?')) {
                window.location.href = '<%= request.getContextPath() %>/admin/users/delete?id=' + userId;
            }
        }
    </script>
    
<jsp:include page="/admin/layout/footer.jsp" />
