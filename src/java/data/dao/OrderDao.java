package data.dao;

import data.models.Order;
import java.util.List;

public interface OrderDao {
    
    /**
     * Tạo đơn hàng mới
     * @param order Thông tin đơn hàng
     * @return ID của đơn hàng đã tạo, -1 nếu thất bại
     */
    int createOrder(Order order);
    
    /**
     * Lấy đơn hàng theo ID
     * @param orderId ID của đơn hàng
     * @return Order object hoặc null nếu không tìm thấy
     */
    Order getOrderById(int orderId);
    
    /**
     * Lấy tất cả đơn hàng của người dùng
     * @param userEmail Email của người dùng
     * @return Danh sách đơn hàng
     */
    List<Order> getOrdersByUserEmail(String userEmail);
    
    /**
     * Cập nhật trạng thái đơn hàng
     * @param orderId ID của đơn hàng
     * @param status Trạng thái mới
     * @return true nếu cập nhật thành công, false nếu thất bại
     */
    boolean updateOrderStatus(int orderId, String status);
    List<Order> getAllOrders();
}
