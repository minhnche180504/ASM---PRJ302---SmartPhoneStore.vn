<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Đăng nhập - SmartPhoneStore.vn</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=2.0, user-scalable=0">
    <link rel="shortcut icon" href="//theme.hstatic.net/1000090299/1000362108/14/favicon.png?v=1134" type="image/png">
    <style>
        body {
            font-family: Arial, sans-serif;
            background: #f6f6f6;
            margin: 0;
            padding: 0;
        }
        .login-container {
            max-width: 400px;
            margin: 60px auto 0 auto;
            background: #fff;
            padding: 32px 28px 28px 28px;
            border-radius: 8px;
            box-shadow: 0 2px 16px rgba(0,0,0,0.07);
        }
        .login-title {
            text-align: center;
            font-size: 2rem;
            font-weight: bold;
            margin-bottom: 24px;
            color: #222;
        }
        .login-form label {
            display: block;
            margin-bottom: 6px;
            color: #333;
            font-weight: 500;
        }
        .login-form input[type="text"],
        .login-form input[type="password"] {
            width: 100%;
            padding: 10px 12px;
            margin-bottom: 18px;
            border: 1px solid #ccc;
            border-radius: 4px;
            font-size: 1rem;
            background: #fafafa;
            box-sizing: border-box;
        }
        .login-form button {
            width: 100%;
            padding: 12px 0;
            background: #007bff;
            color: #fff;
            border: none;
            border-radius: 4px;
            font-size: 1.1rem;
            font-weight: bold;
            cursor: pointer;
            transition: background 0.2s;
        }
        .login-form button:hover {
            background: #0056b3;
        }
        .login-links {
            margin-top: 18px;
            text-align: center;
        }
        .login-links a {
            color: #007bff;
            text-decoration: none;
            margin: 0 8px;
            font-size: 1rem;
        }
        .login-links a:hover {
            text-decoration: underline;
        }
        .login-error {
            color: #dc3545;
            background: #fff0f0;
            border: 1px solid #f5c2c7;
            padding: 10px 14px;
            border-radius: 4px;
            margin-bottom: 18px;
            text-align: center;
        }
        .login-success {
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
    <div class="login-container">
        <div class="login-title">Đăng nhập</div>
        <%
            String error = (String) request.getAttribute("error");
            String success = (String) request.getAttribute("success");
            if (error != null) {
        %>
            <div class="login-error"><%= error %></div>
        <%
            }
            if (success != null) {
        %>
            <div class="login-success"><%= success %></div>
        <%
            }
        %>
        <form class="login-form" action="<%= request.getContextPath() %>/login" method="post">
            <label for="username">Tên đăng nhập:</label>
            <input type="text" id="username" name="username" required autofocus>
            <label for="password">Mật khẩu:</label>
            <input type="password" id="password" name="password" required>
            <button type="submit">Đăng nhập</button>
        </form>
        <div class="login-links">
            <a href="<%= request.getContextPath() %>/register">Chưa có tài khoản? Đăng ký</a>
            |
            <a href="<%= request.getContextPath() %>/home">Về trang chủ</a>
        </div>
    </div>
</body>
</html>