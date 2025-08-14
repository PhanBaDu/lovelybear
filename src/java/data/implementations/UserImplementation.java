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
/**
 *
 * @author PC
 */
public class UserImplementation implements UserDao {
    Connection con = MySqlDriver.getConnection();
    
    @Override
    public User createUser(String email, String sodienthoai, String fullName, String pictureProfile, String address, String password) {
        // b1: kiem tra email / sdt ton tai chua
        String sql = "SELECT 1 FROM users WHERE email = ? OR sodienthoai = ? LIMIT 1";
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, email);
            ps.setString(2, sodienthoai);

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                // Có thông tin trùng lặp
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
            e.printStackTrace();
        }
        
        // b2: 
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
}
