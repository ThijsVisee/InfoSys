# Information Systems - Advanced SQL


Lazaros Kogioumtzidis - s4109651
Thijs Visee - S2982129


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

```
    -- 2.1
    SELECT printf("%s %s ", `e`.`firstname`, `e`.`lastname`) AS 'Supervisee',
          printf("%s %s ", `m`.`firstname`, `m`.`lastname`) AS 'Supervisor' 
    FROM `Employee` `e`
    LEFT JOIN `Employee` `m` ON `m`.`id` = `e`.`reportsto`;

    -- 2.2 We interpreted the exercise as select only the information
    --     about the product itself. This is why we left out the information
    --	   belonging to the order.
    SELECT `p`.*
    FROM `OrderDetail` `o`
    INNER JOIN `Product` `p` ON `o`.`OrderId`   = 10272
                AND `o`.`ProductId` = `p`.`Id`
    ORDER BY `p`.`ProductName` ASC;
          
    -- 2.3
    SELECT `s`.`CompanyName`
    FROM `Order` `o`
    LEFT JOIN `Shipper` `s` ON `o`.`ShipVia` = `s`.`id`
    GROUP BY `o`.`ShipVia`
    ORDER BY count(`s`.`id`) DESC
    LIMIT 1;

    -- 2.4
    SELECT `s`.`City`, `s`.`Country`, `p`.*
    FROM `Product` `p`
    INNER JOIN `Supplier` `s` ON `p`.`SupplierId` = `s`.`id`
                AND `s`.`Fax` IS NOT NULL;

    -- 2.5 
    SELECT `c`.`CompanyName`, group_concat(`p`.`ProductName`, ", ")
    FROM `Customer` `c`
    INNER JOIN `Order` `o` ON `c`.`id` = `o`.`CustomerId`
    INNER JOIN `OrderDetail` `od` ON `o`.`id` = `od`.`OrderId`
    INNER JOIN `Product` `p` ON `od`.`ProductId` = `p`.`id`
    GROUP BY `c`.`id`
    ORDER BY `c`.`CompanyName` ASC;
```



## Problem 3 - Assorted Queries

```
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
```

