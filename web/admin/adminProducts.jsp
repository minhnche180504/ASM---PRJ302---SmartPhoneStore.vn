<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.User" %>
<%@ page import="model.Product" %>
<%@ page import="java.util.List" %>
<%
    User currentUser = (User) session.getAttribute("user");
    if (currentUser == null || !"ADMIN".equals(currentUser.getRole())) {
        response.sendRedirect(request.getContextPath() + "/login");
        return;
    }
    
    List<Product> products = (List<Product>) request.getAttribute("products");
    String messageType = (String) request.getAttribute("messageType");
    String message = (String) request.getAttribute("message");
    Product editProduct = (Product) request.getAttribute("editProduct");
    String activePage = "products";
    String pageTitle = "Quản lý Sản phẩm";
    
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
                    <h1 class="page-title">📦 Quản lý Sản phẩm</h1>
                    <button class="btn btn-primary" onclick="openAddProductModal()">
                        ➕ Thêm sản phẩm
                    </button>
                </div>
                
                <!-- Breadcrumb -->
                <nav class="breadcrumb">
                    <div class="breadcrumb-item"><a href="<%= request.getContextPath() %>/admin/products">Dashboard</a></div>
                    <div class="breadcrumb-item active">Sản phẩm</div>
                </nav>
                
                <!-- Alert Messages -->
                <% if (message != null) { %>
                    <div class="alert alert-<%= "success".equals(messageType) ? "success" : "danger" %>">
                        <%= message %>
                        <button class="close" onclick="this.parentElement.style.display='none'">&times;</button>
                    </div>
                <% } %>
                
                <!-- Products Table Card -->
                <div class="card">
                    <div class="card-header">
                        <span style="font-size: 1.5rem;">📊</span>
                        <h2 class="card-title">Danh sách Sản phẩm</h2>
                    </div>
                    <div class="card-body">
                        <div class="table-responsive">
                            <table id="productsTable" class="table">
                                <thead>
                                    <tr>
                                        <th>ID</th>
                                        <th>Hình ảnh</th>
                                        <th>Tên sản phẩm</th>
                                        <th>Giá (₫)</th>
                                        <th>Danh mục</th>
                                        <th>Mô tả</th>
                                        <th>Thao tác</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <% if (products != null && !products.isEmpty()) { %>
                                        <% for (Product product : products) { %>
                                            <tr>
                                                <td><strong>#<%= product.getId() %></strong></td>
                                                <td>
                                                    <% if (product.getImage() != null && !product.getImage().isEmpty() && !product.getImage().equals("null")) { %>
                                                        <img src="<%= product.getImage() %>" alt="<%= product.getName() %>" class="product-image" onerror="this.style.display='none'; this.nextElementSibling.style.display='flex';">
                                                        <div class="product-image-placeholder" style="display: none;">📱</div>
                                                    <% } else { %>
                                                        <div class="product-image-placeholder">📱</div>
                                                    <% } %>
                                                </td>
                                                <td><strong><%= product.getName() %></strong></td>
                                                <td data-order="<%= product.getPrice() %>"><strong><%= String.format("%,.0f", product.getPrice()) %> ₫</strong></td>
                                                <td>
                                                    <% if (product.getCategory() != null && !product.getCategory().isEmpty()) { %>
                                                        <span class="badge badge-info"><%= product.getCategory() %></span>
                                                    <% } else { %>
                                                        <span class="badge badge-secondary">N/A</span>
                                                    <% } %>
                                                </td>
                                                <td><%= product.getDescription() != null ? (product.getDescription().length() > 50 ? product.getDescription().substring(0, 50) + "..." : product.getDescription()) : "" %></td>
                                                <td>
                                                    <div class="btn-group">
                                                        <button class="btn btn-info btn-sm" onclick="openEditProductModal(<%= product.getId() %>, '<%= product.getName().replaceAll("'", "\\\\'") %>', <%= product.getPrice() %>, '<%= product.getDescription() != null ? product.getDescription().replaceAll("'", "\\\\'").replaceAll("\n", " ").replaceAll("\r", "") : "" %>', '<%= product.getImage() != null ? product.getImage().replaceAll("'", "\\\\'") : "" %>', '<%= product.getCategory() != null ? product.getCategory().replaceAll("'", "\\\\'") : "" %>')" title="Sửa">
                                                            ✏️
                                                        </button>
                                                        <button class="btn btn-danger btn-sm" onclick="deleteProduct(<%= product.getId() %>, '<%= product.getName().replaceAll("'", "\\\\'") %>')" title="Xóa">
                                                            🗑️
                                                        </button>
                                                    </div>
                                                </td>
                                            </tr>
                                        <% } %>
                                    <% } else { %>
                                        <tr>
                                            <td colspan="7" style="text-align: center; padding: 3rem; color: #94a3b8;">
                                                <div style="font-size: 3rem; margin-bottom: 1rem;">📦</div>
                                                <p style="font-size: 1.125rem; font-weight: 600; margin: 0;">Chưa có sản phẩm nào</p>
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
    
    <!-- Add Product Modal -->
    <div id="addProductModal" class="modal">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">➕ Thêm sản phẩm mới</h5>
                    <button class="close" onclick="closeModal('addProductModal')">&times;</button>
                </div>
                <form action="<%= request.getContextPath() %>/admin/products/add" method="post">
                    <div class="modal-body">
                        <div class="form-group">
                            <label class="form-label" for="name">Tên sản phẩm *</label>
                            <input type="text" class="form-control" id="name" name="name" required placeholder="Nhập tên sản phẩm">
                        </div>
                        <div class="form-group">
                            <label class="form-label" for="price">Giá sản phẩm (₫) *</label>
                            <input type="number" class="form-control" id="price" name="price" step="1000" min="0" required placeholder="0">
                        </div>
                        <div class="form-group">
                            <label class="form-label" for="category">Danh mục *</label>
                            <select class="form-control" id="category" name="category" required>
                                <option value="">-- Chọn danh mục --</option>
                                <option value="Apple">Apple</option>
                                <option value="Samsung">Samsung</option>
                                <option value="Oppo">Oppo</option>
                                <option value="Xiaomi">Xiaomi</option>
                                <option value="Vivo">Vivo</option>
                                <option value="OnePlus">OnePlus</option>
                                <option value="Google">Google</option>
                            </select>
                        </div>
                        <div class="form-group">
                            <label class="form-label" for="description">Mô tả</label>
                            <textarea class="form-control" id="description" name="description" rows="3" placeholder="Nhập mô tả sản phẩm"></textarea>
                        </div>
                        <div class="form-group">
                            <label class="form-label" for="image">URL Hình ảnh</label>
                            <input type="url" class="form-control" id="image" name="image" placeholder="https://...">
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" onclick="closeModal('addProductModal')">Hủy</button>
                        <button type="submit" class="btn btn-primary">Thêm sản phẩm</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
    
    <!-- Edit Product Modal -->
    <div id="editProductModal" class="modal">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">✏️ Sửa thông tin sản phẩm</h5>
                    <button class="close" onclick="closeModal('editProductModal')">&times;</button>
                </div>
                <form action="<%= request.getContextPath() %>/admin/products/update" method="post">
                    <input type="hidden" id="editProductId" name="productId">
                    <div class="modal-body">
                        <div class="form-group">
                            <label class="form-label" for="editName">Tên sản phẩm *</label>
                            <input type="text" class="form-control" id="editName" name="name" required>
                        </div>
                        <div class="form-group">
                            <label class="form-label" for="editPrice">Giá sản phẩm (₫) *</label>
                            <input type="number" class="form-control" id="editPrice" name="price" step="1000" min="0" required>
                        </div>
                        <div class="form-group">
                            <label class="form-label" for="editCategory">Danh mục *</label>
                            <select class="form-control" id="editCategory" name="category" required>
                                <option value="">-- Chọn danh mục --</option>
                                <option value="Apple">Apple</option>
                                <option value="Samsung">Samsung</option>
                                <option value="Oppo">Oppo</option>
                                <option value="Xiaomi">Xiaomi</option>
                                <option value="Vivo">Vivo</option>
                                <option value="OnePlus">OnePlus</option>
                                <option value="Google">Google</option>
                            </select>
                        </div>
                        <div class="form-group">
                            <label class="form-label" for="editDescription">Mô tả</label>
                            <textarea class="form-control" id="editDescription" name="description" rows="3"></textarea>
                        </div>
                        <div class="form-group">
                            <label class="form-label" for="editImage">URL Hình ảnh</label>
                            <input type="url" class="form-control" id="editImage" name="image" placeholder="https://...">
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" onclick="closeModal('editProductModal')">Hủy</button>
                        <button type="submit" class="btn btn-primary">Cập nhật</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
    
    <script>
        // Auto open edit modal if editProduct exists
        <% if (editProduct != null) { %>
            window.addEventListener('DOMContentLoaded', function() {
                openEditProductModal(
                    <%= editProduct.getId() %>, 
                    '<%= editProduct.getName().replaceAll("'", "\\\\'") %>', 
                    <%= editProduct.getPrice() %>, 
                    '<%= editProduct.getDescription() != null ? editProduct.getDescription().replaceAll("'", "\\\\'").replaceAll("\n", " ").replaceAll("\r", "") : "" %>', 
                    '<%= editProduct.getImage() != null ? editProduct.getImage().replaceAll("'", "\\\\'") : "" %>',
                    '<%= editProduct.getCategory() != null ? editProduct.getCategory().replaceAll("'", "\\\\'") : "" %>'
                );
            });
        <% } %>
        
        // Initialize DataTables with improved search and pagination
        $(document).ready(function() {
            var table = $('#productsTable').DataTable({
                "language": {
                    "lengthMenu": "Hiển thị _MENU_ sản phẩm",
                    "zeroRecords": "Không tìm thấy sản phẩm nào",
                    "info": "Hiển thị _START_ đến _END_ của _TOTAL_ sản phẩm",
                    "infoEmpty": "Không có dữ liệu",
                    "infoFiltered": "(lọc từ _MAX_ sản phẩm)",
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
                    "searchPlaceholder": "Tìm kiếm sản phẩm..."
                },
                "pageLength": 10,
                "lengthMenu": [[10, 25, 50, 100, -1], [10, 25, 50, 100, "Tất cả"]],
                "order": [[ 0, "desc" ]],
                "columnDefs": [
                    { "orderable": false, "targets": [1, 6] },
                    { "type": "num", "targets": [0, 3] }
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
        function openAddProductModal() {
            openModal('addProductModal');
        }
        
        function openEditProductModal(id, name, price, description, image, category) {
            document.getElementById('editProductId').value = id;
            document.getElementById('editName').value = name;
            document.getElementById('editPrice').value = price;
            document.getElementById('editDescription').value = description || '';
            document.getElementById('editImage').value = image || '';
            if (category) {
                document.getElementById('editCategory').value = category;
            }
            openModal('editProductModal');
        }
        
        function deleteProduct(productId, productName) {
            if (confirm('Bạn có chắc muốn xóa sản phẩm "' + productName + '"?')) {
                window.location.href = '<%= request.getContextPath() %>/admin/products/delete?id=' + productId;
            }
        }
    </script>
    
<jsp:include page="/admin/layout/footer.jsp" />
