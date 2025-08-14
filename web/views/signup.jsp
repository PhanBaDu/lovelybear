<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <link rel="icon" type="image/x-icon" href="logo-title.ico" />
    <title>Đăng Ký</title>
    <link rel="stylesheet" href="./public/assets/styles/globals.css" />
    <script src="https://cdn.jsdelivr.net/npm/@tailwindcss/browser@4"></script>
    <style>
      .error-message {
        animation: slideDown 0.3s ease-out;
      }
      
      @keyframes slideDown {
        from {
          opacity: 0;
          transform: translateY(-10px);
        }
        to {
          opacity: 1;
          transform: translateY(0);
        }
      }
      
      .input-error {
        border-color: var(--destructive) !important;
        box-shadow: 0 0 0 2px rgba(239, 68, 68, 0.1) !important;
      }
      
      .input-error:focus {
        border-color: var(--destructive) !important;
        box-shadow: 0 0 0 2px rgba(239, 68, 68, 0.2) !important;
      }
      
      .success-message {
        animation: slideIn 0.5s ease-out;
      }
      
      @keyframes slideIn {
        from {
          opacity: 0;
          transform: translateX(-20px);
        }
        to {
          opacity: 1;
          transform: translateX(0);
        }
      }
    </style>
  </head>
  <body>
    <jsp:include page="../components/features/authentication/header.jsp" />
    
    <!-- Success Message -->
    <c:if test="${not empty signup_success}">
      <div class="fixed top-4 right-4 z-50 success-message">
        <div class="bg-green-500 text-white px-6 py-3 rounded-lg shadow-lg flex items-center gap-2">
          <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
            <path d="M20 6 9 17l-5-5"/>
          </svg>
          <span>${signup_success}</span>
        </div>
      </div>
    </c:if>
    
    <div class="w-full min-h-screen flex justify-center items-center p-4 bg-muted">
        <div class="w-full max-w-md">
            <!-- Error Messages -->
            <c:if test="${not empty signup_errors}">
                <div class="mb-6 error-message">
                    <c:forEach var="error" items="${signup_errors}">
                        <div class="bg-destructive text-destructive-foreground px-4 py-3 rounded-lg mb-2 flex items-center gap-2">
                            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                <circle cx="12" cy="12" r="10"/>
                                <line x1="15" y1="9" x2="9" y2="15"/>
                                <line x1="9" y1="9" x2="15" y2="15"/>
                            </svg>
                            <span class="text-sm">${error.value}</span>
                        </div>
                    </c:forEach>
                </div>
            </c:if>
            
            <form class="p-6 bg-card rounded-lg flex flex-col gap-4 shadow-lg" method="post" action="signup" id="signupForm">
                <div class="text-center mb-2">
                    <h1 class="text-2xl font-bold text-foreground">Đăng Ký</h1>
                    <p class="text-sm text-muted-foreground mt-1">Tạo tài khoản mới để bắt đầu</p>
                </div>

                <!-- Email Field -->
                <div class="flex flex-col gap-2">
                    <label for="email" class="text-sm font-medium text-foreground">
                        Email <span class="text-destructive">*</span>
                    </label>
                    <input
                        name="email"
                        id="email"
                        type="email"
                        placeholder="Nhập email của bạn...."
                        value="${signup_data.email}"
                        class="w-full h-10 px-3 py-2 text-sm bg-background border border-input rounded-md placeholder:text-muted-foreground focus:outline-none focus:ring-2 focus:ring-ring focus:border-transparent transition-all ${not empty signup_errors.email ? 'input-error' : ''}"
                        required
                    />
                    <c:if test="${not empty signup_errors.email}">
                        <span class="text-xs text-destructive error-message">${signup_errors.email}</span>
                    </c:if>
                </div>
                
                <!-- Password Field -->
                <div class="flex flex-col gap-2">
                    <label for="password" class="text-sm font-medium text-foreground">
                        Mật khẩu <span class="text-destructive">*</span>
                    </label>
                    <div class="relative">
                        <input
                            name="password"
                            id="password"
                            type="password"
                            placeholder="Nhập mật khẩu của bạn...."
                            class="w-full h-10 px-3 py-2 text-sm bg-background border border-input rounded-md placeholder:text-muted-foreground focus:outline-none focus:ring-2 focus:ring-ring focus:border-transparent transition-all ${not empty signup_errors.password ? 'input-error' : ''}"
                            required
                        />
                        <button
                            type="button"
                            id="togglePassword"
                            class="absolute right-3 top-1/2 transform -translate-y-1/2 text-muted-foreground hover:text-foreground transition-colors"
                        >
                            <svg id="eyeIcon" xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                <path d="M2 12s3-7 10-7 10 7 10 7-3 7-10 7-10-7-10-7Z"/>
                                <circle cx="12" cy="12" r="3"/>
                            </svg>
                        </button>
                    </div>
                    <c:if test="${not empty signup_errors.password}">
                        <span class="text-xs text-destructive error-message">${signup_errors.password}</span>
                    </c:if>
                    <div class="text-xs text-muted-foreground">
                        Mật khẩu phải có ít nhất 6 ký tự, bao gồm chữ hoa, chữ thường và số
                    </div>
                </div>

                <!-- Confirm Password Field -->
                <div class="flex flex-col gap-2">
                    <label for="confirmPassword" class="text-sm font-medium text-foreground">
                        Xác nhận mật khẩu <span class="text-destructive">*</span>
                    </label>
                    <div class="relative">
                        <input
                            name="confirmPassword"
                            id="confirmPassword"
                            type="password"
                            placeholder="Nhập lại mật khẩu...."
                            class="w-full h-10 px-3 py-2 text-sm bg-background border border-input rounded-md placeholder:text-muted-foreground focus:outline-none focus:ring-2 focus:ring-ring focus:border-transparent transition-all ${not empty signup_errors.confirmPassword ? 'input-error' : ''}"
                            required
                        />
                        <button
                            type="button"
                            id="toggleConfirmPassword"
                            class="absolute right-3 top-1/2 transform -translate-y-1/2 text-muted-foreground hover:text-foreground transition-colors"
                        >
                            <svg id="eyeConfirmIcon" xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                <path d="M2 12s3-7 10-7 10 7 10 7-3 7-10 7-10-7-10-7Z"/>
                                <circle cx="12" cy="12" r="3"/>
                            </svg>
                        </button>
                    </div>
                    <c:if test="${not empty signup_errors.confirmPassword}">
                        <span class="text-xs text-destructive error-message">${signup_errors.confirmPassword}</span>
                    </c:if>
                </div>

                <!-- Full Name Field -->
                <div class="flex flex-col gap-2">
                    <label for="fullName" class="text-sm font-medium text-foreground">
                        Họ và tên <span class="text-destructive">*</span>
                    </label>
                    <input
                        name="fullName"
                        id="fullName"
                        type="text"
                        placeholder="Nhập tên đầy đủ của bạn...."
                        value="${signup_data.fullName}"
                        class="w-full h-10 px-3 py-2 text-sm bg-background border border-input rounded-md placeholder:text-muted-foreground focus:outline-none focus:ring-2 focus:ring-ring focus:border-transparent transition-all ${not empty signup_errors.fullName ? 'input-error' : ''}"
                        required
                    />
                    <c:if test="${not empty signup_errors.fullName}">
                        <span class="text-xs text-destructive error-message">${signup_errors.fullName}</span>
                    </c:if>
                </div>

                <!-- Phone & Address Fields -->
                <div class="flex gap-4">
                    <div class="flex flex-col gap-2 flex-1">
                        <label for="phoneNumber" class="text-sm font-medium text-foreground">
                            Số điện thoại <span class="text-destructive">*</span>
                        </label>
                        <input
                            name="phoneNumber"
                            id="phoneNumber"
                            type="text"
                            placeholder="0123456789"
                            value="${signup_data.phoneNumber}"
                            class="w-full h-10 px-3 py-2 text-sm bg-background border border-input rounded-md placeholder:text-muted-foreground focus:outline-none focus:ring-2 focus:ring-ring focus:border-transparent transition-all ${not empty signup_errors.phoneNumber ? 'input-error' : ''}"
                            required
                        />
                        <c:if test="${not empty signup_errors.phoneNumber}">
                            <span class="text-xs text-destructive error-message">${signup_errors.phoneNumber}</span>
                        </c:if>
                    </div>

                    <div class="flex flex-col gap-2 flex-1">
                        <label for="address" class="text-sm font-medium text-foreground">
                            Địa chỉ <span class="text-destructive">*</span>
                        </label>
                        <input
                            name="address"
                            id="address"
                            type="text"
                            placeholder="Nhập địa chỉ của bạn...."
                            value="${signup_data.address}"
                            class="w-full h-10 px-3 py-2 text-sm bg-background border border-input rounded-md placeholder:text-muted-foreground focus:outline-none focus:ring-2 focus:ring-ring focus:border-transparent transition-all ${not empty signup_errors.address ? 'input-error' : ''}"
                            required
                        />
                        <c:if test="${not empty signup_errors.address}">
                            <span class="text-xs text-destructive error-message">${signup_errors.address}</span>
                        </c:if>
                    </div>
                </div>

                <!-- Profile Picture Upload -->
                <div class="flex flex-col gap-2">
                    <label class="text-sm font-medium text-foreground">
                        Ảnh đại diện <span class="text-muted-foreground">(Tùy chọn)</span>
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
                            <svg xmlns="http://www.w3.org/2000/svg" width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="4" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-x-icon lucide-x"><path d="M18 6 6 18"/><path d="m6 6 12 12"/></svg>
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
                </div>

                <!-- Submit Button -->
                <button
                    type="submit"
                    id="submitBtn"
                    class="mt-4 px-4 py-3 bg-primary text-primary-foreground rounded-md font-medium hover:bg-primary/90 focus:outline-none focus:ring-2 focus:ring-ring transition-all disabled:opacity-50 disabled:cursor-not-allowed"
                >
                    <span id="submitText">Đăng ký</span>
                    <span id="loadingText" class="hidden">Đang xử lý...</span>
                </button>
                
                <!-- Login Link -->
                <div class="text-center mt-4">
                    <p class="text-sm text-muted-foreground">
                        Đã có tài khoản? 
                        <a href="signin" class="text-primary hover:underline font-medium">Đăng nhập</a>
                    </p>
                </div>
            </form>
        </div>
    </div>

    <script>
      document.addEventListener("DOMContentLoaded", function () {
        const fileInput = document.getElementById("pictureProfile");
        const uploadLabel = document.getElementById("uploadLabel");
        const imagePreviewContainer = document.getElementById("imagePreviewContainer");
        const imagePreview = document.getElementById("imagePreview");
        const removeImageBtn = document.getElementById("removeImageBtn");
        const pictureProfileBase64Input = document.getElementById("pictureProfileBase64");
        const togglePassword = document.getElementById("togglePassword");
        const toggleConfirmPassword = document.getElementById("toggleConfirmPassword");
        const passwordInput = document.getElementById("password");
        const confirmPasswordInput = document.getElementById("confirmPassword");
        const submitBtn = document.getElementById("submitBtn");
        const submitText = document.getElementById("submitText");
        const loadingText = document.getElementById("loadingText");
        const form = document.getElementById("signupForm");

        // Toggle password visibility
        togglePassword.addEventListener("click", function() {
          const type = passwordInput.type === "password" ? "text" : "password";
          passwordInput.type = type;
          
          const eyeIcon = document.getElementById("eyeIcon");
          if (type === "text") {
            eyeIcon.innerHTML = '<path d="M9.88 9.88a3 3 0 1 0 4.24 4.24"/><path d="M10.73 5.08A10.43 10.43 0 0 1 12 5c7 0 10 7 10 7a13.16 13.16 0 0 1-1.67 2.68"/><path d="M6.61 6.61A13.526 13.526 0 0 0 2 12s3 7 10 7a9.74 9.74 0 0 0 5.39-1.61"/><line x1="2" y1="2" x2="22" y2="22"/>';
          } else {
            eyeIcon.innerHTML = '<path d="M2 12s3-7 10-7 10 7 10 7-3 7-10 7-10-7-10-7Z"/><circle cx="12" cy="12" r="3"/>';
          }
        });

        toggleConfirmPassword.addEventListener("click", function() {
          const type = confirmPasswordInput.type === "password" ? "text" : "password";
          confirmPasswordInput.type = type;
          
          const eyeConfirmIcon = document.getElementById("eyeConfirmIcon");
          if (type === "text") {
            eyeConfirmIcon.innerHTML = '<path d="M9.88 9.88a3 3 0 1 0 4.24 4.24"/><path d="M10.73 5.08A10.43 10.43 0 0 1 12 5c7 0 10 7 10 7a13.16 13.16 0 0 1-1.67 2.68"/><path d="M6.61 6.61A13.526 13.526 0 0 0 2 12s3 7 10 7a9.74 9.74 0 0 0 5.39-1.61"/><line x1="2" y1="2" x2="22" y2="22"/>';
          } else {
            eyeConfirmIcon.innerHTML = '<path d="M2 12s3-7 10-7 10 7 10 7-3 7-10 7-10-7-10-7Z"/><circle cx="12" cy="12" r="3"/>';
          }
        });

        // Form validation
        form.addEventListener("submit", function(e) {
          let isValid = true;
          
          // Clear previous errors
          document.querySelectorAll('.input-error').forEach(input => {
            input.classList.remove('input-error');
          });
          document.querySelectorAll('.error-message').forEach(error => {
            if (error.tagName === 'SPAN') {
              error.remove();
            }
          });

          // Validate email
          const email = document.getElementById("email").value.trim();
          if (!email) {
            showFieldError("email", "Email không được để trống");
            isValid = false;
          } else if (!isValidEmail(email)) {
            showFieldError("email", "Email không đúng định dạng");
            isValid = false;
          }

          // Validate password
          const password = passwordInput.value;
          if (!password) {
            showFieldError("password", "Mật khẩu không được để trống");
            isValid = false;
          } else if (password.length < 6) {
            showFieldError("password", "Mật khẩu phải có ít nhất 6 ký tự");
            isValid = false;
          } else if (!isValidPassword(password)) {
            showFieldError("password", "Mật khẩu phải chứa ít nhất 1 chữ hoa, 1 chữ thường và 1 số");
            isValid = false;
          }

          // Validate confirm password
          const confirmPassword = confirmPasswordInput.value;
          if (!confirmPassword) {
            showFieldError("confirmPassword", "Xác nhận mật khẩu không được để trống");
            isValid = false;
          } else if (password !== confirmPassword) {
            showFieldError("confirmPassword", "Mật khẩu xác nhận không khớp");
            isValid = false;
          }

          // Validate full name
          const fullName = document.getElementById("fullName").value.trim();
          if (!fullName) {
            showFieldError("fullName", "Họ và tên không được để trống");
            isValid = false;
          } else if (fullName.length < 2) {
            showFieldError("fullName", "Họ và tên phải có ít nhất 2 ký tự");
            isValid = false;
          }

          // Validate phone number
          const phoneNumber = document.getElementById("phoneNumber").value.trim();
          if (!phoneNumber) {
            showFieldError("phoneNumber", "Số điện thoại không được để trống");
            isValid = false;
          } else if (!isValidPhoneNumber(phoneNumber)) {
            showFieldError("phoneNumber", "Số điện thoại không đúng định dạng");
            isValid = false;
          }

          // Validate address
          const address = document.getElementById("address").value.trim();
          if (!address) {
            showFieldError("address", "Địa chỉ không được để trống");
            isValid = false;
          } else if (address.length < 5) {
            showFieldError("address", "Địa chỉ phải có ít nhất 5 ký tự");
            isValid = false;
          }

          if (!isValid) {
            e.preventDefault();
            return false;
          }

          // Show loading state
          submitBtn.disabled = true;
          submitText.classList.add("hidden");
          loadingText.classList.remove("hidden");
        });

        function showFieldError(fieldId, message) {
          const field = document.getElementById(fieldId);
          field.classList.add("input-error");
          
          const errorSpan = document.createElement("span");
          errorSpan.className = "text-xs text-destructive error-message";
          errorSpan.textContent = message;
          field.parentNode.appendChild(errorSpan);
        }

        function isValidEmail(email) {
          const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
          return emailRegex.test(email);
        }

        function isValidPassword(password) {
          const hasUpper = /[A-Z]/.test(password);
          const hasLower = /[a-z]/.test(password);
          const hasNumber = /\d/.test(password);
          return hasUpper && hasLower && hasNumber;
        }

        function isValidPhoneNumber(phone) {
          const phoneRegex = /^0[0-9]{9,10}$/;
          return phoneRegex.test(phone);
        }

        // Lắng nghe sự kiện thay đổi file
        fileInput.addEventListener("change", function (event) {
          const file = event.target.files[0];

          if (file) {
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

            // Kiểm tra kích thước file (ví dụ: tối đa 5MB)
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
            };

            reader.onerror = function () {
              alert("Có lỗi xảy ra khi đọc file ảnh");
            };

            // Đọc file dưới dạng data URL
            reader.readAsDataURL(file);
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

        // Auto-hide success message after 5 seconds
        const successMessage = document.querySelector('.success-message');
        if (successMessage) {
          setTimeout(() => {
            successMessage.style.opacity = '0';
            setTimeout(() => {
              successMessage.remove();
            }, 300);
          }, 5000);
        }
      });
    </script>
  </body>
</html>
