-- Problem 2 - Assorted Queries

-- 2.1 - Assuming later creation means higher `created_at` value
-- Select all users ordered by the date at which they joined, new first
SELECT *
FROM `users`
ORDER BY `users`.`created_at` DESC;

-- Select only the newest user
SELECT MAX(`created_at`)
FROM `users`;

-- 2.2 TODO: Change my name and email to your name and email
-- on one of the following lines
INSERT INTO `users` (`name`, `email`) VALUES 
('Thijs Visee', 't.p.visee@student.rug.nl'),
('Lazaros', 't.p.visee@student.rug.nl');

-- 2.3