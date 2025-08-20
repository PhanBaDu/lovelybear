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
        <title>Káº¿t quáº£ tÃ¬m kiáº¿m</title>
        <link rel="icon" type="image/x-icon" href="logo-lovely.ico">
        <link rel="stylesheet" href="./public/assets/styles/globals.css">
        <script src="https://cdn.jsdelivr.net/npm/@tailwindcss/browser@4"></script>
    </head>
    <body> 
        <div class="flex flex-col min-h-screen justify-between bg-muted">
            <jsp:include page="./components/header.jsp" />
            <div class="pt-24 px-5 w-full pb-32">
                <div class="max-w-6xl mx-auto">
                    <!-- Search Results Header -->
                    <div class="mb-8">
                        <h1 class="text-xl font-bold text-foreground mb-4">
                            <% if (request.getAttribute("searchTerm") != null && !((String) request.getAttribute("searchTerm")).isEmpty()) { %>
                               Kết quả tìm kiếm cho "<%= request.getAttribute("searchTerm") %>"
                            <% } else { %>
                                Không tìm thấy sản phẩm
                            <% } %>
                        </h1>
                        
                        <% 
                        List<Product> products = (List<Product>) request.getAttribute("products");
                        if (products != null) {
                        %>
                            <p class="text-muted-foreground text-sm">
                                Tìm thấy <span class="font-semibold text-primary"><%= products.size() %></span> sản phẩm
                            </p>
                        <% } %>
                    </div>
                    
                    <!-- Search Results Grid -->
                    <div class="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 lg:grid-cols-4 gap-6">
                        <% 
                        if (products != null && !products.isEmpty()) {
                            ProductImageDao imageDao = (ProductImageDao) request.getAttribute("imageDao");
                            
                            for (Product product : products) {
                                // Láº¥y áº£nh cho sáº£n pháº©m
                                List<ProductImage> images = imageDao.getProductImagesByProductId(product.getId());
                                String mainImageUrl = null;
                                if (images != null && !images.isEmpty()) {
                                    mainImageUrl = images.get(0).getImageUrl();
                                }
                        %>
                            <div class="block rounded-lg overflow-hidden h-96 bg-card hover:shadow-xl transition-shadow">
                                <!-- Pháº§n hÃ¬nh áº£nh - cÃ³ thá» click -->
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
                                    <!-- TÃªn sáº£n pháº©m - cÃ³ thá» click -->
                                    <div class="overflow-hidden">
                                        <a href="product?id=<%= product.getId() %>" class="text-sm line-clamp-2 text-secondary-foreground">
                                            <%= product.getName() %>
                                        </a>
                                    </div>

                                    <div class="flex items-center justify-between">
                                        <!-- GiÃ¡ tiá»n - cÃ³ thá» click -->
                                        <a href="product?id=<%= product.getId() %>" class="flex items-center gap-1">
                                            <span class="text-primary font-extrabold text-base">
                                                <%= String.format("%,.0f", product.getPrice()) %>.000đ
                                            </span>
                                        </a>

                                        <%
                                        // Kiá»m tra sáº£n pháº©m ÄÃ£ cÃ³ trong giá» hÃ ng chÆ°a
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
                                                // Náº¿u cÃ³ lá»i, máº·c Äá»nh cho phÃ©p thÃªm
                                                isInCart = false;
                                            }
                                        }
                                        %>
                                        
                                        <% if (isInCart) { %>
                                            <!-- Äang á» tráº¡ng thÃ¡i ÄÃ£ trong giá»: hiá»n thá» nÃºt xÃ³a, áº©n nÃºt thÃªm -->
                                            <button id="remove-btn-<%= product.getId() %>" onclick="removeFromCart(<%= product.getId() %>)" class="bg-[#e7000b]/10 border border-destructive text-white shadow-xs inline-flex items-center justify-center gap-2 whitespace-nowrap rounded-[6px] text-xs px-3 py-2 cursor-pointer">
                                                <svg xmlns="http://www.w3.org/2000/svg" class="text-destructive" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-trash2-icon lucide-trash-2"><path d="M10 11v6"/><path d="M14 11v6"/><path d="M19 6v14a2 2 0 0 1-2 2H7a2 2 0 0 1-2-2V6"/><path d="M3 6h18"/><path d="M8 6V4a2 2 0 0 1 2-2h4a2 2 0 0 1 2 2v2"/></svg>
                                                <p class="font-medium text-xs text-destructive">XÃ³a khá»i giá»</p>
                                            </button>
                                            <button id="add-btn-<%= product.getId() %>" onclick="addToCart(<%= product.getId() %>)" style="display:none" class="bg-primary text-white shadow-xs hover:bg-primary/90 focus-visible:ring-primary/20 dark:focus-visible:ring-primary/40 dark:bg-primary/60 add button items-center justify-center gap-2 whitespace-nowrap rounded-[6px] text-xs px-3 py-2 cursor-pointer transition-colors">
                                                <svg xmlns="http://www.w3.org/2000/svg" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                                    <path d="M16 10a4 4 0 0 1-8 0"/>
                                                    <path d="M3.103 6.034h17.794"/>
                                                    <path d="M3.4 5.467a2 2 0 0 0-.4 1.2V20a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2V6.667a2 2 0 0 0-.4-1.2l-2-2.667A2 2 0 0 0 17 2H7a2 2 0 0 0-1.6.8z"/>
                                                </svg>
                                                <p class="font-medium text-xs text-background">Thêm vào giỏ</p>
                                            </button>
                                        <% } else { %>
                                            <!-- ChÆ°a trong giá»: hiá»n thá» nÃºt thÃªm, áº©n nÃºt xÃ³a -->
                                            <button id="add-btn-<%= product.getId() %>" onclick="addToCart(<%= product.getId() %>)" class="border border-primary bg-primary text-white shadow-xs hover:bg-primary/90 focus-visible:ring-primary/20 dark:focus-visible:ring-primary/40 dark:bg-primary/60 add button inline-flex items-center justify-center gap-2 whitespace-nowrap rounded-[6px] text-xs px-3 py-2 cursor-pointer transition-colors">
                                                <svg xmlns="http://www.w3.org/2000/svg" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                                    <path d="M16 10a4 4 0 0 1-8 0"/>
                                                    <path d="M3.103 6.034h17.794"/>
                                                    <path d="M3.4 5.467a2 2 0 0 0-.4 1.2V20a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2V6.667a2 2 0 0 0-.4-1.2l-2-2.667A2 2 0 0 0 17 2H7a2 2 0 0 0-1.6.8z"/>
                                                </svg>
                                                <p class="font-medium text-xs text-background">Thêm vào giỏ</p>
                                            </button>
                                            <button id="remove-btn-<%= product.getId() %>" onclick="removeFromCart(<%= product.getId() %>)" style="display:none" class="bg-[#e7000b]/10 border border-destructive text-white shadow-xs items-center justify-center gap-2 whitespace-nowrap rounded-[6px] text-xs px-3 py-2 cursor-pointer">
                                                <svg xmlns="http://www.w3.org/2000/svg" class="text-destructive" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-trash2-icon lucide-trash-2"><path d="M10 11v6"/><path d="M14 11v6"/><path d="M19 6v14a2 2 0 0 1-2 2H7a2 2 0 0 1-2-2V6"/><path d="M3 6h18"/><path d="M8 6V4a2 2 0 0 1 2-2h4a2 2 0 0 1 2 2v2"/></svg>
                                                <p class="font-medium text-xs text-destructive">XÃ³a khá»i giá»</p>
                                            </button>
                                        <% } %>
                                    </div>
                                </div>
                            </div>
                        <%
                            }
                        } else {
                        %>
                            <!-- No Results Found -->
                            <div class="col-span-full text-center py-20">
                                <div class="w-24 h-24 mx-auto mb-6 bg-muted rounded-full flex items-center justify-center">
                                    <svg class="w-12 h-12 text-muted-foreground" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z"></path>
                                    </svg>
                                </div>
                                <h3 class="text-2xl font-bold text-foreground mb-3">KhÃ´ng tÃ¬m tháº¥y sáº£n pháº©m</h3>
                                <p class="text-muted-foreground mb-8 text-lg">
                                    <% if (request.getAttribute("searchTerm") != null && !((String) request.getAttribute("searchTerm")).isEmpty()) { %>
                                        KhÃ´ng cÃ³ sáº£n pháº©m nÃ o phÃ¹ há»£p vá»i tá»« khÃ³a "<%= request.getAttribute("searchTerm") %>"
                                    <% } else { %>
                                        KhÃ´ng cÃ³ sáº£n pháº©m nÃ o trong há» thá»ng
                                    <% } %>
                                </p>
                                <a href="${pageContext.request.contextPath}/" 
                                   class="inline-flex items-center gap-3 bg-primary text-primary-foreground px-8 py-4 rounded-xl font-semibold hover:bg-primary/90 transition-all duration-300">
                                    Quay vá» trang chá»§
                                </a>
                            </div>
                        <%
                        }
                        %>
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
