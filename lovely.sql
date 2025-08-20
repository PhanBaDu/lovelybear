-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3307
-- Generation Time: Aug 21, 2025 at 01:14 AM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.0.28

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `decor_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `carts`
--

CREATE TABLE `carts` (
  `id` int(11) NOT NULL,
  `user_email` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `carts`
--

INSERT INTO `carts` (`id`, `user_email`, `created_at`, `updated_at`) VALUES
(1, 'admin@gmail.com', '2025-08-19 18:42:47', '2025-08-20 23:10:31'),
(2, 'huyen@gmail.com', '2025-08-20 17:18:17', '2025-08-20 19:04:00');

-- --------------------------------------------------------

--
-- Table structure for table `cart_items`
--

CREATE TABLE `cart_items` (
  `id` int(11) NOT NULL,
  `cart_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `product_name` longtext NOT NULL,
  `product_description` longtext DEFAULT NULL,
  `price` decimal(10,2) NOT NULL,
  `quantity` int(11) NOT NULL DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `cart_items`
--

INSERT INTO `cart_items` (`id`, `cart_id`, `product_id`, `product_name`, `product_description`, `price`, `quantity`, `created_at`, `updated_at`) VALUES
(118, 1, 2, '[CHÍNH HÃNG 100%][HỎA TỐC] Labubu macaron V1 PM - Blindbox', '‼️‼️‼️  Hàng Chính Hãng 100% ‼️‼️‼️\r\n\r\n\r\n\r\nBộ sưu tập asty Macaron Vinyl Face – Vinyl Plush Doll từ PM mang đến những mô hình đồ chơi độc đáo và ấn tượng, lấy cảm hứng từ thiên nhiên hoang dã. \r\n\r\n\r\n\r\nTHÔNG TIN SẢN PHẨM :\r\n\r\n- Tên sản phẩm :Labubu macaron V1 - Blindbox\r\n\r\n- Thương hiệu : PM\r\n\r\n\r\n\r\n*** LƯU Ý QUAN TRỌNG *** \r\n\r\n● ĐÂY LÀ SẢN PHẨM ĐẶC THÙ, CẦN CÓ VIDEO KHI MỞ HÀNG SẼ KHÔNG ĐƯỢC ĐỔI TRẢ 📦\r\n\r\n\r\n\r\n🔥 HỖ TRỢ HỎA TỐC TẠI TP.HCM 🔥', 789.00, 1, '2025-08-20 23:10:31', '2025-08-20 23:10:31');

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `id` int(11) NOT NULL,
  `user_email` varchar(255) NOT NULL,
  `order_date` timestamp NOT NULL DEFAULT current_timestamp(),
  `total_quantity` int(11) NOT NULL,
  `total_amount` decimal(10,2) NOT NULL,
  `status` varchar(50) NOT NULL DEFAULT 'PENDING'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`id`, `user_email`, `order_date`, `total_quantity`, `total_amount`, `status`) VALUES
