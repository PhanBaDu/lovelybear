package data.utils;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.UUID;

/**
 * Utility class để xử lý việc lưu và quản lý hình ảnh
 * Hỗ trợ lưu ảnh từ base64 vào thư mục uploads
 */
public class ImageUtils {
    
    // Đường dẫn thư mục lưu ảnh - được khởi tạo từ ServletContext
    private static String UPLOAD_BASE_PATH = null;
    private static String USERS_UPLOAD_PATH = null;
    private static String PRODUCTS_UPLOAD_PATH = null;
    
    /**
     * Khởi tạo đường dẫn upload từ ServletContext
     * Chuyển đổi từ build/web về web (source) để lưu file vào thư mục source
     * @param realPath Đường dẫn thực từ ServletContext (thường là build/web)
     */
    public static void initializePaths(String realPath) {
        // Chuyển từ build/web về web (source) để lưu file vào thư mục source
        String sourcePath = realPath.replace("build\\web", "web").replace("build/web", "web");
        UPLOAD_BASE_PATH = sourcePath + "uploads";
        USERS_UPLOAD_PATH = UPLOAD_BASE_PATH + "/users";
        PRODUCTS_UPLOAD_PATH = UPLOAD_BASE_PATH + "/products";
        
        System.out.println("ImageUtils khởi tạo thành công:");
        System.out.println("Source path: " + sourcePath);
        System.out.println("Upload paths: " + UPLOAD_BASE_PATH);
    }
    
    /**
     * Lưu ảnh profile user từ base64 vào thư mục users
     * @param base64Data Dữ liệu ảnh dạng base64
     * @param originalFileName Tên file gốc (để lấy extension)
     * @return Đường dẫn tương đối đến file đã lưu, null nếu lỗi
     */
    public static String saveUserImage(String base64Data, String originalFileName) {
        if (base64Data == null || base64Data.isEmpty()) {
            return null;
        }
        
        // Kiểm tra đường dẫn đã được khởi tạo chưa
        if (USERS_UPLOAD_PATH == null) {
            System.err.println("Lỗi: ImageUtils chưa được khởi tạo. Gọi initializePaths() trước.");
            return null;
        }
        
        try {
            // Tạo thư mục nếu chưa tồn tại
            createDirectoryIfNotExists(USERS_UPLOAD_PATH);
            
            // Tạo tên file duy nhất với UUID
            String fileExtension = getFileExtension(originalFileName);
            String uniqueFileName = generateUniqueFileName(fileExtension);
            String filePath = USERS_UPLOAD_PATH + "/" + uniqueFileName;
            
            // Decode base64 và lưu file
            byte[] imageBytes = Base64Utils.decode(base64Data);
            if (imageBytes != null) {
                try (FileOutputStream fos = new FileOutputStream(filePath)) {
                    fos.write(imageBytes);
                    System.out.println("Đã lưu ảnh user: " + uniqueFileName);
                }
                
                // Trả về đường dẫn tương đối để lưu vào database
                return "/uploads/users/" + uniqueFileName;
            }
            
        } catch (IOException e) {
            System.err.println("Lỗi khi lưu ảnh user: " + e.getMessage());
            e.printStackTrace();
        }
        
        return null;
    }
    
    /**
     * Lưu ảnh sản phẩm từ base64 vào thư mục products
     * @param base64Data Dữ liệu ảnh dạng base64
     * @param originalFileName Tên file gốc
     * @return Đường dẫn tương đối đến file đã lưu
     */
    public static String saveProductImage(String base64Data, String originalFileName) {
        if (base64Data == null || base64Data.isEmpty()) {
            return null;
        }
        
        try {
            // Tạo thư mục nếu chưa tồn tại
            createDirectoryIfNotExists(PRODUCTS_UPLOAD_PATH);
            
            // Tạo tên file duy nhất với UUID
            String fileExtension = getFileExtension(originalFileName);
            String uniqueFileName = generateUniqueFileName(fileExtension);
            String filePath = PRODUCTS_UPLOAD_PATH + "/" + uniqueFileName;
            
            // Decode base64 và lưu file
            byte[] imageBytes = Base64Utils.decode(base64Data);
            if (imageBytes != null) {
                try (FileOutputStream fos = new FileOutputStream(filePath)) {
                    fos.write(imageBytes);
                    System.out.println("Đã lưu ảnh sản phẩm: " + uniqueFileName);
                }
                
                // Trả về đường dẫn tương đối để lưu vào database
                return "/uploads/products/" + uniqueFileName;
            }
            
        } catch (IOException e) {
            System.err.println("Lỗi khi lưu ảnh sản phẩm: " + e.getMessage());
            e.printStackTrace();
        }
        
        return null;
    }
    
    /**
     * Xóa file ảnh từ đường dẫn tương đối
     * @param imagePath Đường dẫn tương đối đến file (ví dụ: /uploads/users/abc.jpg)
     * @return true nếu xóa thành công
     */
    public static boolean deleteImage(String imagePath) {
        if (imagePath == null || imagePath.isEmpty()) {
            return false;
        }
        
        try {
            // Chuyển đường dẫn tương đối thành đường dẫn tuyệt đối
            String absolutePath = UPLOAD_BASE_PATH + imagePath;
            File file = new File(absolutePath);
            
            if (file.exists()) {
                return file.delete();
            }
        } catch (Exception e) {
            System.err.println("Lỗi khi xóa ảnh: " + e.getMessage());
            e.printStackTrace();
        }
        
        return false;
    }
    
    /**
     * Kiểm tra xem file ảnh có tồn tại không
     * @param imagePath Đường dẫn tương đối đến file
     * @return true nếu file tồn tại
     */
    public static boolean imageExists(String imagePath) {
        if (imagePath == null || imagePath.isEmpty()) {
            return false;
        }
        
        String absolutePath = UPLOAD_BASE_PATH + imagePath;
        File file = new File(absolutePath);
        return file.exists();
    }
    
    /**
     * Tạo thư mục nếu chưa tồn tại
     * @param directoryPath Đường dẫn thư mục cần tạo
     * @throws IOException Nếu không thể tạo thư mục
     */
    private static void createDirectoryIfNotExists(String directoryPath) throws IOException {
        Path path = Paths.get(directoryPath);
        if (!Files.exists(path)) {
            Files.createDirectories(path);
        }
    }
    
    /**
     * Lấy extension từ tên file
     * @param fileName Tên file gốc
     * @return Extension của file (mặc định là jpg)
     */
    private static String getFileExtension(String fileName) {
        if (fileName == null || fileName.isEmpty()) {
            return "jpg"; // Extension mặc định
        }
        
        int lastDotIndex = fileName.lastIndexOf('.');
        if (lastDotIndex > 0 && lastDotIndex < fileName.length() - 1) {
            return fileName.substring(lastDotIndex + 1).toLowerCase();
        }
        
        return "jpg"; // Extension mặc định
    }
    
    /**
     * Tạo tên file duy nhất với UUID
     * @param extension Extension của file
     * @return Tên file duy nhất (UUID + extension)
     */
    private static String generateUniqueFileName(String extension) {
        String uuid = UUID.randomUUID().toString();
        return uuid + "." + extension;
    }
}
