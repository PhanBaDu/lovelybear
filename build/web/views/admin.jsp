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
            <div class="pt-32 px-5 w-full pb-32 bg-muted">
                <div class="max-w-6xl mx-auto flex flex-col gap-10">
                    <div class="bg-card p-5 rounded-xl">
                        <h1 class="text-2xl font-bold text-foreground mb-6">Thêm Sản Phẩm Mới</h1>
                        
                                                 <!-- Hiển thị message từ URL parameters -->
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
                        
                        <!-- Đổi enctype từ multipart/form-data thành application/x-www-form-urlencoded -->
                        <form method="post" action="add-product" enctype="multipart/form-data" class="space-y-6">
                            
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
                                    class="w-full h-10 px-3 py-2 text-sm bg-background border border-input rounded-md placeholder:text-muted-foreground focus:outline-none focus:ring-2 focus:ring-ring focus:border-transparent transition-all"
                                />
                            </div>

                            <!-- Mô tả sản phẩm -->
                            <div class="flex flex-col gap-2">
                                <label for="description" class="text-sm font-medium text-foreground">
                                    Mô tả sản phẩm
                                </label>
                                <textarea
                                    name="description"
                                    id="description"
                                    rows="6"
                                    placeholder="Nhập mô tả chi tiết về sản phẩm..."
                                    class="w-full px-3 py-2 text-sm bg-background border-input placeholder:text-muted-foreground  flex field-sizing-content min-h-16 w-full rounded-md border bg-transparent px-3 py-2 text-base shadow-xs transition-[color,box-shadow] outline-none md:text-sm"                                ></textarea>
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
                                    class="w-full h-10 px-3 py-2 text-sm bg-background border border-input rounded-md placeholder:text-muted-foreground focus:outline-none focus:ring-2 focus:ring-ring focus:border-transparent transition-all"
                                />
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
                                    class="w-full h-44 flex flex-col justify-center items-center text-sm font-medium text-center rounded-md border-2 border-input border-dashed cursor-pointer bg-background hover:bg-muted/50 transition-all group"
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
                                        class="text-muted-foreground mb-3 group-hover:text-foreground transition-colors"
                                    >
                                        <path d="M14.5 4h-5L7 7H4a2 2 0 0 0-2 2v9a2 2 0 0 0 2 2h16a2 2 0 0 0 2-2V9a2 2 0 0 0-2-2h-3l-2.5-3z"/>
                                        <circle cx="12" cy="13" r="3"/>
                                    </svg>
                                    <p class="text-foreground group-hover:text-foreground transition-colors font-medium mb-1">
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

                            <!-- Submit button -->
                            <div class="flex gap-4 pt-6">
                                <button
                                    type="submit"
                                    id="submitButton"
                                    class="flex-1 text-sm px-6 py-3 cursor-pointer bg-primary text-primary-foreground rounded-md font-medium hover:bg-primary/90 focus:outline-none focus:ring-2 focus:ring-ring transition-all"
                                >
                                    Thêm Sản Phẩm
                                </button>
                                <button
                                    type="button"
                                    onclick="resetForm()"
                                    class="text-sm px-6 cursor-pointer py-3 bg-secondary text-secondary-foreground rounded-md font-medium hover:bg-secondary/90 focus:outline-none focus:ring-2 focus:ring-ring transition-all"
                                >
                                    Làm Mới
                                </button>
                            </div>
                        </form>
                    </div>
                    <!-- Card 2: Hiển thị toàn bộ sản phẩm -->
                    <div class="bg-card p-5 rounded-xl mb-6">
                        <h2 class="text-xl font-bold text-foreground mb-4">Danh Sách Sản Phẩm</h2>
                        <%
                        @SuppressWarnings("unchecked")
                        List<Product> products = (List<Product>) request.getAttribute("products");

                        if (products == null || products.isEmpty()) {
                        %>
                            <h1 class="text-2xl font-bold text-foreground mb-6">Chưa có sản phẩm nào</h1>
                        <%
                        } else {
                        %>
                            <div class="overflow-x-auto">
                                <table class="w-full text-sm">
                                    <thead>
                                        <tr class="border-b border-input">
                                            <th class="text-left py-3 px-4 font-medium text-foreground">ID</th>
                                            <th class="text-left py-3 px-4 font-medium text-foreground">Tên Sản Phẩm</th>
                                            <th class="text-left py-3 px-4 font-medium text-foreground">Mô Tả</th>
                                            <th class="text-left py-3 px-4 font-medium text-foreground">Giá (VNĐ)</th>
                                            <th class="text-left py-3 px-4 font-medium text-foreground">Thao Tác</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <%
                                        for (Product product : products) {
                                        %>
                                            <tr class="border-b border-input hover:bg-muted/50">
                                                <td class="py-3 px-4 text-foreground"><%= product.getId() %></td>
                                                <td class="py-3 px-4 text-foreground font-medium"><%= product.getName() %></td>
                                                <td class="py-3 px-4 text-foreground">
                                                    <div class="max-w-xs truncate" title="<%= product.getDescription() != null ? product.getDescription() : "" %>">
                                                        <%= product.getDescription() != null ? product.getDescription() : "Không có mô tả" %>
                                                    </div>
                                                </td>
                                                <td class="py-3 px-4 text-foreground">
                                                    <%= String.format("%,.0f", product.getPrice()) %>k
                                                </td>
                                                                                             <td class="py-3 px-4">
                                                     <button onclick="deleteProduct(<%= product.getId() %>)" 
                                                             class="px-3 py-1 text-xs bg-red-500 text-white rounded hover:bg-red-600 transition-colors">
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
                     <!-- Card 3: Hiển thị danh sách đơn hàng -->
                    <div class="bg-card p-5 rounded-xl mb-6">
                        <h1 class="text-2xl font-bold text-foreground mb-6">Danh Sách Đơn Hàng</h1>
                        <%
                        @SuppressWarnings("unchecked")
                        List<Order> orders = (List<Order>) request.getAttribute("orders");

                        if (orders == null || orders.isEmpty()) {
                        %>
                            <div class="text-center py-8">
                                <p class="text-muted-foreground">Chưa có đơn hàng nào</p>
                            </div>
                        <%
                        } else {
                        %>
                            <div class="overflow-x-auto">
                                <table class="w-full text-sm">
                                    <thead>
                                        <tr class="border-b border-input">
                                            <th class="text-left py-3 px-4 font-medium text-foreground">ID</th>
                                            <th class="text-left py-3 px-4 font-medium text-foreground">Email Khách Hàng</th>
                                            <th class="text-left py-3 px-4 font-medium text-foreground">Ngày Đặt</th>
                                            <th class="text-left py-3 px-4 font-medium text-foreground">Số Lượng</th>
                                            <th class="text-left py-3 px-4 font-medium text-foreground">Tổng Tiền</th>
                                            <th class="text-left py-3 px-4 font-medium text-foreground">Trạng Thái</th>
                                            <th class="text-left py-3 px-4 font-medium text-foreground">Thao Tác</th>
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
                                            <tr class="border-b border-input hover:bg-muted/50">
                                                <td class="py-3 px-4 text-foreground"><%= order.getId() %></td>
                                                <td class="py-3 px-4 text-foreground"><%= order.getUserEmail() %></td>
                                                <td class="py-3 px-4 text-foreground">
                                                    <%= new java.text.SimpleDateFormat("dd/MM/yyyy HH:mm").format(order.getOrderDate()) %>
                                                </td>
                                                <td class="py-3 px-4 text-foreground"><%= order.getTotalQuantity() %></td>
                                                <td class="py-3 px-4 text-foreground font-medium">
                                                    <%= String.format("%,.0f", order.getTotalAmount()) %>k
                                                </td>
                                                <td class="py-3 px-4">
                                                    <span class="inline-flex items-center px-2 py-1 rounded-full text-xs font-medium <%= statusColor %>">
                                                        <%= statusText %>
                                                    </span>
                                                </td>
                                                                                             <td class="py-3 px-4">
                                                     <%
                                                     if ("PENDING".equals(order.getStatus())) {
                                                     %>
                                                         <button onclick="updateOrderStatus(<%= order.getId() %>, 'CONFIRMED')" 
                                                                 class="px-3 py-1 text-xs bg-green-500 text-white rounded hover:bg-green-600 transition-colors">
                                                             Xác nhận
                                                         </button>
                                                     <%
                                                     } else {
                                                     %>
                                                         <span class="text-sm text-gray-500">Đã xác nhận</span>
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
            <jsp:include page="../components/footer.jsp" />
        </div>

        <script>
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
                        imgElement.className = "w-full h-32 object-cover rounded-md border border-input";
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

                // Form submit validation - FIXED
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
        </script>
        
                 <!-- Admin Functions JavaScript -->
         <script>
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
         </script>
    </body>
</html>