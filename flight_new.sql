-- Project: Database Design (M)
-- Author: Farhana Alam


-- QI.1 : creation of the database
CREATE SCHEMA IF NOT EXISTS flight;

-- QI.2 : creation of the table Airline
CREATE TABLE IF NOT EXISTS flight.Airline (
  Airline_ID INT(11) NOT NULL,
  Airline_Abbreviation VARCHAR(6) NOT NULL,
  Address1 VARCHAR(100) NULL,
  Address2 VARCHAR(100) NULL,
  City VARCHAR(100) NULL,
  Country VARCHAR(100) NULL,
  State_Province VARCHAR(20) NULL,
  PRIMARY KEY (Airline_ID));            -- QI.3 : creation of Primary key


-- QI.5 : Creating Index on City
CREATE INDEX City ON flight.airline(City)VISIBLE;  

-- QI.2 : creation of the table Airport
CREATE TABLE IF NOT EXISTS flight.Airport(
  Airport_Abbrev VARCHAR(3) NOT NULL,
  Airport_Name VARCHAR(100) NOT NULL,
  City_Name VARCHAR(100) NULL,
  County_Name VARCHAR(100) NULL,
  State VARCHAR(2) NULL,
  Country VARCHAR(100) NULL,
  PRIMARY KEY (Airport_Abbrev));            -- QI.3 : creation of Primary key

-- QI.2 : creation of the table Market
CREATE TABLE IF NOT EXISTS flight.Market (
  Market_ID INT(11) NOT NULL,
  Market_Name VARCHAR(200) NOT NULL,
  Start_Airport VARCHAR(3) NOT NULL,
  End_Airport VARCHAR(3) NOT NULL,
  PRIMARY KEY (Market_ID),            -- QI.3 : creation of Primary key
  INDEX fk_Market_Airport1 (Start_Airport ASC) VISIBLE,
  INDEX fk_Market_Airport2 (End_Airport ASC) VISIBLE,
  CONSTRAINT fk_Market_Airport1
    FOREIGN KEY (Start_Airport)            -- QI.4 : creation of Foreign key
    REFERENCES flight.Airport (Airport_Abbrev),
  CONSTRAINT fk_Market_Airport2
    FOREIGN KEY (End_Airport)            -- QI.4 : creation of Foreign key
    REFERENCES flight.Airport (Airport_Abbrev));

-- QI.2 : creation of the table Route
CREATE TABLE IF NOT EXISTS flight.Route (
  Route_ID INT(11) NOT NULL,
  Route_Name VARCHAR(100) NULL,
  Days_Operating CHAR(20) NULL,
  Schedule_Departure TIME NOT NULL,
  Schedule_Arrival TIME NOT NULL,
  Airline_ID INT(11) NOT NULL,
  Market_ID INT(11) NOT NULL,
  PRIMARY KEY (Route_ID),            -- QI.3 : creation of Primary key
  INDEX fk_Route_Airline1 (Airline_ID ASC) VISIBLE,
  INDEX fk_Route_Market1 (Market_ID ASC) VISIBLE,
  CONSTRAINT fk_Route_Airline1
    FOREIGN KEY (Airline_ID)            -- QI.4 : creation of Foreign key
    REFERENCES flight.Airline (Airline_ID),
  CONSTRAINT fk_Route_Market1
    FOREIGN KEY (Market_ID)            -- QI.4 : creation of Foreign key
    REFERENCES flight.Market(Market_ID));

-- QI.2 : creation of the table Flight
CREATE TABLE IF NOT EXISTS flight.Flight (
  flight_ID INT(11) NOT NULL,
  flight_Number INT(11) NULL,
  DayOfWeek VARCHAR(1) NULL,
  Route_ID INT(11) NOT NULL,
  PRIMARY KEY (flight_ID),            -- QI.3 : creation of Primary key
  INDEX fk_flight_Route (Route_ID ASC) VISIBLE,
  CONSTRAINT fk_flight_Route
    FOREIGN KEY (Route_ID)            -- QI.4 : creation of Foreign key
     REFERENCES flight.Route(Route_ID));


