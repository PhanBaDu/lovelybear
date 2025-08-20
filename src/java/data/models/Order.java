package data.models;

import data.constants.OrderStatus;
import java.math.BigDecimal;
import java.sql.Timestamp;

public class Order {
    private int id;
    private String userEmail;
    private Timestamp orderDate;
    private int totalQuantity;
    private BigDecimal totalAmount;
    private String status;
    
    // Constructor mặc định
    public Order() {}
    
    // Constructor đầy đủ
    public Order(int id, String userEmail, Timestamp orderDate, int totalQuantity, BigDecimal totalAmount, String status) {
        this.id = id;
        this.userEmail = userEmail;
        this.orderDate = orderDate;
        this.totalQuantity = totalQuantity;
        this.totalAmount = totalAmount;
        this.status = status;
    }
    
    // Constructor không có ID (để tạo mới)
    public Order(String userEmail, int totalQuantity, BigDecimal totalAmount) {
        this.userEmail = userEmail;
        this.totalQuantity = totalQuantity;
        this.totalAmount = totalAmount;
        this.status = OrderStatus.PENDING;
    }
    
    // Getters và Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    
    public String getUserEmail() { return userEmail; }
    public void setUserEmail(String userEmail) { this.userEmail = userEmail; }
    
    public Timestamp getOrderDate() { return orderDate; }
    public void setOrderDate(Timestamp orderDate) { this.orderDate = orderDate; }
    
    public int getTotalQuantity() { return totalQuantity; }
    public void setTotalQuantity(int totalQuantity) { this.totalQuantity = totalQuantity; }
    
    public BigDecimal getTotalAmount() { return totalAmount; }
    public void setTotalAmount(BigDecimal totalAmount) { this.totalAmount = totalAmount; }
    
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
}
