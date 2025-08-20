package data.controllers;

import data.dao.OrderDao;
import data.implementations.OrderImplementation;
import data.models.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
// import org.json.JSONObject;

@WebServlet(name = "UpdateOrderStatusServlet", urlPatterns = {"/update-order-status"})
public class UpdateOrderStatusServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
            // Kiểm tra session và role ADMIN
            HttpSession session = request.getSession(false);
            if (session == null) {
                response.sendRedirect(request.getContextPath() + "/admin?error=" + 
                    java.net.URLEncoder.encode("Chưa đăng nhập", "UTF-8"));
                return;
            }
            
            User user = (User) session.getAttribute("user");
            if (user == null || !"ADMIN".equals(user.getRole())) {
                response.sendRedirect(request.getContextPath() + "/admin?error=" + 
                    java.net.URLEncoder.encode("Không có quyền truy cập", "UTF-8"));
                return;
            }
            
            // Lấy orderId và status từ request
            String orderIdStr = request.getParameter("orderId");
            String status = request.getParameter("status");
            
            if (orderIdStr == null || orderIdStr.trim().isEmpty()) {
                response.sendRedirect(request.getContextPath() + "/admin?error=" + 
                    java.net.URLEncoder.encode("Thiếu thông tin đơn hàng", "UTF-8"));
                return;
            }
            
            if (status == null || status.trim().isEmpty()) {
                response.sendRedirect(request.getContextPath() + "/admin?error=" + 
                    java.net.URLEncoder.encode("Thiếu thông tin trạng thái", "UTF-8"));
                return;
            }
            
            int orderId;
            try {
                orderId = Integer.parseInt(orderIdStr);
            } catch (NumberFormatException e) {
                response.sendRedirect(request.getContextPath() + "/admin?error=" + 
                    java.net.URLEncoder.encode("ID đơn hàng không hợp lệ", "UTF-8"));
                return;
            }
            
            // Kiểm tra trạng thái hợp lệ
            if (!"CONFIRMED".equals(status)) {
                response.sendRedirect(request.getContextPath() + "/admin?error=" + 
                    java.net.URLEncoder.encode("Trạng thái không hợp lệ", "UTF-8"));
                return;
            }
            
            // Thực hiện cập nhật trạng thái đơn hàng
            OrderDao orderDao = new OrderImplementation();
            boolean updateSuccess = orderDao.updateOrderStatus(orderId, status);
            
            if (updateSuccess) {
                System.out.println("Admin " + user.getEmail() + " đã cập nhật đơn hàng ID: " + orderId + " thành trạng thái: " + status);
                // Redirect về admin page với message thành công
                response.sendRedirect(request.getContextPath() + "/admin?success=" + 
                    java.net.URLEncoder.encode("Cập nhật trạng thái đơn hàng thành công!", "UTF-8"));
            } else {
                // Redirect về admin page với message lỗi
                response.sendRedirect(request.getContextPath() + "/admin?error=" + 
                    java.net.URLEncoder.encode("Không thể cập nhật trạng thái đơn hàng", "UTF-8"));
            }
            
        } catch (Exception e) {
            System.err.println("Lỗi khi cập nhật trạng thái đơn hàng: " + e.getMessage());
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/admin?error=" + 
                java.net.URLEncoder.encode("Có lỗi xảy ra: " + e.getMessage(), "UTF-8"));
        }
    }

               @Override
           protected void doGet(HttpServletRequest request, HttpServletResponse response)
                   throws ServletException, IOException {
               // Xử lý GET request từ redirect
               doPost(request, response);
           }
}
