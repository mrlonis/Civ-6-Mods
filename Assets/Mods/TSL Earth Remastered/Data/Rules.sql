--Minimum City Range
UPDATE GlobalParameters 
SET Value = (SELECT Value FROM TSLEE_UserSettings WHERE Type = 'MIN_CITY_DISTANCE')	
WHERE Name = 'CITY_MIN_RANGE';

-- City states don't gain tiles, default is CanAnnexTilesWithReceivedInfluence = 1
-- UPDATE CivilizationLevels
-- SET CanAnnexTilesWithReceivedInfluence = 0
-- WHERE CivilizationLevelType = 'CIVILIZATION_LEVEL_CITY_STATE';