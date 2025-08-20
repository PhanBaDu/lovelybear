package data.controllers;

import data.dao.ProductDao;
import data.dao.ProductImageDao;
import data.dao.Database;
import data.models.Product;
import data.models.ProductImage;
import java.io.IOException;
import java.io.PrintWriter;
import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;


/**
 * API Servlet for Products
 * @author PC
 */
@WebServlet(name = "ProductsAPIServlet", urlPatterns = {"/api/products"})
public class ProductsAPIServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Set response type to JSON
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        
        PrintWriter out = response.getWriter();
        
        try {
            // Lấy danh sách sản phẩm từ database
            ProductDao productDao = Database.getProductDao();
            ProductImageDao productImageDao = Database.getProductImageDao();
            List<Product> products = productDao.getAllProducts();
            
            // Debug logging
            System.out.println("API: Lấy được " + (products != null ? products.size() : 0) + " sản phẩm");
            
            // Tạo JSON response thủ công
            StringBuilder jsonBuilder = new StringBuilder();
            jsonBuilder.append("[");
            
            if (products != null && !products.isEmpty()) {
                for (int i = 0; i < products.size(); i++) {
                    Product product = products.get(i);
                    
                    // Lấy ảnh đầu tiên của sản phẩm
                    String imageUrl = "";
                    try {
                        List<ProductImage> productImages = productImageDao.getProductImagesByProductId(product.getId());
                        if (productImages != null && !productImages.isEmpty()) {
                            imageUrl = productImages.get(0).getImageUrl();
                            // Thêm base URL nếu imageUrl chỉ là relative path
                            if (imageUrl.startsWith("/")) {
                                imageUrl = request.getContextPath() + imageUrl;
                            }
                            System.out.println("API: Sản phẩm " + product.getId() + " có ảnh: " + imageUrl);
                        } else {
                            System.out.println("API: Sản phẩm " + product.getId() + " không có ảnh");
                        }
                    } catch (Exception e) {
                        System.err.println("API: Lỗi khi lấy ảnh cho sản phẩm " + product.getId() + ": " + e.getMessage());
                    }
                    
                    // Format giá tiền - làm tròn lên và format .000đ
                    String formattedPrice = formatPrice(product.getPrice());
                    
                    // Build JSON object
                    jsonBuilder.append("{");
                    jsonBuilder.append("\"id\":").append(product.getId()).append(",");
                    jsonBuilder.append("\"name\":\"").append(escapeJson(product.getName())).append("\",");
                    jsonBuilder.append("\"description\":\"").append(escapeJson(product.getDescription())).append("\",");
                    jsonBuilder.append("\"price\":").append(product.getPrice() != null ? product.getPrice() : 0).append(",");
                    jsonBuilder.append("\"formattedPrice\":\"").append(formattedPrice).append("\",");
                    jsonBuilder.append("\"imageUrl\":\"").append(escapeJson(imageUrl)).append("\"");
                    jsonBuilder.append("}");
                    
                    if (i < products.size() - 1) {
                        jsonBuilder.append(",");
                    }
                }
            }
            
            jsonBuilder.append("]");
            
            System.out.println("API: Trả về JSON response thành công với " + (products != null ? products.size() : 0) + " sản phẩm");
            out.print(jsonBuilder.toString());
            
        } catch (Exception e) {
            // Debug logging
            System.err.println("API: Lỗi khi xử lý request: " + e.getMessage());
            e.printStackTrace();
            
            // Trả về error response
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            out.print("{\"error\": \"Không thể tải danh sách sản phẩm: " + escapeJson(e.getMessage()) + "\"}");
        } finally {
            out.close();
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Products API Servlet";
    }
    
    /**
     * Helper method để escape JSON string
     */
    private String escapeJson(String input) {
        if (input == null) return "";
        return input.replace("\\", "\\\\")
                    .replace("\"", "\\\"")
                    .replace("\n", "\\n")
                    .replace("\r", "\\r")
                    .replace("\t", "\\t");
    }
    
    /**
     * Format giá tiền - làm tròn lên và hiển thị .000đ
     */
    private String formatPrice(BigDecimal price) {
        if (price == null) return "0.000đ";
        
        // Làm tròn lên đến hàng nghìn
        BigDecimal roundedPrice = price.setScale(0, RoundingMode.UP);
        
        // Format với dấu phẩy ngăn cách hàng nghìn và .000đ
        String priceStr = roundedPrice.toString();
        StringBuilder formatted = new StringBuilder();
        
        for (int i = 0; i < priceStr.length(); i++) {
            if (i > 0 && (priceStr.length() - i) % 3 == 0) {
                formatted.append(".");
            }
            formatted.append(priceStr.charAt(i));
        }
        
        return formatted.toString() + ".000đ";
    }
}
