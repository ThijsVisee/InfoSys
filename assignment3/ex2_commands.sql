-- 2.1
-- Select all users
SELECT *
FROM `users`
ORDER BY `users`.`created_at` DESC; 

-- Select only the newest user
SELECT `id`, `name`, `email`, MAX(`created_at`) FROM `users`;

-- 2.2 TODO: enter your name and email
INSERT INTO `users` (`name`, `email`) VALUES 
('Thijs Visee', 't.p.visee@student.rug.nl'),
('Lazaros', 'email');
SELECT *
FROM `users`
ORDER BY `users`.`created_at` DESC; 

-- 2.3 TODO


-- 2.4
SELECT `name`, `email`
FROM `users`
WHERE `users`.`email` LIKE '%.com'
ORDER BY `users`.`email` ASC


-- 2.5
-- Rename "Bench Press" exercise to "Barbell Bench Press"
UPDATE `exercises`
SET `name` = 'Barbell Bench Press'
WHERE `name` LIKE 'Bench Press';
-- Delete user JOE MAMMA
DELETE FROM `users`
WHERE `name` LIKE 'JOE MAMMA';

SELECT * FROM `users`;