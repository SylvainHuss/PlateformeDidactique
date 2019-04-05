-- MySQL dump 10.13  Distrib 8.0.15, for Linux (x86_64)
--
-- Host: localhost    Database: bd
-- ------------------------------------------------------
-- Server version	8.0.15

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
 SET NAMES utf8mb4 ;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `chapitre`
--

DROP TABLE IF EXISTS `chapitre`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `chapitre` (
  `id` int(11) NOT NULL,
  `nom` varchar(255) DEFAULT NULL,
  `indice` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `chapitre`
--

LOCK TABLES `chapitre` WRITE;
/*!40000 ALTER TABLE `chapitre` DISABLE KEYS */;
INSERT INTO `chapitre` VALUES (1,'test','test');
/*!40000 ALTER TABLE `chapitre` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `exercice`
--

DROP TABLE IF EXISTS `exercice`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `exercice` (
  `id` int(11) NOT NULL,
  `titre` varchar(255) DEFAULT NULL,
  `id_chap` int(11) DEFAULT NULL,
  `consigne` varchar(255) DEFAULT NULL,
  `corrige` varchar(255) DEFAULT NULL,
  `parametres` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id_chap` (`id_chap`),
  CONSTRAINT `exercice_ibfk_1` FOREIGN KEY (`id_chap`) REFERENCES `chapitre` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `exercice`
--

LOCK TABLES `exercice` WRITE;
/*!40000 ALTER TABLE `exercice` DISABLE KEYS */;
INSERT INTO `exercice` VALUES (1,'test',1,'test','test','2');
/*!40000 ALTER TABLE `exercice` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jeutest`
--

DROP TABLE IF EXISTS `jeutest`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `jeutest` (
  `id` int(11) NOT NULL,
  `id_ex` int(11) DEFAULT NULL,
  `entree` varchar(255) DEFAULT NULL,
  `sortie` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id_ex` (`id_ex`),
  CONSTRAINT `jeutest_ibfk_1` FOREIGN KEY (`id_ex`) REFERENCES `exercice` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jeutest`
--

LOCK TABLES `jeutest` WRITE;
/*!40000 ALTER TABLE `jeutest` DISABLE KEYS */;
INSERT INTO `jeutest` VALUES (1,1,'1','1'),(2,1,'2','4');
/*!40000 ALTER TABLE `jeutest` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `realise`
--

DROP TABLE IF EXISTS `realise`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `realise` (
  `id_ex` int(11) NOT NULL,
  `id_eleve` int(11) NOT NULL,
  `temps_debut` time DEFAULT NULL,
  `temps_valide` time DEFAULT NULL,
  `nb_essai` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_ex`,`id_eleve`),
  KEY `id_eleve` (`id_eleve`),
  CONSTRAINT `realise_ibfk_1` FOREIGN KEY (`id_ex`) REFERENCES `exercice` (`id`),
  CONSTRAINT `realise_ibfk_2` FOREIGN KEY (`id_eleve`) REFERENCES `utilisateur` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `realise`
--

LOCK TABLES `realise` WRITE;
/*!40000 ALTER TABLE `realise` DISABLE KEYS */;
INSERT INTO `realise` VALUES (1,1,'09:46:05','09:49:59',3),(1,2,'11:41:57','11:41:57',1);
/*!40000 ALTER TABLE `realise` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `utilisateur`
--

DROP TABLE IF EXISTS `utilisateur`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `utilisateur` (
  `id` int(11) NOT NULL,
  `nom` varchar(255) DEFAULT NULL,
  `mdp` varchar(255) DEFAULT NULL,
  `type` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `utilisateur`
--

LOCK TABLES `utilisateur` WRITE;
/*!40000 ALTER TABLE `utilisateur` DISABLE KEYS */;
INSERT INTO `utilisateur` VALUES (1,'test','mdp',0),(2,'test','mdp',0);
/*!40000 ALTER TABLE `utilisateur` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-04-05 22:16:38
