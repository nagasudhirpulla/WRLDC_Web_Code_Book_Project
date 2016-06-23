-- phpMyAdmin SQL Dump
-- version 4.5.2
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Jun 23, 2016 at 06:51 PM
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
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `catagories`
--

DROP TABLE IF EXISTS `catagories`;
CREATE TABLE IF NOT EXISTS `catagories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name_UNIQUE` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `catagories`
--

INSERT INTO `catagories` (`id`, `name`) VALUES
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
  `time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `category_id` int(11) NOT NULL,
  `description` varchar(250) DEFAULT NULL,
  `element_id` int(11) DEFAULT NULL,
  `is_cancelled` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `category_id_idx` (`category_id`),
  KEY `element_id_idx` (`element_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

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
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `elements`
--

DROP TABLE IF EXISTS `elements`;
CREATE TABLE IF NOT EXISTS `elements` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

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
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

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
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

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
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `rldcs`
--

INSERT INTO `rldcs` (`id`, `name`) VALUES
(3, 'ERLDC'),
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
  ADD CONSTRAINT `category_id` FOREIGN KEY (`category_id`) REFERENCES `catagories` (`id`) ON UPDATE CASCADE,
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
