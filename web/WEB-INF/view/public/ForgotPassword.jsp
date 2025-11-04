<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quên mật khẩu - SmartPhoneStore.vn</title>
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
        
        .forgot-password-container {
            flex: 1;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 40px 20px;
        }
        
        .forgot-password-card {
            background: white;
            border-radius: 10px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 450px;
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
        
        .forgot-password-card h2 {
            font-size: 1.75rem;
            font-weight: 600;
            margin-bottom: 10px;
            color: #333;
        }
        
        .forgot-password-card p {
            color: #6c757d;
            margin-bottom: 25px;
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
        
        .btn-primary {
            background-color: #007bff;
            border: none;
            border-radius: 6px;
            padding: 12px;
            font-weight: 500;
            transition: background-color 0.3s, transform 0.2s;
            width: 100%;
        }
        
        .btn-primary:hover {
            background-color: #0056b3;
            transform: translateY(-1px);
        }
        
        .btn-primary:disabled {
            opacity: 0.6;
            cursor: not-allowed;
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
                <a class="nav-link" href="${pageContext.request.contextPath}/login">Đăng nhập</a>
                <a class="nav-link" href="${pageContext.request.contextPath}/register">Đăng ký</a>
            </div>
        </div>
    </nav>
    
    <!-- Forgot Password Form -->
    <div class="forgot-password-container">
        <div class="forgot-password-card">
            <h2 class="text-center">Quên mật khẩu</h2>
            <p class="text-center">Nhập email của bạn để nhận liên kết đặt lại mật khẩu</p>
            
            <!-- Error Alert -->
            <c:if test="${not empty errorMessage}">
                <div class="alert alert-danger" role="alert">
                    ${errorMessage}
                </div>
            </c:if>
            
            <!-- Success Alert -->
            <c:if test="${not empty successMessage}">
                <div class="alert alert-success" role="alert">
                    ${successMessage}
                </div>
            </c:if>
            
            <!-- Forgot Password Form -->
            <form id="forgotPasswordForm" method="post" action="${pageContext.request.contextPath}/forgot-password" novalidate>
                <div class="mb-3">
                    <label for="email" class="form-label">Email:</label>
                    <input type="email" class="form-control" id="email" name="email" 
                           required
                           placeholder="Nhập email của bạn">
                </div>
                
                <button type="submit" class="btn btn-primary" id="submitBtn">
                    <i class="fas fa-paper-plane me-2"></i>Gửi yêu cầu đặt lại mật khẩu
                </button>
            </form>
            
            <!-- Links -->
            <div class="form-links">
                <p>
                    <a href="${pageContext.request.contextPath}/login">
                        <i class="fas fa-arrow-left me-1"></i>Quay lại đăng nhập
                    </a>
                    <span class="mx-2">|</span>
                    <a href="${pageContext.request.contextPath}/home">Về trang chủ</a>
                </p>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Form submission with loading state
        const form = document.getElementById('forgotPasswordForm');
        const submitBtn = document.getElementById('submitBtn');
        
        form.addEventListener('submit', function(e) {
            // Disable button and show loading state
            submitBtn.disabled = true;
            submitBtn.innerHTML = '<i class="fas fa-spinner fa-spin me-2"></i>Đang gửi...';
            
            // Form will submit normally
        });
    </script>
</body>
</html>

