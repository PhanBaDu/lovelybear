# Decor - Hệ thống Đăng ký và Đăng xuất

## Tổng quan

Dự án Decor là một ứng dụng web Java Servlet với các chức năng đăng ký và đăng xuất được cải thiện, bao gồm validation đầy đủ và giao diện người dùng hiện đại.

## Tính năng chính

### 1. Đăng ký (Sign Up)
- **Validation đầy đủ**: Kiểm tra tất cả các trường bắt buộc
- **Kiểm tra trùng lặp**: Email và số điện thoại không được trùng
- **Validation mật khẩu**: Yêu cầu chữ hoa, chữ thường và số
- **Upload ảnh đại diện**: Hỗ trợ drag & drop
- **Giao diện responsive**: Tương thích với mọi thiết bị

### 2. Đăng xuất (Sign Out)
- **Xóa session an toàn**: Đảm bảo bảo mật
- **Thông báo thành công**: Hiển thị toast notification
- **Redirect tự động**: Về trang chủ sau khi đăng xuất

### 3. Validation Rules

#### Email
- Không được để trống
- Phải đúng định dạng email
- Không được trùng với email đã tồn tại

#### Mật khẩu
- Tối thiểu 6 ký tự
- Phải chứa ít nhất 1 chữ hoa
- Phải chứa ít nhất 1 chữ thường
- Phải chứa ít nhất 1 số

#### Xác nhận mật khẩu
- Phải khớp với mật khẩu

#### Họ và tên
- Tối thiểu 2 ký tự
- Không được để trống

#### Số điện thoại
- Định dạng số điện thoại Việt Nam (0xxxxxxxxx)
- Không được trùng với số đã tồn tại

#### Địa chỉ
- Tối thiểu 5 ký tự
- Không được để trống

## Cấu trúc dự án

```
decor/
├── src/java/data/
│   ├── controllers/
│   │   ├── signUpServlet.java      # Xử lý đăng ký
│   │   └── signOutServlet.java     # Xử lý đăng xuất
│   ├── dao/
│   │   ├── Database.java           # Kết nối database
│   │   └── UserDao.java            # Interface DAO
│   ├── implementations/
│   │   └── UserImplementation.java # Triển khai DAO
│   └── utils/
│       └── Base64Utils.java        # Xử lý Base64
├── web/
│   ├── views/
│   │   └── signup.jsp              # Giao diện đăng ký
│   ├── public/assets/
│   │   ├── styles/
│   │   │   ├── globals.css         # CSS chính
│   │   │   └── validation.css      # CSS validation
│   │   └── js/
│   │       └── validation.js       # JavaScript validation
│   └── index.jsp                   # Trang chủ
└── README.md
```

## Cài đặt và chạy

### Yêu cầu hệ thống
- Java JDK 8 trở lên
- Apache Tomcat 9.0 trở lên
- MySQL 5.7 trở lên

### Cài đặt
1. Clone repository
2. Import project vào IDE (NetBeans, Eclipse, IntelliJ)
3. Cấu hình database trong `src/java/data/driver/MySqlDriver.java`
4. Build và deploy lên Tomcat

