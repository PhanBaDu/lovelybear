-- Tạo bảng giỏ hàng
CREATE TABLE IF NOT EXISTS carts (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_email VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_user_email (user_email),
    INDEX idx_created_at (created_at),
    INDEX idx_updated_at (updated_at)
);

-- Tạo bảng sản phẩm trong giỏ hàng
CREATE TABLE IF NOT EXISTS cart_items (
    id INT AUTO_INCREMENT PRIMARY KEY,
    cart_id INT NOT NULL,
    product_id INT NOT NULL,
    product_name VARCHAR(255) NOT NULL,
    product_description TEXT,
    price DECIMAL(10,2) NOT NULL,
    quantity INT NOT NULL DEFAULT 1,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (cart_id) REFERENCES carts(id) ON DELETE CASCADE,
    INDEX idx_cart_id (cart_id),
    INDEX idx_product_id (product_id),
    INDEX idx_created_at (created_at),
    INDEX idx_updated_at (updated_at)
);

-- Thêm dữ liệu mẫu (tùy chọn)
-- INSERT INTO carts (user_email) VALUES ('user@example.com');
-- INSERT INTO cart_items (cart_id, product_id, product_name, product_description, price, quantity) 
-- VALUES (1, 1, 'Sản phẩm mẫu', 'Mô tả sản phẩm mẫu', 100000.00, 2);
