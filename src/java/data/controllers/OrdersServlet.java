package data.controllers;

import data.dao.OrderDao;
import data.dao.OrderItemDao;
import data.implementations.OrderImplementation;
import data.implementations.OrderItemImplementation;
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
import java.util.List;

@WebServlet("/orders")
public class OrdersServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        // Kiểm tra đăng nhập
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/views/signin.jsp");
            return;
        }
        
        try {
            // Lấy action từ request (nếu có)
            String action = request.getParameter("action");
            String orderIdParam = request.getParameter("id");
            
            if ("detail".equals(action) && orderIdParam != null) {
                // Hiển thị chi tiết đơn hàng
                showOrderDetail(request, response, user, orderIdParam);
            } else {
                // Hiển thị danh sách đơn hàng
                showOrdersList(request, response, user);
            }
            
        } catch (Exception e) {
            System.err.println("Error in OrdersServlet: " + e.getMessage());
            request.setAttribute("error", "Có lỗi xảy ra khi tải đơn hàng: " + e.getMessage());
            request.getRequestDispatcher("/views/orders.jsp").forward(request, response);
        }
    }
    
    private void showOrdersList(HttpServletRequest request, HttpServletResponse response, User user) 
            throws ServletException, IOException {
        
        OrderDao orderDao = new OrderImplementation();
        List<Order> orders = orderDao.getActiveOrdersByUserEmail(user.getEmail());
        
        request.setAttribute("orders", orders);
        request.getRequestDispatcher("/views/orders.jsp").forward(request, response);
    }
    
    private void showOrderDetail(HttpServletRequest request, HttpServletResponse response, 
                                User user, String orderIdParam) 
            throws ServletException, IOException {
        
        try {
            int orderId = Integer.parseInt(orderIdParam);
            
            OrderDao orderDao = new OrderImplementation();
            Order order = orderDao.getOrderById(orderId);
            
            // Kiểm tra đơn hàng có thuộc về user này không
            if (order == null || !order.getUserEmail().equals(user.getEmail())) {
                response.sendRedirect(request.getContextPath() + "/orders");
                return;
            }
            
            // Lấy chi tiết items của đơn hàng
            OrderItemDao orderItemDao = new OrderItemImplementation();
            List<OrderItem> orderItems = orderItemDao.getOrderItemsByOrderId(orderId);
            
            request.setAttribute("order", order);
            request.setAttribute("orderItems", orderItems);
            request.getRequestDispatcher("/views/order-detail.jsp").forward(request, response);
            
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/orders");
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Redirect POST requests to GET
        doGet(request, response);
    }
}
