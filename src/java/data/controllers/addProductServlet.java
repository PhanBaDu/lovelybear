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
import java.util.ArrayList;
import java.util.List;
import data.dao.Database;
import data.dao.ProductDao;
import data.dao.ProductImageDao;
import data.models.Product;
import data.models.ProductImage;

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
        
        System.out.println("=== ADD PRODUCT SERVLET - START ===");
        
        try {
            // Lấy thông tin sản phẩm từ request
            String productName = request.getParameter("productName");
            String description = request.getParameter("description");
            String price = request.getParameter("price");
            
            System.out.println("--- Product Information ---");
            System.out.println("Product Name: " + productName);
            System.out.println("Description: " + description);
            System.out.println("Price: " + price);
            
            // Validate thông tin cơ bản
            if (productName == null || productName.trim().isEmpty()) {
                System.err.println("Lỗi: Tên sản phẩm không được để trống");
                sendErrorResponse(response, "Tên sản phẩm không được để trống");
                return;
            }
            
            if (price == null || price.trim().isEmpty()) {
                System.err.println("Lỗi: Giá sản phẩm không được để trống");
                sendErrorResponse(response, "Giá sản phẩm không được để trống");
                return;
            }
            
            // Tạo sản phẩm
            ProductDao productDao = Database.getProductDao();
            Product newProduct = productDao.createProduct(productName.trim(), 
                description != null ? description.trim() : "", price);
            
            if (newProduct == null) {
                System.err.println("Lỗi: Không thể tạo sản phẩm");
                sendErrorResponse(response, "Không thể tạo sản phẩm. Vui lòng kiểm tra lại thông tin.");
                return;
            }
            
            System.out.println("Tạo sản phẩm thành công với ID: " + newProduct.getId());
            
            // Xử lý hình ảnh sản phẩm
            List<ProductImage> createdImages = new ArrayList<>();
            ProductImageDao imageDao = Database.getProductImageDao();
            
            // Lấy tất cả parameters để tìm hình ảnh
            Map<String, String[]> parameterMap = request.getParameterMap();
            int imageCount = 0;
            
            System.out.println("\n--- Processing Images ---");
            
            for (String paramName : parameterMap.keySet()) {
                if (paramName.startsWith("imageBase64_")) {
                    imageCount++;
                    String imageId = paramName.substring("imageBase64_".length());
                    String base64Data = request.getParameter(paramName);
                    String mimeType = request.getParameter("imageMimeType_" + imageId);
                    String fileName = request.getParameter("imageFileName_" + imageId);
                    
                    System.out.println("Processing Image " + imageCount + ":");
                    System.out.println("  ID: " + imageId);
                    System.out.println("  File Name: " + fileName);
                    System.out.println("  MIME Type: " + mimeType);
                    System.out.println("  Base64 Length: " + (base64Data != null ? base64Data.length() : 0) + " characters");
                    
                    // Tạo URL hình ảnh từ base64 data
                    if (base64Data != null && !base64Data.trim().isEmpty()) {
                        String imageUrl = createImageUrlFromBase64(base64Data, mimeType, fileName);
                        
                        if (imageUrl != null) {
                            // Tạo ProductImage trong database
                            ProductImage newImage = imageDao.createProductImage(newProduct.getId(), imageUrl);
                            
                            if (newImage != null) {
                                createdImages.add(newImage);
                                System.out.println("  Tạo hình ảnh thành công với ID: " + newImage.getId());
                            } else {
                                System.err.println("  Lỗi: Không thể tạo hình ảnh trong database");
                            }
                        } else {
                            System.err.println("  Lỗi: Không thể xử lý dữ liệu hình ảnh");
                        }
                    } else {
                        System.err.println("  Lỗi: Dữ liệu hình ảnh rỗng");
                    }
                }
            }
            
            System.out.println("Tổng số hình ảnh đã xử lý: " + imageCount);
            System.out.println("Tổng số hình ảnh đã tạo thành công: " + createdImages.size());
            
            // Gửi response thành công
            if (imageCount == 0) {
                System.out.println("Không có hình ảnh nào được cung cấp");
            }
            
            sendSuccessResponse(response, newProduct, createdImages);
            
        } catch (Exception e) {
            System.err.println("Lỗi không mong muốn: " + e.getMessage());
            e.printStackTrace();
            sendErrorResponse(response, "Đã xảy ra lỗi: " + e.getMessage());
        }
        
        System.out.println("=== ADD PRODUCT SERVLET - END ===\n");
    }
    
    /**
     * Tạo URL hình ảnh từ dữ liệu base64
     */
    private String createImageUrlFromBase64(String base64Data, String mimeType, String fileName) {
        try {
            // Trong thực tế, bạn có thể:
            // 1. Lưu file vào thư mục trên server
            // 2. Upload lên cloud storage (AWS S3, Google Cloud Storage, etc.)
            // 3. Lưu trực tiếp vào database dưới dạng BLOB
            
            // Ví dụ đơn giản: tạo URL tương đối
            if (fileName != null && !fileName.trim().isEmpty()) {
                return "/uploads/products/" + System.currentTimeMillis() + "_" + fileName;
            } else {
                return "/uploads/products/" + System.currentTimeMillis() + ".jpg";
            }
            
        } catch (Exception e) {
            System.err.println("Lỗi khi xử lý hình ảnh: " + e.getMessage());
            return null;
        }
    }
    
    /**
     * Gửi response thành công
     */
    private void sendSuccessResponse(HttpServletResponse response, Product product, List<ProductImage> images) 
            throws IOException {
        response.setContentType("application/json;charset=UTF-8");
        response.setCharacterEncoding("UTF-8");
        
        try (PrintWriter out = response.getWriter()) {
            StringBuilder json = new StringBuilder();
            json.append("{");
            json.append("\"success\": true,");
            json.append("\"message\": \"Tạo sản phẩm thành công\",");
            json.append("\"product\": {");
            json.append("\"id\": ").append(product.getId()).append(",");
            json.append("\"name\": \"").append(product.getName()).append("\",");
            json.append("\"description\": \"").append(product.getDescription()).append("\",");
            json.append("\"price\": ").append(product.getPrice()).append(",");
            json.append("\"createdAt\": \"").append(product.getCreatedAt()).append("\"");
            json.append("},");
            json.append("\"images\": [");
            
            for (int i = 0; i < images.size(); i++) {
                ProductImage img = images.get(i);
                json.append("{");
                json.append("\"id\": ").append(img.getId()).append(",");
                json.append("\"url\": \"").append(img.getImageUrl()).append("\"");
                json.append("}");
                if (i < images.size() - 1) {
                    json.append(",");
                }
            }
            
            json.append("]");
            json.append("}");
            
            out.print(json.toString());
            System.out.println("Gửi response thành công: " + json.toString());
        }
    }
    
    /**
     * Gửi response lỗi
     */
    private void sendErrorResponse(HttpServletResponse response, String errorMessage) 
            throws IOException {
        response.setContentType("application/json;charset=UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
        
        try (PrintWriter out = response.getWriter()) {
            String json = "{\"success\": false, \"message\": \"" + errorMessage + "\"}";
            out.print(json);
            System.out.println("Gửi response lỗi: " + json);
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
