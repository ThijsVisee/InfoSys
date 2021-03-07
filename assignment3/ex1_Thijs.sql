-- Drop tables beforehand.
DROP TABLE IF EXISTS `reports`;
DROP TABLE IF EXISTS `players`;
DROP TABLE IF EXISTS `games`;
DROP TABLE IF EXISTS `participants`;
DROP TABLE IF EXISTS `game_participants`;
DROP TABLE IF EXISTS `party_players`;
DROP TABLE IF EXISTS `parties`;
DROP TABLE IF EXISTS `player_items`;
DROP TABLE IF EXISTS `loot_items`;
DROP TABLE IF EXISTS `game_results`;

-- Player
CREATE TABLE `players` (
  `username` TEXT PRIMARY KEY UNIQUE,
	`joined at` TEXT NOT NULL DEFAULT (strftime('%Y-%m-%dT%H:%M:%S', 'now')),
  `xp_level` INTEGER DEFAULT 0,
  `participant_id` FOREIGN KEY NULL DEFAULT NULL
);