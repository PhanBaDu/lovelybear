/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package data.implementations;

import data.dao.ProductDao;
import data.driver.MySqlDriver;
import data.models.Product;
import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author PC
 */
public class ProductImplementation implements ProductDao {
    Connection con = MySqlDriver.getConnection();
    
    @Override
    public Product createProduct(String name, String description, String price) {
        // Validate input parameters
        if (name == null || name.trim().isEmpty()) {
            System.err.println("Tên sản phẩm không được để trống");
            return null;
        }
        
        if (price == null || price.trim().isEmpty()) {
            System.err.println("Giá sản phẩm không được để trống");
            return null;
        }
        
        // Convert price string to BigDecimal
        BigDecimal productPrice;
        try {
            productPrice = new BigDecimal(price);
            if (productPrice.compareTo(BigDecimal.ZERO) < 0) {
                System.err.println("Giá sản phẩm không được âm");
                return null;
            }
        } catch (NumberFormatException e) {
            System.err.println("Giá sản phẩm không hợp lệ: " + price);
            return null;
        }
        
        // Check if product name already exists
        String checkSql = "SELECT 1 FROM products WHERE name = ? LIMIT 1";
        try (PreparedStatement checkPs = con.prepareStatement(checkSql)) {
            checkPs.setString(1, name.trim());
            ResultSet rs = checkPs.executeQuery();
            
            if (rs.next()) {
                System.err.println("Tên sản phẩm đã tồn tại: " + name);
                return null;
            }
        } catch (SQLException e) {
            System.err.println("Lỗi khi kiểm tra tên sản phẩm: " + e.getMessage());
            e.printStackTrace();
            return null;
        }
        
        // Insert new product
        String insertSql = "INSERT INTO products (name, description, price, created_at, updated_at) VALUES (?, ?, ?, ?, ?)";
        try (PreparedStatement insertPs = con.prepareStatement(insertSql, PreparedStatement.RETURN_GENERATED_KEYS)) {
            Timestamp currentTime = new Timestamp(System.currentTimeMillis());
            
            insertPs.setString(1, name.trim());
            insertPs.setString(2, description != null ? description.trim() : "");
            insertPs.setBigDecimal(3, productPrice);
            insertPs.setTimestamp(4, currentTime);
            insertPs.setTimestamp(5, currentTime);

            int rowsAffected = insertPs.executeUpdate();

            if (rowsAffected > 0) {
                // Get the generated ID
                ResultSet generatedKeys = insertPs.getGeneratedKeys();
                if (generatedKeys.next()) {
                    int productId = generatedKeys.getInt(1);
                    System.out.println("Tạo sản phẩm thành công: " + name + " với ID: " + productId);
                    
                    // Create and return the Product object
                    Product newProduct = new Product(productId, name.trim(), 
                        description != null ? description.trim() : "", productPrice);
                    newProduct.setCreatedAt(currentTime);
                    newProduct.setUpdatedAt(currentTime);
                    
                    return newProduct;
                } else {
                    System.err.println("Không thể lấy ID của sản phẩm vừa tạo");
                    return null;
                }
            } else {
                System.err.println("Không thể tạo sản phẩm");
                return null;
            }

        } catch (SQLException e) {
            System.err.println("Lỗi khi tạo sản phẩm: " + e.getMessage());
            e.printStackTrace();
            return null;
        }
    }
    
