<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <link rel="icon" type="image/x-icon" href="logo-lovely.ico" />
    <title>Đăng Ký</title>
    <link rel="stylesheet" href="./public/assets/styles/globals.css" />
    <script src="https://cdn.jsdelivr.net/npm/@tailwindcss/browser@4"></script>
  </head>
  <body>
    <jsp:include page="../components/features/authentication/header.jsp" />
    <div class="w-full min-h-screen flex justify-center items-center p-4 bg-muted">
        <form class="p-6 bg-card rounded-lg flex flex-col gap-4" method="post" action="signup">
            <h1 class="text-lg font-semibold text-center text-foreground">Đăng Ký</h1>

            <!-- Email Field -->
            <div class="flex flex-col gap-2">
                <label for="email" class="text-sm font-medium text-foreground">
                    Email
                </label>
                <input
                    name="email"
                    id="email"
                    type="email"
                    placeholder="Nhập email của bạn...."
                    class="w-full h-9 px-3 py-1 text-sm bg-background border border-input rounded-md placeholder:text-muted-foreground focus:outline-none focus:ring-2 focus:ring-ring focus:border-transparent transition-all"
                />
            </div>
            
             <!-- Password Field -->
            <div class="flex flex-col gap-2">
                <label for="password" class="text-sm font-medium text-foreground">
                    Mật khẩu
                </label>
                <input
                    name="password"
                    id="password"
                    type="password"
                    placeholder="Nhập mật khẩu của bạn...."
                    class="w-full h-9 px-3 py-1 text-sm bg-background border border-input rounded-md placeholder:text-muted-foreground focus:outline-none focus:ring-2 focus:ring-ring focus:border-transparent transition-all"
                />
            </div>

            <!-- Address Field -->
            <div class="flex flex-col gap-2">
                <label for="address" class="text-sm font-medium text-foreground">
                    Địa chỉ
                </label>
                <input
                    name="address"
                    id="address"
                    type="text"
                    placeholder="Nhập địa chỉ của bạn...."
                    class="w-full h-9 px-3 py-1 text-sm bg-background border border-input rounded-md placeholder:text-muted-foreground focus:outline-none focus:ring-2 focus:ring-ring focus:border-transparent transition-all"
                />
            </div>

            <!-- Phone & Name Fields -->
            <div class="flex gap-4">
                <div class="flex flex-col gap-2 flex-1">
                    <label for="phoneNumber" class="text-sm font-medium text-foreground">
                        Số điện thoại
                    </label>
                    <input
                        name="phoneNumber"
                        id="phoneNumber"
                        type="text"
                        placeholder="Nhập số điện thoại của bạn...."
                        class="w-full h-9 px-3 py-1 text-sm bg-background border border-input rounded-md placeholder:text-muted-foreground focus:outline-none focus:ring-2 focus:ring-ring focus:border-transparent transition-all"
                    />
                </div>

                <div class="flex flex-col gap-2 flex-1">
                    <label for="fullName" class="text-sm font-medium text-foreground">
                        Họ và tên
                    </label>
                    <input
                        name="fullName"
                        id="fullName"
                        type="text"
                        placeholder="Nhập tên đầy đủ của bạn...."
                        class="w-full h-9 px-3 py-1 text-sm bg-background border border-input rounded-md placeholder:text-muted-foreground focus:outline-none focus:ring-2 focus:ring-ring focus:border-transparent transition-all"
                    />
                </div>
            </div>

            <!-- Profile Picture Upload -->
            <div class="flex flex-col gap-2">
                <label class="text-sm font-medium text-foreground">
                    Ảnh đại diện
                </label>
                
                <!-- Image Preview Container -->
                <div id="imagePreviewContainer" class="hidden relative w-full">
                    <img
                        id="imagePreview"
                        src=""
                        alt="Preview"
                        class="w-full h-44 object-cover rounded-md border border-input" 
                    />
                    <button
                        type="button"
                        id="removeImageBtn"
                        class="absolute top-2 cursor-pointer right-2 w-6 h-6 bg-destructive text-destructive-foreground rounded-sm text-xs font-medium hover:bg-destructive/90 transition-all focus:outline-none focus:ring-2 focus:ring-ring flex items-center justify-center shadow-md"
                        title="Xóa ảnh"
                    >
                        <svg xmlns="http://www.w3.org/2000/svg" width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="#fff" stroke-width="4" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-x-icon lucide-x"><path d="M18 6 6 18"/><path d="m6 6 12 12"/></svg>
                    </button>
                </div>

                <!-- Upload Label -->
                <label
                    for="pictureProfile"
                    id="uploadLabel"
                    class="w-full h-44 flex flex-col justify-center items-center text-sm font-medium text-center rounded-md border-2 border-input border-dashed cursor-pointer bg-background hover:bg-muted/50 transition-all group"
                >
                    <svg
                        xmlns="http://www.w3.org/2000/svg"
                        width="32"
                        height="32"
                        viewBox="0 0 24 24"
                        fill="none"
                        stroke="currentColor"
                        stroke-width="1.5"
                        stroke-linecap="round"
                        stroke-linejoin="round"
                        class="text-muted-foreground mb-2 group-hover:text-foreground transition-colors"
                    >
                        <path d="M10.3 21H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h14a2 2 0 0 1 2 2v10l-3.1-3.1a2 2 0 0 0-2.814.014L6 21"/>
                        <path d="m14 19.5 3-3 3 3"/>
                        <path d="M17 22v-5.5"/>
                        <circle cx="9" cy="9" r="2"/>
                    </svg>
                    <p class="text-muted-foreground group-hover:text-foreground transition-colors">
                        Click để chọn ảnh
                    </p>
                    <p class="text-xs text-muted-foreground mt-1">
                        hoặc kéo thả file vào đây
                    </p>
                </label>

                <!-- Hidden File Input -->
                <input
                    name="pictureProfile"
                    id="pictureProfile"
                    type="file"
                    accept=".jpg,.jpeg,.png,.gif,.webp"
                    class="hidden"
                />
                <input
                    type="hidden"
                    name="pictureProfileBase64"
                    id="pictureProfileBase64"
                />
                <input
                    type="hidden"
                    name="originalFileName"
                    id="originalFileName"
                />
            </div>

            <!-- Submit Button -->
            <button
                type="submit"
                class="mt-4 px-4 text-sm py-2 bg-primary text-primary-foreground rounded-md font-medium hover:bg-primary/90 focus:outline-none focus:ring-2 focus:ring-ring transition-all"
            >
                Đăng ký
            </button>
            <!-- Sign Up Link -->
            <div class="text-center text-xs">
                <span class="text-muted-foreground">Đã có tài khoản? </span>
                <a href="signin" class="text-primary font-medium hover:underline">
                   Đăng nhập
                </a>
            </div>
        </form>
    </div>

    <!-- Include image upload JavaScript -->
    <script src="${pageContext.request.contextPath}/public/assets/js/image-upload.js"></script>
    
    <script>
      document.addEventListener("DOMContentLoaded", function () {
        const fileInput = document.getElementById("pictureProfile");
        const uploadLabel = document.getElementById("uploadLabel");
        const imagePreviewContainer = document.getElementById(
          "imagePreviewContainer"
        );
        const imagePreview = document.getElementById("imagePreview");
        const removeImageBtn = document.getElementById("removeImageBtn");
        const pictureProfileBase64Input = document.getElementById(
          "pictureProfileBase64"
        );

        // Sử dụng ImageUploader class từ image-upload.js
        imageUploader.handleImageSelect = function(file, callback) {
          // Kiểm tra loại file
          const validTypes = [
            "image/jpeg",
            "image/jpg",
            "image/png",
            "image/gif",
            "image/webp",
          ];
          if (!validTypes.includes(file.type)) {
            alert("Vui lòng chọn file ảnh hợp lệ (JPG, PNG, GIF, WebP)");
            return;
          }

          // Kiểm tra kích thước file (tối đa 5MB)
          const maxSize = 5 * 1024 * 1024; // 5MB
          if (file.size > maxSize) {
            alert("File ảnh quá lớn. Vui lòng chọn file nhỏ hơn 5MB");
            return;
          }

          // Sử dụng FileReader để đọc file
          const reader = new FileReader();

          reader.onload = function (e) {
            // Hiển thị ảnh preview
            imagePreview.src = e.target.result;
            imagePreviewContainer.classList.remove("hidden");
            uploadLabel.classList.add("hidden");

            // Lưu base64 string vào hidden input
            const base64String = e.target.result.split(",")[1]; // Lấy phần base64 sau dấu phẩy
            pictureProfileBase64Input.value = base64String;
            
            // Lưu tên file gốc
            const originalFileNameInput = document.getElementById("originalFileName");
            if (originalFileNameInput) {
              originalFileNameInput.value = file.name;
            }
          };

          reader.onerror = function () {
            alert("Có lỗi xảy ra khi đọc file ảnh");
          };

          // Đọc file dưới dạng data URL
          reader.readAsDataURL(file);
        };

        // Lắng nghe sự kiện thay đổi file
        fileInput.addEventListener("change", function (event) {
          const file = event.target.files[0];
          if (file) {
            imageUploader.handleImageSelect(file);
          }
        });

        // Xử lý nút xóa ảnh
        removeImageBtn.addEventListener("click", function () {
          // Xóa ảnh preview
          imagePreview.src = "";
          imagePreviewContainer.classList.add("hidden");
          uploadLabel.classList.remove("hidden");

          // Reset input file và base64
          fileInput.value = "";
          pictureProfileBase64Input.value = "";
          
          // Xóa tên file gốc
          const originalFileNameInput = document.getElementById("originalFileName");
          if (originalFileNameInput) {
            originalFileNameInput.value = "";
          }
        });

        // Xử lý drag & drop (tùy chọn)
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

          const files = e.dataTransfer.files;
          if (files.length > 0) {
            fileInput.files = files;
            // Trigger change event
            fileInput.dispatchEvent(new Event("change"));
          }
        });
      });
    </script>
  </body>
</html>