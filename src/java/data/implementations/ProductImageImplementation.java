/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package data.implementations;

import data.dao.ProductImageDao;
import data.driver.MySqlDriver;
import data.models.ProductImage;
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
public class ProductImageImplementation implements ProductImageDao {
    Connection con = MySqlDriver.getConnection();
    
    @Override
    public ProductImage createProductImage(int productId, String imageUrl) {
        // Validate input parameters
        if (productId <= 0) {
            System.err.println("ID sản phẩm không hợp lệ: " + productId);
            return null;
        }
        
        if (imageUrl == null || imageUrl.trim().isEmpty()) {
            System.err.println("URL hình ảnh không được để trống");
            return null;
        }
        
        // Check if product exists (optional validation)
        String checkProductSql = "SELECT 1 FROM products WHERE id = ? LIMIT 1";
        try (PreparedStatement checkPs = con.prepareStatement(checkProductSql)) {
            checkPs.setInt(1, productId);
            ResultSet rs = checkPs.executeQuery();
            
            if (!rs.next()) {
                System.err.println("Không tìm thấy sản phẩm với ID: " + productId);
                return null;
            }
        } catch (SQLException e) {
            System.err.println("Lỗi khi kiểm tra sản phẩm: " + e.getMessage());
            e.printStackTrace();
            return null;
        }
        
        // Insert new product image
        String insertSql = "INSERT INTO product_images (product_id, image_url, created_at) VALUES (?, ?, ?)";
        try (PreparedStatement insertPs = con.prepareStatement(insertSql, PreparedStatement.RETURN_GENERATED_KEYS)) {
            Timestamp currentTime = new Timestamp(System.currentTimeMillis());
            
            insertPs.setInt(1, productId);
            insertPs.setString(2, imageUrl.trim());
            insertPs.setTimestamp(3, currentTime);

            int rowsAffected = insertPs.executeUpdate();

            if (rowsAffected > 0) {
                // Get the generated ID
                ResultSet generatedKeys = insertPs.getGeneratedKeys();
                if (generatedKeys.next()) {
                    int imageId = generatedKeys.getInt(1);
                    System.out.println("Tạo hình ảnh sản phẩm thành công với ID: " + imageId + " cho sản phẩm: " + productId);
                    
                    // Create and return the ProductImage object
                    ProductImage newImage = new ProductImage(imageId, productId, imageUrl.trim());
                    newImage.setCreatedAt(currentTime);
                    
                    return newImage;
                } else {
                    System.err.println("Không thể lấy ID của hình ảnh vừa tạo");
                    return null;
                }
            } else {
                System.err.println("Không thể tạo hình ảnh sản phẩm");
                return null;
            }

        } catch (SQLException e) {
            System.err.println("Lỗi khi tạo hình ảnh sản phẩm: " + e.getMessage());
            e.printStackTrace();
            return null;
        }
    }
    
    @Override
    public ProductImage getProductImageById(int id) {
        String sql = "SELECT id, product_id, image_url, created_at FROM product_images WHERE id = ?";
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                int imageId = rs.getInt("id");
                int productId = rs.getInt("product_id");
                String imageUrl = rs.getString("image_url");
                Timestamp createdAt = rs.getTimestamp("created_at");

                ProductImage productImage = new ProductImage(imageId, productId, imageUrl, createdAt);
                System.out.println("Lấy hình ảnh sản phẩm thành công với ID: " + id);
                return productImage;
            } else {
                System.out.println("Không tìm thấy hình ảnh sản phẩm với ID: " + id);
                return null;
            }
        } catch (SQLException e) {
            System.err.println("Lỗi khi lấy hình ảnh sản phẩm: " + e.getMessage());
            e.printStackTrace();
            return null;
        }
    }
    
    @Override
    public List<ProductImage> getProductImagesByProductId(int productId) {
        String sql = "SELECT id, product_id, image_url, created_at FROM product_images WHERE product_id = ? ORDER BY created_at ASC";
        List<ProductImage> images = new ArrayList<>();
        
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, productId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                int imageId = rs.getInt("id");
                int prodId = rs.getInt("product_id");
                String imageUrl = rs.getString("image_url");
                Timestamp createdAt = rs.getTimestamp("created_at");

                ProductImage productImage = new ProductImage(imageId, prodId, imageUrl, createdAt);
                images.add(productImage);
            }
            
            System.out.println("Lấy " + images.size() + " hình ảnh cho sản phẩm với ID: " + productId);
            return images;
            
        } catch (SQLException e) {
            System.err.println("Lỗi khi lấy hình ảnh sản phẩm: " + e.getMessage());
            e.printStackTrace();
            return new ArrayList<>();
        }
    }
    
    @Override
    public boolean updateProductImage(ProductImage productImage) {
        if (productImage == null || productImage.getId() <= 0) {
            System.err.println("Hình ảnh sản phẩm không hợp lệ để cập nhật");
            return false;
        }
        
        String sql = "UPDATE product_images SET product_id = ?, image_url = ? WHERE id = ?";
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, productImage.getProductId());
            ps.setString(2, productImage.getImageUrl());
            ps.setInt(3, productImage.getId());

            int rowsAffected = ps.executeUpdate();

            if (rowsAffected > 0) {
                System.out.println("Cập nhật hình ảnh sản phẩm thành công với ID: " + productImage.getId());
                return true;
            } else {
                System.out.println("Không thể cập nhật hình ảnh sản phẩm với ID: " + productImage.getId());
                return false;
            }
        } catch (SQLException e) {
            System.err.println("Lỗi khi cập nhật hình ảnh sản phẩm: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
    
    @Override
    public boolean deleteProductImage(int id) {
        String sql = "DELETE FROM product_images WHERE id = ?";
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);

            int rowsAffected = ps.executeUpdate();

            if (rowsAffected > 0) {
                System.out.println("Xóa hình ảnh sản phẩm thành công với ID: " + id);
                return true;
            } else {
                System.out.println("Không thể xóa hình ảnh sản phẩm với ID: " + id);
                return false;
            }
        } catch (SQLException e) {
            System.err.println("Lỗi khi xóa hình ảnh sản phẩm: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
    
    @Override
    public boolean deleteProductImagesByProductId(int productId) {
        String sql = "DELETE FROM product_images WHERE product_id = ?";
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, productId);

            int rowsAffected = ps.executeUpdate();

            if (rowsAffected > 0) {
                System.out.println("Xóa " + rowsAffected + " hình ảnh cho sản phẩm với ID: " + productId);
                return true;
            } else {
                System.out.println("Không có hình ảnh nào để xóa cho sản phẩm với ID: " + productId);
                return true; // Return true as no images to delete is not an error
            }
        } catch (SQLException e) {
            System.err.println("Lỗi khi xóa hình ảnh sản phẩm: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
}
