<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="data.models.CartItem" %>
<%@ page import="data.models.User" %>
<%@ page import="data.models.ProductImage" %>
<%@ page import="data.dao.ProductImageDao" %>
<%@ page import="data.dao.CartDao" %>
<%@ page import="data.implementations.ProductImageImplementation" %>
<%@ page import="data.implementations.CartImplementation" %>
<%@ page import="java.util.List" %>
<%@ page import="java.math.BigDecimal" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="icon" type="image/x-icon" href="${pageContext.request.contextPath}/logo-title.ico">
        <title>Thanh Toán</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/public/assets/styles/globals.css">
        <script src="https://cdn.jsdelivr.net/npm/@tailwindcss/browser@4"></script>
    </head>
    <body> 
        <%
            // Lấy thông tin user từ session
            User user = (User) session.getAttribute("user");
            if (user == null) {
                response.sendRedirect(request.getContextPath() + "/signin.jsp");
                return;
            }
            
            // Lấy danh sách sản phẩm đã chọn từ request
            String[] selectedItemIds = request.getParameterValues("selectedItems");
            List<CartItem> selectedItems = null;
            BigDecimal totalAmount = BigDecimal.ZERO;
            int totalQuantity = 0;
            
            if (selectedItemIds != null && selectedItemIds.length > 0) {
                // TODO: Lấy thông tin sản phẩm từ database dựa trên selectedItemIds
                // Hiện tại sẽ hiển thị placeholder
                ProductImageDao imageDao = new ProductImageImplementation();
            }
        %>
        
        <div class="flex flex-col min-h-screen justify-between bg-muted">
            <jsp:include page="../components/header.jsp" />
            
            <div class="pt-24 px-5 w-full pb-32">
                <div class="max-w-4xl mx-auto">
                    <h1 class="text-2xl font-bold text-gray-900 mb-8 text-center">Thanh Toán Đơn Hàng</h1>
                    
                    <div class="grid grid-cols-1 lg:grid-cols-3 gap-8">
                        <!-- Left Column - Order Summary -->
                        <div class="lg:col-span-2">
                            <!-- User Information Section -->
                            <div class="bg-white rounded-lg shadow-sm p-6 mb-6">
                                <div class="flex items-center gap-3 mb-4">
                                    <div class="w-8 h-8 bg-red-100 rounded-full flex items-center justify-center">
                                        <svg class="w-5 h-5 text-red-500" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17.657 16.657L13.414 20.9a1.998 1.998 0 01-2.827 0l-4.244-4.243a8 8 0 1111.314 0z"/>
                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 11a3 3 0 11-6 0 3 3 0 016 0z"/>
                                        </svg>
                                    </div>
                                    <h2 class="text-lg font-semibold text-red-600">Địa Chỉ Nhận Hàng</h2>
                                </div>
                                
                                <div class="space-y-3">
                                    <div>
                                        <label class="block text-sm font-medium text-gray-700 mb-1">Họ và tên</label>
                                        <input type="text" value="<%= user.getFullName() != null ? user.getFullName() : "Chưa cập nhật" %>" 
                                               class="w-full px-3 py-2 border border-gray-300 rounded-lg bg-gray-50 text-gray-600" 
                                               disabled>
                                    </div>
                                    
                                    <div>
                                        <label class="block text-sm font-medium text-gray-700 mb-1">Số điện thoại</label>
                                        <input type="text" value="<%= user.getSodienthoai() != null ? user.getSodienthoai() : "Chưa cập nhật" %>" 
                                               class="w-full px-3 py-2 border border-gray-300 rounded-lg bg-gray-50 text-gray-600" 
                                               disabled>
                                    </div>
                                    
                                    <div>
                                        <label class="block text-sm font-medium text-gray-700 mb-1">Địa chỉ</label>
                                        <textarea class="w-full px-3 py-2 border border-gray-300 rounded-lg bg-gray-50 text-gray-600" 
                                                  rows="3" disabled><%= user.getAddress() != null ? user.getAddress() : "Chưa cập nhật" %></textarea>
                                    </div>
                                </div>
                            </div>
                            
                            <!-- Payment Method Section -->
                            <div class="bg-white rounded-lg shadow-sm p-6">
                                <h3 class="text-lg font-semibold text-gray-900 mb-4">Phương Thức Thanh Toán</h3>
                                <div class="space-y-3">
                                    <label class="flex items-center gap-3 p-3 border border-gray-200 rounded-lg cursor-pointer hover:border-gray-300">
                                        <input type="radio" name="paymentMethod" value="cod" checked 
                                               class="w-4 h-4 text-primary border-gray-300 focus:ring-primary">
                                        <div class="flex items-center gap-2">
                                            <svg class="w-5 h-5 text-green-500" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8c-1.657 0-3 .895-3 2s1.343 2 3 2 3 .895 3 2-1.343 2-3 2m0-8c1.11 0 2.08.402 2.599 1M12 8V7m0 1v8m0 0v1m0-1c-1.11 0-2.08-.402-2.599-1"/>
                                            </svg>
                                            <span class="font-medium">Thanh toán khi nhận hàng (COD)</span>
                                        </div>
                                    </label>
                                </div>
                            </div>
                        </div>
                        
                        <!-- Right Column - Order Summary -->
                        <div class="lg:col-span-1">
                            <div class="bg-white rounded-lg shadow-sm p-6 sticky top-24">
                                <h3 class="text-lg font-semibold text-gray-900 mb-4">Tóm Tắt Đơn Hàng</h3>
                                
                                <!-- Selected Products -->
                                <div class="space-y-3 mb-4">
                                    <%
                                    if (selectedItemIds != null && selectedItemIds.length > 0) {
                                        ProductImageDao imageDao = new ProductImageImplementation();
                                        BigDecimal productsTotalAmount = BigDecimal.ZERO;
                                        int productsTotalQuantity = 0;
                                        
                                        for (String itemId : selectedItemIds) {
                                            try {
                                                int itemIdInt = Integer.parseInt(itemId);
                                                // Lấy thông tin thực từ database dựa trên itemId
                                                CartDao cartDao = new CartImplementation();
                                                CartItem cartItem = cartDao.getCartItemById(itemIdInt);
                                                
                                                if (cartItem != null) {
                                                    BigDecimal itemPrice = cartItem.getPrice();
                                                    int itemQuantity = cartItem.getQuantity();
                                                    String productName = cartItem.getProductName();
                                                    BigDecimal itemTotal = itemPrice.multiply(new BigDecimal(itemQuantity));
                                                    
                                                    // Lấy ảnh sản phẩm
                                                    List<ProductImage> images = imageDao.getProductImagesByProductId(cartItem.getProductId());
                                                    String imageUrl = request.getContextPath() + "/public/assets/images/product-placeholder.svg";
                                                    if (images != null && !images.isEmpty()) {
                                                        imageUrl = request.getContextPath() + images.get(0).getImageUrl();
                                                    }
                                                    
                                                    productsTotalAmount = productsTotalAmount.add(itemTotal);
                                                    productsTotalQuantity += itemQuantity;
                                    %>
                                        <div class="flex items-center gap-3 p-3 border border-gray-100 rounded-lg">
                                            <div class="w-12 h-12 flex-shrink-0">
                                                <img src="<%= imageUrl %>" alt="<%= productName %>" class="w-full h-full object-cover rounded-lg">
                                            </div>
                                            <div class="flex-1 min-w-0">
                                                <h4 class="text-sm font-medium text-gray-900 truncate"><%= productName %></h4>
                                                <p class="text-xs text-gray-500">Số lượng: <%= itemQuantity %></p>
                                            </div>
                                            <div class="text-right">
                                                <p class="text-sm font-medium text-gray-900"><%= String.format("%,.0f", itemPrice) %>k</p>
                                            </div>
                                        </div>
                                    <%
                                                }
                                            } catch (NumberFormatException e) {
                                                // Bỏ qua itemId không hợp lệ
                                                continue;
                                            }
                                        }
                                    %>
                                        <!-- Total Summary -->
                                        <div class="border-t border-gray-200 pt-3 mt-4">
                                            <div class="flex justify-between text-sm font-medium">
                                                <span>Tổng số lượng:</span>
                                                <span><%= productsTotalQuantity %></span>
                                            </div>
                                        </div>
                                    <%
                                    } else {
                                    %>
                                        <div class="text-center py-8 text-gray-500">
                                            <svg class="w-12 h-12 mx-auto mb-3 text-gray-300" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M16 11V7a4 4 0 00-8 0v4M5 9h14l1 12H4L5 9z"/>
                                            </svg>
                                            <p>Không có sản phẩm nào được chọn</p>
                                        </div>
                                    <%
                                    }
                                    %>
                                </div>
                                
                                <!-- Order Total -->
                                <div class="border-t border-gray-200 pt-4 space-y-2">
                                    <%
                                    BigDecimal orderTotal = BigDecimal.ZERO;
                                    int orderQuantity = 0;
                                    
                                    if (selectedItemIds != null && selectedItemIds.length > 0) {
                                        CartDao cartDao = new CartImplementation();
                                        for (String itemId : selectedItemIds) {
                                            try {
                                                int itemIdInt = Integer.parseInt(itemId);
                                                CartItem cartItem = cartDao.getCartItemById(itemIdInt);
                                                
                                                if (cartItem != null) {
                                                    BigDecimal itemPrice = cartItem.getPrice();
                                                    int itemQuantity = cartItem.getQuantity();
                                                    BigDecimal itemTotal = itemPrice.multiply(new BigDecimal(itemQuantity));
                                                    
                                                    orderTotal = orderTotal.add(itemTotal);
                                                    orderQuantity += itemQuantity;
                                                }
                                            } catch (NumberFormatException e) {
                                                continue;
                                            }
                                        }
                                    }
                                    %>
                                    <div class="flex justify-between text-sm">
                                        <span class="text-gray-600">Tạm tính:</span>
                                        <span class="font-medium"><%= String.format("%,.0f", orderTotal) %>k</span>
                                    </div>
                                    <div class="flex justify-between text-sm">
                                        <span class="text-gray-600">Phí vận chuyển:</span>
                                        <span class="font-medium">0đ</span>
                                    </div>
                                    <div class="flex justify-between text-lg font-bold text-red-600">
                                        <span>Tổng cộng:</span>
                                        <span><%= String.format("%,.0f", orderTotal) %>k</span>
                                    </div>
                                </div>
                                
                                <!-- Place Order Button -->
                                <button onclick="placeOrder()" 
                                        class="w-full mt-6 bg-primary text-white py-3 px-6 rounded-lg font-medium hover:bg-primary/90 transition-colors">
                                    Đặt Hàng
                                </button>
                                
                                <p class="text-xs text-gray-500 text-center mt-3">
                                    Bằng việc đặt hàng, bạn đồng ý với <a href="#" class="text-primary hover:underline">điều khoản sử dụng</a>
                                </p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            
            <jsp:include page="../components/footer.jsp" />
        </div>
        
        <script>
        function placeOrder() {
            if (confirm('Bạn có chắc muốn đặt hàng?')) {
                // Tạo form để submit
                const form = document.createElement('form');
                form.method = 'POST';
                form.action = '${pageContext.request.contextPath}/place-order';
                
                // Thêm selectedItemIds vào form
                <% 
                if (selectedItemIds != null && selectedItemIds.length > 0) {
                    for (String itemId : selectedItemIds) {
                %>
                    const input<%= itemId %> = document.createElement('input');
                    input<%= itemId %>.type = 'hidden';
                    input<%= itemId %>.name = 'selectedItems';
                    input<%= itemId %>.value = '<%= itemId %>';
                    form.appendChild(input<%= itemId %>);
                <%
                    }
                }
                %>
                
                // Submit form
                document.body.appendChild(form);
                form.submit();
            }
        }
        </script>
    </body>
</html>
