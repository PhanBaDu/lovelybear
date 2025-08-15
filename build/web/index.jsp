<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="icon" type="image/x-icon" href="logo-title.ico">
        <title>Trang Chủ</title>
        <link rel="stylesheet" href="./public/assets/styles/globals.css">
        <script src="https://cdn.jsdelivr.net/npm/@tailwindcss/browser@4"></script>
    </head>
    <body> 
        <div class="flex flex-col min-h-screen justify-between">
            <jsp:include page="./components/header.jsp" />
            <div class="pt-24 px-5 w-full pb-32">
                <jsp:include page="./components/products.jsp" />
            </div>
            <jsp:include page="./components/footer.jsp" />
        </div>
    </body>
</html>
