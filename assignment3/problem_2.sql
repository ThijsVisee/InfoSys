-- Drop tables beforehand.
DROP TABLE IF EXISTS `workout_exercises`;
DROP TABLE IF EXISTS `exercise_metrics`;
DROP TABLE IF EXISTS `exercises`;
DROP TABLE IF EXISTS `workouts`;
DROP TABLE IF EXISTS `users`;

-- Make sure foreign key constraints are enforced.
PRAGMA foreign_keys = ON;

CREATE TABLE `users` (
	`id` INTEGER PRIMARY KEY AUTOINCREMENT,
	`name` TEXT NOT NULL,
	`email` TEXT NOT NULL UNIQUE,
	`created_at` TEXT NOT NULL DEFAULT (strftime('%Y-%m-%dT%H:%M:%S', 'now'))
);

CREATE TABLE `workouts` (
	`id` INTEGER PRIMARY KEY AUTOINCREMENT,
	`created_at` TEXT NOT NULL DEFAULT (strftime('%Y-%m-%dT%H:%M:%S', 'now')),
	`user_id` INTEGER NOT NULL,
	FOREIGN KEY (`user_id`) REFERENCES `users`(`id`)
		ON UPDATE CASCADE
		ON DELETE CASCADE
);

CREATE TABLE `exercises` (
	`name` TEXT PRIMARY KEY
);

CREATE TABLE `exercise_metrics` (
	`id` INTEGER PRIMARY KEY AUTOINCREMENT,
	`duration` INTEGER NULL DEFAULT NULL,
	`repetitions` INTEGER NULL DEFAULT NULL,
	`weight` REAL NULL DEFAULT NULL,
	CHECK (
		`duration` IS NOT NULL
		OR `repetitions` IS NOT NULL
		OR `weight` IS NOT NULL
	)
);

CREATE TABLE `workout_exercises` (
	`workout_id` INTEGER NOT NULL,
	`exercise_name` TEXT NOT NULL,
	`exercise_metric_id` INTEGER NOT NULL,
	`created_at` TEXT NOT NULL DEFAULT (strftime('%Y-%m-%dT%H:%M:%S', 'now')),
	PRIMARY KEY (`workout_id`, `exercise_name`, `exercise_metric_id`),
	FOREIGN KEY (`workout_id`) REFERENCES `workouts`(`id`)
		ON UPDATE CASCADE
		ON DELETE CASCADE,
	FOREIGN KEY (`exercise_name`) REFERENCES `exercises`(`name`)
		ON UPDATE CASCADE
		ON DELETE CASCADE,
	FOREIGN KEY (`exercise_metric_id`) REFERENCES `exercise_metrics`(`id`)
		ON UPDATE CASCADE
		ON DELETE CASCADE
);

-- Data insertion.
INSERT INTO `users` (`name`, `email`, `created_at`) VALUES
('Andrew Lalis', 'a.lalis@student.rug.nl', '2018-05-24T12:35:41'),
('Joe Mamma', 'joe.mamma@protonmail.com', '2020-11-02T19:01:55'),
('Ronnie Coleman', 'r.coleman@bodybuilding.com', '2021-07-30T05:21:00'),
('Hafthor Bjornsson', 'themountain@gmail.com', '2016-02-28T19:44:30');


INSERT INTO `exercises` (`name`) VALUES
('Deadlift'),
('Bench Press'),
('Pull Up'),
('Squat'),
('Overhead Press'),
('Running');

-- Insert a sample workout with a few exercises.
INSERT INTO `workouts` (`user_id`)
SELECT `users`.`id`
FROM `users`
WHERE `users`.`name` = 'Andrew Lalis';

INSERT INTO `exercise_metrics` (`duration`, `repetitions`, `weight`) VALUES
(300, NULL, NULL);
INSERT INTO `workout_exercises` (`workout_id`, `exercise_name`, `exercise_metric_id`) VALUES
(
	(SELECT MAX(`id`) FROM `workouts`),
	'Running',
	(SELECT MAX(`id`) FROM `exercise_metrics`)
);

INSERT INTO `exercise_metrics` (`duration`, `repetitions`, `weight`) VALUES
(NULL, 8, 122.5);
INSERT INTO `workout_exercises` (`workout_id`, `exercise_name`, `exercise_metric_id`) VALUES
(
	(SELECT MAX(`id`) FROM `workouts`),
	'Bench Press',
	(SELECT MAX(`id`) FROM `exercise_metrics`)
);

