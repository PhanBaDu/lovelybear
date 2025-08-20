# HỆ THỐNG E-COMMERCE - TÀI LIỆU CHI TIẾT

## 📋 TỔNG QUAN HỆ THỐNG

Hệ thống e-commerce được xây dựng bằng Java Servlet, JSP với kiến trúc MVC. Sử dụng MySQL làm cơ sở dữ liệu và Tailwind CSS cho giao diện.

---

## 🏗️ KIẾN TRÚC HỆ THỐNG

### Cấu trúc thư mục:

```
decor/
├── src/java/data/
│   ├── controllers/     # Servlet xử lý request
│   ├── dao/            # Data Access Object
│   ├── implementations/ # Implementation của DAO
│   ├── models/         # Entity classes
│   ├── utils/          # Utility classes
│   └── listeners/      # Event listeners
├── web/
│   ├── views/          # JSP pages
│   ├── components/     # Reusable JSP components
│   ├── public/         # Static resources
│   └── WEB-INF/        # Configuration files
└── test/               # Test files
```

---

## 🔐 CHỨC NĂNG XÁC THỰC (AUTHENTICATION)

### 1. Đăng ký tài khoản (Sign Up)

**Files liên quan:**

- `web/views/signup.jsp` - Giao diện đăng ký
- `src/java/data/controllers/signUpServlet.java` - Xử lý đăng ký
- `src/java/data/dao/UserDao.java` - Interface quản lý user
- `src/java/data/implementations/UserImplementation.java` - Implementation
- `src/java/data/models/User.java` - Model User

**Flow hoạt động:**

1. User nhập thông tin → `signup.jsp`
2. Submit form → `signUpServlet.doPost()`
3. Validate dữ liệu → Kiểm tra email tồn tại
4. Hash password → `Base64Utils.encode()`
5. Lưu user → `UserImplementation.createUser()`
6. Redirect → Trang đăng nhập

**Công nghệ sử dụng:**

- Password hashing với Base64
- Email validation
- Session management

### 2. Đăng nhập (Sign In)

**Files liên quan:**

- `web/views/signin.jsp` - Giao diện đăng nhập
- `src/java/data/controllers/signInServlet.java` - Xử lý đăng nhập
- `src/java/data/dao/UserDao.java`
- `src/java/data/implementations/UserImplementation.java`

**Flow hoạt động:**

1. User nhập email/password → `signin.jsp`
2. Submit form → `signInServlet.doPost()`
3. Validate credentials → `UserImplementation.getUserByEmail()`
4. Hash password so sánh → `Base64Utils.encode()`
5. Tạo session → `session.setAttribute("user", user)`
6. Redirect → Trang chủ

**Công nghệ sử dụng:**

- Session-based authentication
- Password verification
- Redirect after login

### 3. Đăng xuất (Sign Out)

**Files liên quan:**

- `src/java/data/controllers/signOutServlet.java`
- `web/components/header.jsp` - Button đăng xuất

**Flow hoạt động:**

1. Click đăng xuất → `signOutServlet`
2. Invalidate session → `session.invalidate()`
3. Redirect → Trang chủ

---

## 🛍️ QUẢN LÝ SẢN PHẨM

### 1. Hiển thị danh sách sản phẩm

**Files liên quan:**

- `web/index.jsp` - Trang chủ hiển thị sản phẩm
- `src/java/data/controllers/ProductsAPIServlet.java` - API lấy sản phẩm
- `src/java/data/dao/ProductDao.java`
- `src/java/data/implementations/ProductImplementation.java`
- `src/java/data/models/Product.java`

**Flow hoạt động:**

1. Truy cập trang chủ → `index.jsp`
2. Load sản phẩm → `ProductsAPIServlet.doGet()`
3. Query database → `ProductImplementation.getAllProducts()`
4. Trả về JSON → Frontend render

**Công nghệ sử dụng:**

- RESTful API
- JSON response
- AJAX loading

### 2. Chi tiết sản phẩm

**Files liên quan:**

- `web/views/product-detail.jsp` - Trang chi tiết
- `src/java/data/controllers/ProductDetailServlet.java`
- `src/java/data/dao/ProductImageDao.java`
- `src/java/data/models/ProductImage.java`

**Flow hoạt động:**

1. Click sản phẩm → `ProductDetailServlet`
2. Lấy product ID → `request.getParameter("id")`
3. Query product + images → `ProductDao.getProductById()`
4. Forward → `product-detail.jsp`

### 3. Tìm kiếm sản phẩm

**Files liên quan:**

- `web/components/header.jsp` - Search form
- `src/java/data/controllers/SearchServlet.java`
- `web/search-results.jsp` - Kết quả tìm kiếm

