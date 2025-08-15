/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package data.models;

import java.sql.Timestamp;

/**
 *
 * @author PC
 */
public class ProductImage {
    private int id;
    private int productId;
    private String imageUrl;
    private Timestamp createdAt;
    
    // Default constructor
    public ProductImage() {
    }
    
    // Constructor with all parameters
    public ProductImage(int id, int productId, String imageUrl, Timestamp createdAt) {
        this.id = id;
        this.productId = productId;
        this.imageUrl = imageUrl;
        this.createdAt = createdAt;
    }
    
    // Constructor without id (for creating new product images)
    public ProductImage(int productId, String imageUrl) {
        this.productId = productId;
        this.imageUrl = imageUrl;
        this.createdAt = new Timestamp(System.currentTimeMillis());
    }
    
    // Constructor without timestamp (for backward compatibility)
    public ProductImage(int id, int productId, String imageUrl) {
        this.id = id;
        this.productId = productId;
        this.imageUrl = imageUrl;
        this.createdAt = new Timestamp(System.currentTimeMillis());
    }
    
    // Getter and Setter methods
    public int getId() {
        return id;
    }
    
    public void setId(int id) {
        this.id = id;
    }
    
    public int getProductId() {
        return productId;
    }
    
    public void setProductId(int productId) {
        this.productId = productId;
    }
    
    public String getImageUrl() {
        return imageUrl;
    }
    
    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }
    
    public Timestamp getCreatedAt() {
        return createdAt;
    }
    
    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }
    
    // Utility methods
    public boolean isValidImageUrl() {
        return imageUrl != null && !imageUrl.trim().isEmpty();
    }
    
    public String getImageFileName() {
        if (imageUrl == null || imageUrl.isEmpty()) {
            return "";
        }
        int lastSlashIndex = imageUrl.lastIndexOf('/');
        if (lastSlashIndex != -1 && lastSlashIndex < imageUrl.length() - 1) {
            return imageUrl.substring(lastSlashIndex + 1);
        }
        return imageUrl;
    }
    
    @Override
    public String toString() {
        return "ProductImage{" + "id=" + id + ", productId=" + productId + 
               ", imageUrl=" + imageUrl + ", createdAt=" + createdAt + '}';
    }
}
