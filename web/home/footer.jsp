<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<footer class="site-footer">
    <div class="footer-container">
        <div class="footer-content">
            <div class="footer-section">
                <h3 class="footer-title">📱 SmartPhoneStore.vn</h3>
                <p class="footer-description">
                    Cửa hàng điện thoại uy tín với đa dạng sản phẩm chất lượng cao. 
                    Cam kết mang đến trải nghiệm mua sắm tuyệt vời nhất cho khách hàng.
                </p>
                <div class="footer-social">
                    <a href="#" class="social-link" title="Facebook">
                        <svg width="24" height="24" fill="currentColor" viewBox="0 0 24 24">
                            <path d="M24 12.073c0-6.627-5.373-12-12-12s-12 5.373-12 12c0 5.99 4.388 10.954 10.125 11.854v-8.385H7.078v-3.47h3.047V9.43c0-3.007 1.792-4.669 4.533-4.669 1.312 0 2.686.235 2.686.235v2.953H15.83c-1.491 0-1.956.925-1.956 1.874v2.25h3.328l-.532 3.47h-2.796v8.385C19.612 23.027 24 18.062 24 12.073z"/>
                        </svg>
                    </a>
                    <a href="#" class="social-link" title="Instagram">
                        <svg width="24" height="24" fill="currentColor" viewBox="0 0 24 24">
                            <path d="M12 2.163c3.204 0 3.584.012 4.85.07 3.252.148 4.771 1.691 4.919 4.919.058 1.265.069 1.645.069 4.849 0 3.205-.012 3.584-.069 4.849-.149 3.225-1.664 4.771-4.919 4.919-1.266.058-1.644.07-4.85.07-3.204 0-3.584-.012-4.849-.07-3.26-.149-4.771-1.699-4.919-4.92-.058-1.265-.07-1.644-.07-4.849 0-3.204.013-3.583.07-4.849.149-3.227 1.664-4.771 4.919-4.919 1.266-.057 1.645-.069 4.849-.069zm0-2.163c-3.259 0-3.667.014-4.947.072-4.358.2-6.78 2.618-6.98 6.98-.059 1.281-.073 1.689-.073 4.948 0 3.259.014 3.668.072 4.948.2 4.358 2.618 6.78 6.98 6.98 1.281.058 1.689.072 4.948.072 3.259 0 3.668-.014 4.948-.072 4.354-.2 6.782-2.618 6.979-6.98.059-1.28.073-1.689.073-4.948 0-3.259-.014-3.667-.072-4.947-.196-4.354-2.617-6.78-6.979-6.98-1.281-.059-1.69-.073-4.949-.073zm0 5.838c-3.403 0-6.162 2.759-6.162 6.162s2.759 6.163 6.162 6.163 6.162-2.759 6.162-6.163c0-3.403-2.759-6.162-6.162-6.162zm0 10.162c-2.209 0-4-1.79-4-4 0-2.209 1.791-4 4-4s4 1.791 4 4c0 2.21-1.791 4-4 4zm6.406-11.845c-.796 0-1.441.645-1.441 1.44s.645 1.44 1.441 1.44c.795 0 1.439-.645 1.439-1.44s-.644-1.44-1.439-1.44z"/>
                        </svg>
                    </a>
                    <a href="#" class="social-link" title="YouTube">
                        <svg width="24" height="24" fill="currentColor" viewBox="0 0 24 24">
                            <path d="M23.498 6.186a3.016 3.016 0 0 0-2.122-2.136C19.505 3.545 12 3.545 12 3.545s-7.505 0-9.377.505A3.017 3.017 0 0 0 .502 6.186C0 8.07 0 12 0 12s0 3.93.502 5.814a3.016 3.016 0 0 0 2.122 2.136c1.871.505 9.376.505 9.376.505s7.505 0 9.377-.505a3.015 3.015 0 0 0 2.122-2.136C24 15.93 24 12 24 12s0-3.93-.502-5.814zM9.545 15.568V8.432L15.818 12l-6.273 3.568z"/>
                        </svg>
                    </a>
                </div>
            </div>
            
            <div class="footer-section">
                <h4 class="footer-heading">🔗 Liên kết nhanh</h4>
                <ul class="footer-links">
                    <li><a href="<%= request.getContextPath() %>/home">🏠 Trang chủ</a></li>
                    <li><a href="<%= request.getContextPath() %>/products">📱 Sản phẩm</a></li>
                    <li><a href="<%= request.getContextPath() %>/cart">🛒 Giỏ hàng</a></li>
                    <li><a href="<%= request.getContextPath() %>/login">🔐 Đăng nhập</a></li>
                    <li><a href="<%= request.getContextPath() %>/register">📝 Đăng ký</a></li>
                </ul>
            </div>
            
            <div class="footer-section">
                <h4 class="footer-heading">💬 Hỗ trợ</h4>
                <ul class="footer-links">
                    <li><a href="#">📞 Hotline: 0917.509.195</a></li>
                    <li><a href="mailto:support@smartphonestore.vn">📧 Email: support@smartphonestore.vn</a></li>
                    <li><a href="#">❓ Câu hỏi thường gặp</a></li>
                    <li><a href="#">📋 Chính sách bảo hành</a></li>
                    <li><a href="#">🔄 Chính sách đổi trả</a></li>
                </ul>
            </div>
            
            <div class="footer-section">
                <h4 class="footer-heading">📍 Thông tin</h4>
                <ul class="footer-links">
                    <li>📍 123 Đường ABC, Quận 1, TP.HCM</li>
                    <li>🕐 8:00 - 22:00 (Hàng ngày)</li>
                    <li>📱 0917.509.195</li>
                    <li>📧 support@smartphonestore.vn</li>
                </ul>
            </div>
        </div>
        
        <div class="footer-bottom">
            <div class="footer-copyright">
                <p>&copy; 2024 SmartPhoneStore.vn. Tất cả các quyền được bảo lưu.</p>
            </div>
            <div class="footer-legal">
                <a href="#">Chính sách bảo mật</a>
                <span>|</span>
                <a href="#">Điều khoản sử dụng</a>
                <span>|</span>
                <a href="#">Chính sách vận chuyển</a>
            </div>
        </div>
    </div>
