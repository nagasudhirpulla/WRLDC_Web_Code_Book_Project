-- phpMyAdmin SQL Dump
-- version 4.5.2
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Jul 16, 2016 at 07:18 PM
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

DELIMITER $$
--
-- Procedures
--
DROP PROCEDURE IF EXISTS `addcode`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `addcode` (IN `cat` INT, IN `des` VARCHAR(250), IN `el` INT)  MODIFIES SQL DATA
  BEGIN
    DECLARE newcode INT;
    SET newcode = -1;
    START TRANSACTION READ WRITE;
    SET newcode = (SELECT IFNULL(MAX(code),-1) FROM wrldc_web_code_book_project.codes WHERE time = (SELECT MAX(time) FROM wrldc_web_code_book_project.codes));
    INSERT INTO wrldc_web_code_book_project.codes(code, category_id, description, element_id) VALUES (newcode + 1, cat, des, el);
    IF ROW_COUNT() > 0 THEN
      SET newcode = LAST_INSERT_ID();
    END IF;
    COMMIT;
    SELECT newcode AS 'newcode';
  END$$

DELIMITER ;

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
) ENGINE=InnoDB AUTO_INCREMENT=166 DEFAULT CHARSET=utf8;

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
  (36, 0, '2016-06-28 15:22:28', 1, 'sfaa', NULL, 0),
  (37, 0, '2016-07-02 13:24:54', 1, NULL, 1, 0),
  (38, 1, '2016-07-02 13:25:49', 1, NULL, 1, 0),
  (39, 2, '2016-07-02 13:26:10', 1, NULL, 1, 0),
  (43, 1, '2016-07-04 13:51:53', 8, 'Zero Code', NULL, 0),
  (44, 1, '2016-07-04 13:56:50', 8, 'Zero Code', NULL, 0),
  (45, 1, '2016-07-04 13:57:09', 8, 'Zero Code', NULL, 0),
  (46, 0, '2016-07-04 13:57:38', 8, 'Zero Code', NULL, 0),
  (47, 0, '2016-07-04 13:58:59', 8, 'Zero Code', NULL, 0),
  (48, 1, '2016-07-04 14:03:58', 1, 'autoinserttest', NULL, 0),
  (49, 2, '2016-07-04 14:06:22', 1, 'autoinserttest', NULL, 0),
  (50, 3, '2016-07-04 14:09:40', 1, 'autoinserttest', NULL, 0),
  (51, 4, '2016-07-04 14:09:53', 1, 'autoinserttest', NULL, 0),
  (52, 5, '2016-07-04 14:12:26', 1, 'othercodestest', NULL, 0),
  (53, 6, '2016-07-04 14:14:34', 1, 'othercodestest', NULL, 0),
  (54, 7, '2016-07-04 14:16:03', 1, 'othercodestest', NULL, 0),
  (55, 8, '2016-07-04 16:04:11', 1, 'othercodetets', NULL, 0),
  (56, 9, '2016-07-04 16:07:20', 1, 'ggjh', NULL, 0),
  (57, 10, '2016-07-04 16:12:58', 1, 'tyh', NULL, 0),
  (58, 11, '2016-07-04 16:14:38', 1, 'hb', NULL, 0),
  (59, 12, '2016-07-04 16:15:37', 1, 'nj', NULL, 0),
  (60, 13, '2016-07-04 16:17:30', 1, 'efie', NULL, 0),
  (61, 0, '2016-07-04 16:23:00', 8, NULL, NULL, 0),
  (62, 0, '2016-07-04 16:23:25', 8, NULL, NULL, 0),
  (63, 0, '2016-07-04 16:23:45', 8, NULL, NULL, 0),
  (64, 0, '2016-07-04 16:27:29', 8, NULL, NULL, 0),
  (65, 1, '2016-07-04 17:34:00', 1, NULL, 1, 0),
  (66, 2, '2016-07-04 17:34:11', 1, NULL, 1, 0),
  (67, 3, '2016-07-04 17:34:32', 1, NULL, 1, 0),
  (68, 4, '2016-07-04 17:34:45', 1, NULL, 1, 0),
  (69, 5, '2016-07-04 17:36:04', 1, NULL, 1, 0),
  (70, 6, '2016-07-04 17:36:33', 1, NULL, 1, 0),
  (71, 7, '2016-07-04 17:36:58', 1, NULL, 1, 0),
  (72, 8, '2016-07-04 17:37:29', 1, NULL, 1, 0),
  (73, 9, '2016-07-04 17:39:57', 1, NULL, 1, 0),
  (74, 0, '2016-07-04 17:53:41', 8, 'Zero Code', NULL, 0),
  (75, 1, '2016-07-04 17:53:58', 1, 'jkkhkj', NULL, 0),
  (76, 2, '2016-07-04 17:56:00', 1, NULL, 1, 0),
  (77, 3, '2016-07-04 18:00:29', 1, NULL, 1, 0),
  (78, 4, '2016-07-04 18:00:40', 1, NULL, 1, 0),
  (79, 5, '2016-07-04 18:32:50', 1, NULL, 1, 0),
  (80, 6, '2016-07-04 18:33:10', 1, NULL, 1, 0),
  (81, 7, '2016-07-04 18:33:40', 1, NULL, 1, 0),
  (82, 8, '2016-07-04 19:03:37', 1, NULL, 1, 0),
  (83, 9, '2016-07-04 19:04:02', 1, NULL, 1, 0),
  (84, 10, '2016-07-04 19:04:29', 1, NULL, 1, 0),
  (86, 11, '2016-07-04 19:05:49', 1, NULL, 1, 0),
  (87, 12, '2016-07-04 19:06:01', 1, NULL, 1, 0),
  (88, 13, '2016-07-04 19:06:26', 1, NULL, 1, 0),
  (89, 14, '2016-07-04 19:08:11', 1, NULL, 1, 0),
  (90, 15, '2016-07-04 19:08:26', 1, NULL, 1, 0),
  (91, 16, '2016-07-04 19:09:04', 1, NULL, 1, 0),
  (92, 17, '2016-07-04 19:09:22', 1, NULL, 1, 0),
  (93, 18, '2016-07-04 19:47:05', 8, 'proctest', 1, 0),
  (94, 19, '2016-07-04 19:49:08', 8, 'dsfsdfsd', 1, 0),
  (95, 20, '2016-07-04 19:49:36', 8, 'dsfsdfsd', 1, 0),
  (96, 21, '2016-07-04 19:49:57', 8, 'dsfsdfsd', 1, 0),
  (97, 22, '2016-07-04 19:51:48', 8, 'dsfsdfsd', 1, 0),
  (98, 23, '2016-07-04 19:51:59', 8, 'dsfsdfsd', 1, 0),
  (99, 24, '2016-07-05 16:51:03', 1, '"proctest"', 1, 0),
  (100, 25, '2016-07-05 16:53:15', 1, 'proctestwb', 1, 0),
  (101, 26, '2016-07-05 16:53:38', 1, 'proctestwb', 1, 0),
  (102, 27, '2016-07-05 16:54:00', 1, 'proctestwb', 1, 0),
  (103, 28, '2016-07-05 16:57:51', 1, 'proctest', 1, 0),
  (104, 29, '2016-07-05 16:58:05', 1, 'proctest', 1, 0),
  (105, 30, '2016-07-05 17:01:48', 1, 'proctest', 1, 0),
  (106, 31, '2016-07-05 17:13:59', 1, 'proctest', 1, 0),
  (107, 32, '2016-07-05 17:13:59', 1, 'proctest', 1, 0),
  (108, 33, '2016-07-05 17:14:42', 1, 'proctest', 1, 0),
  (109, 34, '2016-07-05 17:36:40', 1, 'proctest', 1, 0),
  (110, 35, '2016-07-05 17:49:16', 8, 'dsfsdfsd', 1, 0),
  (111, 36, '2016-07-05 17:49:31', 8, 'dsfsdfsd', 1, 0),
  (112, 37, '2016-07-05 17:49:54', 8, 'dsfsdfsd', 1, 0),
  (113, 38, '2016-07-05 17:50:06', 8, 'dsfsdfsd', 1, 0),
  (114, 39, '2016-07-05 17:50:33', 8, 'dsfsdfsd', 1, 0),
  (115, 40, '2016-07-05 17:54:39', 8, 'dsfsdfsd', 1, 0),
  (116, 41, '2016-07-05 17:54:44', 8, 'dsfsdfsd', 1, 0),
  (117, 42, '2016-07-05 17:55:18', 8, 'dsfsdfsd', 1, 0),
  (118, 43, '2016-07-05 18:07:43', 8, 'dsfsdfsd', 1, 0),
  (119, 44, '2016-07-05 18:10:30', 8, 'dsfsdfsd', 1, 0),
  (120, 45, '2016-07-05 18:14:49', 8, 'dsfsdfsd', 1, 0),
  (121, 46, '2016-07-05 18:16:47', 1, '', 1, 0),
  (122, 47, '2016-07-05 18:18:37', 1, '', 1, 0),
  (123, 48, '2016-07-05 18:18:49', 1, '', 1, 0),
  (124, 49, '2016-07-05 18:22:07', 8, 'dsfsdfsd', 1, 0),
  (125, 50, '2016-07-05 18:27:39', 8, 'dsfsdfsd', 1, 0),
  (126, 51, '2016-07-05 18:40:29', 8, 'transaction stored proc', 1, 0),
  (127, 52, '2016-07-05 18:41:06', 8, 'transaction stored proc', 1, 0),
  (128, 0, '2016-07-05 18:44:25', 8, 'Zero Code', NULL, 0),
  (129, 1, '2016-07-05 18:58:04', 8, 'dsfsdfsd', 1, 0),
  (130, 2, '2016-07-05 19:06:08', 2, 'transac proctest', NULL, 0),
  (131, 3, '2016-07-05 19:06:20', 5, 'edit code test', NULL, 0),
  (132, 4, '2016-07-05 19:11:24', 1, 'transac  proctest', NULL, 0),
  (133, 5, '2016-07-05 19:14:05', 8, 'dsfsdfsd', 1, 0),
  (134, 6, '2016-07-05 19:16:34', 8, 'proctest transacction', NULL, 0),
  (135, 7, '2016-07-05 19:19:13', 8, 'proctest transacction 1', NULL, 0),
  (136, 0, '2016-07-05 19:27:45', 8, 'edited code', NULL, 0),
  (137, 1, '2016-07-06 19:08:43', 2, 'venky', NULL, 0),
  (138, 2, '2016-07-07 00:06:26', 2, 'gjhg,hk', NULL, 0),
  (139, 0, '2016-07-07 00:06:46', 8, 'Zero Code', NULL, 0),
  (140, 1, '2016-07-07 00:06:55', 2, 'gjh', NULL, 0),
  (141, 2, '2016-07-09 22:38:39', 1, 'mastan', NULL, 0),
  (142, 0, '2016-07-12 16:39:18', 8, 'Zero Code', NULL, 0),
  (143, 1, '2016-07-12 23:00:15', 1, 'prajapati', NULL, 1),
  (144, 2, '2016-07-13 01:34:00', 7, 'siddharth', NULL, 0),
  (145, 3, '2016-07-14 22:08:46', 3, 'cseb element out code', NULL, 0),
  (146, 4, '2016-07-14 23:20:42', 1, 'gfgh', NULL, 0),
  (147, 5, '2016-07-15 18:20:40', 4, 'create test for pagination', NULL, 0),
  (148, 6, '2016-07-15 18:22:55', 4, 'create test for pagination1', NULL, 0),
  (149, 7, '2016-07-15 18:23:47', 4, 'create test for pagination2', NULL, 0),
  (150, 8, '2016-07-15 18:24:12', 4, 'create test for pagination3', NULL, 0),
  (151, 9, '2016-07-15 18:26:32', 1, 'pagination test 4', NULL, 0),
  (152, 10, '2016-07-15 23:40:59', 1, '', NULL, 0),
  (153, 11, '2016-07-16 21:36:05', 1, 'authtest', NULL, 0),
  (154, 12, '2016-07-16 21:39:51', 1, 'authtest', NULL, 0),
  (155, 13, '2016-07-16 21:46:05', 1, 'authtest1', NULL, 0),
  (156, 14, '2016-07-16 21:50:01', 1, 'authtest', NULL, 0),
  (157, 15, '2016-07-16 21:53:33', 1, 'authtest', NULL, 0),
  (158, 16, '2016-07-16 21:54:45', 1, 'authtest', NULL, 0),
  (159, 17, '2016-07-16 22:42:17', 1, 'vhgfhg', NULL, 0),
  (160, 18, '2016-07-16 22:52:36', 1, 'afmnl', NULL, 0),
  (161, 19, '2016-07-16 22:55:47', 1, 'ftjv', NULL, 0),
  (162, 20, '2016-07-16 22:57:39', 1, 'ftjvsd', NULL, 0),
  (163, 21, '2016-07-16 23:01:14', 1, 'ftjvsdkj', NULL, 0),
  (164, 22, '2016-07-16 23:12:22', 1, 'authtest', NULL, 0),
  (165, 23, '2016-07-16 23:53:08', 6, 'authtest', NULL, 0);

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
) ENGINE=InnoDB AUTO_INCREMENT=130 DEFAULT CHARSET=latin1;

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
  (38, 4, 36),
  (55, 1, 131),
  (39, 2, 132),
  (40, 4, 132),
  (41, 2, 134),
  (42, 4, 134),
  (43, 2, 135),
  (44, 4, 135),
  (58, 5, 136),
  (59, 9, 136),
  (63, 1, 137),
  (64, 2, 137),
  (65, 3, 137),
  (70, 2, 138),
  (71, 4, 138),
  (50, 2, 140),
  (51, 4, 140),
  (52, 1, 141),
  (53, 3, 141),
  (74, 2, 143),
  (75, 4, 143),
  (80, 3, 144),
  (81, 10, 144),
  (84, 4, 145),
  (89, 2, 146),
  (90, 8, 146),
  (91, 2, 147),
  (92, 4, 147),
  (93, 2, 148),
  (94, 4, 148),
  (95, 2, 149),
  (96, 4, 149),
  (101, 2, 150),
  (102, 4, 150),
  (99, 2, 151),
  (100, 4, 151),
  (103, 2, 152),
  (104, 4, 152),
  (105, 2, 153),
  (106, 4, 153),
  (107, 2, 154),
  (108, 5, 154),
  (109, 2, 155),
  (110, 5, 155),
  (111, 2, 156),
  (112, 4, 156),
  (113, 2, 157),
  (114, 4, 157),
  (115, 2, 158),
  (116, 4, 158),
  (117, 2, 159),
  (118, 4, 159),
  (119, 2, 160),
  (120, 4, 160),
  (121, 2, 161),
  (122, 4, 161),
  (123, 2, 162),
  (124, 4, 162),
  (125, 2, 163),
  (126, 4, 163),
  (127, 3, 164),
  (128, 1, 165),
  (129, 5, 165);

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
) ENGINE=InnoDB AUTO_INCREMENT=175 DEFAULT CHARSET=latin1;

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
  (87, 36, 2, 45),
  (88, 132, 3, 95),
  (89, 132, 1, 45),
  (90, 134, 3, 18),
  (91, 134, 6, 545),
  (92, 134, 1, 455),
  (93, 134, 5, 45),
  (94, 135, 3, 18),
  (95, 135, 6, 545),
  (96, 135, 1, 455),
  (97, 135, 5, 45),
  (101, 140, 3, 45),
  (102, 140, 1, 78),
  (103, 140, 5, 77),
  (104, 141, 3, 5),
  (105, 141, 6, 48),
  (106, 141, 1, 465),
  (107, 141, 2, 81),
  (113, 131, 3, 44),
  (114, 131, 6, 66),
  (115, 131, 1, 22),
  (116, 131, 2, 33),
  (117, 131, 5, 55),
  (123, 136, 3, 66),
  (124, 136, 6, 95),
  (125, 136, 1, 78),
  (126, 136, 2, 48),
  (127, 136, 5, 15),
  (131, 137, 3, 45),
  (132, 137, 1, 78),
  (133, 137, 5, 77),
  (140, 138, 3, 45),
  (141, 138, 1, 78),
  (142, 138, 5, 77),
  (148, 143, 3, 245),
  (149, 143, 6, 25),
  (150, 143, 1, 551),
  (151, 143, 5, 89),
  (158, 144, 1, 45),
  (159, 144, 2, 18),
  (160, 145, 2, 512),
  (161, 147, 1, 12),
  (162, 148, 1, 12),
  (163, 149, 1, 12),
  (165, 150, 3, 52),
  (166, 150, 1, 123),
  (167, 153, 2, 123),
  (168, 154, 2, 123),
  (169, 155, 2, 123),
  (170, 165, 3, 3),
  (171, 165, 6, 5),
  (172, 165, 1, 1),
  (173, 165, 2, 2),
  (174, 165, 5, 4);

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
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `times`
--

INSERT INTO `times` (`id`, `code_id`, `time`) VALUES
  (7, 131, '2016-07-09 23:13:00'),
  (9, 136, '2016-07-12 16:17:00');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(100) NOT NULL,
  `password` varchar(500) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `password`, `created_at`) VALUES
  (2, 'nagasudhirpulla@gmail.com', '$2a$09$JrdUNLydJsga3ChGlT3O2OhMIHKIfCXQPuxar9somgbZVK0rSnGT6', '2016-06-10 03:07:53'),
  (4, 'nagasudhirpull', '$2a$09$s3x3Lbevuy4DmihyDKsdn.goTStLge0smdlgC.5Z3qa3IO2b6Hv/W', '2016-06-10 03:48:51'),
  (5, 'sudhir', '$2a$09$4FfoIVX.PFLaLqw3wYDKXemj/BFVtWY5f.Xu18rQg073nBMz0FGK2', '2016-07-16 18:24:02');

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
