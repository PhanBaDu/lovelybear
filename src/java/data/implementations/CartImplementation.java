package data.implementations;

import data.dao.CartDao;
import data.driver.DatabaseConnectionManager;
import data.models.Cart;
import data.models.CartItem;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * Implementation của CartDao để thao tác với database
 * @author PC
 */
public class CartImplementation implements CartDao {
    
    @Override
    public Cart createCart(String userEmail) {
        String sql = "INSERT INTO carts (user_email, created_at, updated_at) VALUES (?, ?, ?)";
        
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        try {
            conn = DatabaseConnectionManager.getConnection();
            if (conn == null) {
                System.err.println("Không thể tạo connection database");
                return null;
            }
            
            stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            
            Timestamp now = new Timestamp(System.currentTimeMillis());
            stmt.setString(1, userEmail);
            stmt.setTimestamp(2, now);
            stmt.setTimestamp(3, now);
            
            int affectedRows = stmt.executeUpdate();
            if (affectedRows > 0) {
                rs = stmt.getGeneratedKeys();
                if (rs.next()) {
                    int cartId = rs.getInt(1);
                    return new Cart(cartId, userEmail, now, now);
                }
            }
        } catch (SQLException e) {
            System.err.println("Error creating cart: " + e.getMessage());
        } finally {
            DatabaseConnectionManager.closeAll(conn, stmt, rs);
        }
        return null;
    }
    
