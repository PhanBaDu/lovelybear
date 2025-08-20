package data.controllers;

import data.dao.OrderDao;
import data.dao.OrderItemDao;
import data.dao.ProductDao;
import data.implementations.OrderImplementation;
import data.implementations.OrderItemImplementation;
import data.implementations.ProductImplementation;
import data.models.Order;
import data.models.OrderItem;
import data.models.Product;
import data.models.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.math.BigDecimal;

@WebServlet("/buy-now")
public class BuyNowServlet extends HttpServlet {
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        response.setContentType("application/json;charset=UTF-8");
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        try (PrintWriter out = response.getWriter()) {
            // Kiểm tra đăng nhập
            if (user == null) {
                String redirect = request.getContextPath() + "/views/signin.jsp";
                out.write("{\"success\":false,\"requiresLogin\":true,\"redirect\":\"" + redirect + "\"}");
                return;
            }
            
            // Lấy thông tin sản phẩm từ request
            String productIdStr = request.getParameter("productId");
            String quantityStr = request.getParameter("quantity");
            
            if (productIdStr == null || quantityStr == null) {
                out.write("{\"success\":false,\"message\":\"Thiếu thông tin sản phẩm hoặc số lượng\"}");
                return;
            }
            
            int productId = Integer.parseInt(productIdStr);
            int quantity = Integer.parseInt(quantityStr);
            
            if (quantity <= 0) {
                quantity = 1;
            }
            
            // Lấy thông tin sản phẩm
            ProductDao productDao = new ProductImplementation();
            Product product = productDao.getProductById(productId);
            
            if (product == null) {
                out.write("{\"success\":false,\"message\":\"Sản phẩm không tồn tại\"}");
                return;
            }
            
            // Tính tổng tiền
            BigDecimal totalAmount = product.getPrice().multiply(new BigDecimal(quantity));
            
            // Tạo đơn hàng
            Order order = new Order(user.getEmail(), quantity, totalAmount);
            OrderDao orderDao = new OrderImplementation();
            
            int orderId = orderDao.createOrder(order);
            
            if (orderId > 0) {
                // Tạo order item
                OrderItemDao orderItemDao = new OrderItemImplementation();
                OrderItem orderItem = new OrderItem(
                    orderId,
                    product.getId(),
                    product.getName(),
                    product.getPrice(),
                    quantity
                );
                orderItemDao.addOrderItem(orderItem);
                
                // Cập nhật session
                session.setAttribute("orderSuccess", true);
                session.setAttribute("orderId", orderId);
                
                String redirect = request.getContextPath() + "/views/order-success.jsp";
                out.write("{\"success\":true,\"orderId\":" + orderId + ",\"redirect\":\"" + redirect + "\"}");
                
            } else {
                out.write("{\"success\":false,\"message\":\"Không thể tạo đơn hàng. Vui lòng thử lại!\"}");
            }
            
        } catch (NumberFormatException e) {
            try (PrintWriter out = response.getWriter()) {
                out.write("{\"success\":false,\"message\":\"Dữ liệu không hợp lệ\"}");
            }
        } catch (Exception e) {
            System.err.println("Error buying now: " + e.getMessage());
            try (PrintWriter out = response.getWriter()) {
                out.write("{\"success\":false,\"message\":\"Có lỗi xảy ra. Vui lòng thử lại!\"}");
            }
        }
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Redirect về POST nếu gọi GET
        doPost(request, response);
    }
}
