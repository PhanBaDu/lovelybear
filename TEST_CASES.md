# Test Cases Chi Tiết - Decor System

## 1. Test Cases Đăng Ký (Sign Up)

### 1.1 Test Case: Đăng ký thành công
**Mô tả**: Đăng ký với tất cả thông tin hợp lệ
**Priority**: High
**Steps**:
1. Truy cập trang đăng ký
2. Nhập email: `test@example.com`
3. Nhập mật khẩu: `Password123`
4. Nhập xác nhận mật khẩu: `Password123`
5. Nhập họ tên: `Nguyễn Văn A`
6. Nhập số điện thoại: `0123456789`
7. Nhập địa chỉ: `123 Đường ABC, Quận 1, TP.HCM`
8. Click "Đăng ký"

**Expected Result**:
- Tạo tài khoản thành công
- Hiển thị thông báo "Đăng ký tài khoản thành công!"
- Redirect về trang chủ
- User được lưu vào database

---

### 1.2 Test Case: Email trống
**Mô tả**: Để trống trường email
**Priority**: High
**Steps**:
1. Truy cập trang đăng ký
2. Để trống trường email
3. Nhập các thông tin khác hợp lệ
4. Click "Đăng ký"

**Expected Result**:
- Hiển thị lỗi "Email không được để trống"
- Form không submit
- Border email field chuyển đỏ

---

### 1.3 Test Case: Email không đúng định dạng
**Mô tả**: Nhập email không đúng định dạng
**Priority**: High
**Steps**:
1. Truy cập trang đăng ký
2. Nhập email: `invalid-email`
3. Nhập các thông tin khác hợp lệ
4. Click "Đăng ký"

**Expected Result**:
- Hiển thị lỗi "Email không đúng định dạng"
- Form không submit

**Test Data**:
- `invalid-email` ❌
- `test@` ❌
- `@example.com` ❌
- `test.example.com` ❌
- `test@example` ❌
- `test@example.com` ✅

---

### 1.4 Test Case: Email đã tồn tại
**Mô tả**: Đăng ký với email đã có trong hệ thống
**Priority**: High
**Steps**:
1. Đăng ký tài khoản đầu tiên với email: `existing@example.com`
2. Đăng ký tài khoản thứ hai với cùng email
3. Click "Đăng ký"

**Expected Result**:
- Hiển thị lỗi "Email đã tồn tại trong hệ thống"
- Form không submit
- Tài khoản thứ hai không được tạo

---

### 1.5 Test Case: Mật khẩu quá ngắn
**Mô tả**: Nhập mật khẩu ít hơn 6 ký tự
**Priority**: High
**Steps**:
1. Truy cập trang đăng ký
2. Nhập mật khẩu: `123`
3. Nhập các thông tin khác hợp lệ
4. Click "Đăng ký"

**Expected Result**:
- Hiển thị lỗi "Mật khẩu phải có ít nhất 6 ký tự"
- Form không submit

**Test Data**:
- `123` ❌ (3 ký tự)
- `12345` ❌ (5 ký tự)
- `123456` ✅ (6 ký tự)

---

### 1.6 Test Case: Mật khẩu không đủ độ mạnh
**Mô tả**: Mật khẩu thiếu chữ hoa, chữ thường hoặc số
**Priority**: High
**Steps**:
1. Truy cập trang đăng ký
2. Nhập mật khẩu: `123456`
3. Nhập các thông tin khác hợp lệ
4. Click "Đăng ký"

**Expected Result**:
- Hiển thị lỗi "Mật khẩu phải chứa ít nhất 1 chữ hoa, 1 chữ thường và 1 số"
- Form không submit

**Test Data**:
- `123456` ❌ (thiếu chữ hoa, chữ thường)
- `abcdef` ❌ (thiếu chữ hoa, số)
- `ABCDEF` ❌ (thiếu chữ thường, số)
- `abc123` ❌ (thiếu chữ hoa)
- `ABC123` ❌ (thiếu chữ thường)
- `Password123` ✅ (đủ yêu cầu)

---

### 1.7 Test Case: Xác nhận mật khẩu không khớp
**Mô tả**: Mật khẩu và xác nhận mật khẩu khác nhau
**Priority**: High
**Steps**:
1. Truy cập trang đăng ký
2. Nhập mật khẩu: `Password123`
3. Nhập xác nhận mật khẩu: `Password456`
4. Nhập các thông tin khác hợp lệ
5. Click "Đăng ký"

**Expected Result**:
- Hiển thị lỗi "Mật khẩu xác nhận không khớp"
- Form không submit

