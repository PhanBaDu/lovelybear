# 🤖 Chatbot Hiển Thị Sản Phẩm - Decor Project

## 📋 Tổng Quan

Đã bổ sung chức năng hiển thị sản phẩm trong chatbot với button "Xem toàn bộ sản phẩm" và hiển thị các sản phẩm dạng item nhỏ xíu.

## 🚀 Tính Năng Mới

### ✅ **Chức Năng Đã Hoàn Thành:**
1. **Button "Xem toàn bộ sản phẩm"** - Xuất hiện khi user hỏi về sản phẩm
2. **Hiển thị sản phẩm dạng grid nhỏ** - Layout 2 cột với ảnh, tên và giá
3. **Tìm kiếm sản phẩm** - Thanh tìm kiếm tích hợp trong chatbot
4. **Xem chi tiết sản phẩm** - Click vào sản phẩm để xem thông tin chi tiết
5. **API endpoint** - `/api/products.jsp` để lấy danh sách sản phẩm

### 🔧 **Chức Năng Kỹ Thuật:**
- **Real-time search** - Tìm kiếm sản phẩm theo tên và mô tả
- **Responsive design** - Giao diện tối ưu cho chatbot
- **JSON API** - Endpoint trả về dữ liệu sản phẩm dạng JSON
- **Error handling** - Xử lý lỗi khi tải sản phẩm

## 📁 Files Đã Cập Nhật

### 1. **`web/components/chatbot.jsp`**
- Thêm button "Xem toàn bộ sản phẩm"
- Thêm phương thức `addProductButton()`
- Thêm phương thức `showProducts()`
- Thêm phương thức `displayProducts()`
- Thêm phương thức `createProductCard()`
- Thêm phương thức `showProductDetail()`
- Thêm phương thức `filterProducts()`
- Cập nhật `generateBotResponse()` để trigger button sản phẩm

### 2. **`web/api/products.jsp`**
- API endpoint mới để trả về danh sách sản phẩm
- Response dạng JSON
- Xử lý lỗi và escape JSON string
- Không cần thư viện bên ngoài

## 🎯 Cách Sử Dụng

### **1. Kích Hoạt Chức Năng:**
- Mở chatbot (click vào button "Bạn cần hỗ trợ gì nào?")
- Gõ tin nhắn có chứa từ "sản phẩm" (ví dụ: "Tôi muốn xem sản phẩm")
- Bot sẽ trả lời và hiển thị button "🛍️ Xem toàn bộ sản phẩm"

### **2. Xem Sản Phẩm:**
- Click vào button "Xem toàn bộ sản phẩm"
- Bot sẽ hiển thị danh sách sản phẩm dạng grid 2 cột
- Mỗi sản phẩm hiển thị: ảnh, tên, giá

### **3. Tìm Kiếm Sản Phẩm:**
- Sử dụng thanh tìm kiếm "🔍 Tìm sản phẩm..." trong chatbot
- Gõ từ khóa để lọc sản phẩm theo tên hoặc mô tả
- Kết quả được cập nhật real-time

### **4. Xem Chi Tiết:**
- Click vào bất kỳ sản phẩm nào trong grid
- Bot sẽ hiển thị thông tin chi tiết: ảnh lớn, tên, mô tả, giá
- Có button "Xem chi tiết" để mở trang sản phẩm trong tab mới

## 🎨 Giao Diện

### **Button "Xem toàn bộ sản phẩm":**
- Màu primary với icon 🛍️
- Xuất hiện sau khi bot trả lời về sản phẩm
- Hover effect và transition

### **Grid Sản Phẩm:**
- Layout 2 cột responsive
- Mỗi card sản phẩm: ảnh 64x64px, tên, giá
- Hover effect với shadow
- Scrollable container (max height 300px)

### **Thanh Tìm Kiếm:**
- Input field nhỏ gọn (150px width)
- Placeholder "🔍 Tìm sản phẩm..."
- Focus effect với border primary

### **Chi Tiết Sản Phẩm:**
- Background xanh nhạt với border
- Ảnh sản phẩm 64x64px
- Thông tin đầy đủ: tên, mô tả, giá
- Button "Xem chi tiết" để mở trang sản phẩm

## 🔧 API Endpoint

### **URL:** `/api/products.jsp`
### **Method:** GET
### **Response:** JSON array
### **Example Response:**
```json
[
  {
    "id": 1,
    "name": "Sản phẩm 1",
    "description": "Mô tả sản phẩm 1",
    "price": 100000,
    "imageUrl": "/uploads/products/image1.jpg"
  },
  {
    "id": 2,
    "name": "Sản phẩm 2",
    "description": "Mô tả sản phẩm 2",
    "price": 200000,
    "imageUrl": "/uploads/products/image2.jpg"
  }
]
```

## 🚀 Luồng Hoạt Động

1. **User gõ tin nhắn có từ "sản phẩm"**
2. **Bot trả lời và hiển thị button "Xem toàn bộ sản phẩm"**
3. **User click button**
4. **Bot gọi API `/api/products.jsp`**
5. **Hiển thị danh sách sản phẩm dạng grid**
6. **User có thể tìm kiếm hoặc click vào sản phẩm**
7. **Hiển thị chi tiết sản phẩm với button "Xem chi tiết"**

## 🎯 Tính Năng Tương Lai

### **Đã Lên Kế Hoạch:**
- [ ] Thêm phân trang cho danh sách sản phẩm lớn
- [ ] Thêm filter theo danh mục sản phẩm
- [ ] Thêm sắp xếp theo giá, tên, ngày
- [ ] Thêm chức năng "Thêm vào giỏ hàng" trực tiếp từ chatbot
- [ ] Thêm gợi ý sản phẩm liên quan

### **Cải Tiến:**
- [ ] Cache danh sách sản phẩm để tăng performance
- [ ] Lazy loading cho ảnh sản phẩm
- [ ] Animation khi hiển thị sản phẩm
- [ ] Voice search cho chatbot

## 🐛 Troubleshooting

### **Lỗi Thường Gặp:**

1. **Button "Xem toàn bộ sản phẩm" không xuất hiện:**
   - Kiểm tra tin nhắn có chứa từ "sản phẩm" không
   - Kiểm tra console log có lỗi JavaScript không

2. **Không hiển thị sản phẩm:**
   - Kiểm tra API endpoint `/api/products.jsp` có hoạt động không
   - Kiểm tra database connection
   - Kiểm tra console log có lỗi fetch không

3. **Ảnh sản phẩm không hiển thị:**
   - Kiểm tra đường dẫn ảnh trong database
   - Kiểm tra file ảnh có tồn tại không
   - Kiểm tra quyền truy cập file

### **Debug:**
```javascript
// Thêm vào console để debug
console.log('Products:', products);
console.log('API Response:', response);
console.log('Filter term:', searchTerm);
```

## 📱 Responsive Design

- **Desktop:** Grid 2 cột với max-width 500px
- **Mobile:** Grid 2 cột với responsive sizing
- **Chatbot:** Fixed width 600px, height 700px
- **Scroll:** Vertical scroll cho danh sách sản phẩm dài

## 🔒 Bảo Mật

- API endpoint không yêu cầu authentication
- Chỉ trả về thông tin công khai của sản phẩm
- Không expose thông tin nhạy cảm
- Input sanitization cho tìm kiếm

---

**Trạng thái**: Hoàn thành ✅  
**Phiên bản**: 1.0  
**Ngày cập nhật**: $(date)
