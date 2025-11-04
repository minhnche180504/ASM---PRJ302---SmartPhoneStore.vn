
CREATE DATABASE SmartPhoneStore;
GO

USE SmartPhoneStore;
GO

select *from users
-- Bảng users
CREATE TABLE users (
    id INT IDENTITY(1,1) PRIMARY KEY,
    username NVARCHAR(50) NOT NULL UNIQUE,
    password NVARCHAR(255) NOT NULL,
    email NVARCHAR(100),
    full_name NVARCHAR(100),
    phone NVARCHAR(20),
    address NVARCHAR(500),
    role NVARCHAR(20) DEFAULT 'USER', -- USER, ADMIN
    created_at DATETIME DEFAULT GETDATE(),
    updated_at DATETIME DEFAULT GETDATE()
);

-- Bảng products
CREATE TABLE products (
    id INT IDENTITY(1,1) PRIMARY KEY,
    name NVARCHAR(200) NOT NULL,
    price DECIMAL(15,2) NOT NULL,
    description NTEXT,
    image NVARCHAR(500),
    category NVARCHAR(100),
    stock_quantity INT DEFAULT 0,
    created_at DATETIME DEFAULT GETDATE(),
    updated_at DATETIME DEFAULT GETDATE()
);

-- Bảng orders
CREATE TABLE orders (
    id INT IDENTITY(1,1) PRIMARY KEY,
    user_id INT,
    user_name NVARCHAR(100),
    total DECIMAL(15,2) NOT NULL,
    status NVARCHAR(50) DEFAULT 'Pending', -- Pending, Completed, Cancelled
    customer_name NVARCHAR(100),
    customer_phone NVARCHAR(20),
    customer_address NVARCHAR(500),
    order_date DATETIME DEFAULT GETDATE(),
    updated_at DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (user_id) REFERENCES users(id)
);

-- Bảng order_items (chi tiết đơn hàng)
CREATE TABLE order_items (
    id INT IDENTITY(1,1) PRIMARY KEY,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    product_name NVARCHAR(200),
    price DECIMAL(15,2) NOT NULL,
    quantity INT NOT NULL,
    subtotal DECIMAL(15,2) NOT NULL,
    created_at DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (order_id) REFERENCES orders(id),
    FOREIGN KEY (product_id) REFERENCES products(id)
);

-- Thêm dữ liệu mẫu cho users
INSERT INTO users (username, password, email, full_name, role) VALUES
('admin', '123456', 'admin@smartphonestore.vn', 'Administrator', 'ADMIN'),
('user1', '123456', 'user1@example.com', 'Nguyễn Văn A', 'USER'),
('user2', '123456', 'user2@example.com', 'Trần Thị B', 'USER');

-- Thêm dữ liệu mẫu cho products
INSERT INTO products (name, price, description, image, category, stock_quantity) VALUES
('iPhone 15 Pro', 34990000, 'Flagship mới nhất từ Apple với chip A17 Pro', '/images/iphone15pro.jpg', 'iPhone', 50),
('Samsung Galaxy S24 Ultra', 29990000, 'Camera siêu nét với S Pen tích hợp', '/images/s24ultra.jpg', 'Samsung', 30),
('iPad Pro M4', 25990000, 'Màn hình Liquid Retina XDR với chip M4', '/images/ipadpro.jpg', 'iPad', 20),
('MacBook Air M3', 28990000, 'Mỏng nhẹ, hiệu năng mạnh mẽ', '/images/macbookair.jpg', 'MacBook', 15),
('iPhone 14 Pro Max', 31990000, 'iPhone 14 Pro Max với Dynamic Island', '/images/iphone14promax.jpg', 'iPhone', 25),
('Galaxy Watch 6', 7990000, 'Smartwatch cao cấp từ Samsung', '/images/galaxywatch6.jpg', 'Watch', 40),
('AirPods Pro 2', 6990000, 'Tai nghe không dây với chống ồn chủ động', '/images/airpodspro2.jpg', 'Accessories', 60),
('iPad Air M2', 18990000, 'iPad Air với chip M2 mạnh mẽ', '/images/ipadair.jpg', 'iPad', 35);

-- Thêm dữ liệu mẫu cho orders
INSERT INTO orders (user_id, user_name, total, status, customer_name, customer_phone, customer_address) VALUES
(2, 'user1', 34990000, 'Completed', 'Nguyễn Văn A', '0901234567', '123 Đường ABC, Quận 1, TP.HCM'),
(3, 'user2', 29990000, 'Pending', 'Trần Thị B', '0907654321', '456 Đường XYZ, Quận 2, TP.HCM'),
(2, 'user1', 25990000, 'Cancelled', 'Nguyễn Văn A', '0901234567', '123 Đường ABC, Quận 1, TP.HCM');

-- Thêm dữ liệu mẫu cho order_items
INSERT INTO order_items (order_id, product_id, product_name, price, quantity, subtotal) VALUES
(1, 1, 'iPhone 15 Pro', 34990000, 1, 34990000),
(2, 2, 'Samsung Galaxy S24 Ultra', 29990000, 1, 29990000),
(3, 3, 'iPad Pro M4', 25990000, 1, 25990000);

-- Tạo index để tối ưu truy vấn
CREATE INDEX IX_users_username ON users(username);
CREATE INDEX IX_products_category ON products(category);
CREATE INDEX IX_orders_user_id ON orders(user_id);
CREATE INDEX IX_orders_status ON orders(status);
CREATE INDEX IX_order_items_order_id ON order_items(order_id);

-- Hiển thị thông báo hoàn thành
PRINT 'Database SmartPhoneStore đã được tạo thành công!';
PRINT 'Đã thêm dữ liệu mẫu cho users, products, orders và order_items.';
PRINT '';
PRINT 'Thông tin đăng nhập mẫu:';
PRINT 'Admin: username=admin, password=123456';
PRINT 'User: username=user1, password=123456';
PRINT 'User: username=user2, password=123456';
