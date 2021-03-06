-- MySQL dump 10.13  Distrib 5.5.37, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: xibo
-- ------------------------------------------------------
-- Server version	5.5.37-0ubuntu0.14.04.1

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
-- Table structure for table `bandwidth`
--

DROP TABLE IF EXISTS `bandwidth`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bandwidth` (
  `DisplayID` int(11) NOT NULL,
  `Type` tinyint(4) NOT NULL,
  `Month` int(11) NOT NULL,
  `Size` bigint(20) NOT NULL,
  PRIMARY KEY (`DisplayID`,`Type`,`Month`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bandwidth`
--

LOCK TABLES `bandwidth` WRITE;
/*!40000 ALTER TABLE `bandwidth` DISABLE KEYS */;
INSERT INTO `bandwidth` VALUES (1,1,1398898800,3544),(1,2,1398898800,164167),(1,3,1398898800,20837),(1,4,1398898800,1002332);
/*!40000 ALTER TABLE `bandwidth` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `blacklist`
--

DROP TABLE IF EXISTS `blacklist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `blacklist` (
  `BlackListID` int(11) NOT NULL AUTO_INCREMENT,
  `MediaID` int(11) NOT NULL,
  `DisplayID` int(11) NOT NULL,
  `UserID` int(11) DEFAULT NULL COMMENT 'Null if it came from a display',
  `ReportingDisplayID` int(11) DEFAULT NULL COMMENT 'The display that reported the blacklist',
  `Reason` text NOT NULL,
  `isIgnored` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'Ignore this blacklist',
  PRIMARY KEY (`BlackListID`),
  KEY `MediaID` (`MediaID`),
  KEY `DisplayID` (`DisplayID`),
  CONSTRAINT `blacklist_ibfk_1` FOREIGN KEY (`MediaID`) REFERENCES `media` (`mediaID`),
  CONSTRAINT `blacklist_ibfk_2` FOREIGN KEY (`DisplayID`) REFERENCES `display` (`displayid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Blacklisted media will not get sent to the Display';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `blacklist`
--

LOCK TABLES `blacklist` WRITE;
/*!40000 ALTER TABLE `blacklist` DISABLE KEYS */;
/*!40000 ALTER TABLE `blacklist` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `campaign`
--

DROP TABLE IF EXISTS `campaign`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `campaign` (
  `CampaignID` int(11) NOT NULL AUTO_INCREMENT,
  `Campaign` varchar(254) NOT NULL,
  `IsLayoutSpecific` tinyint(4) NOT NULL,
  `UserID` int(11) NOT NULL,
  PRIMARY KEY (`CampaignID`),
  KEY `UserID` (`UserID`),
  CONSTRAINT `campaign_ibfk_1` FOREIGN KEY (`UserID`) REFERENCES `user` (`UserID`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `campaign`
--

LOCK TABLES `campaign` WRITE;
/*!40000 ALTER TABLE `campaign` DISABLE KEYS */;
INSERT INTO `campaign` VALUES (1,'Default Layout',1,1);
/*!40000 ALTER TABLE `campaign` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dataset`
--

DROP TABLE IF EXISTS `dataset`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dataset` (
  `DataSetID` int(11) NOT NULL AUTO_INCREMENT,
  `DataSet` varchar(50) NOT NULL,
  `Description` varchar(254) DEFAULT NULL,
  `UserID` int(11) NOT NULL,
  PRIMARY KEY (`DataSetID`),
  KEY `UserID` (`UserID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dataset`
--

LOCK TABLES `dataset` WRITE;
/*!40000 ALTER TABLE `dataset` DISABLE KEYS */;
/*!40000 ALTER TABLE `dataset` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `datasetcolumn`
--

DROP TABLE IF EXISTS `datasetcolumn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `datasetcolumn` (
  `DataSetColumnID` int(11) NOT NULL AUTO_INCREMENT,
  `DataSetID` int(11) NOT NULL,
  `Heading` varchar(50) NOT NULL,
  `DataTypeID` smallint(6) NOT NULL,
  `DataSetColumnTypeID` smallint(6) NOT NULL,
  `ListContent` varchar(255) DEFAULT NULL,
  `ColumnOrder` smallint(6) NOT NULL,
  `Formula` varchar(1000) DEFAULT NULL,
  PRIMARY KEY (`DataSetColumnID`),
  KEY `DataSetID` (`DataSetID`),
  CONSTRAINT `datasetcolumn_ibfk_1` FOREIGN KEY (`DataSetID`) REFERENCES `dataset` (`DataSetID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `datasetcolumn`
--

LOCK TABLES `datasetcolumn` WRITE;
/*!40000 ALTER TABLE `datasetcolumn` DISABLE KEYS */;
/*!40000 ALTER TABLE `datasetcolumn` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `datasetcolumntype`
--

DROP TABLE IF EXISTS `datasetcolumntype`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `datasetcolumntype` (
  `DataSetColumnTypeID` smallint(6) NOT NULL,
  `DataSetColumnType` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `datasetcolumntype`
--

LOCK TABLES `datasetcolumntype` WRITE;
/*!40000 ALTER TABLE `datasetcolumntype` DISABLE KEYS */;
INSERT INTO `datasetcolumntype` VALUES (1,'Value'),(2,'Formula');
/*!40000 ALTER TABLE `datasetcolumntype` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `datasetdata`
--

DROP TABLE IF EXISTS `datasetdata`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `datasetdata` (
  `DataSetDataID` int(11) NOT NULL AUTO_INCREMENT,
  `DataSetColumnID` int(11) NOT NULL,
  `RowNumber` int(11) NOT NULL,
  `Value` varchar(255) NOT NULL,
  PRIMARY KEY (`DataSetDataID`),
  KEY `DataColumnID` (`DataSetColumnID`),
  CONSTRAINT `datasetdata_ibfk_1` FOREIGN KEY (`DataSetColumnID`) REFERENCES `datasetcolumn` (`DataSetColumnID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `datasetdata`
--

LOCK TABLES `datasetdata` WRITE;
/*!40000 ALTER TABLE `datasetdata` DISABLE KEYS */;
/*!40000 ALTER TABLE `datasetdata` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `datatype`
--

DROP TABLE IF EXISTS `datatype`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `datatype` (
  `DataTypeID` smallint(6) NOT NULL,
  `DataType` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `datatype`
--

LOCK TABLES `datatype` WRITE;
/*!40000 ALTER TABLE `datatype` DISABLE KEYS */;
INSERT INTO `datatype` VALUES (1,'String'),(2,'Number'),(3,'Date');
/*!40000 ALTER TABLE `datatype` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `display`
--

DROP TABLE IF EXISTS `display`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `display` (
  `displayid` int(8) NOT NULL AUTO_INCREMENT,
  `isAuditing` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'Is this display auditing',
  `display` varchar(50) NOT NULL,
  `defaultlayoutid` int(8) NOT NULL,
  `license` varchar(40) DEFAULT NULL,
  `licensed` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'Is the Requested License Key Allowed',
  `loggedin` tinyint(4) NOT NULL DEFAULT '0',
  `lastaccessed` int(11) DEFAULT NULL,
  `inc_schedule` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'Will this default be used in the scheduling calcs',
  `email_alert` tinyint(1) NOT NULL DEFAULT '1',
  `alert_timeout` int(11) NOT NULL DEFAULT '0',
  `ClientAddress` varchar(100) DEFAULT NULL,
  `MediaInventoryStatus` tinyint(4) NOT NULL DEFAULT '0',
  `MediaInventoryXml` longtext,
  `MacAddress` varchar(254) DEFAULT NULL COMMENT 'Mac Address of the Client',
  `LastChanged` int(11) DEFAULT NULL COMMENT 'Last time this Mac Address changed',
  `NumberOfMacAddressChanges` int(11) NOT NULL DEFAULT '0',
  `LastWakeOnLanCommandSent` int(11) DEFAULT NULL,
  `WakeOnLan` tinyint(4) NOT NULL DEFAULT '0',
  `WakeOnLanTime` varchar(5) DEFAULT NULL,
  `BroadCastAddress` varchar(100) DEFAULT NULL,
  `SecureOn` varchar(17) DEFAULT NULL,
  `Cidr` smallint(6) DEFAULT NULL,
  `GeoLocation` point DEFAULT NULL,
  `version_instructions` varchar(255) DEFAULT NULL,
  `client_type` varchar(20) DEFAULT NULL,
  `client_version` varchar(5) DEFAULT NULL,
  `client_code` smallint(6) DEFAULT NULL,
  PRIMARY KEY (`displayid`),
  KEY `defaultplaylistid` (`defaultlayoutid`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `display`
--

LOCK TABLES `display` WRITE;
/*!40000 ALTER TABLE `display` DISABLE KEYS */;
INSERT INTO `display` VALUES (1,0,'raspberrypi',4,'b084aa7f524fc359d14fef50bbc6667fff6cb3d8',1,1,1400856418,0,0,0,'172.30.254.252',1,'<?xml version=\"1.0\" ?>\n<files macAddress=\"b8:27:eb:ca:31:3e\">\n	<file complete=\"1\" id=\"10\" lastChecked=\"2014-05-23 16:41:41\" md5=\"f75a0638c88502bfd4f4306bb668b670\" type=\"media\"/>\n	<file complete=\"1\" id=\"11\" lastChecked=\"2014-05-23 16:41:41\" md5=\"3f1da9cae5dfad77691441c17c242e34\" type=\"media\"/>\n	<file complete=\"1\" id=\"4\" lastChecked=\"2014-05-23 16:41:41\" md5=\"848ffdb82cbce2fa2edc6d5d879d5367\" type=\"media\"/>\n	<file complete=\"1\" id=\"3\" lastChecked=\"2014-05-23 16:41:42\" md5=\"030f39447116a18cded931935362dc00\" type=\"media\"/>\n	<file complete=\"1\" id=\"0\" lastChecked=\"2014-05-23 16:41:42\" md5=\"4b14f66e4933019dbe96fd0ad3f965ba\" type=\"media\"/>\n	<file complete=\"1\" id=\"4\" lastChecked=\"2014-05-23 16:41:53\" md5=\"299d52f80b3deaa676ccdf5cee60e566\" type=\"layout\"/>\n	<file complete=\"1\" id=\"0\" lastChecked=\"2014-05-23 16:41:42\" md5=\"89685dbff67cc25863d0ca99e8686bb8\" type=\"media\"/>\n	<file complete=\"1\" id=\"6\" lastChecked=\"2014-05-23 16:41:42\" md5=\"13234d8ca6fb2ce947510e6a8f040348\" type=\"media\"/>\n	<file complete=\"1\" id=\"7\" lastChecked=\"2014-05-23 16:41:42\" md5=\"9c745f91be0eb1201098d508d8341858\" type=\"media\"/>\n	<file complete=\"1\" id=\"1\" lastChecked=\"2014-05-23 16:41:42\" md5=\"4ad3b1f2572a3323dda3a88f97c1f35f\" type=\"media\"/>\n	<file complete=\"1\" id=\"5\" lastChecked=\"2014-05-23 16:41:42\" md5=\"7c89d07101fe148fb35bc86e0620e510\" type=\"media\"/>\n</files>\n','b8:27:eb:ca:31:3e',1400600375,1,NULL,0,'','','',0,'\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0',NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `display` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `displaygroup`
--

DROP TABLE IF EXISTS `displaygroup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `displaygroup` (
  `DisplayGroupID` int(11) NOT NULL AUTO_INCREMENT,
  `DisplayGroup` varchar(50) NOT NULL,
  `Description` varchar(254) DEFAULT NULL,
  `IsDisplaySpecific` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`DisplayGroupID`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `displaygroup`
--

LOCK TABLES `displaygroup` WRITE;
/*!40000 ALTER TABLE `displaygroup` DISABLE KEYS */;
INSERT INTO `displaygroup` VALUES (1,'raspberrypi','',1);
/*!40000 ALTER TABLE `displaygroup` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `file`
--

DROP TABLE IF EXISTS `file`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `file` (
  `FileID` int(11) NOT NULL AUTO_INCREMENT,
  `CreatedDT` int(11) NOT NULL,
  `UserID` int(11) NOT NULL,
  PRIMARY KEY (`FileID`),
  KEY `UserID` (`UserID`),
  CONSTRAINT `file_ibfk_1` FOREIGN KEY (`UserID`) REFERENCES `user` (`UserID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `file`
--

LOCK TABLES `file` WRITE;
/*!40000 ALTER TABLE `file` DISABLE KEYS */;
/*!40000 ALTER TABLE `file` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `group`
--

DROP TABLE IF EXISTS `group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `group` (
  `groupID` int(11) NOT NULL AUTO_INCREMENT,
  `group` varchar(50) NOT NULL,
  `IsUserSpecific` tinyint(4) NOT NULL DEFAULT '0',
  `IsEveryone` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`groupID`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='Groups';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `group`
--

LOCK TABLES `group` WRITE;
/*!40000 ALTER TABLE `group` DISABLE KEYS */;
INSERT INTO `group` VALUES (1,'Users',0,0),(2,'Everyone',0,1),(3,'xibo_admin',1,0);
/*!40000 ALTER TABLE `group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `help`
--

DROP TABLE IF EXISTS `help`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `help` (
  `HelpID` int(11) NOT NULL AUTO_INCREMENT,
  `Topic` varchar(254) NOT NULL,
  `Category` varchar(254) NOT NULL DEFAULT 'General',
  `Link` varchar(254) NOT NULL,
  PRIMARY KEY (`HelpID`)
) ENGINE=InnoDB AUTO_INCREMENT=82 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `help`
--

LOCK TABLES `help` WRITE;
/*!40000 ALTER TABLE `help` DISABLE KEYS */;
INSERT INTO `help` VALUES (1,'Layout','General','manual/single.php?p=layout/overview'),(2,'Content','General','manual/single.php?p=content/overview'),(4,'Schedule','General','manual/single.php?p=schedule/overview'),(5,'Group','General','manual/single.php?p=users/groups'),(6,'Admin','General','manual/single.php?p=admin/settings'),(7,'Report','General','manual/single.php?p=admin/advanced'),(8,'Dashboard','General','manual/single.php?p=coreconcepts/dashboard'),(9,'User','General','manual/single.php?p=users/users'),(10,'Display','General','manual/single.php?p=admin/displays'),(11,'DisplayGroup','General','manual/single.php?p=admin/displaygroups'),(12,'Layout','Add','manual/single.php?p=layout/overview#Add_Layout'),(13,'Layout','Background','manual/single.php?p=layout/layoutdesigner#Background'),(14,'Content','Assign','manual/single.php?p=layout/assigncontent#Assigning_Content'),(15,'Layout','RegionOptions','manual/single.php?p=layout/assigncontent'),(16,'Content','AddtoLibrary','manual/single.php?p=content/adding'),(17,'Display','Edit','manual/single.php?p=admin/displays#Display_Edit'),(18,'Display','Delete','manual/single.php?p=admin/displays#Display_Delete'),(19,'Displays','Groups','manual/single.php?p=admin/displaygroups#Group_Members'),(20,'UserGroup','Add','manual/single.php?p=users/groups#Adding_Group'),(21,'User','Add','manual/single.php?p=users/users#Add_User'),(22,'User','Delete','manual/single.php?p=users/users#Delete_User'),(23,'Content','Config','manual/single.php?p=admin/settings#Content'),(24,'LayoutMedia','Permissions','manual/single.php?p=users/user_permissions'),(25,'Region','Permissions','manual/single.php?p=users/user_permissions'),(26,'Library','Assign','manual/single.php?p=layout/assigncontent#Add_From_Library'),(27,'Media','Delete','manual/single.php?p=content/deleting'),(28,'DisplayGroup','Add','manual/single.php?p=admin/displaygroups#Add_Group'),(29,'DisplayGroup','Edit','manual/single.php?p=admin/displaygroups#Edit_Group'),(30,'DisplayGroup','Delete','manual/single.php?p=admin/displaygroups#Delete_Group'),(31,'DisplayGroup','Members','manual/single.php?p=admin/displaygroups#Group_Members'),(32,'DisplayGroup','Permissions','manual/single.php?p=users/user_permissions'),(34,'Schedule','ScheduleNow','manual/single.php?p=schedule/schedule_now'),(35,'Layout','Delete','manual/single.php?p=layout/overview#Delete_Layout'),(36,'Layout','Copy','manual/single.php?p=layout/overview#Copy_Layout'),(37,'Schedule','Edit','manual/single.php?p=schedule/schedule_event'),(38,'Schedule','Add','manual/single.php?p=schedule/schedule_event'),(39,'Layout','Permissions','manual/single.php?p=users/user_permissions'),(40,'Display','MediaInventory','manual/single.php?p=admin/displays#Media_Inventory'),(41,'User','ChangePassword','manual/single.php?p=coreconcepts/navbar#Change_Password'),(42,'Schedule','Delete','manual/single.php?p=schedule/schedule_event'),(43,'Layout','Edit','manual/single.php?p=layout/overview#Edit_Layout'),(44,'Media','Permissions','manual/single.php?p=users/user_permissions'),(45,'Display','DefaultLayout','manual/single.php?p=admin/displays'),(46,'UserGroup','Edit','manual/single.php?p=users/groups#Edit_Group'),(47,'UserGroup','Members','manual/single.php?p=users/groups#Group_Member'),(48,'User','PageSecurity','manual/single.php?p=users/menu_page_security#Page_Security'),(49,'User','MenuSecurity','manual/single.php?p=users/menu_page_security#Menu_Security'),(50,'UserGroup','Delete','manual/single.php?p=users/groups#Delete_Group'),(51,'User','Edit','manual/single.php?p=users/users#Edit_User'),(52,'User','Applications','manual/single.php?p=users/users#Users_MyApplications'),(53,'User','SetHomepage','manual/single.php?p=coreconcepts/dashboard#Media_Dashboard'),(54,'DataSet','General','manual/single.php?p=content/content_dataset'),(55,'DataSet','Add','manual/single.php?p=content/content_dataset#Create_Dataset'),(56,'DataSet','Edit','manual/single.php?p=content/content_dataset#Edit_Dataset'),(57,'DataSet','Delete','manual/single.php?p=content/content_dataset#Delete_Dataset'),(58,'DataSet','AddColumn','manual/single.php?p=content/content_dataset#Dataset_Column'),(59,'DataSet','EditColumn','manual/single.php?p=content/content_dataset#Dataset_Column'),(60,'DataSet','DeleteColumn','manual/single.php?p=content/content_dataset#Dataset_Column'),(61,'DataSet','Data','manual/single.php?p=content/content_dataset#Dataset_Row'),(62,'DataSet','Permissions','manual/single.php?p=users/user_permissions'),(63,'Fault','General','manual/single.php?p=admin/advanced#Report_Fault'),(65,'Stats','General','manual/single.php?p=admin/displaystats'),(66,'Resolution','General','manual/single.php?p=templates/template_resolution'),(67,'Template','General','manual/single.php?p=templates/overview'),(68,'Services','Register','manual/single.php?p=admin/api_oauth#Registered_Applications'),(69,'OAuth','General','manual/single.php?p=admin/api_oauth'),(70,'Services','Log','manual/single.php?p=admin/api_oauth#oAuthLog'),(71,'Module','Edit','manual/single.php?p=admin/modules'),(72,'Module','General','manual/single.php?p=admin/modules'),(73,'Campaign','General','manual/single.php?p=layout/campaign_layout'),(74,'License','General','manual/single.php?p=license/licenses'),(75,'DataSet','ViewColumns','manual/single.php?p=content/content_dataset#Dataset_Column'),(76,'Campaign','Permissions','manual/single.php?p=users/user_permissions'),(77,'Transition','Edit','manual/single.php?p=layout/transitions'),(78,'User','SetPassword','manual/single.php?p=users/users#Set_Password'),(79,'DataSet','ImportCSV','manual/single.php?p=content/content_dataset#Import_CSV'),(80,'DisplayGroup','FileAssociations','manual/single.php?p=admin/fileassociations'),(81,'Statusdashboard','General','manual/single.php?p=coreconcepts/dashboard#Status_Dashboard');
/*!40000 ALTER TABLE `help` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `layout`
--

DROP TABLE IF EXISTS `layout`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `layout` (
  `layoutID` int(11) NOT NULL AUTO_INCREMENT,
  `layout` varchar(50) NOT NULL,
  `xml` longtext NOT NULL,
  `userID` int(11) NOT NULL COMMENT 'The UserID that created this layout',
  `createdDT` datetime NOT NULL,
  `modifiedDT` datetime NOT NULL,
  `description` varchar(254) DEFAULT NULL,
  `tags` varchar(254) DEFAULT NULL,
  `templateID` int(11) DEFAULT NULL COMMENT 'The ID of the template',
  `retired` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'Is this layout retired',
  `duration` int(11) NOT NULL DEFAULT '0' COMMENT 'The duration in seconds',
  `background` varchar(254) DEFAULT NULL,
  `status` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`layoutID`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='Layouts';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `layout`
--

LOCK TABLES `layout` WRITE;
/*!40000 ALTER TABLE `layout` DISABLE KEYS */;
INSERT INTO `layout` VALUES (4,'Default Layout','<?xml version=\"1.0\"?>\n<layout schemaVersion=\"1\" width=\"800\" height=\"450\" bgcolor=\"#000000\" background=\"2.png\" resolutionid=\"4\"><region id=\"47ff29524ce1b\" width=\"460\" height=\"272\" top=\"101\" left=\"177\" userId=\"1\"><media id=\"10\" type=\"image\" duration=\"10\" lkid=\"10\" userId=\"1\" schemaVersion=\"1\">\n                            <options><uri>10.png</uri></options>\n                            <raw/>\n                    </media><media id=\"11\" type=\"image\" duration=\"10\" lkid=\"11\" userId=\"1\" schemaVersion=\"1\">\n                            <options><uri>11.png</uri></options>\n                            <raw/>\n                    </media></region><region id=\"537b79c27eade\" userId=\"1\" width=\"800\" height=\"61\" top=\"389\" left=\"0\"><media id=\"3d4de8eb456dffe12921ab00c472b86f\" type=\"ticker\" duration=\"10\" lkid=\"\" userId=\"1\" schemaVersion=\"1\">\n                            <options><xmds>1</xmds><sourceId>1</sourceId><uri>http%3A%2F%2Ffeeds.bbci.co.uk%2Fnews%2Fworld%2Frss.xml</uri><datasetid>0</datasetid><updateInterval>120</updateInterval><scrollSpeed>1</scrollSpeed><direction>single</direction><copyright/><numItems>30</numItems><takeItemsFrom>start</takeItemsFrom><durationIsPerItem>1</durationIsPerItem><fitText>0</fitText><itemsSideBySide>0</itemsSideBySide><upperLimit>0</upperLimit><lowerLimit>0</lowerLimit><filter/><ordering/><itemsPerPage>1</itemsPerPage></options>\n                            <raw><template><![CDATA[<p style=\"text-align: center;\"><span style=\"color:#000000;\"><span style=\"font-size: 20px;\">[Description]</span></span></p>\n]]></template><css><![CDATA[]]></css></raw>\n                    </media></region><region id=\"537f5368b172a\" userId=\"1\" width=\"286\" height=\"98\" top=\"0\" left=\"0\"><media id=\"6\" type=\"image\" duration=\"3\" lkid=\"8\" userId=\"1\" schemaVersion=\"1\">\n                            <options><uri>6.png</uri></options>\n                            <raw/>\n                    </media><media id=\"b4f8db9697d8b5be5d877e3b7e9df3ee\" type=\"webpage\" duration=\"999\" lkid=\"\" userId=\"1\" schemaVersion=\"1\">\n                            <options><uri>%2Fclock.php</uri><scaling>100</scaling><transparency>1</transparency><offsetLeft>0</offsetLeft><offsetTop>0</offsetTop></options>\n                            <raw/>\n                    </media></region></layout>\n',1,'2013-02-02 14:30:40','2014-05-23 15:41:10',NULL,NULL,NULL,0,0,'2.png',2);
/*!40000 ALTER TABLE `layout` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lkcampaigngroup`
--

DROP TABLE IF EXISTS `lkcampaigngroup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lkcampaigngroup` (
  `LkCampaignGroupID` int(11) NOT NULL AUTO_INCREMENT,
  `CampaignID` int(11) NOT NULL,
  `GroupID` int(11) NOT NULL,
  `View` tinyint(4) NOT NULL DEFAULT '0',
  `Edit` tinyint(4) NOT NULL DEFAULT '0',
  `Del` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`LkCampaignGroupID`),
  KEY `CampaignID` (`CampaignID`),
  KEY `GroupID` (`GroupID`),
  CONSTRAINT `lkcampaigngroup_ibfk_1` FOREIGN KEY (`CampaignID`) REFERENCES `campaign` (`CampaignID`),
  CONSTRAINT `lkcampaigngroup_ibfk_2` FOREIGN KEY (`GroupID`) REFERENCES `group` (`groupID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lkcampaigngroup`
--

LOCK TABLES `lkcampaigngroup` WRITE;
/*!40000 ALTER TABLE `lkcampaigngroup` DISABLE KEYS */;
/*!40000 ALTER TABLE `lkcampaigngroup` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lkcampaignlayout`
--

DROP TABLE IF EXISTS `lkcampaignlayout`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lkcampaignlayout` (
  `LkCampaignLayoutID` int(11) NOT NULL AUTO_INCREMENT,
  `CampaignID` int(11) NOT NULL,
  `LayoutID` int(11) NOT NULL,
  `DisplayOrder` int(11) NOT NULL,
  PRIMARY KEY (`LkCampaignLayoutID`),
  KEY `CampaignID` (`CampaignID`),
  KEY `LayoutID` (`LayoutID`),
  CONSTRAINT `lkcampaignlayout_ibfk_1` FOREIGN KEY (`CampaignID`) REFERENCES `campaign` (`CampaignID`),
  CONSTRAINT `lkcampaignlayout_ibfk_2` FOREIGN KEY (`LayoutID`) REFERENCES `layout` (`layoutID`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lkcampaignlayout`
--

LOCK TABLES `lkcampaignlayout` WRITE;
/*!40000 ALTER TABLE `lkcampaignlayout` DISABLE KEYS */;
INSERT INTO `lkcampaignlayout` VALUES (1,1,4,1);
/*!40000 ALTER TABLE `lkcampaignlayout` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lkdatasetgroup`
--

DROP TABLE IF EXISTS `lkdatasetgroup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lkdatasetgroup` (
  `LkDataSetGroupID` int(11) NOT NULL AUTO_INCREMENT,
  `DataSetID` int(11) NOT NULL,
  `GroupID` int(11) NOT NULL,
  `View` tinyint(4) NOT NULL DEFAULT '0',
  `Edit` tinyint(4) NOT NULL DEFAULT '0',
  `Del` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`LkDataSetGroupID`),
  KEY `DataSetID` (`DataSetID`),
  KEY `GroupID` (`GroupID`),
  CONSTRAINT `lkdatasetgroup_ibfk_1` FOREIGN KEY (`DataSetID`) REFERENCES `dataset` (`DataSetID`),
  CONSTRAINT `lkdatasetgroup_ibfk_2` FOREIGN KEY (`GroupID`) REFERENCES `group` (`groupID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lkdatasetgroup`
--

LOCK TABLES `lkdatasetgroup` WRITE;
/*!40000 ALTER TABLE `lkdatasetgroup` DISABLE KEYS */;
/*!40000 ALTER TABLE `lkdatasetgroup` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lkdisplaydg`
--

DROP TABLE IF EXISTS `lkdisplaydg`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lkdisplaydg` (
  `LkDisplayDGID` int(11) NOT NULL AUTO_INCREMENT,
  `DisplayGroupID` int(11) NOT NULL,
  `DisplayID` int(11) NOT NULL,
  PRIMARY KEY (`LkDisplayDGID`),
  KEY `DisplayGroupID` (`DisplayGroupID`),
  KEY `DisplayID` (`DisplayID`),
  CONSTRAINT `lkdisplaydg_ibfk_1` FOREIGN KEY (`DisplayGroupID`) REFERENCES `displaygroup` (`DisplayGroupID`),
  CONSTRAINT `lkdisplaydg_ibfk_2` FOREIGN KEY (`DisplayID`) REFERENCES `display` (`displayid`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lkdisplaydg`
--

LOCK TABLES `lkdisplaydg` WRITE;
/*!40000 ALTER TABLE `lkdisplaydg` DISABLE KEYS */;
INSERT INTO `lkdisplaydg` VALUES (1,1,1);
/*!40000 ALTER TABLE `lkdisplaydg` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lkdisplaygroupgroup`
--

DROP TABLE IF EXISTS `lkdisplaygroupgroup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lkdisplaygroupgroup` (
  `LkDisplayGroupGroupID` int(11) NOT NULL AUTO_INCREMENT,
  `GroupID` int(11) NOT NULL,
  `DisplayGroupID` int(11) NOT NULL,
  `View` tinyint(4) NOT NULL DEFAULT '0',
  `Edit` tinyint(4) NOT NULL DEFAULT '0',
  `Del` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`LkDisplayGroupGroupID`),
  KEY `GroupID` (`GroupID`),
  KEY `DisplayGroupID` (`DisplayGroupID`),
  CONSTRAINT `lkdisplaygroupgroup_ibfk_1` FOREIGN KEY (`GroupID`) REFERENCES `group` (`groupID`),
  CONSTRAINT `lkdisplaygroupgroup_ibfk_2` FOREIGN KEY (`DisplayGroupID`) REFERENCES `displaygroup` (`DisplayGroupID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lkdisplaygroupgroup`
--

LOCK TABLES `lkdisplaygroupgroup` WRITE;
/*!40000 ALTER TABLE `lkdisplaygroupgroup` DISABLE KEYS */;
/*!40000 ALTER TABLE `lkdisplaygroupgroup` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lklayoutmedia`
--

DROP TABLE IF EXISTS `lklayoutmedia`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lklayoutmedia` (
  `lklayoutmediaID` int(11) NOT NULL AUTO_INCREMENT COMMENT 'The ID',
  `mediaID` int(11) NOT NULL,
  `layoutID` int(11) NOT NULL,
  `regionID` varchar(50) NOT NULL COMMENT 'Region ID in the XML',
  PRIMARY KEY (`lklayoutmediaID`),
  KEY `mediaID` (`mediaID`),
  KEY `layoutID` (`layoutID`),
  CONSTRAINT `lklayoutmedia_ibfk_1` FOREIGN KEY (`mediaID`) REFERENCES `media` (`mediaID`),
  CONSTRAINT `lklayoutmedia_ibfk_2` FOREIGN KEY (`layoutID`) REFERENCES `layout` (`layoutID`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8 COMMENT='Creates a reference between Layout and Media';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lklayoutmedia`
--

LOCK TABLES `lklayoutmedia` WRITE;
/*!40000 ALTER TABLE `lklayoutmedia` DISABLE KEYS */;
INSERT INTO `lklayoutmedia` VALUES (8,6,4,'537f5368b172a'),(10,10,4,'47ff29524ce1b'),(11,11,4,'47ff29524ce1b');
/*!40000 ALTER TABLE `lklayoutmedia` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lklayoutmediagroup`
--

DROP TABLE IF EXISTS `lklayoutmediagroup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lklayoutmediagroup` (
  `LkLayoutMediaGroup` int(11) NOT NULL AUTO_INCREMENT,
  `LayoutID` int(11) NOT NULL,
  `RegionID` varchar(50) NOT NULL,
  `MediaID` varchar(50) NOT NULL,
  `GroupID` int(11) NOT NULL,
  `View` tinyint(4) NOT NULL DEFAULT '0',
  `Edit` tinyint(4) NOT NULL DEFAULT '0',
  `Del` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`LkLayoutMediaGroup`),
  KEY `LayoutID` (`LayoutID`),
  KEY `GroupID` (`GroupID`),
  CONSTRAINT `lklayoutmediagroup_ibfk_1` FOREIGN KEY (`LayoutID`) REFERENCES `layout` (`layoutID`),
  CONSTRAINT `lklayoutmediagroup_ibfk_2` FOREIGN KEY (`GroupID`) REFERENCES `group` (`groupID`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lklayoutmediagroup`
--

LOCK TABLES `lklayoutmediagroup` WRITE;
/*!40000 ALTER TABLE `lklayoutmediagroup` DISABLE KEYS */;
INSERT INTO `lklayoutmediagroup` VALUES (8,4,'537f5368b172a','6',3,1,1,1),(10,4,'47ff29524ce1b','10',3,1,1,1),(11,4,'47ff29524ce1b','11',3,1,1,1);
/*!40000 ALTER TABLE `lklayoutmediagroup` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lklayoutregiongroup`
--

DROP TABLE IF EXISTS `lklayoutregiongroup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lklayoutregiongroup` (
  `LkLayoutRegionGroup` int(11) NOT NULL AUTO_INCREMENT,
  `LayoutID` int(11) NOT NULL,
  `RegionID` varchar(50) NOT NULL,
  `GroupID` int(11) NOT NULL,
  `View` tinyint(4) NOT NULL DEFAULT '0',
  `Edit` tinyint(4) NOT NULL DEFAULT '0',
  `Del` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`LkLayoutRegionGroup`),
  KEY `LayoutID` (`LayoutID`),
  KEY `GroupID` (`GroupID`),
  CONSTRAINT `lklayoutregiongroup_ibfk_1` FOREIGN KEY (`LayoutID`) REFERENCES `layout` (`layoutID`),
  CONSTRAINT `lklayoutregiongroup_ibfk_2` FOREIGN KEY (`GroupID`) REFERENCES `group` (`groupID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lklayoutregiongroup`
--

LOCK TABLES `lklayoutregiongroup` WRITE;
/*!40000 ALTER TABLE `lklayoutregiongroup` DISABLE KEYS */;
/*!40000 ALTER TABLE `lklayoutregiongroup` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lkmediadisplaygroup`
--

DROP TABLE IF EXISTS `lkmediadisplaygroup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lkmediadisplaygroup` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `mediaid` int(11) NOT NULL,
  `displaygroupid` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='File associations directly to Display Groups';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lkmediadisplaygroup`
--

LOCK TABLES `lkmediadisplaygroup` WRITE;
/*!40000 ALTER TABLE `lkmediadisplaygroup` DISABLE KEYS */;
/*!40000 ALTER TABLE `lkmediadisplaygroup` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lkmediagroup`
--

DROP TABLE IF EXISTS `lkmediagroup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lkmediagroup` (
  `LkMediaGroupID` int(11) NOT NULL AUTO_INCREMENT,
  `MediaID` int(11) NOT NULL,
  `GroupID` int(11) NOT NULL,
  `View` tinyint(4) NOT NULL DEFAULT '0',
  `Edit` tinyint(4) NOT NULL DEFAULT '0',
  `Del` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`LkMediaGroupID`),
  KEY `MediaID` (`MediaID`),
  KEY `GroupID` (`GroupID`),
  CONSTRAINT `lkmediagroup_ibfk_1` FOREIGN KEY (`MediaID`) REFERENCES `media` (`mediaID`),
  CONSTRAINT `lkmediagroup_ibfk_2` FOREIGN KEY (`GroupID`) REFERENCES `group` (`groupID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lkmediagroup`
--

LOCK TABLES `lkmediagroup` WRITE;
/*!40000 ALTER TABLE `lkmediagroup` DISABLE KEYS */;
/*!40000 ALTER TABLE `lkmediagroup` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lkmenuitemgroup`
--

DROP TABLE IF EXISTS `lkmenuitemgroup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lkmenuitemgroup` (
  `LkMenuItemGroupID` int(11) NOT NULL AUTO_INCREMENT,
  `GroupID` int(11) NOT NULL,
  `MenuItemID` int(11) NOT NULL,
  PRIMARY KEY (`LkMenuItemGroupID`),
  KEY `GroupID` (`GroupID`),
  KEY `MenuItemID` (`MenuItemID`),
  CONSTRAINT `lkmenuitemgroup_ibfk_1` FOREIGN KEY (`GroupID`) REFERENCES `group` (`groupID`),
  CONSTRAINT `lkmenuitemgroup_ibfk_2` FOREIGN KEY (`MenuItemID`) REFERENCES `menuitem` (`MenuItemID`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lkmenuitemgroup`
--

LOCK TABLES `lkmenuitemgroup` WRITE;
/*!40000 ALTER TABLE `lkmenuitemgroup` DISABLE KEYS */;
INSERT INTO `lkmenuitemgroup` VALUES (1,1,33),(2,1,14),(3,1,15),(4,1,16),(5,1,20),(6,1,24),(7,1,1),(8,1,2),(9,1,3),(10,1,29),(11,1,30),(12,1,26);
/*!40000 ALTER TABLE `lkmenuitemgroup` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lkpagegroup`
--

DROP TABLE IF EXISTS `lkpagegroup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lkpagegroup` (
  `lkpagegroupID` int(11) NOT NULL AUTO_INCREMENT,
  `pageID` int(11) NOT NULL,
  `groupID` int(11) NOT NULL,
  PRIMARY KEY (`lkpagegroupID`),
  KEY `pageID` (`pageID`),
  KEY `groupID` (`groupID`),
  CONSTRAINT `lkpagegroup_ibfk_1` FOREIGN KEY (`pageID`) REFERENCES `pages` (`pageID`),
  CONSTRAINT `lkpagegroup_ibfk_2` FOREIGN KEY (`groupID`) REFERENCES `group` (`groupID`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COMMENT='Pages available to groups';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lkpagegroup`
--

LOCK TABLES `lkpagegroup` WRITE;
/*!40000 ALTER TABLE `lkpagegroup` DISABLE KEYS */;
INSERT INTO `lkpagegroup` VALUES (1,2,1),(2,1,1),(3,3,1),(4,19,1),(5,5,1),(6,7,1),(7,24,1),(8,39,1),(9,41,1),(10,42,1);
/*!40000 ALTER TABLE `lkpagegroup` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lktemplategroup`
--

DROP TABLE IF EXISTS `lktemplategroup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lktemplategroup` (
  `LkTemplateGroupID` int(11) NOT NULL AUTO_INCREMENT,
  `TemplateID` int(11) NOT NULL,
  `GroupID` int(11) NOT NULL,
  `View` tinyint(4) NOT NULL DEFAULT '0',
  `Edit` tinyint(4) NOT NULL DEFAULT '0',
  `Del` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`LkTemplateGroupID`),
  KEY `TemplateID` (`TemplateID`),
  KEY `GroupID` (`GroupID`),
  CONSTRAINT `lktemplategroup_ibfk_1` FOREIGN KEY (`TemplateID`) REFERENCES `template` (`templateID`),
  CONSTRAINT `lktemplategroup_ibfk_2` FOREIGN KEY (`GroupID`) REFERENCES `group` (`groupID`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lktemplategroup`
--

LOCK TABLES `lktemplategroup` WRITE;
/*!40000 ALTER TABLE `lktemplategroup` DISABLE KEYS */;
INSERT INTO `lktemplategroup` VALUES (1,1,2,1,0,0),(2,2,2,1,0,0),(3,3,2,1,0,0),(4,4,2,1,0,0),(5,5,2,1,0,0),(6,6,2,1,0,0),(7,7,2,1,0,0),(8,8,2,1,0,0);
/*!40000 ALTER TABLE `lktemplategroup` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lkusergroup`
--

DROP TABLE IF EXISTS `lkusergroup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lkusergroup` (
  `LkUserGroupID` int(11) NOT NULL AUTO_INCREMENT,
  `GroupID` int(11) NOT NULL,
  `UserID` int(11) NOT NULL,
  PRIMARY KEY (`LkUserGroupID`),
  KEY `GroupID` (`GroupID`),
  KEY `UserID` (`UserID`),
  CONSTRAINT `lkusergroup_ibfk_1` FOREIGN KEY (`GroupID`) REFERENCES `group` (`groupID`),
  CONSTRAINT `lkusergroup_ibfk_2` FOREIGN KEY (`UserID`) REFERENCES `user` (`UserID`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lkusergroup`
--

LOCK TABLES `lkusergroup` WRITE;
/*!40000 ALTER TABLE `lkusergroup` DISABLE KEYS */;
INSERT INTO `lkusergroup` VALUES (10,3,1);
/*!40000 ALTER TABLE `lkusergroup` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `log`
--

DROP TABLE IF EXISTS `log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `log` (
  `logid` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'The log ID',
  `logdate` datetime NOT NULL COMMENT 'The log date',
  `type` enum('error','audit') NOT NULL,
  `page` varchar(50) NOT NULL,
  `function` varchar(50) DEFAULT NULL,
  `message` longtext NOT NULL,
  `RequestUri` varchar(2000) DEFAULT NULL,
  `RemoteAddr` varchar(254) DEFAULT NULL,
  `userID` int(11) NOT NULL DEFAULT '0',
  `UserAgent` varchar(254) DEFAULT NULL,
  `scheduleID` int(11) DEFAULT NULL,
  `displayID` int(11) DEFAULT NULL,
  `layoutID` int(11) DEFAULT NULL,
  `mediaID` int(11) DEFAULT NULL,
  PRIMARY KEY (`logid`),
  KEY `logdate` (`logdate`)
) ENGINE=MyISAM AUTO_INCREMENT=11204 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `media`
--

DROP TABLE IF EXISTS `media`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `media` (
  `mediaID` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `type` varchar(15) NOT NULL,
  `duration` int(11) NOT NULL,
  `originalFilename` varchar(254) DEFAULT NULL,
  `storedAs` varchar(254) DEFAULT NULL COMMENT 'What has this media been stored as',
  `MD5` varchar(32) DEFAULT NULL,
  `FileSize` bigint(20) DEFAULT NULL,
  `userID` int(11) NOT NULL,
  `retired` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'Is retired?',
  `isEdited` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'Is this the current record',
  `editedMediaID` int(11) DEFAULT NULL COMMENT 'The Parent ID',
  PRIMARY KEY (`mediaID`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `media`
--

LOCK TABLES `media` WRITE;
/*!40000 ALTER TABLE `media` DISABLE KEYS */;
INSERT INTO `media` VALUES (1,'bgrnd1','image',10,'background.png','1.png','89685dbff67cc25863d0ca99e8686bb8',257704,1,0,0,NULL),(2,'xibo_karoshi','image',10,'xibobackground.png','2.png','4b14f66e4933019dbe96fd0ad3f965ba',70831,1,0,0,NULL),(6,'blackbox1.png','image',3,'blackbox1.png','6.png','13234d8ca6fb2ce947510e6a8f040348',655,1,0,0,NULL),(10,'welcome1','image',10,'welcome1.png','10.png','f75a0638c88502bfd4f4306bb668b670',43628,1,0,0,NULL),(11,'welcome2','image',10,'welcome2.png','11.png','3f1da9cae5dfad77691441c17c242e34',23884,1,0,0,NULL);
/*!40000 ALTER TABLE `media` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `menu`
--

DROP TABLE IF EXISTS `menu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `menu` (
  `MenuID` smallint(6) NOT NULL AUTO_INCREMENT,
  `Menu` varchar(50) NOT NULL,
  PRIMARY KEY (`MenuID`),
  UNIQUE KEY `Menu` (`Menu`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 COMMENT='A Menu (or collection of links)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `menu`
--

LOCK TABLES `menu` WRITE;
/*!40000 ALTER TABLE `menu` DISABLE KEYS */;
INSERT INTO `menu` VALUES (8,'Administration Menu'),(9,'Advanced Menu'),(2,'Dashboard'),(6,'Design Menu'),(7,'Display Menu'),(5,'Library Menu'),(1,'Top Nav');
/*!40000 ALTER TABLE `menu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `menuitem`
--

DROP TABLE IF EXISTS `menuitem`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `menuitem` (
  `MenuItemID` int(11) NOT NULL AUTO_INCREMENT,
  `MenuID` smallint(6) NOT NULL,
  `PageID` int(11) NOT NULL,
  `Args` varchar(254) DEFAULT NULL,
  `Text` varchar(20) NOT NULL,
  `Class` varchar(50) DEFAULT NULL,
  `Img` varchar(254) DEFAULT NULL,
  `Sequence` smallint(6) NOT NULL DEFAULT '1',
  `External` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`MenuItemID`),
  KEY `PageID` (`PageID`),
  KEY `MenuID` (`MenuID`),
  CONSTRAINT `menuitem_ibfk_1` FOREIGN KEY (`MenuID`) REFERENCES `menu` (`MenuID`),
  CONSTRAINT `menuitem_ibfk_2` FOREIGN KEY (`PageID`) REFERENCES `pages` (`pageID`)
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `menuitem`
--

LOCK TABLES `menuitem` WRITE;
/*!40000 ALTER TABLE `menuitem` DISABLE KEYS */;
INSERT INTO `menuitem` VALUES (1,1,2,NULL,'Schedule',NULL,NULL,1,0),(2,1,5,NULL,'Design',NULL,NULL,2,0),(3,1,7,NULL,'Library',NULL,NULL,3,0),(4,1,17,NULL,'Administration',NULL,NULL,5,0),(7,7,11,NULL,'Displays',NULL,NULL,1,0),(8,8,15,NULL,'User Groups',NULL,NULL,2,0),(9,8,17,NULL,'Users',NULL,NULL,1,0),(10,9,16,NULL,'Log',NULL,NULL,1,0),(11,9,18,NULL,'About',NULL,NULL,4,0),(12,9,40,NULL,'Sessions',NULL,NULL,2,0),(13,8,14,NULL,'Settings',NULL,NULL,3,0),(14,2,2,'sp=month','Schedule','schedule_button','dashboard/scheduleview.png',1,0),(15,2,5,NULL,'Layouts','playlist_button','dashboard/presentations.png',2,0),(16,2,7,NULL,'Library','content_button','dashboard/content.png',3,0),(17,2,25,NULL,'Templates','layout_button','dashboard/layouts.png',4,0),(18,2,17,NULL,'Users','user_button','dashboard/users.png',5,0),(19,2,14,NULL,'Settings','settings_button','dashboard/settings.png',6,0),(20,2,18,NULL,'About','license_button','dashboard/license.png',7,0),(22,9,26,NULL,'Report Fault',NULL,NULL,3,0),(23,7,27,NULL,'Statistics',NULL,NULL,3,0),(24,2,28,'manual/index.php','Manual','help_button','dashboard/help.png',10,1),(25,6,29,NULL,'Resolutions',NULL,NULL,4,0),(26,6,25,NULL,'Templates',NULL,NULL,3,0),(27,7,32,NULL,'Display Groups',NULL,NULL,2,0),(28,8,33,NULL,'Applications',NULL,NULL,4,0),(29,5,36,NULL,'DataSets',NULL,NULL,2,0),(30,5,7,NULL,'Media',NULL,NULL,1,0),(33,6,5,NULL,'Layouts',NULL,NULL,2,0),(34,1,11,NULL,'Displays',NULL,NULL,4,0),(35,1,16,NULL,'Advanced',NULL,NULL,6,0),(36,8,24,NULL,'Modules',NULL,NULL,5,0),(37,6,37,NULL,'Campaigns',NULL,NULL,1,0),(38,8,38,NULL,'Transitions',NULL,NULL,6,0),(39,9,30,NULL,'Help Links',NULL,NULL,6,0);
/*!40000 ALTER TABLE `menuitem` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `module`
--

DROP TABLE IF EXISTS `module`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `module` (
  `ModuleID` int(11) NOT NULL AUTO_INCREMENT,
  `Module` varchar(50) NOT NULL,
  `Name` varchar(50) NOT NULL,
  `Enabled` tinyint(4) NOT NULL DEFAULT '0',
  `RegionSpecific` tinyint(4) NOT NULL DEFAULT '1',
  `Description` varchar(254) DEFAULT NULL,
  `ImageUri` varchar(254) NOT NULL,
  `SchemaVersion` int(11) NOT NULL DEFAULT '1',
  `ValidExtensions` varchar(254) DEFAULT NULL,
  `PreviewEnabled` tinyint(4) NOT NULL DEFAULT '1',
  `assignable` tinyint(4) NOT NULL DEFAULT '1',
  PRIMARY KEY (`ModuleID`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8 COMMENT='Functional Modules';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `module`
--

LOCK TABLES `module` WRITE;
/*!40000 ALTER TABLE `module` DISABLE KEYS */;
INSERT INTO `module` VALUES (1,'Image','Image',1,0,'Images. PNG, JPG, BMP, GIF','forms/image.gif',1,'jpg,jpeg,png,bmp,gif',1,1),(2,'Video','Video',1,0,'Videos - support varies depending on the client hardware you are using.','forms/video.gif',1,'wmv,avi,mpg,mpeg,webm,mp4',1,1),(3,'Flash','Flash',1,0,'Flash','forms/flash.gif',1,'swf',1,1),(4,'PowerPoint','PowerPoint',1,0,'Powerpoint. PPT, PPS','forms/powerpoint.gif',1,'ppt,pps,pptx',1,1),(5,'Webpage','Webpage',1,1,'Webpages.','forms/webpage.gif',1,NULL,1,1),(6,'Ticker','Ticker',1,1,'RSS Ticker.','forms/ticker.gif',1,NULL,1,1),(7,'Text','Text',1,1,'Text. With Directional Controls.','forms/text.gif',1,NULL,1,1),(8,'Embedded','Embedded',1,1,'Embedded HTML','forms/webpage.gif',1,NULL,1,1),(9,'MicroBlog','MicroBlog',0,1,NULL,'forms/microblog.gif',1,NULL,1,1),(10,'Counter','Counter',0,1,'Customer Counter connected to a Remote Control','forms/counter.gif',1,NULL,1,1),(11,'datasetview','Data Set',1,1,'A view on a DataSet','forms/datasetview.gif',1,NULL,1,1),(12,'shellcommand','Shell Command',1,1,'Execute a shell command on the client','forms/shellcommand.gif',1,NULL,1,1),(13,'localvideo','Local Video',0,1,'Play a video locally stored on the client','forms/video.gif',1,NULL,1,1),(14,'genericfile','Generic File',1,0,'A generic file to be stored in the library','forms/library.gif',1,'apk,js,html,htm',0,0);
/*!40000 ALTER TABLE `module` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oauth_log`
--

DROP TABLE IF EXISTS `oauth_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oauth_log` (
  `olg_id` int(11) NOT NULL AUTO_INCREMENT,
  `olg_osr_consumer_key` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `olg_ost_token` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `olg_ocr_consumer_key` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `olg_oct_token` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `olg_usa_id_ref` int(11) DEFAULT NULL,
  `olg_received` text NOT NULL,
  `olg_sent` text NOT NULL,
  `olg_base_string` text NOT NULL,
  `olg_notes` text NOT NULL,
  `olg_timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `olg_remote_ip` bigint(20) NOT NULL,
  PRIMARY KEY (`olg_id`),
  KEY `olg_osr_consumer_key` (`olg_osr_consumer_key`,`olg_id`),
  KEY `olg_ost_token` (`olg_ost_token`,`olg_id`),
  KEY `olg_ocr_consumer_key` (`olg_ocr_consumer_key`,`olg_id`),
  KEY `olg_oct_token` (`olg_oct_token`,`olg_id`),
  KEY `olg_usa_id_ref` (`olg_usa_id_ref`,`olg_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oauth_log`
--

LOCK TABLES `oauth_log` WRITE;
/*!40000 ALTER TABLE `oauth_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `oauth_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oauth_server_nonce`
--

DROP TABLE IF EXISTS `oauth_server_nonce`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oauth_server_nonce` (
  `osn_id` int(11) NOT NULL AUTO_INCREMENT,
  `osn_consumer_key` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `osn_token` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `osn_timestamp` bigint(20) NOT NULL,
  `osn_nonce` varchar(80) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`osn_id`),
  UNIQUE KEY `osn_consumer_key` (`osn_consumer_key`,`osn_token`,`osn_timestamp`,`osn_nonce`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oauth_server_nonce`
--

LOCK TABLES `oauth_server_nonce` WRITE;
/*!40000 ALTER TABLE `oauth_server_nonce` DISABLE KEYS */;
/*!40000 ALTER TABLE `oauth_server_nonce` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oauth_server_registry`
--

DROP TABLE IF EXISTS `oauth_server_registry`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oauth_server_registry` (
  `osr_id` int(11) NOT NULL AUTO_INCREMENT,
  `osr_usa_id_ref` int(11) DEFAULT NULL,
  `osr_consumer_key` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `osr_consumer_secret` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `osr_enabled` tinyint(1) NOT NULL DEFAULT '1',
  `osr_status` varchar(16) NOT NULL,
  `osr_requester_name` varchar(64) NOT NULL,
  `osr_requester_email` varchar(64) NOT NULL,
  `osr_callback_uri` varchar(255) NOT NULL,
  `osr_application_uri` varchar(255) NOT NULL,
  `osr_application_title` varchar(80) NOT NULL,
  `osr_application_descr` text NOT NULL,
  `osr_application_notes` text NOT NULL,
  `osr_application_type` varchar(20) NOT NULL,
  `osr_application_commercial` tinyint(1) NOT NULL DEFAULT '0',
  `osr_issue_date` datetime NOT NULL,
  `osr_timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`osr_id`),
  UNIQUE KEY `osr_consumer_key` (`osr_consumer_key`),
  KEY `osr_usa_id_ref` (`osr_usa_id_ref`),
  CONSTRAINT `oauth_server_registry_ibfk_1` FOREIGN KEY (`osr_usa_id_ref`) REFERENCES `user` (`UserID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oauth_server_registry`
--

LOCK TABLES `oauth_server_registry` WRITE;
/*!40000 ALTER TABLE `oauth_server_registry` DISABLE KEYS */;
/*!40000 ALTER TABLE `oauth_server_registry` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oauth_server_token`
--

DROP TABLE IF EXISTS `oauth_server_token`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oauth_server_token` (
  `ost_id` int(11) NOT NULL AUTO_INCREMENT,
  `ost_osr_id_ref` int(11) NOT NULL,
  `ost_usa_id_ref` int(11) NOT NULL,
  `ost_token` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `ost_token_secret` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `ost_token_type` enum('request','access') DEFAULT NULL,
  `ost_authorized` tinyint(1) NOT NULL DEFAULT '0',
  `ost_referrer_host` varchar(128) NOT NULL,
  `ost_token_ttl` datetime NOT NULL DEFAULT '9999-12-31 00:00:00',
  `ost_timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `ost_verifier` char(10) DEFAULT NULL,
  `ost_callback_url` varchar(512) DEFAULT NULL,
  PRIMARY KEY (`ost_id`),
  UNIQUE KEY `ost_token` (`ost_token`),
  KEY `ost_osr_id_ref` (`ost_osr_id_ref`),
  KEY `ost_token_ttl` (`ost_token_ttl`),
  KEY `ost_usa_id_ref` (`ost_usa_id_ref`),
  CONSTRAINT `oauth_server_token_ibfk_1` FOREIGN KEY (`ost_osr_id_ref`) REFERENCES `oauth_server_registry` (`osr_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `oauth_server_token_ibfk_2` FOREIGN KEY (`ost_usa_id_ref`) REFERENCES `user` (`UserID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oauth_server_token`
--

LOCK TABLES `oauth_server_token` WRITE;
/*!40000 ALTER TABLE `oauth_server_token` DISABLE KEYS */;
/*!40000 ALTER TABLE `oauth_server_token` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pagegroup`
--

DROP TABLE IF EXISTS `pagegroup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pagegroup` (
  `pagegroupID` int(11) NOT NULL AUTO_INCREMENT,
  `pagegroup` varchar(50) NOT NULL,
  PRIMARY KEY (`pagegroupID`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8 COMMENT='Page Groups';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pagegroup`
--

LOCK TABLES `pagegroup` WRITE;
/*!40000 ALTER TABLE `pagegroup` DISABLE KEYS */;
INSERT INTO `pagegroup` VALUES (1,'Schedule'),(2,'Homepage and Login'),(3,'Layouts'),(4,'Content'),(7,'Displays'),(8,'Users and Groups'),(9,'Reports'),(10,'License and Settings'),(11,'Updates'),(12,'Templates'),(13,'Web Services'),(14,'DataSets');
/*!40000 ALTER TABLE `pagegroup` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pages`
--

DROP TABLE IF EXISTS `pages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pages` (
  `pageID` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `pagegroupID` int(11) NOT NULL,
  PRIMARY KEY (`pageID`),
  KEY `pagegroupID` (`pagegroupID`),
  CONSTRAINT `pages_ibfk_1` FOREIGN KEY (`pagegroupID`) REFERENCES `pagegroup` (`pagegroupID`)
) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=utf8 COMMENT='Available Pages';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pages`
--

LOCK TABLES `pages` WRITE;
/*!40000 ALTER TABLE `pages` DISABLE KEYS */;
INSERT INTO `pages` VALUES (1,'dashboard',2),(2,'schedule',1),(3,'mediamanager',2),(5,'layout',3),(7,'content',4),(11,'display',7),(12,'update',11),(14,'admin',10),(15,'group',8),(16,'log',9),(17,'user',8),(18,'license',10),(19,'index',2),(24,'module',4),(25,'template',3),(26,'fault',10),(27,'stats',9),(28,'manual',2),(29,'resolution',12),(30,'help',2),(31,'clock',2),(32,'displaygroup',7),(33,'oauth',13),(34,'help',2),(35,'clock',2),(36,'dataset',14),(37,'campaign',3),(38,'transition',4),(39,'timeline',3),(40,'sessions',9),(41,'preview',3),(42,'statusdashboard',2);
/*!40000 ALTER TABLE `pages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `resolution`
--

DROP TABLE IF EXISTS `resolution`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `resolution` (
  `resolutionID` int(11) NOT NULL AUTO_INCREMENT,
  `resolution` varchar(20) NOT NULL,
  `width` smallint(6) NOT NULL,
  `height` smallint(6) NOT NULL,
  `intended_width` smallint(6) NOT NULL,
  `intended_height` smallint(6) NOT NULL,
  PRIMARY KEY (`resolutionID`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COMMENT='Supported Resolutions';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `resolution`
--

LOCK TABLES `resolution` WRITE;
/*!40000 ALTER TABLE `resolution` DISABLE KEYS */;
INSERT INTO `resolution` VALUES (1,'4:3 Monitor',800,600,1024,768),(2,'3:2 Tv',720,480,1440,960),(3,'16:10 Widescreen Mon',800,500,1680,1050),(4,'16:9 HD Widescreen',800,450,1920,1080),(5,'3:4 Monitor',600,800,768,1024),(6,'2:3 Tv',480,720,960,1440),(7,'10:16 Widescreen',500,800,1050,1680),(8,'9:16 HD Widescreen',450,800,1080,1920);
/*!40000 ALTER TABLE `resolution` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `schedule`
--

DROP TABLE IF EXISTS `schedule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `schedule` (
  `eventID` int(11) NOT NULL AUTO_INCREMENT,
  `CampaignID` int(11) NOT NULL,
  `DisplayGroupIDs` varchar(254) NOT NULL COMMENT 'A list of the display group ids for this event',
  `recurrence_type` enum('Hour','Day','Week','Month','Year') DEFAULT NULL,
  `recurrence_detail` varchar(100) DEFAULT NULL,
  `userID` int(11) NOT NULL,
  `is_priority` tinyint(4) NOT NULL,
  `FromDT` bigint(20) NOT NULL DEFAULT '0',
  `ToDT` bigint(20) NOT NULL DEFAULT '0',
  `recurrence_range` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`eventID`),
  KEY `layoutID` (`CampaignID`),
  CONSTRAINT `schedule_ibfk_1` FOREIGN KEY (`CampaignID`) REFERENCES `campaign` (`CampaignID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='High level schedule information';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `schedule`
--

LOCK TABLES `schedule` WRITE;
/*!40000 ALTER TABLE `schedule` DISABLE KEYS */;
/*!40000 ALTER TABLE `schedule` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `schedule_detail`
--

DROP TABLE IF EXISTS `schedule_detail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `schedule_detail` (
  `schedule_detailID` int(11) NOT NULL AUTO_INCREMENT,
  `DisplayGroupID` int(11) NOT NULL,
  `CampaignID` int(11) NOT NULL,
  `userID` int(8) NOT NULL DEFAULT '1' COMMENT 'Owner of the Event',
  `is_priority` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'This scheduled event has priority and will take precidence over any others scheduled',
  `eventID` int(11) DEFAULT NULL,
  `FromDT` bigint(20) NOT NULL DEFAULT '0',
  `ToDT` bigint(20) NOT NULL DEFAULT '0',
  `DisplayOrder` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`schedule_detailID`),
  KEY `layoutID` (`CampaignID`),
  KEY `scheduleID` (`eventID`),
  KEY `DisplayGroupID` (`DisplayGroupID`),
  CONSTRAINT `schedule_detail_ibfk_7` FOREIGN KEY (`eventID`) REFERENCES `schedule` (`eventID`),
  CONSTRAINT `schedule_detail_ibfk_8` FOREIGN KEY (`DisplayGroupID`) REFERENCES `displaygroup` (`DisplayGroupID`),
  CONSTRAINT `schedule_detail_ibfk_9` FOREIGN KEY (`CampaignID`) REFERENCES `campaign` (`CampaignID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Replicated schedule across displays and recurrence';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `schedule_detail`
--

LOCK TABLES `schedule_detail` WRITE;
/*!40000 ALTER TABLE `schedule_detail` DISABLE KEYS */;
/*!40000 ALTER TABLE `schedule_detail` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `session`
--

DROP TABLE IF EXISTS `session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `session` (
  `session_id` varchar(160) NOT NULL,
  `session_data` longtext NOT NULL,
  `session_expiration` int(10) unsigned NOT NULL DEFAULT '0',
  `LastAccessed` datetime DEFAULT NULL,
  `LastPage` varchar(25) DEFAULT NULL,
  `userID` int(11) DEFAULT NULL,
  `IsExpired` tinyint(4) NOT NULL DEFAULT '1',
  `UserAgent` varchar(254) DEFAULT NULL,
  `RemoteAddr` varchar(50) DEFAULT NULL,
  `SecurityToken` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`session_id`),
  KEY `userID` (`userID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `session`
--

LOCK TABLES `session` WRITE;
/*!40000 ALTER TABLE `session` DISABLE KEYS */;
INSERT INTO `session` VALUES ('2mjp7i29l02dakumnjgh2qvh53','pagename|s:6:\"layout\";token|s:32:\"2c6953f2c6411ead6b50b04a3b5b7df2\";token_timeout|i:1400855330;message|s:0:\"\";userid|s:1:\"1\";username|s:10:\"xibo_admin\";usertype|s:1:\"1\";layout|a:5:{s:13:\"filter_layout\";s:0:\"\";s:13:\"filter_userid\";i:0;s:14:\"filter_retired\";i:0;s:11:\"filter_tags\";s:0:\"\";s:12:\"LayoutFilter\";i:0;}layoutDesigner|a:2:{s:8:\"JumpList\";i:0;s:4:\"Name\";s:0:\"\";}content|a:8:{s:4:\"type\";s:7:\"webpage\";s:9:\"mediatype\";s:5:\"image\";s:11:\"filter_type\";s:0:\"\";s:11:\"filter_name\";s:0:\"\";s:12:\"filter_owner\";i:0;s:14:\"filter_retired\";i:0;s:26:\"filter_duration_in_seconds\";i:0;s:6:\"Filter\";i:0;}',1400857510,'2014-05-23 15:41:10','layout',1,0,'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:23.0) Gecko/20100101 Firefox/23.0','172.30.86.31',NULL),('41l84lk0ecb78sefjk7mrq8j92','pagename|s:5:\"clock\";token|s:32:\"3e87c25720384ffbafe17e2d08b5be51\";token_timeout|i:1400856366;message|s:0:\"\";username|s:10:\"xibo_admin\";usertype|s:1:\"1\";layout|a:5:{s:13:\"filter_layout\";s:0:\"\";s:13:\"filter_userid\";i:0;s:14:\"filter_retired\";i:0;s:11:\"filter_tags\";s:0:\"\";s:12:\"LayoutFilter\";i:0;}layoutDesigner|a:2:{s:8:\"JumpList\";i:0;s:4:\"Name\";s:0:\"\";}content|a:8:{s:4:\"type\";s:6:\"ticker\";s:11:\"filter_type\";s:0:\"\";s:11:\"filter_name\";s:0:\"\";s:12:\"filter_owner\";i:0;s:14:\"filter_retired\";i:0;s:26:\"filter_duration_in_seconds\";i:0;s:6:\"Filter\";i:0;s:9:\"mediatype\";s:5:\"image\";}DisplayGroupIDs|a:0:{}',1400857806,'2014-05-23 15:46:06','clock',1,1,'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:29.0) Gecko/20100101 Firefox/29.0','127.0.0.1',NULL),('7clmpcr3bvhc96rh0ev8thque6','pagename|s:5:\"clock\";token|s:32:\"684cc8a780fa102a2474f9f640b9ae60\";token_timeout|i:1400849886;message|s:0:\"\";username|s:10:\"xibo_admin\";usertype|s:1:\"1\";layout|a:5:{s:13:\"filter_layout\";s:0:\"\";s:13:\"filter_userid\";i:0;s:14:\"filter_retired\";i:0;s:11:\"filter_tags\";s:0:\"\";s:12:\"LayoutFilter\";i:0;}user|a:3:{s:15:\"filter_username\";s:0:\"\";s:17:\"filter_usertypeid\";i:0;s:6:\"Filter\";i:0;}template|a:4:{s:11:\"filter_name\";s:0:\"\";s:11:\"filter_tags\";s:0:\"\";s:16:\"filter_is_system\";s:2:\"-1\";s:6:\"Filter\";i:0;}layoutDesigner|a:2:{s:8:\"JumpList\";i:0;s:4:\"Name\";s:0:\"\";}content|a:7:{s:4:\"type\";s:6:\"ticker\";s:11:\"filter_type\";s:0:\"\";s:11:\"filter_name\";s:0:\"\";s:12:\"filter_owner\";i:0;s:14:\"filter_retired\";i:0;s:26:\"filter_duration_in_seconds\";i:0;s:6:\"Filter\";i:0;}DisplayGroupIDs|a:0:{}',1400851326,'2014-05-23 13:58:06','clock',1,1,'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:23.0) Gecko/20100101 Firefox/23.0','172.30.86.31',NULL),('rl8h45ti5o31inckgtdbvbmen6','pagename|s:5:\"clock\";token|s:32:\"f027ecba00351b087259d99f09b4ffc0\";token_timeout|i:1400856348;message|s:0:\"\";username|s:10:\"xibo_admin\";usertype|s:1:\"1\";layout|a:5:{s:13:\"filter_layout\";s:0:\"\";s:13:\"filter_userid\";i:0;s:14:\"filter_retired\";i:0;s:11:\"filter_tags\";s:0:\"\";s:12:\"LayoutFilter\";i:0;}layoutDesigner|a:2:{s:8:\"JumpList\";i:0;s:4:\"Name\";s:0:\"\";}content|a:7:{s:11:\"filter_type\";s:0:\"\";s:11:\"filter_name\";s:0:\"\";s:12:\"filter_owner\";i:0;s:14:\"filter_retired\";i:0;s:26:\"filter_duration_in_seconds\";i:0;s:6:\"Filter\";i:0;s:4:\"type\";s:4:\"text\";}template|a:4:{s:11:\"filter_name\";s:0:\"\";s:11:\"filter_tags\";s:0:\"\";s:16:\"filter_is_system\";s:2:\"-1\";s:6:\"Filter\";i:0;}user|a:3:{s:15:\"filter_username\";s:0:\"\";s:17:\"filter_usertypeid\";i:0;s:6:\"Filter\";i:0;}DisplayGroupIDs|a:0:{}',1400857788,'2014-05-23 15:45:48','clock',1,1,'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:27.0) Gecko/20100101 Firefox/27.0','172.30.86.12',NULL);
/*!40000 ALTER TABLE `session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `setting`
--

DROP TABLE IF EXISTS `setting`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `setting` (
  `settingid` int(11) NOT NULL AUTO_INCREMENT,
  `setting` varchar(50) NOT NULL,
  `value` varchar(1000) NOT NULL,
  `type` varchar(24) NOT NULL,
  `helptext` text,
  `options` varchar(254) DEFAULT NULL,
  `cat` varchar(24) NOT NULL DEFAULT 'general',
  `userChange` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'Can the user change this setting',
  PRIMARY KEY (`settingid`)
) ENGINE=InnoDB AUTO_INCREMENT=74 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `setting`
--

LOCK TABLES `setting` WRITE;
/*!40000 ALTER TABLE `setting` DISABLE KEYS */;
INSERT INTO `setting` VALUES (1,'MEDIA_DEFAULT','private','dropdown','Media will be created with these settings. If public everyone will be able to view and use this media.','private|public','default',1),(2,'LAYOUT_DEFAULT','private','dropdown','New layouts will be created with these settings. If public everyone will be able to view and use this layout.','private|public','default',1),(3,'defaultUsertype','User','dropdown','Sets the default user type selected when creating a user.\r\n<br />\r\nWe recommend that this is set to \"User\"','User|Group Admin|Super Admin','default',1),(5,'debug','Off','dropdown','Sets whether debug information is recorded when an error occurs.\r\n<br />\r\nThis should be set to \"off\" to ensure smaller log sizes','On|Off','error',1),(7,'userModule','module_user_general.php','dirselect','This sets which user authentication module is currently being used.',NULL,'user',0),(10,'adminMessage','','text','Sets the admin message to be displayed on the client page at all times',NULL,'general',0),(11,'defaultTimezone','Europe/London','timezone','Set the default timezone for the application','Europe/London','default',1),(18,'mail_to','admin@yoursite.com','text','Errors will be mailed here',NULL,'maintenance',1),(19,'mail_from','mail@yoursite.com','text','Mail will be sent from this address',NULL,'maintenance',1),(20,'BASE_URL','http://localhost/xibo/','text','This is the fully qualified URI of the site. e.g http://www.xibo.co.uk/',NULL,'general',0),(23,'jpg_length','10','text','Default length for JPG files (in seconds)',NULL,'content',1),(24,'ppt_width','1024','text','Default length for PPT files',NULL,'content',0),(25,'ppt_height','768','text','Default height for PPT files',NULL,'content',0),(26,'ppt_length','120','text','Default length for PPT files (in seconds)',NULL,'content',1),(29,'swf_length','60','text','Default length for SWF files',NULL,'content',1),(30,'audit','Off','dropdown','Turn on the auditing information. Warning this will quickly fill up the log','On|Off','error',1),(33,'LIBRARY_LOCATION','/var/www/xibo-library/','text',NULL,NULL,'path',1),(34,'SERVER_KEY','xiboserverkey','text',NULL,NULL,'general',1),(35,'HELP_BASE','http://www.xibo.org.uk/manual/','text',NULL,NULL,'path',0),(36,'PHONE_HOME','Off','dropdown','Should the server send anonymous statistics back to the Xibo project?','On|Off','general',1),(37,'PHONE_HOME_KEY','27c4d299dbca36c644de33042377b1f8','text','Key used to distinguish each Xibo instance. This is generated randomly based on the time you first installed Xibo, and is completely untraceable.',NULL,'general',0),(38,'PHONE_HOME_URL','http://www.xibo.org.uk/stats/track.php','text','The URL to connect to to PHONE_HOME (if enabled)',NULL,'path',0),(39,'PHONE_HOME_DATE','0','text','The last time we PHONED_HOME in seconds since the epoch',NULL,'general',0),(40,'SERVER_MODE','Production','dropdown','This should only be set if you want to display the maximum allowed error messaging through the user interface. <br /> Useful for capturing critical php errors and environment issues.','Production|Test','error',1),(41,'MAINTENANCE_ENABLED','Off','dropdown','Allow the maintenance script to run if it is called?','Protected|On|Off','maintenance',1),(42,'MAINTENANCE_EMAIL_ALERTS','On','dropdown','Global switch for email alerts to be sent','On|Off','maintenance',1),(43,'MAINTENANCE_KEY','changeme','text','String appended to the maintenance script to prevent malicious calls to the script.',NULL,'maintenance',1),(44,'MAINTENANCE_LOG_MAXAGE','30','text','Maximum age for log entries. Set to 0 to keep logs indefinitely.',NULL,'maintenance',1),(45,'MAINTENANCE_STAT_MAXAGE','30','text','Maximum age for statistics entries. Set to 0 to keep statistics indefinitely.',NULL,'maintenance',1),(46,'MAINTENANCE_ALERT_TOUT','12','text','How long in minutes after the last time a client connects should we send an alert? Can be overridden on a per client basis.',NULL,'maintenance',1),(47,'SHOW_DISPLAY_AS_VNCLINK','','text','Turn the display name in display management into a VNC link using the IP address last collected. The %s is replaced with the IP address. Leave blank to disable.',NULL,'general',1),(48,'SHOW_DISPLAY_AS_VNC_TGT','_top','text','If the display name is shown as a link in display management, what target should the link have? Set _top to open the link in the same window or _blank to open in a new window.',NULL,'general',1),(49,'MAINTENANCE_ALWAYS_ALERT','Off','dropdown','Should Xibo send an email if a display is in an error state every time the maintenance script runs?','On|Off','maintenance',1),(50,'SCHEDULE_LOOKAHEAD','On','dropdown','Should Xibo send future schedule information to clients?','On|Off','general',0),(51,'REQUIRED_FILES_LOOKAHEAD','172800','text','How many seconds in to the future should the calls to RequiredFiles look?',NULL,'general',1),(52,'REGION_OPTIONS_COLOURING','Media Colouring','dropdown',NULL,'Media Colouring|Permissions Colouring','permissions',1),(53,'LAYOUT_COPY_MEDIA_CHECKB','Unchecked','dropdown','Default the checkbox for making duplicates of media when copying layouts','Checked|Unchecked','default',1),(54,'MAX_LICENSED_DISPLAYS','0','text','The maximum number of licensed clients for this server installation. 0 = unlimited',NULL,'general',0),(55,'LIBRARY_MEDIA_UPDATEINALL_CHECKB','Unchecked','dropdown','Default the checkbox for updating media on all layouts when editing in the library','Checked|Unchecked','default',1),(56,'USER_PASSWORD_POLICY','','text','Regular Expression for password complexity, leave blank for no policy.','','permissions',1),(57,'USER_PASSWORD_ERROR','','text','A text description of this password policy. Will be show to users when their password does not meet the required policy','','permissions',1),(58,'MODULE_CONFIG_LOCKED_CHECKB','Unchecked','dropdown','Is the module config locked? Useful for Service providers.','Checked|Unchecked','general',0),(59,'LIBRARY_SIZE_LIMIT_KB','0','text','The Limit for the Library Size in KB',NULL,'content',0),(60,'MONTHLY_XMDS_TRANSFER_LIMIT_KB','0','text','XMDS Transfer Limit in KB/month',NULL,'general',0),(61,'DEFAULT_LANGUAGE','en_GB','text','The default language to use',NULL,'general',1),(62,'TRANSITION_CONFIG_LOCKED_CHECKB','Unchecked','dropdown','Is the Transition config locked?','Checked|Unchecked','general',0),(63,'GLOBAL_THEME_NAME','default','text','The Theme to apply to all pages by default',NULL,'general',1),(64,'DEFAULT_LAT','51.504','text','The Latitude to apply for any Geo aware Previews',NULL,'general',1),(65,'DEFAULT_LONG','-0.104','text','The Longitude to apply for any Geo aware Previews',NULL,'general',1),(66,'SCHEDULE_WITH_VIEW_PERMISSION','No','dropdown','Should users with View permissions on displays be allowed to schedule to them?','Yes|No','permissions',1),(67,'SETTING_IMPORT_ENABLED','Off','dropdown',NULL,'On|Off','general',0),(68,'SETTING_LIBRARY_TIDY_ENABLED','Off','dropdown',NULL,'On|Off','general',0),(69,'SENDFILE_MODE','Off','dropdown','When a user downloads a file from the library or previews a layout, should we attempt to use Apache X-Sendfile, Nginx X-Accel, or PHP (Off) to return the file from the library?','Off|Apache|Nginx','general',1),(70,'EMBEDDED_STATUS_WIDGET','','text','HTML to embed in an iframe on the Status Dashboard',NULL,'general',0),(71,'PROXY_HOST','','text','The Proxy URL',NULL,'general',1),(72,'PROXY_PORT','','text','The Proxy Port',NULL,'general',1),(73,'PROXY_AUTH','','text','The Authentication information for this proxy. username:password',NULL,'general',1);
/*!40000 ALTER TABLE `setting` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stat`
--

DROP TABLE IF EXISTS `stat`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `stat` (
  `statID` bigint(20) NOT NULL AUTO_INCREMENT,
  `Type` varchar(20) NOT NULL,
  `statDate` datetime NOT NULL COMMENT 'State entry date',
  `scheduleID` int(8) NOT NULL,
  `displayID` int(4) NOT NULL,
  `layoutID` int(8) NOT NULL,
  `mediaID` varchar(50) DEFAULT NULL,
  `start` datetime NOT NULL,
  `end` datetime NOT NULL,
  `Tag` varchar(254) DEFAULT NULL,
  PRIMARY KEY (`statID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stat`
--

LOCK TABLES `stat` WRITE;
/*!40000 ALTER TABLE `stat` DISABLE KEYS */;
/*!40000 ALTER TABLE `stat` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `template`
--

DROP TABLE IF EXISTS `template`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `template` (
  `templateID` int(11) NOT NULL AUTO_INCREMENT,
  `template` varchar(50) NOT NULL,
  `xml` text NOT NULL,
  `userID` int(11) NOT NULL,
  `createdDT` datetime NOT NULL,
  `modifiedDT` datetime NOT NULL,
  `description` varchar(254) DEFAULT NULL,
  `tags` varchar(254) DEFAULT NULL,
  `thumbnail` varchar(100) DEFAULT NULL,
  `isSystem` tinyint(4) NOT NULL DEFAULT '0',
  `retired` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`templateID`),
  KEY `userID` (`userID`),
  CONSTRAINT `template_ibfk_3` FOREIGN KEY (`userID`) REFERENCES `user` (`UserID`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COMMENT='Templates for use on Layouts';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `template`
--

LOCK TABLES `template` WRITE;
/*!40000 ALTER TABLE `template` DISABLE KEYS */;
INSERT INTO `template` VALUES (1,'Full Screen 16:9','<?xml version=\"1.0\"?>\n<layout schemaVersion=\"1\" width=\"800\" height=\"450\" bgcolor=\"#000000\"><region id=\"47ff29524ce1b\" width=\"800\" height=\"450\" top=\"0\" left=\"0\"/></layout>\n',1,'2008-01-01 01:00:00','2008-01-01 01:00:00','','fullscreen',NULL,1,0),(2,'Full Screen 16:10','<?xml version=\"1.0\"?>\n<layout schemaVersion=\"1\" width=\"800\" height=\"500\" bgcolor=\"#000000\"><region id=\"47ff29524ce1b\" width=\"800\" height=\"500\" top=\"0\" left=\"0\"/></layout>\n',1,'2008-01-01 01:00:00','2008-01-01 01:00:00','','fullscreen',NULL,1,0),(3,'Full Screen 4:3','<?xml version=\"1.0\"?>\n<layout schemaVersion=\"1\" width=\"800\" height=\"600\" bgcolor=\"#000000\"><region id=\"47ff29524ce1b\" width=\"800\" height=\"600\" top=\"0\" left=\"0\"/></layout>\n',1,'2008-01-01 01:00:00','2008-01-01 01:00:00','','fullscreen',NULL,1,0),(4,'Full Screen 3:2','<?xml version=\"1.0\"?>\n<layout schemaVersion=\"1\" width=\"720\" height=\"480\" bgcolor=\"#000000\"><region id=\"47ff29524ce1b\" width=\"720\" height=\"480\" top=\"0\" left=\"0\"/></layout>\n',1,'2008-01-01 01:00:00','2008-01-01 01:00:00','','fullscreen',NULL,1,0),(5,'Portrait - 10:16','<?xml version=\"1.0\"?>\n<layout width=\"500\" height=\"800\" bgcolor=\"#000000\" background=\"\" schemaVersion=\"1\"><region id=\"47ff2f524ae1b\" width=\"500\" height=\"800\" top=\"0\" left=\"0\"/></layout>\n',1,'2008-01-01 01:00:00','2008-01-01 01:00:00','','',NULL,1,0),(6,'Portrait - 9:16','<?xml version=\"1.0\"?>\n<layout width=\"450\" height=\"800\" bgcolor=\"#000000\" background=\"\" schemaVersion=\"1\"><region id=\"47ff2f524be1b\" width=\"450\" height=\"800\" top=\"0\" left=\"0\"/></layout>\n',1,'2008-01-01 01:00:00','2008-01-01 01:00:00','','',NULL,1,0),(7,'Portrait - 3:4','<?xml version=\"1.0\"?>\n<layout width=\"600\" height=\"800\" bgcolor=\"#000000\" background=\"\" schemaVersion=\"1\"><region id=\"47ff2f524ce1b\" width=\"600\" height=\"800\" top=\"0\" left=\"0\"/></layout>\n',1,'2008-01-01 01:00:00','2008-01-01 01:00:00','','',NULL,1,0),(8,'Portrait - 2:3','<?xml version=\"1.0\"?>\n<layout width=\"480\" height=\"720\" bgcolor=\"#000000\" background=\"\" schemaVersion=\"1\"><region id=\"47ff2f524de1b\" width=\"480\" height=\"720\" top=\"0\" left=\"0\"/></layout>\n',1,'2008-01-01 01:00:00','2008-01-01 01:00:00','','',NULL,1,0);
/*!40000 ALTER TABLE `template` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transition`
--

DROP TABLE IF EXISTS `transition`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `transition` (
  `TransitionID` int(11) NOT NULL AUTO_INCREMENT,
  `Transition` varchar(254) NOT NULL,
  `Code` varchar(50) NOT NULL,
  `HasDuration` tinyint(4) NOT NULL,
  `HasDirection` tinyint(4) NOT NULL,
  `AvailableAsIn` tinyint(4) NOT NULL,
  `AvailableAsOut` tinyint(4) NOT NULL,
  PRIMARY KEY (`TransitionID`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transition`
--

LOCK TABLES `transition` WRITE;
/*!40000 ALTER TABLE `transition` DISABLE KEYS */;
INSERT INTO `transition` VALUES (1,'Fade In','fadeIn',1,0,0,0),(2,'Fade Out','fadeOut',1,0,0,0),(3,'Fly','fly',1,1,0,0);
/*!40000 ALTER TABLE `transition` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user` (
  `UserID` int(11) NOT NULL AUTO_INCREMENT,
  `usertypeid` int(8) NOT NULL,
  `UserName` varchar(15) NOT NULL,
  `UserPassword` varchar(128) NOT NULL,
  `loggedin` tinyint(1) NOT NULL DEFAULT '0',
  `lastaccessed` datetime DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL COMMENT 'The users email address',
  `homepage` varchar(254) NOT NULL DEFAULT 'dashboard.php' COMMENT 'The users homepage',
  `Retired` tinyint(4) NOT NULL DEFAULT '0',
  `CSPRNG` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`UserID`),
  KEY `usertypeid` (`usertypeid`),
  CONSTRAINT `user_ibfk_2` FOREIGN KEY (`usertypeid`) REFERENCES `usertype` (`usertypeid`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,1,'xibo_admin','sha256:1000:bHAULq9e8k0hBwZqNQZ6aVL9anCyEMp+:wDpfkLdXcDKhiI0vA2CF0bNBRbdyP2PG',1,'2014-05-23 15:46:55','info@xibo.org.uk','statusdashboard',0,1);
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usertype`
--

DROP TABLE IF EXISTS `usertype`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `usertype` (
  `usertypeid` int(8) NOT NULL,
  `usertype` varchar(16) CHARACTER SET latin1 NOT NULL,
  PRIMARY KEY (`usertypeid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usertype`
--

LOCK TABLES `usertype` WRITE;
/*!40000 ALTER TABLE `usertype` DISABLE KEYS */;
INSERT INTO `usertype` VALUES (1,'Super Admin'),(2,'Group Admin'),(3,'User');
/*!40000 ALTER TABLE `usertype` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `version`
--

DROP TABLE IF EXISTS `version`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `version` (
  `app_ver` varchar(20) DEFAULT NULL,
  `XmdsVersion` smallint(6) NOT NULL,
  `XlfVersion` smallint(6) NOT NULL,
  `DBVersion` int(11) NOT NULL DEFAULT '1'
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Version information';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `version`
--

LOCK TABLES `version` WRITE;
/*!40000 ALTER TABLE `version` DISABLE KEYS */;
INSERT INTO `version` VALUES ('1.6.0',3,1,68);
/*!40000 ALTER TABLE `version` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2014-05-23 15:47:19