(1, 'admin@gmail.com', '2025-08-20 18:42:20', 6, 892.05, 'CANCELLED'),
(2, 'admin@gmail.com', '2025-08-20 18:43:40', 2, 678.95, 'CANCELLED'),
(3, 'admin@gmail.com', '2025-08-20 18:45:59', 2, 322.05, 'CANCELLED'),
(4, 'admin@gmail.com', '2025-08-20 18:49:25', 1, 499.40, 'CANCELLED'),
(5, 'admin@gmail.com', '2025-08-20 18:49:44', 1, 142.50, 'CANCELLED'),
(6, 'admin@gmail.com', '2025-08-20 18:51:38', 1, 499.40, 'CANCELLED'),
(7, 'admin@gmail.com', '2025-08-20 18:51:47', 1, 499.40, 'CONFIRMED'),
(8, 'huyen@gmail.com', '2025-08-20 18:57:26', 1, 789.00, 'CONFIRMED'),
(9, 'admin@gmail.com', '2025-08-20 21:02:07', 2, 968.55, 'CANCELLED'),
(10, 'admin@gmail.com', '2025-08-20 21:11:42', 1, 789.00, 'CANCELLED'),
(11, 'admin@gmail.com', '2025-08-20 21:24:18', 2, 968.55, 'PENDING'),
(12, 'admin@gmail.com', '2025-08-20 21:44:23', 1, 142.50, 'PENDING'),
(13, 'admin@gmail.com', '2025-08-20 21:45:42', 1, 179.55, 'PENDING'),
(14, 'admin@gmail.com', '2025-08-20 21:46:02', 1, 179.55, 'PENDING'),
(15, 'admin@gmail.com', '2025-08-20 21:46:40', 1, 789.00, 'PENDING'),
(16, 'admin@gmail.com', '2025-08-20 22:48:21', 1, 789.00, 'PENDING'),
(17, 'admin@gmail.com', '2025-08-20 23:13:26', 1, 179.55, 'PENDING');

-- --------------------------------------------------------

--
-- Table structure for table `order_items`
--

CREATE TABLE `order_items` (
  `id` int(11) NOT NULL,
  `order_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `product_name` varchar(500) NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `quantity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `order_items`
--

INSERT INTO `order_items` (`id`, `order_id`, `product_id`, `product_name`, `price`, `quantity`) VALUES
(1, 1, 5, 'Gấu Bông Sầu Riêng Cực Dễ Thương Có Thể Tách Ruột Bên Trong', 142.50, 5),
(2, 1, 4, 'Gấu Bông Cá Sấu Lông Xù Siêu To Khổng Lồ – Dài 1m2/1m5/1m7/2m', 179.55, 1),
(4, 2, 4, 'Gấu Bông Cá Sấu Lông Xù Siêu To Khổng Lồ – Dài 1m2/1m5/1m7/2m', 179.55, 1),
(5, 3, 4, 'Gấu Bông Cá Sấu Lông Xù Siêu To Khổng Lồ – Dài 1m2/1m5/1m7/2m', 179.55, 1),
(6, 3, 5, 'Gấu Bông Sầu Riêng Cực Dễ Thương Có Thể Tách Ruột Bên Trong', 142.50, 1),
(8, 5, 5, 'Gấu Bông Sầu Riêng Cực Dễ Thương Có Thể Tách Ruột Bên Trong', 142.50, 1),
(11, 8, 2, '[CHÍNH HÃNG 100%][HỎA TỐC] Labubu macaron V1 PM - Blindbox', 789.00, 1),
(12, 9, 2, '[CHÍNH HÃNG 100%][HỎA TỐC] Labubu macaron V1 PM - Blindbox', 789.00, 1),
(13, 9, 4, 'Gấu Bông Cá Sấu Lông Xù Siêu To Khổng Lồ – Dài 1m2/1m5/1m7/2m', 179.55, 1),
(14, 10, 2, '[CHÍNH HÃNG 100%][HỎA TỐC] Labubu macaron V1 PM - Blindbox', 789.00, 1),
(15, 11, 4, 'Gấu Bông Cá Sấu Lông Xù Siêu To Khổng Lồ – Dài 1m2/1m5/1m7/2m', 179.55, 1),
(16, 11, 2, '[CHÍNH HÃNG 100%][HỎA TỐC] Labubu macaron V1 PM - Blindbox', 789.00, 1),
(17, 12, 5, 'Gấu Bông Sầu Riêng Cực Dễ Thương Có Thể Tách Ruột Bên Trong', 142.50, 1),
(18, 13, 4, 'Gấu Bông Cá Sấu Lông Xù Siêu To Khổng Lồ – Dài 1m2/1m5/1m7/2m', 179.55, 1),
(19, 14, 4, 'Gấu Bông Cá Sấu Lông Xù Siêu To Khổng Lồ – Dài 1m2/1m5/1m7/2m', 179.55, 1),
(20, 15, 2, '[CHÍNH HÃNG 100%][HỎA TỐC] Labubu macaron V1 PM - Blindbox', 789.00, 1),
(21, 16, 2, '[CHÍNH HÃNG 100%][HỎA TỐC] Labubu macaron V1 PM - Blindbox', 789.00, 1),
(22, 17, 4, 'Gấu Bông Cá Sấu Lông Xù Siêu To Khổng Lồ – Dài 1m2/1m5/1m7/2m', 179.55, 1);

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `id` int(11) NOT NULL,
  `name` longtext NOT NULL,
  `description` longtext DEFAULT NULL,
  `price` decimal(10,2) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `name`, `description`, `price`, `created_at`, `updated_at`) VALUES
