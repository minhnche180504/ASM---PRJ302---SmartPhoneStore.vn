-- =====================================================
-- SmartPhoneStore Database Script
-- Database: SmartPhoneStore
-- Server: SQL Server
-- =====================================================

-- Kiểm tra và xóa database cũ (nếu cần)
-- USE master;
-- GO
-- IF EXISTS (SELECT name FROM sys.databases WHERE name = 'SmartPhoneStore')
--     DROP DATABASE SmartPhoneStore;
-- GO
-- CREATE DATABASE SmartPhoneStore;
-- GO

USE SmartPhoneStore;
GO

-- =====================================================
-- 1. XÓA CÁC BẢNG CŨ (NẾU CÓ)
-- =====================================================
IF OBJECT_ID('order_items', 'U') IS NOT NULL
    DROP TABLE order_items;
GO

IF OBJECT_ID('orders', 'U') IS NOT NULL
    DROP TABLE orders;
GO

IF OBJECT_ID('products', 'U') IS NOT NULL
    DROP TABLE products;
GO

IF OBJECT_ID('users', 'U') IS NOT NULL
    DROP TABLE users;
GO

-- =====================================================
-- 2. TẠO BẢNG USERS
-- =====================================================
CREATE TABLE users (
    id INT PRIMARY KEY IDENTITY(1,1),
    username NVARCHAR(50) NOT NULL UNIQUE,
    password NVARCHAR(255) NOT NULL,
    email NVARCHAR(100) NOT NULL,
    full_name NVARCHAR(100),
    phone NVARCHAR(20),
    address NVARCHAR(255),
    role NVARCHAR(20) DEFAULT 'USER' CHECK (role IN ('USER', 'ADMIN')),
    created_at DATETIME DEFAULT GETDATE(),
    updated_at DATETIME DEFAULT GETDATE()
);
GO

-- =====================================================
-- 3. TẠO BẢNG PRODUCTS
-- =====================================================
CREATE TABLE products (
    id INT PRIMARY KEY IDENTITY(1,1),
    name NVARCHAR(255) NOT NULL,
    price DECIMAL(18,2) NOT NULL CHECK (price >= 0),
    description NVARCHAR(MAX),
    image NVARCHAR(255),
    category NVARCHAR(100),
    created_at DATETIME DEFAULT GETDATE(),
    updated_at DATETIME DEFAULT GETDATE()
);
GO

-- =====================================================
-- 4. TẠO BẢNG ORDERS
-- =====================================================
CREATE TABLE orders (
    id INT PRIMARY KEY IDENTITY(1,1),
    user_id INT NOT NULL,
    user_name NVARCHAR(50),
    total DECIMAL(18,2) NOT NULL CHECK (total >= 0),
    status NVARCHAR(20) DEFAULT 'Pending' CHECK (status IN ('Pending', 'Completed', 'Cancelled')),
    customer_name NVARCHAR(100) NOT NULL,
    customer_phone NVARCHAR(20) NOT NULL,
    customer_address NVARCHAR(255) NOT NULL,
    order_date DATETIME DEFAULT GETDATE(),
    updated_at DATETIME DEFAULT GETDATE(),
    CONSTRAINT FK_orders_users FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);
GO

-- =====================================================
-- 5. TẠO BẢNG ORDER_ITEMS
-- =====================================================
CREATE TABLE order_items (
    id INT PRIMARY KEY IDENTITY(1,1),
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    product_name NVARCHAR(255) NOT NULL,
    price DECIMAL(18,2) NOT NULL CHECK (price >= 0),
    quantity INT NOT NULL CHECK (quantity > 0),
    subtotal DECIMAL(18,2) NOT NULL CHECK (subtotal >= 0),
    CONSTRAINT FK_order_items_orders FOREIGN KEY (order_id) REFERENCES orders(id) ON DELETE CASCADE,
    CONSTRAINT FK_order_items_products FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE NO ACTION
);
GO

-- =====================================================
-- 6. TẠO INDEX ĐỂ TỐI ƯU HIỆU SUẤT
-- =====================================================

-- Index cho bảng users
CREATE INDEX IX_users_username ON users(username);
CREATE INDEX IX_users_email ON users(email);
CREATE INDEX IX_users_role ON users(role);

-- Index cho bảng products
CREATE INDEX IX_products_name ON products(name);
CREATE INDEX IX_products_category ON products(category);
CREATE INDEX IX_products_price ON products(price);

-- Index cho bảng orders
CREATE INDEX IX_orders_user_id ON orders(user_id);
CREATE INDEX IX_orders_status ON orders(status);
CREATE INDEX IX_orders_order_date ON orders(order_date);

-- Index cho bảng order_items
CREATE INDEX IX_order_items_order_id ON order_items(order_id);
CREATE INDEX IX_order_items_product_id ON order_items(product_id);
GO

