-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Dec 18, 2023 at 06:11 AM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.1.17

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `restaurant`
--

-- --------------------------------------------------------

--
-- Table structure for table `alembic_version`
--

CREATE TABLE `alembic_version` (
  `version_num` varchar(32) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `alembic_version`
--

INSERT INTO `alembic_version` (`version_num`) VALUES
('4536b6820a75');

-- --------------------------------------------------------

--
-- Table structure for table `food_and_beverage`
--

CREATE TABLE `food_and_beverage` (
  `id` int(11) NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  `type` varchar(20) DEFAULT NULL,
  `price` float DEFAULT NULL,
  `path` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `food_and_beverage`
--

INSERT INTO `food_and_beverage` (`id`, `name`, `type`, `price`, `path`) VALUES
(1, 'Pizza', 'food', 70000, NULL),
(2, 'Burger', 'food', NULL, NULL),
(3, 'Salad', 'food', NULL, NULL),
(4, 'Pasta', 'food', NULL, NULL),
(5, 'Sandwich', 'food', NULL, NULL),
(6, 'Steak', 'food', NULL, NULL),
(7, 'Sushi', 'food', NULL, NULL),
(8, 'Tacos', 'food', NULL, NULL),
(9, 'Fried Chicken', 'food', NULL, NULL),
(10, 'Ramen', 'food', NULL, NULL),
(11, 'Lasagna', 'food', NULL, NULL),
(12, 'Curry', 'food', NULL, NULL),
(13, 'Burrito', 'food', NULL, NULL),
(14, 'Grilled Cheese', 'food', NULL, NULL),
(15, 'Pad Thai', 'food', NULL, NULL),
(16, 'Coffee', 'beverage', NULL, NULL),
(17, 'Tea', 'beverage', NULL, NULL),
(18, 'Soda', 'beverage', NULL, NULL),
(19, 'Juice', 'beverage', NULL, NULL),
(20, 'Smoothie', 'beverage', NULL, NULL),
(21, 'Beer', 'beverage', NULL, NULL),
(22, 'Wine', 'beverage', NULL, NULL),
(23, 'Cocktail', 'beverage', NULL, NULL),
(24, 'Lemonade', 'beverage', NULL, NULL),
(25, 'Milkshake', 'beverage', NULL, NULL),
(26, 'Iced Tea', 'beverage', NULL, NULL),
(27, 'Hot Chocolate', 'beverage', NULL, NULL),
(28, 'Limeade', 'beverage', NULL, NULL),
(29, 'Iced Coffee', 'beverage', NULL, NULL),
(30, 'Margarita', 'beverage', NULL, NULL),
(34, 'Babi Guling', 'food', NULL, NULL),
(35, 'Ayam Betutu', 'food', 15000, NULL),
(38, 'Ikan Nyatnyat', 'food', NULL, NULL),
(39, 'Plecing Kangkung', 'food', 5000, NULL),
(40, 'Ayam Geprek', 'food', NULL, NULL),
(42, 'Sate Babi', 'food', 15000, NULL),
(43, 'Nasi Kuning', 'food', 5000, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `order`
--

CREATE TABLE `order` (
  `id` int(11) NOT NULL,
  `table_number` int(11) DEFAULT NULL,
  `status` varchar(20) DEFAULT NULL,
  `total_price` float DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `order`
--

INSERT INTO `order` (`id`, `table_number`, `status`, `total_price`) VALUES
(1, 7, 'open', NULL),
(2, 9, 'open', 0);

-- --------------------------------------------------------

--
-- Table structure for table `order_item`
--

CREATE TABLE `order_item` (
  `id` int(11) NOT NULL,
  `order_id` int(11) DEFAULT NULL,
  `item_id` int(11) DEFAULT NULL,
  `quantity` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `order_item`
--

INSERT INTO `order_item` (`id`, `order_id`, `item_id`, `quantity`) VALUES
(1, 1, 1, 4),
(2, 1, 3, 1),
(3, 1, 4, 1),
(4, 2, 1, 3),
(5, 2, 3, 3);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `alembic_version`
--
ALTER TABLE `alembic_version`
  ADD PRIMARY KEY (`version_num`);

--
-- Indexes for table `food_and_beverage`
--
ALTER TABLE `food_and_beverage`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `order`
--
ALTER TABLE `order`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `order_item`
--
ALTER TABLE `order_item`
  ADD PRIMARY KEY (`id`),
  ADD KEY `item_id` (`item_id`),
  ADD KEY `order_id` (`order_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `food_and_beverage`
--
ALTER TABLE `food_and_beverage`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=44;

--
-- AUTO_INCREMENT for table `order`
--
ALTER TABLE `order`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `order_item`
--
ALTER TABLE `order_item`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `order_item`
--
ALTER TABLE `order_item`
  ADD CONSTRAINT `order_item_ibfk_1` FOREIGN KEY (`item_id`) REFERENCES `food_and_beverage` (`id`),
  ADD CONSTRAINT `order_item_ibfk_2` FOREIGN KEY (`order_id`) REFERENCES `order` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
