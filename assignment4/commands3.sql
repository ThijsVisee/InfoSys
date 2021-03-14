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