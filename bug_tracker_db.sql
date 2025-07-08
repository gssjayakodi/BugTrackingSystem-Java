-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jul 08, 2025 at 07:45 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `bug_tracker_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `bugs`
--

CREATE TABLE `bugs` (
  `id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `steps` text NOT NULL,
  `expected` text DEFAULT NULL,
  `actual` text DEFAULT NULL,
  `priority` varchar(50) NOT NULL,
  `severity` varchar(50) DEFAULT NULL,
  `environment` varchar(255) DEFAULT NULL,
  `status` varchar(50) DEFAULT 'New',
  `reporter` varchar(100) DEFAULT NULL,
  `assigned_to` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `bugs`
--

INSERT INTO `bugs` (`id`, `title`, `description`, `steps`, `expected`, `actual`, `priority`, `severity`, `environment`, `status`, `reporter`, `assigned_to`, `created_at`, `updated_at`) VALUES
(2, 'Login page error', 'Login button does not respond on click.', '1. Open login page\r\n2. Enter valid credentials\r\n3. Click login button', 'User should be redirected to dashboard', 'Nothing happens on button click', 'High', 'Major', 'Windows 10, Chrome 113', 'Open', 'alice@example.com', 3, '2025-07-07 17:52:44', '2025-07-08 01:50:17'),
(3, 'Crash on file upload', 'Application crashes when uploading large files over 50MB.', '', '', '', 'Critical', 'Blocker', '', 'In Progress', 'bob@example.com', 2, '2025-07-07 17:52:44', '2025-07-08 04:07:29'),
(4, 'Incorrect total price calculation', 'Shopping cart shows wrong total when discount applied.', '1. Add 3 items to cart\n2. Apply 10% discount coupon', 'Total price should reflect discount', 'Total price remains the same without discount', 'Medium', 'Minor', 'Android 11, Chrome Mobile', 'In Progress', 'charlie@example.com', 3, '2025-07-07 17:52:44', '2025-07-08 04:07:56'),
(5, 'Profile picture not updating', 'User cannot change profile picture, upload fails silently.', '1. Go to profile page\n2. Upload new picture\n3. Save changes', 'Profile picture updates immediately', 'No change, old picture stays', 'Low', 'Trivial', 'Windows 11, Edge 114', 'Resolved', 'diana@example.com', 1, '2025-07-07 17:52:44', '2025-07-07 17:52:44'),
(6, 'Search functionality slow', 'Search results take more than 10 seconds to load.', '1. Type keyword in search box\n2. Press enter', 'Results should load within 2 seconds', 'Loading spinner for 10+ seconds', 'High', 'Major', 'Ubuntu 22.04, Firefox 103', 'Open', 'eve@example.com', 2, '2025-07-07 17:52:44', '2025-07-07 17:52:44');

-- --------------------------------------------------------

--
-- Table structure for table `developers`
--

CREATE TABLE `developers` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `email` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `developers`
--

INSERT INTO `developers` (`id`, `name`, `email`) VALUES
(1, 'Alice Johnson', 'alice@company.com'),
(2, 'Bob Smith', 'bob@company.com'),
(3, 'Charlie Dev', 'charlie@company.com');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `email` varchar(100) DEFAULT NULL,
  `role` varchar(20) DEFAULT 'qa'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `password`, `email`, `role`) VALUES
(1, 'qa', 'qa123', 'qa@example.com', 'qa'),
(2, 'shanuka', '123', 'abc@gmail.com', 'qa');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `bugs`
--
ALTER TABLE `bugs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `assigned_to` (`assigned_to`);

--
-- Indexes for table `developers`
--
ALTER TABLE `developers`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `bugs`
--
ALTER TABLE `bugs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `developers`
--
ALTER TABLE `developers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `bugs`
--
ALTER TABLE `bugs`
  ADD CONSTRAINT `bugs_ibfk_1` FOREIGN KEY (`assigned_to`) REFERENCES `developers` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
