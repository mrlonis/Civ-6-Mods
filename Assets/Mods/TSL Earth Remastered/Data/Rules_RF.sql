-- Remove extra starting tiles from city-states
UPDATE CivilizationLevels SET StartingTilesForCity = StartingTilesForCity - 1 
WHERE CivilizationLevelType = 'CIVILIZATION_LEVEL_CITY_STATE' 
AND StartingTilesForCity > 5;

--City States don't gain tiles from influence and will never expand their borders. Uncomment below to activate.
-- UPDATE CivilizationLevels
-- SET CanAnnexTilesWithReceivedInfluence = 0
-- WHERE CivilizationLevelType = 'CIVILIZATION_LEVEL_CITY_STATE';

--City States gain tiles from culture but not influence. Uncomment below to activate.
-- UPDATE CivilizationLevels
-- SET CanAnnexTilesWithReceivedInfluence = 0, CanAnnexTilesWithCulture = 1
-- WHERE CivilizationLevelType = 'CIVILIZATION_LEVEL_CITY_STATE';