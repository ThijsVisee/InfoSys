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
SELECT `s`.`CompanyName`, count(`s`.`id`)
FROM `Order` o
INNER JOIN `Shipper` `s` ON `o`.`ShipVia` = `s`.`id`
GROUP BY `s`.`id`;
