use SberbayAirLines
 go


-- 1. SearchFlightsByStatus: Retrieves flights by flight status
CREATE PROCEDURE SearchFlightsByStatus
    @FlightStatus INT
AS
BEGIN
    SELECT 
        ID, FlightStatus, Duration, TakeOffDate, LandingDate, 
        EconomySeatsLeft, BusinessSeatsLeft, FirstClassSeatsLeft, 
        FromAirportID, ToAirportID, AirplaneID, CompanyID
    FROM Flights
    WHERE FlightStatus = @FlightStatus;
END;



go

-- 2. SearchFlightsByTakeOffDate: Retrieves flights by take off date range
CREATE PROCEDURE SearchFlightsByTakeOffDate
    @StartDate DATETIME2(7),
    @EndDate DATETIME2(7)
AS
BEGIN
    SELECT 
        ID, FlightStatus, Duration, TakeOffDate, LandingDate, 
        EconomySeatsLeft, BusinessSeatsLeft, FirstClassSeatsLeft, 
        FromAirportID, ToAirportID, AirplaneID, CompanyID
    FROM Flights
    WHERE TakeOffDate BETWEEN @StartDate AND @EndDate;
END;




go
-- 3. SearchFlightsByAirplane: Retrieves flights by airplane ID
CREATE PROCEDURE SearchFlightsByAirplane
    @AirplaneID INT
AS
BEGIN
    SELECT 
        ID, FlightStatus, Duration, TakeOffDate, LandingDate, 
        EconomySeatsLeft, BusinessSeatsLeft, FirstClassSeatsLeft, 
        FromAirportID, ToAirportID, AirplaneID, CompanyID
    FROM Flights
    WHERE AirplaneID = @AirplaneID;
END;




go
-- 4. SearchFlightsByAirports: Retrieves flights by departure and arrival airports
CREATE PROCEDURE SearchFlightsByAirports
    @FromAirportID INT,
    @ToAirportID INT
AS
BEGIN
    SELECT 
        ID, FlightStatus, Duration, TakeOffDate, LandingDate, 
        EconomySeatsLeft, BusinessSeatsLeft, FirstClassSeatsLeft, 
        FromAirportID, ToAirportID, AirplaneID, CompanyID
    FROM Flights
    WHERE FromAirportID = @FromAirportID AND ToAirportID = @ToAirportID;
END;



go

-- 5. SearchFlightsByAvailableSeats: Retrieves flights based on available seats in a specific class
CREATE PROCEDURE SearchFlightsByAvailableSeats
    @SeatClass VARCHAR(20), -- 'Economy', 'Business', or 'FirstClass'
    @MinSeats INT
AS
BEGIN
    DECLARE @ColumnName VARCHAR(20);

    IF @SeatClass = 'Economy'
        SET @ColumnName = 'EconomySeatsLeft';
    ELSE IF @SeatClass = 'Business'
        SET @ColumnName = 'BusinessSeatsLeft';
    ELSE IF @SeatClass = 'FirstClass'
        SET @ColumnName = 'FirstClassSeatsLeft';
    ELSE
        BEGIN
            PRINT 'Invalid Seat Class';
            RETURN;
        END

    DECLARE @Query VARCHAR(MAX) = 
        'SELECT ID, FlightStatus, Duration, TakeOffDate, LandingDate, ' + 
        @ColumnName + ', FromAirportID, ToAirportID, AirplaneID, CompanyID ' + 
        'FROM Flights ' + 
        'WHERE ' + @ColumnName + ' >= @MinSeats';

    EXEC sp_executesql @Query, N'@MinSeats INT', @MinSeats;
END;




go
-- 6. SearchFlightsByDuration: Retrieves flights based on flight duration range
CREATE PROCEDURE SearchFlightsByDuration
    @MinDuration INT,
    @MaxDuration INT
AS
BEGIN
    SELECT 
        ID, FlightStatus, Duration, TakeOffDate, LandingDate, 
        EconomySeatsLeft, BusinessSeatsLeft, FirstClassSeatsLeft, 
        FromAirportID, ToAirportID, AirplaneID, CompanyID
    FROM Flights
    WHERE Duration BETWEEN @MinDuration AND @MaxDuration;
END;




go
-- 7. SearchFlightsByCompany: Retrieves flights by company ID
CREATE PROCEDURE SearchFlightsByCompany
    @CompanyID INT
AS
BEGIN
    SELECT 
        ID, FlightStatus, Duration, TakeOffDate, LandingDate, 
        EconomySeatsLeft, BusinessSeatsLeft, FirstClassSeatsLeft, 
        FromAirportID, ToAirportID, AirplaneID, CompanyID
    FROM Flights
    WHERE CompanyID = @CompanyID;
END;


go
--  8 . Stored Procedure: SearchFlightsByPriceRange
CREATE PROCEDURE SearchFlightsByPriceRange
    @LowerPrice DECIMAL(18, 2),
    @UpperPrice DECIMAL(18, 2)
AS
BEGIN
    DECLARE @FlightIDs TABLE (FlightID INT);

    INSERT INTO @FlightIDs (FlightID)
    SELECT DISTINCT FlightID
    FROM Tickets
    WHERE Price BETWEEN @LowerPrice AND @UpperPrice;
    SELECT 
        F.ID, 
        F.FlightStatus, 
        F.Duration, 
        F.TakeOffDate, 
        F.LandingDate, 
        F.EconomySeatsLeft, 
        F.BusinessSeatsLeft, 
        F.FirstClassSeatsLeft, 
        F.FromAirportID, 
        F.ToAirportID, 
        F.AirplaneID, 
        F.CompanyID
    FROM Flights F
    INNER JOIN @FlightIDs FIDs ON F.ID = FIDs.FlightID;
END;
