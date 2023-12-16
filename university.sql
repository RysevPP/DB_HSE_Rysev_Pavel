CREATE DATABASE  IF NOT EXISTS `university` /*!40100 DEFAULT CHARACTER SET utf8mb3 */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `university`;
-- MySQL dump 10.13  Distrib 8.0.34, for Win64 (x86_64)
--
-- Host: localhost    Database: university
-- ------------------------------------------------------
-- Server version	8.0.34

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `assessment`
--

DROP TABLE IF EXISTS `assessment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `assessment` (
  `idassessment` int NOT NULL AUTO_INCREMENT,
  `assessment` int DEFAULT NULL,
  `offset` varchar(20) DEFAULT NULL,
  `date` date NOT NULL,
  `idstud` int DEFAULT NULL,
  `idteacher` int DEFAULT NULL,
  `idsubject` int DEFAULT NULL,
  PRIMARY KEY (`idassessment`),
  UNIQUE KEY `idassessment_UNIQUE` (`idassessment`),
  KEY `idstudent_idx` (`idstud`),
  KEY `idteacher_idx` (`idteacher`),
  KEY `idsubject_idx` (`idsubject`),
  CONSTRAINT `FK_assessment_student` FOREIGN KEY (`idstud`) REFERENCES `student` (`idstud`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `FK_assessment_subject` FOREIGN KEY (`idsubject`) REFERENCES `subject` (`idsubject`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `FK_assessment_teacher` FOREIGN KEY (`idteacher`) REFERENCES `teacher` (`idteacher`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `assessment_chk_1` CHECK ((`assessment` between 0 and 6))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 KEY_BLOCK_SIZE=1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `assessment`
--

LOCK TABLES `assessment` WRITE;
/*!40000 ALTER TABLE `assessment` DISABLE KEYS */;
/*!40000 ALTER TABLE `assessment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `department`
--

