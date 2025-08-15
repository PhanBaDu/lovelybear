/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package data.controllers;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.Enumeration;
import java.util.Map;

/**
 *
 * @author PC
 */
@WebServlet(name = "addProductServlet", urlPatterns = {"/add-product"})
public class addProductServlet extends HttpServlet {

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
            out.println("<title>Servlet addProductServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet addProductServlet at " + request.getContextPath() + "</h1>");
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
        processRequest(request, response);
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
// Set encoding để xử lý tiếng Việt
        request.setCharacterEncoding("UTF-8");
        
        System.out.println("=== ADD PRODUCT SERVLET - PARAMETER DEBUG ===");
        
        // Method 1: In từng parameter quan trọng
        System.out.println("--- Basic Product Info ---");
        System.out.println("Product Name: " + request.getParameter("productName"));
        System.out.println("Description: " + request.getParameter("description"));
        System.out.println("Price: " + request.getParameter("price"));
        
        // Method 2: In tất cả parameters bằng Enumeration
        System.out.println("\n--- All Parameters (Enumeration) ---");
        Enumeration<String> parameterNames = request.getParameterNames();
        while (parameterNames.hasMoreElements()) {
            String paramName = parameterNames.nextElement();
            String[] paramValues = request.getParameterValues(paramName);
            
            if (paramValues.length == 1) {
                System.out.println(paramName + " = " + paramValues[0]);
            } else {
                System.out.println(paramName + " = [" + String.join(", ", paramValues) + "]");
            }
        }
        
        // Method 3: In tất cả parameters bằng Parameter Map
        System.out.println("\n--- All Parameters (Parameter Map) ---");
        Map<String, String[]> parameterMap = request.getParameterMap();
        for (Map.Entry<String, String[]> entry : parameterMap.entrySet()) {
            String key = entry.getKey();
            String[] values = entry.getValue();
            
            if (values.length == 1) {
                System.out.println(key + " = " + values[0]);
            } else {
                System.out.println(key + " = [" + String.join(", ", values) + "]");
            }
        }
        
        // Method 4: Kiểm tra và in các image parameters đặc biệt
        System.out.println("\n--- Image Parameters Analysis ---");
        int imageCount = 0;
        for (String paramName : parameterMap.keySet()) {
            if (paramName.startsWith("imageBase64_")) {
                imageCount++;
                String imageId = paramName.substring("imageBase64_".length());
                String base64Data = request.getParameter(paramName);
                String mimeType = request.getParameter("imageMimeType_" + imageId);
                String fileName = request.getParameter("imageFileName_" + imageId);
                
                System.out.println("Image " + imageCount + ":");
                System.out.println("  ID: " + imageId);
                System.out.println("  File Name: " + fileName);
                System.out.println("  MIME Type: " + mimeType);
                System.out.println("  Base64 Length: " + (base64Data != null ? base64Data.length() : 0) + " characters");
                System.out.println("  Base64 Preview: " + (base64Data != null ? base64Data.substring(0, Math.min(50, base64Data.length())) + "..." : "null"));
            }
        }
        System.out.println("Total Images Found: " + imageCount);
        
        // Method 5: Kiểm tra content type và multipart
        System.out.println("\n--- Request Info ---");
        System.out.println("Content Type: " + request.getContentType());
        System.out.println("Content Length: " + request.getContentLength());
        System.out.println("Method: " + request.getMethod());
        System.out.println("Character Encoding: " + request.getCharacterEncoding());
        
        System.out.println("=== END DEBUG ===\n");
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
