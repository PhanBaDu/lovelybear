/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package data.controllers;

import data.driver.MySqlDriver;
import java.sql.Connection;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import data.utils.Base64Utils;

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
        request.getRequestDispatcher("./views/signup.jsp").include(request, response);
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
        String email = request.getParameter("email");
        String address = request.getParameter("address");
        String phoneNumber = request.getParameter("phoneNumber");
        String fullName = request.getParameter("fullName");
        String pictureProfileBase64 = request.getParameter("pictureProfileBase64");
        
        System.err.println("Email: " + email);
        System.err.println("Address: " + address);
        System.err.println("Phone Number: " + phoneNumber);
        System.err.println("Full Name: " + fullName);
        System.err.println("Picture Profile Base64: " + (pictureProfileBase64 != null ? pictureProfileBase64.substring(0, Math.min(50, pictureProfileBase64.length())) + "..." : "null"));
                // Xử lý base64 string ở đây
        if (pictureProfileBase64 != null && !pictureProfileBase64.isEmpty()) {
            // Có thể lưu vào database hoặc xử lý theo nhu cầu
            System.err.println("Base64 length: " + pictureProfileBase64.length());
            
            // Ví dụ: Chuyển đổi base64 thành byte array
            byte[] imageBytes = Base64Utils.decode(pictureProfileBase64);
            if (imageBytes != null) {
                System.err.println("Image bytes length: " + imageBytes.length);
            }
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
