<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.Order" %>
<%@ page import="model.User" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%
    List<Order> orders = (List<Order>) request.getAttribute("orders");
    User user = (User) session.getAttribute("user");
    SimpleDateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy HH:mm");
%>
<jsp:include page="/home/header.jsp" />
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đơn hàng của tôi - SmartPhoneStore.vn</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: #f4f6fb;
            margin: 0;
            padding: 0;
        }
        .orders-container {
            max-width: 1200px;
            margin: 30px auto;
            padding: 0 20px;
        }
        .orders-header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 30px;
            border-radius: 12px;
            margin-bottom: 30px;
            box-shadow: 0 4px 20px rgba(0,0,0,0.1);
        }
        .orders-header h1 {
            margin: 0;
            font-size: 2rem;
            font-weight: 700;
        }
        .orders-header p {
            margin: 10px 0 0 0;
            opacity: 0.9;
        }
        .orders-content {
            background: white;
            border-radius: 12px;
            padding: 30px;
            box-shadow: 0 2px 12px rgba(0,0,0,0.08);
        }
        .order-card {
            background: #f8f9fa;
            border-radius: 12px;
            padding: 24px;
            margin-bottom: 20px;
            border: 1px solid #e9ecef;
            transition: all 0.3s ease;
        }
        .order-card:hover {
            box-shadow: 0 4px 16px rgba(0,0,0,0.1);
            transform: translateY(-2px);
        }
        .order-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 16px;
            padding-bottom: 16px;
            border-bottom: 2px solid #e9ecef;
        }
        .order-id {
            font-size: 1.2rem;
            font-weight: 700;
            color: #333;
        }
        .order-date {
            color: #6c757d;
            font-size: 0.9rem;
        }
        .order-status {
            padding: 6px 12px;
            border-radius: 20px;
            font-size: 0.85rem;
            font-weight: 600;
            text-transform: uppercase;
        }
        .status-pending {
            background: #fff3cd;
            color: #856404;
        }
        .status-completed {
            background: #d4edda;
            color: #155724;
        }
        .status-cancelled {
            background: #f8d7da;
            color: #721c24;
        }
        .order-info {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 16px;
            margin-bottom: 16px;
        }
        .info-item {
            display: flex;
            flex-direction: column;
        }
        .info-label {
            font-size: 0.85rem;
            color: #6c757d;
            margin-bottom: 4px;
        }
        .info-value {
            font-size: 1rem;
            color: #333;
            font-weight: 600;
        }
        .order-total {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding-top: 16px;
            border-top: 2px solid #e9ecef;
        }
        .total-label {
            font-size: 1.1rem;
            font-weight: 600;
            color: #333;
        }
        .total-value {
            font-size: 1.5rem;
            font-weight: 700;
            color: #e53935;
        }
        .empty-orders {
            text-align: center;
            padding: 60px 20px;
            color: #6c757d;
        }
        .empty-orders svg {
            width: 80px;
            height: 80px;
            margin-bottom: 20px;
            opacity: 0.5;
        }
        .empty-orders h3 {
            margin: 0 0 10px 0;
            color: #333;
        }
        .empty-orders p {
            margin: 0;
            font-size: 1rem;
        }
        .btn {
            padding: 10px 20px;
            border: none;
            border-radius: 8px;
            font-size: 0.95rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            text-decoration: none;
            display: inline-block;
        }
        .btn-primary {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
        }
        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(102, 126, 234, 0.4);
        }
        @media (max-width: 768px) {
            .orders-container {
                margin: 20px auto;
                padding: 0 16px;
            }
            .orders-header {
                padding: 20px;
            }
            .orders-content {
                padding: 20px;
            }
            .order-header {
                flex-direction: column;
                align-items: flex-start;
                gap: 12px;
            }
            .order-info {
                grid-template-columns: 1fr;
            }
            .order-total {
                flex-direction: column;
                align-items: flex-start;
                gap: 12px;
            }
        }
    </style>
</head>
<body>
    <div class="orders-container">
        <div class="orders-header">
            <h1>📦 Đơn hàng của tôi</h1>
            <p>Xem lịch sử đơn hàng của bạn</p>
        </div>
        
        <div class="orders-content">
            <% if (orders != null && !orders.isEmpty()) { %>
                <% for (Order order : orders) { %>
                    <div class="order-card">
                        <div class="order-header">
                            <div>
                                <div class="order-id">Đơn hàng #<%= order.getId() %></div>
                                <div class="order-date">
                                    📅 <%= order.getOrderDate() != null ? dateFormat.format(order.getOrderDate()) : "N/A" %>
                                </div>
                            </div>
                            <div>
                                <% 
                                    String statusClass = "status-pending";
                                    String statusText = "Đang xử lý";
                                    if ("Completed".equals(order.getStatus())) {
                                        statusClass = "status-completed";
                                        statusText = "Hoàn thành";
                                    } else if ("Cancelled".equals(order.getStatus())) {
                                        statusClass = "status-cancelled";
                                        statusText = "Đã hủy";
                                    }
                                %>
                                <span class="order-status <%= statusClass %>"><%= statusText %></span>
                            </div>
                        </div>
                        
                        <div class="order-info">
                            <div class="info-item">
                                <span class="info-label">👤 Người nhận:</span>
                                <span class="info-value"><%= order.getCustomerName() != null ? order.getCustomerName() : "N/A" %></span>
                            </div>
                            <div class="info-item">
                                <span class="info-label">📞 Số điện thoại:</span>
                                <span class="info-value"><%= order.getCustomerPhone() != null ? order.getCustomerPhone() : "N/A" %></span>
                            </div>
                            <div class="info-item">
                                <span class="info-label">📍 Địa chỉ:</span>
                                <span class="info-value"><%= order.getCustomerAddress() != null ? order.getCustomerAddress() : "N/A" %></span>
                            </div>
                        </div>
                        
                        <div class="order-total">
                            <span class="total-label">Tổng tiền:</span>
                            <span class="total-value"><%= String.format("%,.0f", order.getTotal()) %> VND</span>
                        </div>
                    </div>
                <% } %>
            <% } else { %>
                <div class="empty-orders">
                    <svg fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M16 11V7a4 4 0 00-8 0v4M5 9h14l1 12H4L5 9z"/>
                    </svg>
                    <h3>Chưa có đơn hàng nào</h3>
                    <p>Bạn chưa có đơn hàng nào. Hãy mua sắm ngay!</p>
                    <br>
                    <a href="<%= request.getContextPath() %>/products" class="btn btn-primary">🛒 Mua sắm ngay</a>
                </div>
            <% } %>
        </div>
    </div>
    <jsp:include page="/home/footer.jsp" />
</body>
</html>

