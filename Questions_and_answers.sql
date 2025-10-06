--1. Select the names of all the products in the store.
SELECT * FROM Products
/*2. Select the names and the prices of all the products in the store.*/
SELECT name , price FROM Products
/*3. Select the name of the products with a price less than or equal to $200.*/
SELECT Price FROM Products
WHERE Price <200
/*4. Select all the products with a price between $60 and $120.
*/
SELECT * 
FROM Products
WHERE Price BETWEEN 60 AND 120 
/* 5. Select the name and price in cents (i.e., the price must be multiplied by 100).
*/
SELECT Price * 100 AS [Price in cents] ,[Name]
FROM Products
/* 6. Compute the average price of all the products.
*/
SELECT AVG(Price) as [Avg_price]
FROM Products
/*7. Compute the average price of all products with manufacturer code equal to 2.*/
SELECT AVG(Price) as [Avg_price]
FROM Products
WHERE Code= 2
/*8. Compute the number of products with a price larger than or equal to $180.
*/
SELECT COUNT(*) AS [#Products>=180]
FROM Products
WHERE Price >=180
/* 9. Select the name and price of all products with a price larger than or equal to $180, and sort first by price (in descending order), and then by name (in ascending order).
*/
SELECT [Name] , Price
FROM Products
WHERE Price >=180
ORDER BY Price DESC , [Name] 
/*10. Select all the data from the products, including all the data for each product's manufacturer.*/
SELECT *
FROM Products P
JOIN Manufacturers M
ON P.Manufacturer = M.Code
/* 11. Select the product name, price, and manufacturer name of all the products.
*/
SELECT P.Name [Product Name]  , p.Price , m.Name [Manufacturer] 
FROM Products P
JOIN Manufacturers M
ON P.Manufacturer = M.Code
/* 12. Select the average price of each manufacturer's products, showing only the manufacturer's code.
*/
SELECT Manufacturer ,AVG(Price) AS [Average Price]
FROM Products
GROUP BY Manufacturer
/* 13. Select the average price of each manufacturer's products, showing the manufacturer's name.
*/
SELECT Manufacturer,M.[Name] AS [Manufacturer Name],AVG(Price) AS [Average Price]
FROM Products P
JOIN Manufacturers M
ON P.Manufacturer = M.Code
GROUP BY Manufacturer,M.[Name]
/* 14. Select the names of manufacturer whose products have an average price larger than or equal to $150.
*/
SELECT Manufacturer,M.[Name] AS [Manufacturer Name],AVG(Price) AS [Average Price]
FROM Products P
JOIN Manufacturers M
ON P.Manufacturer = M.Code
GROUP BY Manufacturer,M.[Name]
HAVING AVG(Price) >= 150
/* 15. Select the name and price of the cheapest product.
*/
SELECT p.[Name] , p.Price
FROM Products p
WHERE P.Price IN (SELECT MIN(Price) FROM Products)
--OR
SELECT TOP(1)p.[Name] , p.Price
FROM Products p
ORDER BY Price 
----
/*16. Select the name of each manufacturer along with the name and price of its most expensive product.*/
SELECT [pname], Price,[Mname]
FROM (SELECT M.Name as [Mname] , P.Name as [pname]  , P.Price ,
DENSE_RANK() OVER(Partition BY m.code ORDER BY Price DESC )
AS DR
FROM Products p
JOIN Manufacturers m
ON p.Manufacturer = m.Code) as t
WHERE DR = 1
--or
SELECT P.Name ,M.Name , Price 
FROM Products p 
JOIN Manufacturers m
ON p.Manufacturer = m.Code
AND P.Price in (
	SELECT MAX(Price)
	FROM Products p1
	WHERE m.code = p1.Manufacturer
)
/*17. Select the name of each manufacturer which have an average price above $145 and contain at least 2 different products.
*/
SELECT m.[Name]
FROM Products p
JOIN Manufacturers m
ON p.Manufacturer = m.Code
AND 145 <(SELECT AVG(price) from Products p
where p.Manufacturer = m.Code)
GROUP BY m.[Name]
HAVING count(*)>=2
--or
SELECT [Name]
FROM (SELECT m.[Name],AVG(Price) over(partition by m.[Name]) as avg_per_group,
COUNT(*) OVER(partition by m.[Name]) as [produts_count]
FROM Products p
JOIN Manufacturers m 
ON p.Manufacturer = m.Code) p
WHERE avg_per_group > 145
AND produts_count >=2
/* 18. Add a new product: Loudspeakers, $70, manufacturer 2.*/
INSERT INTO Products VALUES(11,'Loudspeakers',70,2)
/*19. Update the name of product 8 to "Laser Printer".*/
UPDATE Products
SET Name = 'Laser Printer'
WHERE Code = 8
/*20. Apply a 10% discount to all products.
*/
SELECT * , Price*1.1 AS [Discount 10%]
from Products
/* 21. Apply a 10% discount to all products with a price larger than or equal to $120.
*/
SELECT * , Price*1.1 AS [Discount 10%]
from Products
WHERE Price >=120
