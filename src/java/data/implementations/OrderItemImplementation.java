package data.implementations;

import data.dao.OrderItemDao;
import data.driver.DatabaseConnectionManager;
import data.models.OrderItem;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class OrderItemImplementation implements OrderItemDao {
    
    @Override
    public boolean addOrderItem(OrderItem orderItem) {
        String sql = "INSERT INTO order_items (order_id, product_id, product_name, price, quantity) VALUES (?, ?, ?, ?, ?)";
        
        Connection conn = null;
        PreparedStatement stmt = null;
        try {
            conn = DatabaseConnectionManager.getConnection();
            if (conn == null) {
                System.err.println("Không thể tạo connection database");
                return false;
            }
            
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, orderItem.getOrderId());
            stmt.setInt(2, orderItem.getProductId());
            stmt.setString(3, orderItem.getProductName());
            stmt.setBigDecimal(4, orderItem.getPrice());
            stmt.setInt(5, orderItem.getQuantity());
            
            int affectedRows = stmt.executeUpdate();
            return affectedRows > 0;
        } catch (SQLException e) {
            System.err.println("Error adding order item: " + e.getMessage());
        } finally {
            DatabaseConnectionManager.closeAll(conn, stmt, null);
        }
        return false;
    }
    
    @Override
    public List<OrderItem> getOrderItemsByOrderId(int orderId) {
        List<OrderItem> items = new ArrayList<>();
        String sql = "SELECT id, order_id, product_id, product_name, price, quantity FROM order_items WHERE order_id = ?";
        
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        try {
            conn = DatabaseConnectionManager.getConnection();
            if (conn == null) {
                System.err.println("Không thể tạo connection database");
                return items;
            }
            
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, orderId);
            rs = stmt.executeQuery();
            
            while (rs.next()) {
                OrderItem item = new OrderItem(
                    rs.getInt("id"),
                    rs.getInt("order_id"),
                    rs.getInt("product_id"),
                    rs.getString("product_name"),
                    rs.getBigDecimal("price"),
                    rs.getInt("quantity")
                );
                items.add(item);
            }
        } catch (SQLException e) {
            System.err.println("Error getting order items by order ID: " + e.getMessage());
        } finally {
            DatabaseConnectionManager.closeAll(conn, stmt, rs);
        }
        return items;
    }
    
    @Override
    public boolean deleteOrderItemsByOrderId(int orderId) {
        String sql = "DELETE FROM order_items WHERE order_id = ?";
        
        Connection conn = null;
        PreparedStatement stmt = null;
        try {
            conn = DatabaseConnectionManager.getConnection();
            if (conn == null) {
                System.err.println("Không thể tạo connection database");
                return false;
            }
            
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, orderId);
            
            int affectedRows = stmt.executeUpdate();
            return affectedRows > 0;
        } catch (SQLException e) {
            System.err.println("Error deleting order items by order ID: " + e.getMessage());
        } finally {
            DatabaseConnectionManager.closeAll(conn, stmt, null);
        }
        return false;
    }
}