---

### 1.8 Test Case: Số điện thoại không đúng định dạng
**Mô tả**: Nhập số điện thoại không đúng định dạng Việt Nam
**Priority**: High
**Steps**:
1. Truy cập trang đăng ký
2. Nhập số điện thoại: `123456789`
3. Nhập các thông tin khác hợp lệ
4. Click "Đăng ký"

**Expected Result**:
- Hiển thị lỗi "Số điện thoại không đúng định dạng"
- Form không submit

**Test Data**:
- `123456789` ❌ (không bắt đầu bằng 0)
- `012345678` ❌ (9 số)
- `012345678901` ❌ (12 số)
- `0123456789` ✅ (10 số)
- `01234567890` ✅ (11 số)

---

### 1.9 Test Case: Số điện thoại đã tồn tại
**Mô tả**: Đăng ký với số điện thoại đã có trong hệ thống
**Priority**: High
**Steps**:
1. Đăng ký tài khoản đầu tiên với số điện thoại: `0123456789`
2. Đăng ký tài khoản thứ hai với cùng số điện thoại
3. Click "Đăng ký"

**Expected Result**:
- Hiển thị lỗi "Số điện thoại đã tồn tại trong hệ thống"
- Form không submit

---

### 1.10 Test Case: Họ tên quá ngắn
**Mô tả**: Nhập họ tên ít hơn 2 ký tự
**Priority**: Medium
**Steps**:
1. Truy cập trang đăng ký
2. Nhập họ tên: `A`
3. Nhập các thông tin khác hợp lệ
4. Click "Đăng ký"

**Expected Result**:
- Hiển thị lỗi "Họ và tên phải có ít nhất 2 ký tự"
- Form không submit

---

### 1.11 Test Case: Địa chỉ quá ngắn
**Mô tả**: Nhập địa chỉ ít hơn 5 ký tự
**Priority**: Medium
**Steps**:
1. Truy cập trang đăng ký
2. Nhập địa chỉ: `123`
3. Nhập các thông tin khác hợp lệ
4. Click "Đăng ký"

**Expected Result**:
- Hiển thị lỗi "Địa chỉ phải có ít nhất 5 ký tự"
- Form không submit

---

### 1.12 Test Case: Upload ảnh đại diện
**Mô tả**: Upload ảnh đại diện thành công
**Priority**: Low
**Steps**:
1. Truy cập trang đăng ký
2. Click vào vùng upload ảnh
3. Chọn file ảnh hợp lệ (JPG, PNG, GIF, WebP)
4. Nhập các thông tin khác hợp lệ
5. Click "Đăng ký"

**Expected Result**:
- Hiển thị preview ảnh
- Ảnh được convert sang Base64
- Đăng ký thành công với ảnh đại diện

---

### 1.13 Test Case: Upload ảnh không hợp lệ
**Mô tả**: Upload file không phải ảnh
**Priority**: Low
**Steps**:
1. Truy cập trang đăng ký
2. Click vào vùng upload ảnh
3. Chọn file không phải ảnh (txt, pdf, doc)
4. Click "Đăng ký"

**Expected Result**:
- Hiển thị thông báo "Vui lòng chọn file ảnh hợp lệ"
- File không được upload

---

### 1.14 Test Case: Upload ảnh quá lớn
**Mô tả**: Upload ảnh lớn hơn 5MB
**Priority**: Low
**Steps**:
1. Truy cập trang đăng ký
2. Click vào vùng upload ảnh
3. Chọn ảnh lớn hơn 5MB
4. Click "Đăng ký"

**Expected Result**:
- Hiển thị thông báo "File ảnh quá lớn. Vui lòng chọn file nhỏ hơn 5MB"
- File không được upload

---

## 2. Test Cases Đăng Xuất (Sign Out)

### 2.1 Test Case: Đăng xuất thành công
**Mô tả**: Đăng xuất khi đã đăng nhập
**Priority**: High
**Steps**:
1. Đăng nhập vào hệ thống
2. Click nút "Đăng xuất"
3. Xác nhận đăng xuất

**Expected Result**:
- Session bị xóa
- Hiển thị thông báo "Đăng xuất thành công!"
- Redirect về trang chủ
- Không thể truy cập các trang yêu cầu đăng nhập

---

### 2.2 Test Case: Đăng xuất khi chưa đăng nhập
**Mô tả**: Truy cập trang đăng xuất khi chưa đăng nhập
**Priority**: Medium
**Steps**:
1. Truy cập trực tiếp URL `/signout` khi chưa đăng nhập
2. Xem kết quả

