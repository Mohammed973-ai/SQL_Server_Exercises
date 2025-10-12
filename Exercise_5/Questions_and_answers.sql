--1. Select the name of all the pieces.

SELECT Name FROM Pieces
--2. Select all the providers' data.

SELECT * FROM Providers

/*3. Obtain the average price of each piece (show only the piece code and the average price).*/

SELECT Piece  , AVG(Price)as [avg price]
FROM Provides
GROUP BY Piece 
/*4. Obtain the names of all providers who supply piece 1.*/
SELECT Provider FROM Provides
WHERE Piece =1

/* 5. Select the name of pieces provided by provider with code "HAL".
*/

SELECT * FROM Providers
SELECT * FROM Pieces
SELECT * FROM Provides
SELECT pe.Name
FROM Provides pr
JOIN Pieces pe
ON pr.Piece = pe.Code
AND pr.Provider = 'HAL'
/*6. For each piece, find the most expensive offering of that piece and include the piece name, provider name, and price (note that there could be two providers who supply the same piece at the most expensive price).
*/

SELECT * 
FROM (SELECT pe.[Name] as [piece Name],pv.[Name][Provider name],Price,DENSE_RANK() OVER(partition by ps.piece ORDER BY ps.Price DESC) as DR
FROM Provides ps
JOIN Pieces pe
ON ps.Piece = pe.Code
JOIN Providers pv
ON pv.Code= ps.Provider) drt
WHERE DR = 1
/*7. Add an entry to the database to indicate that "Skellington Supplies" (code "TNBC") will provide sprockets (code "1") for 7 cents each.
*/
INSERT INTO Provides VALUES(1,'TNBC',7)
--8. Increase all prices by one cent.
Update Provides
SET Price+=1
--9. Update the database to reflect that "Susan Calvin Corp." (code "RBT") will not supply bolts (code 4).
DELETE FROM Provides
WHERE Piece =4 AND Provider ='RBT'
/*
10. Update the database to reflect that "Susan Calvin Corp." (code "RBT") will not supply any pieces (the provider should still remain in the database).*/
DELETE FROM Provides
WHERE Provider ='RBT'