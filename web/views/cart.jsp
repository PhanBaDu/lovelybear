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
        <link rel="icon" type="image/x-icon" href="${pageContext.request.contextPath}/icon-title.ico">
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
        
        <div class="flex flex-col min-h-screen justify-between bg-muted" style="
        background-image: url('./public/assets/images/background.png');
        background-size: cover;
        background-position: center;
        background-repeat: no-repeat;
      ">
            <jsp:include page="../components/chatbot.jsp" />
            <jsp:include page="../components/header.jsp" />
            
            <div class="pt-24 px-5 w-full pb-32">
                <div class="max-w-6xl mx-auto bg-background rounded-lg overflow-hidden">
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
                        ProductImageDao imageDao = new ProductImageImplementation();
                    %>
                            <div class="bg-white rounded-lg shadow-sm p-6">
                                <h1 class="bg-muted w-full p-4 rounded-lg mb-6">Giỏ hàng của bạn</h1>                             
                                <!-- Cart Items -->
                                <div class="flex flex-col gap-5">
                                    <%
                                    for (CartItem item : cartItems) {
                                        BigDecimal itemTotal = item.getPrice().multiply(new BigDecimal(item.getQuantity()));
                                        
                                        // Lấy ảnh đầu tiên của sản phẩm
                                        List<ProductImage> images = imageDao.getProductImagesByProductId(item.getProductId());
                                        String imageUrl = request.getContextPath() + "/public/assets/images/product-placeholder.svg";
                                        if (images != null && !images.isEmpty()) {
                                            imageUrl = request.getContextPath() + images.get(0).getImageUrl();
                                        }
                                    %>
                                        <!-- Cart Item -->
                                        <div class="flex items-center gap-4 p-4 border border-gray-200 rounded-lg hover:border-gray-300 transition-colors">
                                            <!-- Checkbox -->
                                            <input type="checkbox" class="product-checkbox rounded border-gray-300" 
                                                   data-item-id="<%= item.getId() %>"
                                                   data-price="<%= item.getPrice() %>"
                                                   data-quantity="<%= item.getQuantity() %>">
                                            
                                            <!-- Product Image -->
                                            <div class="w-20 h-20 flex-shrink-0">
                                                <img src="<%= imageUrl %>" alt="<%= item.getProductName() %>" class="w-full h-full object-cover rounded-lg">
                                            </div>
                                            
                                            <!-- Product Info -->
                                            <div class="flex-1 min-w-0">
                                                <h3 class="font-medium text-gray-900 text-sm leading-tight mb-1"><%= item.getProductName() %></h3>
                                                <p class="text-xs text-gray-500">Mã SP: #<%= item.getProductId() %></p>
                                            </div>
                                            
                                            <!-- Price -->
                                            <div class="text-center">
                                                <p class="text-sm font-medium text-gray-900"><%= String.format("%,.0f", item.getPrice()) %>k</p>
                                                <p class="text-xs text-gray-500">Đơn giá</p>
                                            </div>
                                            
                                            <!-- Quantity Controls -->
                                            <div class="flex flex-col items-center gap-2">
                                                <div class="flex items-center border border-gray-300 rounded-lg">
                                                    <button onclick="updateQuantity(<%= item.getId() %>, <%= item.getQuantity() - 1 %>)" 
                                                            class="w-8 h-8 flex items-center justify-center text-gray-600 hover:bg-gray-100 disabled:opacity-50"
                                                            <%= item.getQuantity() <= 1 ? "disabled" : "" %>>
                                                        -
                                                    </button>
                                                    <input type="number" 
                                                           value="<%= item.getQuantity() %>" 
                                                           min="1" 
                                                           class="w-12 h-8 text-center border-0 focus:ring-0 text-sm" 
                                                           onchange="updateQuantity(<%= item.getId() %>, this.value)">
                                                    <button onclick="updateQuantity(<%= item.getId() %>, <%= item.getQuantity() + 1 %>)" 
                                                            class="w-8 h-8 flex items-center justify-center text-gray-600 hover:bg-gray-100">
                                                        +
                                                    </button>
                                                </div>
                                                <p class="text-xs text-gray-500">Số lượng</p>
                                            </div>
                                            
                                            <!-- Total Price -->
                                            <div class="text-center">
                                                <p class="text-sm font-semibold text-red-500"><%= String.format("%,.0f", itemTotal) %>k</p>
                                                <p class="text-xs text-gray-500">Tổng tiền</p>
                                            </div>
                                            
                                            <!-- Remove Button -->
                                            <button onclick="removeItem(<%= item.getId() %>)" 
                                                    class="w-8 h-8 flex items-center justify-center text-red-500 hover:bg-red-50 rounded-full transition-colors">
                                                <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 7l-.867 12.142A2 2 0 0116.138 21H7.862a2 2 0 01-1.995-1.858L5 7m5 4v6m4-6v6m1-10V4a1 1 0 00-1-1h-4a1 1 0 00-1 1v3M4 7h16"/>
                                                </svg>
                                            </button>
                                        </div>
                                    <%
                                    }
                                    %>
                                </div>
                                
                                <!-- Total Summary -->
                                <div class="mt-8 pt-6 border-t border-gray-200">
                                    <div class="flex items-center justify-between">
                                        <div class="flex items-center gap-4">
                                            <label class="flex items-center gap-2">
                                                <input type="checkbox" id="selectAll" onchange="toggleSelectAll(this)" class="rounded border-gray-300">
                                                <span class="text-sm font-medium">Chọn Tất Cả</span>
                                            </label>
                                            <div class="flex items-center gap-2 text-gray-600">
                                                <svg xmlns="http://www.w3.org/2000/svg" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-shopping-bag-icon lucide-shopping-bag"><path d="M16 10a4 4 0 0 1-8 0"/><path d="M3.103 6.034h17.794"/><path d="M3.4 5.467a2 2 0 0 0-.4 1.2V20a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2V6.667a2 2 0 0 0-.4-1.2l-2-2.667A2 2 0 0 0 17 2H7a2 2 0 0 0-1.6.8z"/></svg>
                                                <span class="text-sm">Tổng cộng (<span id="selectedCount">0</span> sản phẩm):</span>
                                            </div>
                                        </div>
                                        <div class="text-right">
                                            <span id="selectedTotal" class="text-primary font-bold">0</span>
                                            <span class="text-primary font-bold">k</span>
                                        </div>
                                    </div>
                                    
                                    <div class="flex gap-4 mt-6">
                                        <button onclick="checkout()" 
                                                class="cursor-pointer flex-1 bg-primary text-background text-sm px-6 py-2 rounded-lg transition-colors font-medium">
                                            Tiến hành đặt hàng
                                        </button>
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
            if (quantity < 1) {
                alert('Số lượng phải lớn hơn 0!');
                return;
            }
            
            // Update data attribute for the checkbox
            const checkbox = document.querySelector(`[data-item-id="${itemId}"]`);
            if (checkbox) {
                checkbox.dataset.quantity = quantity;
                updateSelectedTotal();
            }
            
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
            const selectedItems = document.querySelectorAll('.product-checkbox:checked');
            if (selectedItems.length === 0) {
                alert('Vui lòng chọn sản phẩm để thanh toán!');
                return;
            }
            
            // Lấy danh sách sản phẩm đã chọn
            const selectedItemIds = Array.from(selectedItems).map(cb => cb.dataset.itemId);
            
            // Tạo form để gửi dữ liệu đến checkout
            const form = document.createElement('form');
            form.method = 'POST';
            form.action = '${pageContext.request.contextPath}/checkout';
            
            // Thêm các sản phẩm đã chọn
            selectedItemIds.forEach(itemId => {
                const input = document.createElement('input');
                input.type = 'hidden';
                input.name = 'selectedItems';
                input.value = itemId;
                form.appendChild(input);
            });
            
            document.body.appendChild(form);
            form.submit();
        }
        
        function toggleSelectAll(checkbox) {
            const isChecked = checkbox.checked;
            const productCheckboxes = document.querySelectorAll('.product-checkbox');
            productCheckboxes.forEach(cb => {
                cb.checked = isChecked;
            });
            updateSelectedTotal();
        }
        
        function deleteSelected() {
            const selectedItems = document.querySelectorAll('.product-checkbox:checked');
            if (selectedItems.length === 0) {
                alert('Vui lòng chọn sản phẩm để xóa!');
                return;
            }
            
            if (confirm(`Bạn có chắc muốn xóa ${selectedItems.length} sản phẩm đã chọn?`)) {
                const itemIds = Array.from(selectedItems).map(cb => cb.dataset.itemId);
                
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
        
        // Auto-update select all checkbox when individual checkboxes change
        document.addEventListener('change', function(e) {
            if (e.target.classList.contains('product-checkbox')) {
                const allCheckboxes = document.querySelectorAll('.product-checkbox');
                const checkedCheckboxes = document.querySelectorAll('.product-checkbox:checked');
                const selectAllCheckbox = document.getElementById('selectAll');
                
                if (checkedCheckboxes.length === allCheckboxes.length) {
                    selectAllCheckbox.checked = true;
                    selectAllCheckbox.indeterminate = false;
                } else if (checkedCheckboxes.length === 0) {
                    selectAllCheckbox.checked = false;
                    selectAllCheckbox.indeterminate = false;
                } else {
                    selectAllCheckbox.checked = false;
                    selectAllCheckbox.indeterminate = true;
                }
                
                updateSelectedTotal();
            }
        });
        
        // Function to calculate total for selected items
        function updateSelectedTotal() {
            const checkedCheckboxes = document.querySelectorAll('.product-checkbox:checked');
            let selectedCount = 0;
            let selectedTotal = 0;
            
            checkedCheckboxes.forEach(checkbox => {
                const price = parseFloat(checkbox.dataset.price) || 0;
                const quantity = parseInt(checkbox.dataset.quantity) || 0;
                
                selectedCount += quantity;
                selectedTotal += price * quantity;
            });
            
            // Update display
            document.getElementById('selectedCount').textContent = selectedCount;
            document.getElementById('selectedTotal').textContent = selectedTotal.toLocaleString('vi-VN');
        }
        
        // Initialize total on page load
        document.addEventListener('DOMContentLoaded', function() {
            updateSelectedTotal();
        });
        </script>
    </body>
</html>
