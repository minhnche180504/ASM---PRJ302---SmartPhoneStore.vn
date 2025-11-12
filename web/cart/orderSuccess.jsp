<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.User" %>
<jsp:include page="/home/header.jsp" />

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đặt hàng thành công - SmartPhoneStore.vn</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: 'Inter', 'Segoe UI', -apple-system, BlinkMacSystemFont, sans-serif;
            background: linear-gradient(135deg, #fdfbfb 0%, #f7f4f9 50%, #faf8fc 100%);
            background-attachment: fixed;
            color: #2d3748;
            min-height: 100vh;
        }
        
        .success-wrapper {
            max-width: 900px;
            margin: 60px auto 80px;
            padding: 0 40px;
        }
        
        /* Success Card */
        .success-card {
            background: #ffffff;
            border-radius: 28px;
            padding: 60px 50px;
            box-shadow: 0 20px 60px rgba(167, 139, 250, 0.2);
            text-align: center;
            position: relative;
            overflow: hidden;
        }
        
        .success-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 6px;
            background: linear-gradient(90deg, #10b981 0%, #059669 100%);
        }
        
        /* Success Icon */
        .success-icon {
            width: 120px;
            height: 120px;
            background: linear-gradient(135deg, #10b981 0%, #059669 100%);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 4rem;
            margin: 0 auto 30px;
            box-shadow: 0 10px 40px rgba(16, 185, 129, 0.4);
            animation: successPulse 2s ease-in-out infinite;
        }
        
        @keyframes successPulse {
            0%, 100% {
                transform: scale(1);
                box-shadow: 0 10px 40px rgba(16, 185, 129, 0.4);
            }
            50% {
                transform: scale(1.05);
                box-shadow: 0 15px 50px rgba(16, 185, 129, 0.6);
            }
        }
        
        .success-title {
            font-size: 2.5rem;
            font-weight: 800;
            color: #10b981;
            margin-bottom: 16px;
        }
        
        .success-subtitle {
            font-size: 1.2rem;
            color: #64748b;
            margin-bottom: 40px;
            line-height: 1.6;
        }
        
        /* Message Box */
        .success-message {
            background: linear-gradient(135deg, #d1fae5 0%, #a7f3d0 100%);
            color: #065f46;
            padding: 24px 32px;
            border-radius: 16px;
            margin-bottom: 40px;
            font-weight: 600;
            line-height: 1.8;
            border: 2px solid #6ee7b7;
            box-shadow: 0 6px 20px rgba(16, 185, 129, 0.15);
        }
        
        /* Timeline */
        .order-timeline {
            text-align: left;
            background: #faf5ff;
            padding: 32px;
            border-radius: 16px;
            margin-bottom: 40px;
            border: 2px solid #e9d8fd;
        }
        
        .timeline-title {
            font-size: 1.3rem;
            font-weight: 700;
            color: #2d3748;
            margin-bottom: 24px;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        
        .timeline-item {
            display: flex;
            gap: 16px;
            margin-bottom: 20px;
            align-items: flex-start;
        }
        
        .timeline-item:last-child {
            margin-bottom: 0;
        }
        
        .timeline-icon {
            width: 40px;
            height: 40px;
            background: linear-gradient(135deg, #a78bfa 0%, #c4b5fd 100%);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.2rem;
            flex-shrink: 0;
        }
        
        .timeline-content {
            flex: 1;
            padding-top: 8px;
        }
        
        .timeline-step {
            font-size: 1rem;
            font-weight: 700;
            color: #2d3748;
            margin-bottom: 4px;
        }
        
        .timeline-desc {
            font-size: 0.9rem;
            color: #64748b;
        }
        
        /* Action Buttons */
        .success-actions {
            display: flex;
            gap: 16px;
            justify-content: center;
            flex-wrap: wrap;
            margin-bottom: 40px;
        }
        
        .btn {
            padding: 16px 32px;
            border: none;
            border-radius: 14px;
            font-size: 1rem;
            font-weight: 700;
            cursor: pointer;
            transition: all 0.3s ease;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 10px;
        }
        
        .btn-primary {
            background: linear-gradient(135deg, #8b5cf6 0%, #a78bfa 100%);
            color: #ffffff;
            box-shadow: 0 8px 25px rgba(139, 92, 246, 0.3);
        }
        
        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 12px 35px rgba(139, 92, 246, 0.4);
            background: linear-gradient(135deg, #7c3aed 0%, #8b5cf6 100%);
        }
        
        .btn-secondary {
            background: #e2e8f0;
            color: #475569;
        }
        
        .btn-secondary:hover {
            background: #cbd5e1;
            transform: translateY(-2px);
        }
        
        .btn-success {
            background: linear-gradient(135deg, #10b981 0%, #059669 100%);
            color: #ffffff;
            box-shadow: 0 8px 25px rgba(16, 185, 129, 0.3);
        }
        
        .btn-success:hover {
            transform: translateY(-2px);
            box-shadow: 0 12px 35px rgba(16, 185, 129, 0.4);
        }
        
        /* Support Info */
        .support-info {
            background: linear-gradient(135deg, #e0f2fe 0%, #dbeafe 100%);
            padding: 32px;
            border-radius: 16px;
            border: 2px solid #bfdbfe;
        }
        
        .support-title {
            font-size: 1.2rem;
            font-weight: 700;
            color: #1e40af;
            margin-bottom: 16px;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        
        .support-item {
            display: flex;
            align-items: center;
            gap: 12px;
            padding: 12px 0;
            color: #1e40af;
            font-weight: 600;
        }
        
        .support-icon {
            font-size: 1.5rem;
        }
        
        /* Sparkles Animation */
        .sparkle {
            position: absolute;
            font-size: 1.5rem;
            animation: sparkle 3s ease-in-out infinite;
            opacity: 0;
        }
        
        @keyframes sparkle {
            0%, 100% { opacity: 0; transform: translate(0, 0) scale(0); }
            50% { opacity: 1; transform: translate(var(--tx), var(--ty)) scale(1); }
        }
        
        .sparkle:nth-child(1) { top: 10%; left: 10%; --tx: -20px; --ty: -20px; animation-delay: 0s; }
        .sparkle:nth-child(2) { top: 15%; right: 15%; --tx: 20px; --ty: -15px; animation-delay: 0.5s; }
        .sparkle:nth-child(3) { bottom: 20%; left: 20%; --tx: -15px; --ty: 20px; animation-delay: 1s; }
        .sparkle:nth-child(4) { bottom: 15%; right: 10%; --tx: 15px; --ty: 15px; animation-delay: 1.5s; }
        
        /* Responsive */
        @media (max-width: 768px) {
            .success-wrapper {
                padding: 0 20px;
                margin: 30px auto 40px;
            }
            
            .success-card {
                padding: 40px 30px;
            }
            
            .success-icon {
                width: 90px;
                height: 90px;
                font-size: 3rem;
            }
            
            .success-title {
                font-size: 2rem;
            }
            
            .success-subtitle {
                font-size: 1rem;
            }
            
            .success-actions {
                flex-direction: column;
            }
            
            .btn {
                width: 100%;
            }
            
            .order-timeline,
            .support-info {
                padding: 24px;
            }
        }
    </style>
</head>
<body>
    <div class="success-wrapper">
        <div class="success-card">
            <!-- Sparkles -->
            <span class="sparkle">✨</span>
            <span class="sparkle">⭐</span>
            <span class="sparkle">💫</span>
            <span class="sparkle">✨</span>
            
            <!-- Success Icon -->
            <div class="success-icon">✓</div>
            
            <!-- Title -->
            <h1 class="success-title">Đặt hàng thành công!</h1>
            <p class="success-subtitle">
                Cảm ơn bạn đã tin tưởng và mua sắm tại SmartPhoneStore.vn<br>
                Đơn hàng của bạn đang được xử lý
            </p>
            
            <!-- Success Message -->
            <%
                String orderSuccessMessage = (String) session.getAttribute("orderSuccessMessage");
                if (orderSuccessMessage != null) {
                    session.removeAttribute("orderSuccessMessage");
            %>
                <div class="success-message">
                    <%= orderSuccessMessage %>
                </div>
            <%
                }
            %>
            
            <!-- Order Timeline -->
            <div class="order-timeline">
                <div class="timeline-title">📋 Quy trình xử lý đơn hàng</div>
                
                <div class="timeline-item">
                    <div class="timeline-icon">1️⃣</div>
                    <div class="timeline-content">
                        <div class="timeline-step">Xác nhận đơn hàng</div>
                        <div class="timeline-desc">Chúng tôi sẽ liên hệ với bạn trong vòng 30 phút để xác nhận</div>
                    </div>
                </div>
                
                <div class="timeline-item">
                    <div class="timeline-icon">2️⃣</div>
                    <div class="timeline-content">
                        <div class="timeline-step">Chuẩn bị hàng</div>
                        <div class="timeline-desc">Đóng gói sản phẩm cẩn thận và kiểm tra chất lượng</div>
                    </div>
                </div>
                
                <div class="timeline-item">
                    <div class="timeline-icon">3️⃣</div>
                    <div class="timeline-content">
                        <div class="timeline-step">Giao hàng</div>
                        <div class="timeline-desc">Giao hàng trong vòng 1-3 ngày làm việc</div>
                    </div>
                </div>
                
                <div class="timeline-item">
                    <div class="timeline-icon">4️⃣</div>
                    <div class="timeline-content">
                        <div class="timeline-step">Hoàn tất</div>
                        <div class="timeline-desc">Thanh toán và nhận hàng tại nhà</div>
                    </div>
                </div>
            </div>
            
            <!-- Action Buttons -->
            <div class="success-actions">
                <a href="<%= request.getContextPath() %>/account/orders" class="btn btn-success">
                    📋 Xem đơn hàng của tôi
                </a>
                <a href="<%= request.getContextPath() %>/products" class="btn btn-primary">
                    📱 Tiếp tục mua sắm
                </a>
                <a href="<%= request.getContextPath() %>/home" class="btn btn-secondary">
                    🏠 Về trang chủ
                </a>
            </div>
            
            <!-- Support Info -->
            <div class="support-info">
                <div class="support-title">💬 Cần hỗ trợ?</div>
                <div class="support-item">
                    <span class="support-icon">📞</span>
                    <span>Hotline: 1900-xxxx (8:00 - 22:00)</span>
                </div>
                <div class="support-item">
                    <span class="support-icon">📧</span>
                    <span>Email: support@smartphonestore.vn</span>
                </div>
                <div class="support-item">
                    <span class="support-icon">💬</span>
                    <span>Chat trực tuyến: Có mặt 24/7</span>
                </div>
            </div>
        </div>
    </div>
    
    <jsp:include page="/home/footer.jsp" />
    
    <script>
        // Auto hide success message sau 10 giây
        setTimeout(function() {
            const message = document.querySelector('.success-message');
            if (message) {
                message.style.transition = 'all 0.5s ease';
                message.style.opacity = '0';
                message.style.transform = 'translateY(-20px)';
                setTimeout(function() {
                    message.style.display = 'none';
                }, 500);
            }
        }, 10000);
        
        // Smooth entrance animation
        document.addEventListener('DOMContentLoaded', function() {
            const card = document.querySelector('.success-card');
            if (card) {
                card.style.opacity = '0';
                card.style.transform = 'translateY(30px)';
                setTimeout(function() {
                    card.style.transition = 'all 0.6s ease';
                    card.style.opacity = '1';
                    card.style.transform = 'translateY(0)';
                }, 100);
            }
        });
    </script>
</body>
</html>

