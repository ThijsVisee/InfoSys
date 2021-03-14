/*
--1
SELECT COUNT(id) AS CustomerCount 
FROM customer 
WHERE region LIKE '%Europe';

--2
SELECT `Region`, Count(ID)
FROM `Customer`
GROUP BY `Region`
ORDER BY `Region` ASC;

-- 3
SELECT SupplierId, AVG(`UnitPrice`), COUNT(ID)
FROM `Product`
WHERE `Discontinued` IS 0
GROUP BY `SupplierId`
HAVING COUNT(ID) > 2
ORDER BY `SupplierId`;

--

--5 
