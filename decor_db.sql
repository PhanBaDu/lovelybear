-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3307
-- Generation Time: Aug 21, 2025 at 07:29 AM
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
(7, 'COMBO 100 Tờ Tranh Dán tường Poster Anime decor góc học tập làm việc, Decal Manga One Piece, Blue Lock tranh Anime AZ', 'COMBO 100 Tờ Tranh Dán tường Poster Anime decor góc học tập làm việc, Decal Manga One Piece, Blue Lock tranh Anime AZ\r\n\r\n** THÔNG TIN SỐ KỸ THUẬT :\r\n\r\n- Chất liệu: Giấy decal bóc dán được\r\n\r\n- Kích thước giấy:\r\n\r\nA6: 100 x 150 mm\r\n\r\n- Loại tranh: Đen trắng\r\n\r\n- Sản xuất tại Việt Nam\r\n\r\n** HƯỚNG DẪN SỬ DỤNG :\r\n\r\n* Để dán tranh dán tường anime được chắc chắn khuyến khích bạn nên vệ sinh tường, vị trí cần dán để dán tường manga dính tốt hơn.\r\n\r\n------------\r\n\r\n* Lưu Ý:\r\n\r\n- Về việc phân loại truyện:\r\n\r\n+ Chọn theo phân loại mình muốn\r\n\r\n+ Mix truyện: Nghĩa là SHOP TỰ CHỌN TRUYỆN để mix cho bạn. \r\n\r\n+ In theo yêu cầu: Nghĩa là bạn có thể tự chọn truyện khác theo ý bạn , chỉ cần nhắn tin báo cho shop thui ạ (truyện gì cũng được ví dụ: Tokyo Revengers, My Hero Academia, Kakegurui, Attack On Titan, Fairy Tail, Conan, Re: Zero, One Punch Man, Black Clover, Dragon Ball...\r\n\r\n\r\n\r\nAnime AZ CAM KẾT:\r\n\r\n- Tranh dán tường anime giống 100% trong hình, ảnh cho thể bị chênh lệch 5-10% do ánh sáng chụp\r\n\r\n- Anime wall được nhân viên đóng hàng kiểm tra kĩ đủ số lượng trước khi giao\r\n\r\n- Hàng có sẵn, được đóng trong vòng nửa ngày khi bạn đặt đơn\r\n\r\n- Hoàn tiền nếu sản phẩm bị lỗi do nhà sản xuất\r\n\r\n- Giao hàng toàn quốc, nhận hàng thanh toán, hàng lỗi trả hàng\r\n\r\n- Hỗ trợ đổi theo quy định shopee', 10.00, '2025-08-21 05:18:36', '2025-08-21 05:18:36'),
(8, 'Đèn Ngủ Decor 3D Quả Cầu Pha Lê Phát Sáng Để Bàn, Quà Tặng Sinh Nhật, Qùa Tặng Giáng Sinh,', 'Đèn Ngủ Decor 3D Quả Cầu Pha Lê Phát Sáng Để Bàn, Quà Tặng Sinh Nhật,  Qùa Tặng Giáng Sinh, Quà Lưu Niệm, Bảo Hành 1 Năm\r\n\r\n\r\n\r\nThông Tin Sản Phẩm : \r\n\r\n-Màu sắc:  Màu sáng ấm cố định 1 màu vàng ấm\r\n\r\n-Chất liệu: Pha lê\r\n\r\n-Nguồn sáng : đèn Led\r\n\r\n-Công nghệ bề mặt: Đánh bóng\r\n\r\n-Kích thước : đường kính 6cm \r\n\r\n\r\n\r\nMô Tả Sản Phẩm :\r\n\r\n\r\n\r\n-Đảm bảo 100% sản phẩm mới, chất lượng cao.\r\n\r\n- Quả cầu pha lê phát sáng phong cách thời trang, thiết kế hấp dẫn.\r\n\r\n-Chất liệu pha lê trong suốt , màu sắc tươi sáng.\r\n\r\n-Sản phẩm sẽ là điểm nhấn đáng chú ý trong mọi ngóc ngách trong ngôi nhà của bạn.\r\n\r\n\r\n\r\nCÔNG DỤNG SẢN PHẨM\r\n\r\n- Quả cầu pha lê phát sáng với hình dáng bắt mắt thích hợp làm đèn trang trí phòng ngủ, phòng làm việc, bàn máy tính , trang trí phòng khách,…\r\n\r\n- Thích hợp làm quà tặng cho bạn bè và người thân vào những dịp sinh nhật , tốt nghiệp, giáng sinh, valentine, …\r\n\r\n-Quả cầu pha lê mới nhất, phụ kiện xinh đẹp, kiểu dáng thanh lịch, thưởng thức thị giác hoàn hảo.\r\n\r\n\r\n\r\n- Bộ bao gồm : \r\n\r\n1 Quà cầu pha lê\r\n\r\n1 Bộ đèn led Đế gỗ, Có cáp sạc USB\r\n\r\n\r\n\r\n------  SHOP CAM KẾT ------\r\n\r\n\r\n\r\n✅Chúng tôi cam kết mang đến cho khách hàng những sản phẩm tốt nhất trong tâm giá so với thị trường, mang lại sự hài lòng tuyệt đối cho khách hàng đã tin tưởng mua sản phẩm.\r\n\r\n\r\n\r\n✅	Quyền lợi khách hàng  là mục tiêu phát triển của chúng tôi.\r\n\r\n\r\n\r\n✅	Hình ảnh sản phẩm giống hình 100%\r\n\r\n\r\n\r\n✅	Sản phẩm được kiểm tra kĩ càng, nghiêm ngặt trước khi giao hàng\r\n\r\n\r\n\r\n✅	Đóng gói và giao hàng ngay khi nhận được đơn đặt hàng\r\n\r\n\r\n\r\n✅	Hoàn tiền ngay nếu sản phẩm không đúng như mô tả\r\n\r\n\r\n\r\n✅	Giao hàng toàn quốc, chấp nhận nhiều phương thức thanh toán\r\n\r\n\r\n\r\n✅	Gửi hàng siêu tốc\r\n\r\n\r\n\r\n✅	Hỗ trợ đổi trả 1:1 nếu sản phẩm có bất kì sai xót nào từ nhà cung cấp', 30.00, '2025-08-21 05:20:03', '2025-08-21 05:20:03'),
(9, 'Đèn LED Đứng Góc Tường Cảm Biến Âm Thanh Để Trang Trí, Decor Phòng Khách, Phòng Game, Phòng Ngủ', 'Đèn Ngủ LED Để Bàn Hoa Tulip Decor Vuông Tráng Gương Handmade Quà Tặng Sinh Nhật\r\n\r\n\r\n\r\n✔️ Đèn ngủ hình cây hoa tulip được làm thủ công 100% với thiết kế gọn gàng , xinh xắn sử dụng đèn led tiết kiệm điện và đế gỗ chắc chắn. đặc biệt đèn được thiết kế hình cây hoa rất tỉ mỉ , vừa làm đèn ngủ ban đêm , vừa làm đồ trang trí bàn làm việc hoặc kệ ban ngày . làm quà tặng ý nghĩa cho bạn gái , người thân , bạn bè .\r\n\r\n✔️ Kích thước:12x12cm và 10x10cm\r\n\r\n\r\n\r\n HƯỚNG DẪN LẮP ĐÈN :\r\n\r\n\r\n\r\n1. Luồn hoa vào chuỗi (từ dưới cùng);\r\n\r\n2. Dán bóng đèn vào hoa, kéo mặt còn lại từ khe hở giữa cánh hoa và xoay để cố định hoa;\r\n\r\n3. Nhỏ keo 502 xuống , thả nó xuống vùng trung tâm của đế, cắm lá vào và nhúng viên đá pha lê quanh lá. \r\n\r\n4. Dây đèn cho 13 bông hoa có thể dài, bạn có thể khoanh tròn chúng vào khe đế (lưu ý: giữ nó gần hoa, hoặc chụp đèn sẽ không che phủ tốt);\r\n\r\n\r\n\r\n LƯU Ý ; ĐÈN NGỦ CHƯA ĐƯỢC GHÉP SẴN , QUÝ KHÁCH VỀ PHẢI TỰ GHÉP Ạ !\r\n\r\n\r\n\r\nCAM KẾT:\r\n\r\n✔️ Liên tục cập nhật những mặt hàng mới nhất với giá cả rẻ nhất để khách hàng lựa chọn.\r\n\r\n✔️ Giao hàng tận nơi trên toàn quốc. Nhận hàng nhanh chóng tại nhà. \r\n\r\n✔️ Miễn phí ĐỔI TRẢ HÀNG TRONG VÒNG 7 NGÀY nếu sản phẩm có lỗi của shop.\r\n\r\n✔️ Hỗ trợ giải quyết đơn hàng trong thời gian sớm nhất với phương án tốt nhất.\r\n\r\n\r\n\r\n🍀 Nếu bạn hài lòng với sản phẩm và dịch vụ của Shop, hãy cho Shop xin đánh giá 5★ cùng hình ảnh sản phẩm trên tay bạn nha!\r\n\r\n\r\n\r\n🍀🍀 CẢM ƠN KHÁCH YÊU ĐÃ GHÉ THĂM VÀ ỦNG HỘ Ạ! 🍀🍀', 500.00, '2025-08-21 05:25:44', '2025-08-21 05:25:44'),
(10, 'Lọ hoa thạch cao cao cấp, Decor trang trí bàn học, bàn làm việc, nhà cửa, Quà tặng, Chụp ảnh sản phẩm - Dana Candle', '♡ THÔNG TIN SẢN PHẨM:\r\n\r\n〰️ Chất liệu: Ceramic\r\n\r\n〰️ Kích thước: \r\n\r\nM1: Cao 10cm, ngang 8cm\r\n\r\nM2: Cao 18cm, ngang 9cm\r\n\r\nM3: Cao 15cm, ngang 15cm\r\n\r\nM4: Cao 10cm, ngang 5cm\r\n\r\nM5: Cao 10cm, ngang 6cm\r\n\r\nM6: Cao 18.5cm, ngang 15cm\r\n\r\nP1: Cao 15cm, ngang 15cm\r\n\r\nP2: Cao 13cm, ngang 13cm\r\n\r\nP3: Cao 18cm, ngang 11\r\n\r\nP4: Cao 16cm, ngang 12cm\r\n\r\nP5: Cao 16cm, ngang 8cm\r\n\r\nBình Gấu: Cao 9.5cm, ngang 7cm\r\n\r\nBình Năm: Cao 13cm, ngang 12cm\r\n\r\nBình Bí: Cao 7.5cm, ngang 7.5cm\r\n\r\nBình bàn tay: Cao 14cm ngang 5cm\r\n\r\nHoa khô mini: Cao 15cm\r\n\r\n♡ ỨNG DỤNG:\r\n\r\n〰️ Đựng trang sức, để nến thơm, khay trang trí phòng ngủ,...\r\n\r\n〰️ Không những giúp không gian nhà bạn trở nên sang trọng, trang nhã mà còn phù hợp với nhiều không gian khác nhau.\r\n\r\n〰️ Phụ kiện chụp ảnh sản phẩm.\r\n\r\n〰️ Dễ dàng vệ sinh và sử dụng lại.\r\n\r\n♡ LƯU Ý VÀ BẢO QUẢN :\r\n\r\n- Lau chùi bằng khăn, cây phủi bụi để làm sạch bề mặt nếu bám bụi, tránh ngâm trong nước\r\n\r\n- Bảo quản nơi khô ráo\r\n\r\n- Khay được làm thủ công bằng vật liệu Eco Ceramic\r\n\r\n- Sản phẩm an toàn với cả trẻ em, không thấm nước độ bền cao\r\n\r\n- Vì là hàng thủ công nên mỗi sản phẩm đều là duy nhất, có thể có chút biến thể về màu sắc, hay bọt khí tuy nhiên đó không phải là lỗi và chúng tớ cố gắng giữ ở mức tối thiểu.\r\n\r\n- Không nên dùng cho máy rửa bát, vệ sinh bằng khăn ẩm.\r\n\r\n- Sản phẩm không có sẵn sẽ được làm sau khi nhận đơn, thời gian làm > 1 ngày\r\n\r\n#nenthom #nenthomphong #tinhdauthomphong #nentrangtri #nendecor #nensinhnhat #nendethuong #quasinhnhat #tinhdauthomphong #tinhdau', 120.00, '2025-08-21 05:26:26', '2025-08-21 05:26:26'),
(11, '(Mẫu Mới 25 cm) Tranh Cát Chuyển Động 3D Nghệ Thuật, Decor Trang Trí Nhà, Bàn Làm Việc, Quà Tặng Cao Cấp / / Stastore', '🎁🎁🎁 STARSTORE_THEGIOIQUATANG\r\n\r\n---------- Chuyên cung cấp gửi đến các bạn các mẫu 💝 QUÀ TẶNG Ý NGHĨA + LÃNG MẠN + ĐẸP + ĐỘC + LẠ 💝-------\r\n\r\n💝 Mô tả sản phẩm : TRANH CÁT CHẢY CHUYỂN ĐỘNG 3D SÁNG TẠO\r\n\r\n- Mẫu tranh cát mới, viền và đế thép thay viền nhựa cũ, sáng bóng, sang trọng đẹp mắt\r\n\r\n- Phong cách Bắc Âu, cát chảy mịn\r\n\r\n- Là một món quà tuyệt vời cho các dịp tân gia, sinh nhật, tiệc tùng cho bạn bè, dùng để decor, trang trí nhà cửa, phòng ngủ, bàn làm việc\r\n\r\n- Được làm bằng thủy tinh, cát màu, chất lỏng và nhựa, sản phẩm này có khả năng chống mài mòn và bền lâu.\r\n\r\n- Những gì sản phẩm này có thể cung cấp cho bạn là có thể thêm một số nét hiện đại vào vị trí của bạn với hiệu ứng 3D và thiết kế cát chảy, mang đến cho bạn sự thoải mái, thư giãn và điềm tĩnh.\r\n\r\n💝 Phân loại sản phẩm:\r\n\r\n- Size đường kính tranh : 25 cm\r\n\r\n- Sáu màu sắc để các bạn lựa chọn: Xanh Biển, Xanh Lam, Hồng Phấn, Đỏ, Đen xám tro, Vàng \r\n\r\n💝 Sản phẩm bao gồm:\r\n\r\n- Tranh cát \r\n\r\n- Chân đế đỡ bức tranh\r\n\r\n- Xi.lanh bơm hút bọt khí\r\n\r\n- Hộp xốp đựng sản phẩm, bao bì bắt mắt\r\n\r\n👍 Hướng dẫn sử dụng :\r\n\r\n- Với thiết kế decor gọn đẹp, là một tác phẩm nghệ thuật tinh tế, Mỗi 1 lần chảy sẽ cho ra các hình khác nhau tạo cảm giác thích thú và thoải mái\r\n\r\n- Để tranh cát trên đế tranh cho cát lắng đọng hết, lắc mạnh để tạo nhiều bọt khí li ti, bọt khí có tác dụng ngăn dòng chảy của cát, tranh chảy nhanh hay chậm tùy thuộc vào số lượng bọt khí nhiều hay ít. Dùng 2 tay quay 180 độ cho bọt khí dàn đều lên trên chặn ngang dòng cát chảy, sau đó đặt lên đế của khung tranh, tranh ổn định một lúc thì cát sẽ chảy xuống từ từ, nếu chạy chậm hoặc không chảy gõ nhẹ lên thành trên của tranh, cát sẽ tự động rơi xuống.\r\n\r\n- Cát chảy nhanh hay chậm phụ thuộc vào lượng bọt khí bên trong, khách hàng có thể tùy chỉnh tốc độ chảy của cát thông qua kim bơm (xi.lanh) để hút bớt bọt khí ra (cát chảy nhanh hơn) hoặc bơm thêm bọt khí vào (cát chạy chậm đi)\r\n\r\n👍 SHOP Còn rất nhiều loại ĐÈN LED TRANG TRÍ khác đẹp ngất ngây luôn. Khách có nhu cầu trang trí trong nhà hay trang trí ngoài trời thì cứ liên hệ Shop nhé ??\r\n\r\n★★★ BẢO HÀNH 1 đổi 1 trong 7 ngày đầu tiên★★★ \r\n\r\n     + Tất cả sản phẩm đều được thử trước khi gửi đi, nếu có lỗi hãy thông báo ngay với SHOP.\r\n\r\n     + Cam kết 100% đổi trả miễn phí nếu sản phẩm có lỗi từ nhà sản xuất.\r\n\r\n     + Bảo hành trong vòng 1 tháng từ ngày nhận hàng.\r\n\r\n     + Nếu có bất kì khiếu nại cần Shop hỗ trợ về sản phẩm, khi mở sản phẩm các Chị vui lòng quay lại video quá trình mở sản phẩm để được đảm bảo 100% đổi lại sản phẩm mới nếu Shop giao bị lỗi.\r\n\r\n#tranhcat3d #tranhcatchay #tranhcatlun #tranhcatchuyendong3D #tranhnghethuat #trangtri #decor #phongthuy #donghocat\r\n\r\n#tranhcat #tranhdonghocat #tranh3d #trangtri #banlamviec #quatang #quasinhnhat #quatangcaocap #doc #la #starstore #thegioiquatang', 300.00, '2025-08-21 05:27:37', '2025-08-21 05:27:37'),
(12, 'Đèn Led Tam Giác Trang Trí lắp ghép gắn tường RGB cảm biến âm thanh, kết nối APP, kèm củ sạc.', 'THÔNG TIN SẢN PHẨM \r\n\r\nSản phẩm là bộ gồm nhiều đèn tam giác ghép nối với nhau giúp bạn có thể trang trí không gian làm viêc, chơi game... một cách tuyệt vời nhất. Bộ đèn led với hơn 16 triệu màu, cảm ứng theo nhạc sẽ làm bạn thực sự hài lòng. \r\n\r\n- Tên sản phẩm: Đèn LED Tam Giác \r\n\r\n- Điện áp: 5VDC \r\n\r\n- Công suất: 10W (6 miếng) \r\n\r\n- Kích thước: 110 * 126 * 28mm \r\n\r\n- Chất liệu: nhựa ABS \r\n\r\nSản Phẩm gồm nhiều đền led tam giác ghép nối để trang trí và bộ thiết bị sử dụng đi kèm: \r\n\r\n- Miếng Tam Giác \r\n\r\n- 1 Dây nguồn 5V 2A + củ sạc\r\n\r\n- 1 Remote điều khiển \r\n\r\n- Thẻ kết nối \r\n\r\n- Miếng dán velcro \r\n\r\n- 1 sách hướng dẫn sử dụng \r\n\r\nLưu ý sử dụng \r\n\r\n- Sử dụng đúng nguồn điện. \r\n\r\n- Nên chọn không gian rộng và ít vật cản trong quá trình lắp đặt để tránh va chạm gây trầy xước ở bề mặt vỏ và ảnh. hưởng mạch điện. \r\n\r\n- Không đặt đèn ở không gian ngoài trời. Thiết bị chưa hỗ trợ chống nước. \r\n\r\n- Không vệ sinh đèn trực tiếp với nước. Chỉ nên dùng khăn mềm lau khi cần. \r\n\r\n- Một phần của sản phẩm này cần phải được lắp ráp, rất dễ dàng. \r\n\r\nVui lòng kiểm tra các phụ kiện vít trước khi lắp đặt.\r\n\r\n\r\n\r\nCHÍNH SÁCH BẢO HÀNH CỦA SHOP - HỖ TRỢ BẢO HÀNH ĐỔI HÀNG 7 NGÀY THEO CHÍNH SÁCH CỦA SHOPEE\r\n\r\n- Khi  lỗi do nhà sản xuất\r\n\r\n- Khi giao sai màu/ Sai mẫu khách đã đặt hàng\r\n\r\n- Khi giao thiếu hàng\r\n\r\n- Hỗ Trợ đổi trả nếu sản phẩm không đúng hình\r\n\r\n- BẢO HÀNH 3 THÁNG KỂ TỪ NGÀY BÁN\r\n\r\n#denledgantuong #dentamgiac #dennhaytheonhac #dendecor #decorpc #leddecorpc #leddecor #dentamgiacnhaytheonhac #dennhaytheonhac #dengantuong #dentuong #ledgantuong #leddecorgantuong #dentreotuong #dentamgiacdecor #ledtamgiac', 180.00, '2025-08-21 05:28:57', '2025-08-21 05:28:57');

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
(13, 7, '/uploads/products/23eb31fc-8ce6-4f33-965f-29ad83a921e9.webp', '2025-08-21 05:18:36'),
(14, 8, '/uploads/products/62e45b24-f3f6-4524-8f73-362f5c175a64.webp', '2025-08-21 05:20:03'),
(15, 9, '/uploads/products/6e5637a3-82b3-43b9-8366-e2caa49b4b52.webp', '2025-08-21 05:25:44'),
(16, 10, '/uploads/products/afeecb64-8e71-4997-a6d9-720913a63db9.webp', '2025-08-21 05:26:26'),
(17, 11, '/uploads/products/20830960-0021-4a6d-be30-cb7576ac90e6.webp', '2025-08-21 05:27:37'),
(18, 12, '/uploads/products/be412fda-2c1a-4ad2-927f-ed19c3bfb532.webp', '2025-08-21 05:28:57'),
(19, 12, '/uploads/products/2d681aea-969d-4b5d-a810-158f118a113f.webp', '2025-08-21 05:28:57'),
(20, 12, '/uploads/products/81d41bb6-1d53-48ad-92fc-bd285ce76d70.webp', '2025-08-21 05:28:57'),
(21, 12, '/uploads/products/da47afc7-b43b-430d-acb3-c3d548561067.webp', '2025-08-21 05:28:57');

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
('admin@gmail.com', '0357013424', 'Phan Bá Đủ', '/uploads/users/0a1f6222-4f23-41a7-b33f-0e888346e2c8.webp', 'Thừa thiên huế', '123123', 'ADMIN', '2025-08-21 05:16:09', '2025-08-21 05:16:28');

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=125;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT for table `order_items`
--
ALTER TABLE `order_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `product_images`
--
ALTER TABLE `product_images`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

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
