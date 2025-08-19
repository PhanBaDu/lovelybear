# 🔧 Sửa Lỗi Template Literals Trong JSP - Decor Project

## 📋 Tổng Quan

Đã sửa lỗi `jakarta.el.ELException: Failed to parse the expression [${this.formatPrice(product.price)}]` xảy ra khi JSP cố gắng parse template literals JavaScript.

## 🚨 Vấn Đề Gặp Phải

### **Lỗi Chính:**
```
jakarta.el.ELException: The identifier [this] is not a valid Java identifier as required by section 1.19 of the EL specification
```

### **Nguyên Nhân:**
- JSP compiler cố gắng parse tất cả `${}` expressions trước khi JavaScript được thực thi
- Template literals JavaScript như `${this.formatPrice(product.price)}` không hợp lệ trong JSP EL
- JSP không thể hiểu `this` trong context của JavaScript

## ✅ **Giải Pháp Đã Áp Dụng**

### **1. Thay Thế Template Literals Bằng String Concatenation:**

**Trước (Lỗi):**
```javascript
// ❌ Không hoạt động trong JSP
price.textContent = `${this.formatPrice(product.price)}đ`;
title.textContent = `📦 Danh sách sản phẩm (${products.length} sản phẩm)`;
alert(`File ${file.name} không hợp lệ`);
```

**Sau (Đã Sửa):**
```javascript
// ✅ Hoạt động bình thường
price.textContent = this.formatPrice(product.price) + 'đ';
title.textContent = '📦 Danh sách sản phẩm (' + products.length + ' sản phẩm)';
alert('File ' + file.name + ' không hợp lệ');
```

### **2. Sửa Trong `web/components/chatbot.jsp`:**
- `addProductButton()`: Thay `${this.formatPrice(product.price)}đ` → `this.formatPrice(product.price) + 'đ'`
- `displayProducts()`: Thay template literal → string concatenation
- `showProductDetail()`: Thay template literal → string concatenation

### **3. Sửa Trong `web/views/admin.jsp`:**
- `validateFile()`: Thay template literals trong alert → string concatenation
- `displayImagePreview()`: Thay template literals trong console.error và alert

## 📁 Files Đã Sửa

### **1. `web/components/chatbot.jsp`**
- Sửa `addProductButton()` method
- Sửa `displayProducts()` method  
- Sửa `showProductDetail()` method
- Thay thế tất cả template literals bằng string concatenation

### **2. `web/views/admin.jsp`**
- Sửa `validateFile()` function
- Sửa `displayImagePreview()` function
- Thay thế template literals trong alert và console.error

## 🔧 Kỹ Thuật Sửa Lỗi

### **Quy Tắc Chung:**
1. **Không sử dụng template literals** `${}` trong JavaScript khi viết trong JSP
2. **Sử dụng string concatenation** với `+` operator
3. **Giữ nguyên JSP EL expressions** `${pageContext.request.contextPath}` trong HTML attributes

### **Ví Dụ Cụ Thể:**

**❌ Không Được:**
```javascript
// JSP sẽ cố gắng parse expression này và gây lỗi
const message = `Giá: ${this.formatPrice(price)}đ`;
const title = `Sản phẩm: ${product.name}`;
```

**✅ Được:**
```javascript
// Sử dụng string concatenation
const message = 'Giá: ' + this.formatPrice(price) + 'đ';
const title = 'Sản phẩm: ' + product.name;
```

**✅ JSP EL Expressions (Giữ Nguyên):**
```jsp
<!-- Đây là JSP EL expressions hợp lệ -->
<img src="${pageContext.request.contextPath}/logo.png" />
<a href="${pageContext.request.contextPath}/home">Home</a>
```

## 🚀 Kết Quả Sau Khi Sửa

### **Trước Khi Sửa:**
- ❌ Lỗi `jakarta.el.ELException` khi compile JSP
- ❌ Không thể load trang `/index.jsp`
- ❌ Stack trace dài với thông tin lỗi chi tiết

### **Sau Khi Sửa:**
- ✅ JSP compile thành công
- ✅ Trang `/index.jsp` load bình thường
- ✅ Chatbot hiển thị sản phẩm hoạt động
- ✅ Admin page upload ảnh hoạt động

## 🎯 Cách Tránh Lỗi Tương Lai

### **1. Khi Viết JavaScript Trong JSP:**
- **Không sử dụng** template literals `${}`
- **Sử dụng** string concatenation `+`
- **Kiểm tra** tất cả JavaScript code trước khi deploy

### **2. Khi Cần Dynamic Values:**
```javascript
// ❌ Không được
const url = `${baseUrl}/api/products`;

// ✅ Được
const url = baseUrl + '/api/products';
```

### **3. Khi Cần Format Complex Strings:**
```javascript
// ❌ Không được
const html = `<div class="${className}">${content}</div>`;

// ✅ Được
const html = '<div class="' + className + '">' + content + '</div>';
```

## 🐛 Troubleshooting

### **Nếu Gặp Lỗi Tương Tự:**

1. **Kiểm tra console log** để tìm dòng lỗi cụ thể
2. **Tìm tất cả template literals** `${}` trong JavaScript code
3. **Thay thế bằng string concatenation** `+`
4. **Test lại** để đảm bảo không còn lỗi

### **Debug Commands:**
```bash
# Tìm tất cả template literals trong JSP files
grep -r "\$\{.*\}" web/ --include="*.jsp"

# Tìm template literals trong JavaScript
grep -r "`.*\$\{.*\}`" web/ --include="*.jsp"
```

## 📚 Tài Liệu Tham Khảo

- [JSP EL Specification](https://docs.oracle.com/javaee/5/tutorial/doc/bnahq.html)
- [Jakarta EE EL Documentation](https://jakarta.ee/specifications/expression-language/)
- [JSP vs JavaScript Best Practices](https://docs.oracle.com/javaee/5/tutorial/doc/bnahq.html)

---

**Trạng thái**: Đã sửa xong ✅  
**Phiên bản**: 1.0  
**Ngày sửa**: $(date)

