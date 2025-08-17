<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="data.dao.Database"%>
<%@page import="data.dao.ProductDao"%>
<%@page import="data.dao.ProductImageDao"%>
<%@page import="data.models.Product"%>
<%@page import="data.models.ProductImage"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="icon" type="image/x-icon" href="logo-title.ico">
        <title>Trang Chủ</title>
        <link rel="stylesheet" href="./public/assets/styles/globals.css">
        <script src="https://cdn.jsdelivr.net/npm/@tailwindcss/browser@4"></script>
        <style>
        /* Thêm vào head của trang */
        .flex.justify-end {
            justify-content: flex-end !important;
        }
        </style>
    </head>
    <body> 
        <div class="flex flex-col min-h-screen justify-between bg-muted">
            <jsp:include page="./components/chatbot.jsp" />
            <jsp:include page="./components/header.jsp" />
            <div class="pt-24 px-5 w-full pb-32">
                <div class="max-w-6xl mx-auto">
                    <div class="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 lg:grid-cols-4 gap-6">
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
                            <a href="product?id=<%= product.getId() %>" class="block rounded-lg overflow-hidden h-96 bg-card hover:shadow-xl transition-shadow">
                                <div class="h-[70%] w-full overflow-hidden">
                                    <% if (mainImageUrl != null && !mainImageUrl.isEmpty()) { %>
                                        <img class="h-full w-full object-cover hover:scale-105 transition-transform duration-300" 
                                             src="<%= request.getContextPath() + mainImageUrl %>" 
                                             alt="<%= product.getName() %>" />
                                    <% } else { %>
                                        <div class="h-full w-full bg-muted flex items-center justify-center">
                                            <svg class="w-16 h-16 text-muted-foreground" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 16l4.586-4.586a2 2 0 012.828 0L16 16m-2-2l1.586-1.586a2 2 0 012.828 0L20 14m-6-6h.01M6 20h12a2 2 0 002-2V6a2 2 0 00-2-2H6a2 2 0 00-2 2v12a2 2 0 002 2z"></path>
                                            </svg>
                                        </div>
                                    <% } %>
                                </div>
                                <div class="h-[30%] p-4 flex flex-col justify-between gap-2">
                                    <div class="overflow-hidden">
                                        <h3 class="text-sm font-medium text-foreground line-clamp-2">
                                            <%= product.getName() %>
                                        </h3>
                                        <% if (product.getDescription() != null && !product.getDescription().isEmpty()) { %>
                                            <p class="text-xs text-muted-foreground line-clamp-1 mt-1">
                                                <%= product.getDescription() %>
                                            </p>
                                        <% } %>
                                    </div>
                                    <div class="flex items-center justify-between">
                                        <div class="flex items-center gap-1">
                                            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="#ff2056" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                                <rect width="20" height="12" x="2" y="6" rx="2"/>
                                                <circle cx="12" cy="12" r="2"/>
                                                <path d="M6 12h.01M18 12h.01"/>
                                            </svg>
                                            <span class="text-primary font-semibold text-base">
                                                <%= String.format("%,.0f", product.getPrice()) %>đ
                                            </span>
                                        </div>
                                        <button class="bg-primary text-white shadow-xs hover:bg-primary/90 focus-visible:ring-primary/20 dark:focus-visible:ring-primary/40 dark:bg-primary/60 add button inline-flex items-center justify-center gap-2 whitespace-nowrap rounded-[6px] text-xs px-3 py-2 cursor-pointer transition-colors">
                                            <svg xmlns="http://www.w3.org/2000/svg" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                                <path d="M16 10a4 4 0 0 1-8 0"/>
                                                <path d="M3.103 6.034h17.794"/>
                                                <path d="M3.4 5.467a2 2 0 0 0-.4 1.2V20a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2V6.667a2 2 0 0 0-.4-1.2l-2-2.667A2 2 0 0 0 17 2H7a2 2 0 0 0-1.6.8z"/>
                                            </svg>
                                        </button>
                                    </div>
                                </div>
                            </a>
                        <% 
                                }
                            } else {
                        %>
                            <div class="col-span-full text-center py-12">
                                <svg class="w-16 h-16 text-muted-foreground mx-auto mb-4" xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-database-icon lucide-database"><ellipse cx="12" cy="5" rx="9" ry="3"/><path d="M3 5V19A9 3 0 0 0 21 19V5"/><path d="M3 12A9 3 0 0 0 21 12"/></svg>
                                <h3 class="text-lg font-medium text-foreground mb-2">Chưa có sản phẩm nào</h3>
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
    </body>
</html>