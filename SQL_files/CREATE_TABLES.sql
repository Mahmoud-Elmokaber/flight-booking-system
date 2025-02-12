CREATE TABLE Accounts (
    ID INT IDENTITY(1,1) ,
    Email NVARCHAR(50) ,
    Password NVARCHAR(50),
    PassengerProfileSSN NVARCHAR(11) 
);

CREATE TABLE Airplanes (
    ID INT IDENTITY(1,1) ,
    EconomySeats INT ,
    BusinessSeats INT ,
    FirstClassSeats INT ,
    Manufacturer NVARCHAR(50),
    Model NVARCHAR(50) 
);

CREATE TABLE Airports (
    ID INT IDENTITY(1,1) ,
    Name NVARCHAR(50) ,
    City NVARCHAR(50) ,
    Country NVARCHAR(50) 
);

CREATE TABLE Companies (
    ID INT IDENTITY(1,1) ,
    Name NVARCHAR(50) ,
    Address NVARCHAR(100),
    Phone NVARCHAR(11) ,
    Email NVARCHAR(100) 
);

CREATE TABLE Flights (
    ID INT IDENTITY(1,1) ,
    FlightStatus INT ,
    Duration NVARCHAR(MAX) ,
    TakeOffDate DATETIME2(7) ,
    LandingDate DATETIME2(7) ,
    EconomySeatsLeft INT ,
    BusinessSeatsLeft INT ,
    FirstClassSeatsLeft INT,
    AirportID INT ,
    AirplaneID INT ,
    CompanyID INT 
);

CREATE TABLE PassengerProfiles (
    SSN NVARCHAR(11),
    AccountID INT ,
    Firstname NVARCHAR(50),
    Middlename NVARCHAR(50),
    Lastname NVARCHAR(50) ,
    PhoneNumber NVARCHAR(11),
    Address NVARCHAR(100) ,
    Passports NVARCHAR(15),
    DateOfBirth DATE 
);

CREATE TABLE Tickets (
    ID INT IDENTITY(1,1),
    Seatnumber NVARCHAR(MAX),
    TicketType INT ,
    Price DECIMAL(18, 2),
    PassengerProfileSSN NVARCHAR(11) ,
    FlightID INT 
);

ALTER TABLE Airplanes
ADD CONSTRAINT FK_Airplanes_Airports
FOREIGN KEY (AirportID) REFERENCES Airports(ID);

ALTER TABLE Airports
ADD CONSTRAINT FK_Airports_Companies
FOREIGN KEY (CompanyID) REFERENCES Companies(ID);

ALTER TABLE Flights
ADD CONSTRAINT FK_Flights_Airplanes
FOREIGN KEY (AirplaneID) REFERENCES Airplanes(ID);

ALTER TABLE Flights
ADD CONSTRAINT FK_Flights_Airports
FOREIGN KEY (AirportID) REFERENCES Airports(ID);

ALTER TABLE Flights
ADD CONSTRAINT FK_Flights_Companies
FOREIGN KEY (CompanyID) REFERENCES Companies(ID);

ALTER TABLE PassengerProfiles
ADD CONSTRAINT FK_PassengerProfiles_Accounts
FOREIGN KEY (AccountID) REFERENCES Accounts(ID);

ALTER TABLE Tickets
ADD CONSTRAINT FK_Tickets_Flights
FOREIGN KEY (FlightID) REFERENCES Flights(ID);

ALTER TABLE Tickets
ADD CONSTRAINT FK_Tickets_PassengerProfiles
FOREIGN KEY (PassengerProfileSSN) REFERENCES PassengerProfiles(SSN);