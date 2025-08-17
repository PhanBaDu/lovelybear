package data.driver;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * Utility class để quản lý database connection
 * @author PC
 */
public class DatabaseConnectionManager {
    
    /**
     * Tạo connection mới
     */
    public static Connection getConnection() {
        return MySqlDriver.getConnection();
    }
    
    /**
     * Đóng connection an toàn
     */
    public static void closeConnection(Connection conn) {
        if (conn != null) {
            try {
                conn.close();
            } catch (SQLException e) {
                System.err.println("Lỗi khi đóng connection: " + e.getMessage());
            }
        }
    }
    
    /**
     * Đóng PreparedStatement an toàn
     */
    public static void closePreparedStatement(PreparedStatement stmt) {
        if (stmt != null) {
            try {
                stmt.close();
            } catch (SQLException e) {
                System.err.println("Lỗi khi đóng PreparedStatement: " + e.getMessage());
            }
        }
    }
    
    /**
     * Đóng ResultSet an toàn
     */
    public static void closeResultSet(ResultSet rs) {
        if (rs != null) {
            try {
                rs.close();
            } catch (SQLException e) {
                System.err.println("Lỗi khi đóng ResultSet: " + e.getMessage());
            }
        }
    }
    
    /**
     * Đóng tất cả resources an toàn
     */
    public static void closeAll(Connection conn, PreparedStatement stmt, ResultSet rs) {
        closeResultSet(rs);
        closePreparedStatement(stmt);
        closeConnection(conn);
    }
    
    /**
     * Kiểm tra connection có hợp lệ không
     */
    public static boolean isConnectionValid(Connection conn) {
        if (conn == null) {
            return false;
        }
        try {
            return !conn.isClosed() && conn.isValid(5);
        } catch (SQLException e) {
            return false;
        }
    }
}
