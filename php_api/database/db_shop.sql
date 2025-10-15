-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Oct 15, 2025 at 05:39 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.1.25

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `db_shop`
--

-- --------------------------------------------------------

--
-- Table structure for table `customers`
--

CREATE TABLE `customers` (
  `customer_id` int(11) NOT NULL,
  `firstName` varchar(50) NOT NULL,
  `lastName` varchar(50) NOT NULL,
  `phone` varchar(15) NOT NULL,
  `username` varchar(20) NOT NULL,
  `password` varchar(128) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `customers`
--

INSERT INTO `customers` (`customer_id`, `firstName`, `lastName`, `phone`, `username`, `password`) VALUES
(36, 'มานะ', 'ใจดี', '03874369', 'mana', '$2y$10$aKsKBq6skVkCWUALjKUr0u0LTqhO07kRtECcReV8KR.33XMlWQqDG'),
(37, 'มะลิร้ตน์', 'เกิดดี', '038743910', 'mali', '$2y$10$TFuV2F6DzYJC.NI6i3hbv.M2QpAPYzkVhuwNL7YwzPccGxDZvj.da'),
(40, 'เมษา', 'เด็กดี', '038745260', 'mesa', '$2y$10$qc8K6WsN0Uvvjk1ggaiWqOrs6z/XepMP6/NnaNgJdDH0709ha8BgC'),
(44, 'สมศรี', 'บุญมาก', '0389759810', 'somchi', '$2y$10$FZ1fzmwD81ic0FoRGgAnPuX9UEyILfVaQ03lguhSOfFmcmUXMMI5W'),
(47, 'AAA', 'BBB', '038743691', 'AAA', '$2y$10$iPT3FRIlJP/uPhyta9ynieEXjFMRFlIo4N/iiWvOzyn8m1B8I6KRK'),
(48, 'เมษา', 'เด็กดี', '038743690', 'mesa', '$2y$10$8ejhxNhpF9i4/fXBtKDTrOCVlD6yB/hGGJW7kseu4V5feYMgWnqr6');

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `id` int(10) UNSIGNED NOT NULL,
  `table_no` varchar(10) NOT NULL,
  `total_price` decimal(10,2) NOT NULL,
  `order_date` datetime NOT NULL,
  `status` varchar(20) DEFAULT 'pending'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`id`, `table_no`, `total_price`, `order_date`, `status`) VALUES
(6, '3', 648.00, '2025-10-15 21:46:19', 'pending'),
(7, '4', 898.00, '2025-10-15 21:47:29', 'pending'),
(8, '3', 1508.00, '2025-10-15 21:51:09', 'pending'),
(9, '2', 449.00, '2025-10-15 21:54:07', 'pending'),
(10, '2', 928.00, '2025-10-15 21:58:39', 'pending'),
(11, '1', 947.00, '2025-10-15 22:17:19', 'เสร็จแล้ว'),
(12, '1', 1098.00, '2025-10-15 22:18:37', 'เสร็จแล้ว');

-- --------------------------------------------------------

--
-- Table structure for table `order_items`
--

