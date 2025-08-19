-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Máy chủ: 127.0.0.1:3307
-- Thời gian đã tạo: Th8 19, 2025 lúc 11:04 PM
-- Phiên bản máy phục vụ: 10.4.28-MariaDB
-- Phiên bản PHP: 8.0.28

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Cơ sở dữ liệu: `decor_db`
--

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `product_images`
--

CREATE TABLE `product_images` (
  `id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `image_url` varchar(500) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `product_images`
--

INSERT INTO `product_images` (`id`, `product_id`, `image_url`, `created_at`) VALUES
(1, 1, '/uploads/products/da05a1e2-236e-4fa7-aea1-215ae556daf1.webp', '2025-08-19 18:42:10'),
(2, 2, '/uploads/products/5e7c0671-eb13-4b75-9026-687e5abd513e.webp', '2025-08-19 18:44:25'),
(3, 3, '/uploads/products/d2a1f081-b6a5-48ba-9323-1ec484ef481a.webp', '2025-08-19 18:45:05'),
(4, 4, '/uploads/products/cbfc1d69-06d7-4c8e-9897-4adbaa35e9c7.webp', '2025-08-19 18:48:25'),
(5, 5, '/uploads/products/6e26727e-4940-4d16-987d-32e3203bd935.webp', '2025-08-19 20:21:49'),
(6, 5, '/uploads/products/d41e0571-6ce8-4821-a919-a1d85dd32e99.webp', '2025-08-19 20:21:49'),
(7, 5, '/uploads/products/52e44b41-5556-45d7-a84e-2642c41b9b34.webp', '2025-08-19 20:21:49'),
(8, 5, '/uploads/products/ac560e6e-4afe-4656-b533-f9f3cf3c7172.webp', '2025-08-19 20:21:49'),
(9, 5, '/uploads/products/ba2550dc-30bb-4825-bac8-0f98b4203388.webp', '2025-08-19 20:21:49'),
(10, 5, '/uploads/products/980434eb-e3d4-421d-998c-a15a9a89e501.webp', '2025-08-19 20:21:49'),
(11, 5, '/uploads/products/dd86285f-f44b-44c5-a21b-5c05ad3e3335.webp', '2025-08-19 20:21:49');

--
-- Chỉ mục cho các bảng đã đổ
--

--
-- Chỉ mục cho bảng `product_images`
--
ALTER TABLE `product_images`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_product_images_product_id` (`product_id`),
  ADD KEY `idx_product_images_created_at` (`created_at`);

--
-- AUTO_INCREMENT cho các bảng đã đổ
--

--
-- AUTO_INCREMENT cho bảng `product_images`
--
ALTER TABLE `product_images`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- Các ràng buộc cho các bảng đã đổ
--

--
-- Các ràng buộc cho bảng `product_images`
--
ALTER TABLE `product_images`
  ADD CONSTRAINT `fk_product_images_product` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
