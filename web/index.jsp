<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="data.dao.Database"%>
<%@page import="data.dao.ProductDao"%>
<%@page import="data.dao.ProductImageDao"%>
<%@page import="data.models.Product"%>
<%@page import="data.models.ProductImage"%>
<%@page import="data.dao.CartDao"%>
<%@page import="data.implementations.CartImplementation"%>
<%@page import="data.models.Cart"%>
<%@page import="data.models.CartItem"%>
<%@page import="data.models.User"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Trang Chủ</title>
        <link rel="icon" type="image/x-icon" href="icon-title.ico">
        <link rel="stylesheet" href="./public/assets/styles/globals.css">
        <script src="https://cdn.jsdelivr.net/npm/@tailwindcss/browser@4"></script>
    </head>
    <body> 
        <div class="flex flex-col min-h-screen justify-between bg-muted" style="
        background-image: url('./public/assets/images/background.png');
        background-size: cover;
        background-position: center;
        background-repeat: no-repeat;
      ">
            <jsp:include page="./components/chatbot.jsp" />
            <jsp:include page="./components/header.jsp" />
            <div class="pt-24 px-5 w-full pb-32">
                <jsp:include page="./components/banner.jsp" />
                <div class="max-w-6xl mx-auto">
                    <!-- Hiển thị thông báo lỗi (nếu có) -->
                    <%
                    String error = request.getParameter("error");
                    if (error != null && !error.isEmpty()) {
                    %>
                        <div class="mb-6 p-4 bg-red-100 border border-red-400 text-red-700 rounded-lg">
                            <%= error %>
                        </div>
                    <%
                    }
                    %>
                    
                    <div class="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 lg:grid-cols-5 gap-6">
                        <% 
                        try {
                            // Lấy danh sách sản phẩm trực tiếp từ database
                            ProductDao productDao = Database.getProductDao();
                            ProductImageDao imageDao = Database.getProductImageDao();
                            
                            List<Product> products = productDao.getAllProducts();
                            
                            if (products != null && !products.isEmpty()) {
                                for (Product product : products) {
                                    // Lấy ảnh cho sản phẩm
                                    List<ProductImage> images = imageDao.getProductImagesByProductId(product.getId());
                                    String mainImageUrl = null;
                                    if (images != null && !images.isEmpty()) {
                                        mainImageUrl = images.get(0).getImageUrl();
                                    }
                        %>
                            <div class="block rounded-lg overflow-hidden h-[290px] bg-card hover:shadow-xl transition-shadow">
                                <!-- Phần hình ảnh - có thể click -->
                                <div class="h-[70%] w-full overflow-hidden">
                                    <% if (mainImageUrl != null && !mainImageUrl.isEmpty()) { %>
                                        <a href="product?id=<%= product.getId() %>" class="block h-full w-full">
                                            <img class="h-full w-full object-cover hover:scale-105 transition-transform duration-300" 
                                                src="<%= request.getContextPath() + mainImageUrl %>" 
                                                alt="<%= product.getName() %>" />
                                        </a>
                                    <% } else { %>
                                        <a href="product?id=<%= product.getId() %>" class="block h-full w-full">
                                            <div class="h-full w-full bg-muted flex items-center justify-center">
                                                <svg class="w-16 h-16 text-muted-foreground" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 16l4.586-4.586a2 2 0 012.828 0L16 16m-2-2l1.586-1.586a2 2 0 012.828 0L20 14m-6-6h.01M6 20h12a2 2 0 002-2V6a2 2 0 00-2-2H6a2 2 0 00-2 2v12a2 2 0 002 2z"></path>
                                                </svg>
                                            </div>
                                        </a>
                                    <% } %>
                                </div>

                                <div class="h-[30%] p-4 flex flex-col justify-between gap-2">
                                    <!-- Tên sản phẩm - có thể click -->
                                    <div class="overflow-hidden">
                                        <a href="product?id=<%= product.getId() %>" class="text-sm line-clamp-1 text-secondary-foreground">
                                            <%= product.getName() %>
                                        </a>
                                    </div>

                                    <div class="flex items-center justify-between">
                                        <!-- Giá tiền - có thể click -->
                                        <a href="product?id=<%= product.getId() %>" class="flex items-center gap-1">
                                            <span class="text-primary font-extrabold text-base">
                                                <%= String.format("%,.0f", product.getPrice()) %>.000đ
                                            </span>
                                        </a>

                                        <%
                                        // Kiểm tra sản phẩm đã có trong giỏ hàng chưa
                                        boolean isInCart = false;
                                        User currentUser = (User) session.getAttribute("user");
                                        if (currentUser != null) {
                                            try {
                                                CartDao cartDao = new CartImplementation();
                                                Cart userCart = cartDao.getCartByUserEmail(currentUser.getEmail());
                                                if (userCart != null) {
                                                    CartItem existingItem = cartDao.getCartItemByProduct(userCart.getId(), product.getId());
                                                    isInCart = (existingItem != null);
                                                }
                                            } catch (Exception e) {
                                                // Nếu có lỗi, mặc định cho phép thêm
                                                isInCart = false;
                                            }
                                        }
                                        %>
                                        
                                        <% if (isInCart) { %>
                                            <!-- Đang ở trạng thái đã trong giỏ: hiển thị nút xóa, ẩn nút thêm -->
                                            <button id="remove-btn-<%= product.getId() %>" onclick="removeFromCart(<%= product.getId() %>)" class="bg-[#e7000b]/10 border border-destructive text-white shadow-xs inline-flex items-center justify-center gap-2 whitespace-nowrap rounded-[6px] text-xs px-3 py-2 cursor-pointer">
                                                <svg xmlns="http://www.w3.org/2000/svg" class="text-destructive" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-trash2-icon lucide-trash-2"><path d="M10 11v6"/><path d="M14 11v6"/><path d="M19 6v14a2 2 0 0 1-2 2H7a2 2 0 0 1-2-2V6"/><path d="M3 6h18"/><path d="M8 6V4a2 2 0 0 1 2-2h4a2 2 0 0 1 2 2v2"/></svg>
                                            </button>
                                            <button id="add-btn-<%= product.getId() %>" onclick="addToCart(<%= product.getId() %>)" style="display:none" class="bg-primary text-white shadow-xs hover:bg-primary/90 focus-visible:ring-primary/20 dark:focus-visible:ring-primary/40 dark:bg-primary/60 add button items-center justify-center gap-2 whitespace-nowrap rounded-[6px] text-xs px-3 py-2 cursor-pointer transition-colors">
                                                <svg xmlns="http://www.w3.org/2000/svg" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                                    <path d="M16 10a4 4 0 0 1-8 0"/>
                                                    <path d="M3.103 6.034h17.794"/>
                                                    <path d="M3.4 5.467a2 2 0 0 0-.4 1.2V20a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2V6.667a2 2 0 0 0-.4-1.2l-2-2.667A2 2 0 0 0 17 2H7a2 2 0 0 0-1.6.8z"/>
                                                </svg>
                                            </button>
                                        <% } else { %>
                                            <!-- Chưa trong giỏ: hiển thị nút thêm, ẩn nút xóa -->
                                            <button id="add-btn-<%= product.getId() %>" onclick="addToCart(<%= product.getId() %>)" class="border border-primary bg-primary text-white shadow-xs hover:bg-primary/90 focus-visible:ring-primary/20 dark:focus-visible:ring-primary/40 dark:bg-primary/60 add button inline-flex items-center justify-center gap-2 whitespace-nowrap rounded-[6px] text-xs px-3 py-2 cursor-pointer transition-colors">
                                                <svg xmlns="http://www.w3.org/2000/svg" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                                    <path d="M16 10a4 4 0 0 1-8 0"/>
                                                    <path d="M3.103 6.034h17.794"/>
                                                    <path d="M3.4 5.467a2 2 0 0 0-.4 1.2V20a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2V6.667a2 2 0 0 0-.4-1.2l-2-2.667A2 2 0 0 0 17 2H7a2 2 0 0 0-1.6.8z"/>
                                                </svg>
                                            </button>
                                            <button id="remove-btn-<%= product.getId() %>" onclick="removeFromCart(<%= product.getId() %>)" style="display:none" class="bg-[#e7000b]/10 border border-destructive text-white shadow-xs items-center justify-center gap-2 whitespace-nowrap rounded-[6px] text-xs px-3 py-2 cursor-pointer">
                                                <svg xmlns="http://www.w3.org/2000/svg" class="text-destructive" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-trash2-icon lucide-trash-2"><path d="M10 11v6"/><path d="M14 11v6"/><path d="M19 6v14a2 2 0 0 1-2 2H7a2 2 0 0 1-2-2V6"/><path d="M3 6h18"/><path d="M8 6V4a2 2 0 0 1 2-2h4a2 2 0 0 1 2 2v2"/></svg>
                                            </button>
                                        <% } %>
                                    </div>
                                </div>
                            </div>
                        <% 
                                }
                            } else {
                        %>
                            <div class="col-span-full mt-32 w-full flex flex-col items-center justify-center text-center gap-4">
                                <svg xmlns="http://www.w3.org/2000/svg" class="text-muted-foreground" width="32" height="32" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-notepad-text-dashed-icon lucide-notepad-text-dashed"><path d="M8 2v4"/><path d="M12 2v4"/><path d="M16 2v4"/><path d="M16 4h2a2 2 0 0 1 2 2v2"/><path d="M20 12v2"/><path d="M20 18v2a2 2 0 0 1-2 2h-1"/><path d="M13 22h-2"/><path d="M7 22H6a2 2 0 0 1-2-2v-2"/><path d="M4 14v-2"/><path d="M4 8V6a2 2 0 0 1 2-2h2"/><path d="M8 10h6"/><path d="M8 14h8"/><path d="M8 18h5"/></svg>
                                <h3 class="text-lg font-medium text-muted-foreground">Chưa có sản phẩm nào !</h3>
                            </div>
                        <% 
                            }
                        } catch (Exception e) {
                            System.err.println("Lỗi khi lấy danh sách sản phẩm: " + e.getMessage());
                            e.printStackTrace();
                        %>
                            <div class="col-span-full text-center py-12">
                                <svg class="w-16 h-16 text-red-500 mx-auto mb-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 9v2m0 4h.01m-6.938 4h13.856c1.54 0 2.502-1.667 1.732-2.5L13.732 4c-.77-.833-1.964-.833-2.732 0L3.34 16.5c-.77.833.192 2.5 1.732 2.5z"></path>
                                </svg>
                                <h3 class="text-lg font-medium text-red-600 mb-2">Có lỗi xảy ra</h3>
                                <p class="text-muted-foreground">Không thể tải danh sách sản phẩm. Vui lòng thử lại sau.</p>
                            </div>
                        <% } %>
                    </div>
                </div>
            </div>
            <jsp:include page="./components/footer.jsp" />
        </div>
        
        <script>
        function setCartBadge(count) {
            const badge = document.getElementById('cart-count-badge');
            if (!badge) return;
            if (count > 0) {
                badge.style.display = '';
                badge.textContent = count;
            } else {
                badge.style.display = 'none';
                badge.textContent = '0';
            }
        }

        async function addToCart(productId) {
            try {
                const res = await fetch('${pageContext.request.contextPath}/add-to-cart', {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                    body: new URLSearchParams({ productId: String(productId), quantity: '1' })
                });
                const data = await res.json();
                if (data.requiresLogin) { window.location.href = data.redirect; return; }
                if (!data.success) { console.error(data.message || 'Failed to add'); return; }
                setCartBadge(data.cartItemCount);
                const addBtn = document.getElementById('add-btn-' + productId);
                const removeBtn = document.getElementById('remove-btn-' + productId);
                if (addBtn && removeBtn) {
                    addBtn.style.display = 'none';
                    removeBtn.style.display = 'inline-flex';
                }
            } catch (e) { console.error(e); }
        }

        async function removeFromCart(productId) {
            try {
                const res = await fetch('${pageContext.request.contextPath}/remove-from-cart', {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                    body: new URLSearchParams({ productId: String(productId) })
                });
                const data = await res.json();
                if (data.requiresLogin) { window.location.href = data.redirect; return; }
                if (!data.success) { console.error(data.message || 'Failed to remove'); return; }
                setCartBadge(data.cartItemCount);
                const addBtn = document.getElementById('add-btn-' + productId);
                const removeBtn = document.getElementById('remove-btn-' + productId);
                if (addBtn && removeBtn) {
                    removeBtn.style.display = 'none';
                    addBtn.style.display = 'inline-flex';
                }
            } catch (e) { console.error(e); }
        }
        </script>
    </body>
</html>