-- MySQL dump 10.13  Distrib 8.0.20, for Win64 (x86_64)
--
-- Host: localhost    Database: traindb
-- ------------------------------------------------------
-- Server version	8.0.20

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
-- Table structure for table `board`
--

DROP TABLE IF EXISTS `board`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `board` (
  `num` int NOT NULL AUTO_INCREMENT,
  `subject` varchar(100) NOT NULL,
  `content` text NOT NULL,
  `regist_day` varchar(30) DEFAULT NULL,
  `hit` int DEFAULT NULL,
  `ip` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`num`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `board`
--

LOCK TABLES `board` WRITE;
/*!40000 ALTER TABLE `board` DISABLE KEYS */;
INSERT INTO `board` VALUES (1,' 첫 번째 공지사항입니다.',' 첫 번째 공지사항입니다.\r\n첫 내용입니다.','2022. 06. 30.',1,'0:0:0:0:0:0:0:1'),(2,' 두 번째 공지사항입니다.','두 번째 공지사항입니다.\r\n두 번째 내용입니다.','2022. 06. 30.',3,'0:0:0:0:0:0:0:1'),(3,' 세 번째 공지사항입니다.','세 번째 공지사항입니다.\r\n세 번째 내용입니다.','2022. 06. 30.',2,'0:0:0:0:0:0:0:1'),(4,'네 번째 공지사항입니다.',' 네 번째 공지사항입니다.\r\n네 번째 내용입니다.','2022. 06. 30.',1,'0:0:0:0:0:0:0:1'),(5,'다섯 번째 공지사항입니다.',' 다섯 번째 공지사항입니다.\r\n다섯 번째 내용입니다.','2022. 06. 30.',0,'0:0:0:0:0:0:0:1'),(6,'여섯 번째 공지사항입니다.',' 여섯 번째 공지사항입니다.\r\n여섯 번째 내용입니다.','2022. 06. 30.',2,'0:0:0:0:0:0:0:1'),(11,'일곱 번째 공지사항입니다.',' 일곱 번째 공지사항입니다.\r\n일곱 번째 내용입니다.','2022. 06. 30.',1,'0:0:0:0:0:0:0:1');
/*!40000 ALTER TABLE `board` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gntickets`
--

DROP TABLE IF EXISTS `gntickets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `gntickets` (
  `num` int NOT NULL AUTO_INCREMENT,
  `id` varchar(20) NOT NULL,
  `train_kind` varchar(10) NOT NULL,
  `train_no` varchar(10) NOT NULL,
  `depSt` varchar(10) NOT NULL,
  `depTime` varchar(20) NOT NULL,
  `arrvSt` varchar(10) NOT NULL,
  `arrvTime` varchar(20) NOT NULL,
  `date` varchar(20) NOT NULL,
  `adult` int NOT NULL,
  `child` int NOT NULL,
  PRIMARY KEY (`num`),
  KEY `id_idx` (`id`),
  CONSTRAINT `id` FOREIGN KEY (`id`) REFERENCES `member` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gntickets`
--

LOCK TABLES `gntickets` WRITE;
/*!40000 ALTER TABLE `gntickets` DISABLE KEYS */;
INSERT INTO `gntickets` VALUES (7,'guest','ITX-새마을','1001','서울','06 : 20','대구','09 : 43','2022. 07. 05',1,0);
/*!40000 ALTER TABLE `gntickets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `member`
--

DROP TABLE IF EXISTS `member`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `member` (
  `id` varchar(20) NOT NULL,
  `name` varchar(20) NOT NULL,
  `rrn` varchar(14) NOT NULL,
  `pw` varchar(12) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `member`
--

LOCK TABLES `member` WRITE;
/*!40000 ALTER TABLE `member` DISABLE KEYS */;
INSERT INTO `member` VALUES ('admin','administrator','123123-123123','123123'),('guest','guest','123123-1234567','guest123'),('user','user','123123-1231234','123123');
/*!40000 ALTER TABLE `member` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rgtickets`
--

DROP TABLE IF EXISTS `rgtickets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rgtickets` (
  `num` int NOT NULL AUTO_INCREMENT,
  `user_id` varchar(20) NOT NULL,
  `train_kind` varchar(10) NOT NULL,
  `depSt` varchar(10) NOT NULL,
  `arrvSt` varchar(10) NOT NULL,
  `fdate` varchar(20) NOT NULL,
  `ldate` varchar(20) NOT NULL,
  PRIMARY KEY (`num`),
  KEY `id_idx` (`user_id`),
  CONSTRAINT `user_id` FOREIGN KEY (`user_id`) REFERENCES `member` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rgtickets`
--

LOCK TABLES `rgtickets` WRITE;
/*!40000 ALTER TABLE `rgtickets` DISABLE KEYS */;
INSERT INTO `rgtickets` VALUES (2,'admin','KTX','서울','대구','2022. 07. 12','2022. 08. 11'),(3,'user','KTX','서울','대구','2022. 07. 11','2022. 08. 10');
/*!40000 ALTER TABLE `rgtickets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stations`
--

DROP TABLE IF EXISTS `stations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `stations` (
  `name` varchar(10) NOT NULL,
  `code` varchar(20) NOT NULL,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stations`
--

LOCK TABLES `stations` WRITE;
/*!40000 ALTER TABLE `stations` DISABLE KEYS */;
INSERT INTO `stations` VALUES ('가남','NAT280090'),('가평','NAT140576'),('각계','NAT012054'),('감곡장호원','NAT280212'),('강경','NAT030607'),('강구','NAT8B0671'),('강릉','NAT601936'),('강촌','NAT140701'),('개포','NAT300733'),('검암','NATC10325'),('경산','NAT013395'),('계룡','NAT030254'),('고한','NAT650828'),('곡성','NAT041072'),('공주','NATH20438'),('관촌','NAT040496'),('광명','NATH10219'),('광양','NAT881708'),('광운대','NAT130182'),('광주','NAT883012'),('광주송정','NAT031857'),('광천','NAT080749'),('구례구','NAT041285'),('구미','NAT012775'),('구포','NAT014281'),('군북','NAT880608'),('군산','NAT081388'),('극락강','NAT883086'),('기장','NAT750329'),('김유정','NAT140787'),('김제','NAT031056'),('김천','NAT012546'),('김천구미','NATH12383'),('나전','NAT610326'),('나주','NAT031998'),('남성현','NAT013542'),('남원','NAT040868'),('남창','NAT750560'),('남춘천','NAT140840'),('남평','NAT882847'),('노량진','NAT010058'),('논산','NAT030508'),('능곡','NAT110165'),('능주','NAT882666'),('다시','NAT032099'),('단양','NAT021784'),('대광리','NAT130844'),('대구','NAT013239'),('대성리','NAT140362'),('대야','NAT320131'),('대전','NAT011668'),('대천','NAT080952'),('덕소','NAT020178'),('덕하','NAT750653'),('도계','NAT601122'),('도고온천','NAT080309'),('도담','NAT021723'),('도라산','NAT110557'),('동대구','NAT013271'),('동두천','NAT130531'),('동래','NAT750106'),('동백산','NAT651053'),('동산','NAT040173'),('동점','NAT600830'),('동탄','NATH30326'),('동해','NAT601485'),('동화','NAT020986'),('둔내','NATN10428'),('득량','NAT882237'),('마산','NAT880345'),('마석','NAT140277'),('만종','NAT021033'),('망상','NAT601605'),('망상해변','NAT601602'),('매곡','NAT020803'),('명봉','NAT882416'),('목포','NAT032563'),('목행','NAT050881'),('몽탄','NAT032313'),('무안','NAT032273'),('묵호','NAT601545'),('문산','NAT110460'),('물금','NAT014150'),('민둥산','NAT650722'),('밀양','NAT013841'),('반곡','NAT021175'),('반성','NAT880766'),('백마고지','NAT130944'),('백양리','NAT140681'),('백양사','NAT031486'),('벌교','NAT882034'),('별어곡','NAT610064'),('보성','NAT882328'),('봉성','NAT600257'),('봉양','NAT021478'),('봉화','NAT600147'),('부강','NAT011403'),('부발','NAT250428'),('부산','NAT014445'),('부전','NAT750046'),('부조','NAT751354'),('부천','NAT060121'),('북영천','NAT023424'),('북울산','NAT750781'),('북천','NAT881269'),('분천','NAT600593'),('비동','NAT600635'),('사곡','NAT012821'),('사릉','NAT140133'),('사방','NAT751238'),('사북','NAT650782'),('사상','NAT014331'),('삼랑진','NAT013967'),('삼례','NAT040133'),('삼산','NAT020884'),('삼척해변','NAT630078'),('삼탄','NAT051006'),('삽교','NAT080492'),('상동','NAT013747'),('상봉','NAT020040'),('상주','NAT300360'),('서경주','NAT023821'),('서광주','NAT882936'),('서대구','NAT013189'),('서대전','NAT030057'),('서빙고','NAT130036'),('서울','NAT010000'),('서원주','NAT020864'),('서정리','NAT010670'),('서천','NAT081343'),('석불','NAT020717'),('석포','NAT600768'),('선평','NAT610137'),('성환','NAT010848'),('센텀','NAT750161'),('소요산','NAT130556'),('소정리','NAT011079'),('송정','NAT750254'),('수서','NATH30000'),('수원','NAT010415'),('순천','NAT041595'),('승부','NAT600692'),('신경주','NATH13421'),('신기','NAT601275'),('신나원','NAT8B0082'),('신녕','NAT023279'),('신도림','NAT010106'),('신동','NAT013067'),('신례원','NAT080353'),('신리','NAT040352'),('신림','NAT021357'),('신망리','NAT130774'),('신안강','NAT8B0190'),('신웅천','NAT081099'),('신창','NAT080216'),('신창원','NAT810048'),('신탄리','NAT130888'),('신탄진','NAT011524'),('신태인','NAT031179'),('신해운대','NAT750189'),('심천','NAT012016'),('쌍룡','NAT650177'),('아산','NAT080045'),('아신','NAT020471'),('아우라지','NAT610387'),('아포','NAT012700'),('아화','NAT023601'),('안강','NAT751296'),('안동','NAT022558'),('안양','NAT010239'),('앙성온천','NAT280358'),('약목','NAT012903'),('양동','NAT020845'),('양보','NAT881323'),('양원','NAT600655'),('양자동','NAT751325'),('양평','NAT020524'),('여수EXPO','NAT041993'),('여천','NAT041866'),('연당','NAT650253'),('연무대','NAT340090'),('연산','NAT030396'),('연천','NAT130738'),('영덕','NAT8B0737'),('영동','NAT012124'),('영등포','NAT010091'),('영월','NAT650341'),('영주','NAT022188'),('영천','NAT023449'),('예당','NAT882194'),('예미','NAT650515'),('예산','NAT080402'),('예천','NAT300850'),('오근장','NAT050215'),('오산','NAT010570'),('오송','NAT050044'),('오수','NAT040667'),('옥곡','NAT881584'),('옥산','NAT300200'),('옥수','NAT130070'),('옥천','NAT011833'),('온양온천','NAT080147'),('완사','NAT881168'),('왕십리','NAT130104'),('왜관','NAT012968'),('용궁','NAT300669'),('용동','NAT030667'),('용문','NAT020641'),('용산','NAT010032'),('운천','NAT110497'),('울산(통도사)','NATH13717'),('원동','NAT014058'),('원북','NAT880644'),('원주','NAT020947'),('월포','NAT8B0504'),('율촌','NAT041710'),('음성','NAT050596'),('의성','NAT022844'),('의정부','NAT130312'),('이양','NAT882544'),('이원','NAT011916'),('익산','NAT030879'),('인천공항T1','NATC10580'),('인천공항T2','NATC30058'),('일로','NAT032422'),('일산','NAT110249'),('일신','NAT020760'),('임기','NAT600476'),('임성리','NAT032489'),('임실','NAT040536'),('임진강','NAT110520'),('입실','NAT750933'),('장락','NAT650050'),('장사','NAT8B0595'),('장성','NAT031638'),('장항','NAT081318'),('전곡','NAT130652'),('전의','NAT011154'),('전주','NAT040257'),('점촌','NAT300600'),('정동진','NAT601774'),('정선','NAT610226'),('정읍','NAT031314'),('제천','NAT021549'),('조성','NAT882141'),('조치원','NAT011298'),('좌천','NAT750412'),('주덕','NAT050719'),('주안','NAT060231'),('중리','NAT880408'),('증평','NAT050366'),('지제','NATH30536'),('지탄','NAT011972'),('지평','NAT020677'),('진례','NAT880179'),('진부','NATN10787'),('진상','NAT881538'),('진성','NAT880825'),('진영','NAT880177'),('진주','NAT881014'),('진해','NAT810195'),('창원','NAT880310'),('창원중앙','NAT880281'),('천안','NAT010971'),('천안아산','NATH10960'),('철암','NAT600870'),('청도','NAT013629'),('청량리','NAT130126'),('청리','NAT300271'),('청소','NAT080827'),('청주','NAT050114'),('청주공항','NAT050244'),('청평','NAT140436'),('초성리','NAT130597'),('추암','NAT630064'),('추전','NAT650918'),('추풍령','NAT012355'),('춘양','NAT600379'),('춘천','NAT140873'),('충주','NAT050827'),('탄현','NAT110265'),('탑리','NAT022961'),('태백','NAT650978'),('태화강','NAT750726'),('퇴계원','NAT140098'),('파주','NAT110407'),('판교','NAT081240'),('평내호평','NAT140214'),('평창','NATN10625'),('평촌','NAT880702'),('평택','NAT010754'),('포항','NAT8B0351'),('풍기','NAT022053'),('하동','NAT881460'),('하양','NAT830200'),('한림정','NAT880099'),('한탄강','NAT130627'),('함백','NAT650567'),('함안','NAT880520'),('함열','NAT030718'),('함창','NAT300558'),('함평','NAT032212'),('행신','NAT110147'),('현동','NAT600527'),('홍성','NAT080622'),('화명','NAT014244'),('화본','NAT023127'),('화순','NAT882755'),('황간','NAT012270'),('횡성','NATN10230'),('횡천','NAT881386'),('효문','NAT750760'),('효자','NAT751418'),('효천','NAT882904'),('흑석리','NAT030173');
/*!40000 ALTER TABLE `stations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'traindb'
--

--
-- Dumping routines for database 'traindb'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-07-12 10:49:44
