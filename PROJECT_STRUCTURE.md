# 🌳 Cấu trúc Project Decor

```
decor/
├── 📁 src/
│   └── 📁 java/
│       └── 📁 data/
│           ├── 📁 controllers/          # 🎮 Xử lý logic nghiệp vụ
│           │   ├── 📄 signInServlet.java        # Đăng nhập
│           │   ├── 📄 signUpServlet.java        # Đăng ký
│           │   ├── 📄 signOutServlet.java       # Đăng xuất
│           │   ├── 📄 adminServlet.java         # Quản lý admin
│           │   ├── 📄 addProductServlet.java    # Thêm sản phẩm
│           │   ├── 📄 ProductDetailServlet.java # Chi tiết sản phẩm
│           │   └── 📄 ImageServlet.java         # Serve ảnh
│           │
│           ├── 📁 models/               # 📋 Định nghĩa dữ liệu
│           │   ├── 📄 User.java                 # Model người dùng
│           │   ├── 📄 Product.java              # Model sản phẩm
│           │   └── 📄 ProductImage.java         # Model ảnh sản phẩm
│           │
│           ├── 📁 dao/                  # 🗄️ Truy cập database
│           │   ├── 📄 Database.java             # Connection pool
│           │   ├── 📄 UserDao.java              # Interface User DAO
│           │   ├── 📄 ProductDao.java           # Interface Product DAO
│           │   └── 📄 ProductImageDao.java      # Interface ProductImage DAO
│           │
│           ├── 📁 implementations/      # ⚙️ Triển khai DAO
│           │   ├── 📄 UserImplementation.java   # Triển khai User DAO
│           │   ├── 📄 ProductImplementation.java # Triển khai Product DAO
│           │   └── 📄 ProductImageImplementation.java # Triển khai ProductImage DAO
│           │
│           ├── 📁 utils/                # 🛠️ Tiện ích
│           │   ├── 📄 ImageUtils.java           # Xử lý ảnh
│           │   └── 📄 Base64Utils.java          # Chuyển đổi Base64
│           │
│           ├── 📁 listeners/            # 🔊 Event listeners
│           │   └── 📄 AppContextListener.java   # Khởi tạo ứng dụng
│           │
│           ├── 📁 driver/               # 🚗 Database driver
│           │   └── 📄 MySqlDriver.java          # MySQL connection
│           │
│           └── 📁 constants/            # 📌 Hằng số
│               └── 📄 Constants.java            # Các hằng số hệ thống
│
├── 📁 web/                              # 🌐 Web resources
│   ├── 📁 views/                        # 📄 Trang JSP chính
│   │   ├── 📄 index.jsp                 # Trang chủ
│   │   ├── 📄 signin.jsp                # Trang đăng nhập
│   │   ├── 📄 signup.jsp                # Trang đăng ký
│   │   ├── 📄 admin.jsp                 # Trang admin
│   │   └── 📄 product-detail.jsp        # Chi tiết sản phẩm
│   │
│   ├── 📁 components/                   # 🧩 Component tái sử dụng
│   │   ├── 📄 header.jsp                # Header chung
│   │   ├── 📄 footer.jsp                # Footer chung
│   │   ├── 📄 products.jsp              # Danh sách sản phẩm
│   │   ├── 📄 product.jsp               # Chi tiết sản phẩm
│   │   └── 📁 features/
│   │       ├── 📁 admin/
│   │       │   └── 📄 header.jsp        # Header admin
│   │       └── 📁 authentication/
│   │           └── 📄 header.jsp        # Header auth
│   │
│   ├── 📁 public/                       # 📂 Tài nguyên tĩnh
│   │   ├── 📁 assets/
│   │   │   ├── 📁 styles/
│   │   │   │   └── 📄 globals.css       # CSS chung
│   │   │   ├── 📁 js/
│   │   │   │   └── 📄 image-upload.js   # JavaScript upload ảnh
│   │   │   ├── 📁 images/
│   │   │   │   └── 📁 logo/
│   │   │   │       ├── 📄 logo-decor-primary.svg
│   │   │   │       └── 📄 logo.svg
│   │   │   ├── 📁 icons/
│   │   │   │   └── 📄 search.svg
│   │   │   └── 📁 fonts/
│   │   │       └── 📄 Inter_18pt-*.ttf  # Font Inter
│   │   └── 📄 logo-lovely.ico
│   │
│   ├── 📁 uploads/                      # 📸 Thư mục lưu ảnh
│   │   ├── 📁 users/                    # Ảnh profile user
│   │   │   └── 📄 *.png, *.jpg          # Ảnh user (UUID)
│   │   └── 📁 products/                 # Ảnh sản phẩm
│   │       └── 📄 *.png, *.jpg          # Ảnh sản phẩm (UUID)
│   │
│   ├── 📁 WEB-INF/                      # ⚙️ Cấu hình web
│   │   └── 📁 lib/                      # Thư viện JAR
│   │
│   ├── 📁 META-INF/                     # 📋 Metadata
│   │   └── 📄 context.xml               # Cấu hình context
│   │
│   └── 📄 index.jsp                     # Entry point
│
├── 📁 nbproject/                        # 🔧 Cấu hình NetBeans
│   ├── 📄 build-impl.xml
│   ├── 📄 genfiles.properties
│   ├── 📄 project.properties
│   ├── 📄 project.xml
│   └── 📁 private/
│
├── 📁 test/                             # 🧪 Thư mục test
├── 📄 build.xml                         # Ant build script
├── 📄 database_schema.sql               # 🗄️ Cấu trúc database
├── 📄 README.md                         # 📖 Hướng dẫn
└── 📄 TEST_CASES.md                     # 📋 Test cases
```