-- =====================================================
-- 7. INSERT DỮ LIỆU MẪU
-- =====================================================

-- Insert Admin User
INSERT INTO users (username, password, email, full_name, phone, address, role)
VALUES 
    ('admin', 'admin123', 'admin@smartphonestore.com', 'Administrator', '0123456789', '123 Admin Street', 'ADMIN'),
    ('user1', 'user123', 'user1@example.com', 'Nguyễn Văn A', '0987654321', '456 User Street', 'USER'),
    ('user2', 'user123', 'user2@example.com', 'Trần Thị B', '0912345678', '789 User Avenue', 'USER');
GO
ALTER TABLE products
ALTER COLUMN image NVARCHAR(1000);

-- Insert Sample Products
INSERT INTO products (name, price, description, image, category)
VALUES 
    ('iPhone 15 Pro Max', 28990000, 'iPhone 15 Pro Max 256GB - Flagship smartphone từ Apple với chip A17 Pro, camera 48MP', 'https://qkm.vn/wp-content/uploads/2024/07/iphone-15-pro-128gb-256gb-512gb-1tb-cu-like-new-99-qkm-1.jpg', 'iPhone'),
    ('Samsung Galaxy S24 Ultra', 24990000, 'Samsung Galaxy S24 Ultra 256GB - Điện thoại Android flagship với bút S Pen', 'https://bizweb.dktcdn.net/100/519/696/products/vn-galaxy-s24-s928-sm-s928bzvcxxv-thumb-539307668-3db53571-d43c-467a-a91d-9783c0f04f67.png?v=1733327651880', 'Samsung'),
    ('Xiaomi 14 Pro', 19990000, 'Xiaomi 14 Pro 256GB - Flagship với camera Leica, chip Snapdragon 8 Gen 3', 'https://cdn.mobilecity.vn/mobilecity-vn/images/2023/10/xiaomi-14-pro-xanh.jpg', 'Xiaomi'),
    ('OPPO Find X7 Ultra', 22990000, 'OPPO Find X7 Ultra 256GB - Flagship với camera Hasselblad, màn hình 2K', 'https://cellphones.com.vn/sforum/wp-content/uploads/2024/01/OPPO-Find-X7-Ultra-ra-mat-1.jpeg', 'OPPO'),
    ('Vivo X100 Pro', 21990000, 'Vivo X100 Pro 256GB - Flagship với camera Zeiss, chip MediaTek Dimensity 9300', 'https://didongthongminh.vn/images/products/2025/03/23/original/1(3).jpg', 'Vivo'),
    ('OnePlus 12', 18990000, 'OnePlus 12 256GB - Flagship với màn hình 2K, sạc nhanh 100W', 'https://kimmobile.com/data/products/blz1710318063.jpg', 'OnePlus'),
    ('Google Pixel 8 Pro', 23990000, 'Google Pixel 8 Pro 256GB - Flagship với camera AI, Android thuần', 'https://kimmobile.com/data/products/blz1710318063.jpg', 'Google'),
    ('iPhone 14 Pro', 22990000, 'iPhone 14 Pro 256GB - iPhone flagship với Dynamic Island, chip A16 Bionic', 'https://cdsassets.apple.com/live/SZLF0YNV/images/sp/111846_sp875-sp876-iphone14-pro-promax.png', 'iPhone'),
    ('Samsung Galaxy S23 Ultra', 19990000, 'Samsung Galaxy S23 Ultra 256GB - Flagship với camera 200MP, bút S Pen', 'https://www.samsungmobilepress.com/file/721EF47FE4CB8C34BF2593D1CD9862F99DB28A510A7C2EF828FEC952DC7D28D2753EF64D5C3C3A2AFBDDF06906DBEE3B8427130C41AC38A26BEF14D494AF0CEDC2502F5114608B0220493DC7C0B2A3D73B5604EE3B3BFDF6FA98BE3A27845EB839D848EC18069F3222E3A1DAE994749BBABC72BA7E77D47A196A0313ED1B310B526A2E2D2FBBF8B56C486E32AD128A55', 'Samsung'),
    ('Xiaomi 13 Pro', 17990000, 'Xiaomi 13 Pro 256GB - Flagship với camera Leica, chip Snapdragon 8 Gen 2', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTGssONfb9qiXMKQ7wCRIlbeiM2Vzm0YJBl8Q&s', 'Xiaomi');
GO

-- =====================================================
-- 8. TẠO TRIGGER ĐỂ TỰ ĐỘNG CẬP NHẬT updated_at
-- =====================================================

-- Trigger cho bảng users
CREATE TRIGGER trg_users_updated_at
ON users
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;
    UPDATE users
    SET updated_at = GETDATE()
    FROM users u
    INNER JOIN inserted i ON u.id = i.id;
END;
GO

-- Trigger cho bảng products
CREATE TRIGGER trg_products_updated_at
ON products
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;
    UPDATE products
    SET updated_at = GETDATE()
    FROM products p
    INNER JOIN inserted i ON p.id = i.id;
END;
GO

-- Trigger cho bảng orders
CREATE TRIGGER trg_orders_updated_at
ON orders
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;
    UPDATE orders
    SET updated_at = GETDATE()
    FROM orders o
    INNER JOIN inserted i ON o.id = i.id;
END;
GO

-- =====================================================
-- 9. TẠO VIEW ĐỂ XEM THỐNG KÊ
-- =====================================================

-- View tổng hợp đơn hàng với thông tin user
CREATE VIEW vw_order_summary AS
SELECT 
    o.id AS order_id,
    o.order_date,
    o.status,
    o.total,
    u.username,
    u.full_name AS user_full_name,
    o.customer_name,
    o.customer_phone,
    o.customer_address,
    COUNT(oi.id) AS item_count
FROM orders o
INNER JOIN users u ON o.user_id = u.id
LEFT JOIN order_items oi ON o.id = oi.order_id
GROUP BY o.id, o.order_date, o.status, o.total, u.username, u.full_name, 
         o.customer_name, o.customer_phone, o.customer_address;
GO

-- View sản phẩm bán chạy
CREATE VIEW vw_top_products AS
SELECT 
    p.id,
    p.name,
    p.price,
    p.category,
    SUM(oi.quantity) AS total_sold,
    SUM(oi.subtotal) AS total_revenue
FROM products p
INNER JOIN order_items oi ON p.id = oi.product_id
INNER JOIN orders o ON oi.order_id = o.id
WHERE o.status = 'Completed'
GROUP BY p.id, p.name, p.price, p.category
ORDER BY total_sold DESC;
GO

-- =====================================================
-- 10. STORED PROCEDURES
-- =====================================================

-- Stored Procedure: Lấy đơn hàng theo user_id
CREATE PROCEDURE sp_get_orders_by_user
    @user_id INT
AS
BEGIN
    SET NOCOUNT ON;
    SELECT 
        o.*,
        COUNT(oi.id) AS item_count
    FROM orders o
    LEFT JOIN order_items oi ON o.id = oi.order_id
    WHERE o.user_id = @user_id
    GROUP BY o.id, o.user_id, o.user_name, o.total, o.status, 
             o.customer_name, o.customer_phone, o.customer_address, 
             o.order_date, o.updated_at
    ORDER BY o.order_date DESC;
END;
GO

-- Stored Procedure: Lấy chi tiết đơn hàng
CREATE PROCEDURE sp_get_order_details
    @order_id INT
AS
BEGIN
    SET NOCOUNT ON;
    -- Thông tin đơn hàng
    SELECT * FROM orders WHERE id = @order_id;
    
    -- Chi tiết sản phẩm trong đơn hàng
    SELECT 
        oi.*,
        p.image,
        p.description
    FROM order_items oi
    INNER JOIN products p ON oi.product_id = p.id
    WHERE oi.order_id = @order_id;
END;
GO

-- Stored Procedure: Tìm kiếm sản phẩm
CREATE PROCEDURE sp_search_products
    @keyword NVARCHAR(255),
    @category NVARCHAR(100) = NULL,
    @min_price DECIMAL(18,2) = NULL,
    @max_price DECIMAL(18,2) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    SELECT * FROM products
    WHERE name LIKE '%' + @keyword + '%'
        AND (@category IS NULL OR category = @category)
        AND (@min_price IS NULL OR price >= @min_price)
        AND (@max_price IS NULL OR price <= @max_price)
    ORDER BY name;
END;
GO

-- =====================================================
-- 11. VERIFY DATABASE STRUCTURE
-- =====================================================
PRINT '========================================';
PRINT 'Database SmartPhoneStore created successfully!';
PRINT '========================================';
PRINT 'Tables created:';
PRINT '  - users';
PRINT '  - products';
PRINT '  - orders';
PRINT '  - order_items';
PRINT '';
PRINT 'Indexes created for performance optimization';
PRINT 'Triggers created for auto-update timestamps';
PRINT 'Views and stored procedures created';
PRINT '';
PRINT 'Sample data inserted:';
PRINT '  - 3 users (1 admin, 2 users)';
PRINT '  - 10 products';
PRINT '========================================';
GO

-- Kiểm tra số lượng bản ghi
SELECT 'users' AS table_name, COUNT(*) AS record_count FROM users
UNION ALL
SELECT 'products', COUNT(*) FROM products
UNION ALL
SELECT 'orders', COUNT(*) FROM orders
UNION ALL
SELECT 'order_items', COUNT(*) FROM order_items;
select *from users
select *from products
