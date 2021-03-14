# Information Systems - Advanced SQL


Lazaros Kogioumtzidis - s4109651


## Problem 1 - Grouping and Aggregates

-- 1.
SELECT COUNT(id) AS CustomerCount 
FROM customer 
WHERE region LIKE '%Europe' OR region = 'Scandinavia';

-- 2.
SELECT Region, Count(ID)
FROM Customer
GROUP BY Region
ORDER BY Region ASC;

-- 3.
SELECT SupplierId, AVG(`UnitPrice`), COUNT(`ID`)
FROM `Product`
WHERE `Discontinued` IS 0
GROUP BY `SupplierId`
HAVING COUNT(ID) > 2
ORDER BY `SupplierId`;

-- 4.
SELECT group_concat(`FirstName`), `Country`
FROM `Employee`
GROUP BY Country;


-- 5.
INSERT INTO CustomerDemographic(`Id`,`CustomerDesc`) SELECT `id`,printf("%s , %s , %s " ,`Customer`.`CompanyName`,`Customer`.`City`,`Customer`.`Country`)
FROM `Customer`
WHERE `fax` IS NOT NULL;


-- 6.
INSERT INTO CustomerDemographic(`Id`,`CustomerDesc`)
SELECT `id` ,printf("%s , %s , %s " ,`CompanyName`,`City`,`Country`)
FROM `Customer`
WHERE `fax` IS NOT NULL;

```

## Problem 2 - Joins

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



## Problem 3 - Assorted Queries

```sqlite
-- 1.
-- Insert code here.

-- 2.
-- Insert code here.

-- 3.
-- Insert code here.

-- 4.
-- Student Number: <INSERT STUDENT NUMBER>
-- Insert code here.
```

