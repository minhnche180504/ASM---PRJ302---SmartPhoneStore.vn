<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng ký - SmartPhoneStore.vn</title>
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
        
        .register-wrapper {
            flex: 1;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 40px 20px;
        }
        
        .register-container {
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
        
        .register-container::before {
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
        
        .register-header {
            text-align: center;
            margin-bottom: 40px;
        }
        
        .register-logo {
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
        
        .register-title {
            font-size: 2.2rem;
            font-weight: 800;
            color: #2d3748;
            margin-bottom: 10px;
            background: linear-gradient(135deg, #4a5568 0%, #2d3748 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }
        
        .register-subtitle {
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
            padding: 8px;
            color: #718096;
            display: flex;
            align-items: center;
            justify-content: center;
            transition: all 0.3s ease;
            z-index: 10;
            border-radius: 8px;
        }
        
        .password-toggle:hover {
            color: #a78bfa;
            background: rgba(167, 139, 250, 0.1);
        }
        
        .password-toggle:focus {
            outline: 2px solid #a78bfa;
            outline-offset: 2px;
        }
        
        .password-toggle svg {
            width: 22px;
            height: 22px;
            pointer-events: none;
        }
        
        .register-btn {
            width: 100%;
            padding: 18px 32px;
            background: linear-gradient(135deg, #a78bfa 0%, #c4b5fd 100%);
            color: #ffffff;
            border: none;
            border-radius: 14px;
            font-size: 1.1rem;
            font-weight: 700;
            cursor: pointer;
            margin-top: 10px;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            position: relative;
            overflow: hidden;
            letter-spacing: 0.3px;
            box-shadow: 0 8px 24px rgba(167, 139, 250, 0.4);
        }
        
        .register-btn::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.4), transparent);
            transition: left 0.6s ease;
        }
        
        .register-btn:hover::before {
            left: 100%;
        }
        
        .register-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 12px 32px rgba(167, 139, 250, 0.5);
            background: linear-gradient(135deg, #8b5cf6 0%, #a78bfa 100%);
        }
        
        .register-btn:active {
            transform: translateY(0);
        }
        
        .register-links {
            margin-top: 28px;
            text-align: center;
            padding-top: 24px;
            border-top: 1px solid #e9d8fd;
        }
        
        .register-links a {
            color: #a78bfa;
            text-decoration: none;
            font-weight: 600;
            font-size: 0.95rem;
            transition: all 0.3s ease;
            display: inline-block;
            margin: 0 8px;
        }
        
        .register-links a:hover {
            color: #8b5cf6;
            text-decoration: underline;
            transform: translateY(-1px);
        }
        
        .register-error {
            color: #dc3545;
            background: linear-gradient(135deg, #fff5f5 0%, #ffe5e5 100%);
            border: 2px solid #f5c2c7;
            padding: 14px 18px;
            border-radius: 12px;
            margin-bottom: 24px;
            text-align: center;
            font-size: 0.95rem;
            font-weight: 500;
            animation: shake 0.5s ease;
        }
        
        @keyframes shake {
            0%, 100% { transform: translateX(0); }
            25% { transform: translateX(-10px); }
            75% { transform: translateX(10px); }
        }
        
        .register-success {
            color: #198754;
            background: linear-gradient(135deg, #f0fdf4 0%, #dcfce7 100%);
            border: 2px solid #b6e2b6;
            padding: 14px 18px;
            border-radius: 12px;
            margin-bottom: 24px;
            text-align: center;
            font-size: 0.95rem;
            font-weight: 500;
        }
        
        @media (max-width: 600px) {
            .register-container {
                padding: 40px 30px;
                border-radius: 20px;
            }
            
            .register-title {
                font-size: 1.8rem;
            }
            
            .register-logo {
                width: 70px;
                height: 70px;
                font-size: 2rem;
            }
        }
    </style>
</head>
<body>
    <div class="register-wrapper">
        <div class="register-container">
            <div class="register-header">
                <div class="register-logo">📱</div>
                <h1 class="register-title">Đăng ký tài khoản</h1>
                <p class="register-subtitle">Tạo tài khoản để mua sắm dễ dàng hơn</p>
            </div>
            
            <%
                String error = (String) request.getAttribute("error");
                String success = (String) request.getAttribute("success");
                if (error != null) {
            %>
                <div class="register-error">⚠️ <%= error %></div>
            <%
                }
                if (success != null) {
            %>
                <div class="register-success">✅ <%= success %></div>
            <%
                }
            %>
            
            <form action="<%= request.getContextPath() %>/register" method="post">
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
                
                <div class="form-group">
                    <label for="confirmPassword" class="form-label">Nhập lại mật khẩu *</label>
                    <div class="form-input-wrapper">
                        <input type="password" id="confirmPassword" name="confirmPassword" class="form-input" required placeholder="Nhập lại mật khẩu">
                        <button type="button" class="password-toggle" id="confirmPasswordToggle" onclick="togglePassword('confirmPassword', 'confirmPasswordToggle')" title="Hiện mật khẩu" aria-label="Hiện mật khẩu">
                            <svg id="confirmPasswordToggleIcon" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z"/>
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M2.458 12C3.732 7.943 7.523 5 12 5c4.478 0 8.268 2.943 9.542 7-1.274 4.057-5.064 7-9.542 7-4.477 0-8.268-2.943-9.542-7z"/>
                            </svg>
                        </button>
                    </div>
                </div>
                
                <button type="submit" class="register-btn">✨ Đăng ký ngay</button>
            </form>
            
            <div class="register-links">
                <a href="<%= request.getContextPath() %>/login">Đã có tài khoản? Đăng nhập</a>
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
