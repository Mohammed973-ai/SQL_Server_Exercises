--1. Select the last name of all employees.
SELECT LastName
FROM Employees
--2. Select the last name of all employees, without duplicates.

SELECT DISTINCT(LastName)
FROM Employees
--3. Select all the data of employees whose last name is "Smith".

SELECT *
FROM Employees
where LOWER(LastName) = 'smith'

/*4. Select all the data of employees whose last name is "Smith" or "Doe".*/
SELECT *
FROM Employees
where LOWER(LastName) IN( 'smith','doe')

--5. Select all the data of employees that work in department 14.

SELECT * 
FROM Employees e
JOIN Departments d
ON d.Code = e.Department
AND  e.Department = 14

/*6. Select all the data of employees that work in department 37 or department 77.*/

SELECT * 
FROM Employees e
JOIN Departments d
ON d.Code = e.Department
AND  e.Department IN (37,77)

/*. Select all the data of employees whose last name begins with an "S".*/
SELECT *
FROM Employees
WHERE LastName LIKE '[Ss]%'
-- 8. Select the sum of all the departments' budgets.
SELECT SUM(Budget) AS [total budget] 
FROM Departments
/*9. Select the number of employees in each department (you only need to show the department code and the number of employees).
*/
SELECT Department , count(*) as [#employees]
FROM Employees
GROUP BY Department
/* 10. Select all the data of employees, including each employee's department's data.
*/

SELECT * 
FROM Employees e
JOIN Departments d
ON e.Department = d.Code
/*11. Select the name and last name of each employee, along with the name and budget of the employee's department.
*/
SELECT e.FisrtName,e.LastName,d.Name,d.Budget
FROM Employees e
JOIN Departments d
ON e.Department = d.Code

/*12. Select the name and last name of employees working for departments with a budget greater than $60,000.
*/
SELECT e.FisrtName , e.LastName
FROM Employees e
JOIN Departments d
ON e.Department = d.Code
AND d.Budget >60000
/*13. Select the departments with a budget larger than the average budget of all the departments.
*/
SELECT *
FROM Departments
WHERE Budget >(SELECT AVG(Budget) FROM Departments)
-- 14. Select the names of departments with more than two employees.
--in case no 2 department has same name 
SELECT d.Name
FROM Departments d
JOIN Employees e
ON e.Department = d.Code
GROUP BY d.Name
HAVING COUNT(*) > 2
-- more general case 
SELECT * 
FROM
(SELECT * ,COUNT(*) OVER (PARTITION BY e.Department )as[#emplyees]
FROM Employees e) p
WHERE [#emplyees] >2
----
SELECT d.Name
FROM Departments d
WHERE 2<(SELECT COUNT(*)
FROM Employees e
WHERE d.Code = e.Department)
----
SELECT d.Name
FROM Departments d
WHERE d.Code IN (SELECT Department FROM Employees
GROUP BY Department
HAVING COUNT(*)>2)
/*15. Select the name and last name of employees working for departments with second lowest budget.*/

SELECT FisrtName , LastName
FROM(select * ,
DENSE_RANK()over (order by budget ) AS DR
FROM Employees e
JOIN Departments d
on e.Department = d.Code) T 
WHERE DR =2
--without window functions
SELECT e.FisrtName ,e.LastName
FROM Employees e
WHERE e.Department IN (		
			SELECT TOP(1)Code
			FROM Departments
			WHERE Budget IN
			(SELECT DISTINCT TOP(2) Budget 
			FROM Departments
			ORDER BY Budget)
			ORDER BY Budget DESC
)

/* 16. Add a new department called "Quality Assurance", with a budget of $40,000 and departmental code 11. Add an employee called "Mary Moore" in that department, with SSN 847-21-9811.
*/
INSERT INTO Departments VALUES(11,'Quality Assurance',40000)
INSERT INTO Employees VALUES(847219811,'Mary','Moore',11)
--17. Reduce the budget of all departments by 10%.
UPDATE Departments
SET Budget = .9*Budget
/*8. Reassign all employees from the Research department (code 77) to the IT department (code 14).*/
UPDATE Employees
SET Department = 14
WHERE Department = 77
/*19. Delete from the table all employees in the IT department (code 14).
*/
BEGIN TRANSACTION
DELETE FROM Employees
WHERE Department = 14
ROLLBACK;
/*20. Delete from the table all employees who work in departments with a budget greater than or equal to $60,000.*/
BEGIN TRANSACTION
SELECT * FROM Employees
DELETE 
FROM Employees 
WHERE Department IN(SELECT Code 
					  FROM Departments
					  WHERE Budget >=60000)
SELECT * FROM Employees
ROLLBACK
/*21. Delete from the table all employees.*/
DELETE FROM Employees