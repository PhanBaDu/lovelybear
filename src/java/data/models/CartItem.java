package data.models;

import java.math.BigDecimal;
import java.sql.Timestamp;

/**
 * Model đại diện cho sản phẩm trong giỏ hàng
 * @author PC
 */
public class CartItem {
    private int id;
    private int cartId;
    private int productId;
    private String productName;
    private String productDescription;
    private BigDecimal price;
    private int quantity;
    private Timestamp createdAt;
    private Timestamp updatedAt;
    
    // Default constructor
    public CartItem() {
    }
    
    // Constructor với thông tin cơ bản
    public CartItem(int cartId, int productId, String productName, String productDescription, BigDecimal price, int quantity) {
        this.cartId = cartId;
        this.productId = productId;
        this.productName = productName;
        this.productDescription = productDescription;
        this.price = price;
        this.quantity = quantity;
        this.createdAt = new Timestamp(System.currentTimeMillis());
        this.updatedAt = new Timestamp(System.currentTimeMillis());
    }
    
    // Constructor đầy đủ
    public CartItem(int id, int cartId, int productId, String productName, String productDescription, 
                   BigDecimal price, int quantity, Timestamp createdAt, Timestamp updatedAt) {
        this.id = id;
        this.cartId = cartId;
        this.productId = productId;
        this.productName = productName;
        this.productDescription = productDescription;
        this.price = price;
        this.quantity = quantity;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
    }
    
    // Getter and Setter methods
    public int getId() {
        return id;
    }
    
    public void setId(int id) {
        this.id = id;
    }
    
    public int getCartId() {
        return cartId;
    }
    
    public void setCartId(int cartId) {
        this.cartId = cartId;
    }
    
    public int getProductId() {
        return productId;
    }
    
    public void setProductId(int productId) {
        this.productId = productId;
    }
    
    public String getProductName() {
        return productName;
    }
    
    public void setProductName(String productName) {
        this.productName = productName;
    }
    
    public String getProductDescription() {
        return productDescription;
    }
    
    public void setProductDescription(String productDescription) {
        this.productDescription = productDescription;
    }
    
    public BigDecimal getPrice() {
        return price;
    }
    
    public void setPrice(BigDecimal price) {
        this.price = price;
    }
    
    public int getQuantity() {
        return quantity;
    }
    
    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }
    
    public Timestamp getCreatedAt() {
        return createdAt;
    }
    
    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }
    
    public Timestamp getUpdatedAt() {
        return updatedAt;
    }
    
    public void setUpdatedAt(Timestamp updatedAt) {
        this.updatedAt = updatedAt;
    }
    
    // Utility methods
    public void updateTimestamp() {
        this.updatedAt = new Timestamp(System.currentTimeMillis());
    }
    
    public BigDecimal getTotalPrice() {
        return price.multiply(BigDecimal.valueOf(quantity));
    }
    
    @Override
    public String toString() {
        return "CartItem{" + "id=" + id + ", cartId=" + cartId + ", productId=" + productId + 
               ", productName=" + productName + ", productDescription=" + productDescription + 
               ", price=" + price + ", quantity=" + quantity + ", createdAt=" + createdAt + 
               ", updatedAt=" + updatedAt + '}';
    }
}