INSERT INTO `exercise_metrics` (`duration`, `repetitions`, `weight`) VALUES
(NULL, 5, 120);
INSERT INTO `workout_exercises` (`workout_id`, `exercise_name`, `exercise_metric_id`) VALUES
(
	(SELECT MAX(`id`) FROM `workouts`),
	'Bench Press',
	(SELECT MAX(`id`) FROM `exercise_metrics`)
);

INSERT INTO `exercise_metrics` (`duration`, `repetitions`, `weight`) VALUES
(NULL, 12, 80);
INSERT INTO `workout_exercises` (`workout_id`, `exercise_name`, `exercise_metric_id`) VALUES
(
	(SELECT MAX(`id`) FROM `workouts`),
	'Squat',
	(SELECT MAX(`id`) FROM `exercise_metrics`)
);

-- 2.1
-- Select all users
SELECT *
FROM `users`
ORDER BY `users`.`created_at` DESC; 

-- Select only the newest user
SELECT`id`, `name`, `email`, MAX(`created_at`) FROM `users`;

-- 2.2 TODO: enter your email
INSERT INTO `users` (`name`, `email`) VALUES 
('Thijs Visee', 't.p.visee@student.rug.nl'),
('Lazaros Kogioumtzidis', 'email');

-- 2.3
-- Add a workout
INSERT INTO `workouts` (`user_id`)
SELECT `users`.`id`
FROM `users`
WHERE `users`.`name` = 'Thijs Visee';

-- Add at least 2 exercises to the workout
INSERT INTO `exercise_metrics` (`duration`, `repetitions`, `weight`) VALUES
(NULL, 10, 2);
INSERT INTO `workout_exercises` (`workout_id`, `exercise_name`, `exercise_metric_id`) VALUES
(
	(SELECT MAX(`id`) FROM `workouts`),
	'Deadlift',
	(SELECT MAX(`id`) FROM `exercise_metrics`)
);

INSERT INTO `exercise_metrics` (`duration`, `repetitions`, `weight`) VALUES
(NULL, 24, NULL);
INSERT INTO `workout_exercises` (`workout_id`, `exercise_name`, `exercise_metric_id`) VALUES
(
	(SELECT MAX(`id`) FROM `workouts`),
	'Squat',
	(SELECT MAX(`id`) FROM `exercise_metrics`)
);

INSERT INTO `exercise_metrics` (`duration`, `repetitions`, `weight`) VALUES
(NULL, 24, NULL);
INSERT INTO `workout_exercises` (`workout_id`, `exercise_name`, `exercise_metric_id`) VALUES
(
	(SELECT MAX(`id`) FROM `workouts`),
	'Pull Up',
	(SELECT MAX(`id`) FROM `exercise_metrics`)
);

-- Also for Partner
INSERT INTO `workouts` (`user_id`)
SELECT `users`.`id`
FROM `users`
WHERE `users`.`name` = 'Lazaros Kogioumtzidis';

-- Add at least 2 exercises once again
INSERT INTO `exercise_metrics` (`duration`, `repetitions`, `weight`) VALUES
(NULL, 50, 60);
INSERT INTO `workout_exercises` (`workout_id`, `exercise_name`, `exercise_metric_id`) VALUES
(
	(SELECT MAX(`id`) FROM `workouts`),
	'Bench Press',
	(SELECT MAX(`id`) FROM `exercise_metrics`)
);

INSERT INTO `exercise_metrics` (`duration`, `repetitions`, `weight`) VALUES
(NULL, 24, 80);
INSERT INTO `workout_exercises` (`workout_id`, `exercise_name`, `exercise_metric_id`) VALUES
(
	(SELECT MAX(`id`) FROM `workouts`),
	'Overhead Press',
	(SELECT MAX(`id`) FROM `exercise_metrics`)
);

INSERT INTO `exercise_metrics` (`duration`, `repetitions`, `weight`) VALUES
(30, NULL, NULL);
INSERT INTO `workout_exercises` (`workout_id`, `exercise_name`, `exercise_metric_id`) VALUES
(
	(SELECT MAX(`id`) FROM `workouts`),
	'Running',
	(SELECT MAX(`id`) FROM `exercise_metrics`)
);

-- 2.4
SELECT `name`, `email`
FROM `users`
WHERE `users`.`email` LIKE '%.com'
ORDER BY `users`.`email` ASC;


-- 2.5
-- Rename "Bench Press" exercise to "Barbell Bench Press"
UPDATE `exercises`
SET `name` = 'Barbell Bench Press'
WHERE `name` LIKE 'Bench Press';

-- Delete user JOE MAMMA
DELETE FROM `users`
WHERE `users`.`name` = 'Joe Mamma';
