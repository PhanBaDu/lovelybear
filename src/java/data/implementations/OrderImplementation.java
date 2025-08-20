package data.implementations;

import data.dao.OrderDao;
import data.driver.DatabaseConnectionManager;
import data.models.Order;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.math.BigDecimal;
import java.sql.Timestamp;

public class OrderImplementation implements OrderDao {
    
    @Override
    public int createOrder(Order order) {
        String sql = "INSERT INTO orders (user_email, order_date, total_quantity, total_amount, status) VALUES (?, ?, ?, ?, ?)";
        
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        try {
            conn = DatabaseConnectionManager.getConnection();
            if (conn == null) {
                System.err.println("Không thể tạo connection database");
                return -1;
            }
            
            stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            
            Timestamp now = new Timestamp(System.currentTimeMillis());
            stmt.setString(1, order.getUserEmail());
            stmt.setTimestamp(2, now);
            stmt.setInt(3, order.getTotalQuantity());
            stmt.setBigDecimal(4, order.getTotalAmount());
            stmt.setString(5, order.getStatus());
            
            int affectedRows = stmt.executeUpdate();
            if (affectedRows > 0) {
                rs = stmt.getGeneratedKeys();
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        } catch (SQLException e) {
            System.err.println("Error creating order: " + e.getMessage());
        } finally {
            DatabaseConnectionManager.closeAll(conn, stmt, rs);
        }
        return -1;
    }
    
    @Override
    public Order getOrderById(int orderId) {
        String sql = "SELECT id, user_email, order_date, total_quantity, total_amount, status FROM orders WHERE id = ?";
        
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        try {
            conn = DatabaseConnectionManager.getConnection();
            if (conn == null) {
                System.err.println("Không thể tạo connection database");
                return null;
            }
            
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, orderId);
            rs = stmt.executeQuery();
            
            if (rs.next()) {
                return new Order(
                    rs.getInt("id"),
                    rs.getString("user_email"),
                    rs.getTimestamp("order_date"),
                    rs.getInt("total_quantity"),
                    rs.getBigDecimal("total_amount"),
                    rs.getString("status")
                );
            }
        } catch (SQLException e) {
            System.err.println("Error getting order by ID: " + e.getMessage());
        } finally {
            DatabaseConnectionManager.closeAll(conn, stmt, rs);
        }
        return null;
    }
    
    @Override
    public List<Order> getOrdersByUserEmail(String userEmail) {
        List<Order> orders = new ArrayList<>();
        String sql = "SELECT id, user_email, order_date, total_quantity, total_amount, status FROM orders WHERE user_email = ? ORDER BY order_date DESC";
        
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        try {
            conn = DatabaseConnectionManager.getConnection();
            if (conn == null) {
                System.err.println("Không thể tạo connection database");
                return orders;
            }
            
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, userEmail);
            rs = stmt.executeQuery();
            
            while (rs.next()) {
                Order order = new Order(
                    rs.getInt("id"),
                    rs.getString("user_email"),
                    rs.getTimestamp("order_date"),
                    rs.getInt("total_quantity"),
                    rs.getBigDecimal("total_amount"),
                    rs.getString("status")
                );
                orders.add(order);
            }
        } catch (SQLException e) {
            System.err.println("Error getting orders by user email: " + e.getMessage());
        } finally {
            DatabaseConnectionManager.closeAll(conn, stmt, rs);
        }
        return orders;
    }
    
    @Override
    public boolean updateOrderStatus(int orderId, String status) {
        String sql = "UPDATE orders SET status = ? WHERE id = ?";
        
        Connection conn = null;
        PreparedStatement stmt = null;
        try {
            conn = DatabaseConnectionManager.getConnection();
            if (conn == null) {
                System.err.println("Không thể tạo connection database");
                return false;
            }
            
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, status);
            stmt.setInt(2, orderId);
            
            int affectedRows = stmt.executeUpdate();
            return affectedRows > 0;
        } catch (SQLException e) {
            System.err.println("Error updating order status: " + e.getMessage());
        } finally {
            DatabaseConnectionManager.closeAll(conn, stmt, null);
        }
        return false;
    }
    
    @Override
    public List<Order> getAllOrders() {
        List<Order> orders = new ArrayList<>();
        String sql = "SELECT id, user_email, order_date, total_quantity, total_amount, status FROM orders ORDER BY order_date DESC";
        
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        try {
            conn = DatabaseConnectionManager.getConnection();
            if (conn == null) {
                System.err.println("Không thể tạo connection database");
                return orders;
            }
            
            stmt = conn.prepareStatement(sql);
            rs = stmt.executeQuery();
            
            while (rs.next()) {
                Order order = new Order(
                    rs.getInt("id"),
                    rs.getString("user_email"),
                    rs.getTimestamp("order_date"),
                    rs.getInt("total_quantity"),
                    rs.getBigDecimal("total_amount"),
                    rs.getString("status")
                );
                orders.add(order);
            }
            
            System.out.println("Lấy " + orders.size() + " đơn hàng thành công");
        } catch (SQLException e) {
            System.err.println("Lỗi khi lấy danh sách đơn hàng: " + e.getMessage());
        } finally {
            DatabaseConnectionManager.closeAll(conn, stmt, rs);
        }
        return orders;
    }
}
