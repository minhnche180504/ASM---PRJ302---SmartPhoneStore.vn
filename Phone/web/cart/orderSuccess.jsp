<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.User" %>
<jsp:include page="header.jsp" />

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Đặt hàng thành công - SmartPhoneStore.vn</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            margin: 0;
            padding: 0;
            min-height: 100vh;
        }
        .success-container {
            max-width: 800px;
            margin: 50px auto;
            background: white;
            padding: 40px;
            border-radius: 12px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.2);
            text-align: center;
        }
        .success-icon {
            font-size: 5rem;
            color: #28a745;
            margin-bottom: 20px;
            animation: bounce 1s ease-in-out;
        }
        .success-title {
            font-size: 2.5rem;
            color: #28a745;
            margin-bottom: 15px;
            font-weight: bold;
        }
        .success-message {
            font-size: 1.2rem;
            color: #2c3e50;
            margin-bottom: 30px;
            line-height: 1.6;
        }
        .order-details {
            background: #f8f9fa;
            padding: 25px;
            border-radius: 8px;
            margin: 30px 0;
            border-left: 4px solid #28a745;
            text-align: left;
        }
        .order-details h3 {
            color: #2c3e50;
            margin-bottom: 20px;
            font-size: 1.4rem;
        }
        .detail-row {
            display: flex;
            justify-content: space-between;
            margin-bottom: 10px;
            padding: 8px 0;
            border-bottom: 1px solid #e9ecef;
        }
        .detail-row:last-child {
            border-bottom: none;
            font-weight: bold;
            color: #28a745;
            font-size: 1.1rem;
        }
        .detail-label {
            font-weight: 500;
            color: #495057;
        }
        .detail-value {
            color: #2c3e50;
        }
        .action-buttons {
            display: flex;
            gap: 20px;
            justify-content: center;
            margin-top: 30px;
            flex-wrap: wrap;
        }
        .btn {
            padding: 12px 24px;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            font-size: 1rem;
            text-decoration: none;
            display: inline-block;
            font-weight: 500;
            transition: all 0.3s ease;
        }
        .btn-primary {
            background: #007bff;
            color: white;
        }
        .btn-success {
            background: #28a745;
            color: white;
        }
        .btn-secondary {
            background: #6c757d;
            color: white;
        }
        .btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(0,0,0,0.15);
            text-decoration: none;
            color: white;
        }
        .support-info {
            background: #e7f3ff;
            border: 1px solid #b8daff;
            padding: 20px;
            border-radius: 8px;
            margin-top: 30px;
        }
        .support-info h4 {
            color: #004085;
            margin-bottom: 15px;
        }
        .support-info p {
            color: #004085;
            margin: 8px 0;
        }
        .timeline {
            background: #fff3cd;
            border: 1px solid #ffeaa7;
            padding: 20px;
            border-radius: 8px;
            margin-top: 20px;
            text-align: left;
        }
        .timeline h4 {
            color: #856404;
            margin-bottom: 15px;
        }
        .timeline-item {
            display: flex;
            align-items: center;
            margin: 10px 0;
            color: #6c5d03;
        }
        .timeline-icon {
            margin-right: 10px;
            font-size: 1.2rem;
        }
        
        @keyframes bounce {
            0%, 20%, 60%, 100% {
                transform: translateY(0);
            }
            40% {
                transform: translateY(-20px);
            }
            80% {
                transform: translateY(-10px);
            }
        }
        
        @media (max-width: 768px) {
            .success-container {
                margin: 20px;
                padding: 30px 20px;
            }
            .success-title {
                font-size: 2rem;
            }
            .action-buttons {
                flex-direction: column;
                align-items: stretch;
            }
            .detail-row {
                flex-direction: column;
                gap: 5px;
            }
        }
        .logo-success {
            display: flex;
            justify-content: center;
            align-items: center;
            margin-bottom: 18px;
        }
        .logo-success img {
            height: 60px;
            margin-right: 14px;
        }
        .logo-success span {
            font-size: 2.1rem;
            font-weight: bold;
            color: #007bff;
            letter-spacing: 1px;
            font-family: 'Segoe UI', Arial, sans-serif;
        }
    </style>
