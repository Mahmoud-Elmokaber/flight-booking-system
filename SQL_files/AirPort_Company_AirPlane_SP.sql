CREATE PROCEDURE SP_AddAirport
    @Name VARCHAR(50),
    @City VARCHAR(50),
    @Country VARCHAR(50)
AS
BEGIN
    INSERT INTO Airports ( Name, City, Country)
    VALUES ( @Name, @City, @Country);
END


CREATE PROCEDURE SP_UpdateAirport
    @ID INT,
    @Name VARCHAR(50),
    @City VARCHAR(50),
    @Country VARCHAR(50)
AS
BEGIN
    UPDATE Airports
    SET Name = @Name, City = @City, Country = @Country
    WHERE ID = @ID;
END


CREATE PROCEDURE SP_DeleteAirport
    @ID INT
AS
BEGIN
    DELETE FROM Airports
    WHERE ID = @ID;
END


CREATE VIEW AirportDetails_view AS
SELECT ID, Name, City, Country
FROM Airports;


CREATE FUNCTION GetAirportByID (@ID INT)
RETURNS TABLE
AS
RETURN
(
    SELECT ID, Name, City, Country
    FROM Airports
    WHERE ID = @ID
);
GO

CREATE PROCEDURE SP_AddAirplane
    @Model_Name VARCHAR(50),
    @Manufacturer VARCHAR(50),
	@First_Class_Seats INT ,
	@Economy_Class_Seats INT,
	@Business_Class_Seats INT
AS
BEGIN
    INSERT INTO Airplanes ( EconomySeats, BusinessSeats , FirstClassSeats , Model, Manufacturer)
    VALUES (@Economy_Class_Seats, @Business_Class_Seats, @First_Class_Seats, @Model_Name, @Manufacturer);
END;

CREATE PROCEDURE SP_UpdateAirplane
    @ID INT,
    @Model_Name VARCHAR(100),
    @Manufacturer VARCHAR(100),
	@First_Class_Seats INT ,
	@Economy_Class_seats INT,
	@Business_Class_Seats INT
AS
BEGIN
    UPDATE Airplanes
    SET Model = @Model_Name,
		Manufacturer = @Manufacturer ,
		FirstClassSeats = @First_Class_Seats ,
		EconomySeats = @Economy_Class_seats,
		BusinessSeats = @Business_Class_Seats
    WHERE ID = @ID;
END;


CREATE PROCEDURE SP_DeleteAirplane
    @ID INT
AS
BEGIN
    DELETE FROM Airplanes
    WHERE ID = @ID;
END;


CREATE VIEW AirplaneDetails_view AS
SELECT ID, Model Manufacturer,FirstClassSeats , EconomySeats, BusinessSeats
FROM Airplanes;


CREATE FUNCTION GetAirplaneByID (@ID INT)
RETURNS TABLE
AS
RETURN
(
    SELECT ID, model, Manufacturer , FirstClassSeats, EconomySeats, BusinessSeats
    FROM Airplanes
    WHERE ID = @ID
);


CREATE PROCEDURE SP_AddCompany
    @Name VARCHAR(50),
    @Email VARCHAR(50),
	@Address VARCHAR(100),
	@Phone CHAR(11)
AS
BEGIN
    INSERT INTO Companies( Name, Address, Phone, Email)
    VALUES (@Name, @Address, @Phone, @Email);
END;


CREATE PROCEDURE SP_UpdateCompany
    @ID INT,
    @Name VARCHAR(50),
    @Email VARCHAR(50),
	@Address VARCHAR(100),
	@Phone CHAR(11)
AS
BEGIN
    UPDATE Companies
    SET Name = @Name,
		Email = @Email ,
		Address = @Address,
		Phone = @Phone
    WHERE ID = @ID;
END;


CREATE PROCEDURE SP_DeleteCompany
    @ID INT
AS
BEGIN
    DELETE FROM Companies
    WHERE ID = @ID;
END;


CREATE VIEW CompanyDetails_view AS
SELECT ID, Name, Email, Address, Phone
FROM Companies;


CREATE FUNCTION GetCompanyByID (@ID INT)
RETURNS TABLE
AS
RETURN
(
    SELECT ID, Name, Email , Address, Phone
    FROM Companies
    WHERE ID = @ID
);
