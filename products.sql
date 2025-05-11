-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: May 11, 2025 at 05:58 PM
-- Server version: 8.0.20-0ubuntu0.19.10.1
-- PHP Version: 7.3.11-0ubuntu0.19.10.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `cp_65011212081`
--

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `id` int NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `author` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `rating` float DEFAULT NULL,
  `price` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `image_url` text COLLATE utf8mb4_unicode_ci,
  `is_favorite` tinyint DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `title`, `author`, `rating`, `price`, `image_url`, `is_favorite`) VALUES
(1, 'ชีทสรุปรวมคำสั่ง SQL', 'สมพงษ์', 4.7, '150 บาท', 'https://upload.wikimedia.org/wikipedia/commons/8/87/Sql_data_base_with_logo.png', 1),
(2, 'ชีทสรุปแคลคูลัส', 'สมพงษ์', 4.9, 'ฟรี', 'https://medium.com/@kkjitesh/calculus-part-1-foundation-73b2ce71d1d7', 0),
(3, 'ชีทสรุป HTML & CSS', 'สมใจ', 4.8, '99 บาท', 'https://cdn-icons-png.flaticon.com/512/732/732212.png', 0),
(4, 'ชีทสรุป Python เบื้องต้น', 'สมหญิง', 4.6, 'ฟรี', 'https://quantumzeitgeist.com/why-is-the-python-programming-language-so-popular/', 0);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
