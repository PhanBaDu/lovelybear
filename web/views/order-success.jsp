<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Đặt Hàng Thành Công</title>
    <link
      rel="icon"
      type="image/x-icon"
      href="${pageContext.request.contextPath}/icon-title.ico"
    />
    <link rel="stylesheet" href="../public/assets/styles/globals.css" />
    <script src="https://cdn.jsdelivr.net/npm/@tailwindcss/browser@4"></script>
  </head>
  <body class="bg-white">
    <div class="min-h-screen flex items-center justify-center">
      <div class="max-w-md w-full bg-white rounded-lg p-8 text-center">
        <div class="mb-6">
          <div
            class="w-16 h-16 bg-green-100 rounded-full flex items-center justify-center mx-auto mb-4"
          >
            <svg
              class="text-green-600"
              xmlns="http://www.w3.org/2000/svg"
              width="24"
              height="24"
              viewBox="0 0 24 24"
              fill="none"
              stroke="currentColor"
              stroke-width="2"
              stroke-linecap="round"
              stroke-linejoin="round"
              class="lucide lucide-check-check-icon lucide-check-check"
            >
              <path d="M18 6 7 17l-5-5" />
              <path d="m22 10-7.5 7.5L13 16" />
            </svg>
          </div>
          <h1 class="text-2xl font-bold text-gray-900 mb-2">
            Đặt Hàng Thành Công!
          </h1>
          <p class="text-gray-600">
            Cảm ơn bạn đã đặt hàng. Chúng tôi sẽ xử lý đơn hàng của bạn sớm
            nhất.
          </p>
        </div>

        <div class="bg-white border border-gray-200 rounded-lg p-4 mb-6">
          <p class="text-sm text-gray-600">Mã đơn hàng:</p>
          <p class="text-lg font-semibold text-gray-900">
            #${sessionScope.orderId}
          </p>
        </div>

        <div class="space-y-3">
          <a
            href="${pageContext.request.contextPath}/"
            class="block w-full text-sm bg-primary text-white py-3 px-6 rounded-lg font-medium transition-colors"
          >
            Tiếp Tục Mua Sắm
          </a>
          <a
            href="${pageContext.request.contextPath}/cart"
            class="block w-full bg-gray-200 text-sm text-gray-800 py-3 px-6 rounded-lg font-medium transition-colors"
          >
            Xem Giỏ Hàng
          </a>
        </div>
      </div>
    </div>
  </body>
</html>
