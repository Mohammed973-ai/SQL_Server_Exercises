--
/*1. Select all warehouses.*/
SELECT * FROM Warehouses
/*2. Select all boxes with a value larger than $150.
*/
SELECT * FROM Boxes 
WHERE Value >150
--3. Select all distinct contents in all the boxes.

SELECT DISTINCT Contents FROM Boxes

--4. Select the average value of all the boxes.
SELECT AVG(Value)
FROM Boxes
--5. Select the warehouse code and the average value of the boxes in each warehouse.

SELECT Warehouse , AVG(Value)
FROM Boxes
GROUP BY Warehouse

/*6. Same as previous exercise, but select only those warehouses where the average value of the boxes is greater than 150.*/
SELECT Warehouse , AVG(Value)
FROM Boxes
GROUP BY Warehouse
HAVING AVG(Value) >150

/*7. Select the code of each box, along with the name of the city the box is located in.*/
SELECT b.Code , w.Location
FROM Boxes b
JOIN Warehouses w
ON b.Warehouse = w.Code
/*8. Select the warehouse codes, along with the number of boxes in each warehouse. Optionally, take into account that some warehouses are empty (i.e., the box count should show up as zero, instead of omitting the warehouse from the result).*/

SELECT w.Code,COUNT(*) 
FROM Boxes b
RIGHT JOIN Warehouses w
ON w.Code = b.Warehouse
GROUP BY w.Code
/*9. Select the codes of all warehouses that are saturated (a warehouse is saturated if the number of boxes in it is larger than the warehouse's capacity).
*/
SELECT Code
FROM Warehouses w
WHERE CAPACITY<
(SELECT COUNT(*) 
FROM Boxes b
WHERE b.Warehouse = w.Code)
--OR
SELECT  w.Code , CAPACITY
FROM Boxes b
JOIN Warehouses w
ON b.Warehouse = w.Code
GROUP BY w.Code , CAPACITY
HAVING COUNT(*)>CAPACITY
--10. Select the codes of all the boxes located in Chicago.

SELECT * 
FROM Warehouses w
JOIN Boxes b
ON w.Code = b.Warehouse
AND w.LOCATION = 'Chicago'

--11. Create a new warehouse in New York with a capacity for 3 boxes.
INSERT INTO Warehouses VALUES(6,'New York', 3)
/*12. Create a new box, with code "H5RT", containing "Papers" with a value of $200, and located in warehouse 2.
*/
INSERT INTO Boxes VALUES('H5RT','Papers',200,2)

-- 13. Reduce the value of all boxes by 15%.
UPDATE Boxes
SET [Value] = 0.85*[Value]
/*14. Apply a 20% value reduction to boxes with a value larger than the average value of all the boxes.*/
BEGIN TRANSACTION
UPDATE Boxes
SET [Value] = 0.8*[Value]
WHERE [Value]>(SELECT AVG([Value]) FROM Boxes)
ROLLBACK
/*15. Remove all boxes with a value lower than $100.
*/
BEGIN TRANSACTION
DELETE FROM Boxes
WHERE [Value]<100
ROLLBACK
--16. Remove all boxes from saturated warehouses.
BEGIN TRANSACTION
DELETE FROM Boxes
WHERE Code IN (
		SELECT b.Code 
		FROM Boxes b
		JOIN Warehouses w
		ON b.Warehouse  = W.Code
		AND w.CAPACITY < (SELECT count(*) 
			FROM Boxes b
			WHERE w.Code = b.Warehouse)

)
ROLLBACK