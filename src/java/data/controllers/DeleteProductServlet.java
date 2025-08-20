package data.controllers;

import data.dao.ProductDao;
import data.implementations.ProductImplementation;
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

@WebServlet(name = "DeleteProductServlet", urlPatterns = {"/delete-product"})
public class DeleteProductServlet extends HttpServlet {

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
            
            // Lấy productId từ request
            String productIdStr = request.getParameter("productId");
            if (productIdStr == null || productIdStr.trim().isEmpty()) {
                response.sendRedirect(request.getContextPath() + "/admin?error=" + 
                    java.net.URLEncoder.encode("Thiếu thông tin sản phẩm", "UTF-8"));
                return;
            }
            
            int productId;
            try {
                productId = Integer.parseInt(productIdStr);
            } catch (NumberFormatException e) {
                response.sendRedirect(request.getContextPath() + "/admin?error=" + 
                    java.net.URLEncoder.encode("ID sản phẩm không hợp lệ", "UTF-8"));
                return;
            }
            
            // Thực hiện xóa sản phẩm
            ProductDao productDao = new ProductImplementation();
            boolean deleteSuccess = productDao.deleteProduct(productId);
            
            if (deleteSuccess) {
                System.out.println("Admin " + user.getEmail() + " đã xóa sản phẩm ID: " + productId);
                // Redirect về admin page với message thành công
                response.sendRedirect(request.getContextPath() + "/admin?success=" + 
                    java.net.URLEncoder.encode("Xóa sản phẩm thành công!", "UTF-8"));
            } else {
                // Redirect về admin page với message lỗi
                response.sendRedirect(request.getContextPath() + "/admin?error=" + 
                    java.net.URLEncoder.encode("Không thể xóa sản phẩm", "UTF-8"));
            }
            
        } catch (Exception e) {
            System.err.println("Lỗi khi xóa sản phẩm: " + e.getMessage());
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