**Flow hoạt động:**

1. Nhập từ khóa → Header search
2. Submit form → `SearchServlet`
3. Query database → `ProductImplementation.searchProducts()`
4. Forward → `search-results.jsp`

---

## 🛒 QUẢN LÝ GIỎ HÀNG

### 1. Thêm sản phẩm vào giỏ hàng

**Files liên quan:**

- `web/views/product-detail.jsp` - Button "Thêm vào giỏ hàng"
- `src/java/data/controllers/AddToCartServlet.java`
- `src/java/data/dao/CartDao.java`
- `src/java/data/implementations/CartImplementation.java`
- `src/java/data/models/Cart.java`
- `src/java/data/models/CartItem.java`

**Flow hoạt động:**

1. Click "Thêm vào giỏ hàng" → `addToCart(productId)`
2. AJAX request → `AddToCartServlet.doPost()`
3. Kiểm tra user session
4. Tạo/lấy cart → `CartImplementation.getCartByUserEmail()`
5. Thêm item → `CartImplementation.addItemToCart()`
6. Trả về JSON → Update UI

**Công nghệ sử dụng:**

- AJAX/Fetch API
- JSON response
- Session-based cart

### 2. Xem giỏ hàng

**Files liên quan:**

- `web/views/cart.jsp` - Trang giỏ hàng
- `src/java/data/controllers/cartServlet.java`
- `web/components/header.jsp` - Cart icon

**Flow hoạt động:**

1. Click cart icon → `cartServlet`
2. Lấy cart items → `CartImplementation.getCartItems()`
3. Forward → `cart.jsp`

### 3. Cập nhật/xóa giỏ hàng

**Files liên quan:**

- `src/java/data/controllers/updateCartItemServlet.java`
- `src/java/data/controllers/removeCartItemServlet.java`
- `src/java/data/controllers/clearCartServlet.java`

**Flow hoạt động:**

1. User action → AJAX request
2. Servlet xử lý → Update database
3. Trả về JSON → Update UI

---

## 💳 QUẢN LÝ ĐƠN HÀNG

### 1. Mua hàng ngay lập tức (Buy Now)

**Files liên quan:**

- `web/views/product-detail.jsp` - Button "Mua Ngay"
- `src/java/data/controllers/BuyNowServlet.java` ⭐ **MỚI**
- `src/java/data/dao/OrderDao.java`
- `src/java/data/dao/OrderItemDao.java`
- `src/java/data/models/Order.java`
- `src/java/data/models/OrderItem.java`

**Flow hoạt động:**

1. Click "Mua Ngay" → `buyNow(productId)`
2. AJAX request → `BuyNowServlet.doPost()`
3. Kiểm tra đăng nhập
4. Tạo order → `OrderImplementation.createOrder()`
5. Tạo order item → `OrderItemImplementation.addOrderItem()`
6. Redirect → `order-success.jsp`

**Công nghệ sử dụng:**

- Direct order creation (bypass cart)
- Transaction management
- JSON response

### 2. Đặt hàng từ giỏ hàng

**Files liên quan:**

- `web/views/checkout.jsp` - Trang checkout
- `src/java/data/controllers/PlaceOrderServlet.java`
- `web/views/order-success.jsp` - Trang thành công

**Flow hoạt động:**

1. Chọn items từ cart → `checkout.jsp`
2. Submit order → `PlaceOrderServlet.doPost()`
3. Tạo order từ cart items
4. Xóa items khỏi cart
5. Redirect → `order-success.jsp`

### 3. Xem lịch sử đơn hàng

**Files liên quan:**

- `web/views/orders.jsp` - Trang đơn hàng
- `src/java/data/controllers/OrdersServlet.java`
- `web/views/order-detail.jsp` - Chi tiết đơn hàng

**Flow hoạt động:**

1. Click "Đơn hàng của tôi" → `OrdersServlet`
2. Lấy orders → `OrderImplementation.getOrdersByUser()`
3. Forward → `orders.jsp`

---

## 🤖 CHATBOT HỖ TRỢ

### 1. Chatbot Interface

**Files liên quan:**

- `web/components/chatbot.jsp` - Chatbot component
- JavaScript embedded trong file

**Chức năng:**

- Real-time chat interface
- Product recommendations
- Search assistance
- Contact information

**Flow hoạt động:**

1. Click chatbot button → Open modal
2. User input → JavaScript processing
3. Keyword matching → Generate responses
4. Product display → API calls to `/api/products`

**Công nghệ sử dụng:**

- LocalStorage for chat history
- Fetch API for product data
- Dynamic UI generation
- Keyword-based response system

