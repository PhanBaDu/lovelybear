<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="data.dao.CartDao" %>
<%@ page import="data.dao.ProductDao" %>
<%@ page import="data.implementations.CartImplementation" %>
<%@ page import="data.driver.DatabaseConnectionManager" %>
<%@ page import="data.models.Cart" %>
<%@ page import="data.models.CartItem" %>
<%@ page import="data.models.Product" %>
<%@ page import="data.models.User" %>
<%@ page import="data.dao.Database" %>

<%
// Kiểm tra đăng nhập
User user = (User) session.getAttribute("user");
if (user == null) {
    response.sendRedirect("signin.jsp?message=Please login to add items to cart");
    return;
}

// Lấy thông tin sản phẩm từ request
String productIdStr = request.getParameter("productId");
String quantityStr = request.getParameter("quantity");

if (productIdStr == null || quantityStr == null) {
    response.sendRedirect("index.jsp?error=Invalid request parameters");
    return;
}

try {
    int productId = Integer.parseInt(productIdStr);
    int quantity = Integer.parseInt(quantityStr);
    
    if (quantity <= 0) {
        quantity = 1; // Mặc định số lượng là 1
    }
    
    // Lấy thông tin sản phẩm từ database
    ProductDao productDao = Database.getProductDao();
    Product product = productDao.getProductById(productId);
    
    if (product == null) {
        response.sendRedirect("index.jsp?error=Product not found");
        return;
    }
    
    // Xử lý giỏ hàng
    CartDao cartDao = new CartImplementation();
    
    // Lấy hoặc tạo giỏ hàng cho người dùng
    Cart cart = cartDao.getCartByUserEmail(user.getEmail());
    if (cart == null) {
        cart = cartDao.createCart(user.getEmail());
        if (cart == null) {
            response.sendRedirect("index.jsp?error=Failed to create cart");
            return;
        }
    }
    
    // Tạo cart item
    CartItem cartItem = new CartItem(
        cart.getId(),
        product.getId(),
        product.getName(),
        product.getDescription(),
        product.getPrice(),
        quantity
    );
    
    // Thêm vào giỏ hàng
    boolean success = cartDao.addItemToCart(cartItem);
    
    if (success) {
        // Cập nhật số lượng sản phẩm trong giỏ hàng vào session
        int cartItemCount = cartDao.getCartItemCount(cart.getId());
        session.setAttribute("cartItemCount", cartItemCount);
        
        // Redirect về trang chủ (không có message)
        response.sendRedirect("index.jsp");
    } else {
        response.sendRedirect("index.jsp?error=Failed to add product to cart");
    }
    
} catch (NumberFormatException e) {
    response.sendRedirect("index.jsp?error=Invalid product ID or quantity");
} catch (Exception e) {
    System.err.println("Error in add-to-cart.jsp: " + e.getMessage());
    response.sendRedirect("index.jsp?error=Internal server error");
}
%>
