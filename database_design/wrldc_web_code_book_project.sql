-- phpMyAdmin SQL Dump
-- version 4.5.2
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Jul 02, 2016 at 07:10 AM
-- Server version: 5.7.9
-- PHP Version: 5.6.16

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `wrldc_web_code_book_project`
--

-- --------------------------------------------------------

--
-- Table structure for table `associates`
--

DROP TABLE IF EXISTS `associates`;
CREATE TABLE IF NOT EXISTS `associates` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Unique element_id, entity_id',
  `element_id` int(11) NOT NULL,
  `entity_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uc_associates` (`element_id`,`entity_id`),
  KEY `element_id_idx` (`element_id`),
  KEY `entity_id_idx` (`entity_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `associates`
--

INSERT INTO `associates` (`id`, `element_id`, `entity_id`) VALUES
(1, 1, 1),
(2, 1, 2);

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
CREATE TABLE IF NOT EXISTS `categories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name_UNIQUE` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`id`, `name`) VALUES
(3, 'emergency element out'),
(1, 'forced element out'),
(7, 'message'),
(4, 'opportunity element out'),
(8, 'other'),
(2, 'planned element out'),
(6, 'revision'),
(5, 'revive element');

-- --------------------------------------------------------

--
-- Table structure for table `codes`
--

DROP TABLE IF EXISTS `codes`;
CREATE TABLE IF NOT EXISTS `codes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code` int(11) NOT NULL,
  `time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `category_id` int(11) NOT NULL,
  `description` varchar(250) DEFAULT NULL,
  `element_id` int(11) DEFAULT NULL,
  `is_cancelled` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `category_id_idx` (`category_id`),
  KEY `element_id_idx` (`element_id`)
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `codes`
--

INSERT INTO `codes` (`id`, `code`, `time`, `category_id`, `description`, `element_id`, `is_cancelled`) VALUES
(1, 0, '2016-06-24 00:26:46', 1, NULL, NULL, 0),
(2, 0, '2016-06-27 16:07:03', 6, 't', 1, 0),
(3, 0, '2016-06-27 16:12:18', 8, 's', 1, 0),
(4, 0, '2016-06-27 16:14:38', 1, 's', 1, 0),
(5, 0, '2016-06-27 16:16:09', 1, 's', 1, 0),
(6, 0, '2016-06-27 16:18:43', 7, 'c', 1, 0),
(7, 0, '2016-06-27 16:20:08', 1, 'ghhas', 1, 0),
(8, 0, '2016-06-27 16:21:29', 2, 'sudhir_test', 1, 0),
(9, 0, '2016-06-27 16:25:45', 5, 'wrldc_test', 1, 0),
(10, 0, '2016-06-27 16:33:25', 1, 'null elem test', NULL, 0),
(11, 0, '2016-06-27 17:19:30', 1, 'another test', NULL, 0),
(12, 0, '2016-06-27 17:23:24', 1, 'agbasbkjs', NULL, 0),
(13, 0, '2016-06-27 18:08:38', 4, 'all except element', NULL, 0),
(14, 0, '2016-06-27 18:13:52', 4, 'all except element1', NULL, 0),
(15, 0, '2016-06-27 18:23:44', 4, 'all except element2', NULL, 0),
(16, 0, '2016-06-27 18:25:48', 4, 'all except element3', NULL, 0),
(17, 0, '2016-06-27 18:30:23', 4, 'all except element4', NULL, 0),
(18, 0, '2016-06-27 18:32:38', 4, 'except element_test', NULL, 0),
(19, 0, '2016-06-27 18:33:36', 5, 'new test', NULL, 0),
(20, 0, '2016-06-28 11:07:34', 3, 'bullshit', NULL, 0),
(21, 0, '2016-06-28 13:46:14', 1, 'testta', NULL, 0),
(22, 0, '2016-06-28 13:55:20', 1, 'testtaac', NULL, 0),
(23, 0, '2016-06-28 13:58:13', 1, 'testtaac', NULL, 0),
(24, 0, '2016-06-28 13:59:40', 1, 'wwdw', NULL, 0),
(25, 0, '2016-06-28 13:59:41', 1, 'wwdw', NULL, 0),
(26, 0, '2016-06-28 13:59:55', 1, 'wwdw', NULL, 0),
(27, 0, '2016-06-28 14:00:08', 1, 'wwdw', NULL, 0),
(28, 0, '2016-06-28 14:03:06', 1, 'wwdw', NULL, 0),
(29, 0, '2016-06-28 14:04:26', 1, 'afsqfqa', NULL, 0),
(30, 0, '2016-06-28 14:25:12', 1, 'oijwl', NULL, 0),
(31, 0, '2016-06-28 14:26:03', 1, 'joajfa', NULL, 0),
(32, 0, '2016-06-28 14:32:50', 1, 'hakd', NULL, 0),
(33, 0, '2016-06-28 14:34:16', 1, 'hakd', NULL, 0),
(34, 0, '2016-06-28 14:41:12', 5, 'one other code test', NULL, 0),
(35, 0, '2016-06-28 14:43:53', 5, 'one other code test', NULL, 0),
(36, 0, '2016-06-28 15:22:28', 1, 'sfaa', NULL, 0);

-- --------------------------------------------------------

--
-- Table structure for table `code_requests`
--

DROP TABLE IF EXISTS `code_requests`;
CREATE TABLE IF NOT EXISTS `code_requests` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Unique code_id,entity_id',
  `entity_id` int(11) NOT NULL,
  `code_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uc_code_requests` (`code_id`,`entity_id`),
  KEY `code_id2_idx` (`code_id`),
  KEY `entity_id1_idx` (`entity_id`)
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `code_requests`
--

INSERT INTO `code_requests` (`id`, `entity_id`, `code_id`) VALUES
(9, 6, 1),
(16, 2, 2),
(17, 8, 2),
(35, 4, 3),
(1, 2, 14),
(2, 4, 14),
(3, 7, 14),
(4, 1, 15),
(5, 6, 15),
(6, 1, 16),
(7, 6, 16),
(8, 9, 16),
(10, 5, 18),
(11, 10, 18),
(12, 3, 19),
(13, 11, 19),
(14, 2, 20),
(15, 3, 20),
(19, 2, 24),
(20, 4, 24),
(21, 2, 25),
(22, 4, 25),
(23, 2, 26),
(24, 4, 26),
(25, 2, 27),
(26, 4, 27),
(27, 2, 28),
(28, 4, 28),
(29, 2, 31),
(30, 4, 31),
(31, 2, 32),
(32, 4, 32),
(33, 2, 33),
(34, 4, 33),
(37, 2, 36),
(38, 4, 36);

-- --------------------------------------------------------

--
-- Table structure for table `elements`
--

DROP TABLE IF EXISTS `elements`;
CREATE TABLE IF NOT EXISTS `elements` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `elements`
--

INSERT INTO `elements` (`id`, `name`) VALUES
(1, 'solapur-raichur'),
(2, 'kolhapur-mapusa');

-- --------------------------------------------------------

--
-- Table structure for table `entities`
--

DROP TABLE IF EXISTS `entities`;
CREATE TABLE IF NOT EXISTS `entities` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `region_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name_UNIQUE` (`name`),
  KEY `region_id_idx` (`region_id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `entities`
--

INSERT INTO `entities` (`id`, `name`, `region_id`) VALUES
(1, 'Maharashtra', 3),
(2, 'SRLDC', 4),
(3, 'Gujarat', 3),
(4, 'Chhattisgarh', 3),
(5, 'Goa', 3),
(6, 'Madhya Pradesh', 3),
(7, 'DD', 3),
(8, 'DNH', 3),
(9, 'NTPC', 3),
(10, 'CPCC Vadodara', 3),
(11, 'CPCC Nagpur', 3);

-- --------------------------------------------------------

--
-- Table structure for table `optional_codes`
--

DROP TABLE IF EXISTS `optional_codes`;
CREATE TABLE IF NOT EXISTS `optional_codes` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'unique - code_id, rldc_id',
  `code_id` int(11) NOT NULL,
  `rldc_id` int(11) NOT NULL,
  `code` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `code_id_idx` (`code_id`),
  KEY `rldc_id_idx` (`rldc_id`)
) ENGINE=InnoDB AUTO_INCREMENT=88 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `optional_codes`
--

INSERT INTO `optional_codes` (`id`, `code_id`, `rldc_id`, `code`) VALUES
(16, 16, 1, 10),
(17, 16, 2, 20),
(18, 16, 3, 30),
(19, 16, 5, 40),
(20, 16, 6, 50),
(31, 19, 3, 35),
(32, 19, 6, 55),
(33, 19, 1, 15),
(34, 19, 2, 25),
(35, 19, 5, 45),
(36, 20, 3, 666),
(37, 20, 6, 879),
(38, 20, 1, 45),
(39, 20, 2, 4564),
(40, 20, 5, 76),
(51, 23, 3, 124),
(52, 23, 6, 47),
(53, 23, 1, 45),
(54, 23, 2, 45),
(55, 23, 5, 48),
(56, 24, 3, 875),
(57, 24, 6, 75),
(58, 24, 1, 4),
(59, 24, 2, 54),
(60, 24, 5, 481),
(61, 25, 3, 875),
(62, 25, 6, 75),
(63, 25, 1, 4),
(64, 25, 2, 54),
(65, 25, 5, 481),
(66, 26, 3, 875),
(67, 26, 6, 75),
(68, 26, 1, 4),
(69, 26, 2, 54),
(70, 26, 5, 481),
(81, 3, 2, 4),
(82, 3, 2, 9),
(83, 33, 2, 999),
(84, 33, 5, 458),
(85, 3, 5, 9),
(86, 3, 5, 9),
(87, 36, 2, 45);

-- --------------------------------------------------------

--
-- Table structure for table `regions`
--

DROP TABLE IF EXISTS `regions`;
CREATE TABLE IF NOT EXISTS `regions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name_UNIQUE` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `regions`
--

INSERT INTO `regions` (`id`, `name`) VALUES
(2, 'ER'),
(5, 'NER'),
(1, 'NR'),
(4, 'SR'),
(3, 'WR');

-- --------------------------------------------------------

--
-- Table structure for table `rldcs`
--

DROP TABLE IF EXISTS `rldcs`;
CREATE TABLE IF NOT EXISTS `rldcs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name_UNIQUE` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `rldcs`
--

INSERT INTO `rldcs` (`id`, `name`) VALUES
(3, 'ERLDC'),
(6, 'NERLDC'),
(1, 'NLDC'),
(2, 'NRLDC'),
(5, 'SRLDC'),
(4, 'WRLDC');

-- --------------------------------------------------------

--
-- Table structure for table `times`
--

DROP TABLE IF EXISTS `times`;
CREATE TABLE IF NOT EXISTS `times` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code_id` int(11) NOT NULL,
  `time` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `code_id_idx` (`code_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `associates`
--
ALTER TABLE `associates`
  ADD CONSTRAINT `element_id1` FOREIGN KEY (`element_id`) REFERENCES `elements` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `entity_id` FOREIGN KEY (`entity_id`) REFERENCES `entities` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `codes`
--
ALTER TABLE `codes`
  ADD CONSTRAINT `category_id` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `element_id` FOREIGN KEY (`element_id`) REFERENCES `elements` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `code_requests`
--
ALTER TABLE `code_requests`
  ADD CONSTRAINT `code_id2` FOREIGN KEY (`code_id`) REFERENCES `codes` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `entity_id1` FOREIGN KEY (`entity_id`) REFERENCES `entities` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `entities`
--
ALTER TABLE `entities`
  ADD CONSTRAINT `region_id` FOREIGN KEY (`region_id`) REFERENCES `regions` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `optional_codes`
--
ALTER TABLE `optional_codes`
  ADD CONSTRAINT `code_id` FOREIGN KEY (`code_id`) REFERENCES `codes` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `rldc_id` FOREIGN KEY (`rldc_id`) REFERENCES `rldcs` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `times`
--
ALTER TABLE `times`
  ADD CONSTRAINT `code_id1` FOREIGN KEY (`code_id`) REFERENCES `codes` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
