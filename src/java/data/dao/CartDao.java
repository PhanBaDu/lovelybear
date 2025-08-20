package data.dao;

import data.models.Cart;
import data.models.CartItem;
import java.util.List;

/**
 * Interface định nghĩa các phương thức thao tác với giỏ hàng
 * @author PC
 */
public interface CartDao {
    
    /**
     * Tạo giỏ hàng mới cho người dùng
     * @param userEmail Email của người dùng
     * @return Cart object đã được tạo
     */
    Cart createCart(String userEmail);
    
    /**
     * Lấy giỏ hàng của người dùng
     * @param userEmail Email của người dùng
     * @return Cart object hoặc null nếu không tìm thấy
     */
    Cart getCartByUserEmail(String userEmail);
    
    /**
     * Lấy giỏ hàng theo ID
     * @param cartId ID của giỏ hàng
     * @return Cart object hoặc null nếu không tìm thấy
     */
    Cart getCartById(int cartId);
    
    /**
     * Thêm sản phẩm vào giỏ hàng
     * @param cartItem Sản phẩm cần thêm
     * @return true nếu thêm thành công, false nếu thất bại
     */
    boolean addItemToCart(CartItem cartItem);
    
    /**
     * Cập nhật số lượng sản phẩm trong giỏ hàng
     * @param cartItemId ID của item trong giỏ hàng
     * @param quantity Số lượng mới
     * @return true nếu cập nhật thành công, false nếu thất bại
     */
    boolean updateItemQuantity(int cartItemId, int quantity);
    
    /**
     * Xóa sản phẩm khỏi giỏ hàng
     * @param cartItemId ID của item cần xóa
     * @return true nếu xóa thành công, false nếu thất bại
     */
    boolean removeItemFromCart(int cartItemId);
    
    /**
     * Lấy tất cả sản phẩm trong giỏ hàng
     * @param cartId ID của giỏ hàng
     * @return Danh sách các sản phẩm trong giỏ hàng
     */
    List<CartItem> getCartItems(int cartId);
    
    /**
     * Kiểm tra xem sản phẩm đã có trong giỏ hàng chưa
     * @param cartId ID của giỏ hàng
     * @param productId ID của sản phẩm
     * @return CartItem nếu đã có, null nếu chưa có
     */
    CartItem getCartItemByProduct(int cartId, int productId);
    
    /**
     * Xóa toàn bộ giỏ hàng
     * @param cartId ID của giỏ hàng
     * @return true nếu xóa thành công, false nếu thất bại
     */
    boolean clearCart(int cartId);
    
    /**
     * Lấy tổng số sản phẩm trong giỏ hàng
     * @param cartId ID của giỏ hàng
     * @return Tổng số sản phẩm
     */
    int getCartItemCount(int cartId);
    
    /**
     * Lấy CartItem theo ID
     * @param cartItemId ID của CartItem
     * @return CartItem object hoặc null nếu không tìm thấy
     */
    CartItem getCartItemById(int cartItemId);
}
