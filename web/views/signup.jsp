<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <link rel="icon" type="image/x-icon" href="logo-title.ico" />
    <title>Đăng Ký</title>
    <link rel="stylesheet" href="./public/assets/styles/globals.css" />
    <script src="https://cdn.jsdelivr.net/npm/@tailwindcss/browser@4"></script>
  </head>
  <body>
    <jsp:include page="../components/features/authentication/header.jsp" />
    <div class="w-full min-h-screen bg-muted flex justify-center items-center">
      <form
        method="post"
        action="signup"
        class="p-4 bg-card rounded-lg flex flex-col gap-4"
      >
        <h1 class="text-lg font-semibold text-center underline">Đăng Ký</h1>

        <label
          for="email"
          class="flex items-center gap-2 text-sm leading-none font-medium select-none group-data-[disabled=true]:pointer-events-none group-data-[disabled=true]:opacity-50 peer-disabled:cursor-not-allowed peer-disabled:opacity-50"
        >
          Email
        </label>
        <input
          name="email"
          id="email"
          style="width: 400px"
          type="email"
          placeholder="Nhập email của bạn...."
          class="file:text-foreground placeholder:text-muted-foreground selection:bg-primary selection:text-primary-foreground dark:bg-input/30 border-input flex h-9 w-full min-w-0 rounded-md border bg-transparent px-3 py-1 text-base shadow-xs transition-[color,box-shadow] outline-none file:inline-flex file:h-7 file:border-0 file:bg-transparent file:text-sm file:font-medium disabled:pointer-events-none disabled:cursor-not-allowed disabled:opacity-50 md:text-sm rounded-[5.6px]"
        />

        <label
          for="address"
          class="flex items-center gap-2 text-sm leading-none font-medium select-none group-data-[disabled=true]:pointer-events-none group-data-[disabled=true]:opacity-50 peer-disabled:cursor-not-allowed peer-disabled:opacity-50"
        >
          Địa chỉ
        </label>
        <input
          name="address"
          id="address"
          style="width: 400px"
          type="text"
          placeholder="Nhập địa chỉ của bạn...."
          class="file:text-foreground placeholder:text-muted-foreground selection:bg-primary selection:text-primary-foreground dark:bg-input/30 border-input flex h-9 w-full min-w-0 rounded-md border bg-transparent px-3 py-1 text-base shadow-xs transition-[color,box-shadow] outline-none file:inline-flex file:h-7 file:border-0 file:bg-transparent file:text-sm file:font-medium disabled:pointer-events-none disabled:cursor-not-allowed disabled:opacity-50 md:text-sm rounded-[5.6px]"
        />

        <div class="flex gap-4 justify-end">
          <div class="flex flex-col gap-4">
            <label
              for="phoneNumber"
              class="flex items-center gap-2 text-sm leading-none font-medium select-none group-data-[disabled=true]:pointer-events-none group-data-[disabled=true]:opacity-50 peer-disabled:cursor-not-allowed peer-disabled:opacity-50"
            >
              Số điện thoại
            </label>
            <input
              name="phoneNumber"
              id="phoneNumber"
              style="width: 200px"
              type="text"
              placeholder="Nhập số điện thoại của bạn...."
              class="file:text-foreground placeholder:text-muted-foreground selection:bg-primary selection:text-primary-foreground dark:bg-input/30 border-input flex h-9 w-full min-w-0 rounded-md border bg-transparent px-3 py-1 text-base shadow-xs transition-[color,box-shadow] outline-none file:inline-flex file:h-7 file:border-0 file:bg-transparent file:text-sm file:font-medium disabled:pointer-events-none disabled:cursor-not-allowed disabled:opacity-50 md:text-sm rounded-[5.6px]"
            />

            <label
              for="fullName"
              class="flex items-center gap-2 text-sm leading-none font-medium select-none group-data-[disabled=true]:pointer-events-none group-data-[disabled=true]:opacity-50 peer-disabled:cursor-not-allowed peer-disabled:opacity-50"
            >
              Họ và tên
            </label>
            <input
              name="fullName"
              id="fullName"
              style="width: 200px"
              type="text"
              placeholder="Nhập tên đầy đủ của bạn...."
              class="file:text-foreground placeholder:text-muted-foreground selection:bg-primary selection:text-primary-foreground dark:bg-input/30 border-input flex h-9 w-full min-w-0 rounded-md border bg-transparent px-3 py-1 text-base shadow-xs transition-[color,box-shadow] outline-none file:inline-flex file:h-7 file:border-0 file:bg-transparent file:text-sm file:font-medium disabled:pointer-events-none disabled:cursor-not-allowed disabled:opacity-50 md:text-sm rounded-[5.6px]"
            />
          </div>
          <div class="flex justify-end w-full">
            <!-- Khu vực preview ảnh -->
            <div id="imagePreviewContainer" class="hidden">
              <img
                id="imagePreview"
                src=""
                alt="Preview"
                class="w-48 h-[100px] object-cover rounded-md border border-input"
              />
              <button
                type="button"
                id="removeImageBtn"
                class="w-full mt-4 px-4 h-6 py-2 has-[>svg]:px-3 cursor-pointer bg-destructive text-primary-foreground shadow-xs hover:bg-primary/90 inline-flex items-center justify-center gap-2 whitespace-nowrap rounded-md text-xs font-medium transition-all disabled:pointer-events-none disabled:opacity-50 [&_svg]:pointer-events-none [&_svg:not([class*='size-'])]:size-4 shrink-0 [&_svg]:shrink-0 outline-none focus-visible:border-ring focus-visible:ring-ring/50 focus-visible:ring-[3px] aria-invalid:ring-destructive/20 dark:aria-invalid:ring-destructive/40 aria-invalid:border-destructive"
              >
                Xóa ảnh
              </button>
            </div>

            <!-- Label upload ảnh -->
            <label
              for="pictureProfile"
              id="uploadLabel"
              class="w-48 h-full flex flex-col justify-center gap-2 items-center text-sm font-medium p-4 text-center rounded-lg border border-input cursor-pointer"
              style="border-style: dashed"
            >
              <svg
                xmlns="http://www.w3.org/2000/svg"
                width="24"
                height="24"
                viewBox="0 0 24 24"
                fill="none"
                stroke="currentColor"
                stroke-width="2"
                stroke-linecap="round"
                stroke-linejoin="round"
                class="lucide lucide-image-up-icon lucide-image-up"
              >
                <path
                  d="M10.3 21H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h14a2 2 0 0 1 2 2v10l-3.1-3.1a2 2 0 0 0-2.814.014L6 21"
                />
                <path d="m14 19.5 3-3 3 3" />
                <path d="M17 22v-5.5" />
                <circle cx="9" cy="9" r="2" />
              </svg>
              <p>Chọn ảnh đại diện</p>
            </label>

            <input
              name="pictureProfile"
              hidden
              id="pictureProfile"
              type="file"
              accept=".jpg,.jpeg,.png,.gif,.webp"
              class="file:text-foreground placeholder:text-muted-foreground selection:bg-primary selection:text-primary-foreground dark:bg-input/30 border-input flex h-9 w-full min-w-0 rounded-xs border bg-transparent px-3 py-1 text-base shadow-xs transition-[color,box-shadow] outline-none file:inline-flex file:h-7 file:border-0 file:bg-transparent file:text-sm file:font-medium disabled:pointer-events-none disabled:cursor-not-allowed disabled:opacity-50 md:text-sm rounded-xs"
              style="border-radius: 5px"
            />
            <input
              type="hidden"
              name="pictureProfileBase64"
              id="pictureProfileBase64"
            />
          </div>
        </div>

        <button
          type="submit"
          class="mt-4 px-4 py-2 has-[>svg]:px-3 cursor-pointer bg-primary text-primary-foreground shadow-xs hover:bg-primary/90 inline-flex items-center justify-center gap-2 whitespace-nowrap rounded-md text-sm font-medium transition-all disabled:pointer-events-none disabled:opacity-50 [&_svg]:pointer-events-none [&_svg:not([class*='size-'])]:size-4 shrink-0 [&_svg]:shrink-0 outline-none focus-visible:border-ring focus-visible:ring-ring/50 focus-visible:ring-[3px] aria-invalid:ring-destructive/20 dark:aria-invalid:ring-destructive/40 aria-invalid:border-destructive"
        >
          Đăng ký
        </button>
      </form>
    </div>

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
      });
    </script>
  </body>
</html>
