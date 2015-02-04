# Dump of table gaf_cards
# ------------------------------------------------------------

DROP TABLE IF EXISTS `gaf_cards`;

CREATE TABLE `gaf_cards` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `domain` varchar(128) DEFAULT NULL,
  `cardname` varchar(128) DEFAULT NULL,
  `type` varchar(128) DEFAULT NULL,
  `namespace` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uniquecard` (`domain`,`cardname`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table gaf_cards_conf
# ------------------------------------------------------------

DROP TABLE IF EXISTS `gaf_cards_conf`;

CREATE TABLE `gaf_cards_conf` (
  `userid` varchar(50) NOT NULL DEFAULT '0',
  `domain` varchar(128) NOT NULL DEFAULT '',
  `cardname` varchar(128) NOT NULL DEFAULT '',
  `type` varchar(128) DEFAULT NULL,
  `param_key` varchar(50) NOT NULL DEFAULT '',
  `param_value` longtext,
  PRIMARY KEY (`userid`,`domain`,`cardname`,`param_key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table gaf_configs
# ------------------------------------------------------------

DROP TABLE IF EXISTS `gaf_configs`;

CREATE TABLE `gaf_configs` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `section` int(10) unsigned NOT NULL DEFAULT '0',
  `label` varchar(45) CHARACTER SET latin1 NOT NULL DEFAULT '',
  `val` longtext CHARACTER SET latin1,
  `description` varchar(255) CHARACTER SET latin1 DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `Index_2` (`label`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table gaf_domains
# ------------------------------------------------------------

DROP TABLE IF EXISTS `gaf_domains`;

CREATE TABLE `gaf_domains` (
  `id` varchar(128) NOT NULL DEFAULT '',
  `height` int(11) DEFAULT NULL,
  `card_grid` varchar(128) DEFAULT NULL,
  `active` tinyint(4) DEFAULT '1',
  `deck_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `gaf_domains` WRITE;
/*!40000 ALTER TABLE `gaf_domains` DISABLE KEYS */;

INSERT INTO `gaf_domains` (`id`, `height`, `card_grid`, `active`, `deck_id`)
VALUES
	('conf_admin',600,'grids/single',1,1),
	('home_super_admin',600,'grids/flot0',1,6);

/*!40000 ALTER TABLE `gaf_domains` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table gaf_menues
# ------------------------------------------------------------

DROP TABLE IF EXISTS `gaf_menues`;

CREATE TABLE `gaf_menues` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `parent` int(11) DEFAULT NULL,
  `label` varchar(256) NOT NULL DEFAULT '',
  `unlogged` tinyint(1) NOT NULL DEFAULT '0',
  `allowed` varchar(1024) DEFAULT NULL,
  `disallowed` varchar(1024) DEFAULT NULL,
  `page` varchar(256) DEFAULT NULL,
  `action` varchar(256) DEFAULT NULL,
  `url` varchar(256) DEFAULT NULL,
  `order` int(11) DEFAULT NULL,
  `active` tinyint(1) DEFAULT '1',
  `icon` varchar(128) DEFAULT NULL,
  `pin` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `gaf_menues` WRITE;
/*!40000 ALTER TABLE `gaf_menues` DISABLE KEYS */;

INSERT INTO `gaf_menues` (`id`, `parent`, `label`, `unlogged`, `allowed`, `disallowed`, `page`, `action`, `url`, `order`, `active`, `icon`, `pin`)
VALUES
	(1,NULL,'Root',0,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL),
	(2,1,'Home',0,NULL,NULL,NULL,'loginSuccess',NULL,10,1,'home',NULL),
	(3,1,'Configurator',0,'ROLE_SUPER_ADMIN',NULL,NULL,NULL,NULL,NULL,1,NULL,NULL),
	(4,3,'Configuration',0,'ROLE_SUPER_ADMIN',NULL,'conf_admin',NULL,NULL,NULL,1,NULL,NULL);

/*!40000 ALTER TABLE `gaf_menues` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table gaf_zone_cards
# ------------------------------------------------------------

DROP TABLE IF EXISTS `gaf_zone_cards`;

CREATE TABLE `gaf_zone_cards` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `idZone` int(11) unsigned NOT NULL,
  `cardname` varchar(128) COLLATE utf8_bin NOT NULL DEFAULT '0',
  `hidden` tinyint(4) DEFAULT NULL,
  `published` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;



# Dump of table gaf_zones
# ------------------------------------------------------------

DROP TABLE IF EXISTS `gaf_zones`;

CREATE TABLE `gaf_zones` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `idDomain` varchar(128) CHARACTER SET utf8 NOT NULL DEFAULT '',
  `name` varchar(128) CHARACTER SET utf8 NOT NULL DEFAULT '',
  `width` int(11) DEFAULT NULL,
  `height` int(11) DEFAULT NULL,
  `closed` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`,`idDomain`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;



# Dump of table members
# ------------------------------------------------------------

DROP TABLE IF EXISTS `members`;

CREATE TABLE `members` (
  `id` varchar(50) NOT NULL DEFAULT '',
  `username` varchar(50) NOT NULL DEFAULT '',
  `password` varchar(128) NOT NULL,
  `name` varchar(40) NOT NULL,
  `company` varchar(50) DEFAULT NULL,
  `phone` varchar(18) DEFAULT NULL,
  `email` varchar(254) DEFAULT NULL,
  `question` varchar(255) DEFAULT NULL,
  `question_answer` varchar(255) DEFAULT NULL,
  `expiration_Date` datetime DEFAULT NULL,
  `enabled` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `members` WRITE;
/*!40000 ALTER TABLE `members` DISABLE KEYS */;

INSERT INTO `members` (`id`, `username`, `password`, `name`, `company`, `phone`, `email`, `question`, `question_answer`, `expiration_Date`, `enabled`)
VALUES
	('admin','creator','creator','admin',NULL,NULL,NULL,NULL,NULL,'2050-01-31 00:00:00',1);

/*!40000 ALTER TABLE `members` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table members_attributes
# ------------------------------------------------------------

DROP TABLE IF EXISTS `members_attributes`;

CREATE TABLE `members_attributes` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `userid` varchar(50) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `value` text,
  PRIMARY KEY (`id`),
  KEY `userid` (`userid`),
  CONSTRAINT `members_attributes_ibfk_1` FOREIGN KEY (`userid`) REFERENCES `members` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table members_authorities
# ------------------------------------------------------------

DROP TABLE IF EXISTS `members_authorities`;

CREATE TABLE `members_authorities` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` varchar(50) NOT NULL,
  `authority` varchar(50) NOT NULL,
  `priority` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `userId` (`userId`,`authority`),
  CONSTRAINT `members_authorities_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `members` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `members_authorities` WRITE;
/*!40000 ALTER TABLE `members_authorities` DISABLE KEYS */;

INSERT INTO `members_authorities` (`id`, `userId`, `authority`, `priority`)
VALUES
	(1,'admin','ROLE_SUPER_ADMIN',100);

/*!40000 ALTER TABLE `members_authorities` ENABLE KEYS */;
UNLOCK TABLES;