(2, '[CHÍNH HÃNG 100%][HỎA TỐC] Labubu macaron V1 PM - Blindbox', '‼️‼️‼️  Hàng Chính Hãng 100% ‼️‼️‼️\r\n\r\n\r\n\r\nBộ sưu tập asty Macaron Vinyl Face – Vinyl Plush Doll từ PM mang đến những mô hình đồ chơi độc đáo và ấn tượng, lấy cảm hứng từ thiên nhiên hoang dã. \r\n\r\n\r\n\r\nTHÔNG TIN SẢN PHẨM :\r\n\r\n- Tên sản phẩm :Labubu macaron V1 - Blindbox\r\n\r\n- Thương hiệu : PM\r\n\r\n\r\n\r\n*** LƯU Ý QUAN TRỌNG *** \r\n\r\n● ĐÂY LÀ SẢN PHẨM ĐẶC THÙ, CẦN CÓ VIDEO KHI MỞ HÀNG SẼ KHÔNG ĐƯỢC ĐỔI TRẢ 📦\r\n\r\n\r\n\r\n🔥 HỖ TRỢ HỎA TỐC TẠI TP.HCM 🔥', 789.00, '2025-08-19 18:44:25', '2025-08-19 18:44:25'),
(4, 'Gấu Bông Cá Sấu Lông Xù Siêu To Khổng Lồ – Dài 1m2/1m5/1m7/2m', 'Gấu Bông Cá Sấu Lông Xù Siêu To Khổng Lồ – Dài 1m2/1m5/1m7/2m\r\n\r\n\r\n\r\nXuất xứ: Việt Nam\r\n\r\nChất vải: Vải lông xù mịn cao cấp, mềm mại và êm ái\r\n\r\nChất liệu bông: Bông Silic đàn hồi, trắng tinh khiết\r\n\r\nKích thước: 120cm - 150cm – 170cm – 200cm\r\n\r\nMàu sắc: Xanh, Xám, Đen\r\n\r\n\r\n\r\nThiết kế và đặc điểm nổi bật\r\n\r\nThiết kế hình cá sấu siêu to khổng lồ với lớp lông xù dày mịn, tạo cảm giác cực kỳ mềm mại khi chạm vào.\r\n\r\nForm cá sấu thon dài, thân hình chắc chắn, ôm rất vừa tay, mang lại cảm giác thoải mái và thư giãn khi sử dụng.\r\n\r\nChất liệu vải cao cấp, không rụng lông, không gây kích ứng da, phù hợp với mọi lứa tuổi, kể cả trẻ em.\r\n\r\nRuột nhồi bông Silic có độ đàn hồi cao, giúp giữ phom dáng đẹp, không bị xẹp dù sử dụng lâu dài.\r\n\r\nKích thước đa dạng lên tới 2m, cực kỳ nổi bật khi trang trí trong phòng hoặc dùng làm gối ôm khi ngủ.\r\n\r\n\r\n\r\nCông dụng\r\n\r\nLà món quà độc đáo và ấn tượng dành tặng bạn bè, người thân, trẻ nhỏ trong các dịp đặc biệt như sinh nhật, Giáng sinh, lễ tình nhân.\r\n\r\nCó thể sử dụng làm gối ôm, vật trang trí cho phòng khách, phòng ngủ, sofa hoặc làm bạn đồng hành giúp xua tan căng thẳng.\r\n\r\nGây ấn tượng mạnh nhờ kích thước khủng và tạo điểm nhấn đáng yêu cho mọi không gian sống.\r\n\r\n\r\n\r\nLưu ý khi sử dụng và bảo quản\r\n\r\nĐặt gấu bông ở nơi khô ráo, thoáng mát, tránh nơi ẩm ướt vì sản phẩm có độ hút ẩm cao.\r\n\r\nGiặt sản phẩm định kỳ mỗi 2–3 tháng. Với size nhỏ có thể giặt máy ở chế độ nhẹ; với size lớn nên tháo bông và giặt riêng phần vỏ để dễ phơi và vệ sinh hiệu quả.\r\n\r\nNên sử dụng xà phòng hoặc nước giặt quần áo trẻ em để giữ độ mềm mại và màu sắc bền đẹp.\r\n\r\nPhơi gấu bông ở nơi có nắng mạnh để sản phẩm nhanh khô và khử khuẩn hiệu quả.\r\n\r\n\r\n\r\nQuy cách đóng gói\r\n\r\nSản phẩm được hút chân không, đóng gói cẩn thận, đảm bảo vận chuyển gọn gàng và an toàn.\r\n\r\nSau khi nhận hàng, chỉ cần vỗ nhẹ và đều để bông nở đều, gấu bông sẽ trở lại hình dáng ban đầu.\r\n\r\nSản phẩm có thể có sai số nhẹ về màu sắc và kích thước tùy thuộc ánh sáng và phương pháp đo khác nhau.\r\n\r\n\r\n\r\nHashtags\r\n\r\n#GấuBôngCáSấu #CáSấuLôngXù #ThúBôngKhổngLồ #GấuBông2m #GốiÔmCáSấu #ThúNhồiBôngCaoCấp #CáSấuSiêuTo #GấuBôngTrangTrí #GấuBôngChoBé', 179.55, '2025-08-19 18:48:25', '2025-08-19 18:48:25'),
(5, 'Gấu Bông Sầu Riêng Cực Dễ Thương Có Thể Tách Ruột Bên Trong', 'gấu bông sầu riêng với phong cách dễ thương có thể tách múi bạn có thể dùng làm quà tặng hoặc làm đồ chơi cho mình\r\n\r\nsize: 30cm - 40cm', 142.50, '2025-08-19 20:21:49', '2025-08-19 20:21:49');