### 2. Product Recommendations

**Files liên quan:**

- `web/components/chatbot.jsp` - Product display logic
- `src/java/data/controllers/ProductsAPIServlet.java`

**Flow hoạt động:**

1. User asks for products → `showProducts()`
2. Fetch API → `ProductsAPIServlet`
3. Display products → Dynamic HTML generation
4. Filter/search → Client-side filtering

---

## 🔍 TÌM KIẾM VÀ LỌC

### 1. Header Search

**Files liên quan:**

- `web/components/header.jsp` - Search form
- `src/java/data/controllers/SearchServlet.java`
- `web/search-results.jsp`

**Flow hoạt động:**

1. Enter search term → Header search
2. Form submission → `SearchServlet`
3. Database query → `ProductImplementation.searchProducts()`
4. Results display → `search-results.jsp`

### 2. Search Suggestions

**Files liên quan:**

- `web/components/header.jsp` - Search suggestions dropdown

**Chức năng:**

- Predefined search terms
- Quick search buttons
- Auto-complete suggestions

---

## 👤 QUẢN LÝ NGƯỜI DÙNG

### 1. User Profile

**Files liên quan:**

- `web/components/header.jsp` - User dropdown
- `src/java/data/models/User.java`
- `src/java/data/dao/UserDao.java`

**Chức năng:**

- Display user info
- Profile picture
- Account management

### 2. Admin Panel

**Files liên quan:**

- `web/views/admin.jsp` - Admin dashboard
- `src/java/data/controllers/adminServlet.java`
- `src/java/data/controllers/AddProductServlet.java`
- `src/java/data/controllers/DeleteProductServlet.java`

**Chức năng:**

- Product management
- User management
- Order management
- Analytics dashboard

---

## 🖼️ QUẢN LÝ HÌNH ẢNH

### 1. Product Images

**Files liên quan:**

- `src/java/data/controllers/ImageServlet.java`
- `src/java/data/dao/ProductImageDao.java`
- `src/java/data/models/ProductImage.java`
- `src/java/data/utils/ImageUtils.java`

**Flow hoạt động:**

1. Image upload → `ImageServlet`
2. File processing → `ImageUtils`
3. Database storage → `ProductImageDao`
4. File system storage → `/uploads/products/`

### 2. User Profile Pictures

**Files liên quan:**

- `src/java/data/utils/ImageUtils.java`
- `/uploads/users/` - Storage directory

**Chức năng:**

- Profile picture upload
- Image resizing
- Format conversion

---

## 🔧 CÔNG NGHỆ VÀ TOOLS

### Backend:

- **Java Servlet/JSP** - Web framework
- **MySQL** - Database
- **JDBC** - Database connectivity
- **Session Management** - User authentication
- **File Upload** - Image handling

### Frontend:

- **Tailwind CSS** - Styling framework
- **JavaScript (ES6+)** - Client-side logic
- **Fetch API** - AJAX requests
- **LocalStorage** - Client-side storage

### Development:

- **NetBeans** - IDE
- **Apache Tomcat** - Application server
- **Git** - Version control

---

## 📊 CƠ SỞ DỮ LIỆU

### Tables:

- `users` - User accounts
- `products` - Product information
- `product_images` - Product images
- `carts` - Shopping carts
- `cart_items` - Cart items
- `orders` - Orders
- `order_items` - Order items

### Relationships:

- User → Cart (1:1)
- Cart → CartItems (1:N)
- User → Orders (1:N)
- Order → OrderItems (1:N)
- Product → ProductImages (1:N)

---

## 🔒 BẢO MẬT

### Authentication:

- Session-based authentication
- Password hashing (Base64)
- Login required for cart/orders

### Data Validation:

- Server-side validation
- SQL injection prevention
- XSS protection

### File Upload Security:

- File type validation
- Size limits
- Secure file storage

---

## 🚀 DEPLOYMENT

### Requirements:

- Java 8+
- Apache Tomcat 9+
- MySQL 5.7+
- 2GB+ RAM

### Configuration:

- Database connection in `context.xml`
- File upload paths
- Session timeout settings

---

## 📝 GHI CHÚ QUAN TRỌNG

1. **Session Management**: Tất cả chức năng cart/order đều yêu cầu đăng nhập
2. **Image Handling**: Sử dụng relative paths cho images
3. **AJAX Requests**: Sử dụng Fetch API thay vì jQuery
4. **Error Handling**: Comprehensive try-catch blocks
5. **Database Transactions**: Sử dụng cho order creation
6. **Responsive Design**: Tailwind CSS classes cho mobile-first design

---

_Tài liệu này được cập nhật lần cuối: [Ngày hiện tại]_