    @Override
    public Product getProductById(int id) {
        String sql = "SELECT id, name, description, price, created_at, updated_at FROM products WHERE id = ?";
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                int productId = rs.getInt("id");
                String name = rs.getString("name");
                String description = rs.getString("description");
                BigDecimal price = rs.getBigDecimal("price");
                Timestamp createdAt = rs.getTimestamp("created_at");
                Timestamp updatedAt = rs.getTimestamp("updated_at");

                Product product = new Product(productId, name, description, price, createdAt, updatedAt);
                System.out.println("Lấy sản phẩm thành công: " + name);
                return product;
            } else {
                System.out.println("Không tìm thấy sản phẩm với ID: " + id);
                return null;
            }
        } catch (SQLException e) {
            System.err.println("Lỗi khi lấy sản phẩm: " + e.getMessage());
            e.printStackTrace();
            return null;
        }
    }
    
    @Override
    public List<Product> getAllProducts() {
        String sql = "SELECT id, name, description, price, created_at, updated_at FROM products ORDER BY created_at DESC";
        List<Product> products = new ArrayList<>();
        
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                int productId = rs.getInt("id");
                String name = rs.getString("name");
                String description = rs.getString("description");
                BigDecimal price = rs.getBigDecimal("price");
                Timestamp createdAt = rs.getTimestamp("created_at");
                Timestamp updatedAt = rs.getTimestamp("updated_at");

                Product product = new Product(productId, name, description, price, createdAt, updatedAt);
                products.add(product);
            }
            
            System.out.println("Lấy " + products.size() + " sản phẩm thành công");
            return products;
            
        } catch (SQLException e) {
            System.err.println("Lỗi khi lấy danh sách sản phẩm: " + e.getMessage());
            e.printStackTrace();
            return new ArrayList<>();
        }
    }
    
    @Override
    public List<Product> searchProductsByName(String searchTerm) {
        if (searchTerm == null || searchTerm.trim().isEmpty()) {
            return getAllProducts();
        }
        
        String sql = "SELECT id, name, description, price, created_at, updated_at FROM products WHERE name LIKE ? ORDER BY created_at DESC";
        List<Product> products = new ArrayList<>();
        
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, "%" + searchTerm.trim() + "%");
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                int productId = rs.getInt("id");
                String name = rs.getString("name");
                String description = rs.getString("description");
                BigDecimal price = rs.getBigDecimal("price");
                Timestamp createdAt = rs.getTimestamp("created_at");
                Timestamp updatedAt = rs.getTimestamp("updated_at");

                Product product = new Product(productId, name, description, price, createdAt, updatedAt);
                products.add(product);
            }
            
            System.out.println("Tìm kiếm sản phẩm với từ khóa '" + searchTerm + "' thành công, tìm thấy " + products.size() + " sản phẩm");
            return products;
            
        } catch (SQLException e) {
            System.err.println("Lỗi khi tìm kiếm sản phẩm: " + e.getMessage());
            e.printStackTrace();
            return new ArrayList<>();
        }
    }
    
    @Override
    public boolean updateProduct(Product product) {
        if (product == null || product.getId() <= 0) {
            System.err.println("Sản phẩm không hợp lệ để cập nhật");
            return false;
        }
        
        String sql = "UPDATE products SET name = ?, description = ?, price = ?, updated_at = ? WHERE id = ?";
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            Timestamp currentTime = new Timestamp(System.currentTimeMillis());
            
            ps.setString(1, product.getName());
            ps.setString(2, product.getDescription());
            ps.setBigDecimal(3, product.getPrice());
            ps.setTimestamp(4, currentTime);
            ps.setInt(5, product.getId());

            int rowsAffected = ps.executeUpdate();

            if (rowsAffected > 0) {
                System.out.println("Cập nhật sản phẩm thành công: " + product.getName());
                return true;
            } else {
                System.out.println("Không thể cập nhật sản phẩm với ID: " + product.getId());
                return false;
            }
        } catch (SQLException e) {
            System.err.println("Lỗi khi cập nhật sản phẩm: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
    
    @Override
    public boolean deleteProduct(int id) {
        Connection conn = null;
        try {
            conn = MySqlDriver.getConnection();
            if (conn == null) {
                System.err.println("Không thể tạo connection database");
                return false;
            }
            
            // Bắt đầu transaction
            conn.setAutoCommit(false);
            
            try {
                // 1. Xóa tất cả order_items liên quan đến sản phẩm này
                String deleteOrderItemsSql = "DELETE FROM order_items WHERE product_id = ?";
                try (PreparedStatement ps = conn.prepareStatement(deleteOrderItemsSql)) {
                    ps.setInt(1, id);
                    int orderItemsDeleted = ps.executeUpdate();
                    System.out.println("Đã xóa " + orderItemsDeleted + " order_items cho sản phẩm ID: " + id);
                }
                
                // 2. Xóa tất cả product_images liên quan
                String deleteImagesSql = "DELETE FROM product_images WHERE product_id = ?";
                try (PreparedStatement ps = conn.prepareStatement(deleteImagesSql)) {
                    ps.setInt(1, id);
                    int imagesDeleted = ps.executeUpdate();
                    System.out.println("Đã xóa " + imagesDeleted + " product_images cho sản phẩm ID: " + id);
                }
                
                // 3. Xóa tất cả cart_items liên quan
                String deleteCartItemsSql = "DELETE FROM cart_items WHERE product_id = ?";
                try (PreparedStatement ps = conn.prepareStatement(deleteCartItemsSql)) {
                    ps.setInt(1, id);
                    int cartItemsDeleted = ps.executeUpdate();
                    System.out.println("Đã xóa " + cartItemsDeleted + " cart_items cho sản phẩm ID: " + id);
                }
                
                // 4. Cuối cùng xóa sản phẩm
                String deleteProductSql = "DELETE FROM products WHERE id = ?";
                try (PreparedStatement ps = conn.prepareStatement(deleteProductSql)) {
                    ps.setInt(1, id);
                    int rowsAffected = ps.executeUpdate();

                    if (rowsAffected > 0) {
                        // Commit transaction nếu tất cả thành công
                        conn.commit();
                        System.out.println("Xóa sản phẩm thành công với ID: " + id);
                        return true;
                    } else {
                        // Rollback nếu không tìm thấy sản phẩm
                        conn.rollback();
                        System.out.println("Không thể xóa sản phẩm với ID: " + id);
                        return false;
                    }
                }
                
            } catch (SQLException e) {
                // Rollback nếu có lỗi
                if (conn != null) {
                    conn.rollback();
                }
                throw e;
            } finally {
                // Reset autoCommit
                if (conn != null) {
                    conn.setAutoCommit(true);
                }
            }
            
        } catch (SQLException e) {
            System.err.println("Lỗi khi xóa sản phẩm: " + e.getMessage());
            e.printStackTrace();
            return false;
        } finally {
            // Đóng connection
            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException e) {
                    System.err.println("Lỗi khi đóng connection: " + e.getMessage());
                }
            }
        }
    }
}
