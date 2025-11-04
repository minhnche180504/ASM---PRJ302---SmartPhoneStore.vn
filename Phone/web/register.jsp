<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Đăng ký tài khoản - SmartPhoneStore.vn</title>
    <style>
        body {
            font-family: 'Segoe UI', Arial, sans-serif;
            background: #f4f6fb;
            margin: 0;
            padding: 0;
        }
        .register-container {
            max-width: 400px;
            margin: 48px auto 0 auto;
            background: #fff;
            border-radius: 8px;
            box-shadow: 0 2px 16px rgba(0,0,0,0.08);
            padding: 32px 28px 28px 28px;
        }
        .register-title {
            font-size: 2rem;
            font-weight: 600;
            text-align: center;
            margin-bottom: 24px;
            color: #222;
        }
        .register-form label {
            display: block;
            margin-bottom: 6px;
            font-weight: 500;
            color: #333;
        }
        .register-form input[type="text"],
        .register-form input[type="password"] {
            width: 100%;
            padding: 10px 12px;
            margin-bottom: 18px;
            border: 1px solid #d1d5db;
            border-radius: 4px;
            font-size: 1rem;
            background: #f8fafc;
            transition: border 0.2s;
            box-sizing: border-box;
        }
        .register-form input:focus {
            border: 1.5px solid #007bff;
            outline: none;
            background: #fff;
        }
        .register-form button {
            width: 100%;
            padding: 12px 0;
            background: #007bff;
            color: #fff;
            font-size: 1.1rem;
            font-weight: 600;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            margin-top: 8px;
            transition: background 0.2s;
        }
        .register-form button:hover {
            background: #0056b3;
        }
        .register-links {
            margin-top: 18px;
            text-align: center;
        }
        .register-links a {
            color: #007bff;
            text-decoration: none;
            margin: 0 8px;
            font-size: 1rem;
        }
        .register-links a:hover {
            text-decoration: underline;
        }
        .register-error {
            color: #dc3545;
            background: #fff0f0;
            border: 1px solid #f5c2c7;
            padding: 10px 14px;
            border-radius: 4px;
            margin-bottom: 18px;
            text-align: center;
        }
        .register-success {
            color: #198754;
            background: #e9fbe9;
            border: 1px solid #b6e2b6;
            padding: 10px 14px;
            border-radius: 4px;
            margin-bottom: 18px;
            text-align: center;
        }
    </style>
</head>
<body>
    <%@ include file="header.jsp" %>
    <div class="register-container">
        <div class="register-title">Đăng ký tài khoản</div>
        <%
            String error = (String) request.getAttribute("error");
            String success = (String) request.getAttribute("success");
            if (error != null) {
        %>
            <div class="register-error"><%= error %></div>
        <%
            }
            if (success != null) {
        %>
            <div class="register-success"><%= success %></div>
        <%
            }
        %>
        <form class="register-form" action="<%= request.getContextPath() %>/register" method="post">
            <label for="username">Tên đăng nhập:</label>
            <input type="text" id="username" name="username" required autofocus>
            <label for="password">Mật khẩu:</label>
            <input type="password" id="password" name="password" required>
            <label for="confirmPassword">Nhập lại mật khẩu:</label>
            <input type="password" id="confirmPassword" name="confirmPassword" required>
            <button type="submit">Đăng ký</button>
        </form>
        <div class="register-links">
            <a href="<%= request.getContextPath() %>/login">Đã có tài khoản? Đăng nhập</a>
            |
            <a href="<%= request.getContextPath() %>/home">Về trang chủ</a>
        </div>
    </div>
</body>
</html>