package data.driver;

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

/**
 *
 * @author PC
 */

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import data.constants.Constants;

public class MySqlDriver {
    
    private MySqlDriver() {
    }

    /**
     * Tạo connection mới mỗi lần gọi
     * Điều này đảm bảo connection luôn hoạt động
     */
    public static Connection getConnection() {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver"); 
            Connection connection = DriverManager.getConnection(Constants.URL, Constants.USERNAME, Constants.PASSWORD);
            System.out.println("Tạo connection mới thành công!");
            return connection;
        } catch (ClassNotFoundException | SQLException e) {
            System.err.println("Không thể kết nối CSDL: " + e.getMessage());
            return null;
        }
    }
    
    /**
     * Kiểm tra connection có hoạt động không
     */
    public static boolean isConnectionValid(Connection connection) {
        if (connection == null) {
            return false;
        }
        try {
            return !connection.isClosed() && connection.isValid(5); // timeout 5 giây
        } catch (SQLException e) {
            return false;
        }
    }
}
