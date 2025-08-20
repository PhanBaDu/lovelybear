# Cấu Trúc Dự Án Lovely Bear - Hệ Thống Bán Hàng Trang Trí

## 📁 Tổng Quan Cấu Trúc Thư Mục

```
decor/
├── src/                    # Mã nguồn Java
│   ├── java/
│   │   └── data/          # Package chính chứa toàn bộ logic
│   │       ├── controllers/    # Các Servlet xử lý HTTP requests
│   │       ├── dao/            # Data Access Objects (Interface)
│   │       ├── implementations/ # Triển khai cụ thể của DAO
│   │       ├── models/         # Các model/entity classes
│   │       ├── utils/          # Tiện ích hỗ trợ
│   │       └── listeners/      # Event listeners
│   └── conf/              # Cấu hình ứng dụng
├── web/                   # Web resources (JSP, CSS, JS, Images)
│   ├── views/             # Các trang JSP chính
│   ├── components/        # Components JSP tái sử dụng
│   ├── public/            # Static resources (CSS, JS, Images)
│   └── WEB-INF/          # Cấu hình web
└── test/                  # Unit tests
```

## 🏗️ Kiến Trúc Hệ Thống

### 1. **Mô Hình MVC (Model-View-Controller)**

- **Model**: `src/java/data/models/` - Các entity classes
- **View**: `web/views/` và `web/components/` - JSP pages
- **Controller**: `src/java/data/controllers/` - Các Servlet

### 2. **Data Access Layer**

- **Interface**: `src/java/data/dao/` - Định nghĩa các phương thức truy cập dữ liệu
- **Implementation**: `src/java/data/implementations/` - Triển khai cụ thể
- **Database**: `src/java/data/dao/Database.java` - Factory class để tạo các DAO instances

## 🔄 Luồng Hoạt Động Chi Tiết - File Gọi Hàm

### **1. Luồng Đăng Nhập/Đăng Ký**

```
User → signin.jsp/signup.jsp → signInServlet/signUpServlet → UserDao → Database → Redirect
```

**Chi tiết từng bước:**

#### **Đăng Nhập:**

1. **Entry Point**: `/signin` → `signInServlet.java`
2. **Method**: `signInServlet.doPost()`
3. **Gọi hàm**: `UserDao.signIn(email, password)`
4. **Implementation**: `UserImplementation.signIn()`
5. **SQL**: `SELECT * FROM users WHERE email = ? AND password = ?`
6. **Kết quả**: Tạo session và redirect về trang chủ

#### **Đăng Ký:**

1. **Entry Point**: `/signup` → `signUpServlet.java`
2. **Method**: `signUpServlet.doPost()`
3. **Gọi hàm**: `UserDao.createUser(email, sodienthoai, fullName, pictureProfile, address, password)`
4. **Implementation**: `UserImplementation.createUser()`
5. **SQL**:
   - Kiểm tra: `SELECT 1 FROM users WHERE email = ? OR sodienthoai = ?`
   - Tạo mới: `INSERT INTO users (...) VALUES (...)`
6. **Kết quả**: Tạo user mới và redirect

### **2. Luồng Hiển Thị Sản Phẩm**

```
User → index.jsp → ProductDao.getAllProducts() → ProductImageDao → Render HTML
```

**Chi tiết từng bước:**

1. **Entry Point**: `/` → `index.jsp`
2. **JSP Code**:
   ```jsp
   ProductDao productDao = Database.getProductDao();
   List<Product> products = productDao.getAllProducts();
   ```
3. **Gọi hàm**: `ProductImplementation.getAllProducts()`
4. **SQL**: `SELECT * FROM products ORDER BY created_at DESC`
5. **Gọi hàm**: `ProductImageDao.getProductImagesByProductId(productId)`
6. **Implementation**: `ProductImageImplementation.getProductImagesByProductId()`
7. **SQL**: `SELECT * FROM product_images WHERE product_id = ?`
8. **Kết quả**: Render HTML grid sản phẩm

### **3. Luồng Tìm Kiếm Sản Phẩm**