DROP TABLE IF EXISTS `department`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `department` (
  `iddep` int NOT NULL AUTO_INCREMENT,
  `fullname` varchar(200) NOT NULL,
  `shortname` varchar(45) NOT NULL,
  `idheaddep` int DEFAULT NULL,
  `office` int NOT NULL,
  `tel` varchar(20) DEFAULT NULL,
  `email` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`iddep`),
  UNIQUE KEY `iddepartment_UNIQUE` (`iddep`),
  UNIQUE KEY `fullname_UNIQUE` (`fullname`),
  UNIQUE KEY `shortname_UNIQUE` (`shortname`),
  KEY `FK_department_teacher_idx` (`idheaddep`),
  CONSTRAINT `FK_department_teacher` FOREIGN KEY (`idheaddep`) REFERENCES `teacher` (`idteacher`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `department`
--

LOCK TABLES `department` WRITE;
/*!40000 ALTER TABLE `department` DISABLE KEYS */;
/*!40000 ALTER TABLE `department` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `faculty`
--

DROP TABLE IF EXISTS `faculty`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `faculty` (
  `idfaculty` int NOT NULL AUTO_INCREMENT,
  `fullname` varchar(200) NOT NULL,
  `shortname` varchar(45) NOT NULL,
  `iddeanfaculty` int DEFAULT NULL,
  `office` int NOT NULL,
  `tel` varchar(20) DEFAULT NULL,
  `email` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idfaculty`),
  UNIQUE KEY `idfaculty_UNIQUE` (`idfaculty`),
  UNIQUE KEY `fullname_UNIQUE` (`fullname`),
  UNIQUE KEY `shortname_UNIQUE` (`shortname`),
  KEY `FK_faculty_teacher_idx` (`iddeanfaculty`),
  CONSTRAINT `FK_faculty_teacher` FOREIGN KEY (`iddeanfaculty`) REFERENCES `teacher` (`idteacher`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `faculty`
--

LOCK TABLES `faculty` WRITE;
/*!40000 ALTER TABLE `faculty` DISABLE KEYS */;
/*!40000 ALTER TABLE `faculty` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `group`
--

DROP TABLE IF EXISTS `group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `group` (
  `idgroup` int NOT NULL AUTO_INCREMENT,
  `number` varchar(45) NOT NULL,
  `yearadmission` date NOT NULL,
  `idelder` int DEFAULT NULL,
  `direction` varchar(45) NOT NULL,
  `specialization` varchar(100) NOT NULL,
  PRIMARY KEY (`idgroup`),
  UNIQUE KEY `idgroup_UNIQUE` (`idgroup`),
  UNIQUE KEY `name_UNIQUE` (`number`),
  KEY `FK_group_student` (`idelder`),
  CONSTRAINT `FK_group_student` FOREIGN KEY (`idelder`) REFERENCES `student` (`idstud`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `group`
--

LOCK TABLES `group` WRITE;
/*!40000 ALTER TABLE `group` DISABLE KEYS */;
/*!40000 ALTER TABLE `group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `student`
--

DROP TABLE IF EXISTS `student`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `student` (
  `idstud` int NOT NULL,
  `name` varchar(64) NOT NULL,
  `surname` varchar(64) NOT NULL,
  `patronymic` varchar(64) DEFAULT NULL,
  `birthday` date NOT NULL,
  `tel` varchar(20) DEFAULT NULL,
  `email` varchar(45) DEFAULT NULL,
  `idgroup` int DEFAULT NULL,
  `idfaculty` int DEFAULT NULL,
  `zip` int NOT NULL,
  `region` varchar(45) NOT NULL,
  `district` varchar(45) DEFAULT NULL,
  `city` varchar(45) NOT NULL,
  `street_house` varchar(100) NOT NULL,
  PRIMARY KEY (`idstud`),
  UNIQUE KEY `idstudent_UNIQUE` (`idstud`),
  UNIQUE KEY `studindex` (`name`,`surname`,`birthday`),
  KEY `idgroup_idx` (`idgroup`),
  KEY `idfaculty_idx` (`idfaculty`),
  CONSTRAINT `FK_student_faculty` FOREIGN KEY (`idfaculty`) REFERENCES `faculty` (`idfaculty`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `FK_student_group` FOREIGN KEY (`idgroup`) REFERENCES `group` (`idgroup`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student`
--

LOCK TABLES `student` WRITE;
/*!40000 ALTER TABLE `student` DISABLE KEYS */;
/*!40000 ALTER TABLE `student` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `subject`
--

DROP TABLE IF EXISTS `subject`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `subject` (
  `idsubject` int NOT NULL AUTO_INCREMENT,
  `name` varchar(120) NOT NULL,
  `category` varchar(64) NOT NULL,
  `idteacher` int DEFAULT NULL,
  PRIMARY KEY (`idsubject`),
  UNIQUE KEY `idsubject_UNIQUE` (`idsubject`),
  KEY `idteacher_idx` (`idteacher`),
  CONSTRAINT `FK_subject_teacher` FOREIGN KEY (`idteacher`) REFERENCES `teacher` (`idteacher`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `subject`
--

LOCK TABLES `subject` WRITE;
/*!40000 ALTER TABLE `subject` DISABLE KEYS */;
/*!40000 ALTER TABLE `subject` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `teacher`
--

DROP TABLE IF EXISTS `teacher`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `teacher` (
  `idteacher` int NOT NULL,
  `name` varchar(64) NOT NULL,
  `surname` varchar(64) NOT NULL,
  `patronymic` varchar(64) DEFAULT NULL,
  `birthday` date NOT NULL,
  `tel` varchar(20) DEFAULT NULL,
  `email` varchar(45) DEFAULT NULL,
  `iddep` int DEFAULT NULL,
  `office` int DEFAULT NULL,
  `zip` int NOT NULL,
  `region` varchar(45) NOT NULL,
  `district` varchar(45) DEFAULT NULL,
  `city` varchar(45) NOT NULL,
  `street_house` varchar(100) NOT NULL,
  PRIMARY KEY (`idteacher`),
  UNIQUE KEY `idteacher_UNIQUE` (`idteacher`),
  UNIQUE KEY `teachindex` (`name`,`surname`,`birthday`),
  KEY `iddepartment_idx` (`iddep`),
  CONSTRAINT `FK_teacher_department` FOREIGN KEY (`iddep`) REFERENCES `department` (`iddep`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `teacher`
--

LOCK TABLES `teacher` WRITE;
/*!40000 ALTER TABLE `teacher` DISABLE KEYS */;
/*!40000 ALTER TABLE `teacher` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'university'
--

--
-- Dumping routines for database 'university'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-12-16 21:55:37
