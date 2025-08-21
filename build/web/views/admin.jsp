<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.net.URLDecoder"%>
<%@page import="data.models.Product"%>
<%@page import="data.models.Order"%>
<%@page import="java.util.List"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="icon" type="image/x-icon" href="icon-title.ico">
        <link rel="stylesheet" href="./public/assets/styles/globals.css">
        <script src="https://cdn.jsdelivr.net/npm/@tailwindcss/browser@4"></script>
        <title>Trang quản lý sản phẩm</title>
    </head>
    <body>
        <div class="flex flex-col min-h-screen items-center justify-between">
            <jsp:include page="../components/features/admin/header.jsp" />
            <div class="pt-32 px-5 w-full pb-32 bg-muted" style="
        background-image: url('./public/assets/images/background.png');
        background-size: cover;
        background-position: center;
        background-repeat: no-repeat;
      ">
                <div class="max-w-7xl mx-auto flex flex-col gap-6">
                    
                    <!-- Navigation Tabs -->
                    <div class="bg-card rounded-xl p-1 shadow-sm">
                        <div class="flex gap-1">
                            <button onclick="showTab('add-product')" id="tab-add-product" class="flex-1 px-4 py-3 text-sm font-medium rounded-lg transition-all bg-primary text-primary-foreground">
                                <span class="flex items-center justify-center gap-2">
                                    <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                        <path d="M12 5v14m-7-7h14"/>
                                    </svg>
                                    Thêm Sản Phẩm
                                </span>
                            </button>
                            <button onclick="showTab('product-list')" id="tab-product-list" class="flex-1 px-4 py-3 text-sm font-medium rounded-lg transition-all text-muted-foreground hover:text-foreground hover:bg-muted/50">
                                <span class="flex items-center justify-center gap-2">
                                    <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                        <path d="M21 8a2 2 0 0 0-1-1.73l-7-4a2 2 0 0 0-2 0l-7 4A2 2 0 0 0 3 8v8a2 2 0 0 0 1 1.73l7 4a2 2 0 0 0 2 0l7-4A2 2 0 0 0 21 16Z"/>
                                        <path d="m3.3 7 8.7 5 8.7-5"/>
                                        <path d="M12 22V12"/>
                                    </svg>
                                    Quản Lý Sản Phẩm
                                </span>
                            </button>
                            <button onclick="showTab('order-list')" id="tab-order-list" class="flex-1 px-4 py-3 text-sm font-medium rounded-lg transition-all text-muted-foreground hover:text-foreground hover:bg-muted/50">
                                <span class="flex items-center justify-center gap-2">
                                    <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                        <path d="M16 4h2a2 2 0 0 1 2 2v14a2 2 0 0 1-2 2H6a2 2 0 0 1-2-2V6a2 2 0 0 1 2-2h2"/>
                                        <rect x="8" y="2" width="8" height="4" rx="1" ry="1"/>
                                        <path d="m9 14 2 2 4-4"/>
                                    </svg>
                                    Quản Lý Đơn Hàng
                                </span>
                            </button>
                        </div>
                    </div>

                    <!-- Alert Messages -->
                    <% 
                    String successMessage = request.getParameter("success");
                    String errorMessage = request.getParameter("error");
                    %>
                    
                    <script>
                        // Hiển thị alert message khi load trang
                        <%
                        if (successMessage != null && !successMessage.trim().isEmpty()) {
                        %>
                            alert('<%= java.net.URLDecoder.decode(successMessage, "UTF-8") %>');
                        <%
                        }
                        
                        if (errorMessage != null && !errorMessage.trim().isEmpty()) {
                        %>
                            alert('<%= java.net.URLDecoder.decode(errorMessage, "UTF-8") %>');
                        <%
                        }
                        %>
                    </script>

                    <!-- Tab 1: Add Product Form -->
                    <div id="content-add-product" class="tab-content">
                        <div class="bg-card p-6 rounded-xl shadow-sm">
                            <div class="flex items-center gap-3 mb-6">
                                <div class="w-10 h-10 bg-primary/10 rounded-lg flex items-center justify-center">
                                    <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" class="text-primary">
                                        <path d="M12 5v14m-7-7h14"/>
                                    </svg>
                                </div>
                                <div>
                                    <h1 class="text-2xl font-bold text-foreground">Thêm Sản Phẩm Mới</h1>
                                    <p class="text-sm text-muted-foreground">Điền thông tin chi tiết để thêm sản phẩm vào hệ thống</p>
                                </div>
                            </div>
                            
                            <form method="post" action="add-product" enctype="multipart/form-data" class="space-y-6">
                                
                                <!-- Product Name & Price Row -->
                                <div class="grid grid-cols-1 lg:grid-cols-2 gap-6">
                                    <!-- Tên sản phẩm -->
                                    <div class="flex flex-col gap-2">
                                        <label for="productName" class="text-sm font-medium text-foreground">
                                            Tên sản phẩm <span class="text-red-500">*</span>
                                        </label>
                                        <input
                                            name="productName"
                                            id="productName"
                                            type="text"
                                            placeholder="Nhập tên sản phẩm..."
                                            required
                                            class="w-full h-12 px-4 py-3 text-sm bg-background border border-input rounded-lg placeholder:text-muted-foreground focus:outline-none focus:ring-2 focus:ring-ring focus:border-transparent transition-all"
                                        />
                                    </div>

                                    <!-- Giá sản phẩm -->
                                    <div class="flex flex-col gap-2">
                                        <label for="price" class="text-sm font-medium text-foreground">
                                            Giá sản phẩm (VNĐ) <span class="text-red-500">*</span>
                                        </label>
                                        <input
                                            name="price"
                                            id="price"
                                            type="text"
                                            min="0"
                                            step="1000"
                                            placeholder="0"
                                            required
                                            class="w-full h-12 px-4 py-3 text-sm bg-background border border-input rounded-lg placeholder:text-muted-foreground focus:outline-none focus:ring-2 focus:ring-ring focus:border-transparent transition-all"
                                        />
                                    </div>
                                </div>

                                <!-- Mô tả sản phẩm -->
                                <div class="flex flex-col gap-2">
                                    <label for="description" class="text-sm font-medium text-foreground">
                                        Mô tả sản phẩm
                                    </label>
                                    <textarea
                                        name="description"
                                        id="description"
                                        rows="4"
                                        placeholder="Nhập mô tả chi tiết về sản phẩm..."
                                        class="w-full px-4 py-3 text-sm bg-background border border-input rounded-lg placeholder:text-muted-foreground focus:outline-none focus:ring-2 focus:ring-ring focus:border-transparent transition-all resize-none"
                                    ></textarea>
                                </div>

                                <!-- Upload nhiều ảnh -->
                                <div class="flex flex-col gap-2">
                                    <label class="text-sm font-medium text-foreground">
                                        Hình ảnh sản phẩm <span class="text-red-500">*</span>
                                    </label>
                                    
                                    <!-- Khu vực hiển thị ảnh đã chọn -->
                                    <div id="imagePreviewContainer" class="grid grid-cols-2 md:grid-cols-3 lg:grid-cols-4 gap-4 mb-4 hidden">
                                        <!-- Preview images will be inserted here -->
                                    </div>

                                    <!-- Upload area -->
                                    <label
                                        for="image"
                                        id="uploadLabel"
                                        class="w-full h-48 flex flex-col justify-center items-center text-sm font-medium text-center rounded-lg border-2 border-input border-dashed cursor-pointer bg-background hover:bg-muted/50 transition-all group"
                                    >
                                        <svg
                                            xmlns="http://www.w3.org/2000/svg"
                                            width="48"
                                            height="48"
                                            viewBox="0 0 24 24"
                                            fill="none"
                                            stroke="currentColor"
                                            stroke-width="1.5"
                                            stroke-linecap="round"
                                            stroke-linejoin="round"
                                            class="text-muted-foreground mb-4 group-hover:text-foreground transition-colors"
                                        >
                                            <path d="M14.5 4h-5L7 7H4a2 2 0 0 0-2 2v9a2 2 0 0 0 2 2h16a2 2 0 0 0 2-2V9a2 2 0 0 0-2-2h-3l-2.5-3z"/>
                                            <circle cx="12" cy="13" r="3"/>
                                        </svg>
                                        <p class="text-foreground group-hover:text-foreground transition-colors font-medium mb-2">
                                            Click để chọn nhiều ảnh
                                        </p>
                                        <p class="text-xs text-muted-foreground">
                                            Hoặc kéo thả file vào đây
                                        </p>
                                        <p class="text-xs text-muted-foreground mt-1">
                                            Hỗ trợ: JPG, PNG, GIF, WebP (Tối đa 5MB mỗi file)
                                        </p>
                                    </label>

                                    <!-- File input cho nhiều ảnh -->
                                    <input
                                        name="image"
                                        id="image"
                                        type="file"
                                        multiple
                                        accept=".jpg,.jpeg,.png,.gif,.webp,image/*"
                                        class="hidden"
                                        required
                                    />
                                </div>

                                <!-- Submit buttons -->
                                <div class="flex gap-4 pt-6">
                                    <button
                                        type="submit"
                                        id="submitButton"
                                        class="flex-1 lg:flex-none lg:px-8 text-sm px-6 py-3 cursor-pointer bg-primary text-primary-foreground rounded-lg font-medium hover:bg-primary/90 focus:outline-none focus:ring-2 focus:ring-ring transition-all"
                                    >
                                        Thêm Sản Phẩm
                                    </button>
                                    <button
                                        type="button"
                                        onclick="resetForm()"
                                        class="text-sm px-6 cursor-pointer py-3 bg-secondary text-secondary-foreground rounded-lg font-medium hover:bg-secondary/90 focus:outline-none focus:ring-2 focus:ring-ring transition-all"
                                    >
                                        Làm Mới
                                    </button>
                                </div>
                            </form>
                        </div>
                    </div>

                    <!-- Tab 2: Product List -->
                    <div id="content-product-list" class="tab-content hidden">
                        <div class="bg-card p-6 rounded-xl shadow-sm">
                            <div class="flex items-center justify-between mb-6">
                                <div class="flex items-center gap-3">
                                    <div class="w-10 h-10 bg-primary/10 rounded-lg flex items-center justify-center">
                                        <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" class="text-primary">
                                            <path d="M21 8a2 2 0 0 0-1-1.73l-7-4a2 2 0 0 0-2 0l-7 4A2 2 0 0 0 3 8v8a2 2 0 0 0 1 1.73l7 4a2 2 0 0 0 2 0l7-4A2 2 0 0 0 21 16Z"/>
                                            <path d="m3.3 7 8.7 5 8.7-5"/>
                                            <path d="M12 22V12"/>
                                        </svg>
                                    </div>
                                    <div>
                                        <h2 class="text-2xl font-bold text-foreground">Quản Lý Sản Phẩm</h2>
                                        <p class="text-sm text-muted-foreground">Danh sách tất cả sản phẩm trong hệ thống</p>
                                    </div>
                                </div>
                                <%
                                @SuppressWarnings("unchecked")
                                List<Product> products = (List<Product>) request.getAttribute("products");
                                int productCount = (products != null) ? products.size() : 0;
                                %>
                                <div class="bg-primary/10 px-4 py-2 rounded-lg">
                                    <span class="text-sm font-medium text-primary">Tổng: <%= productCount %> sản phẩm</span>
                                </div>
                            </div>
                            
                            <%
                            if (products == null || products.isEmpty()) {
                            %>
                                <div class="text-center py-12">
                                    <div class="w-16 h-16 bg-muted/50 rounded-full flex items-center justify-center mx-auto mb-4">
                                        <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" class="text-muted-foreground">
                                            <path d="M21 8a2 2 0 0 0-1-1.73l-7-4a2 2 0 0 0-2 0l-7 4A2 2 0 0 0 3 8v8a2 2 0 0 0 1 1.73l7 4a2 2 0 0 0 2 0l7-4A2 2 0 0 0 21 16Z"/>
                                        </svg>
                                    </div>
                                    <h3 class="text-lg font-medium text-foreground mb-2">Chưa có sản phẩm nào</h3>
                                    <p class="text-muted-foreground mb-6">Hãy thêm sản phẩm đầu tiên của bạn</p>
                                    <button onclick="showTab('add-product')" class="px-6 py-2 bg-primary text-primary-foreground rounded-lg font-medium hover:bg-primary/90 transition-all">
                                        Thêm Sản Phẩm Ngay
                                    </button>
                                </div>
                            <%
                            } else {
                            %>
                                <div class="overflow-x-auto">
                                    <table class="w-full text-sm">
                                        <thead>
                                            <tr class="border-b border-input">
                                                <th class="text-left py-4 px-4 font-semibold text-foreground">ID</th>
                                                <th class="text-left py-4 px-4 font-semibold text-foreground">Tên Sản Phẩm</th>
                                                <th class="text-left py-4 px-4 font-semibold text-foreground">Mô Tả</th>
                                                <th class="text-left py-4 px-4 font-semibold text-foreground">Giá (VNĐ)</th>
                                                <th class="text-center py-4 px-4 font-semibold text-foreground">Thao Tác</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <%
                                            for (Product product : products) {
                                            %>
                                                <tr class="border-b border-input hover:bg-muted/30 transition-colors">
                                                    <td class="py-4 px-4 text-foreground font-mono text-xs bg-muted/20 rounded">
                                                        #<%= product.getId() %>
                                                    </td>
                                                    <td class="py-4 px-4 text-foreground font-medium">
                                                        <%= product.getName() %>
                                                    </td>
                                                    <td class="py-4 px-4 text-foreground">
                                                        <div class="max-w-xs truncate" title="<%= product.getDescription() != null ? product.getDescription() : "" %>">
                                                            <%= product.getDescription() != null ? product.getDescription() : "Không có mô tả" %>
                                                        </div>
                                                    </td>
                                                    <td class="py-4 px-4 text-foreground font-semibold">
                                                        <span class="text-green-600">
                                                            <%= String.format("%,.0f", product.getPrice()) %>k
                                                        </span>
                                                    </td>
                                                    <td class="py-4 px-4 text-center">
                                                        <button onclick="deleteProduct(<%= product.getId() %>)" 
                                                                class="px-4 py-2 text-xs bg-red-500 text-white rounded-lg hover:bg-red-600 transition-colors font-medium">
                                                            Xóa
                                                        </button>
                                                    </td>
                                                </tr>
                                            <%
                                            }
                                            %>
                                        </tbody>
                                    </table>
                                </div>
                            <%
                            }
                            %>
                        </div>
                    </div>

                    <!-- Tab 3: Order List -->
                    <div id="content-order-list" class="tab-content hidden">
                        <div class="bg-card p-6 rounded-xl shadow-sm">
                            <div class="flex items-center justify-between mb-6">
                                <div class="flex items-center gap-3">
                                    <div class="w-10 h-10 bg-primary/10 rounded-lg flex items-center justify-center">
                                        <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" class="text-primary">
                                            <path d="M16 4h2a2 2 0 0 1 2 2v14a2 2 0 0 1-2 2H6a2 2 0 0 1-2-2V6a2 2 0 0 1 2-2h2"/>
                                            <rect x="8" y="2" width="8" height="4" rx="1" ry="1"/>
                                            <path d="m9 14 2 2 4-4"/>
                                        </svg>
                                    </div>
                                    <div>
                                        <h1 class="text-2xl font-bold text-foreground">Quản Lý Đơn Hàng</h1>
                                        <p class="text-sm text-muted-foreground">Theo dõi và xử lý đơn hàng từ khách hàng</p>
                                    </div>
                                </div>
                                <%
                                @SuppressWarnings("unchecked")
                                List<Order> orders = (List<Order>) request.getAttribute("orders");
                                int orderCount = (orders != null) ? orders.size() : 0;
                                %>
                                <div class="bg-primary/10 px-4 py-2 rounded-lg">
                                    <span class="text-sm font-medium text-primary">Tổng: <%= orderCount %> đơn hàng</span>
                                </div>
                            </div>

                            <%
                            if (orders == null || orders.isEmpty()) {
                            %>
                                <div class="text-center py-12">
                                    <div class="w-16 h-16 bg-muted/50 rounded-full flex items-center justify-center mx-auto mb-4">
                                        <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" class="text-muted-foreground">
                                            <path d="M16 4h2a2 2 0 0 1 2 2v14a2 2 0 0 1-2 2H6a2 2 0 0 1-2-2V6a2 2 0 0 1 2-2h2"/>
                                            <rect x="8" y="2" width="8" height="4" rx="1" ry="1"/>
                                        </svg>
                                    </div>
                                    <h3 class="text-lg font-medium text-foreground mb-2">Chưa có đơn hàng nào</h3>
                                    <p class="text-muted-foreground">Các đơn hàng mới sẽ xuất hiện ở đây</p>
                                </div>
                            <%
                            } else {
                            %>
                                <div class="overflow-x-auto">
                                    <table class="w-full text-sm">
                                        <thead>
                                            <tr class="border-b border-input">
                                                <th class="text-left py-4 px-4 font-semibold text-foreground">ID</th>
                                                <th class="text-left py-4 px-4 font-semibold text-foreground">Email Khách Hàng</th>
                                                <th class="text-left py-4 px-4 font-semibold text-foreground">Ngày Đặt</th>
                                                <th class="text-center py-4 px-4 font-semibold text-foreground">Số Lượng</th>
                                                <th class="text-left py-4 px-4 font-semibold text-foreground">Tổng Tiền</th>
                                                <th class="text-center py-4 px-4 font-semibold text-foreground">Trạng Thái</th>
                                                <th class="text-center py-4 px-4 font-semibold text-foreground">Thao Tác</th>
                                            </tr>
                                        </thead>
                                        <tbody>
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
                                                <tr class="border-b border-input hover:bg-muted/30 transition-colors">
                                                    <td class="py-4 px-4 text-foreground font-mono text-xs bg-muted/20 rounded">
                                                        #<%= order.getId() %>
                                                    </td>
                                                    <td class="py-4 px-4 text-foreground"><%= order.getUserEmail() %></td>
                                                    <td class="py-4 px-4 text-foreground">
                                                        <%= new java.text.SimpleDateFormat("dd/MM/yyyy HH:mm").format(order.getOrderDate()) %>
                                                    </td>
                                                    <td class="py-4 px-4 text-center">
                                                        <span class="bg-muted/50 px-2 py-1 rounded text-foreground font-medium">
                                                            <%= order.getTotalQuantity() %>
                                                        </span>
                                                    </td>
                                                    <td class="py-4 px-4 text-foreground font-semibold">
                                                        <span class="text-green-600">
                                                            <%= String.format("%,.0f", order.getTotalAmount()) %>k
                                                        </span>
                                                    </td>
                                                    <td class="py-4 px-4 text-center">
                                                        <span class="inline-flex items-center px-3 py-1 rounded-full text-xs font-medium <%= statusColor %>">
                                                            <%= statusText %>
                                                        </span>
                                                    </td>
                                                    <td class="py-4 px-4 text-center">
                                                        <%
                                                        if ("PENDING".equals(order.getStatus())) {
                                                        %>
                                                            <button onclick="updateOrderStatus(<%= order.getId() %>, 'CONFIRMED')" 
                                                                    class="px-4 py-2 text-xs bg-green-500 text-white rounded-lg hover:bg-green-600 transition-colors font-medium">
                                                                Xác nhận
                                                            </button>
                                                        <%
                                                        } else {
                                                        %>
                                                            <span class="text-sm text-gray-500 bg-gray-100 px-3 py-1 rounded-lg">Đã xử lý</span>
                                                        <%
                                                        }
                                                        %>
                                                    </td>
                                                </tr>
                                            <%
                                            }
                                            %>
                                        </tbody>
                                    </table>
                                </div>
                            <%
                            }
                            %>
                        </div>
                    </div>
                </div>
            </div>
            <jsp:include page="../components/footer.jsp" />
        </div>

        <script>
            // Tab Management
            function showTab(tabName) {
                // Hide all tab contents
                const tabContents = document.querySelectorAll('.tab-content');
                tabContents.forEach(content => {
                    content.classList.add('hidden');
                });

                // Remove active class from all tab buttons
                const tabButtons = document.querySelectorAll('[id^="tab-"]');
                tabButtons.forEach(button => {
                    button.className = "flex-1 px-4 py-3 text-sm font-medium rounded-lg transition-all text-muted-foreground hover:text-foreground hover:bg-muted/50";
                });

                // Show selected tab content
                const selectedContent = document.getElementById('content-' + tabName);
                if (selectedContent) {
                    selectedContent.classList.remove('hidden');
                }

                // Add active class to selected tab button
                const selectedButton = document.getElementById('tab-' + tabName);
                if (selectedButton) {
                    selectedButton.className = "flex-1 px-4 py-3 text-sm font-medium rounded-lg transition-all bg-primary text-primary-foreground";
                }
            }

            document.addEventListener("DOMContentLoaded", function () {
                const fileInput = document.getElementById("image");
                const uploadLabel = document.getElementById("uploadLabel");
                const imagePreviewContainer = document.getElementById("imagePreviewContainer");
                const submitButton = document.getElementById("submitButton");
                
                let selectedFiles = new Map(); // Sử dụng Map để lưu nhiều file

                // Lắng nghe sự kiện thay đổi file
                fileInput.addEventListener("change", function (event) {
                    const files = Array.from(event.target.files);
                    
                    if (files.length > 0) {
                        processFiles(files);
                    }
                });

                function processFiles(files) {
                    files.forEach((file) => {
                        // Kiểm tra loại file
                        const validTypes = ["image/jpeg", "image/jpg", "image/png", "image/gif", "image/webp"];
                        if (!validTypes.includes(file.type)) {
                            alert('File ' + file.name + ' không hợp lệ. Vui lòng chọn file ảnh (JPG, PNG, GIF, WebP)');
                            return;
                        }

                        // Kiểm tra kích thước file
                        const maxSize = 5 * 1024 * 1024; // 5MB
                        if (file.size > maxSize) {
                            alert('File ' + file.name + ' quá lớn. Vui lòng chọn file nhỏ hơn 5MB');
                            return;
                        }

                        // Tạo unique ID cho file
                        const uniqueId = 'img_' + Date.now() + '_' + Math.random().toString(36).substring(2, 11);

                        // Kiểm tra trùng lặp dựa trên signature của file
                        const fileSignature = file.name + '_' + file.size + '_' + file.lastModified;
                        let isDuplicate = false;
                        selectedFiles.forEach((existingFile, id) => {
                            const existingSignature = existingFile.name + '_' + existingFile.size + '_' + existingFile.lastModified;
                            if (existingSignature === fileSignature) {
                                isDuplicate = true;
                            }
                        });

                        if (isDuplicate) {
                            alert('File ' + file.name + ' đã được chọn');
                            return;
                        }

                        // Lưu file vào Map
                        selectedFiles.set(uniqueId, file);
                        
                        // Hiển thị preview
                        displayImagePreview(file, uniqueId);
                    });

                    updateUploadLabel();
                }

                function displayImagePreview(file, uniqueId) {
                    const reader = new FileReader();
                    
                    reader.onload = function (e) {
                        // Validation cơ bản
                        if (!e.target.result.startsWith('data:image/')) {
                            console.error('Invalid image data');
                            return;
                        }
                        
                        // Tạo preview element
                        const previewDiv = document.createElement("div");
                        previewDiv.className = "relative group";
                        previewDiv.setAttribute('data-image-id', uniqueId);
                        
                        // Tạo img element
                        const imgElement = document.createElement('img');
                        imgElement.alt = file.name;
                        imgElement.className = "w-full h-32 object-cover rounded-lg border border-input";
                        imgElement.src = e.target.result;
                        
                        // Tạo button xóa với absolute positioning
                        const removeButton = document.createElement('button');
                        removeButton.type = 'button';
                        removeButton.className = "absolute top-2 right-2 w-6 h-6 bg-red-500 text-white rounded-full text-xs hover:bg-red-600 transition-all opacity-0 group-hover:opacity-100 flex items-center justify-center";
                        removeButton.title = "Xóa ảnh";
                        removeButton.innerHTML = "×";
                        removeButton.onclick = function(e) {
                            e.preventDefault();
                            e.stopPropagation();
                            removeImage(uniqueId);
                        };
                        
                        // Thêm elements vào preview
                        previewDiv.appendChild(imgElement);
                        previewDiv.appendChild(removeButton);
                        
                        // Thêm preview vào container
                        imagePreviewContainer.appendChild(previewDiv);
                        imagePreviewContainer.classList.remove("hidden");
                    };

                    reader.onerror = function (error) {
                        console.error('Lỗi đọc file ' + file.name + ':', error);
                        alert('Có lỗi xảy ra khi đọc file ' + file.name);
                    };

                    reader.readAsDataURL(file);
                }

                function updateUploadLabel() {
                    const count = selectedFiles.size;
                    const labelText = uploadLabel.querySelector("p");
                    if (count > 0) {
                        labelText.textContent = count + " ảnh đã được chọn - Click để thêm ảnh khác";
                    } else {
                        labelText.textContent = "Click để chọn nhiều ảnh";
                        imagePreviewContainer.classList.add("hidden");
                    }
                }

                // Hàm xóa ảnh
                window.removeImage = function(uniqueId) {
                    // Xóa file khỏi Map
                    if (selectedFiles.has(uniqueId)) {
                        selectedFiles.delete(uniqueId);
                    }
                    
                    // Xóa preview element
                    const previewElement = imagePreviewContainer.querySelector('[data-image-id="' + uniqueId + '"]');
                    if (previewElement) {
                        previewElement.remove();
                    }
                    
                    updateUploadLabel();
                };

                // Xử lý drag & drop
                uploadLabel.addEventListener("dragover", function (e) {
                    e.preventDefault();
                    uploadLabel.classList.add("bg-muted");
                });

                uploadLabel.addEventListener("dragleave", function (e) {
                    e.preventDefault();
                    uploadLabel.classList.remove("bg-muted");
                });

                uploadLabel.addEventListener("drop", function (e) {
                    e.preventDefault();
                    uploadLabel.classList.remove("bg-muted");

                    const files = Array.from(e.dataTransfer.files);
                    if (files.length > 0) {
                        processFiles(files);
                    }
                });

                // Format giá tiền
                const priceInput = document.getElementById("price");
                priceInput.addEventListener("input", function(e) {
                    let value = e.target.value.replace(/\D/g, '');
                    if (value) {
                        e.target.value = parseInt(value).toLocaleString('vi-VN');
                    }
                });

                priceInput.addEventListener("blur", function(e) {
                    let value = e.target.value.replace(/\D/g, '');
                    if (value) {
                        e.target.value = parseInt(value).toLocaleString('vi-VN');
                    }
                });

                // Form submit validation
                document.querySelector('form').addEventListener('submit', function(e) {
                    console.log('=== FORM SUBMIT DEBUG ===');
                    
                    // Kiểm tra basic fields
                    const productName = document.getElementById('productName').value.trim();
                    const price = document.getElementById('price').value.trim();
                    
                    console.log('Product Name:', productName);
                    console.log('Price:', price);
                    
                    if (!productName) {
                        e.preventDefault();
                        alert('Vui lòng nhập tên sản phẩm');
                        return;
                    }
                    
                    if (!price) {
                        e.preventDefault();
                        alert('Vui lòng nhập giá sản phẩm');
                        return;
                    }
                    
                    // Kiểm tra image - Kiểm tra có ít nhất 1 ảnh
                    if (selectedFiles.size === 0) {
                        e.preventDefault();
                        alert('Vui lòng chọn ít nhất một hình ảnh sản phẩm');
                        return;
                    }
                    
                    console.log('Form validation passed, submitting...');
                    
                    // Disable submit button để tránh double submit
                    submitButton.disabled = true;
                    submitButton.textContent = 'Đang xử lý...';
                    
                    // Wait a bit to see console logs
                    setTimeout(() => {
                        console.log('Form should submit now...');
                    }, 100);
                });
            });

            // Hàm reset form
            function resetForm() {
                if (confirm("Bạn có chắc chắn muốn xóa tất cả dữ liệu đã nhập?")) {
                    // Reset form
                    document.querySelector("form").reset();
                    
                    // Clear preview container
                    const imagePreviewContainer = document.getElementById("imagePreviewContainer");
                    imagePreviewContainer.classList.add("hidden");
                    imagePreviewContainer.innerHTML = ""; // Clear any existing preview
                    
                    // Clear selectedFiles
                    selectedFiles.clear();
                    document.getElementById("image").value = ""; // Clear file input
                    
                    // Re-enable submit button
                    const submitButton = document.getElementById("submitButton");
                    submitButton.disabled = false;
                    submitButton.textContent = 'Thêm Sản Phẩm';
                }
            }

            // Hàm lấy tất cả base64 strings
            function getAllBase64Data() {
                // This function is no longer needed as we are not using multipart/form-data
                // and the image is handled directly.
                return [];
            }
            
            // Hàm đóng message
            window.closeMessage = function(messageId) {
                const messageElement = document.getElementById(messageId);
                if (messageElement) {
                    messageElement.style.transition = 'opacity 0.3s ease-out';
                    messageElement.style.opacity = '0';
                    setTimeout(() => {
                        messageElement.remove();
                    }, 300);
                }
            };
            
            // Tự động ẩn success message sau 5 giây
            const successMessage = document.getElementById('successMessage');
            if (successMessage) {
                setTimeout(() => {
                    closeMessage('successMessage');
                }, 5000);
            }
            
            // Tự động ẩn error message sau 8 giây
            const errorMessage = document.getElementById('errorMessage');
            if (errorMessage) {
                setTimeout(() => {
                    closeMessage('errorMessage');
                }, 8000);
            }

            // Admin Functions JavaScript
            // Product Management Functions
            function deleteProduct(productId) {
                if (confirm('Bạn có chắc muốn xóa sản phẩm này?')) {
                    // Redirect đến servlet xóa sản phẩm
                    window.location.href = 'delete-product?productId=' + productId;
                }
            }
            
            // Order Management Functions
            function updateOrderStatus(orderId, newStatus) {
                if (confirm('Bạn có chắc muốn xác nhận đơn hàng này?')) {
                    // Redirect đến servlet cập nhật trạng thái đơn hàng
                    window.location.href = 'update-order-status?orderId=' + orderId + '&status=' + newStatus;
                }
            }
            
            // Refresh page after successful operations
            function refreshPage() {
                location.reload();
            }

            // Initialize default tab
            showTab('add-product');
        </script>
    </body>
</html>