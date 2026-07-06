CREATE DATABASE  IF NOT EXISTS `hairqueen_labs` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `hairqueen_labs`;
-- MySQL dump 10.13  Distrib 8.0.44, for Win64 (x86_64)
--
-- Host: localhost    Database: hairqueen_labs
-- ------------------------------------------------------
-- Server version	8.0.44

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
-- Table structure for table `categoria`
--

DROP TABLE IF EXISTS `categoria`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `categoria` (
  `id_categoria` int NOT NULL AUTO_INCREMENT,
  `nome_categoria` varchar(100) NOT NULL,
  PRIMARY KEY (`id_categoria`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categoria`
--

LOCK TABLES `categoria` WRITE;
/*!40000 ALTER TABLE `categoria` DISABLE KEYS */;
INSERT INTO `categoria` VALUES (1,'Cura dei Capelli'),(2,'Strumenti di Styling'),(3,'Bundle');
/*!40000 ALTER TABLE `categoria` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dettaglio_ordine`
--

DROP TABLE IF EXISTS `dettaglio_ordine`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dettaglio_ordine` (
  `id_ordine` int NOT NULL,
  `id_prodotto` int NOT NULL,
  `quantita_acquistata` int NOT NULL,
  `prezzo_unitario` decimal(10,2) NOT NULL,
  PRIMARY KEY (`id_ordine`,`id_prodotto`),
  KEY `dettaglio_ordine_ibfk_2` (`id_prodotto`),
  CONSTRAINT `dettaglio_ordine_ibfk_1` FOREIGN KEY (`id_ordine`) REFERENCES `ordine` (`id_ordine`) ON DELETE CASCADE,
  CONSTRAINT `dettaglio_ordine_ibfk_2` FOREIGN KEY (`id_prodotto`) REFERENCES `prodotto` (`id_prodotto`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dettaglio_ordine`
--

LOCK TABLES `dettaglio_ordine` WRITE;
/*!40000 ALTER TABLE `dettaglio_ordine` DISABLE KEYS */;
INSERT INTO `dettaglio_ordine` VALUES (1,1,1,14.99),(1,2,1,14.99),(1,3,1,19.99),(1,4,1,149.99),(2,14,1,199.99),(3,2,1,14.99),(3,3,1,19.99),(3,4,1,149.99),(3,7,1,24.99),(3,15,1,19.99),(3,16,1,99.99);
/*!40000 ALTER TABLE `dettaglio_ordine` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ordine`
--

DROP TABLE IF EXISTS `ordine`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ordine` (
  `id_ordine` int NOT NULL AUTO_INCREMENT,
  `data_ordine` datetime DEFAULT CURRENT_TIMESTAMP,
  `totale` decimal(10,2) NOT NULL,
  `stato` varchar(50) DEFAULT 'In elaborazione',
  `id_utente` int DEFAULT NULL,
  PRIMARY KEY (`id_ordine`),
  KEY `id_utente` (`id_utente`),
  CONSTRAINT `ordine_ibfk_1` FOREIGN KEY (`id_utente`) REFERENCES `utente` (`id_utente`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ordine`
--

LOCK TABLES `ordine` WRITE;
/*!40000 ALTER TABLE `ordine` DISABLE KEYS */;
INSERT INTO `ordine` VALUES (1,'2026-05-23 01:23:49',199.96,'Spedito',7),(2,'2026-05-29 19:33:55',199.99,'Consegnato',7),(3,'2026-07-06 22:58:05',329.94,'In elaborazione',8);
/*!40000 ALTER TABLE `ordine` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `prodotto`
--

DROP TABLE IF EXISTS `prodotto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `prodotto` (
  `id_prodotto` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(150) NOT NULL,
  `descrizione` text,
  `prezzo` decimal(10,2) NOT NULL,
  `quantita_magazzino` int NOT NULL,
  `immagine_url` varchar(255) DEFAULT NULL,
  `fase_utilizzo` varchar(50) DEFAULT NULL,
  `id_sottocategoria` int DEFAULT NULL,
  `tipo_cute_target` varchar(50) DEFAULT NULL,
  `tipo_capello_target` varchar(50) DEFAULT NULL,
  `is_novita` tinyint(1) DEFAULT '0',
  `is_attivo` tinyint(1) DEFAULT '1',
  `id_utente` int DEFAULT NULL,
  PRIMARY KEY (`id_prodotto`),
  KEY `id_sottocategoria` (`id_sottocategoria`),
  KEY `fk_prodotto_utente` (`id_utente`),
  CONSTRAINT `fk_prodotto_utente` FOREIGN KEY (`id_utente`) REFERENCES `utente` (`id_utente`),
  CONSTRAINT `prodotto_ibfk_1` FOREIGN KEY (`id_sottocategoria`) REFERENCES `sottocategoria` (`id_sottocategoria`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prodotto`
--

LOCK TABLES `prodotto` WRITE;
/*!40000 ALTER TABLE `prodotto` DISABLE KEYS */;
INSERT INTO `prodotto` VALUES (1,'Shampoo Idratante Lisci','Shampoo professionale con estratti di seta per detergere delicatamente e idratare in profondità i capelli più esigenti.',14.99,50,'/images/shampoo_idratante.png','Detersione',1,'Secca / Sensibile','Lisci',0,1,NULL),(2,'Shampoo Purificante Lisci','Trattamento purificante intensivo per cute grassa. Regola il sebo lasciando le lunghezze morbide, leggere e lucenti.',14.99,35,'/images/shampoo_purificante.png','Detersione',1,'Grassa','Lisci',0,1,NULL),(3,'Balsamo Purificante Lisci','Crema vellutata districante arricchita con olio di Argan. Nutre intensamente senza appesantire il capello.',19.99,40,'/images/balsamo_purificante.png','Nutrizione',2,'Grassa','Lisci',0,1,NULL),(4,'Piastra Capelli Lisci','Piastra lisciante in titanio con controllo intelligente del calore. Per un liscio perfetto in una sola passata senza danni.',149.99,15,'/images/piastra_base.png','Styling',3,'Normale','Lisci',0,1,NULL),(5,'Ferro Conico Lisci','Ferro conico professionale placcato oro 24k per onde morbide e naturali. Riscaldamento ultrarapido.',149.99,20,'/images/ferro_capelli.png','Styling',4,'Normale','Lisci',0,1,NULL),(6,'AirQueen Multistyler Lisci','Il rivoluzionario sistema di styling ad aria. Asciuga, arriccia, liscia e nasconde i baby hair senza calore estremo.',499.99,10,'/images/airstyler.png','Asciugatura e Styling',5,'Normale','Lisci',0,1,NULL),(7,'Trattamento Purificante Lisci','Trattamento intensivo di ricostruzione profonda per capelli gravemente danneggiati. Rigenera la fibra capillare donando lucentezza immediata.',24.99,25,'/images/trattamento_purificante.png','Trattamento intensivo',6,'Grassa','Lisci',0,1,NULL),(8,'Trattamento Idratante Lisci','Trattamento ',24.99,50,'/images/trattamento_idratante.png','Trattamento intensivo',6,'Secca / Sensibile','Lisci',0,1,NULL),(9,'Trattamento Riparatore Lisci','Trattamento',24.99,45,'/images/trattamento_riparatore.png','Trattamento intensivo',6,'Normale','Lisci',0,1,NULL),(10,'Shampoo Riparatore Lisci','Shampoo riparatore',14.99,132,'/images/shampoo_riparatore.png','Detersione',1,'Normale','Lisci',0,1,NULL),(11,'Balsamo Idratante Lisci','Balsamo idratante',19.99,68,'/images/balsamo_idratante.png','Nutrizione',2,'Secca / Sensibile','Lisci',0,1,NULL),(12,'Balsamo Riparatore Lisci','Balsamo riparatore',19.99,34,'/images/balsamo_riparatore.png','Nutrizione',2,'Normale','Lisci',0,1,NULL),(13,'Asciugacapelli professionale Lisci','Asciugacapelli professionale con velocità e temperatura regolabile',245.99,34,'','Styling',7,'Normale','Lisci',0,1,NULL),(14,'Bundle phon/piastra',NULL,199.99,50,'/images/promo_phon_piastra_capelli.png','Styling',9,'Tutti','Tutti',1,1,NULL),(15,'Olio per capelli Pro','Olio Pro',19.99,89,'/images/olio_pro.png','Styling',6,'Tutti','Tutti',1,1,NULL),(16,'Phon Pro','Phon per capelli',99.99,56,'/images/phon_capelli.png','Styling',7,'Tutti','Tutti',1,1,NULL),(17,'Balsamo Pro','Balsamo Pro',29.99,45,'/images/balsamo_pro.png','Nutrizione',2,'Tutti','Tutti',1,1,NULL),(22,'Prodotto Prova','Prodotto Prova da cancellare per vedere se l\'admin riesce a vederlo anche se eliminato',555.00,55,'','Styling',NULL,'Grassa','Sottile',0,0,NULL),(23,'Shampoo prova','UUU',444.00,44,'','',NULL,'','',0,0,NULL),(24,'Balsamo Prova','aaa',888.00,88,'','',NULL,'','',0,0,NULL),(25,'Siero Prova','',11.00,11,'','',NULL,'','',0,0,8);
/*!40000 ALTER TABLE `prodotto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `recensione`
--

DROP TABLE IF EXISTS `recensione`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `recensione` (
  `id_recensione` int NOT NULL AUTO_INCREMENT,
  `voto` int DEFAULT NULL,
  `testo` text,
  `data_recensione` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `id_utente` int DEFAULT NULL,
  `id_prodotto` int DEFAULT NULL,
  PRIMARY KEY (`id_recensione`),
  KEY `id_utente` (`id_utente`),
  KEY `id_prodotto` (`id_prodotto`),
  CONSTRAINT `recensione_ibfk_1` FOREIGN KEY (`id_utente`) REFERENCES `utente` (`id_utente`),
  CONSTRAINT `recensione_ibfk_2` FOREIGN KEY (`id_prodotto`) REFERENCES `prodotto` (`id_prodotto`),
  CONSTRAINT `recensione_chk_1` CHECK (((`voto` >= 1) and (`voto` <= 5)))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `recensione`
--

LOCK TABLES `recensione` WRITE;
/*!40000 ALTER TABLE `recensione` DISABLE KEYS */;
/*!40000 ALTER TABLE `recensione` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sottocategoria`
--

DROP TABLE IF EXISTS `sottocategoria`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sottocategoria` (
  `id_sottocategoria` int NOT NULL AUTO_INCREMENT,
  `nome_sottocategoria` varchar(100) NOT NULL,
  `id_categoria` int DEFAULT NULL,
  PRIMARY KEY (`id_sottocategoria`),
  KEY `id_categoria` (`id_categoria`),
  CONSTRAINT `sottocategoria_ibfk_1` FOREIGN KEY (`id_categoria`) REFERENCES `categoria` (`id_categoria`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sottocategoria`
--

LOCK TABLES `sottocategoria` WRITE;
/*!40000 ALTER TABLE `sottocategoria` DISABLE KEYS */;
INSERT INTO `sottocategoria` VALUES (1,'Shampoo',1),(2,'Balsamo',1),(3,'Piastre',2),(4,'Ferri',2),(5,'Multistyler',2),(6,'Trattamenti',1),(7,'Phon',2),(8,'Set Cura dei capelli',3),(9,'Set Styling',3);
/*!40000 ALTER TABLE `sottocategoria` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `utente`
--

DROP TABLE IF EXISTS `utente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `utente` (
  `id_utente` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(50) NOT NULL,
  `cognome` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `indirizzo` varchar(255) DEFAULT NULL,
  `ruolo` enum('CLIENTE','ADMIN') DEFAULT 'CLIENTE',
  `telefono` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id_utente`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `utente`
--

LOCK TABLES `utente` WRITE;
/*!40000 ALTER TABLE `utente` DISABLE KEYS */;
INSERT INTO `utente` VALUES (1,'Laura','Bianchi','laura@test.com','pass123',NULL,'CLIENTE',NULL),(2,'Laura','Bianchi','laura.bianchi@email.it','passwordSicura123','Via dello Shopping 5, Milano','CLIENTE',NULL),(3,'Mario','Rossi','mariorossi@gmail.com','ASdfgh78?','Via Roma, 89','CLIENTE',NULL),(4,'Maria','Cioffi','mariacioffi@gmail.com','Qwerty76.','Via Napoli, 76','CLIENTE','3456767677'),(5,'Paolo','De Santis','paolo.desantis@gmail.com','5d55b4d61a38eb270b68eaec538a98662953f0c7f09ddcdf291ce4273d620d6a','Via Napoli, 45','CLIENTE','3449891234'),(6,'Luca','Izzo','luca.izzo@gmail.com','b4c444008ed6099bec3ec4ff41cbbfd57682f09efab111f0c35321c15467a657','Via Roma, 98','CLIENTE','0348765918'),(7,'Giampaolo','Giampi','gampgiampi@gmail.com','b4c444008ed6099bec3ec4ff41cbbfd57682f09efab111f0c35321c15467a657','Via Napoli, 88','ADMIN','2345678900'),(8,'Emma','Bove','emmabove@gmail.com','9f1759f36957eb13e0fbba99615f34f57fe5f4999d12f857ce756eaa14bac8c5','Via Cristoforo Colombo, 55','ADMIN','3219876543'),(9,'Lillo','Greg','lillogreg@gmail.com','756ae9ca714b68d35df669a57e0f42d20d42d0f37819cf32d3c009e87b30470d','Via Napoli, 99','CLIENTE','1239874654'),(10,'Michael','Jackson','michaeljackson@gmail.com','fbbb48c76c52a5855e8e4fea904d4067079c7790050480440eeed96e8bfff6bb','Via Roma, 26','CLIENTE','7775551234'),(11,'Freddie','Mercury','freddiemercury@gmail.com','167255cc77cb30ccf5bbf433e7f5ac4d4387a6e476af76aa3e8e95851802f2b4','Via Rhapsody, 75','CLIENTE','7689123000'),(12,'Alan','Leone','alanleone@gmail.com','0babd2140d8478cdfbbeaf41b6814300c1a5190ad2119ddbec76f9c838db0c4a','Via Leone, 77','CLIENTE','8765000000'),(13,'Gigi','D\'Alessio','gigi@gmail.com','cd30bd27c380a34ef19995fa84bff18aebb9fa4b3b49a2e5cf774ae0cb5168d0','Via Napoli, 101','CLIENTE','4567112222');
/*!40000 ALTER TABLE `utente` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-07-07  1:10:55
