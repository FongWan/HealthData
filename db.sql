CREATE TABLE `admission` (
  `id` int(10) unsigned NOT NULL,
  `personId` int(10) unsigned NOT NULL,
  `admissionAt` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `admissionFrom` int(10) unsigned NOT NULL COMMENT 'Medic Person Id',
  `reason` text NOT NULL,
  `room` varchar(255) NOT NULL,
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `active` enum('0','1') NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
);
CREATE TABLE `appointment` (
  `datetime` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `toWho` int(10) unsigned NOT NULL,
  `fromWho` int(10) unsigned NOT NULL,
  `reason` text NOT NULL,
  `room` varchar(255) NOT NULL,
  `duration` int(10) unsigned NOT NULL,
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `active` enum('0','1') NOT NULL DEFAULT '1',
  PRIMARY KEY (`datetime`,`toWho`,`createdAt`)
);
CREATE TABLE `appointment_defaultroom` (
  `personId` int(10) unsigned NOT NULL,
  `defaultRoom` varchar(255) NOT NULL,
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`personId`)
);
CREATE TABLE `classification` (
  `id` int(10) unsigned NOT NULL,
  `classification` varchar(255) NOT NULL,
  `code` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
);
CREATE TABLE `classification_name` (
  `classificationId` int(10) unsigned NOT NULL,
  `name` varchar(255) NOT NULL,
  `language` char(2) NOT NULL
);
CREATE TABLE `discharge` (
  `id` int(11) NOT NULL,
  `admissionId` int(10) unsigned NOT NULL,
  `dischargeAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `dischargeFrom` int(10) unsigned NOT NULL,
  `dischargeStatus` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
);
CREATE TABLE `discharge_note` (
  `dischargeId` int(10) unsigned NOT NULL,
  `note` text NOT NULL,
  `classificationId` int(10) unsigned NOT NULL,
  `condition` text NOT NULL,
  `otherConditions` text NOT NULL,
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`dischargeId`,`createdAt`)
);
CREATE TABLE `group` (
  `id` int(10) unsigned NOT NULL,
  `name` varchar(255) NOT NULL,
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `active` enum('0','1') NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
);
CREATE TABLE `log_access_record` (
  `accessAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `userId` int(10) unsigned NOT NULL,
  `recordId` int(10) unsigned NOT NULL,
  PRIMARY KEY (`accessAt`,`userId`,`recordId`)
);
CREATE TABLE `log_access_user` (
  `accessAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `userId` int(10) unsigned NOT NULL,
  `leaveAt` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`accessAt`,`userId`)
);
CREATE TABLE `person` (
  `id` int(10) unsigned NOT NULL,
  `uuid` binary(16) NOT NULL,
  `externalId` varchar(100) NOT NULL,
  `birthdate` date NOT NULL,
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `active` enum('0','1') NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uuid` (`uuid`)
);
CREATE TABLE `person_contact` (
  `personId` int(10) unsigned NOT NULL,
  `type` enum('addr','phone','email','url') NOT NULL,
  `name` varchar(255) NOT NULL,
  `value` text NOT NULL,
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `active` enum('0','1') NOT NULL DEFAULT '1',
  PRIMARY KEY (`personId`,`createdAt`,`active`)
);
CREATE TABLE `person_group` (
  `personId` int(10) unsigned NOT NULL,
  `groupId` int(10) unsigned NOT NULL,
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `active` enum('0','1') NOT NULL DEFAULT '1',
  PRIMARY KEY (`personId`,`groupId`,`createdAt`)
);
CREATE TABLE `person_identity` (
  `personId` int(10) unsigned NOT NULL,
  `title` varchar(255) NOT NULL,
  `firstName` varchar(255) NOT NULL,
  `lastName` varchar(255) NOT NULL,
  `gender` enum('male','female') NOT NULL DEFAULT 'male',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`personId`,`createdAt`)
);
CREATE TABLE `person_role` (
  `personId` int(10) unsigned NOT NULL,
  `name` int(11) NOT NULL,
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `active` enum('0','1') NOT NULL DEFAULT '1',
  PRIMARY KEY (`personId`,`createdAt`)
);
CREATE TABLE `record` (
  `id` int(10) unsigned NOT NULL,
  `uuid` binary(16) NOT NULL,
  `externalId` varchar(10) NOT NULL,
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uuid` (`uuid`)
);
CREATE TABLE `record_note` (
  `id` int(10) unsigned NOT NULL,
  `recordId` int(10) unsigned NOT NULL,
  `type` enum('inpatient','outpatient','emergency') NOT NULL,
  PRIMARY KEY (`id`)
);
CREATE TABLE `record_note_content` (
  `noteId` int(10) unsigned NOT NULL,
  `reason` text NOT NULL,
  `subjective` text NOT NULL,
  `objective` text NOT NULL,
  `assessment` text NOT NULL,
  `plan` text NOT NULL,
  `createdBy` int(10) unsigned NOT NULL,
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`noteId`,`createdAt`,`createdBy`)
);
CREATE TABLE `record_person` (
  `recordId` int(10) unsigned NOT NULL,
  `personId` int(10) unsigned NOT NULL,
  PRIMARY KEY (`recordId`,`personId`)
);
CREATE TABLE `record_procedure` (
  `id` int(10) unsigned NOT NULL,
  `recordId` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`)
);
CREATE TABLE `record_procedure_content` (
  `procedureId` int(10) unsigned NOT NULL,
  `classificationId` int(10) unsigned NOT NULL,
  `participants` text NOT NULL,
  `procedureNote` text NOT NULL,
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`procedureId`,`createdAt`)
);
CREATE TABLE `record_vitalsign` (
  `recordId` int(10) unsigned NOT NULL,
  `type` enum('pulse','respiration','spo2','bp','temperature','weight','height') NOT NULL,
  `value` text NOT NULL,
  `createdBy` int(10) unsigned NOT NULL,
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`recordId`,`createdAt`,`createdBy`)
);
CREATE TABLE `session` (
  `id` int(10) unsigned NOT NULL,
  `userId` int(10) unsigned NOT NULL,
  `accessToken` binary(20) NOT NULL,
  `displayName` varchar(255) NOT NULL,
  `lastActivityTime` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  KEY `userId` (`userId`),
  KEY `accessToken` (`accessToken`)
);
CREATE TABLE `user` (
  `personId` int(10) unsigned NOT NULL,
  `username` varchar(60) NOT NULL,
  `password` varchar(64) NOT NULL,
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `active` enum('0','1') NOT NULL DEFAULT '1',
  PRIMARY KEY (`personId`)
);
