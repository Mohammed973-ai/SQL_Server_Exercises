--1. Select the title of all movies.
SELECT title from Movies
--2. Show all the distinct ratings in the database.
SELECT DISTINCT rating 
from Movies
--3. Show all unrated movies.

SELECT * FROM Movies
WHERE Rating IS NULL

/*4. Select all movie theaters that are not currently showing a movie.*/
SELECT * 
FROM MovieTheaters
WHERE Movie IS NULL
/* 5. Select all data from all movie theaters and, additionally, the data from the movie that is being shown in the theater (if one is being shown).
*/
SELECT *
FROM MovieTheaters mt
JOIN Movies m
ON m.Code = mt.Movie
/*6. Select all data from all movies and, if that movie is being shown in a theater, show the data from the theater.
*/
SELECT * FROM Movies
LEFT JOIN MovieTheaters
ON Movies.Code = MovieTheaters.Movie
/*7. Show the titles of movies not currently being shown in any theaters.*/
SELECT title
from Movies m 
LEFT JOIN MovieTheaters mt
ON m.Code = mt.Movie
WHERE Movie IS NULL

--8. Add the unrated movie "One, Two, Three".
SELECT * FROM Movies
INSERT INTO Movies(Code,Title) VALUES(10,'One, Two, Three')
--9. Set the rating of all unrated movies to "G".
UPDATE Movies
SET Rating  = 'G'
WHERE Rating IS NULL
--10. Remove movie theaters projecting movies rated "NC-17".
BEGIN TRANSACTION
DELETE 
FROM MovieTheaters 
WHERE Movie IN(SELECT Movie FROM Movies WHERE Rating = 'NC-17')
ROLLBACK