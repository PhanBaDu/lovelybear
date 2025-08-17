<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="data.dao.CartDao" %>
<%@ page import="data.implementations.CartImplementation" %>
<%@ page import="data.models.Cart" %>
<%@ page import="data.models.CartItem" %>
<%@ page import="data.models.User" %>
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
        // Lấy thông tin giỏ hàng từ database
        List<CartItem> cartItems = null;
        int cartItemCount = 0;
        BigDecimal totalAmount = BigDecimal.ZERO;
        User currentUser = (User) session.getAttribute("user");
        
        if (currentUser != null) {
            try {
                CartDao cartDao = new CartImplementation();
                Cart userCart = cartDao.getCartByUserEmail(currentUser.getEmail());
                
                if (userCart != null) {
                    cartItems = cartDao.getCartItems(userCart.getId());
                    cartItemCount = cartDao.getCartItemCount(userCart.getId());
                    
                    // Tính tổng tiền
                    if (cartItems != null) {
                        for (CartItem item : cartItems) {
                            totalAmount = totalAmount.add(item.getPrice().multiply(new BigDecimal(item.getQuantity())));
                        }
                    }
                }
            } catch (Exception e) {
                System.err.println("Error loading cart: " + e.getMessage());
            }
        }
        
        // Nếu chưa đăng nhập, redirect về trang đăng nhập
        if (currentUser == null) {
            response.sendRedirect("../signin.jsp?message=Please login to view your cart");
            return;
        }
        %>
        
        <div class="flex flex-col min-h-screen justify-between bg-muted">
            <jsp:include page="../components/chatbot.jsp" />
            <jsp:include page="../components/header.jsp" />
            
            <div class="pt-24 px-5 w-full pb-32">
                <div class="max-w-4xl mx-auto">
                    <h1 class="text-3xl font-bold text-foreground mb-8">Giỏ Hàng</h1>
                    
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
                    %>
                            <div class="grid grid-cols-1 lg:grid-cols-3 gap-8">
                                <!-- Danh sách sản phẩm trong giỏ hàng -->
                                <div class="lg:col-span-2">
                                    <div class="bg-card rounded-lg p-6">
                                        <h2 class="text-xl font-semibold mb-4">Sản phẩm trong giỏ hàng</h2>
                                        
                                        <%
                                        for (CartItem item : cartItems) {
                                            BigDecimal itemTotal = item.getPrice().multiply(new BigDecimal(item.getQuantity()));
                                        %>
                                            <div class="flex items-center gap-4 py-4 border-b border-border last:border-b-0">
                                                <div class="w-20 h-20 bg-muted rounded-lg flex-shrink-0">
                                                    <%
                                                    // Sử dụng ảnh placeholder cho sản phẩm
                                                    String imageUrl = request.getContextPath() + "/public/assets/images/product-placeholder.svg";
                                                    %>
                                                    <img src="<%= imageUrl %>" alt="<%= item.getProductName() %>" class="w-full h-full object-cover rounded-lg">
                                                </div>
                                                
                                                <div class="flex-1 min-w-0">
                                                    <h3 class="font-medium text-foreground truncate"><%= item.getProductName() %></h3>
                                                    <p class="text-sm text-muted-foreground line-clamp-2"><%= item.getProductDescription() != null ? item.getProductDescription() : "Không có mô tả" %></p>
                                                    <div class="flex items-center gap-4 mt-2">
                                                        <div class="flex items-center gap-2">
                                                            <label class="text-sm text-muted-foreground">Số lượng:</label>
                                                            <select onchange="updateQuantity(<%= item.getId() %>, this.value)" class="border rounded px-2 py-1 text-sm">
                                                                <%
                                                                for (int qty = 1; qty <= 10; qty++) {
                                                                    String selected = (item.getQuantity() == qty) ? "selected" : "";
                                                                %>
                                                                    <option value="<%= qty %>" <%= selected %>><%= qty %></option>
                                                                <%
                                                                }
                                                                %>
                                                            </select>
                                                        </div>
                                                        <button onclick="removeItem(<%= item.getId() %>)" class="text-red-500 hover:text-red-700 text-sm">
                                                            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                                                <path d="M3 6h18"/>
                                                                <path d="M19 6v14c0 1-1 2-2 2H7c-1 0-2-1-2-2V6"/>
                                                                <path d="M8 6V4c0-1 1-2 2-2h4c1 0 2 1 2 2v2"/>
                                                            </svg>
                                                        </button>
                                                    </div>
                                                </div>
                                                
                                                <div class="text-right flex-shrink-0">
                                                    <p class="font-semibold text-primary"><%= String.format("%,.0f", item.getPrice()) %>đ</p>
                                                    <p class="text-sm text-muted-foreground">Tổng: <%= String.format("%,.0f", itemTotal) %>đ</p>
                                                </div>
                                            </div>
                                        <%
                                        }
                                        %>
                                    </div>
                                </div>
                                
                                <!-- Tổng quan giỏ hàng -->
                                <div class="lg:col-span-1">
                                    <div class="bg-card rounded-lg p-6 sticky top-24">
                                        <h2 class="text-xl font-semibold mb-4">Tổng quan</h2>
                                        
                                        <div class="space-y-3 mb-6">
                                            <div class="flex justify-between">
                                                <span class="text-muted-foreground">Tổng sản phẩm:</span>
                                                <span class="font-medium"><%= cartItemCount %></span>
                                            </div>
                                            <div class="flex justify-between">
                                                <span class="text-muted-foreground">Tổng tiền:</span>
                                                <span class="font-semibold text-primary text-lg"><%= String.format("%,.0f", totalAmount) %>đ</span>
                                            </div>
                                        </div>
                                        
                                        <button onclick="checkout()" class="w-full bg-primary text-white py-3 rounded-lg hover:bg-primary/90 transition-colors font-medium">
                                            Thanh toán
                                        </button>
                                        
                                        <button onclick="clearCart()" class="w-full bg-muted text-foreground py-2 rounded-lg hover:bg-muted/80 transition-colors mt-3">
                                            Xóa giỏ hàng
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
        </script>
    </body>
</html>
