CREATE DATABASE `buspassdb` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
CREATE TABLE `category` (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(256) DEFAULT NULL,
  `createdOn` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
CREATE TABLE `classifieds` (
  `id` int NOT NULL AUTO_INCREMENT,
  `category_id` int DEFAULT NULL,
  `user_id` int DEFAULT NULL,
  `status` int DEFAULT '0',
  `headline` varchar(100) DEFAULT NULL,
  `product_name` varchar(50) DEFAULT NULL,
  `brand` varchar(25) DEFAULT NULL,
  `product_condition` varchar(256) DEFAULT NULL,
  `description` varchar(500) DEFAULT NULL,
  `price` int DEFAULT NULL,
  `recurrence` int DEFAULT '0',
  `pictures` varchar(500) DEFAULT NULL,
  `lastUpdatedOn` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `category_id` (`category_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `classifieds_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `category` (`id`),
  CONSTRAINT `classifieds_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
CREATE TABLE `route` (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(256) DEFAULT NULL,
  `description` varchar(256) DEFAULT NULL,
  `adminId` int DEFAULT NULL,
  `createdOn` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `adminId` (`adminId`),
  CONSTRAINT `route_ibfk_1` FOREIGN KEY (`adminId`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
CREATE TABLE `stop` (
  `id` int NOT NULL AUTO_INCREMENT,
  `address` varchar(256) DEFAULT NULL,
  `sequenceOrder` int DEFAULT NULL,
  `routeId` int DEFAULT NULL,
  `adminId` int DEFAULT NULL,
  `createdOn` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `routeId` (`routeId`),
  KEY `adminId` (`adminId`),
  CONSTRAINT `stop_ibfk_1` FOREIGN KEY (`routeId`) REFERENCES `route` (`id`),
  CONSTRAINT `stop_ibfk_2` FOREIGN KEY (`adminId`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
CREATE TABLE `user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(256) DEFAULT NULL,
  `phone` varchar(256) DEFAULT NULL,
  `email` varchar(256) NOT NULL,
  `password` varchar(256) DEFAULT NULL,
  `address` varchar(256) DEFAULT NULL,
  `department` varchar(256) DEFAULT NULL,
  `type` int NOT NULL,
  `createdOn` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
CREATE TABLE `vehicle` (
  `id` int NOT NULL AUTO_INCREMENT,
  `registrationNumber` varchar(256) DEFAULT NULL,
  `totalSeats` int DEFAULT NULL,
  `filledSeats` int DEFAULT NULL,
  `routeId` int DEFAULT NULL,
  `type` int DEFAULT NULL,
  `vehicleStatus` int DEFAULT NULL,
  `startPickUpTime` varchar(256) DEFAULT NULL,
  `startDropOffTime` varchar(256) DEFAULT NULL,
  `adminId` int DEFAULT NULL,
  `driverID` int DEFAULT NULL,
  `createdOn` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `routeId` (`routeId`),
  KEY `adminId` (`adminId`),
  KEY `driverID` (`driverID`),
  CONSTRAINT `vehicle_ibfk_1` FOREIGN KEY (`routeId`) REFERENCES `route` (`id`),
  CONSTRAINT `vehicle_ibfk_2` FOREIGN KEY (`adminId`) REFERENCES `user` (`id`),
  CONSTRAINT `vehicle_ibfk_3` FOREIGN KEY (`driverID`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