# 🎯 Chức năng chính theo module:

## 🔐 **Module Xác thực (Authentication)**
```
📁 Controllers: signInServlet, signUpServlet, signOutServlet
📁 Models: User
📁 DAO: UserDao, UserImplementation
📁 Views: signin.jsp, signup.jsp
📁 Components: header.jsp (auth)
```

## 🛍️ **Module Sản phẩm (Products)**
```
📁 Controllers: addProductServlet, ProductDetailServlet
📁 Models: Product, ProductImage
📁 DAO: ProductDao, ProductImageDao, ProductImplementation, ProductImageImplementation
📁 Views: admin.jsp, product-detail.jsp
📁 Components: products.jsp, product.jsp
```

## 👨‍💼 **Module Admin**
```
📁 Controllers: adminServlet
📁 Views: admin.jsp
📁 Components: admin/header.jsp
```

## 🖼️ **Module Quản lý ảnh (Image Management)**
```
📁 Controllers: ImageServlet
📁 Utils: ImageUtils, Base64Utils
📁 Listeners: AppContextListener
📁 Uploads: users/, products/
```

## 🏠 **Module Trang chủ (Home)**
```
📁 Views: index.jsp
📁 Components: header.jsp, footer.jsp, products.jsp
```

# 🔄 **Luồng dữ liệu:**

## 1. **Đăng ký User:**
```
signup.jsp → signUpServlet → ImageUtils → UserImplementation → Database
```

## 2. **Thêm Sản phẩm:**
```
add-product form → addProductServlet → ImageUtils → ProductImplementation → Database
```

## 3. **Hiển thị ảnh:**
```
<img src="/uploads/..."> → ImageServlet → File system
```

# 🗄️ **Database Schema:**
```
📊 users (email, fullName, pictureProfile, ...)
📊 products (id, name, description, price, ...)
📊 product_images (id, product_id, image_url, ...)
```

# 🎨 **Giao diện người dùng:**
```
🌐 Public: index.jsp, signin.jsp, signup.jsp, product-detail.jsp
👨‍💼 Admin: admin.jsp, add-product form
🧩 Components: header, footer, products, product
```
