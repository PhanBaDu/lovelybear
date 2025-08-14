<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="icon" type="image/x-icon" href="logo-title.ico">
        <title>Trang Chủ</title>
        <link rel="stylesheet" href="./public/assets/styles/globals.css">
        <link rel="stylesheet" href="./public/assets/styles/validation.css">
        <script src="https://cdn.jsdelivr.net/npm/@tailwindcss/browser@4"></script>
        <style>
            .hero-section {
                background: linear-gradient(135deg, var(--primary) 0%, var(--primary-foreground) 100%);
            }
            
            .feature-card {
                transition: transform 0.3s ease, box-shadow 0.3s ease;
            }
            
            .feature-card:hover {
                transform: translateY(-5px);
                box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
            }
        </style>
    </head>
    <body> 
        <jsp:include page="./components/header.jsp" />
        
        <!-- Success/Error Messages -->
        <c:if test="${not empty logout_success}">
            <div class="fixed top-4 right-4 z-50 toast success">
                <div class="flex items-center gap-2">
                    <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                        <path d="M20 6 9 17l-5-5"/>
                    </svg>
                    <span>${logout_success}</span>
                </div>
            </div>
        </c:if>
        
        <c:if test="${not empty signup_success}">
            <div class="fixed top-4 right-4 z-50 toast success">
                <div class="flex items-center gap-2">
                    <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                        <path d="M20 6 9 17l-5-5"/>
                    </svg>
                    <span>${signup_success}</span>
                </div>
            </div>
        </c:if>
        
        <!-- Hero Section -->
        <section class="hero-section text-white py-20">
            <div class="container mx-auto px-4 text-center">
                <h1 class="text-4xl md:text-6xl font-bold mb-6">
                    Chào mừng đến với <span class="text-yellow-300">Decor</span>
                </h1>
                <p class="text-xl md:text-2xl mb-8 opacity-90">
                    Khám phá thế giới trang trí nội thất tuyệt đẹp
                </p>
                <div class="flex flex-col sm:flex-row gap-4 justify-center">
                    <a href="signup" class="bg-white text-primary px-8 py-3 rounded-lg font-semibold hover:bg-gray-100 transition-colors">
                        Bắt đầu ngay
                    </a>
                    <a href="#features" class="border-2 border-white text-white px-8 py-3 rounded-lg font-semibold hover:bg-white hover:text-primary transition-colors">
                        Tìm hiểu thêm
                    </a>
                </div>
            </div>
        </section>
        
        <!-- Features Section -->
        <section id="features" class="py-16 bg-muted">
            <div class="container mx-auto px-4">
                <h2 class="text-3xl font-bold text-center mb-12 text-foreground">
                    Tại sao chọn chúng tôi?
                </h2>
                <div class="grid md:grid-cols-3 gap-8">
                    <div class="feature-card bg-card p-6 rounded-lg shadow-md">
                        <div class="w-12 h-12 bg-primary rounded-lg flex items-center justify-center mb-4">
                            <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="text-white">
                                <path d="M12 2L2 7l10 5 10-5-10-5z"/>
                                <path d="M2 17l10 5 10-5"/>
                                <path d="M2 12l10 5 10-5"/>
                            </svg>
                        </div>
                        <h3 class="text-xl font-semibold mb-2 text-foreground">Thiết kế độc đáo</h3>
                        <p class="text-muted-foreground">Những mẫu thiết kế độc đáo, phù hợp với mọi không gian sống của bạn.</p>
                    </div>
                    
                    <div class="feature-card bg-card p-6 rounded-lg shadow-md">
                        <div class="w-12 h-12 bg-primary rounded-lg flex items-center justify-center mb-4">
                            <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="text-white">
                                <path d="M12 22s8-4 8-10V5l-8-3-8 3v7c0 6 8 10 8 10z"/>
                            </svg>
                        </div>
                        <h3 class="text-xl font-semibold mb-2 text-foreground">Chất lượng cao</h3>
                        <p class="text-muted-foreground">Sản phẩm chất lượng cao, bền đẹp với thời gian và giá cả hợp lý.</p>
                    </div>
                    
                    <div class="feature-card bg-card p-6 rounded-lg shadow-md">
                        <div class="w-12 h-12 bg-primary rounded-lg flex items-center justify-center mb-4">
                            <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="text-white">
                                <path d="M22 16.92v3a2 2 0 0 1-2.18 2 19.79 19.79 0 0 1-8.63-3.07 19.5 19.5 0 0 1-6-6 19.79 19.79 0 0 1-3.07-8.67A2 2 0 0 1 4.11 2h3a2 2 0 0 1 2 1.72 12.84 12.84 0 0 0 .7 2.81 2 2 0 0 1-.45 2.11L8.09 9.91a16 16 0 0 0 6 6l1.27-1.27a2 2 0 0 1 2.11-.45 12.84 12.84 0 0 0 2.81.7A2 2 0 0 1 22 16.92z"/>
                            </svg>
                        </div>
                        <h3 class="text-xl font-semibold mb-2 text-foreground">Hỗ trợ 24/7</h3>
                        <p class="text-muted-foreground">Đội ngũ tư vấn chuyên nghiệp, sẵn sàng hỗ trợ bạn mọi lúc.</p>
                    </div>
                </div>
            </div>
        </section>
        
        <!-- CTA Section -->
        <section class="py-16 bg-primary text-white">
            <div class="container mx-auto px-4 text-center">
                <h2 class="text-3xl font-bold mb-4">Sẵn sàng tạo không gian sống tuyệt vời?</h2>
                <p class="text-xl mb-8 opacity-90">Tham gia ngay để nhận những ưu đãi đặc biệt</p>
                <a href="signup" class="bg-white text-primary px-8 py-3 rounded-lg font-semibold hover:bg-gray-100 transition-colors">
                    Đăng ký miễn phí
                </a>
            </div>
        </section>
        
        <!-- Footer -->
        <footer class="bg-foreground text-white py-8">
            <div class="container mx-auto px-4 text-center">
                <p>&copy; 2024 Decor. Tất cả quyền được bảo lưu.</p>
            </div>
        </footer>
        
        <script>
            // Auto-hide toast messages
            document.addEventListener('DOMContentLoaded', function() {
                const toasts = document.querySelectorAll('.toast');
                toasts.forEach(toast => {
                    setTimeout(() => {
                        toast.style.opacity = '0';
                        setTimeout(() => {
                            toast.remove();
                        }, 300);
                    }, 5000);
                });
            });
        </script>
    </body>
</html>
