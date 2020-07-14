-- UserSettings (TSLEE)
-- Author: totalslacker

--Minimum City Distance
--Default Value in the base game is 3.  Set to 2 for TSL Earth, Cordiform Earth and Tiny Earth Maps. Can be set lower or higher for smaller or larger maps
INSERT INTO TSLEE_UserSettings (Type, Value)
VALUES
	('MIN_CITY_DISTANCE', 2);
	
--Loyal Capitals
--Set to 1 to enable Loyal Capitals. Set to 0 to disable.
INSERT INTO TSLEE_UserSettings (Type, Value)
VALUES
	('LOYAL_CAPITALS', 1);
	
--Loyalty Pressure
--Set to 1 to enable loyalty pressure values listed below
INSERT INTO TSLEE_UserSettings (Type, Value)
VALUES
	('LOYALTY_PRESSURE', 1);
	
--Loyalty Pressure Values
/* 
	1. LOYALTY_CAP_RANGE
	
	Default value in the base game is 10.  Default mod value is 6.  This number
	represents the number of tiles that pressure will extend from the capital city,
	including the tile that contains the capital city itself.  Capital cities
	generate extra pressure on top of other cities so this value can stack with
	the value below.
	
	2. LOYALTY_CITY_RANGE
	
	Default value in the base game is 10.  Default mod value is 6.  This number
	represents the number of tiles that pressure will extend from any given
	city that is not the capital, including the tile that contains the city itself.

	3. LOYALTY_MAX_PRESSURE
	
	Default value in the base game is 20.  Default mod value is 16.  This number
	represents the maximum possible pressure that can be exerted on any one tile.
	Not all tiles will reach the maximum pressure, as pressure decreases with 
	distance from the source.

 */
INSERT INTO TSLEE_UserSettings (Type, Value)
VALUES
	('LOYALTY_CAP_RANGE', 		6),
	('LOYALTY_CITY_RANGE', 		6),
	('LOYALTY_MAX_PRESSURE', 	16);