<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="data.models.Order" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.math.BigDecimal" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đơn Hàng Của Tôi</title>
    <link rel="icon" type="image/x-icon" href="logo-lovely.ico">
    <link rel="stylesheet" href="./public/assets/styles/globals.css">
    <script src="https://cdn.jsdelivr.net/npm/@tailwindcss/browser@4"></script>
</head>
<body>
    <div class="flex flex-col min-h-screen justify-between bg-muted">
        <!-- Header -->
        <jsp:include page="../components/header.jsp" />

        <div class="container mx-auto px-4 py-8 max-w-6xl pt-32">
            <!-- Page Title -->
            <div class="mb-8">
                <h1 class="text-2xl font-bold text-gray-900 mb-2">Đơn Hàng Của Tôi</h1>
                <p class="text-gray-600">Theo dõi và quản lý đơn hàng của bạn</p>
            </div>
            
            <%
            String error = (String) request.getAttribute("error");
            if (error != null) {
            %>
                <div class="bg-red-50 border border-red-200 rounded-lg p-4 mb-6">
                    <div class="flex">
                        <svg class="w-5 h-5 text-red-400 mr-3 mt-0.5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v4m0 4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z"></path>
                        </svg>
                        <p class="text-red-700"><%= error %></p>
                    </div>
                </div>
            <%
            }
            
            @SuppressWarnings("unchecked")
            List<Order> orders = (List<Order>) request.getAttribute("orders");
            
            if (orders == null || orders.isEmpty()) {
            %>
                <!-- Empty State -->
                <div class="text-center py-16">
                    <div class="w-24 h-24 mx-auto mb-6 bg-gray-100 rounded-full flex items-center justify-center">
                        <svg class="w-12 h-12 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M16 11V7a4 4 0 00-8 0v4M5 9h14l1 12H4L5 9z"/>
                        </svg>
                    </div>
                    <h3 class="text-lg font-medium text-gray-900 mb-2">Chưa có đơn hàng nào</h3>
                    <p class="text-gray-500 mb-6">Bạn chưa đặt đơn hàng nào. Hãy khám phá sản phẩm và đặt hàng ngay!</p>
                    <a href="${pageContext.request.contextPath}/" 
                       class="inline-flex items-center gap-2 bg-blue-500 text-white px-6 py-3 rounded-lg font-medium hover:bg-blue-600 transition-colors">
                        <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M16 11V7a4 4 0 00-8 0v4M5 9h14l1 12H4L5 9z"/>
                        </svg>
                        Mua Sắm Ngay
                    </a>
                </div>
            <%
            } else {
                SimpleDateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy HH:mm");
            %>
                <!-- Orders List -->
                <div class="space-y-6">
                    <%
                    for (Order order : orders) {
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
                        <!-- Order Card -->
                        <div class="bg-white border border-gray-200 rounded-lg overflow-hidden hover:shadow-md transition-shadow">
                            <!-- Order Header -->
                            <div class="bg-gray-50 px-6 py-4 border-b border-gray-200">
                                <div class="flex items-center justify-between">
                                    <div class="flex items-center gap-4">
                                        <div>
                                            <h3 class="text-lg font-semibold text-gray-900">Đơn hàng #<%= order.getId() %></h3>
                                            <p class="text-sm text-gray-500">Đặt lúc: <%= dateFormat.format(order.getOrderDate()) %></p>
                                        </div>
                                    </div>
                                    <div class="flex items-center gap-3">
                                        <span class="inline-flex items-center px-3 py-1 rounded-full text-sm font-medium <%= statusColor %>">
                                            <%= statusText %>
                                        </span>
                                    </div>
                                </div>
                            </div>
                            
                            <!-- Order Body -->
                            <div class="px-6 py-4">
                                <div class="flex items-center justify-between">
                                    <div class="flex items-center gap-6">
                                        <div class="text-center">
                                            <p class="text-sm text-gray-500 mb-1">Số lượng</p>
                                            <p class="text-lg font-semibold text-gray-900"><%= order.getTotalQuantity() %> sản phẩm</p>
                                        </div>
                                        <div class="h-8 w-px bg-gray-200"></div>
                                        <div class="text-center">
                                            <p class="text-sm text-gray-500 mb-1">Tổng tiền</p>
                                            <p class="text-lg font-semibold text-red-600"><%= String.format("%,.0f", order.getTotalAmount()) %>k</p>
                                        </div>
                                    </div>
                                    
                                    <div class="flex items-center gap-3">
                                        <a href="${pageContext.request.contextPath}/orders?action=detail&id=<%= order.getId() %>" 
                                           class="inline-flex items-center gap-2 px-4 py-2 border border-gray-300 rounded-lg text-sm font-medium text-gray-700 bg-white hover:bg-gray-50 transition-colors">
                                            <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z"/>
                                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M2.458 12C3.732 7.943 7.523 5 12 5c4.478 0 8.268 2.943 9.542 7-1.274 4.057-5.064 7-9.542 7-4.477 0-8.268-2.943-9.542-7z"/>
                                            </svg>
                                            Xem chi tiết
                                        </a>
                                        
                                        <% if ("PENDING".equals(order.getStatus())) { %>
                                            <button onclick="cancelOrder(<%= order.getId() %>)" 
                                                    class="inline-flex items-center gap-2 px-4 py-2 border border-red-300 rounded-lg text-sm font-medium text-red-700 bg-white hover:bg-red-50 transition-colors">
                                                <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12"/>
                                                </svg>
                                                Hủy đơn
                                            </button>
                                        <% } %>
                                    </div>
                                </div>
                            </div>
                        </div>
                    <%
                    }
                    %>
                </div>
            <%
            }
            %>
        </div>
        
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
