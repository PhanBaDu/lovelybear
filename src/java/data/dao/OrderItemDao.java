package data.dao;

import data.models.OrderItem;
import java.util.List;

public interface OrderItemDao {
    
    /**
     * Thêm item vào đơn hàng
     * @param orderItem Thông tin item
     * @return true nếu thêm thành công, false nếu thất bại
     */
    boolean addOrderItem(OrderItem orderItem);
    
    /**
     * Lấy tất cả items của một đơn hàng
     * @param orderId ID của đơn hàng
     * @return Danh sách items
     */
    List<OrderItem> getOrderItemsByOrderId(int orderId);
    
    /**
     * Xóa tất cả items của một đơn hàng
     * @param orderId ID của đơn hàng
     * @return true nếu xóa thành công, false nếu thất bại
     */
    boolean deleteOrderItemsByOrderId(int orderId);
}