**Expected Result**:
- Redirect về trang chủ
- Không có thông báo lỗi

---

## 3. Test Cases Giao Diện

### 3.1 Test Case: Responsive Design
**Mô tả**: Kiểm tra giao diện trên các thiết bị khác nhau
**Priority**: Medium
**Steps**:
1. Mở trang đăng ký trên desktop
2. Thay đổi kích thước màn hình
3. Mở trên tablet
4. Mở trên mobile

**Expected Result**:
- Giao diện hiển thị đẹp trên mọi thiết bị
- Form không bị vỡ layout
- Text dễ đọc

---

### 3.2 Test Case: Password Toggle
**Mô tả**: Ẩn/hiện mật khẩu
**Priority**: Low
**Steps**:
1. Truy cập trang đăng ký
2. Nhập mật khẩu
3. Click icon mắt để ẩn/hiện mật khẩu

**Expected Result**:
- Mật khẩu chuyển đổi giữa ẩn và hiện
- Icon mắt thay đổi tương ứng

---

### 3.3 Test Case: Real-time Validation
**Mô tả**: Validation ngay khi người dùng nhập
**Priority**: Medium
**Steps**:
1. Truy cập trang đăng ký
2. Nhập email không hợp lệ
3. Click ra ngoài trường email

**Expected Result**:
- Hiển thị lỗi ngay lập tức
- Border chuyển đỏ
- Lỗi biến mất khi nhập lại đúng

---

## 4. Test Cases Bảo Mật

### 4.1 Test Case: SQL Injection Prevention
**Mô tả**: Thử inject SQL vào các trường input
**Priority**: High
**Steps**:
1. Truy cập trang đăng ký
2. Nhập SQL injection vào trường email: `'; DROP TABLE users; --`
3. Click "Đăng ký"

**Expected Result**:
- Không có lỗi SQL
- Hiển thị lỗi validation bình thường
- Database không bị ảnh hưởng

---

### 4.2 Test Case: XSS Prevention
**Mô tả**: Thử inject JavaScript vào các trường input
**Priority**: High
**Steps**:
1. Truy cập trang đăng ký
2. Nhập XSS vào trường họ tên: `<script>alert('XSS')</script>`
3. Click "Đăng ký"

**Expected Result**:
- Script không được thực thi
- Dữ liệu được escape an toàn

---

## 5. Test Cases Performance

### 5.1 Test Case: Load Time
**Mô tả**: Kiểm tra thời gian tải trang
**Priority**: Low
**Steps**:
1. Mở Developer Tools
2. Truy cập trang đăng ký
3. Kiểm tra thời gian tải

**Expected Result**:
- Trang tải trong vòng 3 giây
- Không có lỗi console

---

### 5.2 Test Case: Form Submission Time
**Mô tả**: Kiểm tra thời gian xử lý form
**Priority**: Low
**Steps**:
1. Điền form với dữ liệu hợp lệ
2. Click "Đăng ký"
3. Đo thời gian từ lúc click đến lúc redirect

**Expected Result**:
- Form xử lý trong vòng 5 giây
- Hiển thị loading state

---

## 6. Test Cases Accessibility

### 6.1 Test Case: Keyboard Navigation
**Mô tả**: Điều hướng bằng bàn phím
**Priority**: Medium
**Steps**:
1. Truy cập trang đăng ký
2. Sử dụng Tab để di chuyển giữa các trường
3. Sử dụng Enter để submit form

**Expected Result**:
- Có thể điều hướng hoàn toàn bằng bàn phím
- Focus indicator rõ ràng

---

### 6.2 Test Case: Screen Reader
**Mô tả**: Tương thích với screen reader
**Priority**: Low
**Steps**:
1. Mở screen reader
2. Truy cập trang đăng ký
3. Đọc các label và error message

**Expected Result**:
- Screen reader đọc đúng các label
- Error message được đọc rõ ràng

---

## Kết Luận

Các test cases trên bao phủ:
- **Functional Testing**: Kiểm tra chức năng chính
- **Validation Testing**: Kiểm tra validation rules
- **Security Testing**: Kiểm tra bảo mật
- **UI/UX Testing**: Kiểm tra giao diện
- **Performance Testing**: Kiểm tra hiệu suất
- **Accessibility Testing**: Kiểm tra khả năng tiếp cận

Tổng cộng: **25 test cases** với độ ưu tiên khác nhau để đảm bảo chất lượng hệ thống.
