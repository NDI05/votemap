-- MySQL dump 10.13  Distrib 9.2.0, for macos15 (arm64)
--
-- Host: localhost    Database: votemap
-- ------------------------------------------------------
-- Server version	9.2.0

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `admintpsuserdetail`
--

DROP TABLE IF EXISTS `admintpsuserdetail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `admintpsuserdetail` (
  `idData` int NOT NULL AUTO_INCREMENT,
  `idUser` int NOT NULL,
  `idTps` bigint NOT NULL,
  PRIMARY KEY (`idData`),
  UNIQUE KEY `idUser` (`idUser`),
  KEY `idx_adminTpsUser_idTps` (`idTps`),
  CONSTRAINT `admintpsuserdetail_ibfk_1` FOREIGN KEY (`idUser`) REFERENCES `users` (`idUser`) ON DELETE CASCADE,
  CONSTRAINT `admintpsuserdetail_ibfk_2` FOREIGN KEY (`idTps`) REFERENCES `tpsdata` (`idTps`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `attendance`
--

DROP TABLE IF EXISTS `attendance`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `attendance` (
  `idAttendance` int NOT NULL AUTO_INCREMENT,
  `idVoter` int NOT NULL,
  `idOfficerUser` int NOT NULL,
  `idTps` bigint NOT NULL,
  `attendanceTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `photoProof` varchar(255) DEFAULT NULL,
  `status` enum('hadir','dibatalkan') NOT NULL DEFAULT 'hadir',
  PRIMARY KEY (`idAttendance`),
  UNIQUE KEY `uq_voter_attendance` (`idVoter`),
  KEY `idx_attendance_idTps` (`idTps`),
  KEY `idx_attendance_idOfficer` (`idOfficerUser`),
  KEY `idx_attendance_status` (`status`),
  CONSTRAINT `fk_attendance_officer_user` FOREIGN KEY (`idOfficerUser`) REFERENCES `users` (`idUser`) ON DELETE CASCADE,
  CONSTRAINT `fk_attendance_tps` FOREIGN KEY (`idTps`) REFERENCES `tpsdata` (`idTps`) ON DELETE CASCADE,
  CONSTRAINT `fk_attendance_voter` FOREIGN KEY (`idVoter`) REFERENCES `voterdata` (`idData`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `citydata`
--

DROP TABLE IF EXISTS `citydata`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `citydata` (
  `idCity` bigint NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  `idProvince` bigint DEFAULT NULL,
  `latitude` decimal(10,8) DEFAULT NULL,
  `longitude` decimal(11,8) DEFAULT NULL,
  PRIMARY KEY (`idCity`),
  KEY `idx_city_name` (`name`),
  KEY `idx_city_idProvince` (`idProvince`),
  CONSTRAINT `citydata_ibfk_1` FOREIGN KEY (`idProvince`) REFERENCES `provincedata` (`idProvince`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cityusersdetail`
--

DROP TABLE IF EXISTS `cityusersdetail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cityusersdetail` (
  `idData` int NOT NULL AUTO_INCREMENT,
  `idUser` int NOT NULL,
  `idCity` bigint NOT NULL,
  PRIMARY KEY (`idData`),
  UNIQUE KEY `idUser` (`idUser`),
  KEY `idx_cityUser_idCity` (`idCity`),
  CONSTRAINT `cityusersdetail_ibfk_1` FOREIGN KEY (`idUser`) REFERENCES `users` (`idUser`) ON DELETE CASCADE,
  CONSTRAINT `cityusersdetail_ibfk_2` FOREIGN KEY (`idCity`) REFERENCES `citydata` (`idCity`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `districtdata`
--

DROP TABLE IF EXISTS `districtdata`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `districtdata` (
  `idDistrict` bigint NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  `idCity` bigint DEFAULT NULL,
  PRIMARY KEY (`idDistrict`),
  KEY `idx_district_name` (`name`),
  KEY `idx_district_idCity` (`idCity`),
  CONSTRAINT `districtdata_ibfk_1` FOREIGN KEY (`idCity`) REFERENCES `citydata` (`idCity`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `districtusersdetail`
--

DROP TABLE IF EXISTS `districtusersdetail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `districtusersdetail` (
  `idData` int NOT NULL AUTO_INCREMENT,
  `idUser` int NOT NULL,
  `idDistrict` bigint NOT NULL,
  PRIMARY KEY (`idData`),
  UNIQUE KEY `idUser` (`idUser`),
  KEY `idx_districtUser_idDistrict` (`idDistrict`),
  CONSTRAINT `districtusersdetail_ibfk_1` FOREIGN KEY (`idUser`) REFERENCES `users` (`idUser`) ON DELETE CASCADE,
  CONSTRAINT `districtusersdetail_ibfk_2` FOREIGN KEY (`idDistrict`) REFERENCES `districtdata` (`idDistrict`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `electiondata`
--

DROP TABLE IF EXISTS `electiondata`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `electiondata` (
  `idData` int NOT NULL AUTO_INCREMENT,
  `countTotal` int DEFAULT NULL,
  `countValid` int DEFAULT NULL,
  `countInvalid` int DEFAULT NULL,
  `countAbstain` int DEFAULT NULL,
  `locationPhoto` varchar(255) NOT NULL,
  `idAdmin` int NOT NULL,
  `status` enum('submitted','archived') NOT NULL DEFAULT 'submitted',
  PRIMARY KEY (`idData`),
  KEY `idx_election_idAdmin` (`idAdmin`),
  KEY `idx_election_status` (`status`),
  CONSTRAINT `electiondata_ibfk_1` FOREIGN KEY (`idAdmin`) REFERENCES `admintpsuserdetail` (`idData`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `nationalusersdetail`
--

DROP TABLE IF EXISTS `nationalusersdetail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `nationalusersdetail` (
  `idData` int NOT NULL AUTO_INCREMENT,
  `idUser` int DEFAULT NULL,
  PRIMARY KEY (`idData`),
  KEY `idx_national_idUser` (`idUser`),
  CONSTRAINT `nationalusersdetail_ibfk_1` FOREIGN KEY (`idUser`) REFERENCES `users` (`idUser`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `officertpsuserdetail`
--

DROP TABLE IF EXISTS `officertpsuserdetail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `officertpsuserdetail` (
  `idData` int NOT NULL AUTO_INCREMENT,
  `idUser` int NOT NULL,
  `idTps` bigint NOT NULL,
  PRIMARY KEY (`idData`),
  UNIQUE KEY `idUser` (`idUser`),
  KEY `idx_officerTpsUser_idTps` (`idTps`),
  CONSTRAINT `officertpsuserdetail_ibfk_1` FOREIGN KEY (`idUser`) REFERENCES `users` (`idUser`) ON DELETE CASCADE,
  CONSTRAINT `officertpsuserdetail_ibfk_2` FOREIGN KEY (`idTps`) REFERENCES `tpsdata` (`idTps`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `provincedata`
--

DROP TABLE IF EXISTS `provincedata`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `provincedata` (
  `idProvince` bigint NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  `latitude` decimal(10,8) DEFAULT NULL,
  `longitude` decimal(11,8) DEFAULT NULL,
  PRIMARY KEY (`idProvince`),
  KEY `idx_province_name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `provinceusersdetail`
--

DROP TABLE IF EXISTS `provinceusersdetail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `provinceusersdetail` (
  `idData` int NOT NULL AUTO_INCREMENT,
  `idUser` int NOT NULL,
  `idProvince` bigint NOT NULL,
  PRIMARY KEY (`idData`),
  UNIQUE KEY `idUser` (`idUser`),
  KEY `idx_provinceUser_idProvince` (`idProvince`),
  CONSTRAINT `provinceusersdetail_ibfk_1` FOREIGN KEY (`idUser`) REFERENCES `users` (`idUser`) ON DELETE CASCADE,
  CONSTRAINT `provinceusersdetail_ibfk_2` FOREIGN KEY (`idProvince`) REFERENCES `provincedata` (`idProvince`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `reportdata`
--

DROP TABLE IF EXISTS `reportdata`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reportdata` (
  `idData` int NOT NULL AUTO_INCREMENT,
  `subject` varchar(255) DEFAULT NULL,
  `description` text,
  `idElectionData` int DEFAULT NULL,
  `idAdmin` int DEFAULT NULL,
  `status` enum('pending','approved','rejected') DEFAULT 'pending',
  PRIMARY KEY (`idData`),
  KEY `idx_report_idAdmin` (`idAdmin`),
  KEY `idx_report_status` (`status`),
  KEY `fk_report_election` (`idElectionData`),
  CONSTRAINT `fk_report_election` FOREIGN KEY (`idElectionData`) REFERENCES `electiondata` (`idData`) ON DELETE SET NULL,
  CONSTRAINT `reportdata_ibfk_1` FOREIGN KEY (`idAdmin`) REFERENCES `admintpsuserdetail` (`idData`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `subdistrictdata`
--

DROP TABLE IF EXISTS `subdistrictdata`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `subdistrictdata` (
  `idSubDistrict` bigint NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  `idDistrict` bigint DEFAULT NULL,
  PRIMARY KEY (`idSubDistrict`),
  KEY `idx_subDistrict_name` (`name`),
  KEY `idx_subDistrict_idDistrict` (`idDistrict`),
  CONSTRAINT `subdistrictdata_ibfk_1` FOREIGN KEY (`idDistrict`) REFERENCES `districtdata` (`idDistrict`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `subdistrictusersdetail`
--

DROP TABLE IF EXISTS `subdistrictusersdetail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `subdistrictusersdetail` (
  `idData` int NOT NULL AUTO_INCREMENT,
  `idUser` int NOT NULL,
  `idSubDistrict` bigint NOT NULL,
  PRIMARY KEY (`idData`),
  UNIQUE KEY `idUser` (`idUser`),
  KEY `idx_subDistrictUser_idSubDistrict` (`idSubDistrict`),
  CONSTRAINT `subdistrictusersdetail_ibfk_1` FOREIGN KEY (`idUser`) REFERENCES `users` (`idUser`) ON DELETE CASCADE,
  CONSTRAINT `subdistrictusersdetail_ibfk_2` FOREIGN KEY (`idSubDistrict`) REFERENCES `subdistrictdata` (`idSubDistrict`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tpsdata`
--

DROP TABLE IF EXISTS `tpsdata`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tpsdata` (
  `idTps` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(155) DEFAULT NULL,
  `idSubDistrict` bigint DEFAULT NULL,
  `status` enum('active','deleted') NOT NULL DEFAULT 'active',
  PRIMARY KEY (`idTps`),
  KEY `idx_tps_idSubDistrict` (`idSubDistrict`),
  KEY `idx_tps_name` (`name`),
  KEY `idx_tps_status` (`status`),
  CONSTRAINT `tpsdata_ibfk_1` FOREIGN KEY (`idSubDistrict`) REFERENCES `subdistrictdata` (`idSubDistrict`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `idUser` int NOT NULL AUTO_INCREMENT,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` enum('national','province','district','sub_district','city','officerTps','adminTps') NOT NULL,
  `status` enum('active','inactive','pending') NOT NULL DEFAULT 'active',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`idUser`),
  UNIQUE KEY `email` (`email`),
  KEY `idx_users_role` (`role`),
  KEY `idx_users_created_at` (`created_at`),
  KEY `idx_users_status` (`status`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `voterdata`
--

DROP TABLE IF EXISTS `voterdata`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `voterdata` (
  `idData` int NOT NULL AUTO_INCREMENT,
  `nik` varchar(16) NOT NULL,
  `name` varchar(255) NOT NULL,
  `dateOfBirth` date NOT NULL,
  `gender` tinyint NOT NULL,
  `idOfficerUser` int NOT NULL,
  `locationPhoto` varchar(255) DEFAULT NULL,
  `status` enum('active','deleted') NOT NULL DEFAULT 'active',
  PRIMARY KEY (`idData`),
  UNIQUE KEY `nik` (`nik`),
  KEY `idx_voter_name` (`name`),
  KEY `idx_voter_idOfficer` (`idOfficerUser`),
  KEY `idx_voter_dateOfBirth` (`dateOfBirth`),
  KEY `idx_voter_status` (`status`),
  CONSTRAINT `fk_voter_officer_user` FOREIGN KEY (`idOfficerUser`) REFERENCES `users` (`idUser`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Temporary view structure for view `vw_admin_users`
--

DROP TABLE IF EXISTS `vw_admin_users`;
/*!50001 DROP VIEW IF EXISTS `vw_admin_users`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_admin_users` AS SELECT 
 1 AS `idUser`,
 1 AS `name`,
 1 AS `email`,
 1 AS `role`,
 1 AS `status`,
 1 AS `idProvince`,
 1 AS `provinceName`,
 1 AS `idCity`,
 1 AS `cityName`,
 1 AS `idDistrict`,
 1 AS `districtName`,
 1 AS `idSubDistrict`,
 1 AS `subDistrictName`,
 1 AS `idTps`,
 1 AS `tpsName`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_attendance_list`
--

DROP TABLE IF EXISTS `vw_attendance_list`;
/*!50001 DROP VIEW IF EXISTS `vw_attendance_list`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_attendance_list` AS SELECT 
 1 AS `id`,
 1 AS `nama`,
 1 AS `nik`,
 1 AS `tgl_lahir`,
 1 AS `jk`,
 1 AS `tps`,
 1 AS `id_tps`,
 1 AS `foto`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_election_details`
--

DROP TABLE IF EXISTS `vw_election_details`;
/*!50001 DROP VIEW IF EXISTS `vw_election_details`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_election_details` AS SELECT 
 1 AS `idData`,
 1 AS `countTotal`,
 1 AS `countValid`,
 1 AS `countInvalid`,
 1 AS `countAbstain`,
 1 AS `locationPhoto`,
 1 AS `status`,
 1 AS `adminUserId`,
 1 AS `adminName`,
 1 AS `idTps`,
 1 AS `tpsName`,
 1 AS `idSubDistrict`,
 1 AS `subDistrictName`,
 1 AS `idDistrict`,
 1 AS `districtName`,
 1 AS `idCity`,
 1 AS `cityName`,
 1 AS `idProvince`,
 1 AS `provinceName`,
 1 AS `provinceLatitude`,
 1 AS `provinceLongitude`,
 1 AS `cityLatitude`,
 1 AS `cityLongitude`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_report_details`
--

DROP TABLE IF EXISTS `vw_report_details`;
/*!50001 DROP VIEW IF EXISTS `vw_report_details`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_report_details` AS SELECT 
 1 AS `idReport`,
 1 AS `reportSubject`,
 1 AS `reportDescription`,
 1 AS `reportStatus`,
 1 AS `idElectionData`,
 1 AS `idTps`,
 1 AS `tpsName`,
 1 AS `subDistrictName`,
 1 AS `districtName`,
 1 AS `cityName`,
 1 AS `provinceName`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_tps_details`
--

DROP TABLE IF EXISTS `vw_tps_details`;
/*!50001 DROP VIEW IF EXISTS `vw_tps_details`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_tps_details` AS SELECT 
 1 AS `idTps`,
 1 AS `name`,
 1 AS `status`,
 1 AS `idSubDistrict`,
 1 AS `subDistrictName`,
 1 AS `idDistrict`,
 1 AS `districtName`,
 1 AS `idCity`,
 1 AS `cityName`,
 1 AS `idProvince`,
 1 AS `provinceName`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_voter_details`
--

DROP TABLE IF EXISTS `vw_voter_details`;
/*!50001 DROP VIEW IF EXISTS `vw_voter_details`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_voter_details` AS SELECT 
 1 AS `idData`,
 1 AS `nik`,
 1 AS `name`,
 1 AS `status`,
 1 AS `dateOfBirth`,
 1 AS `gender`,
 1 AS `locationPhoto`,
 1 AS `idOfficerUser`,
 1 AS `officerName`,
 1 AS `idTps`,
 1 AS `tpsName`,
 1 AS `idSubDistrict`,
 1 AS `subDistrictName`,
 1 AS `idDistrict`,
 1 AS `districtName`,
 1 AS `idCity`,
 1 AS `cityName`,
 1 AS `idProvince`,
 1 AS `provinceName`*/;
SET character_set_client = @saved_cs_client;

--
-- Dumping routines for database 'votemap'
--
/*!50003 DROP PROCEDURE IF EXISTS `sp_attendance_cancel` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_attendance_cancel`(IN p_actor_idUser INT, IN p_idAttendance INT)
BEGIN
    DECLARE v_idTps BIGINT;
    SELECT idTps INTO v_idTps FROM attendance WHERE idAttendance = p_idAttendance;
    IF v_idTps IS NULL THEN SIGNAL SQLSTATE '45021'; END IF;
    CALL sp_validateUser(p_actor_idUser, v_idTps, 'tps');
    UPDATE attendance SET status = 'dibatalkan' WHERE idAttendance = p_idAttendance;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_attendance_create` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_attendance_create`(IN p_actor_idUser INT, IN p_idVoter INT, IN p_idOfficerUserOnDuty INT, IN p_photoProof VARCHAR(255))
BEGIN
    DECLARE v_actor_role VARCHAR(50);
    DECLARE v_actor_idTps BIGINT;
    DECLARE v_officer_idTps BIGINT;
    DECLARE v_voter_idTps BIGINT;
    DECLARE v_attendance_count INT DEFAULT 0;
    SELECT u.role, ad.idTps INTO v_actor_role, v_actor_idTps FROM users u JOIN admintpsuserdetail ad ON u.idUser = ad.idUser WHERE u.idUser = p_actor_idUser;
    IF v_actor_role != 'adminTps' THEN SIGNAL SQLSTATE '45001'; END IF;
    SELECT idTps INTO v_officer_idTps FROM officertpsuserdetail WHERE idUser = p_idOfficerUserOnDuty;
    IF v_officer_idTps IS NULL THEN SIGNAL SQLSTATE '45031';
    ELSEIF v_officer_idTps != v_actor_idTps THEN SIGNAL SQLSTATE '45032'; END IF;
    SELECT t.idTps INTO v_voter_idTps FROM voterdata v JOIN officertpsuserdetail otud ON v.idOfficerUser = otud.idUser JOIN tpsdata t ON otud.idTps = t.idTps WHERE v.idData = p_idVoter;
    IF v_voter_idTps != v_actor_idTps THEN SIGNAL SQLSTATE '45041'; END IF;
    SELECT COUNT(*) INTO v_attendance_count FROM attendance WHERE idVoter = p_idVoter;
    IF v_attendance_count > 0 THEN SIGNAL SQLSTATE '45040'; END IF;
    INSERT INTO attendance(idVoter, idOfficerUser, idTps, photoProof) VALUES (p_idVoter, p_idOfficerUserOnDuty, v_actor_idTps, p_photoProof);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_attendance_read` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_attendance_read`(IN p_actor_idUser INT, IN p_filter_idTps BIGINT)
BEGIN
    DECLARE v_actor_role VARCHAR(50);
    DECLARE v_actor_idTps BIGINT;
    SELECT u.role, COALESCE(atud.idTps, otud.idTps) INTO v_actor_role, v_actor_idTps FROM users u LEFT JOIN admintpsuserdetail atud ON u.idUser = atud.idUser LEFT JOIN officertpsuserdetail otud ON u.idUser = otud.idUser WHERE u.idUser = p_actor_idUser;
    IF v_actor_role IN ('adminTps', 'officerTps') THEN SET p_filter_idTps = v_actor_idTps; END IF;
    SELECT a.idAttendance, a.attendanceTime, v.nik, v.name AS voterName, t.name AS tpsName, u.name AS officerName FROM attendance a JOIN voterdata v ON a.idVoter = v.idData JOIN tpsdata t ON a.idTps = t.idTps JOIN users u ON a.idOfficerUser = u.idUser WHERE (p_filter_idTps IS NULL OR a.idTps = p_filter_idTps) AND a.status = 'hadir';
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_auth_login` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_auth_login`(IN p_email VARCHAR(100), IN p_password VARCHAR(255))
BEGIN
    DECLARE v_idUser INT;
    SELECT idUser INTO v_idUser FROM users WHERE email = p_email AND password = SHA2(p_password, 256) AND status = 'active' LIMIT 1;
    IF v_idUser IS NOT NULL THEN SELECT * FROM vw_admin_users WHERE idUser = v_idUser; END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_dashboard_get_summary` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_dashboard_get_summary`(
    IN p_idProvince VARCHAR(13), IN p_idCity VARCHAR(13), IN p_idDistrict VARCHAR(13), 
    IN p_idSubDistrict VARCHAR(13), IN p_idTps BIGINT
)
BEGIN
    DECLARE v_tps_total INT;
    DECLARE v_tps_masuk INT;
    DECLARE v_pemilih_hadir INT;
    DECLARE v_total_dpt INT;

    CREATE TEMPORARY TABLE IF NOT EXISTS relevant_tps AS (
        SELECT idTps FROM vw_tps_details
        WHERE
            (p_idProvince IS NULL OR idProvince = p_idProvince) AND
            (p_idCity IS NULL OR idCity = p_idCity) AND
            (p_idDistrict IS NULL OR idDistrict = p_idDistrict) AND
            (p_idSubDistrict IS NULL OR idSubDistrict = p_idSubDistrict) AND
            (p_idTps IS NULL OR idTps = p_idTps)
    );

    SELECT COUNT(*) INTO v_tps_total FROM relevant_tps;

    SELECT COUNT(DISTINCT ad.idTps) INTO v_tps_masuk
    FROM electiondata e JOIN admintpsuserdetail ad ON e.idAdmin = ad.idData
    WHERE e.status = 'submitted' AND ad.idTps IN (SELECT idTps FROM relevant_tps);

    SELECT COUNT(*) INTO v_pemilih_hadir
    FROM attendance a
    WHERE a.idTps IN (SELECT idTps FROM relevant_tps) AND a.status = 'hadir';

    SELECT COUNT(v.idData) INTO v_total_dpt
    FROM voterdata v JOIN officertpsuserdetail otud ON v.idOfficerUser = otud.idUser
    WHERE otud.idTps IN (SELECT idTps FROM relevant_tps) AND v.status = 'active';

    SELECT v_tps_masuk AS tps_masuk, v_tps_total AS tps_total;
    SELECT v_pemilih_hadir AS pemilih_hadir, v_total_dpt AS total_dpt;

    SELECT CASE WHEN age BETWEEN 17 AND 25 THEN '17-25' WHEN age BETWEEN 26 AND 40 THEN '26-40' WHEN age BETWEEN 41 AND 60 THEN '41-60' ELSE '>60' END AS age_group, COUNT(*) AS total FROM (SELECT TIMESTAMPDIFF(YEAR, v.dateOfBirth, CURDATE()) AS age FROM voterdata v JOIN officertpsuserdetail otud ON v.idOfficerUser = otud.idUser WHERE otud.idTps IN (SELECT idTps FROM relevant_tps) AND v.status = 'active') AS age_data GROUP BY age_group;
    SELECT CASE WHEN age BETWEEN 17 AND 25 THEN '17-25' WHEN age BETWEEN 26 AND 40 THEN '26-40' WHEN age BETWEEN 41 AND 60 THEN '41-60' ELSE '>60' END AS age_group, COUNT(*) AS total FROM (SELECT TIMESTAMPDIFF(YEAR, v.dateOfBirth, CURDATE()) AS age FROM attendance a JOIN voterdata v ON a.idVoter = v.idData WHERE a.idTps IN (SELECT idTps FROM relevant_tps) AND a.status = 'hadir') AS age_data GROUP BY age_group;
    
    SELECT * FROM vw_election_details WHERE idTps IN (SELECT idTps FROM relevant_tps) AND status = 'submitted' LIMIT 10;
    
    SELECT r.idData, t.name as tpsName, r.subject, r.status FROM reportdata r JOIN electiondata e ON r.idElectionData = e.idData JOIN admintpsuserdetail ad ON e.idAdmin = ad.idData JOIN tpsdata t ON ad.idTps = t.idTps WHERE t.idTps IN (SELECT idTps FROM relevant_tps) AND r.status = 'pending' LIMIT 10;

    DROP TEMPORARY TABLE relevant_tps;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_election_archive` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_election_archive`(IN p_actor_idUser INT, IN p_idData INT)
BEGIN
    DECLARE v_actor_role VARCHAR(50);
    DECLARE v_idTps BIGINT;
    
    SELECT role INTO v_actor_role FROM users WHERE idUser = p_actor_idUser;
    IF v_actor_role = 'adminTps' THEN 
        SIGNAL SQLSTATE '45001'; 
    END IF;

    SELECT idTps INTO v_idTps FROM vw_election_details WHERE idData = p_idData;
    IF v_idTps IS NULL THEN 
        SIGNAL SQLSTATE '45021'; 
    END IF;

    CALL sp_validateUser(p_actor_idUser, v_idTps, 'tps');
    
    UPDATE electiondata SET status = 'archived' WHERE idData = p_idData;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_election_create` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_election_create`(
    IN p_actor_idUser INT,
    IN p_countValid INT,
    IN p_countInvalid INT,
    IN p_locationPhoto VARCHAR(255)
)
BEGIN
    DECLARE v_admin_detail_id INT;
    DECLARE v_idTps BIGINT;
    DECLARE v_existing_count INT DEFAULT 0;
    DECLARE v_total_dpt INT;
    DECLARE v_total_hadir INT;
    DECLARE v_count_abstain INT;

    SELECT ad.idData, ad.idTps INTO v_admin_detail_id, v_idTps
    FROM admintpsuserdetail ad
    WHERE ad.idUser = p_actor_idUser;

    IF v_admin_detail_id IS NULL THEN
        SIGNAL SQLSTATE '45001';
    END IF;

    SELECT COUNT(*) INTO v_existing_count 
    FROM electiondata e 
    JOIN admintpsuserdetail ad ON e.idAdmin = ad.idData 
    WHERE ad.idTps = v_idTps AND e.status = 'submitted';

    IF v_existing_count > 0 THEN
        SIGNAL SQLSTATE '45050';
    END IF;

    SELECT COUNT(*) INTO v_total_dpt
    FROM voterdata v
    WHERE v.idOfficerUser IN (SELECT idUser FROM officertpsuserdetail WHERE idTps = v_idTps);

    SELECT COUNT(*) INTO v_total_hadir
    FROM attendance
    WHERE idTps = v_idTps AND status = 'hadir';

    SET v_count_abstain = v_total_dpt - v_total_hadir;
    IF v_count_abstain < 0 THEN
        SET v_count_abstain = 0;
    END IF;

    INSERT INTO electiondata (countTotal, countValid, countInvalid, countAbstain, locationPhoto, idAdmin)
    VALUES (
        (p_countValid + p_countInvalid), 
        p_countValid, 
        p_countInvalid, 
        v_count_abstain,
        p_locationPhoto, 
        v_admin_detail_id
    );
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_election_read` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_election_read`(IN p_actor_idUser INT, IN p_filter_idTps BIGINT)
BEGIN
    DECLARE v_actor_role VARCHAR(50);
    SELECT role INTO v_actor_role FROM users WHERE idUser = p_actor_idUser;
    IF v_actor_role = 'adminTps' THEN SIGNAL SQLSTATE '45001'; END IF;
    CALL sp_validateUser(p_actor_idUser, 0, 'national');
    
    SELECT * FROM vw_election_details 
    WHERE 
        (p_filter_idTps IS NULL OR idTps = p_filter_idTps) 
        AND status = 'submitted';
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_election_update` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_election_update`(IN p_actor_idUser INT, IN p_idData INT, IN p_countValid INT, IN p_countInvalid INT, IN p_countAbstain INT, IN p_locationPhoto VARCHAR(255))
BEGIN
    DECLARE v_actor_role VARCHAR(50);
    DECLARE v_idTps BIGINT;
    SELECT role INTO v_actor_role FROM users WHERE idUser = p_actor_idUser;
    IF v_actor_role = 'adminTps' THEN SIGNAL SQLSTATE '45001'; END IF;
    SELECT idTps INTO v_idTps FROM vw_election_details WHERE idData = p_idData;
    IF v_idTps IS NULL THEN SIGNAL SQLSTATE '45021'; END IF;
    CALL sp_validateUser(p_actor_idUser, v_idTps, 'tps');
    UPDATE electiondata SET
        countValid = COALESCE(p_countValid, countValid),
        countInvalid = COALESCE(p_countInvalid, countInvalid),
        countAbstain = COALESCE(p_countAbstain, countAbstain),
        countTotal = (COALESCE(p_countValid, countValid) + COALESCE(p_countInvalid, countInvalid)),
        locationPhoto = COALESCE(p_locationPhoto, locationPhoto)
    WHERE idData = p_idData;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_public_get_recapitulation` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_public_get_recapitulation`(IN p_idProvince BIGINT, IN p_idCity BIGINT, IN p_idDistrict BIGINT, IN p_idSubDistrict BIGINT, IN p_idTps BIGINT)
BEGIN
    SELECT 
        idData, idTps, tpsName, subDistrictName, districtName, cityName, provinceName,
        countValid, countInvalid, countTotal, locationPhoto
    FROM vw_election_details
    WHERE 
        (p_idProvince IS NULL OR idProvince = p_idProvince) AND
        (p_idCity IS NULL OR idCity = p_idCity) AND
        (p_idDistrict IS NULL OR idDistrict = p_idDistrict) AND
        (p_idSubDistrict IS NULL OR idSubDistrict = p_idSubDistrict) AND
        (p_idTps IS NULL OR idTps = p_idTps) AND
        status = 'submitted';
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_report_create_public` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_report_create_public`(
    IN p_idElectionData INT,
    IN p_subject VARCHAR(255),
    IN p_description TEXT
)
BEGIN
    DECLARE v_election_status ENUM('submitted', 'archived');

    SELECT status INTO v_election_status 
    FROM electiondata 
    WHERE idData = p_idElectionData;

    IF v_election_status IS NULL THEN
        SIGNAL SQLSTATE '45021'; 
    END IF;

    IF v_election_status = 'archived' THEN
        SIGNAL SQLSTATE '45051'; 
    END IF;

    INSERT INTO reportdata(idElectionData, subject, description, status)
    VALUES (p_idElectionData, p_subject, p_description, 'pending');

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_report_read` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_report_read`(IN p_actor_idUser INT, IN p_filter_status ENUM('pending', 'approved', 'rejected'))
BEGIN
    DECLARE v_actor_role VARCHAR(50);
    SELECT role INTO v_actor_role FROM users WHERE idUser = p_actor_idUser;
    IF v_actor_role != 'national' THEN SIGNAL SQLSTATE '45001'; END IF;
    SELECT * FROM vw_report_details WHERE (p_filter_status IS NULL OR reportStatus = p_filter_status);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_report_update_status` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_report_update_status`(IN p_actor_idUser INT, IN p_idReport INT, IN p_new_status ENUM('pending', 'approved', 'rejected'))
BEGIN
    DECLARE v_actor_role VARCHAR(50);
    DECLARE v_report_exists INT DEFAULT 0;
    SELECT role INTO v_actor_role FROM users WHERE idUser = p_actor_idUser;
    IF v_actor_role != 'national' THEN SIGNAL SQLSTATE '45001'; END IF;
    SELECT COUNT(*) INTO v_report_exists FROM reportdata WHERE idData = p_idReport;
    IF v_report_exists = 0 THEN SIGNAL SQLSTATE '45021'; END IF;
    UPDATE reportdata SET status = p_new_status WHERE idData = p_idReport;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_tps_archive` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_tps_archive`(IN p_actor_idUser INT, IN p_idTps BIGINT)
BEGIN
    DECLARE v_idSubDistrict VARCHAR(13);
    SELECT idSubDistrict INTO v_idSubDistrict FROM tpsdata WHERE idTps = p_idTps;
    IF v_idSubDistrict IS NULL THEN SIGNAL SQLSTATE '45021'; END IF;
    CALL sp_validateUser(p_actor_idUser, v_idSubDistrict, 'sub_district');
    UPDATE tpsdata SET status = 'deleted' WHERE idTps = p_idTps;
    UPDATE users u JOIN (SELECT idUser FROM admintpsuserdetail WHERE idTps = p_idTps UNION SELECT idUser FROM officertpsuserdetail WHERE idTps = p_idTps) AS tps_users ON u.idUser = t_users.idUser
    SET u.status = 'inactive';
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_tps_create` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_tps_create`(
    IN p_actor_idUser INT,
    IN p_name VARCHAR(155),
    IN p_idSubDistrict VARCHAR(13)
)
BEGIN
    DECLARE v_existing_id BIGINT;
    DECLARE v_existing_status ENUM('active', 'deleted');

    CALL sp_validateUser(p_actor_idUser, p_idSubDistrict, 'sub_district');

    SELECT idTps, status INTO v_existing_id, v_existing_status 
    FROM tpsdata 
    WHERE name = p_name AND idSubDistrict = p_idSubDistrict;

    IF v_existing_id IS NOT NULL AND v_existing_status = 'active' THEN
        SIGNAL SQLSTATE '45020';
    END IF;

    BEGIN
        DECLARE EXIT HANDLER FOR SQLEXCEPTION 
        BEGIN
            ROLLBACK;
            SIGNAL SQLSTATE '45000';
        END;

        START TRANSACTION;
        IF v_existing_id IS NOT NULL THEN
            UPDATE tpsdata SET status = 'active' WHERE idTps = v_existing_id;
        ELSE
            INSERT INTO tpsdata(name, idSubDistrict, status) VALUES (p_name, p_idSubDistrict, 'active');
        END IF;
        COMMIT;
    END;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_tps_read` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_tps_read`(IN p_actor_idUser INT, IN p_filter_name VARCHAR(255), IN p_filter_idSubDistrict BIGINT, IN p_filter_idDistrict BIGINT, IN p_filter_idCity BIGINT, IN p_filter_idProvince BIGINT, IN p_limit INT, IN p_offset INT)
BEGIN
    DECLARE v_actor_role VARCHAR(50);
    DECLARE v_actor_idProvince BIGINT;
    DECLARE v_actor_idCity BIGINT;
    DECLARE v_actor_idDistrict BIGINT;
    DECLARE v_actor_idSubDistrict BIGINT;
    DECLARE v_actor_idTps BIGINT;
    SELECT role, idProvince, idCity, idDistrict, idSubDistrict, idTps INTO v_actor_role, v_actor_idProvince, v_actor_idCity, v_actor_idDistrict, v_actor_idSubDistrict, v_actor_idTps FROM vw_admin_users WHERE idUser = p_actor_idUser;
    SELECT * FROM vw_tps_details WHERE (v_actor_role = 'national' OR (v_actor_role = 'province' AND vw_tps_details.idProvince = v_actor_idProvince) OR (v_actor_role = 'city' AND vw_tps_details.idCity = v_actor_idCity) OR (v_actor_role = 'district' AND vw_tps_details.idDistrict = v_actor_idDistrict) OR (v_actor_role = 'sub_district' AND vw_tps_details.idSubDistrict = v_actor_idSubDistrict) OR (v_actor_role IN ('adminTps', 'officerTps') AND vw_tps_details.idTps = v_actor_idTps)) AND (p_filter_name IS NULL OR vw_tps_details.name LIKE CONCAT('%', p_filter_name, '%')) AND (p_filter_idSubDistrict IS NULL OR vw_tps_details.idSubDistrict = p_filter_idSubDistrict) AND (p_filter_idDistrict IS NULL OR vw_tps_details.idDistrict = p_filter_idDistrict) AND (p_filter_idCity IS NULL OR vw_tps_details.idCity = p_filter_idCity) AND (p_filter_idProvince IS NULL OR vw_tps_details.idProvince = p_filter_idProvince) LIMIT p_limit OFFSET p_offset;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_tps_update` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_tps_update`(IN p_actor_idUser INT, IN p_idTps BIGINT, IN p_name VARCHAR(155), IN p_idSubDistrict VARCHAR(13))
BEGIN
    DECLARE v_original_idSubDistrict VARCHAR(13);
    SELECT idSubDistrict INTO v_original_idSubDistrict FROM tpsdata WHERE idTps = p_idTps;
    IF v_original_idSubDistrict IS NULL THEN
        SIGNAL SQLSTATE '45021';
    END IF;
    CALL sp_validateUser(p_actor_idUser, v_original_idSubDistrict, 'sub_district');
    IF p_idSubDistrict IS NOT NULL AND p_idSubDistrict != v_original_idSubDistrict THEN
        CALL sp_validateUser(p_actor_idUser, p_idSubDistrict, 'sub_district');
    END IF;
    UPDATE tpsdata
    SET
        name = COALESCE(p_name, name),
        idSubDistrict = COALESCE(p_idSubDistrict, idSubDistrict)
    WHERE idTps = p_idTps;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_users_create` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_users_create`(IN p_actor_idUser INT, IN p_email VARCHAR(100), IN p_password VARCHAR(255), IN p_name VARCHAR(255), IN p_role ENUM('national','province','district','sub_district','city','officerTps','adminTps'), IN p_assignmentId BIGINT)
BEGIN
    DECLARE v_actor_role VARCHAR(50);
    DECLARE v_existing_id INT;
    DECLARE v_existing_status ENUM('active', 'inactive', 'pending');
    DECLARE v_target_level VARCHAR(50);
    DECLARE v_assignment_exists INT DEFAULT 0;

    SELECT role INTO v_actor_role FROM users WHERE idUser = p_actor_idUser;
    IF v_actor_role = p_role THEN SIGNAL SQLSTATE '45014'; END IF;

    IF p_role = 'province' THEN SET v_target_level = 'province';
    ELSEIF p_role = 'city' THEN SET v_target_level = 'city';
    ELSEIF p_role = 'district' THEN SET v_target_level = 'district';
    ELSEIF p_role = 'sub_district' THEN SET v_target_level = 'sub_district';
    ELSEIF p_role IN ('adminTps', 'officerTps') THEN SET v_target_level = 'tps';
    ELSEIF p_role = 'national' THEN SET v_target_level = 'national';
    END IF;

    IF v_target_level IS NOT NULL THEN CALL sp_validateUser(p_actor_idUser, p_assignmentId, v_target_level);
    ELSE SIGNAL SQLSTATE '45011'; END IF;

    IF p_role != 'national' THEN
        IF p_role = 'province' THEN SELECT COUNT(*) INTO v_assignment_exists FROM provincedata WHERE idProvince = p_assignmentId;
        ELSEIF p_role = 'city' THEN SELECT COUNT(*) INTO v_assignment_exists FROM citydata WHERE idCity = p_assignmentId;
        ELSEIF p_role = 'district' THEN SELECT COUNT(*) INTO v_assignment_exists FROM districtdata WHERE idDistrict = p_assignmentId;
        ELSEIF p_role = 'sub_district' THEN SELECT COUNT(*) INTO v_assignment_exists FROM subdistrictdata WHERE idSubDistrict = p_assignmentId;
        ELSEIF p_role IN ('adminTps', 'officerTps') THEN SELECT COUNT(*) INTO v_assignment_exists FROM tpsdata WHERE idTps = p_assignmentId;
        END IF;
        IF v_assignment_exists = 0 THEN SIGNAL SQLSTATE '45013'; END IF;
    END IF;

    SELECT idUser, status INTO v_existing_id, v_existing_status FROM users WHERE email = p_email;
    IF v_existing_id IS NOT NULL AND v_existing_status = 'active' THEN SIGNAL SQLSTATE '45010'; END IF;

    BEGIN
        DECLARE EXIT HANDLER FOR SQLEXCEPTION BEGIN ROLLBACK; SIGNAL SQLSTATE '45000'; END;
        START TRANSACTION;
        IF v_existing_id IS NOT NULL THEN
            UPDATE users SET name = p_name, password = SHA2(p_password, 256), role = p_role, status = 'active' WHERE idUser = v_existing_id;
            DELETE FROM nationalusersdetail WHERE idUser = v_existing_id;
            DELETE FROM provinceusersdetail WHERE idUser = v_existing_id;
            DELETE FROM cityusersdetail WHERE idUser = v_existing_id;
            DELETE FROM districtusersdetail WHERE idUser = v_existing_id;
            DELETE FROM subdistrictusersdetail WHERE idUser = v_existing_id;
            DELETE FROM admintpsuserdetail WHERE idUser = v_existing_id;
            DELETE FROM officertpsuserdetail WHERE idUser = v_existing_id;
            IF p_role = 'province' THEN INSERT INTO provinceusersdetail (idUser, idProvince) VALUES (v_existing_id, p_assignmentId);
            ELSEIF p_role = 'city' THEN INSERT INTO cityusersdetail (idUser, idCity) VALUES (v_existing_id, p_assignmentId);
            ELSEIF p_role = 'district' THEN INSERT INTO districtusersdetail (idUser, idDistrict) VALUES (v_existing_id, p_assignmentId);
            ELSEIF p_role = 'sub_district' THEN INSERT INTO subdistrictusersdetail (idUser, idSubDistrict) VALUES (v_existing_id, p_assignmentId);
            ELSEIF p_role = 'adminTps' THEN INSERT INTO admintpsuserdetail (idUser, idTps) VALUES (v_existing_id, p_assignmentId);
            ELSEIF p_role = 'officerTps' THEN INSERT INTO officertpsuserdetail (idUser, idTps) VALUES (v_existing_id, p_assignmentId);
            ELSEIF p_role = 'national' THEN INSERT INTO nationalusersdetail (idUser) VALUES (v_existing_id);
            END IF;
        ELSE
            INSERT INTO users (email, password, name, role, status) VALUES (p_email, SHA2(p_password, 256), p_name, p_role, 'active');
            SET @new_idUser = LAST_INSERT_ID();
            IF p_role = 'province' THEN INSERT INTO provinceusersdetail (idUser, idProvince) VALUES (@new_idUser, p_assignmentId);
            ELSEIF p_role = 'city' THEN INSERT INTO cityusersdetail (idUser, idCity) VALUES (@new_idUser, p_assignmentId);
            ELSEIF p_role = 'district' THEN INSERT INTO districtusersdetail (idUser, idDistrict) VALUES (@new_idUser, p_assignmentId);
            ELSEIF p_role = 'sub_district' THEN INSERT INTO subdistrictusersdetail (idUser, idSubDistrict) VALUES (@new_idUser, p_assignmentId);
            ELSEIF p_role = 'adminTps' THEN INSERT INTO admintpsuserdetail (idUser, idTps) VALUES (@new_idUser, p_assignmentId);
            ELSEIF p_role = 'officerTps' THEN INSERT INTO officertpsuserdetail (idUser, idTps) VALUES (@new_idUser, p_assignmentId);
            ELSEIF p_role = 'national' THEN INSERT INTO nationalusersdetail (idUser) VALUES (@new_idUser);
            END IF;
        END IF;
        COMMIT;
    END;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_users_disable` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_users_disable`(IN p_actor_idUser INT, IN p_target_idUser INT)
BEGIN
    DECLARE v_actor_role VARCHAR(50);
    DECLARE v_target_role VARCHAR(50);
    DECLARE v_target_level VARCHAR(50);
    DECLARE v_target_assignmentId BIGINT;
    IF p_actor_idUser = p_target_idUser THEN SIGNAL SQLSTATE '45012'; END IF;
    SELECT role INTO v_actor_role FROM users WHERE idUser = p_actor_idUser;
    SELECT role INTO v_target_role FROM users WHERE idUser = p_target_idUser;
    IF v_actor_role = v_target_role THEN SIGNAL SQLSTATE '45014'; END IF;
    SELECT COALESCE(t.idTps, sd.idSubDistrict, d.idDistrict, c.idCity, p.idProvince, 0),
           COALESCE(CASE WHEN t.idTps IS NOT NULL THEN 'tps' END, CASE WHEN sd.idSubDistrict IS NOT NULL THEN 'sub_district' END, CASE WHEN d.idDistrict IS NOT NULL THEN 'district' END, CASE WHEN c.idCity IS NOT NULL THEN 'city' END, CASE WHEN p.idProvince IS NOT NULL THEN 'province' END, 'national')
    INTO v_target_assignmentId, v_target_level
    FROM users u
    LEFT JOIN nationalusersdetail nud ON u.idUser = nud.idUser LEFT JOIN provinceusersdetail pud ON u.idUser = pud.idUser LEFT JOIN cityusersdetail cud ON u.idUser = cud.idUser LEFT JOIN districtusersdetail dud ON u.idUser = dud.idUser LEFT JOIN subdistrictusersdetail sdud ON u.idUser = sdud.idUser LEFT JOIN admintpsuserdetail atud ON u.idUser = atud.idUser LEFT JOIN officertpsuserdetail otud ON u.idUser = otud.idUser LEFT JOIN provincedata p ON pud.idProvince = p.idProvince LEFT JOIN citydata c ON cud.idCity = c.idCity LEFT JOIN districtdata d ON dud.idDistrict = d.idDistrict LEFT JOIN subdistrictdata sd ON sdud.idSubDistrict = sd.idSubDistrict LEFT JOIN tpsdata t ON atud.idTps = t.idTps OR otud.idTps = t.idTps
    WHERE u.idUser = p_target_idUser;
    CALL sp_validateUser(p_actor_idUser, v_target_assignmentId, v_target_level);
    UPDATE users SET status = 'inactive' WHERE idUser = p_target_idUser;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_users_read_complex` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_users_read_complex`(IN p_actor_idUser INT, IN p_filter_name VARCHAR(255), IN p_filter_email VARCHAR(100), IN p_filter_role ENUM('national','province','district','sub_district','city','officerTps','adminTps'), IN p_filter_idProvince VARCHAR(13), IN p_filter_idCity VARCHAR(13), IN p_filter_idDistrict VARCHAR(13), IN p_filter_idSubDistrict VARCHAR(13))
BEGIN
    DECLARE v_actor_role VARCHAR(50);
    DECLARE v_actor_idProvince VARCHAR(13);
    DECLARE v_actor_idCity VARCHAR(13);
    DECLARE v_actor_idDistrict VARCHAR(13);
    DECLARE v_actor_idSubDistrict VARCHAR(13);
    DECLARE v_actor_idTps BIGINT;
    SELECT role, idProvince, idCity, idDistrict, idSubDistrict, idTps INTO v_actor_role, v_actor_idProvince, v_actor_idCity, v_actor_idDistrict, v_actor_idSubDistrict, v_actor_idTps FROM vw_admin_users WHERE idUser = p_actor_idUser;
    SELECT * FROM vw_admin_users
    WHERE
        (v_actor_role = 'national' OR (v_actor_role = 'province' AND vw_admin_users.idProvince = v_actor_idProvince) OR (v_actor_role = 'city' AND vw_admin_users.idCity = v_actor_idCity) OR (v_actor_role = 'district' AND vw_admin_users.idDistrict = v_actor_idDistrict) OR (v_actor_role = 'sub_district' AND vw_admin_users.idSubDistrict = v_actor_idSubDistrict) OR (v_actor_role IN ('adminTps', 'officerTps') AND vw_admin_users.idTps = v_actor_idTps))
        AND CASE
            WHEN v_actor_role = 'national' THEN TRUE
            WHEN v_actor_role = 'province' THEN vw_admin_users.role IN ('city', 'district', 'sub_district', 'adminTps', 'officerTps')
            WHEN v_actor_role = 'city' THEN vw_admin_users.role IN ('district', 'sub_district', 'adminTps', 'officerTps')
            WHEN v_actor_role = 'district' THEN vw_admin_users.role IN ('sub_district', 'adminTps', 'officerTps')
            WHEN v_actor_role = 'sub_district' THEN vw_admin_users.role IN ('adminTps', 'officerTps')
            WHEN v_actor_role = 'adminTps' THEN vw_admin_users.role = 'officerTps'
            ELSE FALSE
        END
        AND (p_filter_name IS NULL OR vw_admin_users.name LIKE CONCAT('%', p_filter_name, '%'))
        AND (p_filter_email IS NULL OR vw_admin_users.email LIKE CONCAT('%', p_filter_email, '%'))
        AND (p_filter_role IS NULL OR vw_admin_users.role = p_filter_role)
        AND (p_filter_idProvince IS NULL OR vw_admin_users.idProvince = p_filter_idProvince)
        AND (p_filter_idCity IS NULL OR vw_admin_users.idCity = p_filter_idCity)
        AND (p_filter_idDistrict IS NULL OR vw_admin_users.idDistrict = p_filter_idDistrict)
        AND (p_filter_idSubDistrict IS NULL OR vw_admin_users.idSubDistrict = p_filter_idSubDistrict);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_users_update` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_users_update`(IN p_actor_idUser INT, IN p_target_idUser INT, IN p_new_email VARCHAR(100), IN p_new_name VARCHAR(255), IN p_new_password VARCHAR(255), IN p_new_status ENUM('active', 'inactive', 'pending'))
BEGIN
    DECLARE v_actor_role VARCHAR(50);
    DECLARE v_target_role VARCHAR(50);
    DECLARE v_target_level VARCHAR(50);
    DECLARE v_target_assignmentId BIGINT;
    SELECT role INTO v_actor_role FROM users WHERE idUser = p_actor_idUser;
    SELECT role INTO v_target_role FROM users WHERE idUser = p_target_idUser;
    IF v_actor_role = v_target_role AND p_actor_idUser != p_target_idUser THEN SIGNAL SQLSTATE '45014'; END IF;
    SELECT COALESCE(t.idTps, sd.idSubDistrict, d.idDistrict, c.idCity, p.idProvince, 0),
           COALESCE(CASE WHEN t.idTps IS NOT NULL THEN 'tps' END, CASE WHEN sd.idSubDistrict IS NOT NULL THEN 'sub_district' END, CASE WHEN d.idDistrict IS NOT NULL THEN 'district' END, CASE WHEN c.idCity IS NOT NULL THEN 'city' END, CASE WHEN p.idProvince IS NOT NULL THEN 'province' END, 'national')
    INTO v_target_assignmentId, v_target_level
    FROM users u
    LEFT JOIN nationalusersdetail nud ON u.idUser = nud.idUser LEFT JOIN provinceusersdetail pud ON u.idUser = pud.idUser LEFT JOIN cityusersdetail cud ON u.idUser = cud.idUser LEFT JOIN districtusersdetail dud ON u.idUser = dud.idUser LEFT JOIN subdistrictusersdetail sdud ON u.idUser = sdud.idUser LEFT JOIN admintpsuserdetail atud ON u.idUser = atud.idUser LEFT JOIN officertpsuserdetail otud ON u.idUser = otud.idUser LEFT JOIN provincedata p ON pud.idProvince = p.idProvince LEFT JOIN citydata c ON cud.idCity = c.idCity LEFT JOIN districtdata d ON dud.idDistrict = d.idDistrict LEFT JOIN subdistrictdata sd ON sdud.idSubDistrict = sd.idSubDistrict LEFT JOIN tpsdata t ON atud.idTps = t.idTps OR otud.idTps = t.idTps
    WHERE u.idUser = p_target_idUser;
    CALL sp_validateUser(p_actor_idUser, v_target_assignmentId, v_target_level);
    UPDATE users SET email = COALESCE(p_new_email, email), name = COALESCE(p_new_name, name), password = COALESCE(SHA2(p_new_password, 256), password), status = COALESCE(p_new_status, status) WHERE idUser = p_target_idUser;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_validateUser` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_validateUser`(IN p_idUser INT, IN p_idTargetData BIGINT, IN p_targetLevel VARCHAR(50))
BEGIN
    DECLARE v_userRole VARCHAR(50);
    DECLARE v_userStatus VARCHAR(20);
    DECLARE v_authorized INT DEFAULT 0;
    SELECT role, status INTO v_userRole, v_userStatus FROM users WHERE idUser = p_idUser;
    IF v_userStatus != 'active' THEN SIGNAL SQLSTATE '45002'; END IF;
    IF v_userRole = 'national' THEN SET v_authorized = 1;
    ELSE
        IF p_targetLevel = 'province' THEN SELECT 1 INTO v_authorized FROM provinceusersdetail WHERE idUser = p_idUser AND idProvince = p_idTargetData LIMIT 1;
        ELSEIF p_targetLevel = 'city' THEN SELECT 1 INTO v_authorized FROM citydata cd WHERE cd.idCity = p_idTargetData AND ( EXISTS (SELECT 1 FROM cityusersdetail WHERE idUser = p_idUser AND idCity = cd.idCity) OR EXISTS (SELECT 1 FROM provinceusersdetail WHERE idUser = p_idUser AND idProvince = cd.idProvince) ) LIMIT 1;
        ELSEIF p_targetLevel = 'district' THEN SELECT 1 INTO v_authorized FROM districtdata d JOIN citydata c ON d.idCity = c.idCity WHERE d.idDistrict = p_idTargetData AND ( EXISTS (SELECT 1 FROM districtusersdetail WHERE idUser = p_idUser AND idDistrict = d.idDistrict) OR EXISTS (SELECT 1 FROM cityusersdetail WHERE idUser = p_idUser AND idCity = c.idCity) OR EXISTS (SELECT 1 FROM provinceusersdetail WHERE idUser = p_idUser AND idProvince = c.idProvince) ) LIMIT 1;
        ELSEIF p_targetLevel = 'sub_district' THEN SELECT 1 INTO v_authorized FROM subdistrictdata sd JOIN districtdata d ON sd.idDistrict = d.idDistrict JOIN citydata c ON d.idCity = c.idCity WHERE sd.idSubDistrict = p_idTargetData AND ( EXISTS (SELECT 1 FROM subdistrictusersdetail WHERE idUser = p_idUser AND idSubDistrict = sd.idSubDistrict) OR EXISTS (SELECT 1 FROM districtusersdetail WHERE idUser = p_idUser AND idDistrict = d.idDistrict) OR EXISTS (SELECT 1 FROM cityusersdetail WHERE idUser = p_idUser AND idCity = c.idCity) OR EXISTS (SELECT 1 FROM provinceusersdetail WHERE idUser = p_idUser AND idProvince = c.idProvince) ) LIMIT 1;
        ELSEIF p_targetLevel = 'tps' THEN SELECT 1 INTO v_authorized FROM tpsdata t JOIN subdistrictdata sd ON t.idSubDistrict = sd.idSubDistrict JOIN districtdata d ON sd.idDistrict = d.idDistrict JOIN citydata c ON d.idCity = c.idCity WHERE t.idTps = p_idTargetData AND ( EXISTS (SELECT 1 FROM officertpsuserdetail WHERE idUser = p_idUser AND idTps = t.idTps) OR EXISTS (SELECT 1 FROM admintpsuserdetail WHERE idUser = p_idUser AND idTps = t.idTps) OR EXISTS (SELECT 1 FROM subdistrictusersdetail WHERE idUser = p_idUser AND idSubDistrict = sd.idSubDistrict) OR EXISTS (SELECT 1 FROM districtusersdetail WHERE idUser = p_idUser AND idDistrict = d.idDistrict) OR EXISTS (SELECT 1 FROM cityusersdetail WHERE idUser = p_idUser AND idCity = c.idCity) OR EXISTS (SELECT 1 FROM provinceusersdetail WHERE idUser = p_idUser AND idProvince = c.idProvince) ) LIMIT 1;
        END IF;
    END IF;
    IF v_authorized = 0 THEN SIGNAL SQLSTATE '45001'; END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_voter_archive` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_voter_archive`(IN p_actor_idUser INT, IN p_idData INT)
BEGIN
    DECLARE v_actor_role VARCHAR(50);
    DECLARE v_idTps BIGINT;
    SELECT role INTO v_actor_role FROM users WHERE idUser = p_actor_idUser;
    IF v_actor_role = 'officerTps' THEN SIGNAL SQLSTATE '45034'; END IF;
    SELECT t.idTps INTO v_idTps FROM voterdata v JOIN officertpsuserdetail otud ON v.idOfficerUser = otud.idUser JOIN tpsdata t ON otud.idTps = t.idTps WHERE v.idData = p_idData;
    IF v_idTps IS NULL THEN SIGNAL SQLSTATE '45021'; END IF;
    CALL sp_validateUser(p_actor_idUser, v_idTps, 'tps');
    UPDATE voterdata SET status = 'deleted' WHERE idData = p_idData;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_voter_create` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_voter_create`(
    IN p_actor_idUser INT,
    IN p_idOfficerUser INT,
    IN p_nik VARCHAR(16),
    IN p_name VARCHAR(255),
    IN p_dateOfBirth DATE,
    IN p_gender TINYINT,
    IN p_locationPhoto VARCHAR(255)
)
BEGIN
    DECLARE v_actor_idTps BIGINT;
    DECLARE v_officer_idTps BIGINT;
    DECLARE v_existing_id INT;
    DECLARE v_existing_status ENUM('active', 'deleted');

    SELECT idTps INTO v_actor_idTps FROM admintpsuserdetail WHERE idUser = p_actor_idUser;
    IF v_actor_idTps IS NULL THEN SIGNAL SQLSTATE '45001'; END IF;

    SELECT idTps INTO v_officer_idTps FROM officertpsuserdetail WHERE idUser = p_idOfficerUser;
    IF v_officer_idTps IS NULL THEN SIGNAL SQLSTATE '45031';
    ELSEIF v_officer_idTps != v_actor_idTps THEN SIGNAL SQLSTATE '45032';
    END IF;

    SELECT idData, status INTO v_existing_id, v_existing_status FROM voterdata WHERE nik = p_nik;
    IF v_existing_id IS NOT NULL AND v_existing_status = 'active' THEN
        SIGNAL SQLSTATE '45030';
    END IF;

    BEGIN
        DECLARE EXIT HANDLER FOR SQLEXCEPTION BEGIN ROLLBACK; SIGNAL SQLSTATE '45000'; END;
        START TRANSACTION;
        IF v_existing_id IS NOT NULL THEN
            UPDATE voterdata 
            SET name = p_name, dateOfBirth = p_dateOfBirth, gender = p_gender, 
                idOfficerUser = p_idOfficerUser, locationPhoto = p_locationPhoto, status = 'active' 
            WHERE idData = v_existing_id;
        ELSE
            INSERT INTO voterdata(nik, name, dateOfBirth, gender, idOfficerUser, locationPhoto, status)
            VALUES (p_nik, p_name, p_dateOfBirth, p_gender, p_idOfficerUser, p_locationPhoto, 'active');
        END IF;
        COMMIT;
    END;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_voter_read` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_voter_read`(IN p_actor_idUser INT, IN p_filter_name VARCHAR(255), IN p_filter_nik VARCHAR(16), IN p_filter_idTps BIGINT, IN p_limit INT, IN p_offset INT)
BEGIN
    DECLARE v_actor_role VARCHAR(50);
    DECLARE v_actor_idProvince VARCHAR(13);
    DECLARE v_actor_idCity VARCHAR(13);
    DECLARE v_actor_idDistrict VARCHAR(13);
    DECLARE v_actor_idSubDistrict VARCHAR(13);
    DECLARE v_actor_idTps BIGINT;
    SELECT role, idProvince, idCity, idDistrict, idSubDistrict, idTps INTO v_actor_role, v_actor_idProvince, v_actor_idCity, v_actor_idDistrict, v_actor_idSubDistrict, v_actor_idTps FROM vw_admin_users WHERE idUser = p_actor_idUser;
    SELECT * FROM vw_voter_details
    WHERE
        ( v_actor_role = 'national' OR
          (v_actor_role = 'province' AND vw_voter_details.idProvince = v_actor_idProvince) OR
          (v_actor_role = 'city' AND vw_voter_details.idCity = v_actor_idCity) OR
          (v_actor_role = 'district' AND vw_voter_details.idDistrict = v_actor_idDistrict) OR
          (v_actor_role = 'sub_district' AND vw_voter_details.idSubDistrict = v_actor_idSubDistrict) OR
          (v_actor_role = 'adminTps' AND vw_voter_details.idTps = v_actor_idTps) OR
          (v_actor_role = 'officerTps' AND vw_voter_details.idOfficerUser = p_actor_idUser)
        )
        AND (p_filter_name IS NULL OR vw_voter_details.name LIKE CONCAT('%', p_filter_name, '%'))
        AND (p_filter_nik IS NULL OR vw_voter_details.nik LIKE CONCAT('%', p_filter_nik, '%'))
        AND (p_filter_idTps IS NULL OR vw_voter_details.idTps = p_filter_idTps)
    LIMIT p_limit OFFSET p_offset;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_voter_update` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_voter_update`(IN p_actor_idUser INT, IN p_idData INT, IN p_nik VARCHAR(16), IN p_name VARCHAR(255), IN p_dateOfBirth DATE, IN p_gender TINYINT, IN p_locationPhoto VARCHAR(255), IN p_new_status ENUM('active', 'deleted'))
BEGIN
    DECLARE v_actor_role VARCHAR(50);
    DECLARE v_voter_officer_id INT;
    DECLARE v_idTps BIGINT;
    DECLARE v_nik_exists INT DEFAULT 0;
    SELECT role INTO v_actor_role FROM users WHERE idUser = p_actor_idUser;
    IF v_actor_role = 'officerTps' THEN
        IF p_nik IS NOT NULL OR p_name IS NOT NULL OR p_dateOfBirth IS NOT NULL OR p_gender IS NOT NULL OR p_new_status IS NOT NULL THEN
            SIGNAL SQLSTATE '45033';
        ELSE
            SELECT idOfficerUser INTO v_voter_officer_id FROM voterdata WHERE idData = p_idData;
            IF p_actor_idUser != v_voter_officer_id THEN
                SIGNAL SQLSTATE '45001';
            ELSE
                UPDATE voterdata SET locationPhoto = p_locationPhoto WHERE idData = p_idData;
            END IF;
        END IF;
    ELSE
        SELECT t.idTps INTO v_idTps FROM voterdata v JOIN officertpsuserdetail otud ON v.idOfficerUser = otud.idUser JOIN tpsdata t ON otud.idTps = t.idTps WHERE v.idData = p_idData;
        IF v_idTps IS NULL THEN SIGNAL SQLSTATE '45021'; END IF;
        CALL sp_validateUser(p_actor_idUser, v_idTps, 'tps');
        IF p_nik IS NOT NULL THEN
            SELECT COUNT(*) INTO v_nik_exists FROM voterdata WHERE nik = p_nik AND idData != p_idData;
            IF v_nik_exists > 0 THEN SIGNAL SQLSTATE '45030'; END IF;
        END IF;
        UPDATE voterdata SET nik = COALESCE(p_nik, nik), name = COALESCE(p_name, name), dateOfBirth = COALESCE(p_dateOfBirth, dateOfBirth), gender = COALESCE(p_gender, gender), locationPhoto = COALESCE(p_locationPhoto, locationPhoto), status = COALESCE(p_new_status, status) WHERE idData = p_idData;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Final view structure for view `vw_admin_users`
--

/*!50001 DROP VIEW IF EXISTS `vw_admin_users`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_admin_users` AS select `u`.`idUser` AS `idUser`,`u`.`name` AS `name`,`u`.`email` AS `email`,`u`.`role` AS `role`,`u`.`status` AS `status`,(case when (`pud`.`idProvince` is not null) then `pud`.`idProvince` when (`c`.`idProvince` is not null) then `c`.`idProvince` when (`dc`.`idProvince` is not null) then `dc`.`idProvince` when (`sddc`.`idProvince` is not null) then `sddc`.`idProvince` when (`tsd_dcp`.`idProvince` is not null) then `tsd_dcp`.`idProvince` else NULL end) AS `idProvince`,(case when (`pud`.`idProvince` is not null) then `p`.`name` when (`c`.`idProvince` is not null) then `cp`.`name` when (`dc`.`idProvince` is not null) then `dcp`.`name` when (`sddc`.`idProvince` is not null) then `sddcp`.`name` when (`tsd_dcp`.`idProvince` is not null) then `tsd_dcp`.`name` else NULL end) AS `provinceName`,(case when (`cud`.`idCity` is not null) then `cud`.`idCity` when (`d`.`idCity` is not null) then `d`.`idCity` when (`sdd`.`idCity` is not null) then `sdd`.`idCity` when (`tsd_d`.`idCity` is not null) then `tsd_d`.`idCity` else NULL end) AS `idCity`,(case when (`cud`.`idCity` is not null) then `c`.`name` when (`d`.`idCity` is not null) then `dc`.`name` when (`sdd`.`idCity` is not null) then `sddc`.`name` when (`tsd_d`.`idCity` is not null) then `tsd_dc`.`name` else NULL end) AS `cityName`,(case when (`dud`.`idDistrict` is not null) then `dud`.`idDistrict` when (`sd`.`idDistrict` is not null) then `sd`.`idDistrict` when (`tsd`.`idDistrict` is not null) then `tsd`.`idDistrict` else NULL end) AS `idDistrict`,(case when (`dud`.`idDistrict` is not null) then `d`.`name` when (`sd`.`idDistrict` is not null) then `sdd`.`name` when (`tsd`.`idDistrict` is not null) then `tsd_d`.`name` else NULL end) AS `districtName`,(case when (`sdud`.`idSubDistrict` is not null) then `sdud`.`idSubDistrict` when (`t`.`idSubDistrict` is not null) then `t`.`idSubDistrict` else NULL end) AS `idSubDistrict`,(case when (`sdud`.`idSubDistrict` is not null) then `sd`.`name` when (`t`.`idSubDistrict` is not null) then `tsd`.`name` else NULL end) AS `subDistrictName`,coalesce(`atud`.`idTps`,`otud`.`idTps`) AS `idTps`,`t`.`name` AS `tpsName` from ((((((((((((((((((((((`users` `u` left join `nationalusersdetail` `nud` on((`u`.`idUser` = `nud`.`idUser`))) left join `provinceusersdetail` `pud` on((`u`.`idUser` = `pud`.`idUser`))) left join `cityusersdetail` `cud` on((`u`.`idUser` = `cud`.`idUser`))) left join `districtusersdetail` `dud` on((`u`.`idUser` = `dud`.`idUser`))) left join `subdistrictusersdetail` `sdud` on((`u`.`idUser` = `sdud`.`idUser`))) left join `admintpsuserdetail` `atud` on((`u`.`idUser` = `atud`.`idUser`))) left join `officertpsuserdetail` `otud` on((`u`.`idUser` = `otud`.`idUser`))) left join `provincedata` `p` on((`pud`.`idProvince` = `p`.`idProvince`))) left join `citydata` `c` on((`cud`.`idCity` = `c`.`idCity`))) left join `provincedata` `cp` on((`c`.`idProvince` = `cp`.`idProvince`))) left join `districtdata` `d` on((`dud`.`idDistrict` = `d`.`idDistrict`))) left join `citydata` `dc` on((`d`.`idCity` = `dc`.`idCity`))) left join `provincedata` `dcp` on((`dc`.`idProvince` = `dcp`.`idProvince`))) left join `subdistrictdata` `sd` on((`sdud`.`idSubDistrict` = `sd`.`idSubDistrict`))) left join `districtdata` `sdd` on((`sd`.`idDistrict` = `sdd`.`idDistrict`))) left join `citydata` `sddc` on((`sdd`.`idCity` = `sddc`.`idCity`))) left join `provincedata` `sddcp` on((`sddc`.`idProvince` = `sddcp`.`idProvince`))) left join `tpsdata` `t` on(((`atud`.`idTps` = `t`.`idTps`) or (`otud`.`idTps` = `t`.`idTps`)))) left join `subdistrictdata` `tsd` on((`t`.`idSubDistrict` = `tsd`.`idSubDistrict`))) left join `districtdata` `tsd_d` on((`tsd`.`idDistrict` = `tsd_d`.`idDistrict`))) left join `citydata` `tsd_dc` on((`tsd_d`.`idCity` = `tsd_dc`.`idCity`))) left join `provincedata` `tsd_dcp` on((`tsd_dc`.`idProvince` = `tsd_dcp`.`idProvince`))) where (`u`.`status` = 'active') */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_attendance_list`
--

/*!50001 DROP VIEW IF EXISTS `vw_attendance_list`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_attendance_list` AS select `v`.`idData` AS `id`,`v`.`name` AS `nama`,`v`.`nik` AS `nik`,date_format(`v`.`dateOfBirth`,'%d-%m-%Y') AS `tgl_lahir`,(case when (`v`.`gender` = 1) then 'L' when (`v`.`gender` = 2) then 'P' else 'N/A' end) AS `jk`,`v`.`tpsName` AS `tps`,`v`.`idTps` AS `id_tps`,`v`.`locationPhoto` AS `foto` from `vw_voter_details` `v` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_election_details`
--

/*!50001 DROP VIEW IF EXISTS `vw_election_details`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_election_details` AS select `e`.`idData` AS `idData`,`e`.`countTotal` AS `countTotal`,`e`.`countValid` AS `countValid`,`e`.`countInvalid` AS `countInvalid`,`e`.`countAbstain` AS `countAbstain`,`e`.`locationPhoto` AS `locationPhoto`,`e`.`status` AS `status`,`u`.`idUser` AS `adminUserId`,`u`.`name` AS `adminName`,`t`.`idTps` AS `idTps`,`t`.`name` AS `tpsName`,`sd`.`idSubDistrict` AS `idSubDistrict`,`sd`.`name` AS `subDistrictName`,`d`.`idDistrict` AS `idDistrict`,`d`.`name` AS `districtName`,`c`.`idCity` AS `idCity`,`c`.`name` AS `cityName`,`p`.`idProvince` AS `idProvince`,`p`.`name` AS `provinceName`,`p`.`latitude` AS `provinceLatitude`,`p`.`longitude` AS `provinceLongitude`,`c`.`latitude` AS `cityLatitude`,`c`.`longitude` AS `cityLongitude` from (((((((`electiondata` `e` join `admintpsuserdetail` `ad` on((`e`.`idAdmin` = `ad`.`idData`))) join `users` `u` on((`ad`.`idUser` = `u`.`idUser`))) join `tpsdata` `t` on((`ad`.`idTps` = `t`.`idTps`))) join `subdistrictdata` `sd` on((`t`.`idSubDistrict` = `sd`.`idSubDistrict`))) join `districtdata` `d` on((`sd`.`idDistrict` = `d`.`idDistrict`))) join `citydata` `c` on((`d`.`idCity` = `c`.`idCity`))) join `provincedata` `p` on((`c`.`idProvince` = `p`.`idProvince`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_report_details`
--

/*!50001 DROP VIEW IF EXISTS `vw_report_details`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_report_details` AS select `r`.`idData` AS `idReport`,`r`.`subject` AS `reportSubject`,`r`.`description` AS `reportDescription`,`r`.`status` AS `reportStatus`,`e`.`idData` AS `idElectionData`,`t`.`idTps` AS `idTps`,`t`.`name` AS `tpsName`,`sd`.`name` AS `subDistrictName`,`d`.`name` AS `districtName`,`c`.`name` AS `cityName`,`p`.`name` AS `provinceName` from (((((((`reportdata` `r` left join `electiondata` `e` on((`r`.`idElectionData` = `e`.`idData`))) left join `admintpsuserdetail` `ad` on((`e`.`idAdmin` = `ad`.`idData`))) left join `tpsdata` `t` on((`ad`.`idTps` = `t`.`idTps`))) left join `subdistrictdata` `sd` on((`t`.`idSubDistrict` = `sd`.`idSubDistrict`))) left join `districtdata` `d` on((`sd`.`idDistrict` = `d`.`idDistrict`))) left join `citydata` `c` on((`d`.`idCity` = `c`.`idCity`))) left join `provincedata` `p` on((`c`.`idProvince` = `p`.`idProvince`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_tps_details`
--

/*!50001 DROP VIEW IF EXISTS `vw_tps_details`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_tps_details` AS select `t`.`idTps` AS `idTps`,`t`.`name` AS `name`,`t`.`status` AS `status`,`sd`.`idSubDistrict` AS `idSubDistrict`,`sd`.`name` AS `subDistrictName`,`d`.`idDistrict` AS `idDistrict`,`d`.`name` AS `districtName`,`c`.`idCity` AS `idCity`,`c`.`name` AS `cityName`,`p`.`idProvince` AS `idProvince`,`p`.`name` AS `provinceName` from ((((`tpsdata` `t` join `subdistrictdata` `sd` on((`t`.`idSubDistrict` = `sd`.`idSubDistrict`))) join `districtdata` `d` on((`sd`.`idDistrict` = `d`.`idDistrict`))) join `citydata` `c` on((`d`.`idCity` = `c`.`idCity`))) join `provincedata` `p` on((`c`.`idProvince` = `p`.`idProvince`))) where (`t`.`status` = 'active') */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_voter_details`
--

/*!50001 DROP VIEW IF EXISTS `vw_voter_details`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_voter_details` AS select `v`.`idData` AS `idData`,`v`.`nik` AS `nik`,`v`.`name` AS `name`,`v`.`status` AS `status`,`v`.`dateOfBirth` AS `dateOfBirth`,`v`.`gender` AS `gender`,`v`.`locationPhoto` AS `locationPhoto`,`v`.`idOfficerUser` AS `idOfficerUser`,`u`.`name` AS `officerName`,`t`.`idTps` AS `idTps`,`t`.`name` AS `tpsName`,`sd`.`idSubDistrict` AS `idSubDistrict`,`sd`.`name` AS `subDistrictName`,`d`.`idDistrict` AS `idDistrict`,`d`.`name` AS `districtName`,`c`.`idCity` AS `idCity`,`c`.`name` AS `cityName`,`p`.`idProvince` AS `idProvince`,`p`.`name` AS `provinceName` from (((((((`voterdata` `v` join `users` `u` on((`v`.`idOfficerUser` = `u`.`idUser`))) join `officertpsuserdetail` `otud` on((`u`.`idUser` = `otud`.`idUser`))) join `tpsdata` `t` on((`otud`.`idTps` = `t`.`idTps`))) join `subdistrictdata` `sd` on((`t`.`idSubDistrict` = `sd`.`idSubDistrict`))) join `districtdata` `d` on((`sd`.`idDistrict` = `d`.`idDistrict`))) join `citydata` `c` on((`d`.`idCity` = `c`.`idCity`))) join `provincedata` `p` on((`c`.`idProvince` = `p`.`idProvince`))) where ((`v`.`status` = 'active') and (`u`.`status` = 'active') and (`t`.`status` = 'active')) */;
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

-- Dump completed on 2025-06-20 14:53:18
