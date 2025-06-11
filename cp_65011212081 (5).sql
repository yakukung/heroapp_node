-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Jun 08, 2025 at 10:31 PM
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
-- Table structure for table `login_history`
--

CREATE TABLE `login_history` (
  `log_id` int NOT NULL,
  `uid` int NOT NULL,
  `login_time` datetime(3) DEFAULT CURRENT_TIMESTAMP(3),
  `ip_address` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_agent` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `id` int NOT NULL,
  `title` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `authorId` int NOT NULL,
  `rating` double DEFAULT NULL,
  `price` double DEFAULT NULL,
  `imageUrl` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `title`, `authorId`, `rating`, `price`, `imageUrl`) VALUES
(1, 'ชีทสรุปรวมคำสั่ง SQL', 1, 4.6, 150, 'https://optim.tildacdn.one/tild6238-3035-4335-a333-306335373139/-/format/webp/IMG_3349.jpg.webp'),
(2, 'ชีทสรุปแคลคูลัส', 1, 4.9, 0, 'https://miro.medium.com/v2/resize:fit:4800/format:webp/1*RJ8DZD1b-ipwDENqdK3WRA.png'),
(3, 'ชีทสรุป HTML & CSS', 1, 4.8, 99, 'https://cdn-icons-png.flaticon.com/512/732/732212.png'),
(4, 'ชีทสรุป Python เบื้องต้น', 1, 4.5, 0, 'https://149860134.v2.pressablecdn.com/wp-content/uploads/pythoned.png');

-- --------------------------------------------------------

--
-- Table structure for table `purchase_history`
--

CREATE TABLE `purchase_history` (
  `purchase_id` int NOT NULL,
  `uid` int NOT NULL,
  `product_id` int NOT NULL,
  `purchase_date` datetime(3) DEFAULT CURRENT_TIMESTAMP(3),
  `total_price` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `uid` int NOT NULL,
  `username` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `profile_image` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `type` tinyint NOT NULL DEFAULT '0'
) ;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`uid`, `username`, `email`, `password`, `profile_image`, `type`) VALUES
(1, 'yakukung', 'yakukung@gmail.com', '$2b$12$mkPAGBkbZbpchcxpt3YKDe49qVjxv.vKbGYdxb.npYkXbbqWs5ERi', 'https://wutheringlab.com/wp-content/uploads/Brant.webp', 0),
(2, 'test1', 'test1@gmail.com', '$2b$12$xM0rEI9N0e7e1i/vjxpOfOOLunfV6Inwf539b/uUImzwP32XG27Pq', 'https://wutheringlab.com/wp-content/uploads/Shorekeeper-icon.webp', 0),
(3, 'test2', 'test2@gmail.com', '$2b$12$j0VoYRQ.adyxPCbaWjXCvO3gC0D6Qwsw92VnmwbMzMhzGRf0gZQga', NULL, 0),
(6, 'yinlin', 'yinling@gmail.com', '$2b$12$ULVfqIeNJHU8CdVwAC4UaexxNuyRorXXb8SbO9HAV.6clJF.ErUlm', NULL, 0),
(7, 'changli', 'changli@gmail.com', '$2b$12$QzHwNuA55R/kXurwhU6eluZAE9Zq3sSrNTV9eie5xcjTP4FvcHz2.', 'https://firebasestorage.googleapis.com/v0/b/web-project-term2.appspot.com/o/7%2Fprofile%2F1747068872874.jpg?alt=media&token=57cde5cb-aeb5-4f4f-bf28-85a6b5d23a44', 0),
(8, 'changl', 'changli@hotmail.com', '$2b$12$EevHC.0gTYjFvbKLC/b4uuBqYoU3O9Dftm5xb.8.yHW8JliHLN6K.', NULL, 0),
(9, 'zani', 'zani@gmail.com', '$2b$12$eZisH2fpfTsPcW5Qhu15XOAXZVCmeTc1PqodWNPWjJqal78fYDeBO', 'https://firebasestorage.googleapis.com/v0/b/web-project-term2.appspot.com/o/9%2Fprofile%2F1747129030620.jpg?alt=media&token=c93297eb-cd5c-4803-a9bb-48ab1f4348e5', 0),
(10, 'shorekeeper', 'shore@gmail.com', '$2b$12$iz5wOfLuD1oJXYuIVtER1.sjfX6G4KZlY0ia6TNHX5XSnjLIqOicO', 'https://firebasestorage.googleapis.com/v0/b/web-project-term2.appspot.com/o/10%2Fprofile%2F1747236884617.jpg?alt=media&token=f1a37760-0024-4851-8e95-ff60b86af2de', 0);

-- --------------------------------------------------------

--
-- Table structure for table `user_favorites`
--

CREATE TABLE `user_favorites` (
  `favorite_id` int NOT NULL,
  `uid` int NOT NULL,
  `product_id` int NOT NULL,
  `added_date` datetime(3) DEFAULT CURRENT_TIMESTAMP(3)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `login_history`
--
ALTER TABLE `login_history`
  ADD PRIMARY KEY (`log_id`),
  ADD KEY `login_history_uid_idx` (`uid`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`),
  ADD KEY `products_authorId_fkey` (`authorId`);

--
-- Indexes for table `purchase_history`
--
ALTER TABLE `purchase_history`
  ADD PRIMARY KEY (`purchase_id`),
  ADD KEY `purchase_history_uid_idx` (`uid`),
  ADD KEY `purchase_history_product_id_idx` (`product_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`uid`),
  ADD UNIQUE KEY `unique_username` (`username`),
  ADD UNIQUE KEY `unique_email` (`email`);

--
-- Indexes for table `user_favorites`
--
ALTER TABLE `user_favorites`
  ADD PRIMARY KEY (`favorite_id`),
  ADD UNIQUE KEY `user_product_unique` (`uid`,`product_id`),
  ADD KEY `user_favorites_product_id_idx` (`product_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `login_history`
--
ALTER TABLE `login_history`
  MODIFY `log_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `purchase_history`
--
ALTER TABLE `purchase_history`
  MODIFY `purchase_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `uid` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `user_favorites`
--
ALTER TABLE `user_favorites`
  MODIFY `favorite_id` int NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `login_history`
--
ALTER TABLE `login_history`
  ADD CONSTRAINT `login_history_uid_fkey` FOREIGN KEY (`uid`) REFERENCES `users` (`uid`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `products`
--
ALTER TABLE `products`
  ADD CONSTRAINT `products_authorId_fkey` FOREIGN KEY (`authorId`) REFERENCES `users` (`uid`) ON DELETE RESTRICT ON UPDATE CASCADE;

--
-- Constraints for table `purchase_history`
--
ALTER TABLE `purchase_history`
  ADD CONSTRAINT `purchase_history_product_id_fkey` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  ADD CONSTRAINT `purchase_history_uid_fkey` FOREIGN KEY (`uid`) REFERENCES `users` (`uid`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `user_favorites`
--
ALTER TABLE `user_favorites`
  ADD CONSTRAINT `user_favorites_product_id_fkey` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `user_favorites_uid_fkey` FOREIGN KEY (`uid`) REFERENCES `users` (`uid`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
