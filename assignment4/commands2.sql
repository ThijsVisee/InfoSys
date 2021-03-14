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
