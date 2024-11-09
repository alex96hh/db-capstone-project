-- MySQL dump 10.13  Distrib 8.0.40, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: littlelemondb
-- ------------------------------------------------------
-- Server version	8.0.40

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
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders` (
  `OrderID` int NOT NULL AUTO_INCREMENT,
  `TableNo` int NOT NULL,
  `Date` date NOT NULL,
  `Quantity` int NOT NULL,
  `BillAmount` decimal(6,2) NOT NULL,
  `MenuID` int NOT NULL,
  `CustomerID` int NOT NULL,
  `BookingID` int NOT NULL,
  PRIMARY KEY (`OrderID`,`TableNo`),
  KEY `Menu_FK_idx` (`MenuID`),
  KEY `Booking_FK_idx` (`BookingID`),
  KEY `Customer_O_FK_idx` (`CustomerID`),
  CONSTRAINT `Booking_FK` FOREIGN KEY (`BookingID`) REFERENCES `bookings` (`BookingID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `Customer_O_FK` FOREIGN KEY (`CustomerID`) REFERENCES `customer` (`CustomerID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `Menu_FK` FOREIGN KEY (`MenuID`) REFERENCES `menu` (`MenuID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` VALUES (1,5,'2024-11-01',2,15.99,1,1,1),(2,2,'2024-11-02',3,9.99,2,2,2),(3,3,'2024-11-03',1,8.49,3,3,3),(4,4,'2024-11-04',4,45.00,4,4,4),(5,1,'2024-11-05',5,12.50,5,5,5),(6,6,'2024-11-06',1,150.99,6,6,6),(7,7,'2024-11-07',2,29.99,7,7,7),(8,8,'2024-11-08',3,18.99,8,8,8),(9,9,'2024-11-09',1,55.75,9,9,9),(10,10,'2024-11-10',4,89.99,10,10,10),(11,11,'2024-11-11',2,19.99,1,1,1),(12,12,'2024-11-12',3,75.49,2,2,2),(13,13,'2024-11-13',2,23.99,3,3,3),(14,14,'2024-11-14',4,199.99,4,4,4),(15,15,'2024-11-15',4,47.25,1,5,5),(16,16,'2024-11-16',1,35.75,6,6,6),(17,17,'2024-11-17',5,28.50,3,7,7),(18,18,'2024-11-18',3,60.00,7,8,8),(19,19,'2024-11-19',4,120.00,3,9,9),(20,20,'2024-11-20',3,92.99,2,10,10);
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-11-09 10:52:45
