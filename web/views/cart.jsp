<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="data.models.Cart" %>
<%@ page import="data.models.CartItem" %>
<%@ page import="data.models.User" %>
<%@ page import="data.models.ProductImage" %>
<%@ page import="data.dao.ProductImageDao" %>
<%@ page import="data.implementations.ProductImageImplementation" %>
<%@ page import="java.util.List" %>
<%@ page import="java.math.BigDecimal" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="icon" type="image/x-icon" href="${pageContext.request.contextPath}/logo-title.ico">
        <title>Giỏ Hàng</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/public/assets/styles/globals.css">
        <script src="https://cdn.jsdelivr.net/npm/@tailwindcss/browser@4"></script>
    </head>
    <body> 
        <%
        // Nhận dữ liệu từ Servlet đã set vào request
        List<CartItem> cartItems = (List<CartItem>) request.getAttribute("cartItems");
        Integer cartItemCountAttr = (Integer) request.getAttribute("cartItemCount");
        BigDecimal totalAmountAttr = (BigDecimal) request.getAttribute("totalAmount");
        int cartItemCount = cartItemCountAttr != null ? cartItemCountAttr : 0;
        BigDecimal totalAmount = totalAmountAttr != null ? totalAmountAttr : BigDecimal.ZERO;
        %>
        
        <div class="flex flex-col min-h-screen justify-between bg-muted">
            <jsp:include page="../components/chatbot.jsp" />
            <jsp:include page="../components/header.jsp" />
            
            <div class="pt-24 px-5 w-full pb-32">
                <div class="w-full mx-auto bg-background rounded-lg overflow-hidden">
                    <%
                    if (cartItems == null || cartItems.isEmpty()) {
                    %>
                            <div class="text-center py-12">
                                <svg class="w-16 h-16 text-muted-foreground mx-auto mb-4" xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                    <path d="M16 10a4 4 0 0 1-8 0"/>
                                    <path d="M3.103 6.034h17.794"/>
                                    <path d="M3.4 5.467a2 2 0 0 0-.4 1.2V20a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2V6.667a2 2 0 0 0-.4-1.2l-2-2.667A2 2 0 0 0 17 2H7a2 2 0 0 0-1.6.8z"/>
                                </svg>
                                <h3 class="text-lg font-medium text-foreground mb-2">Giỏ hàng trống</h3>
                                <p class="text-muted-foreground mb-4">Bạn chưa có sản phẩm nào trong giỏ hàng.</p>
                                <a href="${pageContext.request.contextPath}/index.jsp" class="bg-primary text-white px-6 py-2 rounded-lg hover:bg-primary/90 transition-colors">
                                    Tiếp tục mua sắm
                                </a>
                            </div>
                    <%
                    } else {
                        // Nhóm sản phẩm theo shop (giả sử tất cả đều từ cùng 1 shop)
                        
                    %>
                            <!-- Bảng giỏ hàng với layout giống Shopee -->
                            <div class="bg-white rounded-lg shadow-sm">
                                <!-- Headers -->
                                <div class="grid grid-cols-12 gap-4 p-4 border-b border-gray-200 bg-gray-50 font-medium text-sm text-gray-600">
                                    <div class="col-span-1">
                                        <input type="checkbox" id="selectAll" onchange="toggleSelectAll(this)" class="rounded border-gray-300">
                                    </div>
                                    <div class="col-span-5">Sản Phẩm</div>
                                    <div class="col-span-2">Đơn Giá</div>
                                    <div class="col-span-2">Số Lượng</div>
                                    <div class="col-span-2">Số Tiền</div>
                                </div>
                                
                                <!-- Shop Section -->
                                <div class="border-b border-gray-200">
                                    <!-- Products -->
                                    <%
                                    ProductImageDao imageDao = new ProductImageImplementation();
                                    for (CartItem item : cartItems) {
                                        BigDecimal itemTotal = item.getPrice().multiply(new BigDecimal(item.getQuantity()));
                                        
                                        // Lấy ảnh đầu tiên của sản phẩm
                                        List<ProductImage> images = imageDao.getProductImagesByProductId(item.getProductId());
                                        String imageUrl = request.getContextPath() + "/public/assets/images/product-placeholder.svg";
                                        if (images != null && !images.isEmpty()) {
                                            imageUrl = request.getContextPath() + images.get(0).getImageUrl();
                                        }
                                    %>
                                        <div class="p-4 border-b border-gray-100 last:border-b-0">
                                            <div class="grid grid-cols-12 gap-4 items-center">
                                                <div class="col-span-1">
                                                    <input type="checkbox" class="product-checkbox rounded border-gray-300" data-item-id="<%= item.getId() %>">
                                                </div>
                                                <div class="col-span-5">
                                                    <div class="flex items-start gap-3">
                                                        <div class="relative w-20 h-20 flex-shrink-0">
                                                            <img src="<%= imageUrl %>" alt="<%= item.getProductName() %>" class="w-full h-full object-cover rounded-lg">
                                                            <div class="absolute -top-1 -right-1 bg-blue-500 text-white text-xs px-1 py-0.5 rounded">SIÊU RẺ</div>
                                                        </div>
                                                        <div class="flex-1 min-w-0">
                                                            <h3 class="font-medium text-gray-900 text-sm leading-tight mb-1"><%= item.getProductName() %></h3>
                                                            <div class="flex items-center gap-2 text-xs text-gray-500">
                                                                <span>Phân Loại Hàng:</span>
                                                                <span class="text-gray-700">MIX3 - Đậu Trà Cam, 200G</span>
                                                                <svg class="w-3 h-3" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 9l-7 7-7-7"/>
                                                                </svg>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-span-2">
                                                    <div class="text-right">
                                                        <p class="text-gray-400 line-through text-sm">₫<%= String.format("%,.0f", item.getPrice().multiply(new BigDecimal("1.3")).doubleValue()) %></p>
                                                        <p class="text-red-500 font-medium">₫<%= String.format("%,.0f", item.getPrice()) %></p>
                                                    </div>
                                                </div>
                                                <div class="col-span-2">
                                                    <div class="flex items-center border border-gray-300 rounded-lg">
                                                        <button onclick="updateQuantity(<%= item.getId() %>, <%= item.getQuantity() - 1 %>)" class="w-8 h-8 flex items-center justify-center text-gray-600 hover:bg-gray-100">-</button>
                                                        <input type="number" value="<%= item.getQuantity() %>" min="1" class="w-12 h-8 text-center border-0 focus:ring-0 text-sm" onchange="updateQuantity(<%= item.getId() %>, this.value)">
                                                        <button onclick="updateQuantity(<%= item.getId() %>, <%= item.getQuantity() + 1 %>)" class="w-8 h-8 flex items-center justify-center text-gray-600 hover:bg-gray-100">+</button>
                                                    </div>
                                                </div>
                                                <div class="col-span-2">
                                                    <div class="text-right">
                                                        <p class="text-red-500 font-medium">₫<%= String.format("%,.0f", itemTotal) %></p>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="mt-3 ml-8 flex items-center gap-4 text-sm">
                                                <button onclick="removeItem(<%= item.getId() %>)" class="text-red-500 hover:text-red-700">Xóa</button>
                                                <button class="text-gray-500 hover:text-gray-700">Tìm sản phẩm tương tự</button>
                                            </div>
                                        </div>
                                    <%
                                    }
                                    %>
                                </div>
                                

                                
                                <!-- Bottom Summary Bar -->
                                <div class="p-4 bg-gray-50 border-t border-gray-200">
                                    <div class="flex items-center justify-between">
                                        <div class="flex items-center gap-4">
                                            <label class="flex items-center gap-2">
                                                <input type="checkbox" id="selectAllBottom" onchange="toggleSelectAll(this)" class="rounded border-gray-300">
                                                <span class="text-sm font-medium">Chọn Tất Cả (<%= cartItemCount %>)</span>
                                            </label>
                                            <button onclick="deleteSelected()" class="text-sm text-red-600 hover:text-red-700">Xóa</button>
                                        </div>
                                        <div class="flex items-center gap-6">
                                            <div class="text-right">
                                                <p class="text-sm text-gray-600">Tổng cộng (<%= cartItemCount %> Sản phẩm): <span class="text-red-500 font-bold text-lg">₫<%= String.format("%,.0f", totalAmount) %></span></p>
                                            </div>
                                            <button onclick="checkout()" class="bg-orange-500 text-white px-8 py-3 rounded-lg hover:bg-orange-600 transition-colors font-medium">
                                                Mua Hàng
                                            </button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                    <%
                    }
                    %>
                </div>
            </div>
            
            <jsp:include page="../components/footer.jsp" />
        </div>
        
        <script>
        function updateQuantity(itemId, quantity) {
            // Tạo form để gửi request cập nhật số lượng
            const form = document.createElement('form');
            form.method = 'POST';
            form.action = '${pageContext.request.contextPath}/update-cart-item';
            
            const itemIdInput = document.createElement('input');
            itemIdInput.type = 'hidden';
            itemIdInput.name = 'itemId';
            itemIdInput.value = itemId;
            form.appendChild(itemIdInput);
            
            const quantityInput = document.createElement('input');
            quantityInput.type = 'hidden';
            quantityInput.name = 'quantity';
            quantityInput.value = quantity;
            form.appendChild(quantityInput);
            
            document.body.appendChild(form);
            form.submit();
        }
        
        function removeItem(itemId) {
            if (confirm('Bạn có chắc muốn xóa sản phẩm này khỏi giỏ hàng?')) {
                const form = document.createElement('form');
                form.method = 'POST';
                form.action = '${pageContext.request.contextPath}/remove-cart-item';
                
                const itemIdInput = document.createElement('input');
                itemIdInput.type = 'hidden';
                itemIdInput.name = 'itemId';
                itemIdInput.value = itemId;
                form.appendChild(itemIdInput);
                
                document.body.appendChild(form);
                form.submit();
            }
        }
        
        function clearCart() {
            if (confirm('Bạn có chắc muốn xóa toàn bộ giỏ hàng?')) {
                const form = document.createElement('form');
                form.method = 'POST';
                form.action = '${pageContext.request.contextPath}/clear-cart';
                
                document.body.appendChild(form);
                form.submit();
            }
        }
        
        function checkout() {
            alert('Chức năng thanh toán sẽ được phát triển sau!');
        }
        
        function toggleSelectAll(checkbox) {
            const isChecked = checkbox.checked;
            
            // Cập nhật cả hai checkbox select all
            document.getElementById('selectAll').checked = isChecked;
            document.getElementById('selectAllBottom').checked = isChecked;
            
            // Cập nhật tất cả checkbox sản phẩm
            const productCheckboxes = document.querySelectorAll('.product-checkbox');
            productCheckboxes.forEach(cb => {
                cb.checked = isChecked;
            });
            
            // Cập nhật checkbox shop
            const shopCheckbox = document.querySelector('.shop-checkbox');
            if (shopCheckbox) {
                shopCheckbox.checked = isChecked;
            }
        }
        
        function deleteSelected() {
            const selectedItems = document.querySelectorAll('.product-checkbox:checked');
            if (selectedItems.length === 0) {
                alert('Vui lòng chọn sản phẩm để xóa!');
                return;
            }
            
            if (confirm(`Bạn có chắc muốn xóa ${selectedItems.length} sản phẩm đã chọn?`)) {
                const itemIds = Array.from(selectedItems).map(cb => cb.dataset.itemId);
                
                // Gửi request xóa nhiều sản phẩm
                const form = document.createElement('form');
                form.method = 'POST';
                form.action = '${pageContext.request.contextPath}/remove-cart-item';
                
                itemIds.forEach(itemId => {
                    const input = document.createElement('input');
                    input.type = 'hidden';
                    input.name = 'itemIds';
                    input.value = itemId;
                    form.appendChild(input);
                });
                
                document.body.appendChild(form);
                form.submit();
            }
        }
        </script>
    </body>
</html>
