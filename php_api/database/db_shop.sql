-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Sep 18, 2025 at 09:31 AM
-- Server version: 10.4.25-MariaDB
-- PHP Version: 8.0.23

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `customers`
--

INSERT INTO `customers` (`customer_id`, `firstName`, `lastName`, `phone`, `username`, `password`) VALUES
(16, 'มานะ', 'ดีใจ', '038743690', 'mana', '$2y$10$a/QExybkIKpUhPKC31565.cGz4HNcneb.iuYfkR/OLHXraAvdK0cO'),
(17, 'มะลิรัตน์', 'คนดี', '038475820', 'mali', '$2y$10$LhcejD2YFJl8nvfsO/1rducc0L1a2gKxJVTPZzpUyzS3JDSKcnlje'),
(18, 'สมหญิง', 'มีใจ', '0817458211', 'som', '$2y$10$CzI.b9IwcXToX.PMCa1.u.bVz.cDO9eG8XigjsNOYHaz3eIeLwN3u'),
(21, 'sdfs', 'dsfs', '3423', 'wer', '$2y$10$KrHBp/dg72coKlHoU//FOOuz2BwudE0RTNFcCXc4HqoZf2uvcPf1G'),
(22, 'sad', 'sd', '23421', 'sda', '$2y$10$sXCKukAcAKtT87V3ojB6XeVNJp0REaJnZZ0QuLr329dLDP9vyv.HG'),
(23, 'sad', 'sda', '242', 'sd', '$2y$10$gmNk/nvntgqmsFJLMGNVe.9gnzE6dESiy1a3FYZZ/Ig7ELy6ZR92C'),
(24, 'dsf', 'dsf', '21321', 'we', '$2y$10$j79s8s0n3FZNHhES16XlvuX.JYJHN0whFSJxXCcJ6c9Ru3etgbRYC'),
(25, 'asd', 'dsa', '2342', 'wer', '$2y$10$c7fVF67FEWz.KojxlzQtGO6Z/mdw5gykDLlMBC2PbdYZAqf20g.pu'),
(26, 'ำไพไ', 'ำไพ', '13213', 'ำไพไ', '$2y$10$ZT.YnxbPFZjv6ogBmHYhPeJ49iMJ9StbhcTYd/L/.QphRvicOX8ke'),
(27, 'sdfs', 'dfs', '342', 'ewr', '$2y$10$AFXUbmisFSTCBrNntBwYLOAKPFU9HsHaqElRhAw6716OdzdQwY6Aa'),
(28, 'ำไพ', 'ำพไ', '2342', 'ewr', '$2y$10$nxQWocaWYS6NtLL9X/80mu3xv8i9.5BQ1kpgmheZdmpl1ZtwCJ2.6'),
(29, 'dsf', 'fds', '2342', 'ewr', '$2y$10$00BCarcFjZBFs1F9hYrto.KldH05QBmSvsxZAognZGP19CrEw71qG'),
(30, 'สมาน ', 'มีตา', '038745820', 'sman', '$2y$10$B6hyHKvi8ZEJpRq5TNbsQe1Id8tiiwcPuBof3YiYYGRpNq4RnZplu'),
(31, 'sdfds', 'dsfs', '32423', 'dfs', '$2y$10$w38g45G2Dqcf804kWw/z/.I1iHyKDsOqu5acLga7/y8mtkytO1jHK');

-- --------------------------------------------------------

--
-- Table structure for table `orderdetails`
--

CREATE TABLE `orderdetails` (
  `order_detail_id` int(11) NOT NULL,
  `order_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `quantity` int(11) NOT NULL,
  `price` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `order_id` int(11) NOT NULL,
  `customer_id` int(11) NOT NULL,
  `total` decimal(10,2) NOT NULL,
  `order_date` timestamp NOT NULL DEFAULT current_timestamp(),
  `status` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`product_id`, `product_name`, `description`, `price`, `image`, `stock`, `created_at`) VALUES
(7, 'เครื่องคอมพิวเตอร์ PC', 'เครื่องคอมพิวเตอร์ PC Acer2400', '28000.00', '1757489972_p2.webp', 21, '2025-09-10 07:39:32'),
(8, 'หนังสือ AutoCAD', 'หนังสือวาดแบบ AutoCAD', '280.00', '1757561799_eq_637248bad2b6e.jpg', 20, '2025-09-11 03:36:39'),
(9, 'หมูเนื้อแดงรวมผัก', 'ชุด 1 หมูเนื้อแดงรวมผักสด', '250.00', '1758077855_p5.jpg', 50, '2025-09-17 02:57:35'),
(10, 'ชุด 2 ลูกชิ้น + หมูสามชั้น', 'ชุด 2 ลูกชิ้น + หมูสามชั้น', '199.00', '1758077915_p6.jpg', 20, '2025-09-17 02:58:35'),
(11, 'สันคอหมูรวมผัก', 'ชุด 3 สันคอหมูรวมผัก', '220.00', '1758077984_p7.jpg', 20, '2025-09-17 02:59:44'),
(12, 'การพัฒนาเว็บด้วย HTML', 'หนังสือสอนการพัฒนาเว็บไซต์ด้วย HTML', '299.00', '1758082138_eq_630ccad48e57c.jpg', 20, '2025-09-17 04:08:58'),
(13, 'ชาบูน้ำดำ หมู ผักสด', 'ชุด 5 ชาบูน้ำดำ หมู ผักสด', '250.00', '1758082507_p3.jpg', 20, '2025-09-17 04:15:07');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `customers`
--
ALTER TABLE `customers`
  ADD PRIMARY KEY (`customer_id`);

--
-- Indexes for table `orderdetails`
--
ALTER TABLE `orderdetails`
  ADD PRIMARY KEY (`order_detail_id`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`order_id`);

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
  MODIFY `customer_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=32;

--
-- AUTO_INCREMENT for table `orderdetails`
--
ALTER TABLE `orderdetails`
  MODIFY `order_detail_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `order_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `payments`
--
ALTER TABLE `payments`
  MODIFY `payment_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `product_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
