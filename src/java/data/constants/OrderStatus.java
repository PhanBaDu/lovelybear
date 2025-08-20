package data.constants;

public class OrderStatus {
    public static final String PENDING = "PENDING";
    public static final String CONFIRMED = "CONFIRMED";
    public static final String SHIPPING = "SHIPPING";
    public static final String DELIVERED = "DELIVERED";
    public static final String CANCELLED = "CANCELLED";
    
    private OrderStatus() {
        // Private constructor to prevent instantiation
    }
}