-- QII.1 : Populating the database
-- Begin of Inserts
Use flight;
INSERT INTO airport
  (Airport_Abbrev, Airport_name, City_Name, County_Name, State, Country)
  VALUES ('LAX', 'Los Angeles Int. Airport','Los Angeles', 'Westchester', 'LA', 'US'),
         ('JFK', 'JOHN F. Kennedy Int. Airport','New York City', 'Queens', 'NY', 'US'),
         ('SEA', 'Seattle–Tacoma International Airport','Seattle','King', 'WA', 'US'),
         ('DEN', 'Denver Int. Airport','NE Denver', 'Adams', 'CO', 'US'),
         ('BOI', 'Boise Airport','Boise','Ada', 'ID', 'US'),
         ('SLC', 'Salt Lake City Int. Airport','Salt Lake City', null, 'UT', 'US'),
         ('ORD', 'O-Hare Int. Airport','Chicago', null, 'IL', 'US'),
         ('SFO', 'San Francisco International Airport','San Francisco', 'SAN MATEO', 'LA', 'US');

INSERT INTO airline
  (Airline_ID, Airline_Abbreviation, Address1, Address2, City, State_Province, Country)
  VALUES (1, 'SW','Dallas, Texax', null,'Dallas', 'TX', 'US'),
         (2, 'United','Chicago, Illinois', null, 'Chicago', 'IL', 'US'),
         (3, 'Alaska','Seattle, Washington', null,'Seattle', 'WA', 'US'),
         (4, 'Delta','Atlanta, Georgia', null,'Atlanta', 'GA', 'US'),
         (5, 'AA','Fort Worth, Texax', null,'Fort Worth', 'TX', 'US');
         
INSERT INTO market
  (Market_ID, Market_Name, Start_Airport, End_Airport)
  VALUES (1, 'Den-to-Boi', 'DEN', 'BOI'),
		 (2, 'SEA-to-Boi', 'SEA', 'BOI'),
         (3, 'JFK-to-LAX', 'JFK', 'LAX'),
         (4, 'JFK-to-SEA', 'JFK', 'SEA'),
         (5, 'SFO-to-LAX', 'SFO', 'LAX'),
         (6, 'BOI-to-DEN', 'BOI', 'DEN'),
         (7, 'SFO-to-BOI', 'SFO', 'BOI'),
         (8, 'SLC-to-BOI', 'SLC', 'BOI'),
         (9, 'SLC-to-ORD', 'SLC', 'ORD'),
         (10, 'DEN-to-SLC', 'DEN', 'SLC'),
         (11, 'DEN-to-JFK', 'DEN', 'JFK'),
         (12, 'LAX-to-BOI', 'LAX', 'BOI');

INSERT INTO route
  (Route_ID, Route_Name, Days_Operating, Schedule_Departure, Schedule_Arrival, Airline_ID, Market_ID)
  VALUES (52, 'Denver-Boise', 'Mon, Wed', '08:00', '11:00',1, 1),
         (24, 'Seattle-Boise', 'Mon, Wed, Fri', '17:00', '19:30', 3, 2),
         (16, 'New York-Los Angeles', 'Mon', '22:00', '06:00', 4, 3),
         (22, 'New York-Seattle', 'Mon, Wed, Fri', '08:00', '14:45', 3, 4),
         (39, 'SAn Fransisco-Los Angeles', 'Wed', '08:00', '10:00', 2, 5),
         (34, 'Boise-Denver', 'Wed, Fri', '08:15', '11:00', 1, 6),
         (30, 'San Fransisco-Boise', 'Mon, Wed, Fri', '10:00', '12:45', 2, 7),
         (58, 'Salt Lake City-Boise', 'Wed', '20:00', '22:00', 5 , 8),
         (42, 'Salt Lake City-Chicago', 'Mon', '12:00', '17:00', 2, 9),
         (19, 'Denver-Boise', 'Mon', '13:00', '17:30', 3, 1),
         (20, 'Denver-NY', 'Mon, Wed', '11:00', '16:00', 5 , 11),
         (33, 'LA-Boise', 'Mon, Wed', '16:00', '20:00', 4 , 12);
  
