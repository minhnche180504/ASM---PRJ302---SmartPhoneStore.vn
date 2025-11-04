-- =============================================
-- PHONEShop Database for SQL Server (FULL SCRIPT)
-- Compatible with Microsoft SQL Server (SSMS)
-- =============================================

USE master;
GO

-- Nếu database đang được sử dụng, rollback & drop nó
IF DB_ID('phoneshop') IS NOT NULL
BEGIN
    ALTER DATABASE phoneshop SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE phoneshop;
END;
GO

-- Tạo mới database
CREATE DATABASE phoneshop;
GO
USE phoneshop;
GO

-- =============================================
-- Table: users
-- =============================================
CREATE TABLE users (
    user_id INT IDENTITY(1,1) PRIMARY KEY,
    name NVARCHAR(100) NOT NULL,
    email NVARCHAR(100) NOT NULL UNIQUE,
    password NVARCHAR(255) NOT NULL,
    phone NVARCHAR(20),
    address NVARCHAR(500),
    role NVARCHAR(20) DEFAULT 'CUSTOMER', -- CUSTOMER, ADMIN
    created_at DATETIME DEFAULT GETDATE(),
    updated_at DATETIME DEFAULT GETDATE()
);
GO

-- =============================================
-- Table: categories
-- =============================================
CREATE TABLE categories (
    cat_id INT IDENTITY(1,1) PRIMARY KEY,
    cat_name NVARCHAR(100) NOT NULL UNIQUE,
    description NVARCHAR(500),
    created_at DATETIME DEFAULT GETDATE(),
    updated_at DATETIME DEFAULT GETDATE()
);
GO

-- =============================================
-- Table: products
-- =============================================
CREATE TABLE products (
    p_id INT IDENTITY(1,1) PRIMARY KEY,
    p_name NVARCHAR(200) NOT NULL,
    brand NVARCHAR(100) NOT NULL,
    price DECIMAL(15,2) NOT NULL,
    stock INT DEFAULT 0,
    description NVARCHAR(MAX),
    image_url NVARCHAR(500),
    cat_id INT NOT NULL,
    created_at DATETIME DEFAULT GETDATE(),
    updated_at DATETIME DEFAULT GETDATE(),
    CONSTRAINT FK_products_categories FOREIGN KEY (cat_id) REFERENCES categories(cat_id) ON DELETE CASCADE
);
GO

-- =============================================
-- Table: orders
-- =============================================
CREATE TABLE orders (
    order_id INT IDENTITY(1,1) PRIMARY KEY,
    user_id INT NOT NULL,
    total_amount DECIMAL(15,2) NOT NULL,
    order_date DATETIME DEFAULT GETDATE(),
    status NVARCHAR(50) DEFAULT 'PENDING', -- PENDING, CONFIRMED, SHIPPING, DELIVERED, CANCELLED
    payment_method NVARCHAR(50) DEFAULT 'COD', -- COD, ONLINE
    shipping_name NVARCHAR(100),
    shipping_phone NVARCHAR(20),
    shipping_address NVARCHAR(500),
    updated_at DATETIME DEFAULT GETDATE(),
    CONSTRAINT FK_orders_users FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE
);
GO

-- =============================================
-- Table: order_items
-- =============================================
CREATE TABLE order_items (
    item_id INT IDENTITY(1,1) PRIMARY KEY,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    price DECIMAL(15,2) NOT NULL,
    subtotal AS (quantity * price) PERSISTED, -- Tính tự động subtotal
    created_at DATETIME DEFAULT GETDATE(),
    CONSTRAINT FK_order_items_orders FOREIGN KEY (order_id) REFERENCES orders(order_id) ON DELETE CASCADE,
    CONSTRAINT FK_order_items_products FOREIGN KEY (product_id) REFERENCES products(p_id) ON DELETE CASCADE
);
GO

-- =============================================
-- Table: promotions
-- =============================================
CREATE TABLE promotions (
    promo_id INT IDENTITY(1,1) PRIMARY KEY,
    promo_code NVARCHAR(50) NOT NULL UNIQUE,
    discount_percent DECIMAL(5,2) NOT NULL, -- Percentage discount (0-100)
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    description NVARCHAR(500),
    is_active BIT DEFAULT 1,
    created_at DATETIME DEFAULT GETDATE(),
    updated_at DATETIME DEFAULT GETDATE()
);
GO

-- =============================================
-- Sample Data: Categories
-- =============================================
INSERT INTO categories (cat_name, description) VALUES
(N'Apple', N'iPhone, iPad, MacBook và các sản phẩm Apple'),
(N'Samsung', N'Galaxy series và các thiết bị Samsung'),
(N'Xiaomi', N'Điện thoại và thiết bị Xiaomi'),
(N'OPPO', N'Điện thoại OPPO và OnePlus'),
(N'Vivo', N'Điện thoại Vivo'),
(N'Accessories', N'Phụ kiện điện thoại: ốp lưng, tai nghe, sạc...');
GO

