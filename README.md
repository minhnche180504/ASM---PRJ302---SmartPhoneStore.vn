# SmartPhoneStore Database

## Mô tả
Script SQL để tạo database cho ứng dụng SmartPhoneStore - Hệ thống bán điện thoại thông minh.

## Cấu trúc Database

### Bảng `users`
- Lưu thông tin người dùng (khách hàng và admin)
- Trường: id, username, password, email, full_name, phone, address, role, created_at, updated_at
- Role: USER, ADMIN

### Bảng `products`
- Lưu thông tin sản phẩm (điện thoại)
- Trường: id, name, price, description, image, category, created_at, updated_at

### Bảng `orders`
- Lưu thông tin đơn hàng
- Trường: id, user_id, user_name, total, status, customer_name, customer_phone, customer_address, order_date, updated_at
- Status: Pending, Completed, Cancelled

### Bảng `order_items`
- Lưu chi tiết sản phẩm trong mỗi đơn hàng
- Trường: id, order_id, product_id, product_name, price, quantity, subtotal

## Cách sử dụng

### 1. Tạo Database mới (Nếu chưa có)

Mở SQL Server Management Studio (SSMS) hoặc Azure Data Studio và chạy:

```sql
-- Tạo database mới
CREATE DATABASE SmartPhoneStore;
GO

USE SmartPhoneStore;
GO
```

### 2. Chạy Script SQL

**Cách 1: Sử dụng SSMS**
1. Mở file `SmartPhoneStore.sql`
2. Kết nối đến SQL Server của bạn
3. Chọn database `SmartPhoneStore` (hoặc tạo mới)
4. Chạy toàn bộ script (F5)

**Cách 2: Sử dụng Command Line**
```bash
sqlcmd -S localhost\MINDTHEMINH -U sa -P admin -d SmartPhoneStore -i SmartPhoneStore.sql
```

**Cách 3: Sử dụng Azure Data Studio**
1. Mở Azure Data Studio
2. Kết nối đến SQL Server
3. Mở file `SmartPhoneStore.sql`
4. Chạy script

### 3. Cấu hình Connection String

Kiểm tra file `src/java/dao/DBConnect.java` và đảm bảo connection string đúng:

```java
String url = "jdbc:sqlserver://localhost\\MINDTHEMINH:1433;databaseName=SmartPhoneStore;trustServerCertificate=true;";
String username = "sa";
String password = "admin";
```

## Tính năng

### Indexes
- Index trên các cột thường xuyên query để tối ưu hiệu suất
- Index trên username, email, role (users)
- Index trên name, category, price (products)
- Index trên user_id, status, order_date (orders)

### Triggers
- Tự động cập nhật `updated_at` khi có thay đổi dữ liệu
- Áp dụng cho: users, products, orders

### Views
- `vw_order_summary`: Tổng hợp thông tin đơn hàng với user
- `vw_top_products`: Sản phẩm bán chạy nhất

### Stored Procedures
- `sp_get_orders_by_user`: Lấy đơn hàng theo user_id
- `sp_get_order_details`: Lấy chi tiết đơn hàng
- `sp_search_products`: Tìm kiếm sản phẩm với nhiều điều kiện

## Dữ liệu mẫu

Script tự động insert:
- **3 users**: 1 admin, 2 users
  - Admin: username=`admin`, password=`admin123`
  - User1: username=`user1`, password=`user123`
  - User2: username=`user2`, password=`user123`

- **10 products**: Các điện thoại thông minh phổ biến
  - iPhone 15 Pro Max, Samsung Galaxy S24 Ultra, Xiaomi 14 Pro, etc.

## Lưu ý

1. **Bảo mật**: 
   - Trong môi trường production, nên hash password thay vì lưu plain text
   - Sử dụng prepared statements để tránh SQL injection

2. **Backup**:
   - Thường xuyên backup database
   - Script này sẽ xóa các bảng cũ nếu tồn tại (có thể comment phần DROP TABLE nếu muốn giữ dữ liệu cũ)

3. **Foreign Keys**:
   - `orders.user_id` → `users.id` (CASCADE DELETE)
   - `order_items.order_id` → `orders.id` (CASCADE DELETE)
   - `order_items.product_id` → `products.id` (NO ACTION)

4. **Constraints**:
   - Username phải unique
   - Price và total phải >= 0
   - Quantity phải > 0
   - Role chỉ nhận giá trị: USER, ADMIN
   - Status chỉ nhận giá trị: Pending, Completed, Cancelled

## Troubleshooting

### Lỗi kết nối
- Kiểm tra SQL Server đã khởi động chưa
- Kiểm tra connection string trong DBConnect.java
- Kiểm tra firewall và port 1433

### Lỗi permissions
- Đảm bảo user có quyền CREATE TABLE, CREATE INDEX, CREATE TRIGGER
- Đảm bảo user có quyền INSERT, UPDATE, DELETE, SELECT

### Lỗi foreign key
- Kiểm tra thứ tự xóa bảng (xóa order_items trước, sau đó orders, products, users)
- Kiểm tra dữ liệu có vi phạm foreign key constraint không

## Liên hệ

Nếu có vấn đề, vui lòng kiểm tra:
1. SQL Server version (nên dùng SQL Server 2016 trở lên)
2. JDBC driver version (kiểm tra trong WEB-INF/lib)
3. Connection string format

