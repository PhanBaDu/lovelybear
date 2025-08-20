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
    <link rel="icon" type="image/x-icon" href="logo-lovely.ico">
    <link rel="stylesheet" href="./public/assets/styles/globals.css">
    <script src="https://cdn.jsdelivr.net/npm/@tailwindcss/browser@4"></script>
</head>
<body class="bg-gradient-to-br from-slate-50 to-slate-100">
    <div class="flex flex-col min-h-screen justify-between">
        <!-- Header -->
        <jsp:include page="../components/header.jsp" />

        <div class="container mx-auto px-4 py-4 max-w-6xl pt-24 pb-24">
            <!-- Page Title -->
            <div class="mb-5 text-center">
                <h1 class="text-4xl font-extrabold text-gray-900 mb-4 text-foreground">Đơn Hàng Của Tôi</h1>
                <p class="text-sm text-muted-foreground font-medium">Theo dõi và quản lý đơn hàng của bạn</p>
            </div>
            
            <%
            String error = (String) request.getAttribute("error");
            String success = request.getParameter("success");
            
            if (error != null) {
            %>
                <div class="bg-gradient-to-r from-red-50 to-red-100 border border-red-200 rounded-xl p-6 mb-8 shadow-lg">
                    <div class="flex items-center">
                        <svg class="w-6 h-6 text-red-500 mr-4 flex-shrink-0" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v4m0 4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z"></path>
                        </svg>
                        <p class="text-red-800 font-semibold"><%= error %></p>
                    </div>
                </div>
            <%
            }
            
            if ("cancelled".equals(success)) {
            %>
                <div class="rounded-xl p-6 mb-4 bg-background text-green-600">
                    <div class="flex items-center justify-between">
                        <p class="text-green-600 text-sm font-semibold">Đơn hàng đã được hủy thành công!</p>
                        <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-check-check-icon lucide-check-check"><path d="M18 6 7 17l-5-5"/><path d="m22 10-7.5 7.5L13 16"/></svg>
                    </div>
                </div>
            <%
            }
            
            @SuppressWarnings("unchecked")
            List<Order> orders = (List<Order>) request.getAttribute("orders");
            
            if (orders == null || orders.isEmpty()) {
            %>
                <!-- Empty State -->
                <div class="text-center py-20">
                    <div class="w-32 h-32 mx-auto mb-8 bg-gradient-to-br from-blue-100 to-purple-100 rounded-full flex items-center justify-center shadow-lg">
                        <svg class="w-16 h-16 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5" d="M16 11V7a4 4 0 00-8 0v4M5 9h14l1 12H4L5 9z"/>
                        </svg>
                    </div>
                    <h3 class="text-2xl font-bold text-gray-900 mb-3">Chưa có đơn hàng nào</h3>
                    <p class="text-gray-600 mb-8 text-lg max-w-md mx-auto">Bạn chưa đặt đơn hàng nào. Hãy khám phá sản phẩm và đặt hàng ngay!</p>
                    <a href="${pageContext.request.contextPath}/" 
                       class="inline-flex items-center gap-3 bg-gradient-to-r from-blue-500 to-purple-600 text-white px-8 py-4 rounded-xl font-semibold hover:from-blue-600 hover:to-purple-700 transition-all duration-300 transform hover:scale-105 shadow-lg hover:shadow-xl">
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
                <!-- Orders List -->
                <div class="space-y-2">
                    <%
                    for (Order order : orders) {
                        String statusColor = "";
                        String statusText = "";
                        String statusBg = "";
                        
                        switch (order.getStatus()) {
                            case OrderStatus.PENDING:
                                statusColor = "text-yellow-700";
                                statusText = "Chờ xử lý";
                                statusBg = "bg-yellow-700/10";
                                break;
                            case OrderStatus.CONFIRMED:
                                statusColor = "text-sky-500";
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
                        <!-- Order Card -->
                        <div class="bg-white border border-gray-200 rounded-2xl overflow-hidden">
                            <!-- Order Header -->
                            <div class="px-4 py-3 border-b border-gray-200">
                                <div class="flex items-center justify-between">
                                    <div class="flex items-center gap-3">
                                        <div>
                                            <h3 class="text-base font-bold text-gray-900">Đơn hàng #<%= order.getId() %></h3>
                                            <p class="text-xs text-gray-600 font-medium mt-0.5">Đặt lúc: <%= dateFormat.format(order.getOrderDate()) %></p>
                                        </div>
                                    </div>
                                    <div class="flex items-center gap-2">
                                        <span class="inline-flex items-center px-2 py-1 rounded-full text-xs font-bold <%= statusBg %> <%= statusColor %> ">
                                            <%= statusText %>
                                        </span>
                                    </div>
                                </div>
                            </div>
                            
                            <!-- Order Body -->
                            <div class="px-4 py-3">
                                <div class="flex items-center justify-between">
                                    <div class="flex items-center gap-4">
                                        <div class="text-center rounded-lg p-2">
                                            <p class="text-xs text-gray-600 mb-1 font-semibold">Số lượng</p>
                                            <p class="text-lg font-bold"><%= order.getTotalQuantity() %></p>
                                            <p class="text-xs ">sản phẩm</p>
                                        </div>
                                        <div class="h-12 w-px bg-gradient-to-b from-gray-200 to-gray-300"></div>
                                        <div class="text-center rounded-lg p-2">
                                            <p class="text-xs text-gray-600 mb-1 font-semibold">Tổng tiền</p>
                                            <p class="text-lg font-bold"><%= String.format("%,.0f", order.getTotalAmount()) %>k</p>
                                            <p class="text-xs ">VNĐ</p>
                                        </div>
                                    </div>
                                    
                                    <div class="flex items-center gap-2">
                                        <a href="${pageContext.request.contextPath}/orders?action=detail&id=<%= order.getId() %>" 
                                           class="inline-flex items-center text-sm gap-1 px-3 py-2 border border-sky-900 text-foreground rounded-lg">
                                            Xem chi tiết
                                        </a>
                                        
                                        <% if (OrderStatus.PENDING.equals(order.getStatus())) { %>
                                            <form method="post" action="${pageContext.request.contextPath}/cancel-order" style="display: inline;">
                                                <input type="hidden" name="orderId" value="<%= order.getId() %>">
                                                <button type="submit" 
                                                        onclick="return confirm('Bạn có chắc muốn hủy đơn hàng này?')"
                                                        class="cursor-pointer inline-flex items-center text-sm gap-1 px-3 py-2 border border-destructive bg-destructive text-background rounded-lg">
                                                    Hủy đơn
                                                </button>
                                            </form>
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
    

</body>
</html>