-- =============================================
-- Sample Data: Users (Password SHA256 of 123456)
-- =============================================
INSERT INTO users (name, email, password, phone, address, role) VALUES
(N'Administrator', N'admin@phoneshop.vn', N'8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', N'0901234567', N'123 Admin Street, Ho Chi Minh City', N'ADMIN'),
(N'Nguyễn Văn A', N'user1@example.com', N'8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', N'0907654321', N'456 Customer Street, Ho Chi Minh City', N'CUSTOMER'),
(N'Trần Thị B', N'user2@example.com', N'8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', N'0912345678', N'789 User Street, Hanoi', N'CUSTOMER');
GO

-- =============================================
-- Sample Data: Products
-- =============================================
INSERT INTO products (p_name, brand, price, stock, description, image_url, cat_id) VALUES
(N'iPhone 15 Pro Max', N'Apple', 34990000, 50, N'Màn hình 6.7 inch, Chip A17 Pro, Camera 48MP, Pin 4441mAh', N'/assets/img/iphone15pro.jpg', 1),
(N'iPhone 15 Pro', N'Apple', 29990000, 45, N'Màn hình 6.1 inch, Chip A17 Pro, Camera 48MP, Pin 3274mAh', N'/assets/img/iphone15.jpg', 1),
(N'iPhone 14 Pro', N'Apple', 27990000, 30, N'Màn hình 6.1 inch, Chip A16 Bionic, Camera 48MP', N'/assets/img/iphone14pro.jpg', 1),
(N'Samsung Galaxy S24 Ultra', N'Samsung', 29990000, 40, N'Màn hình 6.8 inch Dynamic AMOLED, S Pen, Camera 200MP', N'/assets/img/s24ultra.jpg', 2),
(N'Samsung Galaxy S23', N'Samsung', 19990000, 35, N'Màn hình 6.1 inch, Snapdragon 8 Gen 2, Camera 50MP', N'/assets/img/s23.jpg', 2),
(N'Xiaomi 14 Pro', N'Xiaomi', 18990000, 25, N'Màn hình 6.73 inch, Snapdragon 8 Gen 3, Camera Leica 50MP', N'/assets/img/xiaomi14pro.jpg', 3),
(N'Xiaomi Redmi Note 13', N'Xiaomi', 6990000, 60, N'Màn hình 6.67 inch, Camera 108MP, Pin 5000mAh', N'/assets/img/redminote13.jpg', 3),
(N'OPPO Find X7', N'OPPO', 17990000, 20, N'Màn hình 6.78 inch, Snapdragon 8 Gen 3, Camera 50MP', N'/assets/img/oppofindx7.jpg', 4),
(N'Vivo X100 Pro', N'Vivo', 22990000, 15, N'Màn hình 6.78 inch, Dimensity 9300, Camera 50MP', N'/assets/img/vivox100.jpg', 5),
(N'AirPods Pro 2', N'Apple', 6990000, 100, N'Tai nghe không dây với chống ồn chủ động, Spatial Audio', N'/assets/img/airpodspro.jpg', 6),
(N'Samsung Galaxy Buds2 Pro', N'Samsung', 4990000, 80, N'Tai nghe True Wireless với chống ồn chủ động', N'/assets/img/galaxybuds.jpg', 6),
(N'Sạc nhanh 20W', N'Apple', 990000, 150, N'Bộ sạc nhanh 20W USB-C Power Adapter', N'/assets/img/charger.jpg', 6);
GO

-- =============================================
-- Sample Data: Promotions
-- =============================================
INSERT INTO promotions (promo_code, discount_percent, start_date, end_date, description, is_active) VALUES
(N'WELCOME10', 10.00, '2024-01-01', '2024-12-31', N'Giảm 10% cho khách hàng mới', 1),
(N'SALE20', 20.00, '2024-01-01', '2024-12-31', N'Giảm 20% cho đơn hàng trên 10 triệu', 1),
(N'VIP30', 30.00, '2024-01-01', '2024-12-31', N'Giảm 30% cho khách hàng VIP', 1),
(N'BLACKFRIDAY', 25.00, '2024-11-01', '2024-11-30', N'Khuyến mãi Black Friday', 1);
GO

-- =============================================
-- Sample Data: Orders
-- =============================================
INSERT INTO orders (user_id, total_amount, status, payment_method, shipping_name, shipping_phone, shipping_address) VALUES
(2, 34990000, N'DELIVERED', N'COD', N'Nguyễn Văn A', N'0907654321', N'456 Customer Street, Ho Chi Minh City'),
(2, 6990000, N'SHIPPING', N'ONLINE', N'Nguyễn Văn A', N'0907654321', N'456 Customer Street, Ho Chi Minh City'),
(3, 29990000, N'CONFIRMED', N'COD', N'Trần Thị B', N'0912345678', N'789 User Street, Hanoi');
GO

-- =============================================
-- Sample Data: Order Items
-- =============================================
INSERT INTO order_items (order_id, product_id, quantity, price) VALUES
(1, 1, 1, 34990000),
(2, 10, 1, 6990000),
(3, 4, 1, 29990000);
GO

-- =============================================
-- Confirmation
-- =============================================
SELECT N'✅ Database phoneshop created successfully and populated with sample data!' AS Message;
GO
select *from users