### Cấu hình Database
```sql
CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    email VARCHAR(255) UNIQUE NOT NULL,
    sodienthoai VARCHAR(15) UNIQUE NOT NULL,
    fullName VARCHAR(255) NOT NULL,
    pictureProfile LONGTEXT,
    address TEXT NOT NULL,
    password VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

## Test Cases

### Test Cases Đăng ký

#### 1. Test Case: Đăng ký thành công
- **Input**: Tất cả thông tin hợp lệ
- **Expected**: Tạo tài khoản thành công, redirect về trang chủ

#### 2. Test Case: Email trống
- **Input**: Email = ""
- **Expected**: Hiển thị lỗi "Email không được để trống"

#### 3. Test Case: Email không đúng định dạng
- **Input**: Email = "invalid-email"
- **Expected**: Hiển thị lỗi "Email không đúng định dạng"

#### 4. Test Case: Email đã tồn tại
- **Input**: Email đã có trong database
- **Expected**: Hiển thị lỗi "Email đã tồn tại trong hệ thống"

#### 5. Test Case: Mật khẩu quá ngắn
- **Input**: Password = "123"
- **Expected**: Hiển thị lỗi "Mật khẩu phải có ít nhất 6 ký tự"

#### 6. Test Case: Mật khẩu không đủ độ mạnh
- **Input**: Password = "123456"
- **Expected**: Hiển thị lỗi "Mật khẩu phải chứa ít nhất 1 chữ hoa, 1 chữ thường và 1 số"

#### 7. Test Case: Xác nhận mật khẩu không khớp
- **Input**: Password = "Password123", ConfirmPassword = "Password456"
- **Expected**: Hiển thị lỗi "Mật khẩu xác nhận không khớp"

#### 8. Test Case: Số điện thoại không đúng định dạng
- **Input**: Phone = "123456789"
- **Expected**: Hiển thị lỗi "Số điện thoại không đúng định dạng"

#### 9. Test Case: Số điện thoại đã tồn tại
- **Input**: Số điện thoại đã có trong database
- **Expected**: Hiển thị lỗi "Số điện thoại đã tồn tại trong hệ thống"

#### 10. Test Case: Họ tên quá ngắn
- **Input**: FullName = "A"
- **Expected**: Hiển thị lỗi "Họ và tên phải có ít nhất 2 ký tự"

#### 11. Test Case: Địa chỉ quá ngắn
- **Input**: Address = "123"
- **Expected**: Hiển thị lỗi "Địa chỉ phải có ít nhất 5 ký tự"

### Test Cases Đăng xuất

#### 1. Test Case: Đăng xuất thành công
- **Input**: Click nút đăng xuất
- **Expected**: Xóa session, hiển thị thông báo thành công, redirect về trang chủ

#### 2. Test Case: Đăng xuất khi chưa đăng nhập
- **Input**: Truy cập /signout khi chưa đăng nhập
- **Expected**: Redirect về trang chủ

## Tính năng bảo mật

1. **Validation Server-side**: Tất cả dữ liệu được validate ở server
2. **Validation Client-side**: Validation real-time ở browser
3. **Session Management**: Xóa session an toàn khi đăng xuất
4. **Password Hashing**: Mật khẩu được mã hóa (cần implement)
5. **SQL Injection Prevention**: Sử dụng PreparedStatement

## Giao diện người dùng

### Thiết kế
- **Modern UI**: Sử dụng Tailwind CSS
- **Responsive**: Tương thích mobile, tablet, desktop
- **Accessibility**: Hỗ trợ screen reader, keyboard navigation
- **Animation**: Hiệu ứng mượt mà, chuyên nghiệp

### Components
- **Form Validation**: Hiển thị lỗi real-time
- **Toast Notifications**: Thông báo thành công/lỗi
- **Loading States**: Hiển thị trạng thái đang xử lý
- **Password Toggle**: Ẩn/hiện mật khẩu
- **Image Upload**: Drag & drop với preview

## Tương lai

### Tính năng có thể thêm
1. **Email Verification**: Xác thực email
2. **Password Reset**: Đặt lại mật khẩu
3. **Social Login**: Đăng nhập bằng Google, Facebook
4. **Two-Factor Authentication**: Xác thực 2 yếu tố
5. **Profile Management**: Quản lý thông tin cá nhân

### Cải thiện bảo mật
1. **Rate Limiting**: Giới hạn số lần đăng ký/đăng nhập
2. **CAPTCHA**: Chống bot
3. **HTTPS**: Bảo mật kết nối
4. **Input Sanitization**: Làm sạch dữ liệu đầu vào

## Đóng góp

1. Fork project
2. Tạo feature branch
3. Commit changes
4. Push to branch
5. Tạo Pull Request

## License

MIT License - xem file LICENSE để biết thêm chi tiết.
