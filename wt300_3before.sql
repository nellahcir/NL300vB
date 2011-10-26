-- MySQL dump 10.13  Distrib 5.5.2-m2, for apple-darwin10.4.0 (i386)
--
-- Host: localhost    Database: wt300_3
-- ------------------------------------------------------
-- Server version	5.5.2-m2

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `checkins`
--

DROP TABLE IF EXISTS `checkins`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `checkins` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `musher_id` int(11) DEFAULT NULL,
  `checkpoint_id` int(11) DEFAULT NULL,
  `dogs` int(11) DEFAULT NULL,
  `time` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `checkins`
--

LOCK TABLES `checkins` WRITE;
/*!40000 ALTER TABLE `checkins` DISABLE KEYS */;
INSERT INTO `checkins` VALUES (1,1,1,16,'2011-02-04 19:00:00','2011-01-10 16:48:51','2011-01-10 16:48:51'),(2,2,1,16,'2011-02-04 19:05:00','2011-01-10 16:48:51','2011-01-14 04:20:22'),(4,2,2,16,'2011-02-04 20:53:00','2011-01-14 02:54:28','2011-01-14 04:15:34');
/*!40000 ALTER TABLE `checkins` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `checkouts`
--

DROP TABLE IF EXISTS `checkouts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `checkouts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `musher_id` int(11) DEFAULT NULL,
  `checkpoint_id` int(11) DEFAULT NULL,
  `dogs` int(11) DEFAULT NULL,
  `time` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `checkouts`
--

LOCK TABLES `checkouts` WRITE;
/*!40000 ALTER TABLE `checkouts` DISABLE KEYS */;
INSERT INTO `checkouts` VALUES (1,1,1,16,'2011-02-04 19:00:00','2011-01-10 16:48:51','2011-01-10 16:48:51'),(2,2,1,16,'2011-02-04 20:03:00','2011-01-10 16:48:51','2011-01-14 04:58:03');
/*!40000 ALTER TABLE `checkouts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `checkpoints`
--

DROP TABLE IF EXISTS `checkpoints`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `checkpoints` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `sequence` int(11) DEFAULT NULL,
  `milepost` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `checkpoints`
--

LOCK TABLES `checkpoints` WRITE;
/*!40000 ALTER TABLE `checkpoints` DISABLE KEYS */;
INSERT INTO `checkpoints` VALUES (1,'Willow (start)',1,0,'2011-01-09 06:01:58','2011-01-09 06:01:58'),(2,'Yentna (out)',2,40,'2011-01-09 06:03:55','2011-01-09 06:03:55'),(3,'Talvista',3,120,'2011-01-09 06:04:12','2011-01-09 06:04:12'),(4,'Yentna (in)',4,200,'2011-01-09 06:04:32','2011-01-09 06:04:32'),(5,'Deshka Landing (in)',5,250,'2011-01-09 06:04:47','2011-01-09 06:04:47'),(6,'Tug Bar (finish)',6,300,'2011-01-09 06:05:02','2011-01-09 06:05:02');
/*!40000 ALTER TABLE `checkpoints` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mushers`
--

DROP TABLE IF EXISTS `mushers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mushers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `bibnum` int(11) DEFAULT NULL,
  `dogs` int(11) DEFAULT NULL,
  `year` int(11) DEFAULT NULL,
  `stpos` int(11) DEFAULT NULL,
  `status_id` int(11) DEFAULT NULL,
  `restartdiff` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mushers`
--

LOCK TABLES `mushers` WRITE;
/*!40000 ALTER TABLE `mushers` DISABLE KEYS */;
INSERT INTO `mushers` VALUES (1,'Allen Sue',1,16,2011,1,3,NULL,'2011-01-09 09:14:18','2011-01-09 09:14:18'),(2,'Allen hciR',2,15,2011,2,3,NULL,'2011-01-09 09:19:25','2011-01-14 03:51:44'),(3,'Fontaine Baptiste',3,12,2011,3,3,NULL,'2011-01-14 04:14:19','2011-01-14 04:14:29');
/*!40000 ALTER TABLE `mushers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `schema_migrations`
--

DROP TABLE IF EXISTS `schema_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `schema_migrations` (
  `version` varchar(255) NOT NULL,
  UNIQUE KEY `unique_schema_migrations` (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `schema_migrations`
--

LOCK TABLES `schema_migrations` WRITE;
/*!40000 ALTER TABLE `schema_migrations` DISABLE KEYS */;
INSERT INTO `schema_migrations` VALUES ('20110108231556'),('20110109055006'),('20110109061424'),('20110109082521'),('20110109084353'),('20110109085518'),('20110109103602'),('20110111012932'),('20110111013004'),('20110111013634');
/*!40000 ALTER TABLE `schema_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary table structure for view `standings`
--

DROP TABLE IF EXISTS `standings`;
/*!50001 DROP VIEW IF EXISTS `standings`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `standings` (
  `Musher` varchar(255),
  `Bibnum` int(11),
  `Checkpoint` varchar(255),
  `DogsIN` int(11),
  `TimeIN` datetime,
  `DogsOUT` int(11),
  `TimeOUT` datetime,
  `RunTime` varchar(24),
  `RestTime` varchar(24)
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `statuses`
--

DROP TABLE IF EXISTS `statuses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `statuses` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `proceed` tinyint(1) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `statuses`
--

LOCK TABLES `statuses` WRITE;
/*!40000 ALTER TABLE `statuses` DISABLE KEYS */;
INSERT INTO `statuses` VALUES (3,'0k',1,'2011-01-09 09:10:19','2011-01-09 09:11:44'),(4,'DQ',0,'2011-01-14 04:13:31','2011-01-14 04:13:31'),(5,'Scratch',0,'2011-01-14 04:13:42','2011-01-14 04:13:42');
/*!40000 ALTER TABLE `statuses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `timedcps`
--

DROP TABLE IF EXISTS `timedcps`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `timedcps` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `checkpoint_id` int(11) DEFAULT NULL,
  `startInterval` int(11) DEFAULT NULL,
  `minMakeup` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `timedcps`
--

LOCK TABLES `timedcps` WRITE;
/*!40000 ALTER TABLE `timedcps` DISABLE KEYS */;
INSERT INTO `timedcps` VALUES (2,2,2,360,'2011-01-14 04:11:22','2011-01-14 04:11:22');
/*!40000 ALTER TABLE `timedcps` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `updates`
--

DROP TABLE IF EXISTS `updates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `updates` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `musher_id` int(11) DEFAULT NULL,
  `checkpoint_id` int(11) DEFAULT NULL,
  `timein` datetime DEFAULT NULL,
  `dogsin` int(11) DEFAULT NULL,
  `timeout` datetime DEFAULT NULL,
  `dogsout` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `updates`
--

LOCK TABLES `updates` WRITE;
/*!40000 ALTER TABLE `updates` DISABLE KEYS */;
INSERT INTO `updates` VALUES (1,1,1,'2011-02-04 10:00:00',16,'2011-02-04 10:00:00',16,'2011-01-09 14:23:42','2011-01-09 14:23:42'),(16,1,2,'2011-02-04 13:31:00',16,NULL,NULL,'2011-01-10 07:32:07','2011-01-10 07:32:07');
/*!40000 ALTER TABLE `updates` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `hashed_password` varchar(255) DEFAULT NULL,
  `salt` varchar(255) DEFAULT NULL,
  `access_level` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'admin','de0316f95ec83efaaccaf9fc5e1a0bee3a8d12e6','21820279400.955187884251051','admin','admin@nellahcir.com','2011-01-09 05:52:56','2011-01-09 05:52:56'),(2,'hcir','c6019eefaaac7a04dbcea12ce0271223085f9caf','21743298400.823191167358382','user','hcir@nellahcir.com','2011-01-14 03:52:30','2011-01-14 03:52:30'),(3,'sue','9bb34724d68adf0b21fbbb95f05f77004925e3b5','21731411000.438332734101497','admin','sue@nosnowkennels.com','2011-01-14 03:54:11','2011-01-14 04:01:06'),(4,'canon','4a7107cd05edbaf470c74e19b4685a7bc966c8a3','21789698400.459382384628408','user','sue@nosnowkennels.com','2011-01-14 03:59:56','2011-01-14 03:59:56');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Final view structure for view `standings`
--

/*!50001 DROP TABLE IF EXISTS `standings`*/;
/*!50001 DROP VIEW IF EXISTS `standings`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`hcir`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `standings` AS select `m`.`name` AS `Musher`,`m`.`bibnum` AS `Bibnum`,`c`.`name` AS `Checkpoint`,`ci`.`dogs` AS `DogsIN`,`ci`.`time` AS `TimeIN`,`co`.`dogs` AS `DogsOUT`,`co`.`time` AS `TimeOUT`,cast(timediff(`ci`.`time`,(select `coinner`.`time` AS `time` from `checkouts` `coinner` where ((`coinner`.`musher_id` = `ci`.`musher_id`) and (`coinner`.`checkpoint_id` = (`ci`.`checkpoint_id` - 1))))) as char(24) charset utf8) AS `RunTime`,cast(timediff(`co`.`time`,`ci`.`time`) as char(24) charset utf8) AS `RestTime` from ((((`checkins` `ci` left join `checkouts` `co` on(((`co`.`musher_id` = `ci`.`musher_id`) and (`co`.`checkpoint_id` = `ci`.`checkpoint_id`)))) left join `mushers` `m` on((`m`.`id` = `ci`.`musher_id`))) left join `checkpoints` `c` on((`c`.`id` = `ci`.`checkpoint_id`))) left join `checkins` `ci2` on(((`ci`.`musher_id` = `ci2`.`musher_id`) and (`ci`.`checkpoint_id` < `ci2`.`checkpoint_id`)))) where isnull(`ci2`.`musher_id`) group by `ci`.`musher_id`,`co`.`musher_id` order by `c`.`sequence` desc,isnull(`co`.`time`),`co`.`time`,`ci`.`time` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2011-01-14 12:00:20