```
User → Header Search → SearchServlet → ProductDao.searchProductsByName() → search-results.jsp
```

**Chi tiết từng bước:**

1. **Entry Point**: Search form → `/search` → `SearchServlet.java`
2. **Method**: `SearchServlet.doGet()`
3. **Gọi hàm**: `ProductDao.searchProductsByName(searchTerm)`
4. **Implementation**: `ProductImplementation.searchProductsByName()`
5. **SQL**: `SELECT * FROM products WHERE name LIKE ?`
6. **Gọi hàm**: `ProductImageDao.getProductImagesByProductId()` cho từng sản phẩm
7. **Kết quả**: Forward đến `search-results.jsp`

### **4. Luồng Thêm Sản Phẩm (Admin)**

```
Admin → addProductServlet → ProductDao.createProduct() → ProductImageDao.saveImages() → Redirect
```

**Chi tiết từng bước:**

1. **Entry Point**: `/add-product` → `addProductServlet.java`
2. **Method**: `addProductServlet.doPost()`
3. **Gọi hàm**: `ProductDao.createProduct(name, description, price)`
4. **Implementation**: `ProductImplementation.createProduct()`
5. **SQL**:
   - Kiểm tra: `SELECT 1 FROM products WHERE name = ?`
   - Tạo mới: `INSERT INTO products (name, description, price, created_at, updated_at) VALUES (...)`
6. **Gọi hàm**: `ProductImageDao.saveProductImages(productId, images)`
7. **Implementation**: `ProductImageImplementation.saveProductImages()`
8. **SQL**: `INSERT INTO product_images (product_id, image_url, created_at) VALUES (...)`
9. **Kết quả**: Redirect với thông báo thành công

### **5. Luồng Giỏ Hàng**

```
User → Add to Cart → AddToCartServlet → CartDao.addToCart() → Redirect to Cart
```

**Chi tiết từng bước:**

1. **Entry Point**: Nút "Thêm vào giỏ" → `/add-to-cart` → `AddToCartServlet.java`
2. **Method**: `AddToCartServlet.doPost()`
3. **Gọi hàm**: `ProductDao.getProductById(productId)`
4. **Implementation**: `ProductImplementation.getProductById()`
5. **SQL**: `SELECT * FROM products WHERE id = ?`
6. **Gọi hàm**: `CartDao.getCartByUserEmail(userEmail)`
7. **Implementation**: `CartImplementation.getCartByUserEmail()`
8. **SQL**: `SELECT * FROM carts WHERE user_email = ?`
9. **Gọi hàm**: `CartDao.createCart(userEmail)` (nếu chưa có cart)
10. **Gọi hàm**: `CartDao.addItemToCart(cartItem)`
11. **Implementation**: `CartImplementation.addItemToCart()`
12. **SQL**: `INSERT INTO cart_items (cart_id, product_id, product_name, description, price, quantity) VALUES (...)`
13. **Kết quả**: Trả về JSON response

### **6. Luồng Đặt Hàng**

```
User → Checkout → checkoutServlet → PlaceOrderServlet → OrderDao.createOrder() → OrderItemDao → Redirect
```

**Chi tiết từng bước:**

#### **Bước 1: Checkout**

1. **Entry Point**: `/checkout` → `checkoutServlet.java`
2. **Method**: `checkoutServlet.doPost()`
3. **Gọi hàm**: `CartDao.getCartByUserEmail(userEmail)`
4. **Implementation**: `CartImplementation.getCartByUserEmail()`
5. **Gọi hàm**: `CartDao.getCartItemById(itemId)` cho từng item
6. **Implementation**: `CartImplementation.getCartItemById()`
7. **SQL**: `SELECT * FROM cart_items WHERE id = ?`
8. **Kết quả**: Forward đến `checkout.jsp`

#### **Bước 2: Place Order**

