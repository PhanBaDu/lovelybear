/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package data.controllers;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.util.Enumeration;
import java.util.Map;
import java.util.ArrayList;
import java.util.List;
import java.util.Collection;
import java.net.URLEncoder;
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
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024, // 1 MB
    maxFileSize = 1024 * 1024 * 10,  // 10 MB
    maxRequestSize = 1024 * 1024 * 50 // 50 MB
)
public class addProductServlet extends HttpServlet {



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
        // Set encoding để xử lý tiếng Việt
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        
        try (PrintWriter out = response.getWriter()) {
            // Lấy message từ session hoặc request parameters
            String successMessage = request.getParameter("success");
            String errorMessage = request.getParameter("error");
            
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Thêm sản phẩm mới</title>");
            out.println("<meta charset='UTF-8'>");
            out.println("<style>");
            out.println("body { font-family: Arial, sans-serif; margin: 20px; }");
            out.println(".message { padding: 10px; margin: 10px 0; border-radius: 5px; }");
            out.println(".success { background-color: #d4edda; color: #155724; border: 1px solid #c3e6cb; }");
            out.println(".error { background-color: #f8d7da; color: #721c24; border: 1px solid #f5c6cb; }");
            out.println(".form-group { margin-bottom: 15px; }");
            out.println("label { display: block; margin-bottom: 5px; font-weight: bold; }");
            out.println("input[type='text'], textarea { width: 100%; padding: 8px; border: 1px solid #ddd; border-radius: 4px; }");
            out.println("button { background-color: #007bff; color: white; padding: 10px 20px; border: none; border-radius: 4px; cursor: pointer; }");
            out.println("button:hover { background-color: #0056b3; }");
            out.println("</style>");
            out.println("</head>");
            out.println("<body>");
            
            out.println("<h1>Thêm sản phẩm mới</h1>");
            
            // Hiển thị message nếu có
            if (successMessage != null && !successMessage.trim().isEmpty()) {
                out.println("<div class='message success'>" + successMessage + "</div>");
            }
            if (errorMessage != null && !errorMessage.trim().isEmpty()) {
                out.println("<div class='message error'>" + errorMessage + "</div>");
            }
            
            // Form thêm sản phẩm
            out.println("<form action='" + request.getContextPath() + "/add-product' method='POST' enctype='multipart/form-data'>");
            out.println("<div class='form-group'>");
            out.println("<label for='productName'>Tên sản phẩm:</label>");
            out.println("<input type='text' id='productName' name='productName' required>");
            out.println("</div>");
            
            out.println("<div class='form-group'>");
            out.println("<label for='description'>Mô tả:</label>");
            out.println("<textarea id='description' name='description' rows='3'></textarea>");
            out.println("</div>");
            
            out.println("<div class='form-group'>");
            out.println("<label for='price'>Giá:</label>");
            out.println("<input type='text' id='price' name='price' required placeholder='Ví dụ: 100000'>");
            out.println("</div>");
            
            out.println("<div class='form-group'>");
            out.println("<label for='image'>Hình ảnh:</label>");
            out.println("<input type='file' id='image' name='image' accept='image/*' multiple>");
            out.println("</div>");
            
            out.println("<button type='submit'>Thêm sản phẩm</button>");
            out.println("</form>");
            
            out.println("<br>");
            out.println("<a href='" + request.getContextPath() + "/admin'>← Quay lại trang Admin</a>");
            
            out.println("</body>");
            out.println("</html>");
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
        System.out.println("=== ADD PRODUCT SERVLET - START ===");
        
        try {
            // Lấy thông tin sản phẩm từ request một cách an toàn
            String productName = getFormParameter(request, "productName");
            String description = getFormParameter(request, "description");
            String price = getFormParameter(request, "price");
            
            System.out.println("--- Product Information ---");
            System.out.println("Product Name: " + productName);
            System.out.println("Description: " + description);
            System.out.println("Price: " + price);
            
            // Validate thông tin cơ bản
            if (productName == null || productName.trim().isEmpty()) {
                System.err.println("Lỗi: Tên sản phẩm không được để trống");
                redirectWithError(request, response, "Tên sản phẩm không được để trống");
                return;
            }
            
            if (price == null || price.trim().isEmpty()) {
                System.err.println("Lỗi: Giá sản phẩm không được để trống");
                redirectWithError(request, response, "Giá sản phẩm không được để trống");
                return;
            }
            
            // Tạo sản phẩm
            ProductDao productDao = Database.getProductDao();
            Product newProduct = productDao.createProduct(productName.trim(), 
                description != null ? description.trim() : "", price);
            
            if (newProduct == null) {
                System.err.println("Lỗi: Không thể tạo sản phẩm");
                redirectWithError(request, response, "Không thể tạo sản phẩm. Vui lòng kiểm tra lại thông tin.");
                return;
            }
            
            System.out.println("Tạo sản phẩm thành công với ID: " + newProduct.getId());
            
            // Xử lý hình ảnh sản phẩm
            List<ProductImage> createdImages = new ArrayList<>();
            ProductImageDao imageDao = Database.getProductImageDao();
            
            // Xử lý file upload - kiểm tra content type trước
            String contentType = request.getContentType();
            System.out.println("Content-Type: " + contentType);
            
            if (contentType != null && contentType.toLowerCase().startsWith("multipart/form-data")) {
                try {
                    Collection<Part> fileParts = request.getParts();
                    int imageCount = 0;
                    
                    System.out.println("\n--- Processing Images ---");
                    
                    for (Part filePart : fileParts) {
                        if (filePart.getName().equals("image") && filePart.getSize() > 0) {
                            imageCount++;
                            String fileName = getSubmittedFileName(filePart);
                            String partContentType = filePart.getContentType();
                            
                            System.out.println("Processing Image " + imageCount + ":");
                            System.out.println("  File Name: " + fileName);
                            System.out.println("  Content Type: " + partContentType);
                            System.out.println("  File Size: " + filePart.getSize() + " bytes");
                            
                            // Tạo URL hình ảnh từ file upload
                            String imageUrl = createImageUrlFromFile(fileName);
                            
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
                                System.err.println("  Lỗi: Không thể xử lý file hình ảnh");
                            }
                        }
                    }
                    
                    System.out.println("Tổng số hình ảnh đã xử lý: " + imageCount);
                    System.out.println("Tổng số hình ảnh đã tạo thành công: " + createdImages.size());
                    
                    if (imageCount == 0) {
                        System.out.println("Không có hình ảnh nào được cung cấp");
                    }
                    
                } catch (Exception e) {
                    System.err.println("Lỗi khi xử lý file upload: " + e.getMessage());
                    e.printStackTrace();
                    // Tiếp tục xử lý mà không dừng lại
                }
            } else {
                System.out.println("Không phải multipart form, bỏ qua xử lý file upload");
            }
            
            // Redirect về trang admin với thông báo thành công
            System.out.println("Redirecting to admin page with success message...");
            redirectWithSuccess(request, response, newProduct);
            
        } catch (Exception e) {
            System.err.println("Lỗi không mong muốn: " + e.getMessage());
            e.printStackTrace();
            redirectWithError(request, response, "Đã xảy ra lỗi: " + e.getMessage());
        }
        
