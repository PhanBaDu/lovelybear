<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!--SET GLOBAL max_allowed_packet=16777216;-->
<div class="fixed top-0 bg-background left-0 right-0 p-4 w-full border-b border-muted flex items-center justify-between gap-4">
    <!-- Logo Section -->
    <div class="flex-1">
        <a href="${pageContext.request.contextPath}">
            <img class="w-56" src="./public/assets/images/logo/logo-primary.svg" alt="Logo"/>
        </a>
    </div>

    <!-- Search Section -->
    <div class="flex-1 relative">
        <input 
            placeholder="Tìm kiếm một sản phẩm mà bạn mong muốn..." 
            class="file:text-foreground placeholder:text-muted-foreground selection:bg-primary selection:text-primary-foreground dark:bg-input/30 border-input flex h-9 w-full min-w-0 rounded-md border bg-transparent px-3 py-1 text-base shadow-xs transition-[color,box-shadow] outline-none file:inline-flex file:h-7 file:border-0 file:bg-transparent file:text-sm file:font-medium disabled:pointer-events-none disabled:cursor-not-allowed disabled:opacity-50 md:text-sm" 
        />
        <svg xmlns="http://www.w3.org/2000/svg" width="19" height="19" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round" class="absolute right-2 -top-[3px] w-5 h-5 translate-y-2/4 lucide lucide-search-icon lucide-search text-muted-foreground">
            <path d="m21 21-4.34-4.34"/>
            <circle cx="11" cy="11" r="8"/>
        </svg>
    </div>
    
    <!-- User Section - Conditional Rendering -->
    <div class="flex-1 flex justify-end items-center gap-4">
        <c:if test="${user != nul}">
            <div class="flex items-center gap-5">
                <c:if test="${user.role == 'ADMIN'}">
                    <a href='admin'>
                        <button class="cursor-pointer mr-4 text-xs inline-flex items-center justify-center gap-2 whitespace-nowrap rounded-md text-sm font-medium transition-all disabled:pointer-events-none disabled:opacity-50 [&_svg]:pointer-events-none [&_svg:not([class*='size-'])]:size-4 shrink-0 [&_svg]:shrink-0 outline-none focus-visible:border-ring focus-visible:ring-ring/50 focus-visible:ring-[3px] aria-invalid:ring-destructive/20 dark:aria-invalid:ring-destructive/40 aria-invalid:border-destructive bg-primary text-primary-foreground shadow-xs hover:bg-primary/90 p-2">
                            <svg xmlns="http://www.w3.org/2000/svg" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-shield-user-icon lucide-shield-user"><path d="M20 13c0 5-3.5 7.5-7.66 8.95a1 1 0 0 1-.67-.01C7.5 20.5 4 18 4 13V6a1 1 0 0 1 1-1c2 0 4.5-1.2 6.24-2.72a1.17 1.17 0 0 1 1.52 0C14.51 3.81 17 5 19 5a1 1 0 0 1 1 1z"/><path d="M6.376 18.91a6 6 0 0 1 11.249.003"/><circle cx="12" cy="11" r="4"/></svg>
                            Đến trang quản lý sản phẩm
                        </button>
                    </a>
                </c:if>
                <button class="cursor-pointer relative mr-4">
                    <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="red" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-shopping-bag-icon lucide-shopping-bag"><path d="M16 10a4 4 0 0 1-8 0"/><path d="M3.103 6.034h17.794"/><path d="M3.4 5.467a2 2 0 0 0-.4 1.2V20a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2V6.667a2 2 0 0 0-.4-1.2l-2-2.667A2 2 0 0 0 17 2H7a2 2 0 0 0-1.6.8z"/></svg>
                    <p class="absolute -top-2.5 -right-2.5 px-1 py-0.5 bg-background border rounded-full text-[10px] font-bold text-destructive">10</p>
                </button>
            </div>
        </c:if>
        <c:choose>
            <c:when test="${not empty user}">
                <!-- User đã đăng nhập - Hiển thị avatar và menu -->
                <div class="relative">
                    <!-- User Avatar với Dropdown -->
                    <button 
                        id="userMenuButton" 
                        class="flex items-center cursor-pointer gap-4 p-1 rounded-full hover:bg-muted/50 transition-all"
                        onclick="toggleUserMenu()"
                    >
                        <!-- User Info -->
                        <div class="hidden md:block text-left">
                            <p class="text-sm font-medium text-foreground">${user.fullName}</p>
                            <p class="text-xs text-muted-foreground">${user.email}</p>
                        </div>
                        
                        <c:choose>
                            <c:when test="${not empty user.pictureProfile}">
                                <!-- Có ảnh đại diện -->
                                <img 
                                    src="data:image/jpeg;base64,${user.pictureProfile}" 
                                    alt="${user.fullName}" 
                                    class="w-10 h-10 rounded-lg object-cover"
                                />
                            </c:when>
                            <c:otherwise>
                                <!-- Không có ảnh - hiển thị avatar mặc định -->
                                <div class="w-10 h-10 rounded-full bg-primary/10 border-2 border-primary/20 flex items-center justify-center text-primary font-medium text-sm">
                                    ${user.fullName.substring(0,1).toUpperCase()}
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </button>
                    
                    <!-- Dropdown Menu -->
                    <div 
                        id="userMenu" 
                        class="hidden absolute right-0 top-full mt-2 w-56 bg-card border border-input rounded-md shadow-lg z-50"
                    >
                        <div class="p-2 border-b border-muted">
                            <p class="text-sm font-medium text-foreground">${user.fullName}</p>
                            <p class="text-xs text-muted-foreground">${user.email}</p>
                        </div>
                        
                        <div class="py-1">
                            <a href="${pageContext.request.contextPath}/profile" class="flex items-center gap-2 px-3 py-2 text-sm text-foreground hover:bg-muted/50 transition-colors">
                                <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-circle-user-round-icon lucide-circle-user-round"><path d="M18 20a6 6 0 0 0-12 0"/><circle cx="12" cy="10" r="4"/><circle cx="12" cy="12" r="10"/></svg>
                                Thông tin cá nhân
                            </a>
                            
                            <a href="${pageContext.request.contextPath}/orders" class="flex items-center gap-2 px-3 py-2 text-sm text-foreground hover:bg-muted/50 transition-colors">
                                <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-shopping-bag-icon lucide-shopping-bag"><path d="M16 10a4 4 0 0 1-8 0"/><path d="M3.103 6.034h17.794"/><path d="M3.4 5.467a2 2 0 0 0-.4 1.2V20a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2V6.667a2 2 0 0 0-.4-1.2l-2-2.667A2 2 0 0 0 17 2H7a2 2 0 0 0-1.6.8z"/></svg>
                                Đơn hàng của tôi
                            </a>
                                
                            <a href="${pageContext.request.contextPath}/signout" class="flex items-center gap-2 px-3 py-2 text-sm text-destructive hover:bg-destructive/10 transition-colors">
                                <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                    <path d="M9 21H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h4"/>
                                    <polyline points="16,17 21,12 16,7"/>
                                    <line x1="21" y1="12" x2="9" y2="12"/>
                                </svg>
                                Đăng xuất
                            </a>
                        </div>
                    </div>
                </div>
                
            </c:when>
            <c:otherwise>
                <!-- User chưa đăng nhập - Hiển thị buttons đăng ký/đăng nhập -->
                <a href="${pageContext.request.contextPath}/signup">
                    <button class="w-36 h-9 px-4 py-2 has-[>svg]:px-3 cursor-pointer bg-secondary text-secondary-foreground shadow-xs hover:bg-secondary/80 inline-flex items-center justify-center gap-2 whitespace-nowrap rounded-md text-sm font-medium transition-all disabled:pointer-events-none disabled:opacity-50 [&_svg]:pointer-events-none [&_svg:not([class*='size-'])]:size-4 shrink-0 [&_svg]:shrink-0 outline-none focus-visible:border-ring focus-visible:ring-ring/50 focus-visible:ring-[3px] aria-invalid:ring-destructive/20 dark:aria-invalid:ring-destructive/40 aria-invalid:border-destructive">
                        Đăng ký
                    </button>
                </a>
                <a href="${pageContext.request.contextPath}/signin">
                    <button class="w-36 h-9 px-4 py-2 has-[>svg]:px-3 cursor-pointer bg-primary text-primary-foreground shadow-xs hover:bg-primary/90 inline-flex items-center justify-center gap-2 whitespace-nowrap rounded-md text-sm font-medium transition-all disabled:pointer-events-none disabled:opacity-50 [&_svg]:pointer-events-none [&_svg:not([class*='size-'])]:size-4 shrink-0 [&_svg]:shrink-0 outline-none focus-visible:border-ring focus-visible:ring-ring/50 focus-visible:ring-[3px] aria-invalid:ring-destructive/20 dark:aria-invalid:ring-destructive/40 aria-invalid:border-destructive">
                        Đăng nhập
                    </button>
                </a>
            </c:otherwise>
        </c:choose>
    </div>
</div>

<script>
// JavaScript để xử lý dropdown menu
function toggleUserMenu() {
    const menu = document.getElementById('userMenu');
    menu.classList.toggle('hidden');
}

// Đóng menu khi click bên ngoài
document.addEventListener('click', function(event) {
    const menu = document.getElementById('userMenu');
    const button = document.getElementById('userMenuButton');
    
    if (menu && button && !menu.contains(event.target) && !button.contains(event.target)) {
        menu.classList.add('hidden');
    }
});

// Đóng menu khi nhấn Escape
document.addEventListener('keydown', function(event) {
    if (event.key === 'Escape') {
        const menu = document.getElementById('userMenu');
        if (menu) {
            menu.classList.add('hidden');
        }
    }
});
</script>