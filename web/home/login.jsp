<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Đăng nhập - SmartPhoneStore.vn</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=2.0, user-scalable=0">
    <link rel="shortcut icon" href="//theme.hstatic.net/1000090299/1000362108/14/favicon.png?v=1134" type="image/png">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: 'Inter', 'Segoe UI', -apple-system, BlinkMacSystemFont, sans-serif;
            background: linear-gradient(135deg, #e0c3fc 0%, #8ec5fc 50%, #b8e6e6 100%);
            background-attachment: fixed;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }
        
        .login-wrapper {
            flex: 1;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 40px 20px;
        }
        
        .login-container {
            max-width: 480px;
            width: 100%;
            background: #ffffff;
            padding: 50px 45px;
            border-radius: 26px;
            box-shadow: 
                0 20px 60px rgba(107, 70, 193, 0.25),
                0 8px 24px rgba(0, 0, 0, 0.1);
            animation: slideUp 0.6s ease;
            position: relative;
            overflow: hidden;
        }
        
        .login-container::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 5px;
            background: linear-gradient(90deg, #e0c3fc 0%, #8ec5fc 50%, #b8e6e6 100%);
        }
        
        @keyframes slideUp {
            from {
                opacity: 0;
                transform: translateY(40px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
        
        .login-header {
            text-align: center;
            margin-bottom: 40px;
        }
        
        .login-logo {
            width: 80px;
            height: 80px;
            background: linear-gradient(135deg, #a78bfa 0%, #c4b5fd 100%);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 2.5rem;
            margin: 0 auto 24px;
            box-shadow: 0 8px 24px rgba(167, 139, 250, 0.4);
            animation: pulse 2s ease-in-out infinite;
        }
        
        @keyframes pulse {
            0%, 100% {
                transform: scale(1);
            }
            50% {
                transform: scale(1.05);
            }
        }
        
        .login-title {
            font-size: 2.2rem;
            font-weight: 800;
            color: #2d3748;
            margin-bottom: 10px;
            background: linear-gradient(135deg, #4a5568 0%, #2d3748 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }
        
        .login-subtitle {
            color: #718096;
            font-size: 0.95rem;
            font-weight: 500;
        }
        
        .form-group {
            margin-bottom: 24px;
        }
        
        .form-label {
            display: block;
            margin-bottom: 10px;
            color: #4a5568;
            font-weight: 600;
            font-size: 0.95rem;
        }
        
        .form-input-wrapper {
            position: relative;
        }
        
        .form-input {
            width: 100%;
            padding: 16px 50px 16px 18px;
            border: 2px solid #e9d8fd;
            border-radius: 14px;
            font-size: 1rem;
            background: #faf5ff;
            color: #2d3748;
            transition: all 0.3s ease;
            font-family: inherit;
        }
        
        .form-input:focus {
            outline: none;
            border-color: #a78bfa;
            background: #ffffff;
            box-shadow: 0 0 0 4px rgba(167, 139, 250, 0.1);
        }
        
        .password-toggle {
            position: absolute;
            right: 16px;
            top: 50%;
            transform: translateY(-50%);
            background: none;
            border: none;
            cursor: pointer;
            padding: 0;
            width: 24px;
            height: 24px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: #a78bfa;
            transition: all 0.2s ease;
            z-index: 10;
        }
        
        .password-toggle:hover {
            color: #8b5cf6;
            transform: translateY(-50%) scale(1.1);
        }
        
        .password-toggle svg {
            width: 20px;
            height: 20px;
            pointer-events: none;
        }
        
        .login-btn {
            width: 100%;
            padding: 18px 0;
            background: linear-gradient(135deg, #8b5cf6 0%, #a78bfa 100%);
            color: #ffffff;
            font-size: 1.1rem;
            font-weight: 700;
            border: none;
            border-radius: 14px;
            cursor: pointer;
            margin-top: 32px;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            box-shadow: 0 10px 30px rgba(139, 92, 246, 0.3);
            letter-spacing: 0.5px;
            text-transform: uppercase;
        }
        
        .login-btn:hover {
            background: linear-gradient(135deg, #7c3aed 0%, #8b5cf6 100%);
            transform: translateY(-2px);
            box-shadow: 0 15px 40px rgba(139, 92, 246, 0.4);
        }
        
        .login-btn:active {
            transform: translateY(-1px);
            box-shadow: 0 8px 20px rgba(139, 92, 246, 0.3);
        }
        
        .login-links {
            margin-top: 36px;
            text-align: center;
            font-size: 0.95rem;
            color: #718096;
        }
        
        .login-links a {
            color: #8b5cf6;
            text-decoration: none;
            font-weight: 700;
            transition: all 0.2s ease;
            position: relative;
        }
        
        .login-links a:hover {
            color: #7c3aed;
        }
        
        .login-links a::after {
            content: '';
            position: absolute;
            bottom: -2px;
            left: 0;
            width: 0;
            height: 2px;
            background: linear-gradient(90deg, #8b5cf6, #a78bfa);
            transition: width 0.3s ease;
        }
        
        .login-links a:hover::after {
            width: 100%;
        }
        
        .login-links span {
            margin: 0 8px;
            color: #cbd5e1;
        }
        
        .alert-message {
            padding: 18px 24px;
            margin-bottom: 28px;
            border-radius: 14px;
            font-size: 0.95rem;
            text-align: center;
            font-weight: 600;
            animation: slideDown 0.4s ease;
        }
        
        @keyframes slideDown {
            from {
                opacity: 0;
                transform: translateY(-10px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
        
        .alert-error {
            background: linear-gradient(135deg, #fee 0%, #fecaca 100%);
            color: #dc2626;
            border: 2px solid #fca5a5;
            box-shadow: 0 6px 16px rgba(220, 38, 38, 0.2);
        }
        
        .alert-success {
            background: linear-gradient(135deg, #d1fae5 0%, #a7f3d0 100%);
            color: #059669;
            border: 2px solid #6ee7b7;
            box-shadow: 0 6px 16px rgba(5, 150, 105, 0.2);
        }
        
        /* Responsive */
        @media (max-width: 768px) {
            .login-wrapper {
                padding: 30px 15px;
            }
            
            .login-container {
                padding: 40px 30px;
                border-radius: 20px;
            }
        }
        
        @media (max-width: 480px) {
            .login-container {
                padding: 35px 25px;
            }
            
            .login-title {
                font-size: 1.85rem;
            }
            
            .login-subtitle {
                font-size: 0.9rem;
            }
            
            .login-logo {
                width: 70px;
                height: 70px;
                font-size: 2.2rem;
            }
            
            .form-input {
                padding: 13px 18px;
                font-size: 0.95rem;
            }
            
            .login-btn {
                padding: 15px 0;
                font-size: 1.05rem;
            }
        }
    </style>
</head>
<body>
    <div class="login-wrapper">
        <div class="login-container">
            <div class="login-header">
                <div class="login-logo">📱</div>
                <h1 class="login-title">Đăng nhập</h1>
                <p class="login-subtitle">Chào mừng bạn quay trở lại!</p>
            </div>
            
            <%
                String error = (String) request.getAttribute("error");
                String success = (String) request.getAttribute("success");
                if (error != null) {
            %>
                <div class="alert-message alert-error"><%= error %></div>
            <%
                }
                if (success != null) {
            %>
                <div class="alert-message alert-success"><%= success %></div>
            <%
                }
            %>
            
            <form action="<%= request.getContextPath() %>/login" method="post">
                <div class="form-group">
                    <label for="username" class="form-label">Tên đăng nhập *</label>
                    <div class="form-input-wrapper">
                        <input type="text" id="username" name="username" class="form-input" required autofocus placeholder="Nhập tên đăng nhập">
                    </div>
                </div>
                
                <div class="form-group">
                    <label for="password" class="form-label">Mật khẩu *</label>
                    <div class="form-input-wrapper">
                        <input type="password" id="password" name="password" class="form-input" required placeholder="Nhập mật khẩu">
                        <button type="button" class="password-toggle" id="passwordToggle" onclick="togglePassword('password', 'passwordToggle')" title="Hiện mật khẩu" aria-label="Hiện mật khẩu">
                            <svg id="passwordToggleIcon" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z"/>
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M2.458 12C3.732 7.943 7.523 5 12 5c4.478 0 8.268 2.943 9.542 7-1.274 4.057-5.064 7-9.542 7-4.477 0-8.268-2.943-9.542-7z"/>
                            </svg>
                        </button>
                    </div>
                </div>
                
                <button type="submit" class="login-btn">🔐 Đăng nhập ngay</button>
            </form>
            
            <div class="login-links">
                <a href="<%= request.getContextPath() %>/register">Chưa có tài khoản? Đăng ký</a>
                <span style="color: #c4b5fd;">|</span>
                <a href="<%= request.getContextPath() %>/home">🏠 Về trang chủ</a>
            </div>
        </div>
    </div>
    
    <script>
        function togglePassword(inputId, toggleId) {
            const passwordInput = document.getElementById(inputId);
            const toggleIcon = document.getElementById(toggleId + 'Icon');
            const toggleButton = document.getElementById(toggleId);
            
            if (passwordInput.type === 'password') {
                passwordInput.type = 'text';
                toggleIcon.innerHTML = '<path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13.875 18.825A10.05 10.05 0 0112 19c-4.478 0-8.268-2.943-9.543-7a9.97 9.97 0 011.563-3.029m5.858.908a3 3 0 114.243 4.243M9.878 9.878l4.242 4.242M9.88 9.88l-3.29-3.29m7.532 7.532l3.29 3.29M3 3l3.59 3.59m0 0A9.953 9.953 0 0112 5c4.478 0 8.268 2.943 9.543 7a10.025 10.025 0 01-4.132 5.411m0 0L21 21"/>';
                if (toggleButton) {
                    toggleButton.setAttribute('title', 'Ẩn mật khẩu');
                    toggleButton.setAttribute('aria-label', 'Ẩn mật khẩu');
                }
            } else {
                passwordInput.type = 'password';
                toggleIcon.innerHTML = '<path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z"/><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M2.458 12C3.732 7.943 7.523 5 12 5c4.478 0 8.268 2.943 9.542 7-1.274 4.057-5.064 7-9.542 7-4.477 0-8.268-2.943-9.542-7z"/>';
                if (toggleButton) {
                    toggleButton.setAttribute('title', 'Hiện mật khẩu');
                    toggleButton.setAttribute('aria-label', 'Hiện mật khẩu');
                }
            }
        }
    </script>
</body>
</html>