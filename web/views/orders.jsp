<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="data.models.Order" %>
<%@ page import="data.constants.OrderStatus" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.math.BigDecimal" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đơn Hàng Của Tôi</title>
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
    <div class="flex flex-col min-h-screen justify-between">
        <!-- Header -->
        <jsp:include page="../components/header.jsp" />

        <div class="container mx-auto px-4 py-4 max-w-7xl pt-24 pb-24">
            <!-- Page Header with Stats -->
            <div class="mb-8">
                <div class="text-center mb-6">
                    <h1 class="text-4xl font-extrabold text-gray-900 mb-2 text-background">Đơn Hàng Của Tôi</h1>
                    <p class="text-sm text-background font-medium opacity-90">Theo dõi và quản lý đơn hàng của bạn</p>
                </div>
                
                <!-- Quick Stats -->
                <%
                @SuppressWarnings("unchecked")
                List<Order> orders = (List<Order>) request.getAttribute("orders");
                
                if (orders != null && !orders.isEmpty()) {
                    int totalOrders = orders.size();
                    int pendingCount = 0, shippingCount = 0, deliveredCount = 0, cancelledCount = 0;
                    BigDecimal totalValue = BigDecimal.ZERO;
                    
                    for (Order order : orders) {
                        totalValue = totalValue.add(order.getTotalAmount());
                        switch (order.getStatus()) {
                            case OrderStatus.PENDING: pendingCount++; break;
                            case OrderStatus.CONFIRMED:
                            case OrderStatus.SHIPPING: shippingCount++; break;
                            case OrderStatus.DELIVERED: deliveredCount++; break;
                            case OrderStatus.CANCELLED: cancelledCount++; break;
                        }
                    }
                %>
                <div class="grid grid-cols-2 md:grid-cols-4 gap-4 mb-6">
                    <div class="bg-white/90 backdrop-blur-sm rounded-xl p-4">
                        <div class="text-center">
                            <div class="text-2xl font-bold text-gray-900 mb-1"><%= totalOrders %></div>
                            <div class="text-xs text-gray-600 font-medium">Tổng đơn hàng</div>
                        </div>
                    </div>
                    <div class="bg-white/90 backdrop-blur-sm rounded-xl p-4">
                        <div class="text-center">
                            <div class="text-2xl font-bold text-yellow-700 mb-1"><%= pendingCount %></div>
                            <div class="text-xs text-gray-600 font-medium">Chờ xử lý</div>
                        </div>
                    </div>
                    <div class="bg-white/90 backdrop-blur-sm rounded-xl p-4">
                        <div class="text-center">
                            <div class="text-2xl font-bold text-purple-700 mb-1"><%= shippingCount %></div>
                            <div class="text-xs text-gray-600 font-medium">Đang giao</div>
                        </div>
                    </div>
                    <div class="bg-white/90 backdrop-blur-sm rounded-xl p-4">
                        <div class="text-center">
                            <div class="text-2xl font-bold text-green-700 mb-1"><%= deliveredCount %></div>
                            <div class="text-xs text-gray-600 font-medium">Hoàn thành</div>
                        </div>
                    </div>
                </div>
                <%
                }
                %>
            </div>
            
            <!-- Alert Messages -->
            <%
            String error = (String) request.getAttribute("error");
            String success = request.getParameter("success");
            
            if (error != null) {
            %>
                <div class="bg-white backdrop-blur-sm border-l-4 border-red-500 rounded-xl p-6 mb-6">
                    <div class="flex items-center">
                        <div class="flex-shrink-0">
                            <svg class="w-6 h-6 text-red-500" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v4m0 4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z"></path>
                            </svg>
                        </div>
                        <div class="ml-3">
                            <p class="text-red-800 font-semibold"><%= error %></p>
                        </div>
                    </div>
                </div>
            <%
            }
            
            if ("cancelled".equals(success)) {
            %>
                <div class="bg-white backdrop-blur-sm border-l-4 border-green-500 rounded-xl p-6 mb-6">
                    <div class="flex items-center">
                        <div class="flex-shrink-0">
                            <svg class="w-6 h-6 text-green-500" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"></path>
                            </svg>
                        </div>
                        <div class="ml-3">
                            <p class="text-green-800 font-semibold">Đơn hàng đã được hủy thành công!</p>
                        </div>
                    </div>
                </div>
            <%
            }
            
            if (orders == null || orders.isEmpty()) {
            %>
                <!-- Empty State -->
                <div class="text-center py-16">
                    <div class="w-32 h-32 mx-auto mb-8 bg-gradient-to-br from-blue-100 to-purple-100 rounded-full flex items-center justify-center">
                        <svg class="w-16 h-16 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5" d="M16 11V7a4 4 0 00-8 0v4M5 9h14l1 12H4L5 9z"/>
                        </svg>
                    </div>
                    <h3 class="text-2xl font-bold text-gray-900 mb-3">Chưa có đơn hàng nào</h3>
                    <p class="text-gray-600 mb-8 text-lg max-w-md mx-auto">Bạn chưa đặt đơn hàng nào. Hãy khám phá sản phẩm và đặt hàng ngay!</p>
                    <a href="${pageContext.request.contextPath}/" 
                       class="inline-flex items-center gap-3 bg-gradient-to-r from-blue-500 to-purple-600 text-white px-8 py-4 rounded-xl font-semibold hover:from-blue-600 hover:to-purple-700 transition-all duration-300 transform hover:scale-105">
                        <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M16 11V7a4 4 0 00-8 0v4M5 9h14l1 12H4L5 9z"/>
                        </svg>
                        Mua Sắm Ngay
                    </a>
                </div>
            <%
            } else {
                SimpleDateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy HH:mm");
            %>
                <!-- Filter/Sort Controls -->
                <div class="bg-white/90 backdrop-blur-sm rounded-xl p-4 mb-6">
                    <div class="flex flex-col sm:flex-row gap-4 items-center justify-between">
                        <div class="flex items-center gap-2">
                            <svg class="w-5 h-5 text-gray-500" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 4a1 1 0 011-1h16a1 1 0 011 1v2.586a1 1 0 01-.293.707l-6.414 6.414a1 1 0 00-.293.707V17l-4 4v-6.586a1 1 0 00-.293-.707L3.293 7.293A1 1 0 013 6.586V4z"/>
                            </svg>
                            <span class="text-sm font-medium text-gray-700">Lọc theo trạng thái:</span>
                        </div>
                        <div class="flex flex-wrap gap-2">
                            <button class="px-3 py-1.5 text-xs font-medium bg-gray-100 text-gray-700 rounded-full border border-gray-300 hover:bg-gray-200 transition-colors">
                                Tất cả (<%= orders.size() %>)
                            </button>
                            <button class="px-3 py-1.5 text-xs font-medium bg-yellow-100 text-yellow-700 rounded-full border border-yellow-300 hover:bg-yellow-200 transition-colors">
                                Chờ xử lý
                            </button>
                            <button class="px-3 py-1.5 text-xs font-medium bg-purple-100 text-purple-700 rounded-full border border-purple-300 hover:bg-purple-200 transition-colors">
                                Đang giao
                            </button>
                            <button class="px-3 py-1.5 text-xs font-medium bg-green-100 text-green-700 rounded-full border border-green-300 hover:bg-green-200 transition-colors">
                                Hoàn thành
                            </button>
                        </div>
                    </div>
                </div>

                <!-- Orders List -->
                <div class="space-y-4">
                    <%
                    for (Order order : orders) {
                        String statusColor = "";
                        String statusText = "";
                        String statusBg = "";
                        String statusIcon = "";
                        
                        switch (order.getStatus()) {
                            case OrderStatus.PENDING:
                                statusColor = "text-yellow-700";
                                statusText = "Chờ xử lý";
                                statusBg = "bg-yellow-700/10";
                                statusIcon = "<circle cx='12' cy='12' r='10'/><polyline points='12,6 12,12 16,14'/>";
                                break;
                            case OrderStatus.CONFIRMED:
                                statusColor = "text-sky-500";
                                statusText = "Đã xác nhận";
                                statusBg = "bg-sky-500/10";
                                statusIcon = "<polyline points='20,6 9,17 4,12'/>";
                                break;
                            case OrderStatus.SHIPPING:
                                statusColor = "text-purple-700";
                                statusText = "Đang giao";
                                statusBg = "bg-gradient-to-r from-purple-100 to-purple-200";
                                statusIcon = "<rect x='1' y='3' width='15' height='13'/><polygon points='16,8 20,8 23,11 23,16 16,16 16,8'/><circle cx='5.5' cy='18.5' r='2.5'/><circle cx='18.5' cy='18.5' r='2.5'/>";
                                break;
                            case OrderStatus.DELIVERED:
                                statusColor = "text-green-700";
                                statusText = "Đã giao";
                                statusBg = "bg-gradient-to-r from-green-100 to-green-200";
                                statusIcon = "<polyline points='20,6 9,17 4,12'/><polyline points='14,7 18,11 22,7'/>";
                                break;
                            case OrderStatus.CANCELLED:
                                statusColor = "text-red-700";
                                statusText = "Đã hủy";
                                statusBg = "bg-gradient-to-r from-red-100 to-red-200";
                                statusIcon = "<circle cx='12' cy='12' r='10'/><line x1='15' y1='9' x2='9' y2='15'/><line x1='9' y1='9' x2='15' y2='15'/>";
                                break;
                            default:
                                statusColor = "text-gray-700";
                                statusText = order.getStatus();
                                statusBg = "bg-gradient-to-r from-gray-100 to-gray-200";
                                statusIcon = "<circle cx='12' cy='12' r='10'/>";
                        }
                    %>
                        <!-- Enhanced Order Card -->
                        <div class="bg-white backdrop-blur-sm rounded-2xl overflow-hidden duration-300">
                            <!-- Order Header -->
                            <div class="px-6 py-4 bg-gray-50/50 border-b border-gray-100">
                                <div class="flex items-center justify-between">
                                    <div class="flex items-center gap-4">
                                        <!-- Status Icon -->
                                        <div class="flex-shrink-0 p-2 rounded-full <%= statusBg %>">
                                            <svg class="w-5 h-5 <%= statusColor %>" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                                <%= statusIcon %>
                                            </svg>
                                        </div>
                                        
                                        <!-- Order Info -->
                                        <div>
                                            <div class="flex items-center gap-2 mb-1">
                                                <h3 class="text-lg font-bold text-gray-900">Đơn hàng #<%= order.getId() %></h3>
                                                <span class="inline-flex items-center px-3 py-1 rounded-full text-xs font-bold <%= statusBg %> <%= statusColor %>">
                                                    <%= statusText %>
                                                </span>
                                            </div>
                                            <div class="flex items-center gap-4 text-sm text-gray-600">
                                                <div class="flex items-center gap-1">
                                                    <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v4l3 3m6-3a9 9 0 11-18 0 9 9 0 0118 0z"/>
                                                    </svg>
                                                    <span><%= dateFormat.format(order.getOrderDate()) %></span>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    
                                    <!-- Action Buttons -->
                                    <div class="flex items-center gap-3">
                                        <a href="${pageContext.request.contextPath}/orders?action=detail&id=<%= order.getId() %>" 
                                           class="inline-flex items-center gap-2 text-sm px-4 py-2 border border-sky-900 text-foreground rounded-lg hover:bg-sky-50 transition-colors">
                                            <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z"/>
                                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M2.458 12C3.732 7.943 7.523 5 12 5c4.478 0 8.268 2.943 9.542 7-1.274 4.057-5.064 7-9.542 7-4.477 0-8.268-2.943-9.542-7z"/>
                                            </svg>
                                            Chi tiết
                                        </a>
                                        
                                        <% if (OrderStatus.PENDING.equals(order.getStatus())) { %>
                                            <form method="post" action="${pageContext.request.contextPath}/cancel-order" style="display: inline;">
                                                <input type="hidden" name="orderId" value="<%= order.getId() %>">
                                                <button type="submit" 
                                                        onclick="return confirm('Bạn có chắc muốn hủy đơn hàng này?')"
                                                        class="inline-flex items-center gap-2 text-sm px-4 py-2 border border-destructive bg-destructive text-background rounded-lg hover:bg-red-600 transition-colors">
                                                    <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12"/>
                                                    </svg>
                                                    Hủy đơn
                                                </button>
                                            </form>
                                        <% } %>
                                    </div>
                                </div>
                            </div>
                            
                            <!-- Order Summary -->
                            <div class="px-6 py-5">
                                <div class="grid grid-cols-2 md:grid-cols-4 gap-6">
                                    <!-- Quantity -->
                                    <div class="text-center">
                                        <div class="p-3 bg-blue-50 rounded-xl mb-2 inline-block">
                                            <svg class="w-6 h-6 text-blue-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M20 7l-8-4-8 4m16 0l-8 4m8-4v10l-8 4m0-10L4 7m8 4v10M4 7v10l8 4"/>
                                            </svg>
                                        </div>
                                        <p class="text-2xl font-bold text-gray-900 mb-1"><%= order.getTotalQuantity() %></p>
                                        <p class="text-sm text-gray-600 font-medium">Sản phẩm</p>
                                    </div>
                                    
                                    <!-- Total Amount -->
                                    <div class="text-center">
                                        <div class="p-3 bg-green-50 rounded-xl mb-2 inline-block">
                                            <svg class="w-6 h-6 text-green-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8c-1.657 0-3 .895-3 2s1.343 2 3 2 3 .895 3 2-1.343 2-3 2m0-8c1.11 0 2.08.402 2.599 1M12 8V7m0 1v8m0 0v1m0-1c-1.11 0-2.08-.402-2.599-1"/>
                                            </svg>
                                        </div>
                                        <p class="text-2xl font-bold text-gray-900 mb-1"><%= String.format("%,.0f", order.getTotalAmount()) %>k</p>
                                        <p class="text-sm text-gray-600 font-medium">VNĐ</p>
                                    </div>
                                    
                                    <!-- Progress Indicator -->
                                    <div class="col-span-2 md:col-span-2">
                                        <div class="flex items-center justify-between mb-2">
                                            <p class="text-sm font-medium text-gray-700">Tiến trình đơn hàng</p>
                                            <p class="text-sm font-medium <%= statusColor %>"><%= statusText %></p>
                                        </div>
                                        <div class="w-full bg-gray-200 rounded-full h-2">
                                            <%
                                            int progress = 0;
                                            String progressColor = "bg-gray-400";
                                            switch (order.getStatus()) {
                                                case OrderStatus.PENDING:
                                                    progress = 25;
                                                    progressColor = "bg-yellow-500";
                                                    break;
                                                case OrderStatus.CONFIRMED:
                                                    progress = 50;
                                                    progressColor = "bg-sky-500";
                                                    break;
                                                case OrderStatus.SHIPPING:
                                                    progress = 75;
                                                    progressColor = "bg-purple-500";
                                                    break;
                                                case OrderStatus.DELIVERED:
                                                    progress = 100;
                                                    progressColor = "bg-green-500";
                                                    break;
                                                case OrderStatus.CANCELLED:
                                                    progress = 100;
                                                    progressColor = "bg-red-500";
                                                    break;
                                            }
                                            %>
                                            <div class="<%= progressColor %> h-2 rounded-full transition-all duration-500" style="width: <%= progress %>%"></div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    <%
                    }
                    %>
                </div>
                
                <!-- Load More Button (if needed for pagination) -->
                <div class="text-center mt-8">
                    <button class="inline-flex items-center gap-2 px-6 py-3 bg-white/90 backdrop-blur-sm border border-gray-200 text-gray-700 rounded-xl hover:bg-gray-50 transition-colors font-medium">
                        <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 4v5h.582m15.356 2A8.001 8.001 0 004.582 9m0 0H9m11 11v-5h-.581m0 0a8.003 8.003 0 01-15.357-2m15.357 2H15"/>
                        </svg>
                        Tải thêm đơn hàng
                    </button>
                </div>
            <%
            }
            %>
        </div>
        
        <!-- Footer -->
        <jsp:include page="../components/footer.jsp" />
    </div>

    <script>
        // Simple filter functionality
        document.addEventListener('DOMContentLoaded', function() {
            const filterButtons = document.querySelectorAll('button[class*="bg-"][class*="100"]');
            const orderCards = document.querySelectorAll('[class*="bg-white"]');
            
            filterButtons.forEach(button => {
                button.addEventListener('click', function() {
                    // Remove active state from all buttons
                    filterButtons.forEach(btn => btn.classList.remove('ring-2', 'ring-blue-500'));
                    
                    // Add active state to clicked button
                    this.classList.add('ring-2', 'ring-blue-500');
                    
                    // Filter logic would go here
                    // This is a placeholder for actual filtering functionality
                });
            });
        });
    </script>
</body>
</html>