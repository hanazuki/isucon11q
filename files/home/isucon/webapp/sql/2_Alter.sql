ALTER TABLE `isu_condition` ADD COLUMN `level` varchar(255) DEFAULT NULL;
ALTER TABLE `isu_condition` ADD INDEX cond_uuid_level_timestamp (jia_isu_uuid, `level`, `timestamp`);