</head>
<body>
    <div class="success-container">
        <div class="logo-success">
            <img src="https://i.imgur.com/8Km9tLL.png" alt="SmartPhoneStore.vn Logo"/>
            <span>SmartPhoneStore.vn</span>
        </div>
        <%
            String orderSuccessMessage = (String) session.getAttribute("orderSuccessMessage");
            String lastOrderId = (String) session.getAttribute("lastOrderId");
            Double lastOrderTotal = (Double) session.getAttribute("lastOrderTotal");
            String lastCustomerName = (String) session.getAttribute("lastCustomerName");
            String lastCustomerPhone = (String) session.getAttribute("lastCustomerPhone");
            String lastCustomerAddress = (String) session.getAttribute("lastCustomerAddress");
            
            User currentUser = (User) session.getAttribute("user");
            
            if (orderSuccessMessage != null) {
                // Xóa thông báo khỏi session sau khi hiển thị
                session.removeAttribute("orderSuccessMessage");
        %>
        
        <div class="success-icon">🎉</div>
        <h1 class="success-title">Đặt hàng thành công!</h1>
        <p class="success-message">
            Cảm ơn bạn đã tin tưởng và mua sắm tại <strong>SmartPhoneStore.vn</strong>!<br>
            Đơn hàng của bạn đã được ghi nhận và đang được xử lý.
        </p>
        
        <% if (lastOrderId != null && lastOrderTotal != null) { %>
        <div class="order-details">
            <h3>📋 Chi tiết đơn hàng</h3>
            <div class="detail-row">
                <span class="detail-label">Mã đơn hàng:</span>
                <span class="detail-value"><strong><%= lastOrderId %></strong></span>
            </div>
            <% if (lastCustomerName != null) { %>
            <div class="detail-row">
                <span class="detail-label">Người nhận:</span>
                <span class="detail-value"><%= lastCustomerName %></span>
            </div>
            <% } %>
            <% if (lastCustomerPhone != null) { %>
            <div class="detail-row">
                <span class="detail-label">Số điện thoại:</span>
                <span class="detail-value"><%= lastCustomerPhone %></span>
            </div>
            <% } %>
            <% if (lastCustomerAddress != null) { %>
            <div class="detail-row">
                <span class="detail-label">Địa chỉ giao hàng:</span>
                <span class="detail-value"><%= lastCustomerAddress %></span>
            </div>
            <% } %>
            <div class="detail-row">
                <span class="detail-label">Phương thức thanh toán:</span>
                <span class="detail-value">Thanh toán khi nhận hàng (COD)</span>
            </div>
            <div class="detail-row">
                <span class="detail-label">Tổng tiền:</span>
                <span class="detail-value"><%= String.format("%,.0f", lastOrderTotal) %> VND</span>
            </div>
        </div>
        <% } %>
        
        <div class="timeline">
            <h4>📅 Quy trình xử lý đơn hàng</h4>
            <div class="timeline-item">
                <span class="timeline-icon">✅</span>
                <span><strong>Đã nhận đơn hàng</strong> - Đơn hàng đã được ghi nhận</span>
            </div>
            <div class="timeline-item">
                <span class="timeline-icon">📞</span>
                <span><strong>Xác nhận đơn hàng</strong> - Chúng tôi sẽ gọi xác nhận trong 30 phút</span>
            </div>
            <div class="timeline-item">
                <span class="timeline-icon">📦</span>
                <span><strong>Chuẩn bị hàng</strong> - Đóng gói và chuẩn bị giao hàng</span>
            </div>
            <div class="timeline-item">
                <span class="timeline-icon">🚚</span>
                <span><strong>Giao hàng</strong> - Giao hàng trong 24-48h</span>
            </div>
            <div class="timeline-item">
                <span class="timeline-icon">💰</span>
                <span><strong>Thanh toán</strong> - Thanh toán khi nhận hàng</span>
            </div>
        </div>
        
        <div class="action-buttons">
            <a href="<%= request.getContextPath() %>/home" class="btn btn-primary">
                🏠 Về trang chủ
            </a>
            <a href="<%= request.getContextPath() %>/products" class="btn btn-success">
                📱 Tiếp tục mua sắm
            </a>
            <% if (currentUser != null) { %>
            <a href="<%= request.getContextPath() %>/account/orders" class="btn btn-secondary">
                📋 Đơn hàng của tôi
            </a>
            <% } %>
        </div>
        
        <div class="support-info">
            <h4>📞 Thông tin hỗ trợ</h4>
            <p><strong>Hotline:</strong> 0917.509.195 (8:00 - 22:00 hàng ngày)</p>
            <p><strong>Email:</strong> support@smartphonestore.vn</p>
            <p><strong>Địa chỉ:</strong> 123 Đường ABC, Quận 1, TP.HCM</p>
            <p>Nếu có bất kỳ thắc mắc nào về đơn hàng, vui lòng liên hệ với chúng tôi!</p>
        </div>
        
        <%
            } else {
        %>
        
        <div class="success-icon" style="color: #dc3545;">❌</div>
        <h1 class="success-title" style="color: #dc3545;">Không tìm thấy thông tin đơn hàng</h1>
        <p class="success-message">
            Có vẻ như bạn đã truy cập trang này một cách trực tiếp hoặc phiên làm việc đã hết hạn.<br>
            Vui lòng thực hiện đặt hàng lại hoặc kiểm tra giỏ hàng của bạn.
        </p>
        
        <div class="action-buttons">
            <a href="<%= request.getContextPath() %>/cart" class="btn btn-primary">
                🛒 Xem giỏ hàng
            </a>
            <a href="<%= request.getContextPath() %>/products" class="btn btn-success">
                📱 Mua sắm ngay
            </a>
        </div>
        
        <%
            }
            
            // Dọn dẹp session sau khi hiển thị
            session.removeAttribute("lastOrderId");
            session.removeAttribute("lastOrderTotal");
            session.removeAttribute("lastOrderDetails");
            session.removeAttribute("lastCustomerName");
            session.removeAttribute("lastCustomerPhone");
            session.removeAttribute("lastCustomerEmail");
            session.removeAttribute("lastCustomerAddress");
            session.removeAttribute("lastOrderNote");
        %>
    </div>

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            // Auto scroll to top
            window.scrollTo(0, 0);
            
            // Add sparkle effect
            function createSparkle() {
                const sparkle = document.createElement('div');
                sparkle.innerHTML = '✨';
                sparkle.style.position = 'fixed';
                sparkle.style.left = Math.random() * window.innerWidth + 'px';
                sparkle.style.top = Math.random() * window.innerHeight + 'px';
                sparkle.style.fontSize = '1.5rem';
                sparkle.style.pointerEvents = 'none';
                sparkle.style.zIndex = '1000';
                sparkle.style.animation = 'sparkle 2s ease-out forwards';
                
                document.body.appendChild(sparkle);
                
                setTimeout(() => {
                    sparkle.remove();
                }, 2000);
            }
            
            // Create sparkles every 500ms for 5 seconds
            let sparkleCount = 0;
            const sparkleInterval = setInterval(() => {
                createSparkle();
                sparkleCount++;
                if (sparkleCount >= 10) {
                    clearInterval(sparkleInterval);
                }
            }, 500);
            
            // Add CSS for sparkle animation
            const style = document.createElement('style');
            style.textContent = `
                @keyframes sparkle {
                    0% {
                        opacity: 1;
                        transform: scale(0);
                    }
                    50% {
                        opacity: 1;
                        transform: scale(1);
                    }
                    100% {
                        opacity: 0;
                        transform: scale(0) translateY(-50px);
                    }
                }
            `;
            document.head.appendChild(style);
            
            // Smooth hover effects
            const buttons = document.querySelectorAll('.btn');
            buttons.forEach(btn => {
                btn.addEventListener('mouseenter', function() {
                    this.style.transform = 'translateY(-2px) scale(1.05)';
                });
                btn.addEventListener('mouseleave', function() {
                    this.style.transform = 'translateY(0) scale(1)';
                });
            });
            
            // Show success message with delay
            const successContainer = document.querySelector('.success-container');
            successContainer.style.opacity = '0';
            successContainer.style.transform = 'translateY(30px)';
            
            setTimeout(() => {
                successContainer.style.transition = 'all 0.6s ease-out';
                successContainer.style.opacity = '1';
                successContainer.style.transform = 'translateY(0)';
            }, 100);
        });
    </script>
</body>
</html>