INSERT INTO flight
  (flight_ID, flight_Number, DayOfWeek, Route_ID)
  VALUES (1, 5612,'M', 52), (2, 5612,'W', 52),
		  (3, 2824,'M', 24), (4, 2824,'W', 24), (5, 2824,'F', 24),
		  (6, 1876,'M', 16),
		  (7, 2224,'M', 22), (8, 2224,'W', 22), (9, 2224,'F', 22),
		  (10, 3549,'W', 39),
		  (11, 3514,'W', 34), (12, 3514,'F', 34),
		  (13, 3300,'M', 30), (14, 3300,'W', 30), (15, 3300,'F', 30),
		  (16, 5328,'W', 58),
		  (17, 4462,'M', 42),
		  (18, 1699,'M', 19),
          (19, 2010,'M', 20),(20, 2010,'W', 20),
          (21, 3813,'M', 33), (22, 3813,'W', 33);
-- End of Inserts


-- Query for QIII.1
        
-- choosing Boise airport
use flight;
With List1 AS(
WITH boise_market AS ( SELECT m.Market_ID, m.Start_Airport, m.End_Airport 
						FROM market m 
                        WHERE (Start_Airport ='BOI' OR End_Airport ='BOI') )
	 SELECT r.Airline_ID, r. Route_ID, bm.Start_Airport, bm.End_Airport, 
            r.Days_Operating, r.Schedule_Departure, r.Schedule_Arrival
     FROM route r
     JOIN boise_market bm ON (bm.Market_ID = r.Market_ID))
 SELECT * from List1; /* For total table OR comment out this line and uncomment any one line below to get several answers */
 -- SELECT COUNT(*) from List1 WHERE Start_Airport = 'BOI';  /* only 1 flight from Boise */
 -- SELECT COUNT(*) from List1 WHERE End_Airport = 'BOI'; /* 6 flights to Boise */


-- Query for QIII.2
-- Choose two airports for this query. (Denver and Boise)
-- List the airlines that fly routes both from the first airport, and to the second airport. 
-- To further clarify, show an airline only if it flies both from the first airport and to the second airport.

WITH Q2_eb AS
		(SELECT Start_Airport, End_Airport, market.Market_ID, Airline_ID
		FROM market
		JOIN route ON (market.Market_ID = route.Market_ID)
		WHERE (End_Airport ='BOI')),
Q2_sd AS
		(SELECT Start_Airport, End_Airport, market.Market_ID, Airline_ID
		FROM  market
		JOIN route ON (market.Market_ID = route.Market_ID)
		WHERE (Start_Airport = 'DEN'))
SELECT  Q2_eb.Airline_ID, ar.Airline_Abbreviation
FROM Q2_eb
JOIN  airline ar ON (Q2_eb.Airline_ID = ar.Airline_ID)
WHERE Q2_eb.Airline_ID = ANY(SELECT Q2_sd.Airline_ID FROM Q2_sd )
limit 1;

      
-- Query for QIII.3
--  Chose Wednesday of the week and  airline United. 
WITH Q3 AS (SELECT r.Route_ID, r.Route_Name, r. Airline_ID, a.Airline_Abbreviation 
FROM route r
join airline a ON (r.Airline_ID = a.Airline_ID)
Having a.Airline_Abbreviation != 'United')
SELECT Q3.Route_ID, Q3.Route_Name, Q3.Airline_Abbreviation, f.flight_Number, f.DayOfWeek 
FROM flight f
Join Q3 ON (Q3.Route_ID = f.Route_ID)
Having DayOfWeek != 'W';

