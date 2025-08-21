<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="data.models.Order" %>
<%@ page import="data.models.OrderItem" %>
<%@ page import="data.models.ProductImage" %>
<%@ page import="data.dao.ProductImageDao" %>
<%@ page import="data.implementations.ProductImageImplementation" %>
<%@ page import="data.constants.OrderStatus" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.math.BigDecimal" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chi Tiết Đơn Hàng</title>
    <link rel="icon" type="image/x-icon" href="icon-title.ico">
    <link rel="stylesheet" href="./public/assets/styles/globals.css">
    <script src="https://cdn.jsdelivr.net/npm/@tailwindcss/browser@4"></script>
</head>
<body class="bg-gradient-to-br from-slate-50 to-slate-100" style="
        background-image: url('./public/assets/images/background.png');
        background-size: cover;
        background-position: center;
        background-repeat: no-repeat;
      ">
    <div class="flex flex-col min-h-screen justify-between pt-18">
        <!-- Header -->
        <jsp:include page="../components/header.jsp" />
        <!-- Header -->
        
        <%
        Order order = (Order) request.getAttribute("order");
        @SuppressWarnings("unchecked")
        List<OrderItem> orderItems = (List<OrderItem>) request.getAttribute("orderItems");
        
        if (order == null) {
        %>
            <div class="container mx-auto px-4 py-8 max-w-6xl">
                <div class="text-center py-20">
                    <div class="w-24 h-24 mx-auto mb-6 bg-gradient-to-br from-red-100 to-red-200 rounded-full flex items-center justify-center shadow-lg">
                        <svg class="w-12 h-12 text-red-500" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 9v2m0 4h.01m-6.938 4h13.856c1.54 0 2.502-1.667 1.732-3L13.732 4c-.77-1.333-2.694-1.333-3.464 0L3.34 16c-.77 1.333.192 3 1.732 3z"/>
                        </svg>
                    </div>
                    <h3 class="text-2xl font-bold text-gray-900 mb-3">Không tìm thấy đơn hàng</h3>
                    <p class="text-gray-600 mb-8 text-lg">Đơn hàng không tồn tại hoặc bạn không có quyền xem.</p>
                    <a href="${pageContext.request.contextPath}/orders" 
                       class="inline-flex items-center gap-3 bg-gradient-to-r from-blue-500 to-purple-600 text-white px-8 py-4 rounded-xl font-semibold hover:from-blue-600 hover:to-purple-700 transition-all duration-300 transform hover:scale-105 shadow-lg hover:shadow-xl">
                        Quay lại danh sách đơn hàng
                    </a>
                </div>
            </div>
        <%
        } else {
            SimpleDateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy HH:mm");
            String statusColor = "";
            String statusText = "";
            String statusBg = "";
            
            switch (order.getStatus()) {
                case OrderStatus.PENDING:
                    statusColor = "text-yellow-700";
                    statusText = "Chờ xử lý";
                    statusBg = "bg-gradient-to-r from-yellow-100 to-yellow-200";
                    break;
                case OrderStatus.CONFIRMED:
                    statusColor = "text-blue-700";
                    statusText = "Đã xác nhận";
                    statusBg = "bg-sky-500/10";
                    break;
                case OrderStatus.SHIPPING:
                    statusColor = "text-purple-700";
                    statusText = "Đang giao";
                    statusBg = "bg-gradient-to-r from-purple-100 to-purple-200";
                    break;
                case OrderStatus.DELIVERED:
                    statusColor = "text-green-700";
                    statusText = "Đã giao";
                    statusBg = "bg-gradient-to-r from-green-100 to-green-200";
                    break;
                case OrderStatus.CANCELLED:
                    statusColor = "text-red-700";
                    statusText = "Đã hủy";
                    statusBg = "bg-gradient-to-r from-red-100 to-red-200";
                    break;
                default:
                    statusColor = "text-gray-700";
                    statusText = order.getStatus();
                    statusBg = "bg-gradient-to-r from-gray-100 to-gray-200";
            }
        %>
            <div class="container mx-auto px-4 py-8 max-w-6xl">
                <!-- Breadcrumb -->
                <nav class="flex items-center gap-2 text-xs text-gray-500 mb-4 bg-white/60 backdrop-blur-sm rounded-lg px-4 py-3">
                    <a href="${pageContext.request.contextPath}/orders">Đơn hàng của tôi</a>
                    <svg class="w-2 h-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5l7 7-7 7"/>
                    </svg>
                    <span class="text-foreground font-semibold">Đơn hàng #<%= order.getId() %></span>
                </nav>
                
                <!-- Order Header -->
                <div class="bg-background rounded-2xl p-8 mb-4">
                    <div class="flex items-center justify-between mb-6">
                        <div>
                            <h1 class="text-xl font-bold">Đơn hàng #<%= order.getId() %></h1>
                            <p class="text-muted-foreground font-medium text-xs">Đặt lúc: <%= dateFormat.format(order.getOrderDate()) %></p>
                        </div>
                        <span class="inline-flex items-center px-3 py-2 rounded-full text-xs font-bold <%= statusBg %> <%= statusColor %>">
                            <%= statusText %>
                        </span>
                    </div>
                    
                    <div class="grid grid-cols-1 md:grid-cols-3 gap-4 border-gray-200">
                        <div class="text-center border rounded-xl p-4">
                            <p class="text-sm text-muted-foreground mb-2 font-semibold">Số lượng sản phẩm</p>
                            <p class="text-sm font-bold text-primary"><%= order.getTotalQuantity() %></p>
                        </div>
                        <div class="text-center border rounded-xl p-4">
                            <p class="text-sm text-muted-foreground mb-2 font-semibold">Phương thức thanh toán</p>
                            <p class="text-sm font-bold text-primary">Thanh toán khi nhận hàng</p>
                        </div>
                        <div class="text-center border rounded-xl p-4">
                            <p class="text-sm text-muted-foreground mb-2 font-semibold">Tổng tiền</p>
                            <p class="text-sm font-bold text-primary"><%= String.format("%,.0f", order.getTotalAmount()) %>k</p>
                        </div>
                    </div>
                </div>
                
                <!-- Order Items -->
                <div class="bg-background rounded-2xl overflow-hidden mb-4">
                    <div class="px-8 pt-6 bg-background">
                        <h3 class="text-xl font-bold text-foreground">Sản phẩm đã đặt</h3>
                    </div>
                    
                    <div class="divide-y divide-gray-200">
                        <%
                        if (orderItems != null && !orderItems.isEmpty()) {
                            ProductImageDao imageDao = new ProductImageImplementation();
                            
                            for (OrderItem item : orderItems) {
                                // Lấy ảnh sản phẩm
                                List<ProductImage> images = imageDao.getProductImagesByProductId(item.getProductId());
                                String imageUrl = request.getContextPath() + "/public/assets/images/product-placeholder.svg";
                                if (images != null && !images.isEmpty()) {
                                    imageUrl = request.getContextPath() + images.get(0).getImageUrl();
                                }
                                
                                BigDecimal itemTotal = item.getPrice().multiply(new BigDecimal(item.getQuantity()));
                        %>
                            <div class="p-8 hover:bg-gray-50/50 transition-all duration-300">
                                <div class="flex items-center gap-4">
                                    <!-- Product Image -->
                                    <div class="w-24 h-24 flex-shrink-0">
                                        <img src="<%= imageUrl %>" alt="<%= item.getProductName() %>" 
                                             class="w-full h-full object-cover rounded-xl">
                                    </div>
                                    
                                    <!-- Product Info -->
                                    <div class="flex-1 min-w-0">
                                        <h4 class="text-sm font-bold text-gray-900 mb-2"><%= item.getProductName() %></h4>
                                        <div class="space-y-1">
                                            <p class="text-sm text-foreground">Mã sản phẩm: <span class="text-primary font-bold">#<%= item.getProductId() %></span></p>
                                            <p class="text-sm text-foreground">Đơn giá: <span class="text-primary font-bold"><%= String.format("%,.0f", item.getPrice()) %>k</span></p>
                                            <p class="text-sm text-foreground">Số lượng: <span class="text-primary font-bold"><%= item.getQuantity() %></span></p>
                                        </div>
                                    </div>
                                    
                                    <!-- Item Total -->
                                    <div class="text-right bg-gradient-to-br from-red-50 to-red-100 rounded-xl p-4">
                                        <p class="text-sm font-bold text-primary"><%= String.format("%,.0f", itemTotal) %>k</p>
                                    </div>
                                </div>
                            </div>
                        <%
                            }
                        } else {
                        %>
                            <div class="p-4 text-center">
                                <div class="w-16 h-16 mx-auto mb-4 bg-gray-100 rounded-full flex items-center justify-center">
                                    <svg class="w-6 h-6 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M20 13V6a2 2 0 00-2-2H6a2 2 0 00-2 2v7m16 0v5a2 2 0 01-2 2H6a2 2 0 01-2-2v-5m16 0h-2.586a1 1 0 00-.707.293l-2.414 2.414a1 1 0 01-.707.293h-3.172a1 1 0 01-.707-.293l-2.414-2.414A1 1 0 006.586 13H4"/>
                                    </svg>
                                </div>
                                <p class="text-muted-foreground text-sm font-medium">Không có sản phẩm nào trong đơn hàng này.</p>
                            </div>
                        <%
                        }
                        %>
                    </div>
                </div>
                
                <!-- Order Summary -->
                <div class="bg-background rounded-2xl p-8 mb-8">
                    <h3 class="text-xl font-bold text-foreground mb-4">Tóm tắt đơn hàng</h3>
                    
                    <div class="space-y-4">
                        <div class="flex justify-between text-sm">
                            <span class="text-foreground">Tạm tính:</span>
                            <span class="font-bold text-primary"><%= String.format("%,.0f", order.getTotalAmount()) %>k</span>
                        </div>
                        <div class="flex justify-between text-sm">
                            <span class="text-foreground">Phí vận chuyển:</span>
                            <span class="font-bold text-primary">Miễn phí</span>
                        </div>
                        <div class="flex justify-between text-sm text-foreground pt-4 border-t border-muted">
                            <span>Tổng cộng:</span>
                            <span class="text-primary font-bold"><%= String.format("%,.0f", order.getTotalAmount()) %>k</span>
                        </div>
                    </div>
                </div>
                
                <!-- Action Buttons -->
                <div class="flex items-center gap-4 flex-wrap">
                    <a href="${pageContext.request.contextPath}/orders" 
                       class="inline-flex items-center gap-2 bg-background text-foreground px-6 py-3 rounded-xl text-sm border border-black">
                        Quay lại danh sách
                    </a>
                    
                    <% if (OrderStatus.PENDING.equals(order.getStatus())) { %>
                        <form method="post" action="${pageContext.request.contextPath}/cancel-order" style="display: inline;">
                            <input type="hidden" name="orderId" value="<%= order.getId() %>">
                            <button type="submit" 
                                    onclick="return confirm('Bạn có chắc muốn hủy đơn hàng này?')"
                                    class="inline-flex items-center gap-2 border border-destructive cursor-pointer bg-background text-foreground px-6 py-3 rounded-xl text-sm">
                                Hủy đơn hàng
                            </button>
                        </form>
                    <% } %>
                    
                    <a href="${pageContext.request.contextPath}/" 
                       class="inline-flex items-center gap-2 bg-primary text-white px-6 py-3 rounded-xl text-sm">
                        Tiếp tục mua sắm
                    </a>
                </div>
            </div>
        <%
        }
        %>
        
        <!-- Footer -->
        <jsp:include page="../components/footer.jsp" />
    </div>
    

</body>
</html>