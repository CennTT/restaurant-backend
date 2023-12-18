-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Dec 18, 2023 at 01:18 PM
-- Server version: 5.7.36
-- PHP Version: 7.4.26

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

DROP TABLE IF EXISTS `alembic_version`;
CREATE TABLE IF NOT EXISTS `alembic_version` (
  `version_num` varchar(32) NOT NULL,
  PRIMARY KEY (`version_num`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `alembic_version`
--

INSERT INTO `alembic_version` (`version_num`) VALUES
('4536b6820a75');

-- --------------------------------------------------------

--
-- Table structure for table `food_and_beverage`
--

DROP TABLE IF EXISTS `food_and_beverage`;
CREATE TABLE IF NOT EXISTS `food_and_beverage` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `type` varchar(20) DEFAULT NULL,
  `price` float DEFAULT NULL,
  `path` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=44 DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `food_and_beverage`
--

INSERT INTO `food_and_beverage` (`id`, `name`, `type`, `price`, `path`) VALUES
(1, 'Pizza', 'food', 70000, 'foods/pizza.png'),
(2, 'Burger', 'food', 36000, 'foods/burger.png'),
(3, 'Salad', 'food', 25000, 'foods/salad.png'),
(4, 'Pasta', 'food', 35000, 'foods/pasta.png'),
(6, 'Steak', 'food', 45000, 'foods/steak.png'),
(7, 'Sushi', 'food', 30000, 'foods/sushi.png'),
(8, 'Tacos', 'food', 20000, 'foods/tacos.png'),
(10, 'Ramen', 'food', 30000, 'foods/ramen.png'),
(16, 'Coffee', 'beverage', 10000, 'beverages/coffee.png'),
(17, 'Tea', 'beverage', 10000, 'beverages/tea.png'),
(18, 'Soda', 'beverage', 7000, 'beverages/soda.png'),
(21, 'Beer', 'beverage', 12000, 'beverages/beer.png'),
(24, 'Lemonade', 'beverage', 12000, 'beverages/lemonade.png'),
(25, 'Milkshake', 'beverage', 15000, 'beverages/milkshake.png'),
(27, 'Hot Chocolate', 'beverage', 13000, 'beverages/hot_chocolate.png');

-- --------------------------------------------------------

--
-- Table structure for table `order`
--

DROP TABLE IF EXISTS `order`;
CREATE TABLE IF NOT EXISTS `order` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `table_number` int(11) DEFAULT NULL,
  `status` varchar(20) DEFAULT NULL,
  `total_price` float DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4;

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

DROP TABLE IF EXISTS `order_item`;
CREATE TABLE IF NOT EXISTS `order_item` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `order_id` int(11) DEFAULT NULL,
  `item_id` int(11) DEFAULT NULL,
  `quantity` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `item_id` (`item_id`),
  KEY `order_id` (`order_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4;

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
