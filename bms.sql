-- MySQL dump 10.13  Distrib 8.0.36, for Win64 (x86_64)
--
-- Host: localhost    Database: BMS
-- ------------------------------------------------------
-- Server version	8.0.36

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
-- Table structure for table `book`
--

DROP TABLE IF EXISTS `book`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `book` (
  `书键` int NOT NULL,
  `书表索书号` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `可借状态` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`书键`),
  KEY `fk_书表索书号` (`书表索书号`),
  CONSTRAINT `fk_书表索书号` FOREIGN KEY (`书表索书号`) REFERENCES `books` (`索书号`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `book`
--

LOCK TABLES `book` WRITE;
/*!40000 ALTER TABLE `book` DISABLE KEYS */;
INSERT INTO `book` VALUES (1,'TN91/C18',0),(2,'TN91/C18',1),(3,'TN91/C18',1),(4,'TN91/C18',1),(5,'TN91/C18',1),(6,'TN79/C60',0),(7,'TN79/C60',0),(8,'TN79/C60',0),(9,'TN79/C60',1),(10,'TN79/C60',1),(11,'TN79/C60',1),(12,'TN79/C60',1),(13,'TN79/C60',1),(14,'TN79/C60',1),(15,'TN79/C60',1),(16,'TN79/C60',1),(17,'TN79/C57',1),(18,'TN79/C57',1),(19,'TN79/C57',1),(20,'TN79/C57',1),(21,'TN79/C57',1),(22,'TN79/C57',1),(23,'TN79/C57',1),(24,'TN79/C57',1),(25,'TN79/C57',1),(26,'TN79/C57',1);
/*!40000 ALTER TABLE `book` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `books`
--

DROP TABLE IF EXISTS `books`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `books` (
  `索书号` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `书名` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `作者` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `可借阅数量` int DEFAULT NULL,
  `总数量` int DEFAULT NULL,
  PRIMARY KEY (`索书号`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `books`
--

LOCK TABLES `books` WRITE;
/*!40000 ALTER TABLE `books` DISABLE KEYS */;
INSERT INTO `books` VALUES ('A121/C21(2018)','雇佣劳动与资本','马克思',0,0),('A121/C22(2018)','德意志意识形态',' 马克思 恩格斯 ',0,0),('A123/C118(2018)','法兰西内战','马克思',0,0),('A123/C119(2018)','资本论','马克思 ',0,0),('A123/C7(2018)','1848年至1850年的法兰西阶级斗争','马克思',0,0),('A123/C9(2018)','共产党宣言',' 马克思 恩格斯',0,0),('A124/C3(2018)','自然辩证法','恩格斯 ',0,0),('A124/C4(2018)','反杜林论','恩格斯 ',0,0),('A124/C6(2018)','路德维希·费尔巴哈和德国古典哲学的终结','恩格斯 ',0,0),('A46/C11','毛泽东著作专题摘编','中共中央文献研究室编',0,0),('A81/C86(2014)','马克思主义研究资料','主编杨金海',0,0),('A811/C81(2018)','家庭、私有制和国家的起源','恩格斯 ',0,0),('C931.46/C6=5','秘书学','陈合宜著',0,0),('D23/C185','中国共产党重大事件纪实','《中国共产党重大事件纪实》编委会编 ',0,0),('D239/C65','中国共产党重大历史问题评价','中共中央党校党史教研部编',0,0),('D61/C391','有中国特色社会主义大典','王维澄主编',0,0),('F129.9/C47','国土资源调查方法','李永军主编',0,0),('F270/C1552=3','企业管理概论','尤建新主编',0,0),('F329/C21','近代中國農村問題研究資料彙編','樊秋實編',0,0),('F713.82/C11','广告经营与管理','郜明编著',0,0),('F724.6/E1=3','Introduction to the computer :',' William M. Fuori.',0,0),('G444/C57','21世纪创新学生心理健康测评新概念',' 主编徐海涛 历有为 邓大刚 ',0,0),('H369.4/C30/1','日语阅读','主编梁淑梅',0,0),('I14/C251','诺贝尔文学奖大系',' 主编李博 王槐茂 刘景峰 ',0,0),('I207.21/C30','詩韻全璧','(清) 湯祥瑟原輯 (清) 華錕重編',0,0),('I25/C875/1','权延赤文集','权延赤著',0,0),('I516.4/C68/2','铁皮鼓','(德) 君特·格拉斯著 胡其鼎译',0,0),('K20/C158=2/8','中国全史','主编白乐天 ',0,0),('K20/C159','中国通史全编',' 冯克诚 田晓娜主编 ',0,0),('K204.1/C29=2/1','毛泽东评点二十四史','毛泽东评点 周留树主编',0,0),('K204.2/C120','史記索引',' 李晓光 李波主编 ',0,0),('K260.6/C20=2/1','绝对见证',' 主编王太岳 周继强 ',0,0),('K265.06/C93/1944','亲历者说','全国政协文史和学习委员会编',0,0),('K294.1/C48','泾阳县志','泾阳县县志编纂委员会编',0,0),('K827/C1259','历史苏武',' 苏振武 王悦琴著 ',0,0),('K827/C1260/2','开国元勋','本书编委会',0,0),('K924.1/C30','咸阳大辞典','《咸阳大辞典》编篡委员会',0,0),('O212/C94','数理统计','汪荣鑫编著',0,0),('O224/C49','最优化简明教程',' 吴光鲁 赵燕燕编著 ',0,0),('P573/C4','矿物晶体化学与矿物物理学','韩照信编著',0,0),('P588.2/C26=2/1','沉积岩石学','冯增昭主编',0,0),('P588.21-64/E1','Argillaceous rock atlas /','  Neal R. O\'Brien Roger M. Slatt. ',0,0),('P588.21/E6=2','Sand and sandstone /','  F.J. Pettijohn P.E. Potter R. Siever. ',0,0),('P618.130.2/C444','中国石油大地构造','张宗命等编',0,0),('P631.4/E16','Seismic noise attenuation /',' by Ernest R. Kanasewich.',0,0),('Q81/C57','生物反应工程','(日) 山根恒夫著 邢新会译',0,0),('TB34/C76','功能材料专业教育教学实践',' 梁金生 丁燕编著 ',0,0),('TD712/C35','高温矿井风流热湿交换与热害控制','范剑辉 魏宗武编著',0,0),('TG506/C10=2','机械制造技术基础','主编宋绪丁',0,0),('TG801/C8=2','公差与技术测量','周勤芳主编',0,0),('TH137/C229','液压传动',' 宋建安 赵铁栓编著 ',0,0),('TH137/C33=3','液压与气压传动',' 王积伟主编 许映秋 陆鑫盛 温济全参编 ',0,0),('TH45/C10','离心式压缩机原理','祁大同主编',0,0),('TN79/C57','数字逻辑电路','魏达 ... [等] 编著',10,10),('TN79/C60','数字电子技术','张豫滇主编',8,11),('TN91/C18','通信导论','魏更宇 孙岩 张冬梅编著',4,5),('TN929.5/C296','移动通信技术','宋铁成，宋晓勤主编 朱彤 赵航 王春峰副主编',0,0),('TP311.138SQ/C200','数据库原理与技术','申时凯 ... [等] 主编',0,0),('TP312JA/C897','Java Web应用设计及实战',' 肖睿 喻晓路主编 ',0,0),('TP332/C206','Cortex-A8原理、实践及应用',' 姜余祥 杨萍 邹莹编著 ',0,0),('TP391.9/C36=2','MATLAB和LabVIEW仿真技术及应用实例','聂春燕 ... [等] 编著',0,0),('TP393/C785','计算机网络',' 王卫亚 孙大跃主编 李晓莉 ... [等] 编著 ',0,0),('U415.526-533/C3','2m铣刨机行走液压控制系统的研究与设计','张亚玲著 张奕指导',0,0),('X196/C97','环境与资源经济学概论','马中主编',0,0),('X4/C87','城市安全与防灾规划原理',' 刘茂 李迪编著 ',0,0),('Z126.27/C51','十三经注疏','十三经注疏',0,0);
/*!40000 ALTER TABLE `books` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `borrow`
--

DROP TABLE IF EXISTS `borrow`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `borrow` (
  `借阅记录号` int NOT NULL,
  `借阅表书键` int DEFAULT NULL,
  `借阅表卡键` int DEFAULT NULL,
  `借书时间` date DEFAULT NULL,
  `还书状态` tinyint(1) DEFAULT NULL,
  `剩余时间` int DEFAULT NULL,
  PRIMARY KEY (`借阅记录号`),
  KEY `借阅表书键` (`借阅表书键`),
  KEY `借阅表卡键` (`借阅表卡键`),
  CONSTRAINT `borrow_ibfk_1` FOREIGN KEY (`借阅表书键`) REFERENCES `book` (`书键`),
  CONSTRAINT `borrow_ibfk_2` FOREIGN KEY (`借阅表卡键`) REFERENCES `card` (`卡键`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `borrow`
--

LOCK TABLES `borrow` WRITE;
/*!40000 ALTER TABLE `borrow` DISABLE KEYS */;
INSERT INTO `borrow` VALUES (1,6,2022901024,'2024-05-29',1,-35),(2,7,2022901024,'2024-05-29',1,-35),(3,1,2022901024,'2024-05-29',1,-35),(4,2,2022901024,'2024-05-29',1,-35),(5,3,2022901024,'2024-05-29',1,-35),(6,4,2022901024,'2024-05-29',1,-34),(7,5,2022901024,'2024-05-29',1,-34),(8,6,2022901024,'2024-05-30',0,-1),(9,7,2022901024,'2024-05-30',0,-1),(10,8,2022901024,'2024-05-30',0,-1),(11,1,2022901024,'2024-05-30',0,-1);
/*!40000 ALTER TABLE `borrow` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `BeforeBorrowInsert` BEFORE INSERT ON `borrow` FOR EACH ROW BEGIN
    DECLARE available_qty INT;
    
    SELECT 可借阅数量
    INTO available_qty
    FROM books
    WHERE 索书号 = (SELECT 书表索书号 FROM book WHERE 书键 = NEW.借阅表书键);
    
    IF available_qty <= 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = '该书籍已全部借出，无法添加借阅记录。';
    ELSE
        
        UPDATE book SET 可借状态 = 0
        WHERE 书键 = NEW.借阅表书键;
        
        UPDATE books SET 可借阅数量 = 可借阅数量 - 1
        WHERE 索书号 = (SELECT 书表索书号 FROM book WHERE 书键 = NEW.借阅表书键);
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `update_return_trigger` BEFORE UPDATE ON `borrow` FOR EACH ROW BEGIN
  
  IF OLD.还书状态 = 0 AND NEW.还书状态 = 1 THEN
    
    UPDATE book SET 可借状态 = 1 WHERE 书键 = NEW.借阅表书键;
    
    UPDATE books SET 可借阅数量 = 可借阅数量 + 1 WHERE 索书号 = (SELECT 书表索书号 FROM book WHERE 书键 = NEW.借阅表书键);
    
    
    UPDATE card SET 余额 = IF(NEW.剩余时间 < 0, 余额 - ABS(NEW.剩余时间), 余额) WHERE 卡键 = NEW.借阅表卡键;
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `card`
--

DROP TABLE IF EXISTS `card`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `card` (
  `卡键` int NOT NULL,
  `姓名` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `余额` int DEFAULT NULL,
  `身份标识` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `密码` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`卡键`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `card`
--

LOCK TABLES `card` WRITE;
/*!40000 ALTER TABLE `card` DISABLE KEYS */;
INSERT INTO `card` VALUES (202291029,'张译心',0,'0','10'),(2022900007,'吴灵奇',0,'0','7'),(2022900008,'张译心',0,'0','8'),(2022901024,'陶煜贤',-19,'1','6'),(2022901025,'吴灵奇',0,'0','7'),(2022901026,'张译心',0,'0','8'),(2022902000,'Michael',0,'1','wV9HKo'),(2022902001,'Emily',1,'1','OKFihU'),(2022902002,'William',2,'0','Qd5UaA'),(2022902003,'Sophia',3,'0','UThxVA'),(2022902004,'Sophia',4,'0','q5r9Uu'),(2022902005,'William',5,'1','yBpeTQ'),(2022902006,'Jane',6,'0','dNAYPA'),(2022902007,'Jane',7,'1','2bwHMG'),(2022902008,'Emily',8,'0','LUkDOE'),(2022902009,'Emily',9,'1','r7jOAp'),(2022902010,'William',10,'1','86g5mS'),(2022902011,'Sophia',11,'0','zVU7kR'),(2022902012,'Jane',12,'0','AhqtDg'),(2022902013,'John',13,'1','bjG7qQ'),(2022902014,'William',14,'0','r2el18'),(2022902015,'Michael',15,'0','X5FeXY'),(2022902016,'Sophia',16,'1','YYjkRE'),(2022902017,'William',17,'1','qmnVwW'),(2022902018,'Sophia',18,'1','Um4r0l'),(2022902019,'John',19,'0','zQuTBo'),(2022902020,'Emily',20,'0','N906aZ'),(2022902021,'Jane',21,'1','iavaS4'),(2022902022,'Emily',22,'0','pNQcGo'),(2022902023,'wlq',23,'1','wlqnb'),(2022902024,'tyx',24,'1','tyxnb'),(2022902025,'zyx',25,'0','zyxnb'),(2022902026,'xwc',26,'0','xwcnb'),(2022902027,'John',27,'1','CIswxN'),(2022902028,'Emily',28,'0','C73Aij'),(2022902029,'Jane',29,'1','UPjZhD'),(2022902030,'William',30,'0','oeoU3k'),(2022902031,'Sophia',31,'1','Wc3Js6'),(2022902032,'Michael',32,'0','szW9eM'),(2022902033,'Sophia',33,'0','HlRJiN'),(2022902034,'John',34,'1','slY87E'),(2022902035,'Michael',35,'0','1itHo6'),(2022902036,'Emily',36,'0','VeVwdu'),(2022902037,'William',37,'1','40EQIW'),(2022902038,'Sophia',38,'1','wR4BmY'),(2022902039,'Jane',39,'1','AOh52I'),(2022902040,'Jane',40,'0','ooddQO'),(2022902041,'William',41,'1','wAaGwQ'),(2022902042,'Jane',42,'0','zDE0gR'),(2022902043,'Emily',43,'1','yHxoFe'),(2022902044,'Jane',44,'1','J4KvXl'),(2022902045,'Emily',45,'0','wJVGmP'),(2022902046,'Emily',46,'0','GkdIrF'),(2022902047,'Michael',47,'1','jF2RJX'),(2022902048,'Michael',48,'0','ddEEfG'),(2022902049,'Sophia',49,'0','FDYuCo'),(2022902050,'Sophia',50,'0','PZbYd3'),(2022902051,'John',51,'1','Dr1873'),(2022902052,'Michael',52,'1','2fzOaC'),(2022902053,'Emily',53,'1','Llc29c'),(2022902054,'Sophia',54,'1','gruXLe'),(2022902055,'Jane',55,'0','T50H3Z'),(2022902056,'Emily',56,'0','b23OKf'),(2022902057,'Emily',57,'1','fvlkvw'),(2022902058,'Emily',58,'1','w2KZgp'),(2022902059,'John',59,'0','XmoeXi'),(2022902060,'John',60,'0','qCYUdB'),(2022902061,'William',61,'1','ug7JmA'),(2022902062,'John',62,'0','FsCtw3'),(2022902063,'Michael',63,'1','Ji0XMo'),(2022902064,'Jane',64,'1','kQ6gB6'),(2022902065,'Emily',65,'1','lG3luG'),(2022902066,'John',66,'1','WKFjM6'),(2022902067,'Michael',67,'1','ITz7dl'),(2022902068,'Jane',68,'1','hBWlFg'),(2022902069,'Sophia',69,'0','gu2iaE'),(2022902070,'Emily',70,'0','XM7AAz'),(2022902071,'Emily',71,'0','bZxf3w'),(2022902072,'William',72,'0','8QP2T7'),(2022902073,'Sophia',73,'0','zgGRXu'),(2022902074,'Michael',74,'1','5dFRX1'),(2022902075,'Michael',75,'1','0rOy5F'),(2022902076,'William',76,'0','iNQK4Z'),(2022902077,'Emily',77,'0','rIvDnk'),(2022902078,'William',78,'1','XkDyOL'),(2022902079,'Sophia',79,'0','pPr2o2'),(2022902080,'Sophia',80,'0','6owomz'),(2022902081,'Michael',81,'0','W04m6I'),(2022902082,'William',82,'1','zOWhMj'),(2022902083,'William',83,'1','cGVNP2'),(2022902084,'Sophia',84,'0','XgZ49v'),(2022902085,'Sophia',85,'1','2oEFZU'),(2022902086,'Jane',86,'0','F8fsHz'),(2022902087,'Michael',87,'1','3bbmOj'),(2022902088,'John',88,'0','Fq1Djs'),(2022902089,'John',89,'1','HZVRHj'),(2022902090,'Emily',90,'0','ii35FD'),(2022902091,'Emily',91,'0','ALGCet'),(2022902092,'John',92,'1','krPAjP'),(2022902093,'Sophia',93,'0','ehLeNH'),(2022902094,'Michael',94,'1','KdkLXM'),(2022902095,'Emily',95,'0','dlBTTM'),(2022902096,'Sophia',96,'0','9dx9P8'),(2022902097,'Sophia',97,'1','0ShxfO'),(2022902098,'Sophia',98,'1','7FkgXh'),(2022902099,'Emily',99,'0','IqjqyB'),(2022902706,'谢文灿',-30,'1','1'),(2022902708,'谢顿',0,'0','1');
/*!40000 ALTER TABLE `card` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `overdue_borrow_records`
--

DROP TABLE IF EXISTS `overdue_borrow_records`;
/*!50001 DROP VIEW IF EXISTS `overdue_borrow_records`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `overdue_borrow_records` AS SELECT 
 1 AS `借阅记录号`,
 1 AS `用户账号`,
 1 AS `用户姓名`,
 1 AS `书名`,
 1 AS `借书时间`,
 1 AS `还书状态`,
 1 AS `剩余天数`*/;
SET character_set_client = @saved_cs_client;

--
-- Final view structure for view `overdue_borrow_records`
--

/*!50001 DROP VIEW IF EXISTS `overdue_borrow_records`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = gbk */;
/*!50001 SET character_set_results     = gbk */;
/*!50001 SET collation_connection      = gbk_chinese_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `overdue_borrow_records` AS select `bo`.`���ļ�¼��` AS `���ļ�¼��`,`c`.`����` AS `�û��˺�`,`c`.`����` AS `�û�����`,`bks`.`����` AS `����`,`bo`.`����ʱ��` AS `����ʱ��`,`bo`.`����״̬` AS `����״̬`,`bo`.`ʣ��ʱ��` AS `ʣ������` from ((`borrow` `bo` join `card` `c` on((`bo`.`���ı�����` = `c`.`����`))) join `books` `bks` on((`bks`.`�����` = (select `book`.`��������` from `book` where (`book`.`���` = `bo`.`���ı����`))))) where (`bo`.`ʣ��ʱ��` < 0) */;
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

-- Dump completed on 2024-06-09  9:12:25
