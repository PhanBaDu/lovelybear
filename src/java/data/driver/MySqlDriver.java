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
    private static Connection connection;

    private MySqlDriver() {
    }

    public static Connection getConnection() {
        if (connection == null) {
            try {
                Class.forName("com.mysql.cj.jdbc.Driver"); 
                connection = DriverManager.getConnection(Constants.URL, Constants.USERNAME, Constants.PASSWORD);
                System.out.println("Kết nối thành công tới database!");
            } catch (ClassNotFoundException | SQLException e) {
                System.err.println("Không thể kết nối CSDL: " + e.getMessage());
            }
        }
        return connection;
    }
}
