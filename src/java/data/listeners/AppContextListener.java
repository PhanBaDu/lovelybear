package data.listeners;

import data.utils.ImageUtils;
import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;

/**
 * Servlet Context Listener để khởi tạo các thành phần cần thiết khi ứng dụng khởi động
 * Được gọi tự động khi web app start/stop
 */
@WebListener
public class AppContextListener implements ServletContextListener {

    /**
     * Được gọi khi ứng dụng web khởi động
     * Khởi tạo ImageUtils với đường dẫn upload
     */
    @Override
    public void contextInitialized(ServletContextEvent sce) {
        System.out.println("=== Ứng dụng Decor đang khởi động ===");
        
        // Khởi tạo đường dẫn upload cho ImageUtils
        String realPath = sce.getServletContext().getRealPath("/");
        ImageUtils.initializePaths(realPath);
        
        System.out.println("=== Khởi tạo hoàn tất ===");
    }

    /**
     * Được gọi khi ứng dụng web tắt
     * Dọn dẹp tài nguyên nếu cần
     */
    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        System.out.println("=== Ứng dụng Decor đang tắt ===");
    }
}
