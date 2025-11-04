# Phone Shop Web Application

## 📱 Overview
A complete Phone Shop Web Application built with **Java JSP + Servlet + JDBC + MySQL** following MVC architecture.

## 🏗️ Project Structure

```
src/
├── model/          # Model classes (User, Product, Category, Order, OrderItem, Promotion)
├── dao/            # DAO interfaces
├── dao/impl/       # DAO implementations
├── service/        # Service interfaces
├── service/impl/   # Service implementations
├── controller/     # Servlet controllers
│   └── admin/      # Admin controllers
└── util/           # Utility classes (DBConnection, PasswordHash)

web/
├── WEB-INF/
│   ├── view/
│   │   ├── public/     # Public JSP pages
│   │   └── admin/      # Admin JSP pages
│   └── web.xml         # Web configuration
└── assets/
    ├── css/            # CSS files
    ├── js/             # JavaScript files
    └── img/            # Images
```

## 🚀 Features

### Customer Side (Public)
- ✅ **Home** - Banner, best sellers, promotions
- ✅ **Products** - List all phones with filter by brand, price range
- ✅ **Product Detail** - Full specs, price, stock
- ✅ **Cart** - Add/update/remove items
- ✅ **Checkout** - Place order (COD or online payment)
- ✅ **Login/Register** - User authentication
- ✅ **Profile** - View and update user info
- ✅ **Order History** - View order list and status

### Admin Side
- ✅ **Dashboard** - Total products, orders, revenue charts
- ✅ **Product Management** - CRUD phones
- ✅ **Category Management** - CRUD categories
- ✅ **Order Management** - View/update order status
- ✅ **Customer Management** - View all users
- ✅ **Promotion Management** - CRUD promotions
- ✅ **Statistics** - Revenue by month, top-selling products

## 🗄️ Database

### Tables
- `users` - User accounts (CUSTOMER, ADMIN)
- `categories` - Product categories
- `products` - Phone products
- `orders` - Customer orders
- `order_items` - Order details
- `promotions` - Discount codes

### Setup
1. Create MySQL database:
   ```sql
   source phoneshop.sql
   ```

2. Update database connection in `src/util/DBConnection.java`:
   ```java
   private static final String DB_URL = "jdbc:mysql://localhost:3306/phoneshop?useSSL=false&serverTimezone=UTC&characterEncoding=UTF-8";
   private static final String DB_USER = "root";
   private static final String DB_PASSWORD = "";
   ```

## 🔐 Default Login Credentials

**Admin:**
- Email: `admin@phoneshop.vn`
- Password: `123456`

**Customer:**
- Email: `user1@example.com`
- Password: `123456`

## 🛠️ Technologies

- **Backend:** Java JSP, Servlet, JDBC
- **Database:** MySQL
- **Frontend:** Bootstrap 5, JSTL, EL
- **Charts:** Chart.js
- **Architecture:** MVC Pattern

## 📦 Dependencies

Required JAR files (add to `WEB-INF/lib/`):
- `mysql-connector-java-8.0.xx.jar` - MySQL JDBC Driver
- JSTL libraries (jakarta.servlet.jsp.jstl-*.jar)
- Jakarta Servlet API

## 🚀 Running the Application

1. **Setup Database:**
   - Import `phoneshop.sql` to MySQL
   - Update connection in `DBConnection.java`

2. **Build Project:**
   - Open in NetBeans/Eclipse
   - Build project

3. **Deploy to Tomcat:**
   - Deploy to Tomcat server
   - Start Tomcat
   - Access: `http://localhost:8080/PhoneShop`

## 📝 Notes

- Password hashing: SHA-256
- Session management for cart and authentication
- Input validation on forms
- Error handling and user feedback
- Responsive design with Bootstrap

## 👨‍💻 Development

This project follows MVC architecture:
- **Model:** Data classes (User, Product, etc.)
- **View:** JSP pages
- **Controller:** Servlet classes
- **DAO:** Data Access Objects
- **Service:** Business logic layer

## 📄 License

This is a educational project for learning Java web development.

---

**Created by:** Senior Full-Stack Developer
**Date:** 2024

