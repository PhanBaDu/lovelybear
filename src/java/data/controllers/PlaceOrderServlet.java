package data.controllers;

import data.dao.CartDao;
import data.dao.OrderDao;
import data.dao.OrderItemDao;
import data.implementations.CartImplementation;
import data.implementations.OrderImplementation;
import data.implementations.OrderItemImplementation;
import data.models.Cart;
import data.models.CartItem;
import data.models.Order;
import data.models.OrderItem;
import data.models.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;
import java.util.ArrayList;

@WebServlet("/place-order")
public class PlaceOrderServlet extends HttpServlet {
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        // Kiểm tra đăng nhập
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/views/signin.jsp");
            return;
        }
        
        try {
            // Lấy danh sách item IDs được chọn từ request
            String[] selectedItemIds = request.getParameterValues("selectedItems");
            
            if (selectedItemIds == null || selectedItemIds.length == 0) {
                response.sendRedirect(request.getContextPath() + "/cart");
                return;
            }
            
            // Lấy thông tin giỏ hàng
            CartDao cartDao = new CartImplementation();
            Cart cart = cartDao.getCartByUserEmail(user.getEmail());
            
            if (cart == null) {
                response.sendRedirect(request.getContextPath() + "/cart");
                return;
            }
            
            // Lấy chỉ những item được chọn
            List<CartItem> selectedCartItems = new ArrayList<>();
            int totalQuantity = 0;
            BigDecimal totalAmount = BigDecimal.ZERO;
            
            for (String itemIdStr : selectedItemIds) {
                try {
                    int itemId = Integer.parseInt(itemIdStr);
                    CartItem cartItem = cartDao.getCartItemById(itemId);
                    
                    // Kiểm tra item có thuộc về user này không
                    if (cartItem != null && cartItem.getCartId() == cart.getId()) {
                        selectedCartItems.add(cartItem);
                        totalQuantity += cartItem.getQuantity();
                        totalAmount = totalAmount.add(cartItem.getPrice().multiply(new BigDecimal(cartItem.getQuantity())));
                    }
                } catch (NumberFormatException e) {
                    System.err.println("Invalid item ID: " + itemIdStr);
                }
            }
            
            if (selectedCartItems.isEmpty()) {
                response.sendRedirect(request.getContextPath() + "/cart");
                return;
            }
            
            // Tạo đơn hàng
            Order order = new Order(user.getEmail(), totalQuantity, totalAmount);
            OrderDao orderDao = new OrderImplementation();
            
            int orderId = orderDao.createOrder(order);
            
            if (orderId > 0) {
                // Tạo order items
                OrderItemDao orderItemDao = new OrderItemImplementation();
                
                for (CartItem cartItem : selectedCartItems) {
                    OrderItem orderItem = new OrderItem(
                        orderId,
                        cartItem.getProductId(),
                        cartItem.getProductName(),
                        cartItem.getPrice(),
                        cartItem.getQuantity()
                    );
                    orderItemDao.addOrderItem(orderItem);
                }
                
                // Chỉ xóa những item đã được đặt hàng
                for (CartItem cartItem : selectedCartItems) {
                    cartDao.removeItemFromCart(cartItem.getId());
                }
                
                // Cập nhật session
                session.setAttribute("orderSuccess", true);
                session.setAttribute("orderId", orderId);
                
                // Redirect đến trang thành công
                response.sendRedirect(request.getContextPath() + "/views/order-success.jsp");
                
            } else {
                // Lỗi tạo đơn hàng
                request.setAttribute("error", "Không thể tạo đơn hàng. Vui lòng thử lại!");
                request.getRequestDispatcher("/views/checkout.jsp").forward(request, response);
            }
            
        } catch (Exception e) {
            System.err.println("Error placing order: " + e.getMessage());
            request.setAttribute("error", "Có lỗi xảy ra. Vui lòng thử lại!");
            request.getRequestDispatcher("/views/checkout.jsp").forward(request, response);
        }
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Redirect về POST nếu gọi GET
        doPost(request, response);
    }
}