CREATE TABLE `order_items` (
  `id` int(10) UNSIGNED NOT NULL,
  `order_id` int(10) UNSIGNED NOT NULL,
  `product_id` int(11) NOT NULL,
  `quantity` int(11) NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `subtotal` decimal(10,2) NOT NULL,
  `status` varchar(20) NOT NULL COMMENT 'status'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `order_items`
--

INSERT INTO `order_items` (`id`, `order_id`, `product_id`, `quantity`, `price`, `subtotal`, `status`) VALUES
(1, 6, 9, 1, 250.00, 250.00, 'เสร็จแล้ว'),
(2, 6, 10, 2, 199.00, 398.00, 'เสร็จแล้ว'),
(3, 7, 10, 2, 199.00, 398.00, 'เสร็จแล้ว'),
(4, 7, 13, 2, 250.00, 500.00, 'เสร็จแล้ว'),
(5, 8, 13, 1, 250.00, 250.00, 'เสร็จแล้ว'),
(6, 8, 14, 2, 299.00, 598.00, 'เสร็จแล้ว'),
(7, 8, 11, 3, 220.00, 660.00, 'เสร็จแล้ว'),
(8, 9, 9, 1, 250.00, 250.00, ''),
(9, 9, 10, 1, 199.00, 199.00, ''),
(10, 10, 8, 1, 280.00, 280.00, 'เสร็จแล้ว'),
(11, 10, 9, 1, 250.00, 250.00, 'เสร็จแล้ว'),
(12, 10, 10, 2, 199.00, 398.00, 'เสร็จแล้ว'),
(13, 11, 9, 1, 250.00, 250.00, 'เสร็จแล้ว'),
(14, 11, 10, 2, 199.00, 398.00, 'เสร็จแล้ว'),
(15, 11, 17, 1, 299.00, 299.00, 'เสร็จแล้ว'),
(16, 12, 14, 2, 299.00, 598.00, 'เสร็จแล้ว'),
(17, 12, 9, 2, 250.00, 500.00, 'เสร็จแล้ว');

-- --------------------------------------------------------

--
-- Table structure for table `payments`
--

CREATE TABLE `payments` (
  `payment_id` int(11) NOT NULL,
  `order_id` int(11) NOT NULL,
  `payment_date` timestamp NOT NULL DEFAULT current_timestamp(),
  `amount` decimal(10,2) NOT NULL,
  `method` varchar(50) NOT NULL,
  `status` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `product_id` int(11) NOT NULL,
  `product_name` varchar(100) NOT NULL,
  `description` text DEFAULT NULL,
  `price` decimal(10,2) NOT NULL,
  `image` text DEFAULT NULL,
  `stock` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`product_id`, `product_name`, `description`, `price`, `image`, `stock`, `created_at`) VALUES
(7, 'เครื่องคอมพิวเตอร์ PC', 'เครื่องคอมพิวเตอร์ PC Acer2400', 28000.00, '1757489972_p2.webp', 21, '2025-09-10 07:39:32'),
(8, 'หนังสือ AutoCAD', 'หนังสือวาดแบบ AutoCAD', 280.00, '1757561799_eq_637248bad2b6e.jpg', 20, '2025-09-11 03:36:39'),
(9, 'หมูเนื้อแดงรวมผัก', 'ชุด 1 หมูเนื้อแดงรวมผักสด', 250.00, '1758077855_p5.jpg', 50, '2025-09-17 02:57:35'),
(10, 'ชุด 2 ลูกชิ้น + หมูสามชั้น', 'ชุด 2 ลูกชิ้น + หมูสามชั้น', 199.00, '1758077915_p6.jpg', 20, '2025-09-17 02:58:35'),
(11, 'สันคอหมูรวมผัก', 'ชุด 3 สันคอหมูรวมผัก', 220.00, '1758077984_p7.jpg', 20, '2025-09-17 02:59:44'),
(12, 'การพัฒนาเว็บด้วย HTML', 'หนังสือสอนการพัฒนาเว็บไซต์ด้วย HTML', 299.00, '1758082138_eq_630ccad48e57c.jpg', 20, '2025-09-17 04:08:58'),
(13, 'ชาบูน้ำดำ หมู ผักสด', 'ชุด 5 ชาบูน้ำดำ หมู ผักสด', 250.00, '1758082507_p3.jpg', 20, '2025-09-17 04:15:07'),
(14, 'ชุดรวมมิตรชาบู', 'รวมมิตร หมู ลูกชิ้น ผักสด', 299.00, '1758180812_p1.jpg', 20, '2025-09-18 07:33:32'),
(15, 'Galaxy Note', 'หนังสือสอนใช้งาน Galaxy Note', 250.00, '1758181345_eq_630ccb3cc1614.jpg', 20, '2025-09-18 07:42:25'),
(16, 'AAAA', 'BBBBB', 500.00, '1760496734_logo-spu.jpg', 24, '2025-09-25 03:39:41'),
(17, 'ออกแบบเว็บด้วย HTML', 'หนังสือเขียนโปรแกรมด้วย HTML', 299.00, '1760498309_eq_630ccad48e57c.jpg', 25, '2025-10-15 03:18:12'),
(19, 'กหด2', 'กหด2', 34.00, '1760498776_eq_63724948c175a.jpg', 23, '2025-10-15 03:25:56');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `customers`
--
ALTER TABLE `customers`
  ADD PRIMARY KEY (`customer_id`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `order_items`
--
ALTER TABLE `order_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `order_id` (`order_id`),
  ADD KEY `product_id` (`product_id`);

--
-- Indexes for table `payments`
--
ALTER TABLE `payments`
  ADD PRIMARY KEY (`payment_id`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`product_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `customers`
--
ALTER TABLE `customers`
  MODIFY `customer_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=50;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `order_items`
--
ALTER TABLE `order_items`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `payments`
--
ALTER TABLE `payments`
  MODIFY `payment_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `product_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `order_items`
--
ALTER TABLE `order_items`
  ADD CONSTRAINT `order_items_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `order_items_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
