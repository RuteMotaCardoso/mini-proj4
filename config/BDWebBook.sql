-- MySQL dump 10.13  Distrib 8.0.20, for Win64 (x86_64)
--
-- Host: localhost:3306    Database: localConference
-- ------------------------------------------------------
-- Server version	5.7.30

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
-- Table structure for table `Users`
--

DROP TABLE IF EXISTS `Users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nome` varchar(255) DEFAULT NULL,
  `apelido` varchar(255) DEFAULT NULL,
  `username` text,
  `tipo` text,
  `email` varchar(255) DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `sobre` text,
  `last_login` datetime DEFAULT NULL,
  `status` enum('active','inactive') DEFAULT 'active',
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Users`
--

LOCK TABLES `Users` WRITE;
/*!40000 ALTER TABLE `Users` DISABLE KEYS */;
/*!40000 ALTER TABLE `Users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `conf_participant`
--

DROP TABLE IF EXISTS `conf_participant`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `conf_participant` (
  `idConference` int(11) NOT NULL DEFAULT '0',
  `idParticipant` varchar(100) NOT NULL DEFAULT '0',
  `dataRegisto` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `nomeParticipante` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idConference`,`idParticipant`),
  CONSTRAINT `conf_fkk` FOREIGN KEY (`idConference`) REFERENCES `conference` (`idConference`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `conf_participant`
--

LOCK TABLES `conf_participant` WRITE;
/*!40000 ALTER TABLE `conf_participant` DISABLE KEYS */;
INSERT INTO `conf_participant` VALUES (1,'beeleza@mail.com','2020-04-05 18:01:56','beleza'),(1,'carlos.parente@softweb.pt','2019-11-18 10:56:56','Carlos Parente'),(1,'danielafortes@bb.com','2020-04-20 21:25:46','danielalopes'),(1,'der@gmail.pt','2020-05-28 12:03:25','hel'),(1,'e@ma.il','2020-05-26 23:24:41','nome'),(1,'jd@gmail.com','2020-02-18 11:37:06','josé duarte'),(1,'joao.manuel@msbnn.com','2020-03-29 12:57:32','joaomanuel'),(1,'joaodalaia@live.pt','2020-01-11 22:13:40','joao'),(1,'joase@mail.com','2020-04-05 18:51:42','joaojoase'),(1,'pjb@gmail.com','2020-04-28 16:32:03','Paulo Belo'),(1,'ricardjose@gmail.com','2020-04-27 00:06:14','Ricardo Baptista'),(1,'rute@uab.pt','2020-05-01 09:20:09','Rute Cardoso'),(1,'teste@email.com','2020-05-26 23:52:48','teste');
/*!40000 ALTER TABLE `conf_participant` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `conf_speaker`
--

DROP TABLE IF EXISTS `conf_speaker`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `conf_speaker` (
  `idConference` int(11) NOT NULL,
  `idSpeaker` int(11) NOT NULL,
  PRIMARY KEY (`idConference`,`idSpeaker`),
  KEY `speaker_fk_idx` (`idSpeaker`),
  CONSTRAINT `speaker_conf_fk` FOREIGN KEY (`idConference`) REFERENCES `conference` (`idConference`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `speaker_fk` FOREIGN KEY (`idSpeaker`) REFERENCES `speaker` (`idSpeaker`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `conf_speaker`
--

LOCK TABLES `conf_speaker` WRITE;
/*!40000 ALTER TABLE `conf_speaker` DISABLE KEYS */;
INSERT INTO `conf_speaker` VALUES (1,2),(1,3);
/*!40000 ALTER TABLE `conf_speaker` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `conf_sponsor`
--

DROP TABLE IF EXISTS `conf_sponsor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `conf_sponsor` (
  `idConference` int(11) NOT NULL,
  `idSponsor` int(11) NOT NULL,
  PRIMARY KEY (`idConference`,`idSponsor`),
  KEY `sponsors_fk` (`idSponsor`),
  CONSTRAINT `confs_fk` FOREIGN KEY (`idConference`) REFERENCES `conference` (`idConference`),
  CONSTRAINT `sponsors_fk` FOREIGN KEY (`idSponsor`) REFERENCES `sponsor` (`idSponsor`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `conf_sponsor`
--

LOCK TABLES `conf_sponsor` WRITE;
/*!40000 ALTER TABLE `conf_sponsor` DISABLE KEYS */;
INSERT INTO `conf_sponsor` VALUES (1,1),(1,2),(1,3);
/*!40000 ALTER TABLE `conf_sponsor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `conference`
--

DROP TABLE IF EXISTS `conference`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `conference` (
  `idConference` int(11) NOT NULL AUTO_INCREMENT,
  `acronimo` varchar(45) DEFAULT NULL,
  `nome` varchar(45) DEFAULT NULL,
  `descricao` varchar(200) DEFAULT NULL,
  `local` varchar(45) DEFAULT NULL,
  `data` date DEFAULT NULL,
  `dataRegisto` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`idConference`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `conference`
--

LOCK TABLES `conference` WRITE;
/*!40000 ALTER TABLE `conference` DISABLE KEYS */;
INSERT INTO `conference` VALUES (1,'WebConference','WebConference','Conferência para a Web','Vila do Conde','2018-10-12','2018-07-27 16:26:19');
/*!40000 ALTER TABLE `conference` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `participant`
--

DROP TABLE IF EXISTS `participant`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `participant` (
  `idParticipant` int(11) NOT NULL AUTO_INCREMENT,
  `nome` varchar(45) DEFAULT NULL,
  `email` varchar(45) DEFAULT NULL,
  `dataRegisto` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`idParticipant`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `participant`
--

LOCK TABLES `participant` WRITE;
/*!40000 ALTER TABLE `participant` DISABLE KEYS */;
INSERT INTO `participant` VALUES (1,'João André Silva','joaoasilva@testemail.com',NULL),(2,NULL,NULL,NULL),(3,NULL,NULL,'2018-07-27 10:55:23'),(4,NULL,NULL,'2018-07-27 10:55:26'),(5,NULL,NULL,'2018-07-27 10:56:28'),(6,'ricardo','ricardo.queiros2@gmail.com','2018-07-27 10:57:08'),(7,'ricardo','ricardo.queiros@gmail.com','2018-07-27 10:57:59'),(8,'ricardo','ricardo.queiros@gmail.com','2018-07-27 10:58:15'),(9,NULL,'ricardo.queiros@gmail.com','2018-07-27 10:58:27'),(10,NULL,'ricardo.queiros@gmail.com','2018-07-27 10:58:29'),(11,NULL,NULL,'2018-07-27 11:00:12'),(12,NULL,NULL,'2018-07-27 11:01:09'),(13,'ricardo','ricardo.queiros@gmail.com','2018-07-27 11:01:29');
/*!40000 ALTER TABLE `participant` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `speaker`
--

DROP TABLE IF EXISTS `speaker`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `speaker` (
  `idSpeaker` int(11) NOT NULL AUTO_INCREMENT,
  `nome` varchar(45) DEFAULT NULL,
  `filiacao` varchar(45) DEFAULT NULL,
  `bio` varchar(2000) DEFAULT NULL,
  `foto` varchar(500) DEFAULT NULL,
  `link` varchar(400) DEFAULT NULL,
  `idSpeakerTipo` int(11) DEFAULT NULL,
  `active` int(11) DEFAULT NULL,
  `facebook` varchar(450) DEFAULT NULL,
  `linkedin` varchar(450) DEFAULT NULL,
  `twitter` varchar(450) DEFAULT NULL,
  `cargo` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idSpeaker`)
) ENGINE=InnoDB AUTO_INCREMENT=90 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `speaker`
--

LOCK TABLES `speaker` WRITE;
/*!40000 ALTER TABLE `speaker` DISABLE KEYS */;
INSERT INTO `speaker` VALUES (1,'rq',NULL,NULL,NULL,NULL,1,1,NULL,NULL,NULL,'xx'),(2,'Filipe Portela',NULL,'PhD em Informática e do Centro ALGORITMI. ','https://filipeportela.com/images/FilipePortela.png',NULL,2,1,'https://www.facebook.com/C.FilipePortela','https://www.linkedin.com/in/filipeportela/',NULL,'Back-end developer'),(3,'Rui Rodrigues',NULL,'Esta é a bio do Rui.\nTrabalhador e simpático!','http://eventos.esmad.ipp.pt/mad-summer/assets/img/speakers/webdev/rui_rodrigues.jpg',NULL,3,1,NULL,'https://pt.linkedin.com/in/rui-rodrigues-75a9462b',NULL,'UI/UX'),(4,'dfg',NULL,NULL,'[object HTMLInputElement]',NULL,NULL,NULL,NULL,NULL,NULL,NULL),(5,'RicardoQueiros2',NULL,NULL,'sdsd',NULL,NULL,NULL,NULL,NULL,NULL,NULL),(6,'rq',NULL,NULL,'xxx',NULL,NULL,NULL,NULL,NULL,NULL,NULL),(7,'rq',NULL,NULL,'xxx',NULL,NULL,NULL,NULL,NULL,NULL,NULL),(8,'ddd',NULL,NULL,'[object HTMLInputElement]',NULL,NULL,NULL,NULL,NULL,NULL,NULL),(9,'sdfsdf',NULL,NULL,'[object HTMLInputElement]',NULL,NULL,NULL,NULL,NULL,NULL,NULL),(10,'sdsd',NULL,NULL,'[object HTMLInputElement]',NULL,NULL,NULL,NULL,NULL,NULL,NULL),(11,'ssss',NULL,NULL,'http://xxx.pt',NULL,NULL,NULL,NULL,NULL,NULL,NULL),(12,'sdfsdf',NULL,NULL,'http://xxx.pt',NULL,NULL,NULL,NULL,NULL,NULL,NULL),(13,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(14,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(15,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(16,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(17,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(18,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(19,'rq',NULL,NULL,'xxx',NULL,NULL,NULL,NULL,NULL,NULL,NULL),(20,'afadf',NULL,NULL,'http://xxx.pt',NULL,NULL,NULL,NULL,NULL,NULL,NULL),(21,'rq',NULL,NULL,'xxx',NULL,NULL,NULL,NULL,NULL,NULL,NULL),(22,'rq',NULL,NULL,'xxx',NULL,NULL,NULL,NULL,NULL,NULL,NULL),(23,'fggdg',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(24,'fggdg',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(25,'rq',NULL,NULL,'xxx',NULL,NULL,NULL,NULL,NULL,NULL,NULL),(26,'a1',NULL,NULL,'http://xxx.pt',NULL,0,NULL,'1','3','2',NULL),(27,'a1',NULL,NULL,'http://xxx.pt',NULL,0,NULL,'1','3','2',NULL),(28,'a1',NULL,NULL,'http://xxx.pt',NULL,0,NULL,'1','3','2',NULL),(29,'sd',NULL,NULL,'http://xxx.pt',NULL,0,NULL,NULL,NULL,NULL,NULL),(30,'sdf',NULL,NULL,'http://xxx.pt',NULL,0,NULL,NULL,NULL,NULL,NULL),(31,'dsf',NULL,NULL,'http://xxx.pt',NULL,0,NULL,NULL,NULL,NULL,NULL),(32,'df',NULL,NULL,'http://xxx.pt',NULL,0,NULL,NULL,NULL,NULL,NULL),(33,'sdf',NULL,NULL,'http://xxx.pt',NULL,0,NULL,NULL,NULL,NULL,NULL),(34,'rq',NULL,NULL,'xxx',NULL,NULL,NULL,NULL,NULL,NULL,NULL),(35,'ad',NULL,NULL,'http://xxx.pt',NULL,0,NULL,NULL,NULL,NULL,NULL),(36,'ad',NULL,NULL,'http://xxx.pt',NULL,0,NULL,NULL,NULL,NULL,NULL),(37,'ad',NULL,NULL,'http://xxx.pt',NULL,0,NULL,NULL,NULL,NULL,NULL),(38,'ad',NULL,NULL,'http://xxx.pt',NULL,0,NULL,NULL,NULL,NULL,NULL),(39,'x1',NULL,NULL,'http://x3.pt',NULL,0,NULL,'x4','x6','x5',NULL),(40,'x1',NULL,NULL,'http://x3.pt',NULL,0,NULL,'x4','x6','x5',NULL),(41,'rq',NULL,NULL,'xxx',NULL,NULL,NULL,NULL,NULL,NULL,NULL),(42,'sss',NULL,NULL,'http://xxx.pt',NULL,0,NULL,NULL,NULL,NULL,NULL),(43,'ddd',NULL,NULL,'http://xxx.pt',NULL,0,NULL,NULL,NULL,NULL,NULL),(44,'xxxx',NULL,NULL,'http://xxx.pt',NULL,0,NULL,NULL,NULL,NULL,NULL),(45,'vvv',NULL,NULL,'http://xxx.pt',NULL,0,NULL,'vvv','vvv','vvvv',NULL),(46,'rrr',NULL,NULL,'http://xxx.pt',NULL,0,NULL,'f','l','t',NULL),(47,'aaa',NULL,NULL,'http://xxx.pt',NULL,NULL,NULL,NULL,NULL,NULL,'aaa'),(48,'João Mendes',NULL,NULL,'https://images.unsplash.com/photo-1529122581445-c5b6773d7cdf?ixlib=rb-0.3.5',NULL,NULL,NULL,NULL,NULL,NULL,'Front-end developer'),(49,'asd',NULL,NULL,'http://xxx.pt',NULL,NULL,NULL,'asd','asd','ads','asd'),(50,'asd',NULL,NULL,'http://xxx.pt',NULL,NULL,NULL,'asd','asd','asd','asd'),(51,'asdasd',NULL,NULL,'http://xxx.pt',NULL,NULL,NULL,'asd','asd','asd','asd'),(52,'xx',NULL,NULL,'http://xxx.pt',NULL,NULL,NULL,'xx','xx','xx','xx'),(53,'qwqw',NULL,NULL,'http://xxx.pt',NULL,NULL,NULL,'qwqw','qwqw','qwqw','qwqw'),(54,'s',NULL,NULL,'http://xxx.pt',NULL,NULL,NULL,NULL,NULL,NULL,'s'),(55,'sd',NULL,NULL,'http://xxx.pt',NULL,NULL,NULL,NULL,NULL,NULL,'sd'),(56,'sd2',NULL,NULL,'http://xxx.pt',NULL,NULL,NULL,NULL,NULL,NULL,'sd2'),(57,'grgr',NULL,NULL,'http://xxx.pt',NULL,NULL,NULL,NULL,NULL,NULL,'grgr'),(58,'xx',NULL,NULL,'http://xxx.pt',NULL,NULL,NULL,NULL,NULL,NULL,'xx'),(59,'aa',NULL,NULL,'http://xxx.pt',NULL,NULL,NULL,NULL,NULL,NULL,'aa'),(60,'aa2',NULL,NULL,'http://xxx.pt',NULL,NULL,NULL,NULL,NULL,NULL,'aa2'),(61,'zz',NULL,NULL,'http://xxx.pt',NULL,NULL,NULL,NULL,NULL,NULL,'zz'),(62,'zz2',NULL,NULL,'http://xxx.pt',NULL,NULL,NULL,NULL,NULL,NULL,'zz2'),(63,'n2',NULL,'n2','http://xxx.pt',NULL,NULL,NULL,'n2','n2','n2','n2'),(64,'Joo',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'jop'),(65,'Teste',NULL,'','',NULL,NULL,NULL,'','','','TEste'),(66,'Nome do Orador',NULL,'Biografia do Orador','',NULL,NULL,NULL,'','','','Cargo do Orador'),(67,'John Doe',NULL,'Some smart guy...','',NULL,NULL,NULL,'','','','Speaker'),(68,'test',NULL,'fdsafdsa','',NULL,NULL,NULL,'','','','test'),(69,'test',NULL,'fdsa','',NULL,NULL,NULL,'','','','test'),(70,'test',NULL,'tes','',NULL,NULL,NULL,'','','','test'),(71,'test',NULL,'tes','',NULL,NULL,NULL,'','','','tes'),(72,'fdsa',NULL,'fdsa','',NULL,NULL,NULL,'','','','fdsa'),(73,'fdsa',NULL,'fdsa','',NULL,NULL,NULL,'','','','fdsa'),(74,'fdsa',NULL,'fdsa','',NULL,NULL,NULL,'','','','fdsa'),(75,'fdsa',NULL,'fdsa','',NULL,NULL,NULL,'','','','fdsa'),(76,'fdsa',NULL,'fdsa','',NULL,NULL,NULL,'','','','fdsa'),(77,'fdsa',NULL,'fdsa','',NULL,NULL,NULL,'','','','fdsa'),(78,'fdsa',NULL,'fdsafas','',NULL,NULL,NULL,'','','','fdsa'),(79,'fdsa',NULL,'fdsa','',NULL,NULL,NULL,'','','','fdsa'),(80,'test',NULL,'fdsa','',NULL,NULL,NULL,'','','','test'),(81,'fdsa',NULL,'fdsa','',NULL,NULL,NULL,'','','','fdsa'),(82,'fdsa',NULL,'fdsa','',NULL,NULL,NULL,'','','','fdsa'),(83,'fdsa',NULL,'fdsa','',NULL,NULL,NULL,'','','','fdsa'),(84,'fdsa',NULL,'fdsa','',NULL,NULL,NULL,'','','','fdsa'),(85,'fdsa',NULL,'fdsa','',NULL,NULL,NULL,'','','','fdsa'),(86,'fdsa',NULL,'fdsa','',NULL,NULL,NULL,'','','','fdsa'),(87,'fdsa',NULL,'fdsa','',NULL,NULL,NULL,'','','','fdsa'),(88,'Nome',NULL,'Biografia','https://avatars1.githubusercontent.com/u/508118?v=3',NULL,1,NULL,'https://www.facebook.com','','','Cargo'),(89,'Nome',NULL,'Biografia parte 2','https://avatars1.githubusercontent.com/u/508118?v=3',NULL,1,NULL,'','','','Cargo');
/*!40000 ALTER TABLE `speaker` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `speaker_type`
--

DROP TABLE IF EXISTS `speaker_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `speaker_type` (
  `idSpeakerType` int(11) NOT NULL,
  `descricao` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idSpeakerType`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `speaker_type`
--

LOCK TABLES `speaker_type` WRITE;
/*!40000 ALTER TABLE `speaker_type` DISABLE KEYS */;
INSERT INTO `speaker_type` VALUES (1,'Front-End'),(2,'Back-End'),(3,'UX');
/*!40000 ALTER TABLE `speaker_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sponsor`
--

DROP TABLE IF EXISTS `sponsor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sponsor` (
  `idSponsor` int(11) NOT NULL AUTO_INCREMENT,
  `nome` varchar(45) DEFAULT NULL,
  `logo` varchar(1000) DEFAULT NULL,
  `categoria` varchar(45) DEFAULT NULL,
  `active` varchar(45) DEFAULT NULL,
  `link` varchar(450) DEFAULT NULL,
  PRIMARY KEY (`idSponsor`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sponsor`
--

LOCK TABLES `sponsor` WRITE;
/*!40000 ALTER TABLE `sponsor` DISABLE KEYS */;
INSERT INTO `sponsor` VALUES (1,'Google','http://irrationallabs.org/wp-content/uploads/2018/02/google-color2x.png','IT','1','https://google.com'),(2,'Facebook','https://webcdn-adespressoinc.netdna-ssl.com/wp-content/uploads/2018/01/facebook.png','IT','1','https://facebook.com'),(3,'P.Porto','https://www.aeiscap.com/wp-content/uploads/2013/11/Pporto-1024x226.png','EDU','1','https://ipp.pt'),(4,'IOTech','https://iotech.pt/assets/images/logo-black.png','IT','1','https://iotech.pt'),(5,'Teste','',NULL,NULL,NULL),(6,'Um Sponsor','','IT',NULL,NULL);
/*!40000 ALTER TABLE `sponsor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nome` varchar(255) DEFAULT NULL,
  `apelido` varchar(255) DEFAULT NULL,
  `username` text,
  `tipo` text,
  `email` varchar(255) DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `sobre` text,
  `last_login` datetime DEFAULT NULL,
  `status` enum('active','inactive') DEFAULT 'active',
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'admin','admin',NULL,NULL,'mail@mail.com','$2a$08$cl4/vg8XYx.ha.IlKc/WI.agpgfnGl9s657IKGaC8kziys4gQmji.',NULL,NULL,'active','2018-07-27 20:12:59','2018-07-27 20:12:59'),(3,'Vitor','Martins',NULL,NULL,'martinsvitor11@gmail.com','$2a$08$eiAwRH695h1dh9C4INN7r.9UtEI0F8CPtHotogaHSHa/c/8BnwnNK',NULL,NULL,'active','2019-01-09 21:22:29','2019-01-09 21:22:29'),(4,NULL,NULL,NULL,NULL,'martinsvitor17@gmail.com','$2a$08$J6tYg7c18VYu5WSeK7b4CeBnMVGAmhRZB6p.bHAUyyj5KLrJRcALi',NULL,NULL,'active','2019-01-12 22:36:17','2019-01-12 22:36:17'),(5,NULL,NULL,NULL,NULL,'p@e.dro','$2a$08$Q/Pi/7m7h7gXTCLOucaTC.QjsQ5lypjh3SeQo3yti.G5PYDr8JkFK',NULL,NULL,'active','2019-09-09 11:12:20','2019-09-09 11:12:20'),(6,'admins','admins',NULL,NULL,'maila@mail.com','$2a$08$f0cbNcaDwnuv/6spGJZ2se941bZjKB15NNtQY3VMA7VnmzUzMkQTS',NULL,NULL,'active','2019-11-13 16:06:57','2019-11-13 16:06:57'),(7,NULL,NULL,NULL,NULL,'yruigomes99@gmail.com','$2a$08$vjdp6/kedCwdylk8GZ6jO.ms.8mtyE0l3kk6VIYQk9M6m99DmNCni',NULL,NULL,'active','2019-12-21 14:32:17','2019-12-21 14:32:17'),(8,NULL,NULL,NULL,NULL,'yruigomes999@gmail.com','$2a$08$jPvqzWyM8t9/9FnNQ7UcCeYmpIC90X1ypxkYBNkzhyEfEb4qQFeHi',NULL,NULL,'active','2019-12-21 15:37:26','2019-12-21 15:37:26'),(9,NULL,NULL,NULL,NULL,'teste102@gmail.com','$2a$08$iWn2EfISasJLljiP5K.CQ.zaxCDMDeVHMkuuV145IObxMrPFXwO6a',NULL,NULL,'active','2019-12-24 16:43:40','2019-12-24 16:43:40'),(10,NULL,NULL,NULL,NULL,'didi@gmail.com','$2a$08$Nu.4lscV0jPniPg4W1IKRu.D1XBDMAkgVLqZoE2k28jiqN6KjS6AW',NULL,NULL,'active','2019-12-30 17:18:53','2019-12-30 17:18:53'),(11,NULL,NULL,NULL,NULL,'didi2@gmail.com','$2a$08$xPX2Q9HyhYNH5hseqQYCa.uiLp7E1Xv7oRJ7IbgnSwHqKhtmeejz.',NULL,NULL,'active','2019-12-30 17:22:45','2019-12-30 17:22:45'),(12,NULL,NULL,NULL,NULL,'adumabc@gmail.com','$2a$08$Srr5z8AvRrrB5iJeOqUsJeMjMEmng714P93MuQYUGnN68zGTPdXGm',NULL,NULL,'active','2020-01-08 13:56:41','2020-01-08 13:56:41'),(13,NULL,NULL,NULL,NULL,'ruigo@gmail.com','$2a$08$.sap8QOxws8LrGqoveO8J.r8r0oeLc7vLve09QpJGyAGx7aQwc082',NULL,NULL,'active','2020-03-13 00:13:41','2020-03-13 00:13:41'),(14,NULL,NULL,NULL,NULL,'mymail@mail.com','$2a$08$FCKQK8fVYiFuxB2.mcH/CeW935dpUJt.tsRBsXbwNVP6nsBcW9TWy',NULL,NULL,'active','2020-03-19 17:57:51','2020-03-19 17:57:51'),(15,NULL,NULL,NULL,NULL,'firstname@mail.com','$2a$08$t2CuX4h5lP0Z.qS8V4Kp7uztfURY2rewwm90scCzS/oYdJ9h/HfRG',NULL,NULL,'active','2020-04-05 18:36:14','2020-04-05 18:36:14'),(16,'Joao','Medina',NULL,NULL,'joaomedina@mail.com','$2a$08$5r8bLGIdfBPadzrhyqeigOw83AO3cBiDswfPA3lm9.NiHep5NUWmW',NULL,NULL,'active','2020-04-07 13:40:33','2020-04-07 13:40:33'),(17,NULL,NULL,NULL,NULL,'vavsmail@mail.com','$2a$08$R.gEi3mYITF3M2Oqmb6AruT97RdHHaX9EN788HOPySND/MhbzJO7O',NULL,NULL,'active','2020-04-12 21:51:27','2020-04-12 21:51:27'),(18,NULL,NULL,NULL,NULL,'fcamail@mail.com','$2a$08$LeFgB5vsEIw08XImQ8405unTBSv/KRAEkiR5LQQiN74jY5/AyIFJm',NULL,NULL,'active','2020-04-12 21:58:39','2020-04-12 21:58:39'),(19,'admin','admin',NULL,NULL,'mail2@mail.com','$2a$08$56rd/qncDmKNwVap6Ut2V.WVIRNSGr/Ige3yGGGleBwxZ/FK1g4v2',NULL,NULL,'active','2020-04-29 17:29:34','2020-04-29 17:29:34');
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

-- Dump completed on 2020-05-30  2:05:33
