/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package data.controllers;

import data.dao.Database;
import data.models.User;
import data.utils.Base64Utils;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.Map;
import java.util.HashMap;
import java.util.regex.Pattern;

/**
 *
 * @author PC
 */
@WebServlet(name = "signUpServlet", urlPatterns = {"/signup"})
public class signUpServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet signUpServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet signUpServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("./views/signup.jsp").forward(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Lấy dữ liệu từ form
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        String address = request.getParameter("address");
        String phoneNumber = request.getParameter("phoneNumber");
        String fullName = request.getParameter("fullName");
        String pictureProfileBase64 = request.getParameter("pictureProfileBase64");
        
        // Validation
        Map<String, String> errors = validateSignupData(email, password, confirmPassword, address, phoneNumber, fullName);
        
        if (!errors.isEmpty()) {
            // Có lỗi validation, lưu lỗi và redirect về form
            request.getSession().setAttribute("signup_errors", errors);
            request.getSession().setAttribute("signup_data", createSignupDataMap(email, password, address, phoneNumber, fullName));
            response.sendRedirect("signup");
            return;
        }
        
        // Kiểm tra user đã tồn tại chưa
        Map<String, Object> userExistsCheck = Database.getUserDao().checkUserExists(email, phoneNumber);
        if ((Boolean) userExistsCheck.get("exists")) {
            Map<String, String> existsErrors = new HashMap<>();
            existsErrors.put("exists", (String) userExistsCheck.get("message"));
            request.getSession().setAttribute("signup_errors", existsErrors);
            request.getSession().setAttribute("signup_data", createSignupDataMap(email, password, address, phoneNumber, fullName));
            response.sendRedirect("signup");
            return;
        }
        
        // Xử lý ảnh profile
        if (pictureProfileBase64 != null && !pictureProfileBase64.isEmpty()) {
            byte[] imageBytes = Base64Utils.decode(pictureProfileBase64);
            if (imageBytes != null) {
                System.err.println("Image bytes length: " + imageBytes.length);
            }
        }
        
        // Tạo user
        User user = Database.getUserDao().createUser(email, phoneNumber, fullName, pictureProfileBase64, address, password);
        if (user == null) {
            Map<String, String> systemErrors = new HashMap<>();
            systemErrors.put("system", "Có lỗi xảy ra khi tạo tài khoản. Vui lòng thử lại sau.");
            request.getSession().setAttribute("signup_errors", systemErrors);
            request.getSession().setAttribute("signup_data", createSignupDataMap(email, password, address, phoneNumber, fullName));
            response.sendRedirect("signup");
        } else {
            // Đăng ký thành công
            request.getSession().setAttribute("user", user);
            request.getSession().setAttribute("signup_success", "Đăng ký tài khoản thành công!");
            response.sendRedirect(request.getContextPath());
        }
    }
    
    /**
     * Validate dữ liệu đăng ký
     */
    private Map<String, String> validateSignupData(String email, String password, String confirmPassword, 
                                                  String address, String phoneNumber, String fullName) {
        Map<String, String> errors = new HashMap<>();
        
        // Validate email
        if (email == null || email.trim().isEmpty()) {
            errors.put("email", "Email không được để trống");
        } else if (!isValidEmail(email)) {
            errors.put("email", "Email không đúng định dạng");
        }
        
        // Validate password
        if (password == null || password.trim().isEmpty()) {
            errors.put("password", "Mật khẩu không được để trống");
        } else if (password.length() < 6) {
            errors.put("password", "Mật khẩu phải có ít nhất 6 ký tự");
        } else if (!isValidPassword(password)) {
            errors.put("password", "Mật khẩu phải chứa ít nhất 1 chữ hoa, 1 chữ thường và 1 số");
        }
        
        // Validate confirm password
        if (confirmPassword == null || confirmPassword.trim().isEmpty()) {
            errors.put("confirmPassword", "Xác nhận mật khẩu không được để trống");
        } else if (!password.equals(confirmPassword)) {
            errors.put("confirmPassword", "Mật khẩu xác nhận không khớp");
        }
        
        // Validate full name
        if (fullName == null || fullName.trim().isEmpty()) {
            errors.put("fullName", "Họ và tên không được để trống");
        } else if (fullName.trim().length() < 2) {
            errors.put("fullName", "Họ và tên phải có ít nhất 2 ký tự");
        }
        
        // Validate phone number
        if (phoneNumber == null || phoneNumber.trim().isEmpty()) {
            errors.put("phoneNumber", "Số điện thoại không được để trống");
        } else if (!isValidPhoneNumber(phoneNumber)) {
            errors.put("phoneNumber", "Số điện thoại không đúng định dạng");
        }
        
        // Validate address
        if (address == null || address.trim().isEmpty()) {
            errors.put("address", "Địa chỉ không được để trống");
        } else if (address.trim().length() < 5) {
            errors.put("address", "Địa chỉ phải có ít nhất 5 ký tự");
        }
        
        return errors;
    }
    
    /**
     * Kiểm tra email hợp lệ
     */
    private boolean isValidEmail(String email) {
        String emailRegex = "^[a-zA-Z0-9_+&*-]+(?:\\.[a-zA-Z0-9_+&*-]+)*@(?:[a-zA-Z0-9-]+\\.)+[a-zA-Z]{2,7}$";
        Pattern pattern = Pattern.compile(emailRegex);
        return pattern.matcher(email).matches();
    }
    
    /**
     * Kiểm tra password hợp lệ
     */
    private boolean isValidPassword(String password) {
        // Ít nhất 1 chữ hoa, 1 chữ thường, 1 số
        boolean hasUpper = password.matches(".*[A-Z].*");
        boolean hasLower = password.matches(".*[a-z].*");
        boolean hasNumber = password.matches(".*\\d.*");
        return hasUpper && hasLower && hasNumber;
    }
    
    /**
     * Kiểm tra số điện thoại hợp lệ
     */
    private boolean isValidPhoneNumber(String phoneNumber) {
        // Số điện thoại Việt Nam: 10-11 số, bắt đầu bằng 0
        String phoneRegex = "^0[0-9]{9,10}$";
        Pattern pattern = Pattern.compile(phoneRegex);
        return pattern.matcher(phoneNumber).matches();
    }
    
    /**
     * Tạo map chứa dữ liệu form để giữ lại khi có lỗi
     */
    private Map<String, String> createSignupDataMap(String email, String password, String address, String phoneNumber, String fullName) {
        Map<String, String> data = new HashMap<>();
        data.put("email", email != null ? email : "");
        data.put("address", address != null ? address : "");
        data.put("phoneNumber", phoneNumber != null ? phoneNumber : "");
        data.put("fullName", fullName != null ? fullName : "");
        return data;
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