1. **Entry Point**: Form checkout → `/place-order` → `PlaceOrderServlet.java`
2. **Method**: `PlaceOrderServlet.doPost()`
3. **Gọi hàm**: `CartDao.getCartByUserEmail(userEmail)`
4. **Gọi hàm**: `CartDao.getCartItemById(itemId)` cho từng selected item
5. **Gọi hàm**: `OrderDao.createOrder(order)`
6. **Implementation**: `OrderImplementation.createOrder()`
7. **SQL**: `INSERT INTO orders (user_email, total_quantity, total_amount, status, created_at) VALUES (...)`
8. **Gọi hàm**: `OrderItemDao.createOrderItem(orderItem)` cho từng item
9. **Implementation**: `OrderItemImplementation.createOrderItem()`
10. **SQL**: `INSERT INTO order_items (order_id, product_id, product_name, price, quantity) VALUES (...)`
11. **Gọi hàm**: `CartDao.removeCartItem(itemId)` để xóa items đã đặt
12. **Kết quả**: Redirect đến trang thành công

## 📋 Chi Tiết Các Servlet và Method Gọi

### **Authentication Controllers**

| Servlet          | URL Pattern | Method Chính | Gọi DAO Method         | Implementation Method             | SQL Query                                              |
| ---------------- | ----------- | ------------ | ---------------------- | --------------------------------- | ------------------------------------------------------ |
| `signInServlet`  | `/signin`   | `doPost()`   | `UserDao.signIn()`     | `UserImplementation.signIn()`     | `SELECT * FROM users WHERE email = ? AND password = ?` |
| `signUpServlet`  | `/signup`   | `doPost()`   | `UserDao.createUser()` | `UserImplementation.createUser()` | `INSERT INTO users (...) VALUES (...)`                 |
| `signOutServlet` | `/signout`  | `doGet()`    | Session cleanup        | -                                 | -                                                      |

### **Product Controllers**

| Servlet                | URL Pattern       | Method Chính | Gọi DAO Method                      | Implementation Method                          | SQL Query                                  |
| ---------------------- | ----------------- | ------------ | ----------------------------------- | ---------------------------------------------- | ------------------------------------------ |
| `addProductServlet`    | `/add-product`    | `doPost()`   | `ProductDao.createProduct()`        | `ProductImplementation.createProduct()`        | `INSERT INTO products (...) VALUES (...)`  |
| `ProductDetailServlet` | `/product`        | `doGet()`    | `ProductDao.getProductById()`       | `ProductImplementation.getProductById()`       | `SELECT * FROM products WHERE id = ?`      |
| `SearchServlet`        | `/search`         | `doGet()`    | `ProductDao.searchProductsByName()` | `ProductImplementation.searchProductsByName()` | `SELECT * FROM products WHERE name LIKE ?` |
| `DeleteProductServlet` | `/delete-product` | `doPost()`   | `ProductDao.deleteProduct()`        | `ProductImplementation.deleteProduct()`        | `DELETE FROM products WHERE id = ?`        |

### **Cart Controllers**

| Servlet                 | URL Pattern         | Method Chính | Gọi DAO Method                 | Implementation Method                     | SQL Query                                         |
| ----------------------- | ------------------- | ------------ | ------------------------------ | ----------------------------------------- | ------------------------------------------------- |
| `AddToCartServlet`      | `/add-to-cart`      | `doPost()`   | `CartDao.addItemToCart()`      | `CartImplementation.addItemToCart()`      | `INSERT INTO cart_items (...) VALUES (...)`       |
| `cartServlet`           | `/cart`             | `doGet()`    | `CartDao.getCartByUserEmail()` | `CartImplementation.getCartByUserEmail()` | `SELECT * FROM carts WHERE user_email = ?`        |
| `updateCartItemServlet` | `/update-cart-item` | `doPost()`   | `CartDao.updateCartItem()`     | `CartImplementation.updateCartItem()`     | `UPDATE cart_items SET quantity = ? WHERE id = ?` |
| `removeCartItemServlet` | `/remove-cart-item` | `doPost()`   | `CartDao.removeCartItem()`     | `CartImplementation.removeCartItem()`     | `DELETE FROM cart_items WHERE id = ?`             |
| `clearCartServlet`      | `/clear-cart`       | `doPost()`   | `CartDao.clearCart()`          | `CartImplementation.clearCart()`          | `DELETE FROM cart_items WHERE cart_id = ?`        |

