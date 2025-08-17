/*
 * Servlet xử lý đăng ký tài khoản user
 * Hỗ trợ upload ảnh profile từ base64
 */
package data.controllers;

import data.dao.Database;
import data.models.User;
import data.utils.ImageUtils;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * Servlet xử lý đăng ký tài khoản
 * @author PC
 */
@WebServlet(name = "signUpServlet", urlPatterns = {"/signup"})
public class signUpServlet extends HttpServlet {

    /**
     * Xử lý request GET - hiển thị form đăng ký
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Kiểm tra nếu đã đăng nhập thì chuyển hướng về trang chủ
        if (request.getSession().getAttribute("user") != null) {
            response.sendRedirect(request.getContextPath() + "/");
            return;
        }
        // Hiển thị trang đăng ký
        request.getRequestDispatcher("./views/signup.jsp").include(request, response);
    }

    /**
     * Xử lý request POST - xử lý đăng ký tài khoản
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Kiểm tra nếu đã đăng nhập thì chuyển hướng về trang chủ
        if (request.getSession().getAttribute("user") != null) {
            response.sendRedirect(request.getContextPath() + "/");
            return;
        }

        // Lấy thông tin từ form
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String address = request.getParameter("address");
        String phoneNumber = request.getParameter("phoneNumber");
        String fullName = request.getParameter("fullName");
        String pictureProfileBase64 = request.getParameter("pictureProfileBase64");
        String originalFileName = request.getParameter("originalFileName");

        // Khởi tạo ImageUtils nếu chưa được khởi tạo
        String realPath = getServletContext().getRealPath("/");
        if (realPath != null) {
            ImageUtils.initializePaths(realPath);
        }
        
        // Xử lý lưu ảnh profile
        String pictureProfilePath = null;
        if (pictureProfileBase64 != null && !pictureProfileBase64.isEmpty()) {
            pictureProfilePath = ImageUtils.saveUserImage(pictureProfileBase64, originalFileName);
            if (pictureProfilePath == null) {
                System.err.println("Lỗi khi lưu ảnh user");
            }
        }

        // Tạo user mới
        User user = Database.getUserDao().createUser(email, phoneNumber, fullName, pictureProfilePath, address, password);
        if (user == null) {
            // Đăng ký thất bại
            request.getSession().setAttribute("login_err", "Thông tin đăng ký không chính xác");
            response.sendRedirect("signup");
        } else {
            // Đăng ký thành công - đăng nhập luôn
            request.getSession().setAttribute("user", user);
            response.sendRedirect(request.getContextPath());
        }
    }

    @Override
    public String getServletInfo() {
        return "Servlet xử lý đăng ký tài khoản";
    }
}
