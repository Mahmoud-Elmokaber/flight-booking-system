
CREATE PROCEDURE SP_AddTicket
    @Seatnumber INT,
    @TicketType INT,
    @Price DECIMAL(10, 2),
    @Flight_ID INT
AS
BEGIN
    INSERT INTO Tickets (Seatnumber, TicketType, Price, FlightID)
    VALUES (@Seatnumber, @TicketType, @Price, @Flight_ID);
END

CREATE PROCEDURE SP_UpdateTicket
    @ID INT,
     @Seatnumber INT,
    @TicketType INT,
    @Price DECIMAL(10, 2),
    @Flight_ID INT
AS
BEGIN
    UPDATE Tickets
    SET 
        Seatnumber = @Seatnumber,
        TicketType = @TicketType,
        Price = @Price,
        FlightID = @Flight_ID
    WHERE ID = @ID;
END

CREATE PROCEDURE SP_DeleteTicket
    @ID INT
AS
BEGIN
    DELETE FROM Tickets
    WHERE ID = @ID;
END



CREATE PROCEDURE SP_ReadTickets
    @ID INT = NULL
AS
BEGIN
    IF @ID IS NOT NULL
        SELECT * FROM Tickets WHERE ID = @ID;
    ELSE
        SELECT * FROM Tickets;
END

CREATE PROCEDURE SP_GetAvailableSeats
    @Flight_ID INT
AS
BEGIN
    SELECT EconomySeatsLeft, BusinessSeatsLeft, FirstClassSeatsLeft
    FROM Flights
    WHERE ID = @Flight_ID;
END


CREATE PROCEDURE SP_CancelTicketsForFlight
    @Flight_ID INT
AS
BEGIN
    DELETE FROM Tickets
    WHERE FlightID = @Flight_ID;
END

CREATE PROCEDURE SP_AssignTicketToPassenger
    @SSN CHAR(14),
    @Ticket_ID INT
AS
BEGIN
   UPDATE Tickets
   SET PassengerProfileSSN = @SSN
   WHERE ID = @Ticket_ID
END;