### **Order Controllers**

| Servlet                    | URL Pattern            | Method Chính | Gọi DAO Method                    | Implementation Method                        | SQL Query                                   |
| -------------------------- | ---------------------- | ------------ | --------------------------------- | -------------------------------------------- | ------------------------------------------- |
| `checkoutServlet`          | `/checkout`            | `doPost()`   | `CartDao.getCartItemById()`       | `CartImplementation.getCartItemById()`       | `SELECT * FROM cart_items WHERE id = ?`     |
| `PlaceOrderServlet`        | `/place-order`         | `doPost()`   | `OrderDao.createOrder()`          | `OrderImplementation.createOrder()`          | `INSERT INTO orders (...) VALUES (...)`     |
| `OrdersServlet`            | `/orders`              | `doGet()`    | `OrderDao.getOrdersByUserEmail()` | `OrderImplementation.getOrdersByUserEmail()` | `SELECT * FROM orders WHERE user_email = ?` |
| `UpdateOrderStatusServlet` | `/update-order-status` | `doPost()`   | `OrderDao.updateOrderStatus()`    | `OrderImplementation.updateOrderStatus()`    | `UPDATE orders SET status = ? WHERE id = ?` |

## 🗄️ Database Layer - Chi Tiết Method

### **DAO Interfaces và Implementations**

#### **UserDao Interface** (`src/java/data/dao/UserDao.java`)

```java
public interface UserDao {
    User createUser(String email, String sodienthoai, String fullName, String pictureProfile, String address, String password);
    User signIn(String email, String password);
}
```

#### **UserImplementation** (`src/java/data/implementations/UserImplementation.java`)

- **Method**: `createUser()` → SQL: `INSERT INTO users (...) VALUES (...)`
- **Method**: `signIn()` → SQL: `SELECT * FROM users WHERE email = ? AND password = ?`

#### **ProductDao Interface** (`src/java/data/dao/ProductDao.java`)

```java
public interface ProductDao {
    Product createProduct(String name, String description, String price);
    List<Product> getAllProducts();
    Product getProductById(int id);
    List<Product> searchProductsByName(String searchTerm);
    boolean deleteProduct(int id);
}
```

#### **ProductImplementation** (`src/java/data/implementations/ProductImplementation.java`)

- **Method**: `createProduct()` → SQL: `INSERT INTO products (...) VALUES (...)`
- **Method**: `getAllProducts()` → SQL: `SELECT * FROM products ORDER BY created_at DESC`
- **Method**: `getProductById()` → SQL: `SELECT * FROM products WHERE id = ?`
- **Method**: `searchProductsByName()` → SQL: `SELECT * FROM products WHERE name LIKE ?`
- **Method**: `deleteProduct()` → SQL: `DELETE FROM products WHERE id = ?`

#### **CartDao Interface** (`src/java/data/dao/CartDao.java`)

```java
public interface CartDao {
    Cart getCartByUserEmail(String userEmail);
    Cart createCart(String userEmail);
    boolean addItemToCart(CartItem cartItem);
    boolean updateCartItem(int itemId, int quantity);
    boolean removeCartItem(int itemId);
    boolean clearCart(int cartId);
    int getCartItemCount(int cartId);
}
```

#### **CartImplementation** (`src/java/data/implementations/CartImplementation.java`)

- **Method**: `getCartByUserEmail()` → SQL: `SELECT * FROM carts WHERE user_email = ?`
- **Method**: `createCart()` → SQL: `INSERT INTO carts (user_email, created_at) VALUES (...)`
- **Method**: `addItemToCart()` → SQL: `INSERT INTO cart_items (...) VALUES (...)`
- **Method**: `updateCartItem()` → SQL: `UPDATE cart_items SET quantity = ? WHERE id = ?`
- **Method**: `removeCartItem()` → SQL: `DELETE FROM cart_items WHERE id = ?`
- **Method**: `clearCart()` → SQL: `DELETE FROM cart_items WHERE cart_id = ?`

