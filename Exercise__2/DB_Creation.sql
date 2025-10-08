CREATE TABLE Departments(
		Code	INT Primary key,
		[Name] VARCHAR(255),
		Budget DEC(9,2),
)
CREATE TABLE Employees(
		SSN INT PRIMARY KEY, 
		[FisrtName] VARCHAR(255),
		[LastName] VARCHAR(255),
		Department INT FOREIGN KEY REFERENCES Departments(Code)
)
INSERT INTO Departments(Code,Name,Budget) VALUES(14,'IT',65000);
INSERT INTO Departments(Code,Name,Budget) VALUES(37,'Accounting',15000);
INSERT INTO Departments(Code,Name,Budget) VALUES(59,'Human Resources',240000);
INSERT INTO Departments(Code,Name,Budget) VALUES(77,'Research',55000);

INSERT INTO Employees(SSN,[FisrtName],LastName,Department) VALUES('123234877','Michael','Rogers',14);
INSERT INTO Employees(SSN,[FisrtName],LastName,Department) VALUES('152934485','Anand','Manikutty',14);
INSERT INTO Employees(SSN,[FisrtName],LastName,Department) VALUES('222364883','Carol','Smith',37);
INSERT INTO Employees(SSN,[FisrtName],LastName,Department) VALUES('326587417','Joe','Stevens',37);
INSERT INTO Employees(SSN,[FisrtName],LastName,Department) VALUES('332154719','Mary-Anne','Foster',14);
INSERT INTO Employees(SSN,[FisrtName],LastName,Department) VALUES('332569843','George','O''Donnell',77);
INSERT INTO Employees(SSN,[FisrtName],LastName,Department) VALUES('546523478','John','Doe',59);
INSERT INTO Employees(SSN,[FisrtName],LastName,Department) VALUES('631231482','David','Smith',77);
INSERT INTO Employees(SSN,[FisrtName],LastName,Department) VALUES('654873219','Zacary','Efron',59);
INSERT INTO Employees(SSN,[FisrtName],LastName,Department) VALUES('745685214','Eric','Goldsmith',59);
INSERT INTO Employees(SSN,[FisrtName],LastName,Department) VALUES('845657245','Elizabeth','Doe',14);
INSERT INTO Employees(SSN,[FisrtName],LastName,Department) VALUES('845657246','Kumar','Swamy',14);