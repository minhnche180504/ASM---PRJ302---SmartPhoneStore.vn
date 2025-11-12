<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng ký - SmartPhoneStore.vn</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        body {
            background-color: #f5f5f5;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }
        
        .navbar {
            background-color: #ffffff;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        
        .navbar-brand {
            font-size: 1.5rem;
            font-weight: bold;
            color: #007bff !important;
        }
        
        .register-container {
            flex: 1;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 40px 20px;
        }
        
        .register-card {
            background: white;
            border-radius: 10px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 400px;
            padding: 30px;
            animation: fadeIn 0.5s ease-in;
        }
        
        @keyframes fadeIn {
            from {
                opacity: 0;
                transform: translateY(-20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
        
        .register-card h2 {
            font-size: 1.75rem;
            font-weight: 600;
            margin-bottom: 25px;
            color: #333;
        }
        
        .alert {
            border-radius: 8px;
            padding: 12px 15px;
            margin-bottom: 20px;
        }
        
        .alert-danger {
            background-color: #f8d7da;
            border: 1px solid #f5c6cb;
            color: #721c24;
        }
        
        .alert-success {
            background-color: #d4edda;
            border: 1px solid #c3e6cb;
            color: #155724;
        }
        
        .form-label {
            font-weight: 500;
            color: #333;
            margin-bottom: 8px;
        }
        
        .form-control {
            border-radius: 6px;
            border: 1px solid #ddd;
            padding: 10px 15px;
            transition: border-color 0.3s;
        }
        
        .form-control:focus {
            border-color: #007bff;
            box-shadow: 0 0 0 0.2rem rgba(0, 123, 255, 0.25);
        }
        
        .password-input-wrapper {
            position: relative;
        }
        
        .password-toggle {
            position: absolute;
            right: 12px;
            top: 50%;
            transform: translateY(-50%);
            cursor: pointer;
            color: #6c757d;
            font-size: 1.1rem;
            z-index: 10;
        }
        
        .password-toggle:hover {
            color: #007bff;
        }
        
        .btn-primary {
            background-color: #007bff;
            border: none;
            border-radius: 6px;
            padding: 12px;
            font-weight: 500;
            transition: background-color 0.3s, transform 0.2s;
        }
        
        .btn-primary:hover {
            background-color: #0056b3;
            transform: translateY(-1px);
        }
        
        .btn-primary:disabled {
            opacity: 0.6;
            cursor: not-allowed;
        }
        
        .invalid-feedback {
            display: block;
            font-size: 0.875rem;
            color: #dc3545;
            margin-top: 5px;
        }
        
        .form-links {
            text-align: center;
            margin-top: 20px;
            color: #6c757d;
            font-size: 0.9rem;
        }
        
        .form-links a {
            color: #007bff;
            text-decoration: none;
        }
        
        .form-links a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <!-- Navigation Bar -->
    <nav class="navbar navbar-expand-lg navbar-light">
        <div class="container">
            <a class="navbar-brand" href="${pageContext.request.contextPath}/home">
                SmartPhoneStore.vn
            </a>
            <div class="navbar-nav ms-auto">
                <a class="nav-link" href="${pageContext.request.contextPath}/home">Trang chủ</a>
                <a class="nav-link" href="${pageContext.request.contextPath}/products">Sản phẩm</a>
                <a class="nav-link" href="${pageContext.request.contextPath}/cart">
                    Giỏ hàng: <span id="cartCount">0</span> sản phẩm
                </a>
                <a class="nav-link" href="${pageContext.request.contextPath}/login">Đăng nhập</a>
                <a class="nav-link" href="${pageContext.request.contextPath}/register">Đăng ký</a>
            </div>
        </div>
    </nav>
    
    <!-- Register Form -->
    <div class="register-container">
        <div class="register-card">
            <h2 class="text-center">Đăng ký tài khoản</h2>
            
            <!-- Error Alert -->
            <c:if test="${not empty errorMessage}">
                <div class="alert alert-danger" role="alert">
                    Có lỗi xảy ra trong quá trình đăng ký!
                </div>
            </c:if>
            
            <!-- Success Alert -->
            <c:if test="${not empty successMessage}">
                <div class="alert alert-success" role="alert">
                    ${successMessage}
                </div>
            </c:if>
            
            <!-- Register Form -->
            <form id="registerForm" method="post" action="${pageContext.request.contextPath}/register" novalidate>
                <div class="mb-3">
                    <label for="username" class="form-label">Tên đăng nhập:</label>
                    <input type="text" class="form-control" id="username" name="username" 
                           required minlength="3" 
                           placeholder="Nhập tên đăng nhập">
                    <div class="invalid-feedback" id="usernameError"></div>
                </div>
                
                <div class="mb-3">
                    <label for="password" class="form-label">Mật khẩu:</label>
                    <div class="password-input-wrapper">
                        <input type="password" class="form-control" id="password" name="password" 
                               required minlength="6"
                               placeholder="Nhập mật khẩu (tối thiểu 6 ký tự)">
                        <i class="fas fa-eye password-toggle" id="togglePassword"></i>
                    </div>
                    <div class="invalid-feedback" id="passwordError"></div>
                </div>
                
                <div class="mb-3">
                    <label for="confirmPassword" class="form-label">Nhập lại mật khẩu:</label>
                    <div class="password-input-wrapper">
                        <input type="password" class="form-control" id="confirmPassword" name="confirmPassword" 
                               required
                               placeholder="Nhập lại mật khẩu">
                        <i class="fas fa-eye password-toggle" id="toggleConfirmPassword"></i>
                    </div>
                    <div class="invalid-feedback" id="confirmPasswordError"></div>
                </div>
                
                <button type="submit" class="btn btn-primary w-100" id="submitBtn">
                    Đăng ký
                </button>
            </form>
            
            <!-- Links -->
            <div class="form-links">
                <p>
                    Đã có tài khoản? <a href="${pageContext.request.contextPath}/login">Đăng nhập</a>
                    <span class="mx-2">|</span>
                    <a href="${pageContext.request.contextPath}/home">Về trang chủ</a>
                </p>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Password Toggle Functionality
        const togglePassword = document.getElementById('togglePassword');
        const toggleConfirmPassword = document.getElementById('toggleConfirmPassword');
        const password = document.getElementById('password');
        const confirmPassword = document.getElementById('confirmPassword');
        
        togglePassword.addEventListener('click', function() {
            const type = password.getAttribute('type') === 'password' ? 'text' : 'password';
            password.setAttribute('type', type);
            this.classList.toggle('fa-eye');
            this.classList.toggle('fa-eye-slash');
        });
        
        toggleConfirmPassword.addEventListener('click', function() {
            const type = confirmPassword.getAttribute('type') === 'password' ? 'text' : 'password';
            confirmPassword.setAttribute('type', type);
            this.classList.toggle('fa-eye');
            this.classList.toggle('fa-eye-slash');
        });
        
        // Form Validation
        const form = document.getElementById('registerForm');
        const usernameInput = document.getElementById('username');
        const passwordInput = document.getElementById('password');
        const confirmPasswordInput = document.getElementById('confirmPassword');
        const submitBtn = document.getElementById('submitBtn');
        
        // Real-time validation
        usernameInput.addEventListener('blur', function() {
            validateUsername();
        });
        
        passwordInput.addEventListener('blur', function() {
            validatePassword();
            validateConfirmPassword();
        });
        
        confirmPasswordInput.addEventListener('blur', function() {
            validateConfirmPassword();
        });
        
        function validateUsername() {
            const username = usernameInput.value.trim();
            const errorElement = document.getElementById('usernameError');
            
            if (username.length === 0) {
                usernameInput.classList.add('is-invalid');
                errorElement.textContent = 'Vui lòng nhập tên đăng nhập';
                return false;
            } else if (username.length < 3) {
                usernameInput.classList.add('is-invalid');
                errorElement.textContent = 'Tên đăng nhập phải có ít nhất 3 ký tự';
                return false;
            } else {
                usernameInput.classList.remove('is-invalid');
                errorElement.textContent = '';
                return true;
            }
        }
        
        function validatePassword() {
            const password = passwordInput.value;
            const errorElement = document.getElementById('passwordError');
            
            if (password.length === 0) {
                passwordInput.classList.add('is-invalid');
                errorElement.textContent = 'Vui lòng nhập mật khẩu';
                return false;
            } else if (password.length < 6) {
                passwordInput.classList.add('is-invalid');
                errorElement.textContent = 'Mật khẩu phải có ít nhất 6 ký tự';
                return false;
            } else {
                passwordInput.classList.remove('is-invalid');
                errorElement.textContent = '';
                return true;
            }
        }
        
        function validateConfirmPassword() {
            const password = passwordInput.value;
            const confirmPassword = confirmPasswordInput.value;
            const errorElement = document.getElementById('confirmPasswordError');
            
            if (confirmPassword.length === 0) {
                confirmPasswordInput.classList.add('is-invalid');
                errorElement.textContent = 'Vui lòng nhập lại mật khẩu';
                return false;
            } else if (password !== confirmPassword) {
                confirmPasswordInput.classList.add('is-invalid');
                errorElement.textContent = 'Mật khẩu xác nhận không khớp';
                return false;
            } else {
                confirmPasswordInput.classList.remove('is-invalid');
                errorElement.textContent = '';
                return true;
            }
        }
        
        // Form submission
        form.addEventListener('submit', function(e) {
            e.preventDefault();
            
            const isUsernameValid = validateUsername();
            const isPasswordValid = validatePassword();
            const isConfirmPasswordValid = validateConfirmPassword();
            
            if (isUsernameValid && isPasswordValid && isConfirmPasswordValid) {
                // Disable button and show loading state
                submitBtn.disabled = true;
                submitBtn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Đang xử lý...';
                
                // Submit form
                form.submit();
            } else {
                // Show validation errors
                if (!isUsernameValid) validateUsername();
                if (!isPasswordValid) validatePassword();
                if (!isConfirmPasswordValid) validateConfirmPassword();
            }
        });
    </script>
</body>
</html>
