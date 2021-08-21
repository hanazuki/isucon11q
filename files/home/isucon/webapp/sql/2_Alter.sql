ALTER TABLE `isu_condition` ADD COLUMN `level` varchar(255) DEFAULT NULL;
-- ALTER TABLE `isu_condition` ADD INDEX cond_uuid_level_timestamp (jia_isu_uuid, `level`, `timestamp`);

ALTER TABLE `isu` DROP COLUMN `created_at`, DROP COLUMN `updated_at`;
ALTER TABLE `isu_condition` DROP COLUMN `created_at`;
ALTER TABLE `user` DROP COLUMN `created_at`;
