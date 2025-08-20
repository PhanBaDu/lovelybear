<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="data.models.Order" %>
<%@ page import="data.models.OrderItem" %>
<%@ page import="data.models.ProductImage" %>
<%@ page import="data.dao.ProductImageDao" %>
<%@ page import="data.implementations.ProductImageImplementation" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.math.BigDecimal" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chi Tiết Đơn Hàng</title>
    <link rel="icon" type="image/x-icon" href="logo-title.ico">
    <link rel="stylesheet" href="./public/assets/styles/globals.css">
    <script src="https://cdn.jsdelivr.net/npm/@tailwindcss/browser@4"></script>
</head>
<body class="bg-muted">
    <div class="flex flex-col min-h-screen justify-between bg-muted pt-18">
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
                <div class="text-center py-16">
                    <h3 class="text-lg font-medium text-gray-900 mb-2">Không tìm thấy đơn hàng</h3>
                    <p class="text-gray-500 mb-6">Đơn hàng không tồn tại hoặc bạn không có quyền xem.</p>
                    <a href="${pageContext.request.contextPath}/orders" 
                       class="inline-flex items-center gap-2 bg-blue-500 text-white px-6 py-3 rounded-lg font-medium hover:bg-blue-600 transition-colors">
                        Quay lại danh sách đơn hàng
                    </a>
                </div>
            </div>
        <%
        } else {
            SimpleDateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy HH:mm");
            String statusColor = "";
            String statusText = "";
            
            switch (order.getStatus()) {
                case "PENDING":
                    statusColor = "bg-yellow-100 text-yellow-800";
                    statusText = "Chờ xử lý";
                    break;
                case "CONFIRMED":
                    statusColor = "bg-blue-100 text-blue-800";
                    statusText = "Đã xác nhận";
                    break;
                case "SHIPPING":
                    statusColor = "bg-purple-100 text-purple-800";
                    statusText = "Đang giao";
                    break;
                case "DELIVERED":
                    statusColor = "bg-green-100 text-green-800";
                    statusText = "Đã giao";
                    break;
                case "CANCELLED":
                    statusColor = "bg-red-100 text-red-800";
                    statusText = "Đã hủy";
                    break;
                default:
                    statusColor = "bg-gray-100 text-gray-800";
                    statusText = order.getStatus();
            }
        %>
            <div class="container mx-auto px-4 py-8 max-w-6xl">
                <!-- Breadcrumb -->
                <nav class="flex items-center gap-2 text-sm text-gray-500 mb-6">
                    <a href="${pageContext.request.contextPath}/orders" class="hover:text-blue-600">Đơn hàng của tôi</a>
                    <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5l7 7-7 7"/>
                    </svg>
                    <span class="text-gray-900">Đơn hàng #<%= order.getId() %></span>
                </nav>
                
                <!-- Order Header -->
                <div class="bg-white border border-gray-200 rounded-lg p-6 mb-6">
                    <div class="flex items-center justify-between mb-4">
                        <div>
                            <h1 class="text-2xl font-bold text-gray-900 mb-2">Đơn hàng #<%= order.getId() %></h1>
                            <p class="text-gray-600">Đặt lúc: <%= dateFormat.format(order.getOrderDate()) %></p>
                        </div>
                        <span class="inline-flex items-center px-4 py-2 rounded-full text-sm font-medium <%= statusColor %>">
                            <%= statusText %>
                        </span>
                    </div>
                    
                    <div class="grid grid-cols-1 md:grid-cols-3 gap-6 pt-4 border-t border-gray-200">
                        <div class="text-center">
                            <p class="text-sm text-gray-500 mb-1">Số lượng sản phẩm</p>
                            <p class="text-xl font-semibold text-gray-900"><%= order.getTotalQuantity() %></p>
                        </div>
                        <div class="text-center">
                            <p class="text-sm text-gray-500 mb-1">Phương thức thanh toán</p>
                            <p class="text-lg font-medium text-gray-900">Thanh toán khi nhận hàng</p>
                        </div>
                        <div class="text-center">
                            <p class="text-sm text-gray-500 mb-1">Tổng tiền</p>
                            <p class="text-xl font-semibold text-red-600"><%= String.format("%,.0f", order.getTotalAmount()) %>k</p>
                        </div>
                    </div>
                </div>
                
                <!-- Order Items -->
                <div class="bg-white border border-gray-200 rounded-lg overflow-hidden mb-6">
                    <div class="px-6 py-4 bg-gray-50 border-b border-gray-200">
                        <h3 class="text-lg font-semibold text-gray-900">Sản phẩm đã đặt</h3>
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
                            <div class="p-6">
                                <div class="flex items-center gap-4">
                                    <!-- Product Image -->
                                    <div class="w-20 h-20 flex-shrink-0">
                                        <img src="<%= imageUrl %>" alt="<%= item.getProductName() %>" 
                                             class="w-full h-full object-cover rounded-lg border border-gray-200">
                                    </div>
                                    
                                    <!-- Product Info -->
                                    <div class="flex-1 min-w-0">
                                        <h4 class="text-lg font-medium text-gray-900 mb-1"><%= item.getProductName() %></h4>
                                        <p class="text-sm text-gray-500">Đơn giá: <%= String.format("%,.0f", item.getPrice()) %>k</p>
                                        <p class="text-sm text-gray-500">Số lượng: <%= item.getQuantity() %></p>
                                    </div>
                                    
                                    <!-- Item Total -->
                                    <div class="text-right">
                                        <p class="text-lg font-semibold text-gray-900"><%= String.format("%,.0f", itemTotal) %>k</p>
                                    </div>
                                </div>
                            </div>
                        <%
                            }
                        } else {
                        %>
                            <div class="p-6 text-center text-gray-500">
                                Không có sản phẩm nào trong đơn hàng này.
                            </div>
                        <%
                        }
                        %>
                    </div>
                </div>
                
                <!-- Order Summary -->
                <div class="bg-white border border-gray-200 rounded-lg p-6 mb-6">
                    <h3 class="text-lg font-semibold text-gray-900 mb-4">Tóm tắt đơn hàng</h3>
                    
                    <div class="space-y-3">
                        <div class="flex justify-between text-sm">
                            <span class="text-gray-600">Tạm tính:</span>
                            <span class="font-medium"><%= String.format("%,.0f", order.getTotalAmount()) %>k</span>
                        </div>
                        <div class="flex justify-between text-sm">
                            <span class="text-gray-600">Phí vận chuyển:</span>
                            <span class="font-medium">0đ</span>
                        </div>
                        <div class="flex justify-between text-lg font-bold text-red-600 pt-3 border-t border-gray-200">
                            <span>Tổng cộng:</span>
                            <span><%= String.format("%,.0f", order.getTotalAmount()) %>k</span>
                        </div>
                    </div>
                </div>
                
                <!-- Action Buttons -->
                <div class="flex items-center gap-4">
                    <a href="${pageContext.request.contextPath}/orders" 
                       class="inline-flex items-center gap-2 px-6 py-3 border border-gray-300 rounded-lg text-sm font-medium text-gray-700 bg-white hover:bg-gray-50 transition-colors">
                        <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10 19l-7-7m0 0l7-7m-7 7h18"/>
                        </svg>
                        Quay lại danh sách
                    </a>
                    
                    <% if ("PENDING".equals(order.getStatus())) { %>
                        <button onclick="cancelOrder(<%= order.getId() %>)" 
                                class="inline-flex items-center gap-2 px-6 py-3 border border-red-300 rounded-lg text-sm font-medium text-red-700 bg-white hover:bg-red-50 transition-colors">
                            <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12"/>
                            </svg>
                            Hủy đơn hàng
                        </button>
                    <% } %>
                    
                    <a href="${pageContext.request.contextPath}/" 
                       class="inline-flex items-center gap-2 bg-blue-500 text-white px-6 py-3 rounded-lg font-medium hover:bg-blue-600 transition-colors">
                        <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M16 11V7a4 4 0 00-8 0v4M5 9h14l1 12H4L5 9z"/>
                        </svg>
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
    
    <script>
        function cancelOrder(orderId) {
            if (confirm('Bạn có chắc muốn hủy đơn hàng này?')) {
                // TODO: Implement cancel order functionality
                alert('Chức năng hủy đơn hàng đang được phát triển!');
            }
        }
    </script>
</body>
</html>