#### **OrderDao Interface** (`src/java/data/dao/OrderDao.java`)

```java
public interface OrderDao {
    int createOrder(Order order);
    List<Order> getOrdersByUserEmail(String userEmail);
    Order getOrderById(int orderId);
    boolean updateOrderStatus(int orderId, String status);
}
```

#### **OrderImplementation** (`src/java/data/implementations/OrderImplementation.java`)

- **Method**: `createOrder()` → SQL: `INSERT INTO orders (...) VALUES (...)`
- **Method**: `getOrdersByUserEmail()` → SQL: `SELECT * FROM orders WHERE user_email = ? ORDER BY created_at DESC`
- **Method**: `getOrderById()` → SQL: `SELECT * FROM orders WHERE id = ?`
- **Method**: `updateOrderStatus()` → SQL: `UPDATE orders SET status = ? WHERE id = ?`

## 🎨 Frontend Structure

### **Main Pages** (`web/views/`)

- `index.jsp` - Trang chủ hiển thị sản phẩm
- `product-detail.jsp` - Chi tiết sản phẩm
- `cart.jsp` - Giỏ hàng
- `checkout.jsp` - Thanh toán
- `orders.jsp` - Danh sách đơn hàng
- `signin.jsp` / `signup.jsp` - Đăng nhập/đăng ký
- `admin.jsp` - Trang quản trị

### **Components** (`web/components/`)

- `header.jsp` - Header chung
- `footer.jsp` - Footer chung
- `banner.jsp` - Banner trang chủ
- `chatbot.jsp` - Chatbot hỗ trợ

### **Static Resources** (`web/public/`)

- `styles/globals.css` - CSS chính
- `js/image-upload.js` - JavaScript xử lý upload ảnh
- `images/` - Hình ảnh sản phẩm và logo
- `fonts/` - Font chữ Inter

## 🔧 Cấu Hình và Deployment

### **Build Configuration**

- `build.xml` - Ant build script
- `nbproject/` - NetBeans project configuration
- `web/META-INF/context.xml` - Database connection pool

### **Database Scripts**

- `decor_db.sql` - Schema database chính
- `lovelybear-database.sql` - Schema database backup

## 📱 Luồng Người Dùng Điển Hình

### **Khách hàng mới:**

1. Truy cập trang chủ → `index.jsp` → `ProductDao.getAllProducts()`
2. Xem sản phẩm → `ProductDetailServlet` → `ProductDao.getProductById()`
3. Đăng ký → `signUpServlet` → `UserDao.createUser()`
4. Thêm vào giỏ → `AddToCartServlet` → `CartDao.addItemToCart()`
5. Thanh toán → `checkoutServlet` → `PlaceOrderServlet` → `OrderDao.createOrder()`
6. Xem đơn hàng → `OrdersServlet` → `OrderDao.getOrdersByUserEmail()`

### **Admin:**

1. Đăng nhập → `signInServlet` → `UserDao.signIn()`
2. Quản lý sản phẩm → `addProductServlet` → `ProductDao.createProduct()`
3. Quản lý đơn hàng → `UpdateOrderStatusServlet` → `OrderDao.updateOrderStatus()`
4. Dashboard → `adminServlet` → `ProductDao.getAllProducts()` + `OrderDao.getAllOrders()`

## 🚀 Để Chạy Dự Án

1. **Setup Database**: Chạy script `decor_db.sql`
2. **Deploy**: Sử dụng NetBeans hoặc Ant build
3. **Access**: Truy cập `http://localhost:8080/decor/`

## 💡 Lưu Ý Quan Trọng

- Hệ thống sử dụng **Jakarta EE** (Servlet 6.0+)
- Database connection được quản lý qua **connection pool**
- Hỗ trợ **multipart upload** cho hình ảnh sản phẩm
- Sử dụng **session management** cho authentication
- **Responsive design** với Tailwind CSS
- **UTF-8 encoding** hỗ trợ tiếng Việt

---

_Tài liệu này giúp developer mới hiểu rõ cấu trúc và luồng hoạt động của hệ thống Lovely Bear._
