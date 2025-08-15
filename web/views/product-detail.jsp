<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="data.models.Product"%>
<%@page import="data.models.ProductImage"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="icon" type="image/x-icon" href="logo-title.ico">
        <link rel="stylesheet" href="./public/assets/styles/globals.css">
        <script src="https://cdn.jsdelivr.net/npm/@tailwindcss/browser@4"></script>
        <title><%= ((Product)request.getAttribute("product")).getName() %></title>
    </head>
    <body class="bg-light-gray">
        <div class="flex flex-col min-h-screen">
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
                    
                    <div class="bg-white rounded-lg shadow-lg p-8">
                        <div class="grid grid-cols-1 lg:grid-cols-2 gap-12">
                            <!-- Left Column - Product Images -->
                            <div class="space-y-6">
                                <!-- Main Product Image -->
                                <div class="relative">
                                    <% if (mainImageUrl != null && !mainImageUrl.isEmpty()) { %>
                                        <img 
                                            id="mainImage"
                                            src="<%= request.getContextPath() + mainImageUrl %>" 
                                            alt="<%= product.getName() %>"
                                            class="w-full h-96 object-cover rounded-lg product-image-border"
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
                                <div class="flex space-x-4">
                                    <% for (int i = 0; i < Math.min(images.size(), 3); i++) { %>
                                        <div class="w-20 h-20 rounded-lg overflow-hidden cursor-pointer hover:opacity-80 transition-opacity">
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
                                
                                <!-- Social Sharing -->
                                <div class="pt-6 border-t border-gray-200">
                                    <div class="flex items-center space-x-4">
                                        <span class="text-sm text-gray-600">Chia sẻ:</span>
                                        <div class="flex space-x-3">
                                            <button class="w-8 h-8 bg-blue-500 rounded-full flex items-center justify-center text-white hover:bg-blue-600 transition-colors">
                                                <svg class="w-4 h-4" fill="currentColor" viewBox="0 0 24 24">
                                                    <path d="M12 2C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zm-2 15l-5-5 1.41-1.41L10 14.17l7.59-7.59L19 8l-9 9z"/>
                                                </svg>
                                            </button>
                                            <button class="w-8 h-8 bg-blue-600 rounded-full flex items-center justify-center text-white hover:bg-blue-700 transition-colors">
                                                <span class="text-xs font-bold">f</span>
                                            </button>
                                            <button class="w-8 h-8 bg-red-600 rounded-full flex items-center justify-center text-white hover:bg-red-700 transition-colors">
                                                <span class="text-xs font-bold">P</span>
                                            </button>
                                            <button class="w-8 h-8 bg-blue-400 rounded-full flex items-center justify-center text-white hover:bg-blue-500 transition-colors">
                                                <svg class="w-4 h-4" fill="currentColor" viewBox="0 0 24 24">
                                                    <path d="M23 3a10.9 10.9 0 01-3.14 1.53 4.48 4.48 0 00-7.86 3v1A10.66 10.66 0 013 4s-4 9 5 13a11.64 11.64 0 01-7 2c9 5 20 0 20-11.5a4.5 4.5 0 00-.08-.83A7.72 7.72 0 0023 3z"/>
                                                </svg>
                                            </button>
                                        </div>
                                        <div class="flex items-center space-x-2 ml-4">
                                            <button class="w-8 h-8 bg-red-500 rounded-full flex items-center justify-center text-white hover:bg-red-600 transition-colors">
                                                <svg class="w-4 h-4" fill="currentColor" viewBox="0 0 24 24">
                                                    <path d="M12 21.35l-1.45-1.32C5.4 15.36 2 12.28 2 8.5 2 5.42 4.42 3 7.5 3c1.74 0 3.41.81 4.5 2.09C13.09 3.81 14.76 3 16.5 3 19.58 3 22 5.42 22 8.5c0 3.78-3.4 6.86-8.55 11.54L12 21.35z"/>
                                                </svg>
                                            </button>
                                            <span class="text-sm text-gray-600">0</span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            
                            <!-- Right Column - Product Details -->
                            <div class="space-y-6">
                                <!-- Report Link -->
                                <div class="text-right">
                                    <a href="#" class="text-sm text-gray-500 hover:text-gray-700">Tố cáo</a>
                                </div>
                                
                                <!-- Product Title -->
                                <h1 class="text-2xl font-semibold text-gray-800 leading-tight">
                                    <%= product.getName() %>
                                </h1>
                                
                                <!-- Rating -->
                                <div class="text-sm text-gray-600">
                                    Chưa Có Đánh Giá
                                </div>
                                
                                <!-- Price -->
                                <div class="text-3xl font-bold price-color">
                                    ₫<%= String.format("%,.0f", product.getPrice()) %>
                                </div>
                                
                                <!-- Shipping Information -->
                                <div class="space-y-3">
                                    <div class="flex items-center space-x-3">
                                        <span class="text-sm text-gray-600">Vận Chuyển</span>
                                        <svg class="w-5 h-5 text-green-500" fill="currentColor" viewBox="0 0 24 24">
                                            <path d="M20 8h-3V4H3c-1.1 0-2 .9-2 2v11h2c0 1.66 1.34 3 3 3s3-1.34 3-3h4c0 1.66 1.34 3 3 3s3-1.34 3-3h2v-5l-3-4zM6 18.5c-.83 0-1.5-.67-1.5-1.5s.67-1.5 1.5-1.5 1.5.67 1.5 1.5-.67 1.5-1.5 1.5zm13.5-9l1.96 2.5H17V9.5h2.5zm-1.5 9c-.83 0-1.5-.67-1.5-1.5s.67-1.5 1.5-1.5 1.5.67 1.5 1.5-.67 1.5-1.5 1.5z"/>
                                        </svg>
                                    </div>
                                    <div class="text-sm text-gray-800">
                                        Nhận từ 20 Th08 - 23 Th08, phí giao ₫0 >
                                    </div>
                                    <div class="text-sm text-gray-600">
                                        Tặng Voucher ₫15.000 nếu đơn giao sau thời gian trên.
                                    </div>
                                </div>
                                
                                <!-- Quantity Selector -->
                                <div class="space-y-2">
                                    <label class="text-sm text-gray-600">Số Lượng</label>
                                    <div class="flex items-center space-x-0">
                                        <button class="w-10 h-10 border border-gray-300 bg-gray-100 text-gray-600 hover:bg-gray-200 transition-colors rounded-l-lg">
                                            -
                                        </button>
                                        <input type="number" value="1" min="1" class="w-16 h-10 border-t border-b border-gray-300 text-center focus:outline-none focus:ring-2 focus:ring-blue-500">
                                        <button class="w-10 h-10 border border-gray-300 bg-gray-100 text-gray-600 hover:bg-gray-200 transition-colors rounded-r-lg">
                                            +
                                        </button>
                                    </div>
                                </div>
                                
                                <!-- Action Buttons -->
                                <div class="space-y-4 pt-4">
                                    <button class="w-full py-3 px-6 bg-primary text-white font-medium rounded-lg border hover:bg-opacity-90 transition-all flex items-center justify-center space-x-2">
                                        <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M16 10a4 4 0 0 1-8 0"/>
                                            <path d="M3.103 6.034h17.794"/>
                                            <path d="M3.4 5.467a2 2 0 0 0-.4 1.2V20a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2V6.667a2 2 0 0 0-.4-1.2l-2-2.667A2 2 0 0 0 17 2H7a2 2 0 0 0-1.6.8z"/>
                                        </svg>
                                        <span>Thêm Vào Giỏ Hàng</span>
                                    </button>
                                    
                                    <button class="w-full py-3 px-6 bg-primary text-white font-medium rounded-lg transition-all">
                                        Mua Ngay
                                    </button>
                                </div>
                                
                                <!-- Product Description -->
                                <% if (product.getDescription() != null && !product.getDescription().isEmpty()) { %>
                                <div class="pt-6 border-t border-gray-200">
                                    <h3 class="text-lg font-semibold text-gray-800 mb-3">Mô tả sản phẩm</h3>
                                    <div class="text-gray-600 leading-relaxed">
                                        <%= product.getDescription() %>
                                    </div>
                                </div>
                                <% } %>
                            </div>
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
