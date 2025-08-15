/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package data.controllers;

import data.dao.Database;
import data.models.User;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 *
 * @author PC
 */
@WebServlet(name = "signInServlet", urlPatterns = {"/signin"})
public class signInServlet extends HttpServlet {

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
            out.println("<title>Servlet signInServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet signInServlet at " + request.getContextPath() + "</h1>");
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
        // Kiểm tra nếu đã đăng nhập thì chuyển hướng về trang chủ
        if (request.getSession().getAttribute("user") != null) {
            response.sendRedirect(request.getContextPath() + "/");
            return;
        }
        request.getRequestDispatcher("./views/signin.jsp").include(request, response);
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
        // Kiểm tra nếu đã đăng nhập thì chuyển hướng về trang chủ
        if (request.getSession().getAttribute("user") != null) {
            response.sendRedirect(request.getContextPath() + "/");
            return;
        }
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        // Validation cơ bản
        if (email == null || email.trim().isEmpty()) {
            // Lưu error vào session thay vì request
            HttpSession session = request.getSession();
            session.setAttribute("errorMessage", "Email không được để trống");
            session.setAttribute("email", email);
            response.sendRedirect(request.getContextPath() + "/signin");
            return;
        }

        if (password == null || password.trim().isEmpty()) {
            HttpSession session = request.getSession();
            session.setAttribute("errorMessage", "Mật khẩu không được để trống");
            session.setAttribute("email", email);
            response.sendRedirect(request.getContextPath() + "/signin");
            return;
        }

        // Kiểm tra email có tồn tại không
        boolean emailExists = Database.getUserDao().checkEmailExists(email.trim());
        if (!emailExists) {
            HttpSession session = request.getSession();
            session.setAttribute("errorMessage", "Email không tồn tại trong hệ thống");
            session.setAttribute("email", email);
            response.sendRedirect(request.getContextPath() + "/signin");
            return;
        }

        // Thực hiện đăng nhập
        User user = Database.getUserDao().signIn(email.trim(), password);
        if (user != null) {
            // Đăng nhập thành công
            HttpSession session = request.getSession();
            session.setAttribute("user", user);

            // Clear any previous error messages
            session.removeAttribute("errorMessage");
            session.removeAttribute("email");

            // Redirect theo role
            if (user.isAdmin()) {
                response.sendRedirect(request.getContextPath() + "/admin");
            } else {
                response.sendRedirect(request.getContextPath() + "/");
            }
        } else {
            // Email tồn tại nhưng mật khẩu sai
            HttpSession session = request.getSession();
            session.setAttribute("errorMessage", "Mật khẩu không đúng");
            session.setAttribute("email", email);
            response.sendRedirect(request.getContextPath() + "/signin");
        }
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
