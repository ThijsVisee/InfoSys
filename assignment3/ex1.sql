

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


PRAGMA foreign_keys = ON; -- Foreign key constrains

-- Loot Item Table (name, rarity)
CREATE TABLE `loot_items` (
  `name` TEXT UNIQUE PRIMARY KEY,
  `rarity` REAL NOT NULL,
  CHECK (0 < `rarity` AND `rarity` < 1)
);
 
-- Participant Table (id, type, rank)
CREATE TABLE `participants` (
  `id` INTEGER PRIMARY KEY AUTOINCREMENT,
  `type` TEXT NOT NULL,
  `rank` INTEGER NOT NULL DEFAULT 0,
  CHECK (`type` IS 'player' OR `type` IS 'party') 
);

-- Game Table (id, started_at, ended_at)
CREATE TABLE `games` (
  `id` INTEGER PRIMARY KEY AUTOINCREMENT,
  `started_at` TEXT NOT NULL DEFAULT
      (strftime('%Y-%m-%dT%H:%M:%S', 'now')),
  `ended_at` TEXT NULL DEFAULT NULL
); 
-- Assumption above: End time of game unknown when entered

-- Game participant table (game_id, participant_id)
CREATE TABLE `game_participants` (
  `game_id` INTEGER NOT NULL,
  `participant_id` INTEGER NOT NULL,
  PRIMARY KEY (`participant_id`,`game_id`),
  FOREIGN KEY (`game_id`) REFERENCES `games`(`id`)
      ON UPDATE CASCADE
      ON DELETE CASCADE,
  FOREIGN KEY (`participant_id`) REFERENCES `participants`(`id`)
      ON UPDATE CASCADE
      ON DELETE CASCADE
);

-- Player table (username, joined_at, xp_level, participant_id)
CREATE TABLE `players` (
  `username` TEXT PRIMARY KEY,
  `joined_at` TEXT NOT NULL DEFAULT
      (strftime('%Y-%m-%dT%H:%M:%S', 'now')),
  `xp_level` INTEGER NOT NULL DEFAULT 0,
  `participant_id` INTEGER NULL DEFAULT NULL,
  FOREIGN KEY (`participant_id`) REFERENCES `participants`(`id`)
      ON UPDATE CASCADE
      ON DELETE CASCADE
);

-- Game result table (game_id, winner_id, score)
CREATE TABLE `game_results` (
  `game_id` INTEGER PRIMARY KEY AUTOINCREMENT,
  `winner_id` INTEGER NOT NULL,
  `score` INTEGER NOT NULL DEFAULT 0,
  FOREIGN KEY (`game_id`) REFERENCES `games`(`id`)
      ON UPDATE CASCADE
      ON DELETE CASCADE,
  FOREIGN KEY (`winner_id`) REFERENCES `participants`(`id`)
      ON UPDATE CASCADE
      ON DELETE CASCADE
);
/*
  Assumption: Winner ID cannot be null, as results are already in.
  Assumption: Score cannot be null, as results are already in.
  Also, no draws are possible.
*/

-- Player Item table (player_username, item_name, count)
CREATE TABLE `player_items` (
  `player_username` TEXT NOT NULL,
  `item_name` TEXT NOT NULL,
  `count` INTEGER NOT NULL, 
  PRIMARY KEY (`player_username`,`item_name`),
  FOREIGN KEY (`player_username`) REFERENCES `players`(`username`) 
      ON UPDATE CASCADE
      ON DELETE CASCADE,
  FOREIGN KEY (`item_name`) REFERENCES `loot_items`(`name`)
      ON UPDATE CASCADE
      ON DELETE CASCADE
);

-- Party table (id, created_by, participant_id)
CREATE TABLE `parties` (
  `id` INTEGER PRIMARY KEY AUTOINCREMENT,
  `created_by` TEXT NOT NULL,
  `participant_id` INTEGER NULL DEFAULT NULL,
  FOREIGN KEY (`created_by`) REFERENCES `players`(`username`)
      ON UPDATE CASCADE
      ON DELETE CASCADE,
  FOREIGN KEY (`participant_id`) REFERENCES `participants`(`id`)
      ON UPDATE CASCADE
      ON DELETE CASCADE
);

-- Party players table (party_id, player_username, joined_at, left_at)
CREATE TABLE `party_players` (
  `party_id` INTEGER NOT NULL,
  `player_username` TEXT NOT NULL,
  `joined_at` TEXT DEFAULT
      (strftime('%Y-%m-%dT%H:%M:%S', 'now')), 
  `left_at` TEXT NULL DEFAULT NULL,
  PRIMARY KEY (`party_id`,`player_username`),
  FOREIGN KEY (`party_id`) REFERENCES `parties`(`id`)
      ON UPDATE CASCADE
      ON DELETE CASCADE,
  FOREIGN KEY (`player_username`) REFERENCES `players`(`username`)
      ON UPDATE CASCADE
      ON DELETE CASCADE
);

-- Report table (id, sent_by, sent_at, report_txt, is_read, reported_player)
CREATE TABLE `reports` (
  `id` INTEGER PRIMARY KEY AUTOINCREMENT,
  `sent_by` TEXT NOT NULL,
  `sent_at` TEXT NOT NULL DEFAULT 
      (strftime('%Y-%m-%dT%H:%M:%S', 'now')), 
  `report_text` TEXT NOT NULL,
  `is_read` TEXT NOT NULL DEFAULT 'No',
  `reported_player` TEXT NOT NULL,
  FOREIGN KEY (`sent_by`) REFERENCES `players`(`username`)
      ON UPDATE CASCADE
      ON DELETE CASCADE,
  FOREIGN KEY (`reported_player`) REFERENCES `players`(`username`) 
      ON UPDATE CASCADE
      ON DELETE CASCADE,
  CHECK (`is_read` IS 'No' 
      OR `is_read` IS 'Yes'
      OR `is_read` IS 'In Progress') 
);
/*
  Assumption: All information is essential and all columns must have values.
  Assumption: a report is not read when submitted, updated to 'In Progress'
  when it is being read, and updated to 'Yes' when it is fully handled.
*/

