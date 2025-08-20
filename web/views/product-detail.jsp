<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="data.models.Product"%>
<%@page import="data.models.ProductImage"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="icon" type="image/x-icon" href="logo-lovely.ico">
        <link rel="stylesheet" href="./public/assets/styles/globals.css">
        <script src="https://cdn.jsdelivr.net/npm/@tailwindcss/browser@4"></script>
        <title><%= ((Product)request.getAttribute("product")).getName() %></title>
    </head>
    <body >
        <div class="flex flex-col min-h-screen bg-muted">
            <jsp:include page="../components/header.jsp" />
            
            <div class="pt-24 pb-32">
                <div class="max-w-6xl mx-auto px-5">
                    <% 
                        Product product = (Product) request.getAttribute("product");
                        List<ProductImage> images = (List<ProductImage>) request.getAttribute("images");
                        String mainImageUrl = null;
                        if (images != null && !images.isEmpty()) {
                            mainImageUrl = images.get(0).getImageUrl();
                        }
                    %>
                    
                    <div class="bg-background rounded-xl p-5">
                        <div class="grid grid-cols-1 lg:grid-cols-2 gap-12">
                            <!-- Left Column - Product Images -->
                            <div class="space-y-6">
                                <!-- Main Product Image -->
                                <div class="relative w-full">
                                    <% if (mainImageUrl != null && !mainImageUrl.isEmpty()) { %>
                                        <img 
                                            id="mainImage"
                                            src="<%= request.getContextPath() + mainImageUrl %>" 
                                            alt="<%= product.getName() %>"
                                            class="w-full h-[500px] object-cover rounded-lg product-image-border"
                                        />
                                    <% } else { %>
                                        <div class="w-full h-96 bg-gray-200 rounded-lg product-image-border flex items-center justify-center">
                                            <svg class="w-24 h-24 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 16l4.586-4.586a2 2 0 012.828 0L16 16m-2-2l1.586-1.586a2 2 0 012.828 0L20 14m-6-6h.01M6 20h12a2 2 0 002-2V6a2 2 0 00-2-2H6a2 2 0 00-2 2v12a2 2 0 002 2z"></path>
                                            </svg>
                                        </div>
                                    <% } %>
                                </div>
                                
                                <!-- Thumbnail Images -->
                                <% if (images != null && !images.isEmpty()) { %>
                                <div class="flex gap-2 overflow-x-auto p-2 scrollbar-hide bg-muted rounded-lg">
                                    <% for (int i = 0; i < images.size(); i++) { %>
                                        <div class="w-20 h-20 rounded-lg overflow-hidden cursor-pointer hover:opacity-80 transition-opacity flex-shrink-0">
                                            <img 
                                                src="<%= request.getContextPath() + images.get(i).getImageUrl() %>" 
                                                alt="<%= product.getName() %> - Ảnh <%= i+1 %>"
                                                class="w-full h-full object-cover"
                                                onclick="changeMainImage('<%= request.getContextPath() + images.get(i).getImageUrl() %>')"
                                            />
                                        </div>
                                    <% } %>
                                </div>
                                <% } %>
                            </div>
                            
                            <!-- Right Column - Product Details -->
                            <div class="flex flex-col justify-between">
                                <div class="space-y-6">
                                    <!-- Product Title -->
                                    <h1 class="text-xl font-semibold leading-tight text-foreground">
                                        <%= product.getName() %>
                                    </h1>
                                    <!-- Price -->
                                    <div class="text-3xl font-extrabold text-primary">
                                        <%= String.format("%,.0f", product.getPrice()) %>.000đ
                                    </div>

                                    <!-- Shipping Information -->
                                    <div class="space-y-3">
                                        <div class="flex items-center space-x-3">
                                            <span class="text-sm text-muted-foreground">Vận Chuyển và nhận hàng sau 5 ngày</span>
                                            <svg xmlns="http://www.w3.org/2000/svg" class="text-muted-foreground" width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-truck-icon lucide-truck"><path d="M14 18V6a2 2 0 0 0-2-2H4a2 2 0 0 0-2 2v11a1 1 0 0 0 1 1h2"/><path d="M15 18H9"/><path d="M19 18h2a1 1 0 0 0 1-1v-3.65a1 1 0 0 0-.22-.624l-3.48-4.35A1 1 0 0 0 17.52 8H14"/><circle cx="17" cy="18" r="2"/><circle cx="7" cy="18" r="2"/></svg>
                                        </div>
                                        <div class="flex items-center space-x-3">
                                            <label class="text-sm text-gray-600">Số Lượng</label>
                                            <div class="flex items-center space-x-0">
                                                <button class="cursor-pointer w-10 h-10 border border-input bg-input text-gray-600 hover:bg-input transition-colors rounded-l-lg">
                                                    -
                                                </button>
                                                <input type="number" value="1" min="1" class="w-12 h-10 border-t border-b text-center border-input focus:outline-none outline-none">
                                                <button class="cursor-pointer w-10 h-10 border border-input bg-input text-gray-600 hover:bg-input transition-colors rounded-r-lg">
                                                    +
                                                </button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <!-- Action Buttons -->
                                <div class="flex gap-4">
                                    <div class="w-full">
                                        <% 
                                        // Kiểm tra xem sản phẩm đã có trong giỏ hàng chưa
                                        boolean isInCart = false;
                                        if (session.getAttribute("user") != null) {
                                            data.models.User user = (data.models.User) session.getAttribute("user");
                                            data.dao.CartDao cartDao = new data.implementations.CartImplementation();
                                            data.models.Cart cart = cartDao.getCartByUserEmail(user.getEmail());
                                            if (cart != null) {
                                                data.models.CartItem cartItem = cartDao.getCartItemByProduct(cart.getId(), product.getId());
                                                isInCart = (cartItem != null);
                                            }
                                        }
                                        %>
                                        
                                        <% if (!isInCart) { %>
                                            <!-- Button thêm vào giỏ hàng -->
                                            <button onclick="addToCart(<%= product.getId() %>)" class="cursor-pointer w-full py-2 inline-flex items-center justify-center gap-2 whitespace-nowrap rounded-md text-sm font-medium transition-all border bg-background shadow-xs hover:bg-accent hover:text-accent-foreground">
                                                <svg fill="none" stroke="currentColor" viewBox="0 0 24 24" class="w-4 h-4">
                                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M16 10a4 4 0 0 1-8 0"/>
                                                    <path d="M3.103 6.034h17.794"/>
                                                    <path d="M3.4 5.467a2 2 0 0 0-.4 1.2V20a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2V6.667a2 2 0 0 0-.4-1.2l-2-2.667A2 2 0 0 0 17 2H7a2 2 0 0 0-1.6.8z"/>
                                                </svg>
                                                <span>Thêm Vào Giỏ Hàng</span>
                                            </button>
                                        <% } else { %>
                                            <!-- Button đã có trong giỏ hàng -->
                                            <button disabled class="cursor-not-allowed w-full py-2 inline-flex items-center justify-center gap-2 whitespace-nowrap rounded-md text-sm font-medium transition-all border bg-muted text-muted-foreground">
                                                <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                                    <path d="M4.929 4.929 19.07 19.071"/>
                                                    <circle cx="12" cy="12" r="10"/>
                                                </svg>
                                                <span>Đã Có Trong Giỏ Hàng</span>
                                            </button>
                                        <% } %>
                                    </div>
                                    <div class="w-full">
                                        <button onclick="buyNow(<%= product.getId() %>)" class="cursor-pointer w-full py-2 bg-primary text-primary-foreground shadow-xs hover:bg-primary/90 inline-flex items-center justify-center gap-2 whitespace-nowrap rounded-md text-sm font-medium transition-all">
                                            Mua Ngay
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                                    
                    <div class="bg-background rounded-xl p-5 mt-5">
                        <h1 class="bg-muted w-full p-4 rounded-lg">Mô tả sản phẩm</h1>
                        <div class="mt-4">
                            <% if (product.getDescription() != null && !product.getDescription().isEmpty()) { %>
                                <span class="text-secondary-foreground leading-relaxed text-sm">
                                    <%= product.getDescription() %>
                                </span>
                            <% } %>
                        </div>
                    </div>                
                </div>
            </div>
            
            <jsp:include page="../components/footer.jsp" />
        </div>
        
        <script>
            function changeMainImage(imageUrl) {
                const mainImage = document.getElementById('mainImage');
                if (mainImage) {
                    mainImage.src = imageUrl;
                }
            }
            
            async function addToCart(productId) {
                try {
                    const quantityInput = document.querySelector('input[type="number"]');
                    const quantity = quantityInput ? parseInt(quantityInput.value) : 1;
                    
                    const res = await fetch('<%= request.getContextPath() %>/add-to-cart', {
                        method: 'POST',
                        headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                        body: new URLSearchParams({ productId: String(productId), quantity: String(quantity) })
                    });
                    
                    const data = await res.json();
                    
                    if (data.requiresLogin) { 
                        window.location.href = data.redirect; 
                        return; 
                    }
                    
                    if (!data.success) { 
                        console.error(data.message || 'Failed to add'); 
                        alert('Có lỗi xảy ra: ' + (data.message || 'Không thể thêm vào giỏ hàng'));
                        return; 
                    }
                    
                    // Thay đổi button thành "Đã Có Trong Giỏ Hàng"
                    const addButton = document.querySelector('button[onclick*="addToCart"]');
                    if (addButton) {
                        addButton.innerHTML = `
                            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                <path d="M4.929 4.929 19.07 19.071"/>
                                <circle cx="12" cy="12" r="10"/>
                            </svg>
                            <span>Đã Có Trong Giỏ Hàng</span>
                        `;
                        addButton.disabled = true;
                        addButton.onclick = null; // Bỏ onclick để không thể click lại
                        addButton.className = addButton.className
                            .replace('cursor-pointer', 'cursor-not-allowed')
                            .replace('bg-background', 'bg-muted')
                            .replace('hover:bg-accent', '')
                            .replace('hover:text-accent-foreground', '');
                    }
                    
                    // Cập nhật số lượng giỏ hàng ở header
                    if (data.cartItemCount !== undefined) {
                        const cartBadge = document.getElementById('cart-count-badge');
                        if (cartBadge) {
                            if (data.cartItemCount > 0) {
                                cartBadge.style.display = '';
                                cartBadge.textContent = data.cartItemCount;
                            } else {
                                cartBadge.style.display = 'none';
                                cartBadge.textContent = '0';
                            }
                        }
                    }
                    
                    // Hiển thị thông báo thành công
                    alert('Đã thêm sản phẩm vào giỏ hàng!');
                    
                } catch (e) { 
                    console.error(e); 
                    alert('Có lỗi xảy ra khi thêm vào giỏ hàng. Vui lòng thử lại.');
                }
            }
            
            async function buyNow(productId) {
                try {
                    const quantityInput = document.querySelector('input[type="number"]');
                    const quantity = quantityInput ? parseInt(quantityInput.value) : 1;
                    
                    const res = await fetch('<%= request.getContextPath() %>/buy-now', {
                        method: 'POST',
                        headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                        body: new URLSearchParams({ productId: String(productId), quantity: String(quantity) })
                    });
                    
                    const data = await res.json();
                    
                    if (data.requiresLogin) { 
                        window.location.href = data.redirect; 
                        return; 
                    }
                    
                    if (!data.success) { 
                        console.error(data.message || 'Failed to buy now'); 
                        alert('Có lỗi xảy ra: ' + (data.message || 'Không thể mua hàng'));
                        return; 
                    }
                    
                    // Chuyển hướng đến trang thành công
                    if (data.redirect) {
                        window.location.href = data.redirect;
                    }
                    
                } catch (e) { 
                    console.error(e); 
                    alert('Có lỗi xảy ra khi mua hàng. Vui lòng thử lại.');
                }
            }
            
            // Quantity selector functionality
            document.addEventListener('DOMContentLoaded', function() {
                const quantityInput = document.querySelector('input[type="number"]');
                const minusBtn = quantityInput.previousElementSibling;
                const plusBtn = quantityInput.nextElementSibling;
                
                minusBtn.addEventListener('click', function() {
                    let value = parseInt(quantityInput.value);
                    if (value > 1) {
                        quantityInput.value = value - 1;
                    }
                });
                
                plusBtn.addEventListener('click', function() {
                    let value = parseInt(quantityInput.value);
                    quantityInput.value = value + 1;
                });
            });
        </script>
    </body>
</html>