        System.out.println("=== ADD PRODUCT SERVLET - END ===\n");
    }
    
    /**
     * Lấy tên file từ Part
     */
    private String getSubmittedFileName(Part part) {
        try {
            String contentDisp = part.getHeader("content-disposition");
            if (contentDisp == null) return "";
            
            String[] tokens = contentDisp.split(";");
            for (String token : tokens) {
                if (token.trim().startsWith("filename")) {
                    String fileName = token.substring(token.indexOf("=") + 2, token.length() - 1);
                    // Loại bỏ dấu ngoặc kép nếu có
                    if (fileName.startsWith("\"") && fileName.endsWith("\"")) {
                        fileName = fileName.substring(1, fileName.length() - 1);
                    }
                    return fileName;
                }
            }
        } catch (Exception e) {
            System.err.println("Lỗi khi lấy tên file: " + e.getMessage());
        }
        return "";
    }
    
    /**
     * Tạo URL hình ảnh từ file upload
     */
    private String createImageUrlFromFile(String fileName) {
        try {
            if (fileName != null && !fileName.trim().isEmpty()) {
                // Loại bỏ ký tự đặc biệt và khoảng trắng
                String safeFileName = fileName.replaceAll("[^a-zA-Z0-9.-]", "_");
                return "/uploads/products/" + System.currentTimeMillis() + "_" + safeFileName;
            } else {
                return "/uploads/products/" + System.currentTimeMillis() + ".jpg";
            }
        } catch (Exception e) {
            System.err.println("Lỗi khi xử lý file hình ảnh: " + e.getMessage());
            return null;
        }
    }
    
    /**
     * Xử lý form data một cách an toàn
     */
    private String getFormParameter(HttpServletRequest request, String paramName) {
        try {
            String value = request.getParameter(paramName);
            return value != null ? value.trim() : "";
        } catch (Exception e) {
            System.err.println("Lỗi khi lấy parameter " + paramName + ": " + e.getMessage());
            return "";
        }
    }
    
    /**
     * Redirect về trang admin với thông báo lỗi
     */
    private void redirectWithError(HttpServletRequest request, HttpServletResponse response, String errorMessage) 
            throws IOException {
        try {
            // Encode message để tránh lỗi Unicode
            String encodedMessage = java.net.URLEncoder.encode(errorMessage, "UTF-8");
            String redirectUrl = request.getContextPath() + "/admin?error=" + encodedMessage;
            
            System.out.println("Redirecting to admin with error: " + redirectUrl);
            response.sendRedirect(redirectUrl);
            
        } catch (Exception e) {
            System.err.println("Lỗi khi redirect: " + e.getMessage());
            // Fallback: redirect về admin không có error message
            response.sendRedirect(request.getContextPath() + "/admin");
        }
    }
    
    /**
     * Redirect về trang admin với thông báo thành công
     */
    private void redirectWithSuccess(HttpServletRequest request, HttpServletResponse response, Product product) 
            throws IOException {
        try {
            String successMessage = "Tạo sản phẩm '" + product.getName() + "' thành công!";
            // Encode message để tránh lỗi Unicode
            String encodedMessage = java.net.URLEncoder.encode(successMessage, "UTF-8");
            String redirectUrl = request.getContextPath() + "/admin?success=" + encodedMessage;
            
            System.out.println("Redirecting to admin with success: " + redirectUrl);
            response.sendRedirect(redirectUrl);
            
        } catch (Exception e) {
            System.err.println("Lỗi khi redirect: " + e.getMessage());
            // Fallback: redirect về admin không có error message
            response.sendRedirect(request.getContextPath() + "/admin");
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