</footer>

<style>
    .site-footer {
        background: linear-gradient(135deg, #2d3748 0%, #1a202c 100%);
        color: #e2e8f0;
        padding: 60px 40px 30px;
        margin-top: 80px;
        position: relative;
        overflow: hidden;
    }
    
    .site-footer::before {
        content: '';
        position: absolute;
        top: 0;
        left: 0;
        right: 0;
        height: 4px;
        background: linear-gradient(90deg, #e0c3fc 0%, #8ec5fc 50%, #b8e6e6 100%);
    }
    
    .footer-container {
        max-width: 1400px;
        margin: 0 auto;
    }
    
    .footer-content {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
        gap: 40px;
        margin-bottom: 40px;
    }
    
    .footer-section {
        display: flex;
        flex-direction: column;
        gap: 20px;
    }
    
    .footer-title {
        font-size: 1.8rem;
        font-weight: 800;
        color: #ffffff;
        margin-bottom: 12px;
        background: linear-gradient(135deg, #a78bfa 0%, #c4b5fd 100%);
        -webkit-background-clip: text;
        -webkit-text-fill-color: transparent;
        background-clip: text;
    }
    
    .footer-heading {
        font-size: 1.3rem;
        font-weight: 700;
        color: #ffffff;
        margin-bottom: 16px;
    }
    
    .footer-description {
        font-size: 0.95rem;
        color: #cbd5e0;
        line-height: 1.6;
        margin-bottom: 20px;
    }
    
    .footer-social {
        display: flex;
        gap: 16px;
        margin-top: 10px;
    }
    
    .social-link {
        width: 44px;
        height: 44px;
        display: flex;
        align-items: center;
        justify-content: center;
        background: rgba(255, 255, 255, 0.1);
        border-radius: 50%;
        color: #ffffff;
        text-decoration: none;
        transition: all 0.3s ease;
        border: 2px solid transparent;
    }
    
    .social-link:hover {
        background: linear-gradient(135deg, #a78bfa 0%, #c4b5fd 100%);
        border-color: #a78bfa;
        transform: translateY(-4px);
        box-shadow: 0 8px 20px rgba(167, 139, 250, 0.4);
        color: #ffffff;
    }
    
    .footer-links {
        list-style: none;
        padding: 0;
        margin: 0;
        display: flex;
        flex-direction: column;
        gap: 12px;
    }
    
    .footer-links li {
        margin: 0;
    }
    
    .footer-links a {
        color: #cbd5e0;
        text-decoration: none;
        font-size: 0.95rem;
        transition: all 0.3s ease;
        display: inline-block;
    }
    
    .footer-links a:hover {
        color: #a78bfa;
        transform: translateX(4px);
        text-decoration: none;
    }
    
    .footer-links li:not(:has(a)) {
        color: #cbd5e0;
        font-size: 0.95rem;
    }
    
    .footer-bottom {
        border-top: 1px solid rgba(255, 255, 255, 0.1);
        padding-top: 30px;
        display: flex;
        justify-content: space-between;
        align-items: center;
        flex-wrap: wrap;
        gap: 20px;
    }
    
    .footer-copyright {
        color: #a0aec0;
        font-size: 0.9rem;
    }
    
    .footer-legal {
        display: flex;
        gap: 12px;
        align-items: center;
        flex-wrap: wrap;
    }
    
    .footer-legal a {
        color: #cbd5e0;
        text-decoration: none;
        font-size: 0.9rem;
        transition: all 0.3s ease;
    }
    
    .footer-legal a:hover {
        color: #a78bfa;
        text-decoration: underline;
    }
    
    .footer-legal span {
        color: #718096;
    }
    
    @media (max-width: 768px) {
        .site-footer {
            padding: 40px 20px 20px;
        }
        
        .footer-content {
            grid-template-columns: 1fr;
            gap: 30px;
        }
        
        .footer-bottom {
            flex-direction: column;
            text-align: center;
        }
        
        .footer-legal {
            justify-content: center;
        }
    }
</style>

