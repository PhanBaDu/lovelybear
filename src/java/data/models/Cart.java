package data.models;

import java.sql.Timestamp;

/**
 * Model đại diện cho giỏ hàng của người dùng
 * @author PC
 */
public class Cart {
    private int id;
    private String userEmail;
    private Timestamp createdAt;
    private Timestamp updatedAt;
    
    // Default constructor
    public Cart() {
    }
    
    // Constructor với user email
    public Cart(String userEmail) {
        this.userEmail = userEmail;
        this.createdAt = new Timestamp(System.currentTimeMillis());
        this.updatedAt = new Timestamp(System.currentTimeMillis());
    }
    
    // Constructor đầy đủ
    public Cart(int id, String userEmail, Timestamp createdAt, Timestamp updatedAt) {
        this.id = id;
        this.userEmail = userEmail;
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
    
    public String getUserEmail() {
        return userEmail;
    }
    
    public void setUserEmail(String userEmail) {
        this.userEmail = userEmail;
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
    
    @Override
    public String toString() {
        return "Cart{" + "id=" + id + ", userEmail=" + userEmail + 
               ", createdAt=" + createdAt + ", updatedAt=" + updatedAt + '}';
    }
}
