-- phpMyAdmin SQL Dump
-- version 4.1.6
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Jul 18, 2014 at 02:36 PM
-- Server version: 5.6.16
-- PHP Version: 5.5.9

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `regsystem`
--

-- --------------------------------------------------------

--
-- Table structure for table `groups`
--

CREATE TABLE IF NOT EXISTS `groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) NOT NULL,
  `permissions` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=3 ;

--
-- Dumping data for table `groups`
--

INSERT INTO `groups` (`id`, `name`, `permissions`) VALUES
(1, 'Standard user', ''),
(2, 'Administrator', '{"admin": 1}');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE IF NOT EXISTS `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(20) NOT NULL,
  `password` varchar(64) NOT NULL,
  `salt` varchar(32) NOT NULL,
  `name` varchar(50) NOT NULL,
  `joined` datetime NOT NULL,
  `group` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=13 ;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `password`, `salt`, `name`, `joined`, `group`) VALUES
(4, 'triibu', 'd54c47e3180c7346ac5e51041c2324be62c356fdaec6fcdcdf4cb4858d710414', '€kÂ‹NcÝê\Z}Ð¸ˆ¥ƒKØG6¹‡K…ñÂXßº<‰', 'Triibu Faty Cat', '2014-07-14 23:29:37', 2),
(6, 'epani', 'd438382adfaa479d341a234edcc9e538421fcef1ebb4d64705f78373ad812523', '²Ü;—âŒ&ð™ðð{°Ã¾æy³²I`h¶%)å›', 'Evelin Pani', '2014-07-14 23:48:38', 2),
(7, 'manin', '44dbfaf8a4555af097f52b7cb8c11965069dce389cf4faa7bc234207e72e9364', '¦/+#õiuŠ­jó¹@¨:´S”ÓŽ;,F7ŠKJŽo', 'Manin Meller', '2014-07-15 10:36:17', 2),
(8, 'miranda', 'b5ba0981374e28c756461e517b02e03d1e2d48b10cc3b7b49cdecd58717789e8', 'á­ÖÜ–dšÐ…§ùê5Ê•ÿÞ¦šŠgk¡jÆÛ¡©E<', 'MIranda Meller', '2014-07-15 22:21:57', 1),
(9, 'melymel', 'newPassword', 'zmÌåäøFÿùñ^Yñ–C«‹¡ä&Ò‡Ï•¯kÜ', 'Mirian Mel', '2014-07-15 22:23:32', 1),
(10, 'gfuret', '45efa044078c6fbacc4d71286cbc16578240a662a1843da6d8f4072f79140da3', '…ë#‚*¾\\R˜Û‘´G7¤•#o«s3{® ÿ', 'Gabriel Furet', '2014-07-18 10:08:33', 1),
(11, 'sucubus', '942205ec3e6b699481696134bd697656ac9d42798f0059716efc23819ec7a1e3', '(\nãýe™±(ðLö$CY	—lÓlÝŸÐïœ\r&®&(x', 'Sucubus Under', '2014-07-18 10:32:30', 1),
(12, 'incubus', 'aaa50588a80e6d6ec7a9a18a204970377f81a60280380259cfa6bfe4473f400d', 'yÆ†Z! €?”sL12… @šbõçÀ/ŽœÚx', 'Incubus Up', '2014-07-18 10:33:27', 1);

-- --------------------------------------------------------

--
-- Table structure for table `users_session`
--

CREATE TABLE IF NOT EXISTS `users_session` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `hash` varchar(64) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=5 ;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
