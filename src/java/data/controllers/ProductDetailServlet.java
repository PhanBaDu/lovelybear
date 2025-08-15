/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package data.controllers;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import data.dao.Database;
import data.dao.ProductDao;
import data.dao.ProductImageDao;
import data.models.Product;
import data.models.ProductImage;
import java.util.List;

/**
 *
 * @author PC
 */
@WebServlet(name = "ProductDetailServlet", urlPatterns = {"/product"})
public class ProductDetailServlet extends HttpServlet {

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
        
        try {
            // Lấy ID sản phẩm từ parameter
            String productIdStr = request.getParameter("id");
            if (productIdStr == null || productIdStr.trim().isEmpty()) {
                response.sendRedirect(request.getContextPath());
                return;
            }
            
            int productId = Integer.parseInt(productIdStr);
            
            // Lấy thông tin sản phẩm
            ProductDao productDao = Database.getProductDao();
            ProductImageDao imageDao = Database.getProductImageDao();
            
            Product product = productDao.getProductById(productId);
            if (product == null) {
                response.sendRedirect(request.getContextPath());
                return;
            }
            
            // Lấy tất cả ảnh của sản phẩm
            List<ProductImage> images = imageDao.getProductImagesByProductId(productId);
            
            // Đặt thông tin vào request attribute
            request.setAttribute("product", product);
            request.setAttribute("images", images);
            
            // Forward đến JSP để hiển thị
            request.getRequestDispatcher("/views/product-detail.jsp").forward(request, response);
            
        } catch (NumberFormatException e) {
            System.err.println("ID sản phẩm không hợp lệ: " + e.getMessage());
            response.sendRedirect(request.getContextPath());
        } catch (Exception e) {
            System.err.println("Lỗi khi lấy chi tiết sản phẩm: " + e.getMessage());
            e.printStackTrace();
            response.sendRedirect(request.getContextPath());
        }
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
        doGet(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Product Detail Servlet";
    }
}
