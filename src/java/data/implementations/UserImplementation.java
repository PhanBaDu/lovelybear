/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package data.implementations;
import data.dao.UserDao;
import data.driver.MySqlDriver;
import data.models.User;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

/**
 *
 * @author PC
 */
public class UserImplementation implements UserDao {
    Connection con = MySqlDriver.getConnection();
    
    @Override
    public User createUser(String email, String sodienthoai, String fullName, String pictureProfile, String address, String password) {
        // Kiểm tra email và số điện thoại đã tồn tại chưa
        String checkSql = "SELECT email, sodienthoai FROM users WHERE email = ? OR sodienthoai = ?";
        try (PreparedStatement ps = con.prepareStatement(checkSql)) {
            ps.setString(1, email);
            ps.setString(2, sodienthoai);

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                String existingEmail = rs.getString("email");
                String existingSdt = rs.getString("sodienthoai");

                if (email.equals(existingEmail)) {
                    System.out.println("Email đã tồn tại: " + email);
                    return null; 
                }
                if (sodienthoai.equals(existingSdt)) {
                    System.out.println("Số điện thoại đã tồn tại: " + sodienthoai);
                    return null; 
                }
            }
        } catch (SQLException e) {
            System.err.println("Lỗi khi kiểm tra user tồn tại: " + e.getMessage());
            e.printStackTrace();
            return null;
        }
        
        // Tạo user mới
        String insertSql = "INSERT INTO users (email, sodienthoai, fullName, pictureProfile, address, password) VALUES (?, ?, ?, ?, ?, ?)";
        try (PreparedStatement insertPs = con.prepareStatement(insertSql)) {
            insertPs.setString(1, email);
            insertPs.setString(2, sodienthoai);
            insertPs.setString(3, fullName);
            insertPs.setString(4, pictureProfile);
            insertPs.setString(5, address);
            insertPs.setString(6, password);

            int rowsAffected = insertPs.executeUpdate();

            if (rowsAffected > 0) {
                System.out.println("Tạo user thành công: " + email);
                return new User(email, sodienthoai, fullName, pictureProfile, address);
            } else {
                System.out.println("Không thể tạo user");
                return null;
            }

        } catch (SQLException e) {
            System.err.println("Lỗi khi tạo user: " + e.getMessage());
            e.printStackTrace();
            return null;
        }
    }
    
    // Thêm method để kiểm tra user tồn tại và trả về thông tin chi tiết
    public Map<String, Object> checkUserExists(String email, String phoneNumber) {
        Map<String, Object> result = new HashMap<>();
        result.put("exists", false);
        result.put("emailExists", false);
        result.put("phoneExists", false);
        result.put("message", "");
        
        String checkSql = "SELECT email, sodienthoai FROM users WHERE email = ? OR sodienthoai = ?";
        try (PreparedStatement ps = con.prepareStatement(checkSql)) {
            ps.setString(1, email);
            ps.setString(2, phoneNumber);

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                String existingEmail = rs.getString("email");
                String existingSdt = rs.getString("sodienthoai");

                if (email.equals(existingEmail)) {
                    result.put("emailExists", true);
                    result.put("exists", true);
                }
                if (phoneNumber.equals(existingSdt)) {
                    result.put("phoneExists", true);
                    result.put("exists", true);
                }
            }
            
            // Tạo message lỗi
            if ((Boolean) result.get("emailExists") && (Boolean) result.get("phoneExists")) {
                result.put("message", "Email và số điện thoại đã tồn tại trong hệ thống");
            } else if ((Boolean) result.get("emailExists")) {
                result.put("message", "Email đã tồn tại trong hệ thống");
            } else if ((Boolean) result.get("phoneExists")) {
                result.put("message", "Số điện thoại đã tồn tại trong hệ thống");
            }
            
        } catch (SQLException e) {
            System.err.println("Lỗi khi kiểm tra user tồn tại: " + e.getMessage());
            result.put("error", "Lỗi hệ thống khi kiểm tra thông tin");
        }
        
        return result;
    }
}
