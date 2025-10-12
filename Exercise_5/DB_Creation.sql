CREATE TABLE Pieces(
		Code INT  Primary key,
		[Name] VARCHAR(50)

)
CREATE TABLE Providers(
		Code VARCHAR(10) PRIMARY KEY,
		[Name] VARCHAR(50)
)

CREATE TABLE Provides(
		Piece INT ,
		[Provider]  VARCHAR(10) ,
		Price INT,
		CONSTRAINT com_pk PRIMARY KEY(Piece,[Provider]),
		CONSTRAINT piece_fk FOREIGN KEY (Piece) REFERENCES Pieces(Code),
		CONSTRAINT provider_fk FOREIGN KEY ([Provider])
		REFERENCES Providers(Code)

)


 INSERT INTO Providers(Code, Name) VALUES('HAL','Clarke Enterprises');
 INSERT INTO Providers(Code, Name) VALUES('RBT','Susan Calvin Corp.');
 INSERT INTO Providers(Code, Name) VALUES('TNBC','Skellington Supplies');
 
 INSERT INTO Pieces(Code, Name) VALUES(1,'Sprocket');
 INSERT INTO Pieces(Code, Name) VALUES(2,'Screw');
 INSERT INTO Pieces(Code, Name) VALUES(3,'Nut');
 INSERT INTO Pieces(Code, Name) VALUES(4,'Bolt');
 
 INSERT INTO Provides(Piece, Provider, Price) VALUES(1,'HAL',10);
 INSERT INTO Provides(Piece, Provider, Price) VALUES(1,'RBT',15);
 INSERT INTO Provides(Piece, Provider, Price) VALUES(2,'HAL',20);
 INSERT INTO Provides(Piece, Provider, Price) VALUES(2,'RBT',15);
 INSERT INTO Provides(Piece, Provider, Price) VALUES(2,'TNBC',14);
 INSERT INTO Provides(Piece, Provider, Price) VALUES(3,'RBT',50);
 INSERT INTO Provides(Piece, Provider, Price) VALUES(3,'TNBC',45);
 INSERT INTO Provides(Piece, Provider, Price) VALUES(4,'HAL',5);
 INSERT INTO Provides(Piece, Provider, Price) VALUES(4,'RBT',7);