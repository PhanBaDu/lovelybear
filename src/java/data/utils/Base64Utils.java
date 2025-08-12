package data.utils;

import java.util.Base64;

public class Base64Utils {
    
    /**
     * Chuyển đổi byte array thành chuỗi base64
     * @param bytes byte array cần chuyển đổi
     * @return Chuỗi base64
     */
    public static String encode(byte[] bytes) {
        if (bytes == null || bytes.length == 0) {
            return null;
        }
        return Base64.getEncoder().encodeToString(bytes);
    }
    
    /**
     * Chuyển đổi chuỗi base64 thành byte array
     * @param base64String chuỗi base64
     * @return byte array
     */
    public static byte[] decode(String base64String) {
        if (base64String == null || base64String.isEmpty()) {
            return null;
        }
        return Base64.getDecoder().decode(base64String);
    }
    
    /**
     * Tạo data URL cho ảnh từ base64 string
     * @param base64String chuỗi base64
     * @param mimeType loại MIME (ví dụ: "image/jpeg", "image/png")
     * @return data URL
     */
    public static String createDataUrl(String base64String, String mimeType) {
        if (base64String == null || base64String.isEmpty()) {
            return null;
        }
        return "data:" + mimeType + ";base64," + base64String;
    }
}
