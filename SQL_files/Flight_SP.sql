DROP PROCEDURE SP_AddFlight
GO
USE SberbayAirLines
GO
--Stored procedure to get the number of seats in an airplane
CREATE PROCEDURE SP_GetAirplaneSeats @ID INT , @EconomySeats INT OUTPUT , 
@FirstClassSeats INT OUTPUT ,@BusinessSeats INT OUTPUT
AS 
BEGIN 
SELECT @EconomySeats = EconomySeats , @FirstClassSeats = FirstClassSeats ,
 @BusinessSeats = BusinessSeats
FROM Airplanes
END
GO
---Stored procedure to add a flight
CREATE PROCEDURE SP_AddFlight
    @Status INT,
    @Duration INT,
    @TakeOff_DateTime DATETIME,
    @Landing_DateTime DATETIME,
    @AirPlane_ID INT,
    @From_Airport_ID INT,
    @To_Airport_ID INT,
    @Company_id INT
AS
BEGIN
--getting the seats from the airplane first

DECLARE @Economy_Seats INT 
DECLARE @First_Class_Seats INT  
DECLARE @Business_Seats INT
EXEC SP_GetAirplaneSeats @AirPlane_ID , @EconomySeats = @Economy_Seats OUTPUT
, @FirstClassSeats = @First_Class_Seats OUTPUT ,@BusinessSeats = @Business_Seats OUTPUT

        INSERT INTO Flights(
            FlightStatus, 
            Duration, 
            TakeOffDate, 
            LandingDate, 
			AirPlaneID, 
            EconomySeatsLeft, 
            BusinessSeatsLeft, 
            FirstClassSeatsLeft, 
            FromAirportID, 
            ToAirportID, 
            CompanyID
        )
        VALUES (
        @Status ,
		@Duration ,
		@TakeOff_DateTime ,
		@Landing_DateTime ,
		@AirPlane_ID ,
		@Economy_Seats ,
		@Business_Seats ,
		@First_Class_Seats ,
		@From_Airport_ID ,
		@To_Airport_ID ,
		@Company_id 
        );
END;
-- Example call to add a flight
EXEC SP_AddFlight
    1,
    180,
    '2024-12-22 10:00:00',
    '2024-12-22 13:00:00',
    1,
    1,
    2,
    2;
--############################### UPDATE FLIGHT ################################################

--Stored procedure to update flight
DROP PROCEDURE SP_UPDATE_FLIGHT
GO
CREATE PROCEDURE SP_UPDATE_FLIGHT
	@FlightID INT,
    @Status INT = NULL ,
    @Duration INT = NULL,
    @TakeOff_DateTime DATETIME = NULL,
    @Landing_DateTime DATETIME = NULL,
    @AirPlane_ID INT = NULL,
    @From_Airport_ID INT = NULL,
    @To_Airport_ID INT = NULL ,
    @Company_id INT = NULL
AS
BEGIN
DECLARE @Economy_Seats INT 
DECLARE @First_Class_Seats INT  
DECLARE @Business_Seats INT
EXEC SP_GetAirplaneSeats @AirPlane_ID , @EconomySeats = @Economy_Seats OUTPUT
, @FirstClassSeats = @First_Class_Seats OUTPUT ,@BusinessSeats = @Business_Seats OUTPUT

        UPDATE Flights
        SET 
            FlightStatus = ISNULL(@Status,FlightStatus), 
            Duration = ISNULL(@Duration, Duration), 
            TakeOffDate = ISNULL(@TakeOff_DateTime, TakeoffDate),
            LandingDate = ISNULL(@Landing_DateTime, LandingDate), 
            EconomySeatsLeft =ISNULL( @Economy_Seats ,EconomySeatsLeft ), 
            BusinessSeatsLeft = ISNULL(@Business_Seats,BusinessSeatsLeft), 
            FirstClassSeatsLeft = ISNULL(@First_Class_Seats,FirstClassSeatsLeft), 
            FromAirportID = ISNULL(@From_Airport_ID,FromAirportID), 
            ToAirportID = ISNULL(@To_Airport_ID,ToAirportID ),
            AirPlaneID = ISNULL(@AirPlane_ID,AirPlaneID ), 
            CompanyID = ISNULL(@Company_id,CompanyID)
        WHERE ID = @FLIGHTID;
END;
GO
