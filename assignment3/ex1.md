# Information Systems - Schema Definition and Simple Queries

Use this markdown file to submit your prepared SQL statements for each problem.

*Fill in your names and student numbers below:*

```
Lazaros Kogioumtzidis - s4109651
Thijs Visee - s2982129
```

## Problem 1 - Schema Definition
```
PRAGMA foreign_keys = ON; -- Foreign key constrains

CREATE TABLE `loot_item` (
`name` TEXT UNIQUE PRIMARY KEY,
`rarity` REAL NOT NULL,
CHECK (rarity > 0 AND rarity < 1)
);
 
CREATE TABLE `participant` (
`id` INTEGER UNIQUE PRIMARY KEY,
`type` TEXT NOT NULL, -- Check if this is right for TEXT;
'rank' INTEGER NOT NULL,
CHECK (type IS 'player' OR type IS 'party') 
);
-- Check if this is right for this;

CREATE TABLE `game` (
`id` INTERGER UNIQUE PRIMARY KEY,
`started_at` TEXT, -- Check if this is right for this
`ended_at` TEXT -- Check if this is right for this
); 

CREATE TABLE `game_participants` (
`game_id` INTEGER NOT NULL,
`participant_id` INTEGER NOT NULL,
PRIMARY KEY (`participant_id`,`game_id`),
FOREIGN KEY (game_id) REFERENCES game(id) ON UPDATE CASCADE ON DELETE CASCADE,
FOREIGN KEY (participant_id) REFERENCES participant(id) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE `player` (
`username` TEXT PRIMARY KEY, --Check here
`joined_at` DATETIME,
`xp_level` INTEGER NOT NULL,--Check here
`participant_id` INTEGER NULL,
FOREIGN KEY (participant_id) REFERENCES participant(id) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE `game_result` (
`game_id` INTEGER PRIMARY KEY,
`winner_id` INTEGER NOT NULL,
`score` INTEGER NOT NULL,
FOREIGN KEY (game_id) REFERENCES game(id) ON UPDATE CASCADE ON DELETE CASCADE,
FOREIGN KEY (winner_id) REFERENCES participant(id) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE `player_items` (
`player_username` TEXT,
`item_name` TEXT,
`count` INTEGER NOT NULL
PRIMARY KEY (`player_username`,`item_name`),
FOREIGN KEY (player_username) REFERENCES player(username) ON UPDATE CASCADE ON DELETE CASCADE,
FOREIGN KEY (item_name) REFERENCES loot_item(name) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE `party` (
`id` INTEGER NOT NULL,
`created_by` TEXT,
`participant_id` INTEGER NULL,
PRIMARY KEY (`id`)
FOREIGN KEY (created_by) REFERENCES player(username) ON UPDATE CASCADE ON DELETE CASCADE,
FOREIGN KEY (participant_id) REFERENCES participant(id) ON UPDATE CASCADE ON DELETE CASCADE
);



CREATE TABLE `party_players` (
`party_id` INTEGER,
`player_username` TEXT,
`jointed_at` DATETIME,
`left_at` DATETIME,
PRIMARY KEY (`party_id`,`player_username`),
FOREIGN KEY (party_id) REFERENCES party(id) ON UPDATE CASCADE ON DELETE CASCADE,
FOREIGN KEY (player_username) REFERENCES player(username) ON UPDATE CASCADE ON DELETE CASCADE
);


CREATE TABLE `Report` (
`id` INTEGER PRIMARY KEY,
`sent_by` TEXT,
`sent_at` DATETIME,
`report_text` TEXT,
`is_read` TEXT,
`reported_player` TEXT,
FOREIGN KEY (sent_by) REFERENCES player(username) ON UPDATE CASCADE ON DELETE CASCADE,
FOREIGN KEY (reported_player) REFERENCES player(username) ON UPDATE CASCADE ON DELETE CASCADE
);











 
insert into game_participants (game_id,participant_id) VALUES ('60',43');

insert into game (id, started_at, ended_at) VALUES ('1','today','yesterday');
 insert into participant (id, type, rank) VALUES ('16','player','30');



 
```

## Problem 2 - Assorted Queries

```sqlite
-- 1.
-- Insert code here.

-- 2.
-- Insert code here.

-- 3.
-- Insert code here.

-- 4.
-- Insert code here.

-- 5.
-- Insert code here.
```

