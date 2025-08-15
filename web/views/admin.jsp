<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="icon" type="image/x-icon" href="logo-title.ico">
        <link rel="stylesheet" href="./public/assets/styles/globals.css">
        <script src="https://cdn.jsdelivr.net/npm/@tailwindcss/browser@4"></script>
        <title>Trang quản lý sản phẩm</title>
    </head>
    <body>
        <div class="flex flex-col min-h-screen justify-between">
            <jsp:include page="../components/features/admin/header.jsp" />
            <div class="pt-24 px-5 w-full pb-32">
                <div class="max-w-4xl mx-auto">
                    <div class="bg-card rounded-lg shadow-lg p-6">
                        <h1 class="text-2xl font-bold text-foreground mb-6">Thêm Sản Phẩm Mới</h1>
                        
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
                                    rows="4"
                                    placeholder="Nhập mô tả chi tiết về sản phẩm..."
                                    class="w-full px-3 py-2 text-sm bg-background border border-input rounded-md placeholder:text-muted-foreground focus:outline-none focus:ring-2 focus:ring-ring focus:border-transparent transition-all resize-none"
                                ></textarea>
                            </div>

                            <!-- Giá sản phẩm -->
                            <div class="flex flex-col gap-2">
                                <label for="price" class="text-sm font-medium text-foreground">
                                    Giá sản phẩm (VNĐ) <span class="text-red-500">*</span>
                                </label>
                                <input
                                    name="price"
                                    id="price"
                                    type="number"
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
                                    for="productImages"
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

                                <!-- Hidden file input -->
                                <input
                                    name="productImages"
                                    id="productImages"
                                    type="file"
                                    multiple
                                    accept=".jpg,.jpeg,.png,.gif,.webp,image/*"
                                    class="hidden"
                                    required
                                />

                                <!-- Hidden inputs for base64 images -->
                                <div id="base64Container"></div>
                            </div>

                            <!-- Submit button -->
                            <div class="flex gap-4 pt-6">
                                <button
                                    type="submit"
                                    class="flex-1 px-6 py-3 bg-primary text-primary-foreground rounded-md font-medium hover:bg-primary/90 focus:outline-none focus:ring-2 focus:ring-ring transition-all"
                                >
                                    Thêm Sản Phẩm
                                </button>
                                <button
                                    type="button"
                                    onclick="resetForm()"
                                    class="px-6 py-3 bg-secondary text-secondary-foreground rounded-md font-medium hover:bg-secondary/90 focus:outline-none focus:ring-2 focus:ring-ring transition-all"
                                >
                                    Làm Mới
                                </button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
            <jsp:include page="../components/footer.jsp" />
        </div>

        <script>
            document.addEventListener("DOMContentLoaded", function () {
                const fileInput = document.getElementById("productImages");
                const uploadLabel = document.getElementById("uploadLabel");
                const imagePreviewContainer = document.getElementById("imagePreviewContainer");
                const base64Container = document.getElementById("base64Container");
                
                let selectedFiles = new Map(); // Sử dụng Map thay vì array để dễ quản lý

                // Lắng nghe sự kiện thay đổi file
                fileInput.addEventListener("change", function (event) {
                    const files = Array.from(event.target.files);
                    
                    if (files.length > 0) {
                        processFiles(files);
                        // Clear input ngay sau khi xử lý
                        fileInput.value = '';
                    }
                });

                function processFiles(files) {
                    files.forEach((file) => {
                        // Kiểm tra loại file
                        const validTypes = ["image/jpeg", "image/jpg", "image/png", "image/gif", "image/webp"];
                        if (!validTypes.includes(file.type)) {
                            alert(`File ${file.name} không hợp lệ. Vui lòng chọn file ảnh (JPG, PNG, GIF, WebP)`);
                            return;
                        }

                        // Kiểm tra kích thước file
                        const maxSize = 5 * 1024 * 1024; // 5MB
                        if (file.size > maxSize) {
                            alert(`File ${file.name} quá lớn. Vui lòng chọn file nhỏ hơn 5MB`);
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
                            alert(`File ${file.name} đã được chọn`);
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

                        // Tạo hidden inputs
                        createHiddenInputs(e.target.result, file, uniqueId);
                    };

                    reader.onerror = function (error) {
                        console.error(`Lỗi đọc file ${file.name}:`, error);
                        alert(`Có lỗi xảy ra khi đọc file ${file.name}`);
                    };

                    reader.readAsDataURL(file);
                }

                function createHiddenInputs(dataUrl, file, uniqueId) {
                    const base64String = dataUrl.split(",")[1];
                    
                    // Base64 input
                    const hiddenInput = document.createElement("input");
                    hiddenInput.type = "hidden";
                    hiddenInput.name = `imageBase64_${uniqueId}`;
                    hiddenInput.value = base64String;
                    hiddenInput.setAttribute('data-image-id', uniqueId);
                    base64Container.appendChild(hiddenInput);
                    
                    // MIME type input
                    const mimeInput = document.createElement("input");
                    mimeInput.type = "hidden";
                    mimeInput.name = `imageMimeType_${uniqueId}`;
                    mimeInput.value = file.type;
                    mimeInput.setAttribute('data-image-id', uniqueId);
                    base64Container.appendChild(mimeInput);
                    
                    // Filename input
                    const filenameInput = document.createElement("input");
                    filenameInput.type = "hidden";
                    filenameInput.name = `imageFileName_${uniqueId}`;
                    filenameInput.value = file.name;
                    filenameInput.setAttribute('data-image-id', uniqueId);
                    base64Container.appendChild(filenameInput);
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
                    console.log('Removing image with ID:', uniqueId);
                    
                    // Xóa file khỏi Map
                    if (selectedFiles.has(uniqueId)) {
                        selectedFiles.delete(uniqueId);
                        console.log('File removed from Map. Remaining files:', selectedFiles.size);
                    }
                    
                    // Xóa preview element
                    const previewElement = imagePreviewContainer.querySelector('[data-image-id="' + uniqueId + '"]');
                    if (previewElement) {
                        previewElement.remove();
                        console.log('Preview element removed');
                    }
                    
                    // Xóa tất cả hidden inputs
                    const hiddenInputs = base64Container.querySelectorAll('[data-image-id="' + uniqueId + '"]');
                    console.log('Found hidden inputs to remove:', hiddenInputs.length);
                    hiddenInputs.forEach(input => {
                        input.remove();
                    });
                    
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
            });

            // Hàm reset form
            function resetForm() {
                if (confirm("Bạn có chắc chắn muốn xóa tất cả dữ liệu đã nhập?")) {
                    // Reset form
                    document.querySelector("form").reset();
                    
                    // Clear preview container
                    const imagePreviewContainer = document.getElementById("imagePreviewContainer");
                    imagePreviewContainer.innerHTML = "";
                    imagePreviewContainer.classList.add("hidden");
                    
                    // Clear hidden inputs
                    document.getElementById("base64Container").innerHTML = "";
                    
                    // Reset upload label
                    document.getElementById("uploadLabel").querySelector("p").textContent = "Click để chọn nhiều ảnh";
                    
                    // Clear selectedFiles Map
                    if (typeof selectedFiles !== 'undefined') {
                        selectedFiles.clear();
                    }
                }
            }

            // Hàm lấy tất cả base64 strings
            function getAllBase64Data() {
                const base64Inputs = document.querySelectorAll('input[name^="imageBase64_"]');
                const mimeInputs = document.querySelectorAll('input[name^="imageMimeType_"]');
                const nameInputs = document.querySelectorAll('input[name^="imageFileName_"]');
                
                const imageData = [];
                const processedIds = new Set();
                
                base64Inputs.forEach(input => {
                    const imageId = input.getAttribute('data-image-id');
                    if (processedIds.has(imageId)) return;
                    
                    const mimeInput = document.querySelector('input[name="imageMimeType_' + imageId + '"]');
                    const nameInput = document.querySelector('input[name="imageFileName_' + imageId + '"]');
                    
                    if (input.value && mimeInput && nameInput) {
                        imageData.push({
                            base64: input.value,
                            mimeType: mimeInput.value,
                            fileName: nameInput.value,
                            dataUrl: 'data:' + mimeInput.value + ';base64,' + input.value
                        });
                        processedIds.add(imageId);
                    }
                });
                
                return imageData;
            }

            // Form submit validation
            document.querySelector('form').addEventListener('submit', function(e) {
                const imageData = getAllBase64Data();
                
                if (imageData.length === 0) {
                    e.preventDefault();
                    alert('Vui lòng chọn ít nhất một hình ảnh sản phẩm');
                    return;
                }
                
                console.log('Form submitted with', imageData.length, 'images');
            });
        </script>
    </body>
</html>