-- --------------------------------------------------------

--
-- Table structure for table `product_images`
--

CREATE TABLE `product_images` (
  `id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `image_url` varchar(500) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `product_images`
--

INSERT INTO `product_images` (`id`, `product_id`, `image_url`, `created_at`) VALUES
(2, 2, '/uploads/products/5e7c0671-eb13-4b75-9026-687e5abd513e.webp', '2025-08-19 18:44:25'),
(4, 4, '/uploads/products/cbfc1d69-06d7-4c8e-9897-4adbaa35e9c7.webp', '2025-08-19 18:48:25'),
(5, 5, '/uploads/products/6e26727e-4940-4d16-987d-32e3203bd935.webp', '2025-08-19 20:21:49'),
(6, 5, '/uploads/products/d41e0571-6ce8-4821-a919-a1d85dd32e99.webp', '2025-08-19 20:21:49'),
(7, 5, '/uploads/products/52e44b41-5556-45d7-a84e-2642c41b9b34.webp', '2025-08-19 20:21:49'),
(8, 5, '/uploads/products/ac560e6e-4afe-4656-b533-f9f3cf3c7172.webp', '2025-08-19 20:21:49'),
(9, 5, '/uploads/products/ba2550dc-30bb-4825-bac8-0f98b4203388.webp', '2025-08-19 20:21:49'),
(10, 5, '/uploads/products/980434eb-e3d4-421d-998c-a15a9a89e501.webp', '2025-08-19 20:21:49'),
(11, 5, '/uploads/products/dd86285f-f44b-44c5-a21b-5c05ad3e3335.webp', '2025-08-19 20:21:49');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `email` varchar(255) NOT NULL,
  `sodienthoai` varchar(20) DEFAULT NULL,
  `fullName` varchar(255) NOT NULL,
  `pictureProfile` varchar(500) DEFAULT NULL,
  `address` varchar(500) DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `role` varchar(20) NOT NULL DEFAULT 'USER',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`email`, `sodienthoai`, `fullName`, `pictureProfile`, `address`, `password`, `role`, `created_at`, `updated_at`) VALUES
('admin@gmail.com', '0357013425', 'Nguyễn Thị Huyền', '/uploads/users/d1e13e41-f02f-40d4-8d1b-6d7de228f03c.jpg', 'nghệ an', '123123', 'ADMIN', '2025-08-19 17:53:27', '2025-08-19 18:40:39'),
('huyen@gmail.com', '1231231232', 'nguyen thi huyen', '/uploads/users/4df11975-dbc6-4c62-95dc-59da822c757b.webp', 'nghệ an', '123123', 'USER', '2025-08-20 16:42:05', '2025-08-20 16:42:05');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `carts`
--
ALTER TABLE `carts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_carts_user_email` (`user_email`),
  ADD KEY `idx_carts_created_at` (`created_at`),
  ADD KEY `idx_carts_updated_at` (`updated_at`);

--
-- Indexes for table `cart_items`
--
ALTER TABLE `cart_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_cart_items_cart_id` (`cart_id`),
  ADD KEY `idx_cart_items_product_id` (`product_id`),
  ADD KEY `idx_cart_items_created_at` (`created_at`),
  ADD KEY `idx_cart_items_updated_at` (`updated_at`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_orders_user_email` (`user_email`),
  ADD KEY `idx_orders_order_date` (`order_date`);

--
-- Indexes for table `order_items`
--
ALTER TABLE `order_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_order_items_order_id` (`order_id`),
  ADD KEY `fk_order_items_product` (`product_id`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`) USING HASH,
  ADD KEY `idx_products_name` (`name`(768)),
  ADD KEY `idx_products_created_at` (`created_at`);

--
-- Indexes for table `product_images`
--
ALTER TABLE `product_images`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_product_images_product_id` (`product_id`),
  ADD KEY `idx_product_images_created_at` (`created_at`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`email`),
  ADD UNIQUE KEY `sodienthoai` (`sodienthoai`),
  ADD KEY `idx_users_phone` (`sodienthoai`),
  ADD KEY `idx_users_role` (`role`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `carts`
--
ALTER TABLE `carts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `cart_items`
--
ALTER TABLE `cart_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=119;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `order_items`
--
ALTER TABLE `order_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `product_images`
--
ALTER TABLE `product_images`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `carts`
--
ALTER TABLE `carts`
  ADD CONSTRAINT `fk_carts_user` FOREIGN KEY (`user_email`) REFERENCES `users` (`email`) ON DELETE CASCADE;

--
-- Constraints for table `cart_items`
--
ALTER TABLE `cart_items`
  ADD CONSTRAINT `fk_cart_items_cart` FOREIGN KEY (`cart_id`) REFERENCES `carts` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_cart_items_product` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`);

--
-- Constraints for table `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `fk_orders_user` FOREIGN KEY (`user_email`) REFERENCES `users` (`email`) ON DELETE CASCADE;

--
-- Constraints for table `order_items`
--
ALTER TABLE `order_items`
  ADD CONSTRAINT `fk_order_items_order` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_order_items_product` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`);

--
-- Constraints for table `product_images`
--
ALTER TABLE `product_images`
  ADD CONSTRAINT `fk_product_images_product` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
