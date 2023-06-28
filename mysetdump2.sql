-- MySQL dump 10.13  Distrib 8.0.32, for Linux (x86_64)
--
-- Host: localhost    Database: myset
-- ------------------------------------------------------
-- Server version	8.0.32-0ubuntu0.22.04.2

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
-- Current Database: `myset`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `myset` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE `myset`;

--
-- Table structure for table `address`
--

DROP TABLE IF EXISTS `address`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `address` (
  `event_id` int DEFAULT NULL,
  `street_no` int DEFAULT NULL,
  `street_name` varchar(100) DEFAULT NULL,
  `city` varchar(100) DEFAULT NULL,
  `state_abbrev` varchar(10) DEFAULT NULL,
  `postcode` varchar(10) DEFAULT NULL,
  `country` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `address`
--

LOCK TABLES `address` WRITE;
/*!40000 ALTER TABLE `address` DISABLE KEYS */;
/*!40000 ALTER TABLE `address` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `club_contact_details`
--

DROP TABLE IF EXISTS `club_contact_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `club_contact_details` (
  `club_id` int DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `facebook_id` varchar(100) DEFAULT NULL,
  `instagram_id` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `club_contact_details`
--

LOCK TABLES `club_contact_details` WRITE;
/*!40000 ALTER TABLE `club_contact_details` DISABLE KEYS */;
/*!40000 ALTER TABLE `club_contact_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `club_managers`
--

DROP TABLE IF EXISTS `club_managers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `club_managers` (
  `manager_id` int NOT NULL AUTO_INCREMENT,
  `club_id` int DEFAULT NULL,
  `user_id` int DEFAULT NULL,
  PRIMARY KEY (`manager_id`),
  KEY `club_id` (`club_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `club_managers_ibfk_1` FOREIGN KEY (`club_id`) REFERENCES `clubs` (`club_id`),
  CONSTRAINT `club_managers_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `club_managers`
--

LOCK TABLES `club_managers` WRITE;
/*!40000 ALTER TABLE `club_managers` DISABLE KEYS */;
/*!40000 ALTER TABLE `club_managers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `clubs`
--

DROP TABLE IF EXISTS `clubs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `clubs` (
  `club_id` int NOT NULL AUTO_INCREMENT,
  `club_name` varchar(100) DEFAULT NULL,
  `club_description` text,
  PRIMARY KEY (`club_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clubs`
--

LOCK TABLES `clubs` WRITE;
/*!40000 ALTER TABLE `clubs` DISABLE KEYS */;
INSERT INTO `clubs` VALUES (1,'WISTEMS','The Women in STEM Society (WISTEMS) aims to create a supportive, fun and inclusive social network for women and other minorities in STEM.'),(2,'CS CLUB','The Computer Science Club of the University of Adelaide!'),(3,'QCC','Adelaide University Quantum Computing Club-The only Club for Quantum Computing in SA!'),(4,'AI & ML','AI & ML Students Club of the University of Adelaide-for Artificial Intelligence and Machine Learning students!'),(5,'ABSS','Adelaide Business Students Society-The biggest Club for Business students'),(6,'AFS','Adelaide Fashion Collective-space for the fashion freaks'),(7,'MSA','Adelaide Health and Medical Sciences Association-AHMS Building'),(8,'Comedy Club','Adelaide University Comedy Club-Expect some fun here!'),(9,'Eco Club','Adelaide University Economics Club-A must join for Economics students'),(10,'Finance Society','Adelaide University Finance Society for the students studying Economics and Finance!');
/*!40000 ALTER TABLE `clubs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `clubs_users`
--

DROP TABLE IF EXISTS `clubs_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `clubs_users` (
  `club_id` int NOT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`club_id`,`user_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `clubs_users_ibfk_1` FOREIGN KEY (`club_id`) REFERENCES `clubs` (`club_id`),
  CONSTRAINT `clubs_users_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clubs_users`
--

LOCK TABLES `clubs_users` WRITE;
/*!40000 ALTER TABLE `clubs_users` DISABLE KEYS */;
/*!40000 ALTER TABLE `clubs_users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `email_notifications`
--

DROP TABLE IF EXISTS `email_notifications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `email_notifications` (
  `user_id` int DEFAULT NULL,
  `content_type` varchar(20) DEFAULT NULL,
  `sent_from` varchar(20) DEFAULT NULL,
  KEY `user_id` (`user_id`),
  CONSTRAINT `email_notifications_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `email_notifications`
--

LOCK TABLES `email_notifications` WRITE;
/*!40000 ALTER TABLE `email_notifications` DISABLE KEYS */;
/*!40000 ALTER TABLE `email_notifications` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `events`
--

DROP TABLE IF EXISTS `events`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `events` (
  `event_id` int NOT NULL AUTO_INCREMENT,
  `event_name` varchar(100) DEFAULT NULL,
  `club_id` int DEFAULT NULL,
  `event_datetime` datetime DEFAULT NULL,
  `cost` decimal(10,2) DEFAULT NULL,
  `contact_email` varchar(100) DEFAULT NULL,
  `event_description` text,
  `expiry` datetime DEFAULT NULL,
  PRIMARY KEY (`event_id`),
  KEY `club_id` (`club_id`),
  CONSTRAINT `events_ibfk_1` FOREIGN KEY (`club_id`) REFERENCES `clubs` (`club_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `events`
--

LOCK TABLES `events` WRITE;
/*!40000 ALTER TABLE `events` DISABLE KEYS */;
INSERT INTO `events` VALUES (4,'WISTEMS Quiz Night',1,'2023-06-16 18:00:00',20.00,'contact@wistems.com','Once upon a time 📖, on the mystical land of IW B18 ✨💫 WISTEMS host their magical🧙‍♀️Quiz Night on Friday 19th May, and they humbly 😇 request the honour of your presence🧚‍♂. You and your esteemed entourage👬👭are invited to participate in a night of enchanting games 👸🫅, mystic rounds of questions🔮, and the opportunity to dress💃🧝 in your most exceptional fairytale outfits. Meals and drinks 🍕🍾🍻(both alcoholic and non) will be provided under purchase of your ticket 💰🎫. Ticket are $20 per person, and sales open 9:00AM Wednesday 26th April. So set your reminders 🕰 to ensure you do not miss out!','2023-06-15 00:00:00'),(5,'QUANTUM WORKSHOP',3,'2023-06-15 00:00:00',5.00,'qcc@adel.com','Quantum Computing Workshop. Here, you will learn about the basics of Quantum Computing and how to use Qiskit','2024-06-15 00:00:00'),(6,'NIGHT GAMES',2,'2023-06-15 00:00:00',0.00,'csclub@adel.com','Need to blow off some steam from a long week of studying? Wanna hang out with like-minded students? Want to be the final boss on Super Smash Bro\'s? or would just like some free food every now and then?Come down to the Duck Lounge (EM110) in the Engineering and Mathematics Building for some games!NOTE: Free food will be provided on the last Friday of every month.','2023-08-15 00:00:00'),(7,'Meet and Greet!',2,'2023-06-25 00:00:00',0.00,'csclub@adel.com','Come hang out and meet the Computer Science Club\'s committee and members in your first week of the semester! FREE Food and drinks!!!','2023-06-25 00:00:00'),(8,'Git + GitHub + Gradescope Workshop',2,'2023-06-29 00:00:00',0.00,'csclub@adel.com','CS Club presents Git Gud with Git, Github and Gradescope 🔥\nNow that the university is moving to Git, Github and Gradescope we would like to invite all our peers, first years or otherwise to this in-person and online workshop.\nWe will be covering the basics of Git and Github, what they are and how to use Gradescope alongside these tools during your courses. We will also go through how Gradescope works when using the Code50 IDE.\nWe will not be covering SVN during the session as first year courses are now using Github and second years and up should already be familiar with SVN.\nHope to see you all there so we can Git Gud together!','2023-06-29 00:00:00');
/*!40000 ALTER TABLE `events` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `linked_account`
--

DROP TABLE IF EXISTS `linked_account`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `linked_account` (
  `user_id` int DEFAULT NULL,
  `linked_account_id` int DEFAULT NULL,
  `linked_account_password` varchar(100) DEFAULT NULL,
  KEY `user_id` (`user_id`),
  CONSTRAINT `linked_account_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `linked_account`
--

LOCK TABLES `linked_account` WRITE;
/*!40000 ALTER TABLE `linked_account` DISABLE KEYS */;
/*!40000 ALTER TABLE `linked_account` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rsvp`
--

DROP TABLE IF EXISTS `rsvp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rsvp` (
  `event_id` int NOT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`event_id`,`user_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `rsvp_ibfk_1` FOREIGN KEY (`event_id`) REFERENCES `events` (`event_id`),
  CONSTRAINT `rsvp_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rsvp`
--

LOCK TABLES `rsvp` WRITE;
/*!40000 ALTER TABLE `rsvp` DISABLE KEYS */;
/*!40000 ALTER TABLE `rsvp` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `updates`
--

DROP TABLE IF EXISTS `updates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `updates` (
  `update_id` int NOT NULL AUTO_INCREMENT,
  `message_subject` varchar(100) DEFAULT NULL,
  `message_body` text,
  `update_type` varchar(10) DEFAULT NULL,
  `recipients_type` varchar(10) DEFAULT NULL,
  `club_id` int DEFAULT NULL,
  `expiry` datetime DEFAULT NULL,
  PRIMARY KEY (`update_id`),
  KEY `club_id` (`club_id`),
  CONSTRAINT `updates_ibfk_1` FOREIGN KEY (`club_id`) REFERENCES `clubs` (`club_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `updates`
--

LOCK TABLES `updates` WRITE;
/*!40000 ALTER TABLE `updates` DISABLE KEYS */;
/*!40000 ALTER TABLE `updates` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `user_id` int NOT NULL AUTO_INCREMENT,
  `user_type` varchar(15) DEFAULT NULL,
  `given_name` varchar(100) DEFAULT NULL,
  `last_name` varchar(100) DEFAULT NULL,
  `username` varchar(50) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `password_hash` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (3,'user',NULL,NULL,'pragya','example@gmail.com','$argon2id$v=19$m=65536,t=3,p=4$1nHEfSq5vRsU464AZnPgJA$3brYYDj4GiQAPuXFSSb0FJ0UPO8g/L3bLha9xjdlq+Q'),(4,'user',NULL,NULL,'victor','example2@gmail.com','$argon2id$v=19$m=65536,t=3,p=4$Db03W4l82bysjz5nDjxOwA$vnoXHqeEetZce3ST/MoYqbCOXdz1acdcatpRy2ybnL4'),(5,'user',NULL,NULL,'simran','example3@gmail.com','$argon2id$v=19$m=65536,t=3,p=4$VPKRnYL917W+OgCGXvoXcQ$SM8Vf2Mp758TmuOy1D4v88+taC2HYtpWhayMgFA1MZ0'),(7,'user',NULL,NULL,'alice','example4@gmail.com','$argon2id$v=19$m=65536,t=3,p=4$odvOhjsYhQXW9OeVxeRfSA$F/TJUgkvr9lyjLDbmsJIYriNLhfTwLSQJfq//0cxJcU'),(8,'user',NULL,NULL,'bob','example5@gmail.com','$argon2id$v=19$m=65536,t=3,p=4$sbAYJzYpv+o9SHWu6F7dZg$fNDBxyqMv4oQ+/MQUtDdtnP+3+AsL1vs5v0FlFHrnAY'),(10,'user','Pragya','Kaushik','prags','iampragyakaushik@gmail.com','$argon2id$v=19$m=65536,t=3,p=4$IDU0OJyFbMPrTmGTfVAYDw$+YsJpoeTu+fo2mVSwotnRgVNVujeKywTro5tkRAfu8g'),(11,'user','Charlie','Brown','charlie','example6@gmail.com','$argon2id$v=19$m=65536,t=3,p=4$NleGm+aBhAvZMKZIl4sSZg$300i1EUyDb+Jq3ZSxnXW4tPw7h/02dWijKB2rXbEtTE'),(12,'user','David','Miller','david','example7@gmail.com','$argon2id$v=19$m=65536,t=3,p=4$laB564Uhq1tQkAKG2l7ImA$2amqlwCVUsrTa+PC6K8g9mSyjCZEGVQgoqcOd6Byqag'),(13,'user','kieron','pollard','kieron','example8@gmal.com','$argon2id$v=19$m=65536,t=3,p=4$Icgdc55ESVBeWnPBr3fvdQ$e86/Xyi3RhGqa6/osAjfP/p/sj3//Br8BMiWnkqHCCU'),(14,'admin','Virat','Kohli','virat','example9@gmal.com','$argon2id$v=19$m=65536,t=3,p=4$a6ISfmMyK0cGhdBBLy2E4g$1h6I7/arV1yUbmIthDJe84xY2mkHUBFggzY48U97Ynw'),(15,'club-manager','Will','Smith','willy','meaghan.rath40@ethereal.email','$argon2id$v=19$m=65536,t=3,p=4$xyGTvcQUrlsmF97LWnaqRA$KL0ZqeUch+jljNNDRxlxX0LSilW+bDetqTRw8KpvFZg'),(16,'user','new','user','newuser','new@gmail.com','$argon2id$v=19$m=65536,t=3,p=4$s3HidXW34eeY8XfInZKO0g$g3dbvUXXgTI66BZERfeEDPrqrxY8WMUqz8k8YEHdyZU'),(19,'user','Pragya','Kaushik','pragya123','example40@gmail.com','$argon2id$v=19$m=65536,t=3,p=4$SoLT3JZEY9I1GegyQDCOoQ$gRC2yZVmxEGjOXUi68bUyMhbulxuB0C2LEMpjPfNrDA'),(23,'user','Pragya','Kaushik','pragyaaa','thisispragyakaushik@gmail.com','$argon2id$v=19$m=65536,t=3,p=4$L16hN90eHmMalHgFGmHuCg$+3+LmVmkzdTbI3yOK4YZarz5jvD8G8knrDBb2VMNeMs');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-06-11 14:20:19
