ALTER TABLE `isu_condition` ADD COLUMN `level` varchar(255) DEFAULT NULL;
-- ALTER TABLE `isu_condition` ADD INDEX cond_uuid_level_timestamp (jia_isu_uuid, `level`, `timestamp`);

ALTER TABLE `isu_condition`
  ADD COLUMN `is_dirty` tinyint AS (INSTR(`condition`, 'is_dirty=true') > 0) PERSISTENT,
  ADD COLUMN `is_overweight` tinyint AS (INSTR(`condition`, 'is_overweight=true') > 0) PERSISTENT,
  ADD COLUMN `is_broken` tinyint AS (INSTR(`condition`, 'is_broken=true') > 0) PERSISTENT,
  ADD COLUMN `score` tinyint AS (
    CASE `is_dirty` + `is_overweight` + `is_broken`
    WHEN 0 THEN 3
    WHEN 1 THEN 2
    WHEN 2 THEN 2
    WHEN 3 THEN 1
    END);


ALTER TABLE `isu_condition` ADD COLUMN `neg_timestamp` BIGINT AS  (-UNIX_TIMESTAMP(`timestamp`)) PERSISTENT,
  ADD INDEX cond_uuid_timestamp_desc (jia_isu_uuid, `neg_timestamp`);


ALTER TABLE `isu` DROP COLUMN `created_at`, DROP COLUMN `updated_at`;
ALTER TABLE `isu_condition` DROP COLUMN `created_at`;
ALTER TABLE `user` DROP COLUMN `created_at`;
