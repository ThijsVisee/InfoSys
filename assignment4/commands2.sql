-- 2.1
/*
SELECT printf("%s %s ", `e`.`firstname`, `e`.`lastname`) AS 'Supervisee',
       printf("%s %s ", `m`.`firstname`, `m`.`lastname`) AS 'Supervisor' 
FROM `Employee` `e`
LEFT JOIN `Employee` `m` ON `m`.`id` = `e`.`reportsto`;
*/ 

-- 2.2 We interpreted the exercise as select only the information
--     about the product itself. This is why we left out the information
--	   belonging to the order.
/*
SELECT `p`.*
FROM `OrderDetail` `o`
INNER JOIN `Product` `p` ON `o`.`OrderId`   = 10272
						AND `o`.`ProductId` = `p`.`Id`
ORDER BY `p`.`ProductName` ASC;
*/
			
-- 2.3
/*
SELECT `s`.`CompanyName`
FROM `Order` o
LEFT JOIN `Shipper` `s` ON `o`.`ShipVia` = `s`.`id`
GROUP BY `o`.`ShipVia`
ORDER BY count(`s`.`id`) DESC
LIMIT 1;
*/

-- 3.4
/*
SELECT `s`.`City`, `s`.`Country`, `p`.*
FROM `Product` `p`
INNER JOIN `Supplier` `s` ON `p`.`SupplierId` = `s`.`id`
						AND `s`.`Fax` IS NOT NULL;
*/

-- 3.5 
SELECT group_concat(`p`.`ProductName`, ", "), `c`.`CompanyName`
INNER JOIN