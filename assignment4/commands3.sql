-- 3.1
SELECT *
FROM `Product`
WHERE `Id` IN
(
	SELECT `ProductId`
	FROM `OrderDetail`
	WHERE `OrderId` = 10256
	   OR `OrderId` = 10746
	   OR `OrderId` = 11077
);

-- 3.2
SELECT `FirstName`, `LastName`
FROM `Employee`
WHERE `id` IN
(
	SELECT `EmployeeId`
	FROM `Order`
	GROUP BY `EmployeeId`
	ORDER BY count(`EmployeeID`) DESC
	LIMIT 5
);

-- 3.3
SELECT `p`.`total_value`, `o`.*
FROM
(
	SELECT `OrderId`, sum(`UnitPrice` * `Quantity` * (1 - `Discount`)) as total_value
	FROM `OrderDetail`
	GROUP BY `OrderId`
	HAVING sum(`UnitPrice` * `Quantity` * (1 - `Discount`)) > 1000
) `p`
INNER JOIN `Order` `o` ON `o`.`id` = `p`.`OrderId`
ORDER BY `p`.`total_value` DESC;

-- 3.4 digit = 9
SELECT `ShipPostalCode`, *
FROM `Order` 
WHERE `CustomerId` IN
(
	SELECT `id`
	FROM `Customer`
	WHERE `PostalCode` LIKE "%9"
);