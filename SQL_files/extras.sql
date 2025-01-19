
--- Stored Procedure for booking a ticket
CREATE PROCEDURE SP_BookTicket
    @PassengerSSN NVARCHAR(11),
    @FlightID INT,
    @SeatNumber INT,
    @TicketType INT,
    @Price DECIMAL(18, 2)
AS
BEGIN
    -- Start a transaction
    BEGIN TRANSACTION;
        BEGIN TRY

        DECLARE @SeatsLeft INT;
        IF @TicketType = 1
            SELECT @SeatsLeft = EconomySeatsLeft FROM Flights WHERE ID = @FlightID;
        ELSE IF @TicketType = 2
            SELECT @SeatsLeft = BusinessSeatsLeft FROM Flights WHERE ID = @FlightID;
        ELSE IF @TicketType = 3
            SELECT @SeatsLeft = FirstClassSeatsLeft FROM Flights WHERE ID = @FlightID;

       
        IF @SeatsLeft <= 0
        BEGIN
            RAISERROR('No seats available for the specified ticket type.', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

        -- Adding a ticket into  Tickets table
        EXEC SP_AddTicket @SeatNumber, @TicketType, @Price, @FlightID;

        -- Updating the number of available seats in the Flights table
        IF @TicketType = 1
            UPDATE Flights SET EconomySeatsLeft = EconomySeatsLeft - 1 WHERE ID = @FlightID;
        ELSE IF @TicketType = 2
            UPDATE Flights SET BusinessSeatsLeft = BusinessSeatsLeft - 1 WHERE ID = @FlightID;
        ELSE IF @TicketType = 3
            UPDATE Flights SET FirstClassSeatsLeft = FirstClassSeatsLeft - 1 WHERE ID = @FlightID;

        -- Commit the transaction
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        -- Rollback the transaction in case of an error
        ROLLBACK TRANSACTION;
    END CATCH
END;
GO
-- Stored Procedure to display the Flight orderd ascendingly or descendingly by price
CREATE PROCEDURE SP_GetFlightDetails
    @OrderBy NVARCHAR(4)
AS
BEGIN
    IF @OrderBy = 'ASC'
    BEGIN
        SELECT 
            f.ID AS FlightID,
            f.Duration,
            From_airport.Name ,
            To_Airport.Name  ,
            t.Price
        FROM 
            Flights  AS  f
        INNER JOIN 
            Airports AS From_airport ON f.FromAirportID = From_airport.ID
        INNER JOIN 
            Airports AS To_Airport ON f.ToAirportID = To_Airport.ID
        INNER JOIN 
            Tickets  AS t ON f.ID = t.FlightID
        ORDER BY 
            t.Price ASC;
    END
    ELSE IF @OrderBy = 'DESC'
    BEGIN
               SELECT 
            f.ID AS FlightID,
            f.Duration,
            From_airport.Name ,
            To_Airport.Name ,
            t.Price
        FROM 
            Flights  AS  f
        INNER JOIN 
            Airports AS From_airport ON f.FromAirportID = From_airport.ID
        INNER JOIN 
            Airports AS To_Airport ON f.ToAirportID = To_Airport.ID
        INNER JOIN 
            Tickets  AS t ON f.ID = t.FlightID
        ORDER BY 
            t.Price DESC;
    END
END;