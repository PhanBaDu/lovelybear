package data.controllers;

import data.constants.OrderStatus;
import data.dao.OrderDao;
import data.implementations.OrderImplementation;
import data.models.Order;
import data.models.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/cancel-order")
public class CancelOrderServlet extends HttpServlet {
    private OrderDao orderDao;
    
    @Override
    public void init() throws ServletException {
        orderDao = new OrderImplementation();
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/signin");
            return;
        }
        
        User user = (User) session.getAttribute("user");
        String orderIdStr = request.getParameter("orderId");
        
        if (orderIdStr == null || orderIdStr.trim().isEmpty()) {
            request.setAttribute("error", "ID đơn hàng không hợp lệ");
            request.getRequestDispatcher("/orders").forward(request, response);
            return;
        }
        
        try {
            int orderId = Integer.parseInt(orderIdStr);
            
            // Kiểm tra đơn hàng có tồn tại và thuộc về user hiện tại không
            Order order = orderDao.getOrderById(orderId);
            if (order == null) {
                request.setAttribute("error", "Đơn hàng không tồn tại");
                request.getRequestDispatcher("/orders").forward(request, response);
                return;
            }
            
            if (!order.getUserEmail().equals(user.getEmail())) {
                request.setAttribute("error", "Bạn không có quyền hủy đơn hàng này");
                request.getRequestDispatcher("/orders").forward(request, response);
                return;
            }
            
            // Kiểm tra trạng thái đơn hàng có thể hủy không
            if (!OrderStatus.PENDING.equals(order.getStatus())) {
                request.setAttribute("error", "Chỉ có thể hủy đơn hàng đang chờ xử lý");
                request.getRequestDispatcher("/orders").forward(request, response);
                return;
            }
            
            // Thực hiện hủy đơn hàng
            boolean success = orderDao.updateOrderStatus(orderId, OrderStatus.CANCELLED);
            
            if (success) {
                // Redirect với thông báo thành công
                response.sendRedirect(request.getContextPath() + "/orders?success=cancelled");
            } else {
                request.setAttribute("error", "Không thể hủy đơn hàng. Vui lòng thử lại sau");
                request.getRequestDispatcher("/orders").forward(request, response);
            }
            
        } catch (NumberFormatException e) {
            request.setAttribute("error", "ID đơn hàng không hợp lệ");
            request.getRequestDispatcher("/orders").forward(request, response);
        } catch (Exception e) {
            System.err.println("Error cancelling order: " + e.getMessage());
            request.setAttribute("error", "Đã xảy ra lỗi khi hủy đơn hàng");
            request.getRequestDispatcher("/orders").forward(request, response);
        }
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Redirect GET requests to orders page
        response.sendRedirect(request.getContextPath() + "/orders");
    }
}
