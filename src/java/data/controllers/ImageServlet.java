package data.controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.nio.file.Path;
import java.nio.file.Paths;

/**
 * Servlet để phục vụ các file ảnh từ thư mục uploads
 * Map URL /uploads/* đến thư mục web/uploads trong source
 */
@WebServlet(name = "ImageServlet", urlPatterns = {"/uploads/*"})
public class ImageServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Lấy đường dẫn file từ URL (ví dụ: /users/abc.jpg)
        String imagePath = request.getPathInfo();
        if (imagePath == null || imagePath.isEmpty()) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }
        
        // Xây dựng đường dẫn tuyệt đối đến file
        String realPath = getServletContext().getRealPath("/");
        // Chuyển từ build/web về web (source) để đọc file từ thư mục source
        String sourcePath = realPath.replace("build\\web", "web").replace("build/web", "web");
        String fullPath = sourcePath + "uploads" + imagePath;
        
        File imageFile = new File(fullPath);
        
        // Kiểm tra file có tồn tại không
        if (!imageFile.exists() || !imageFile.isFile()) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Không tìm thấy ảnh: " + imagePath);
            return;
        }
        
        // Kiểm tra bảo mật: file phải nằm trong thư mục uploads
        Path uploadsPath = Paths.get(sourcePath, "uploads").toAbsolutePath().normalize();
        Path requestedPath = imageFile.toPath().toAbsolutePath().normalize();
        
        if (!requestedPath.startsWith(uploadsPath)) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "Truy cập bị từ chối");
            return;
        }
        
        // Xác định content type dựa trên extension
        String contentType = getContentType(imagePath);
        response.setContentType(contentType);
        
        // Set cache headers để tối ưu performance
        response.setHeader("Cache-Control", "public, max-age=31536000"); // Cache 1 năm
        response.setHeader("Expires", "Thu, 31 Dec 2024 23:59:59 GMT");
        
        // Gửi file ảnh về client
        try (FileInputStream fis = new FileInputStream(imageFile);
             OutputStream out = response.getOutputStream()) {
            
            byte[] buffer = new byte[4096];
            int bytesRead;
            while ((bytesRead = fis.read(buffer)) != -1) {
                out.write(buffer, 0, bytesRead);
            }
        }
    }
    
    /**
     * Xác định content type dựa trên extension của file
     * @param filePath Đường dẫn file
     * @return Content type tương ứng
     */
    private String getContentType(String filePath) {
        String extension = "";
        int lastDot = filePath.lastIndexOf('.');
        if (lastDot > 0) {
            extension = filePath.substring(lastDot + 1).toLowerCase();
        }
        
        switch (extension) {
            case "jpg":
            case "jpeg":
                return "image/jpeg";
            case "png":
                return "image/png";
            case "gif":
                return "image/gif";
            case "webp":
                return "image/webp";
            default:
                return "application/octet-stream";
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendError(HttpServletResponse.SC_METHOD_NOT_ALLOWED);
    }
}