    @Override
    public Cart getCartByUserEmail(String userEmail) {
        String sql = "SELECT id, user_email, created_at, updated_at FROM carts WHERE user_email = ?";
        
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
            stmt.setString(1, userEmail);
            rs = stmt.executeQuery();
            
            if (rs.next()) {
                return new Cart(
                    rs.getInt("id"),
                    rs.getString("user_email"),
                    rs.getTimestamp("created_at"),
                    rs.getTimestamp("updated_at")
                );
            }
        } catch (SQLException e) {
            System.err.println("Error getting cart by user email: " + e.getMessage());
        } finally {
            DatabaseConnectionManager.closeAll(conn, stmt, rs);
        }
        return null;
    }
    
    @Override
    public Cart getCartById(int cartId) {
        String sql = "SELECT id, user_email, created_at, updated_at FROM carts WHERE id = ?";
        
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
            stmt.setInt(1, cartId);
            rs = stmt.executeQuery();
            
            if (rs.next()) {
                return new Cart(
                    rs.getInt("id"),
                    rs.getString("user_email"),
                    rs.getTimestamp("created_at"),
                    rs.getTimestamp("updated_at")
                );
            }
        } catch (SQLException e) {
            System.err.println("Error getting cart by ID: " + e.getMessage());
        } finally {
            DatabaseConnectionManager.closeAll(conn, stmt, rs);
        }
        return null;
    }
    
    @Override
    public boolean addItemToCart(CartItem cartItem) {
        // Kiểm tra xem sản phẩm đã có trong giỏ hàng chưa
        CartItem existingItem = getCartItemByProduct(cartItem.getCartId(), cartItem.getProductId());
        
        if (existingItem != null) {
            // Nếu đã có, cập nhật số lượng
            int newQuantity = existingItem.getQuantity() + cartItem.getQuantity();
            return updateItemQuantity(existingItem.getId(), newQuantity);
        } else {
            // Nếu chưa có, thêm mới
            String sql = "INSERT INTO cart_items (cart_id, product_id, product_name, product_description, price, quantity, created_at, updated_at) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
            
            Connection conn = null;
            PreparedStatement stmt = null;
            try {
                conn = DatabaseConnectionManager.getConnection();
                if (conn == null) {
                    System.err.println("Không thể tạo connection database");
                    return false;
                }
                
                stmt = conn.prepareStatement(sql);
                stmt.setInt(1, cartItem.getCartId());
                stmt.setInt(2, cartItem.getProductId());
                stmt.setString(3, cartItem.getProductName());
                stmt.setString(4, cartItem.getProductDescription());
                stmt.setBigDecimal(5, cartItem.getPrice());
                stmt.setInt(6, cartItem.getQuantity());
                stmt.setTimestamp(7, cartItem.getCreatedAt());
                stmt.setTimestamp(8, cartItem.getUpdatedAt());
                
                int affectedRows = stmt.executeUpdate();
                if (affectedRows > 0) {
                    // Cập nhật timestamp của giỏ hàng
                    updateCartTimestamp(cartItem.getCartId());
                    return true;
                }
            } catch (SQLException e) {
                System.err.println("Error adding item to cart: " + e.getMessage());
            } finally {
                DatabaseConnectionManager.closeAll(conn, stmt, null);
            }
        }
        return false;
    }
    
    @Override
    public boolean updateItemQuantity(int cartItemId, int quantity) {
        String sql = "UPDATE cart_items SET quantity = ?, updated_at = ? WHERE id = ?";
        
        Connection conn = null;
        PreparedStatement stmt = null;
        try {
            conn = DatabaseConnectionManager.getConnection();
            if (conn == null) {
                System.err.println("Không thể tạo connection database");
                return false;
            }
            
            stmt = conn.prepareStatement(sql);
            Timestamp now = new Timestamp(System.currentTimeMillis());
            stmt.setInt(1, quantity);
            stmt.setTimestamp(2, now);
            stmt.setInt(3, cartItemId);
            
            int affectedRows = stmt.executeUpdate();
            if (affectedRows > 0) {
                // Cập nhật timestamp của giỏ hàng
                updateCartTimestampByItemId(cartItemId);
                return true;
            }
        } catch (SQLException e) {
            System.err.println("Error updating item quantity: " + e.getMessage());
        } finally {
            DatabaseConnectionManager.closeAll(conn, stmt, null);
        }
        return false;
    }
    
    @Override
    public boolean removeItemFromCart(int cartItemId) {
        String sql = "DELETE FROM cart_items WHERE id = ?";
        
        Connection conn = null;
        PreparedStatement stmt = null;
        try {
            conn = DatabaseConnectionManager.getConnection();
            if (conn == null) {
                System.err.println("Không thể tạo connection database");
                return false;
            }
            
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, cartItemId);
            
            int affectedRows = stmt.executeUpdate();
            if (affectedRows > 0) {
                // Cập nhật timestamp của giỏ hàng
                updateCartTimestampByItemId(cartItemId);
                return true;
            }
        } catch (SQLException e) {
            System.err.println("Error removing item from cart: " + e.getMessage());
        } finally {
            DatabaseConnectionManager.closeAll(conn, stmt, null);
        }
        return false;
    }
    
    @Override
    public List<CartItem> getCartItems(int cartId) {
        List<CartItem> items = new ArrayList<>();
        String sql = "SELECT id, cart_id, product_id, product_name, product_description, price, quantity, created_at, updated_at FROM cart_items WHERE cart_id = ?";
        
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
            stmt.setInt(1, cartId);
            rs = stmt.executeQuery();
            
            while (rs.next()) {
                CartItem item = new CartItem(
                    rs.getInt("id"),
                    rs.getInt("cart_id"),
                    rs.getInt("product_id"),
                    rs.getString("product_name"),
                    rs.getString("product_description"),
                    rs.getBigDecimal("price"),
                    rs.getInt("quantity"),
                    rs.getTimestamp("created_at"),
                    rs.getTimestamp("updated_at")
                );
                items.add(item);
            }
        } catch (SQLException e) {
            System.err.println("Error getting cart items: " + e.getMessage());
        } finally {
            DatabaseConnectionManager.closeAll(conn, stmt, rs);
        }
        return items;
    }
    
    @Override
    public CartItem getCartItemByProduct(int cartId, int productId) {
        String sql = "SELECT id, cart_id, product_id, product_name, product_description, price, quantity, created_at, updated_at FROM cart_items WHERE cart_id = ? AND product_id = ?";
        
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
            stmt.setInt(1, cartId);
            stmt.setInt(2, productId);
            rs = stmt.executeQuery();
            
            if (rs.next()) {
                return new CartItem(
                    rs.getInt("id"),
                    rs.getInt("cart_id"),
                    rs.getInt("product_id"),
                    rs.getString("product_name"),
                    rs.getString("product_description"),
                    rs.getBigDecimal("price"),
                    rs.getInt("quantity"),
                    rs.getTimestamp("created_at"),
                    rs.getTimestamp("updated_at")
                );
            }
        } catch (SQLException e) {
            System.err.println("Error getting cart item by product: " + e.getMessage());
        } finally {
            DatabaseConnectionManager.closeAll(conn, stmt, rs);
        }
        return null;
    }
    
    @Override
    public boolean clearCart(int cartId) {
        String sql = "DELETE FROM cart_items WHERE cart_id = ?";
        
        Connection conn = null;
        PreparedStatement stmt = null;
        try {
            conn = DatabaseConnectionManager.getConnection();
            if (conn == null) {
                System.err.println("Không thể tạo connection database");
                return false;
            }
            
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, cartId);
            int affectedRows = stmt.executeUpdate();
            
            if (affectedRows > 0) {
                // Cập nhật timestamp của giỏ hàng
                updateCartTimestamp(cartId);
                return true;
            }
        } catch (SQLException e) {
            System.err.println("Error clearing cart: " + e.getMessage());
        } finally {
            DatabaseConnectionManager.closeAll(conn, stmt, null);
        }
        return false;
    }
    
    @Override
    public int getCartItemCount(int cartId) {
        String sql = "SELECT COUNT(*) FROM cart_items WHERE cart_id = ?";
        
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        try {
            conn = DatabaseConnectionManager.getConnection();
            if (conn == null) {
                System.err.println("Không thể tạo connection database");
                return 0;
            }
            
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, cartId);
            rs = stmt.executeQuery();
            
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            System.err.println("Error getting cart item count: " + e.getMessage());
        } finally {
            DatabaseConnectionManager.closeAll(conn, stmt, rs);
        }
        return 0;
    }
    
    // Helper methods
    private void updateCartTimestamp(int cartId) {
        String sql = "UPDATE carts SET updated_at = ? WHERE id = ?";
        
        Connection conn = null;
        PreparedStatement stmt = null;
        try {
            conn = DatabaseConnectionManager.getConnection();
            if (conn == null) {
                System.err.println("Không thể tạo connection database");
                return;
            }
            
            stmt = conn.prepareStatement(sql);
            Timestamp now = new Timestamp(System.currentTimeMillis());
            stmt.setTimestamp(1, now);
            stmt.setInt(2, cartId);
            stmt.executeUpdate();
        } catch (SQLException e) {
            System.err.println("Error updating cart timestamp: " + e.getMessage());
        } finally {
            DatabaseConnectionManager.closeAll(conn, stmt, null);
        }
    }
    
    private void updateCartTimestampByItemId(int cartItemId) {
        String sql = "UPDATE carts SET updated_at = ? WHERE id = (SELECT cart_id FROM cart_items WHERE id = ?)";
        
        Connection conn = null;
        PreparedStatement stmt = null;
        try {
            conn = DatabaseConnectionManager.getConnection();
            if (conn == null) {
                System.err.println("Không thể tạo connection database");
                return;
            }
            
            stmt = conn.prepareStatement(sql);
            Timestamp now = new Timestamp(System.currentTimeMillis());
            stmt.setTimestamp(1, now);
            stmt.setInt(2, cartItemId);
            stmt.executeUpdate();
        } catch (SQLException e) {
            System.err.println("Error updating cart timestamp by item ID: " + e.getMessage());
        } finally {
            DatabaseConnectionManager.closeAll(conn, stmt, null);
        }
    }
}
