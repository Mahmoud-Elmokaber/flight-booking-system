CREATE PROCEDURE SP_GetAccount @SSN CHAR(14)
AS
BEGIN
	SELECT * FROM Accounts
	WHERE SSN =	@SSN
END;


CREATE PROCEDURE SP_AddAccount @Email nvarchar(50), @Password nvarchar(50), @PassengerSSN char(14)
AS
BEGIN 
	INSERT INTO Accounts (Email, Password,PassengerProfileSSN)
	VALUES (@Email, @Password, @PassengerSSN);
END;

CREATE PROCEDURE SP_UpdateAccount @ID int, @Email nvarchar(50), @Password nvarchar(50)
AS 
BEGIN
	IF @Password IS NOT NULL
		UPDATE Accounts SET Password = @Password;
	
	IF @Email IS NOT NULL
		UPDATE Accounts SET Email = @Email;
END;

CREATE PROCEDURE SP_DeleteAccount @ID INT
AS
BEGIN
	DELETE FROM Accounts
	WHERE ID = @ID
END;

CREATE PROCEDURE SP_CheckExistingEmail @Email nvarchar(50)
AS
BEGIN
	DECLARE @IsValid BIT
	IF EXISTS
	(
		SELECT 1
		FROM Accounts
		WHERE Email = @Email
	)
	BEGIN
		SET @IsValid = 1;
	END;
	ELSE
	BEGIN
		SET @IsValid = 0;
	END;

	SELECT @IsValid
END;

CREATE PROCEDURE SP_CheckAccount @Email nvarchar(50), @Password nvarchar(50)
AS
BEGIN
		DECLARE @IsValid BIT
		IF EXISTS
		(
			SELECT 1
			FROM Accounts
			WHERE Email = @Email AND Password = @Password
		)
		BEGIN
			SET @IsValid = 1;
		END
		ELSE
		BEGIN
			SET @IsValid = 0;
		END

		Select @IsValid
		
END;


----------Passenger

CREATE PROCEDURE SP_GetPassengers @SSN NVARCHAR(50) = NULL
AS
BEGIN
    IF @SSN IS NULL
        SELECT * FROM PassengerProfiles; 
    ELSE
        SELECT * FROM PassengerProfiles WHERE SSN = @SSN; 
END;

CREATE PROCEDURE SP_GetPassengerPassport @SSN char(14)
AS
BEGIN
	SELECT * FROM Passport
	WHERE SSN = @SSN
END;


DROP PROCEDURE SP_AddPassenger
CREATE PROCEDURE SP_AddPassenger @SSN char(14),
	@Firstname nvarchar(50),
	@Middlename nvarchar(50),
	@Lastname nvarchar(50),
	@Address nvarchar(100),
	@Phone char(15),
	@DOB Date,
	@AccountID nvarchar
AS
BEGIN
	INSERT INTO PassengerpPassengerProfiles(SSN, AccountID, Firstname, Middlename, Lastname, PhoneNumber, Address, DateOfBirth)
    VALUES (@SSN, @AccountID, @Firstname, @Middlename, @Lastname, @Phone, @Address, @DOB);

END;

CREATE PROCEDURE SP_AddPassengerPassport @SSN char(14), @PassportNumber char(9), @Country nvarchar(50)
AS
BEGIN
	INSERT INTO Passport(PassportNumber, Country, SSN)
	VALUES (@PassportNumber, @Country, @SSN)
END;


CREATE PROCEDURE SP_UpdatePassenger
    @SSN NVARCHAR(14),
    @LastName NVARCHAR(50),
    @MiddleName NVARCHAR(50),
    @FirstName NVARCHAR(50),
    @Address NVARCHAR(100),
    @Phone NVARCHAR(15),
    @DOB DATE
AS
BEGIN
    UPDATE PassengerProfiles
    SET Lastname = @LastName,
        Middlename = @MiddleName,
        Firstname = @FirstName,
        Address = @Address,
        PhoneNumber = @Phone,
        DateOfBirth = @DOB
    WHERE SSN = @SSN;

END;


CREATE PROCEDURE SP_DeletePassenger @SSN NVARCHAR(50)
AS
BEGIN
    DELETE FROM PassengerProfiles WHERE SSN = @SSN;
END;

CREATE PROCEDURE SP_UpdatePassengerPassport @PassportNumber char(9), @SSN CHAR(14), @COUNTRY NVARCHAR(50)
AS
BEGIN
	UPDATE Passport
	SET Country = @COUNTRY,
		PassportNumber = @PassportNumber
	WHERE SSN = @SSN
END;

CREATE PROCEDURE SP_DeletePassengerPassport @SSN CHAR(14), @PassportNumber CHAR(9)
AS 
BEGIN
	DELETE FROM Passport
	WHERE SSN = @SSN AND PassportNumber = @PassportNumber
END;