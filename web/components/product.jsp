<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="data.dao.CartDao" %>
<%@ page import="data.implementations.CartImplementation" %>
<%@ page import="data.models.Cart" %>
<%@ page import="data.models.CartItem" %>
<%@ page import="data.models.User" %>

<div class="border rounded-lg overflow-hidden h-96">
    <img class="h-[70%] w-full object-cover" src="${product.imageUrl != null ? product.imageUrl : 'https://img.lazcdn.com/g/p/6806dd18f8aed18b6c3339b5d322e9d1.jpg_360x360q75.jpg_.webp'}" alt="${product.name}" />
    <div class="h-[30%] p-2 flex flex-col justify-between gap-1">
        <div class="overflow-hidden">
            <span class="text-sm line-clamp-2">
                ${product.name != null ? product.name : 'Giày thể thao Giày thể thao Giày thể thao Giày thể thao Giày thể thao Giày thể thao'}
            </span>
        </div>
        <div class="flex items-center justify-between">
            <p class="text-xs leading-none border w-fit p-0.5 rounded-xs border-destructive text-primary px-1">Rẻ vô địch</p>
            <div>
                <span class="text-xs text-muted-foreground">
                    Đã bán 10k+
                </span>
            </div>
        </div>
        <div class="text-sm flex items-center justify-between">
            <div class="flex items-center gap-1">
                <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="#ff2056" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-banknote-icon lucide-banknote"><rect width="20" height="12" x="2" y="6" rx="2"/><circle cx="12" cy="12" r="2"/><path d="M6 12h.01M18 12h.01"/></svg>
                <span class="text-primary font-semibold text-base">
                    ${product.price != null ? product.price : '120.000đ'}
                </span>
            </div>
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
                <!-- Sản phẩm đã có trong giỏ hàng -->
                <button disabled class="bg-gray-400 text-white shadow-xs inline-flex items-center justify-center gap-2 whitespace-nowrap rounded-[6px] text-xs px-2 py-1 cursor-not-allowed">
                    <svg xmlns="http://www.w3.org/2000/svg" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-check-icon lucide-check"><path d="m20 6-8.5 8.5L9 12"/></svg>
                    Đã có trong giỏ
                </button>
            <% } else { %>
                <!-- Sản phẩm chưa có trong giỏ hàng -->
                <button onclick="addToCart(${product.id != null ? product.id : 1})" class="bg-primary text-white shadow-xs hover:bg-destructive/90 focus-visible:ring-destructive/20 dark:focus-visible:ring-destructive/40 dark:bg-destructive/60 add button inline-flex items-center justify-center gap-2 whitespace-nowrap rounded-[6px] text-xs px-2 py-1 cursor-pointer">
                    <svg xmlns="http://www.w3.org/2000/svg" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-shopping-bag-icon lucide-shopping-bag"><path d="M16 10a4 4 0 0 1-8 0"/><path d="M3.103 6.034h17.794"/><path d="M3.4 5.467a2 2 0 0 0-.4 1.2V20a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2V6.667a2 2 0 0 0-.4-1.2l-2-2.667A2 2 0 0 0 17 2H7a2 2 0 0 0-1.6.8z"/></svg>
                    Thêm vào giỏ
                </button>
            <% } %>
        </div>
    </div>
</div>

<script>
function addToCart(productId) {
    // Tạo form để gửi request trực tiếp đến servlet
    const form = document.createElement('form');
    form.method = 'POST';
    form.action = 'add-to-cart.jsp';
    
    // Thêm input cho productId
    const productIdInput = document.createElement('input');
    productIdInput.type = 'hidden';
    productIdInput.name = 'productId';
    productIdInput.value = productId;
    form.appendChild(productIdInput);
    
    // Thêm input cho quantity (mặc định là 1)
    const quantityInput = document.createElement('input');
    quantityInput.type = 'hidden';
    quantityInput.name = 'quantity';
    quantityInput.value = 1;
    form.appendChild(quantityInput);
    
    // Thêm form vào body và submit
    document.body.appendChild(form);
    form.submit();
}
</script>