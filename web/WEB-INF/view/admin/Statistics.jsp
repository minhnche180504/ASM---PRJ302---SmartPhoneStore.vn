<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Thống kê - Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/css/style.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</head>
<body>
    <jsp:include page="AdminHeader.jsp"/>
    
    <div class="container-fluid my-4">
        <h1 class="mb-4">Thống kê</h1>
        
        <!-- Revenue Chart -->
        <div class="card mb-4">
            <div class="card-header">
                <h5>Doanh thu theo tháng</h5>
            </div>
            <div class="card-body">
                <canvas id="revenueChart" height="100"></canvas>
            </div>
        </div>
        
        <!-- Top Selling Products -->
        <div class="card mb-4">
            <div class="card-header">
                <h5>Sản phẩm bán chạy</h5>
            </div>
            <div class="card-body">
                <div class="table-responsive">
                    <table class="table">
                        <thead>
                            <tr>
                                <th>STT</th>
                                <th>Tên sản phẩm</th>
                                <th>Thương hiệu</th>
                                <th>Giá</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="product" items="${topSelling}" varStatus="status">
                                <tr>
                                    <td>${status.index + 1}</td>
                                    <td>${product.pName}</td>
                                    <td>${product.brand}</td>
                                    <td><fmt:formatNumber value="${product.price}" type="currency" currencyCode="VND"/></td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
        
        <!-- Status Distribution -->
        <div class="card">
            <div class="card-header">
                <h5>Phân bố trạng thái đơn hàng</h5>
            </div>
            <div class="card-body">
                <canvas id="statusChart"></canvas>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Revenue Chart
        const revenueData = {
            labels: [<c:forEach var="entry" items="${revenueByMonth}">'${entry.key}',</c:forEach>],
            datasets: [{
                label: 'Doanh thu',
                data: [<c:forEach var="entry" items="${revenueByMonth}">${entry.value},</c:forEach>],
                backgroundColor: 'rgba(54, 162, 235, 0.2)',
                borderColor: 'rgba(54, 162, 235, 1)',
                borderWidth: 1
            }]
        };
        
        new Chart(document.getElementById('revenueChart'), {
            type: 'line',
            data: revenueData,
            options: {
                responsive: true,
                scales: {
                    y: {
                        beginAtZero: true
                    }
                }
            }
        });
        
        // Status Chart
        const statusData = {
            labels: [<c:forEach var="entry" items="${statusCount}">'${entry.key}',</c:forEach>],
            datasets: [{
                label: 'Số lượng',
                data: [<c:forEach var="entry" items="${statusCount}">${entry.value},</c:forEach>],
                backgroundColor: [
                    'rgba(255, 99, 132, 0.2)',
                    'rgba(54, 162, 235, 0.2)',
                    'rgba(255, 206, 86, 0.2)',
                    'rgba(75, 192, 192, 0.2)',
                    'rgba(153, 102, 255, 0.2)'
                ]
            }]
        };
        
        new Chart(document.getElementById('statusChart'), {
            type: 'doughnut',
            data: statusData
        });
    </script>
</body>
</html>

