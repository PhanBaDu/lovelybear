<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    // Kiểm tra xem người dùng đã đăng nhập chưa
    // Giả sử bạn lưu thông tin user trong session với key "user" hoặc "userId"
    Object user = session.getAttribute("user"); // hoặc "userId", "currentUser" tùy theo cách bạn implement
    
    // Nếu đã đăng nhập, chuyển hướng về trang chủ hoặc dashboard
    if (user != null) {
        response.sendRedirect(request.getContextPath() + "/"); // hoặc "home", "index" tùy theo trang chính của bạn
        return;
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="icon" type="image/x-icon" href="logo-title.ico">
        <title>Đăng Nhập</title>
        <link rel="stylesheet" href="./public/assets/styles/globals.css">
        <script src="https://cdn.jsdelivr.net/npm/@tailwindcss/browser@4"></script>
    </head>
    <body>
        <jsp:include page="../components/features/authentication/header.jsp" />
        <div class="w-full min-h-screen flex justify-center items-center p-4 bg-muted">
            <form class="p-6 bg-card rounded-lg flex flex-col gap-4 w-[400px]" method="post" action="signin">
                <h1 class="text-lg font-semibold text-center text-foreground">Đăng Nhập</h1>
                
                <!-- Error Message -->
                <% if (request.getAttribute("errorMessage") != null) { %>
                    <div class="p-3 bg-destructive/10 border border-destructive/20 rounded-md text-destructive text-sm">
                        <%= request.getAttribute("errorMessage") %>
                    </div>
                <% } %>
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
                        value="<%= request.getAttribute("email") != null ? request.getAttribute("email") : "" %>"
                        class="w-full h-9 px-3 py-1 text-sm bg-background border border-input rounded-md placeholder:text-muted-foreground focus:outline-none focus:ring-2 focus:ring-ring focus:border-transparent transition-all"
                        required
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
                        value="<%= request.getAttribute("password") != null ? request.getAttribute("password") : "" %>"
                        placeholder="Nhập mật khẩu của bạn...."
                        class="w-full h-9 px-3 py-1 text-sm bg-background border border-input rounded-md placeholder:text-muted-foreground focus:outline-none focus:ring-2 focus:ring-ring focus:border-transparent transition-all"
                        required
                    />
                </div>
                <!-- Submit Button -->
                <button
                    type="submit"
                    class="mt-4 px-4 py-2 bg-primary text-primary-foreground rounded-md font-medium hover:bg-primary/90 focus:outline-none focus:ring-2 focus:ring-ring transition-all"
                >
                    Đăng nhập
                </button>
                <!-- Sign Up Link -->
                <div class="text-center text-sm">
                    <span class="text-muted-foreground">Chưa có tài khoản? </span>
                    <a href="signup" class="text-primary font-medium hover:underline">
                        Đăng ký ngay
                    </a>
                </div>
            </form>
        </div>
    </body>
</html>