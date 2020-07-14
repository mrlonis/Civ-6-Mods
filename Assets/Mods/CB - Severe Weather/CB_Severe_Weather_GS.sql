-- CB_Severe_Weather_GS
-- Author: JNR
--------------------------------------------------------------

-- RandomEvents
--------------------------------------------------------------
UPDATE RandomEvents SET ChanceIncreasePerDegree=20	WHERE RandomEventType='RANDOM_EVENT_FLOOD_MODERATE';		-- was 20
UPDATE RandomEvents SET ChanceIncreasePerDegree=30	WHERE RandomEventType='RANDOM_EVENT_FLOOD_MAJOR';			-- was 20
UPDATE RandomEvents SET ChanceIncreasePerDegree=40	WHERE RandomEventType='RANDOM_EVENT_FLOOD_1000_YEAR';		-- was 20

UPDATE RandomEvents SET ChanceIncreasePerDegree=30	WHERE RandomEventType='RANDOM_EVENT_BLIZZARD_CRIPPLING';	-- was 50
UPDATE RandomEvents SET ChanceIncreasePerDegree=60	WHERE RandomEventType='RANDOM_EVENT_DUST_STORM_HABOOB';		-- was 50
UPDATE RandomEvents SET ChanceIncreasePerDegree=60	WHERE RandomEventType='RANDOM_EVENT_TORNADO_OUTBREAK';		-- was 50
UPDATE RandomEvents SET ChanceIncreasePerDegree=60	WHERE RandomEventType='RANDOM_EVENT_HURRICANE_CAT_5';		-- was 50
UPDATE RandomEvents SET ChanceIncreasePerDegree=20	WHERE RandomEventType='RANDOM_EVENT_DROUGHT_MAJOR';			-- was 0
UPDATE RandomEvents SET ChanceIncreasePerDegree=60	WHERE RandomEventType='RANDOM_EVENT_DROUGHT_EXTREME';		-- was 50

UPDATE RandomEvents SET MitigatedYieldReduction=75	WHERE RandomEventType='RANDOM_EVENT_FLOOD_MODERATE';		-- was 50
UPDATE RandomEvents SET MitigatedYieldReduction=75	WHERE RandomEventType='RANDOM_EVENT_FLOOD_MAJOR';			-- was 50
UPDATE RandomEvents SET MitigatedYieldReduction=75	WHERE RandomEventType='RANDOM_EVENT_FLOOD_1000_YEAR';		-- was 50

UPDATE RandomEvents SET HaltsStormFertility=1		WHERE RandomEventType='RANDOM_EVENT_SEA_LEVEL_RISE3';		-- was 0
UPDATE RandomEvents SET HaltsFloodFertility=1		WHERE RandomEventType='RANDOM_EVENT_SEA_LEVEL_RISE3';		-- was 0
UPDATE RandomEvents SET FertilityRemovalChance=20	WHERE RandomEventType='RANDOM_EVENT_SEA_LEVEL_RISE4';		-- was 0
UPDATE RandomEvents SET FertilityRemovalChance=40	WHERE RandomEventType='RANDOM_EVENT_SEA_LEVEL_RISE5';		-- was 15
UPDATE RandomEvents SET FertilityRemovalChance=60	WHERE RandomEventType='RANDOM_EVENT_SEA_LEVEL_RISE6';		-- was 30
UPDATE RandomEvents SET FertilityRemovalChance=80	WHERE RandomEventType='RANDOM_EVENT_SEA_LEVEL_RISE7';		-- was 45

UPDATE RandomEvents SET Description='LOC_RANDOM_EVENT_SEA_LEVEL_RISE4_LONG_DESCRIPTION'			WHERE RandomEventType='RANDOM_EVENT_SEA_LEVEL_RISE3';
UPDATE RandomEvents SET Description='LOC_RANDOM_EVENT_SEA_LEVEL_RISE5_LONG_DESCRIPTION'			WHERE RandomEventType='RANDOM_EVENT_SEA_LEVEL_RISE4';
UPDATE RandomEvents SET Description='LOC_RANDOM_EVENT_SEA_LEVEL_RISE6_LONG_DESCRIPTION'			WHERE RandomEventType='RANDOM_EVENT_SEA_LEVEL_RISE5';
UPDATE RandomEvents SET Description='LOC_RANDOM_EVENT_SEA_LEVEL_RISE7_LONG_DESCRIPTION'			WHERE RandomEventType='RANDOM_EVENT_SEA_LEVEL_RISE6';
UPDATE RandomEvents SET Description='LOC_RANDOM_EVENT_SEA_LEVEL_RISE7_LONG_DESCRIPTION_JNR_CB'	WHERE RandomEventType='RANDOM_EVENT_SEA_LEVEL_RISE7';
--------------------------------------------------------------

-- RandomEvent_Terrains
--------------------------------------------------------------
INSERT OR IGNORE INTO RandomEvent_Terrains
		(RandomEventType,					TerrainType)
VALUES	('RANDOM_EVENT_DROUGHT_MAJOR',		'TERRAIN_DESERT'),
		('RANDOM_EVENT_DROUGHT_MAJOR',		'TERRAIN_DESERT_HILLS'),
		('RANDOM_EVENT_DROUGHT_EXTREME',	'TERRAIN_DESERT'),
		('RANDOM_EVENT_DROUGHT_EXTREME',	'TERRAIN_DESERT_HILLS');
--------------------------------------------------------------

-- RandomEvent_Damages
--------------------------------------------------------------
-- Blizzards
UPDATE RandomEvent_Damages SET Percentage=15								WHERE RandomEventType='RANDOM_EVENT_BLIZZARD_SIGNIFICANT'	AND DamageType='IMPROVEMENT_DESTROYED';	-- was 25
UPDATE RandomEvent_Damages SET Percentage=30								WHERE RandomEventType='RANDOM_EVENT_BLIZZARD_SIGNIFICANT'	AND DamageType='IMPROVEMENT_PILLAGED';	-- was 50
UPDATE RandomEvent_Damages SET Percentage=20								WHERE RandomEventType='RANDOM_EVENT_BLIZZARD_SIGNIFICANT'	AND DamageType='DISTRICT_PILLAGED';		-- was 15
UPDATE RandomEvent_Damages SET Percentage=50								WHERE RandomEventType='RANDOM_EVENT_BLIZZARD_SIGNIFICANT'	AND DamageType='BUILDING_PILLAGED';		-- was 40

UPDATE RandomEvent_Damages SET Percentage=30								WHERE RandomEventType='RANDOM_EVENT_BLIZZARD_CRIPPLING'		AND DamageType='IMPROVEMENT_DESTROYED';	-- was 50
UPDATE RandomEvent_Damages SET Percentage=60								WHERE RandomEventType='RANDOM_EVENT_BLIZZARD_CRIPPLING'		AND DamageType='IMPROVEMENT_PILLAGED';	-- was 100
UPDATE RandomEvent_Damages SET Percentage=40								WHERE RandomEventType='RANDOM_EVENT_BLIZZARD_CRIPPLING'		AND DamageType='DISTRICT_PILLAGED';		-- was 50
UPDATE RandomEvent_Damages SET Percentage=100								WHERE RandomEventType='RANDOM_EVENT_BLIZZARD_CRIPPLING'		AND DamageType='BUILDING_PILLAGED';		-- was 100

UPDATE RandomEvent_Damages SET Percentage=15								WHERE RandomEventType='RANDOM_EVENT_BLIZZARD_CRIPPLING'		AND DamageType='POPULATION_LOSS';		-- was 15
UPDATE RandomEvent_Damages SET Percentage=40								WHERE RandomEventType='RANDOM_EVENT_BLIZZARD_CRIPPLING'		AND DamageType='UNIT_KILLED_CIVILIAN';	-- was 20
UPDATE RandomEvent_Damages SET Percentage=100, MinHP=50, MaxHP=70			WHERE RandomEventType='RANDOM_EVENT_BLIZZARD_CRIPPLING'		AND DamageType='UNIT_DAMAGE_LAND';		-- was 100,40,60
UPDATE RandomEvent_Damages SET Percentage=75,  MinHP=40, MaxHP=60			WHERE RandomEventType='RANDOM_EVENT_BLIZZARD_CRIPPLING'		AND DamageType='UNIT_DAMAGE_NAVAL';		-- was 60,40,60

-- Dust Storms
UPDATE RandomEvent_Damages SET Percentage=50								WHERE RandomEventType='RANDOM_EVENT_DUST_STORM_GRADIENT'	AND DamageType='IMPROVEMENT_DESTROYED';	-- was 35
UPDATE RandomEvent_Damages SET Percentage=75								WHERE RandomEventType='RANDOM_EVENT_DUST_STORM_GRADIENT'	AND DamageType='IMPROVEMENT_PILLAGED';	-- was 75
UPDATE RandomEvent_Damages SET Percentage=50								WHERE RandomEventType='RANDOM_EVENT_DUST_STORM_GRADIENT'	AND DamageType='DISTRICT_PILLAGED';		-- was 20
UPDATE RandomEvent_Damages SET Percentage=50								WHERE RandomEventType='RANDOM_EVENT_DUST_STORM_GRADIENT'	AND DamageType='BUILDING_PILLAGED';		-- was 60

UPDATE RandomEvent_Damages SET Percentage=75								WHERE RandomEventType='RANDOM_EVENT_DUST_STORM_HABOOB'		AND DamageType='IMPROVEMENT_DESTROYED';	-- was 75
UPDATE RandomEvent_Damages SET Percentage=100								WHERE RandomEventType='RANDOM_EVENT_DUST_STORM_HABOOB'		AND DamageType='IMPROVEMENT_PILLAGED';	-- was 100
UPDATE RandomEvent_Damages SET Percentage=75								WHERE RandomEventType='RANDOM_EVENT_DUST_STORM_HABOOB'		AND DamageType='DISTRICT_PILLAGED';		-- was 75
UPDATE RandomEvent_Damages SET Percentage=100								WHERE RandomEventType='RANDOM_EVENT_DUST_STORM_HABOOB'		AND DamageType='BUILDING_PILLAGED';		-- was 100

UPDATE RandomEvent_Damages SET Percentage=10								WHERE RandomEventType='RANDOM_EVENT_DUST_STORM_HABOOB'		AND DamageType='POPULATION_LOSS';		-- was 20
UPDATE RandomEvent_Damages SET Percentage=20								WHERE RandomEventType='RANDOM_EVENT_DUST_STORM_HABOOB'		AND DamageType='UNIT_KILLED_CIVILIAN';	-- was 20
UPDATE RandomEvent_Damages SET Percentage=100, MinHP=50, MaxHP=70			WHERE RandomEventType='RANDOM_EVENT_DUST_STORM_HABOOB'		AND DamageType='UNIT_DAMAGE_LAND';		-- was 100,40,60
UPDATE RandomEvent_Damages SET Percentage=50,  MinHP=20, MaxHP=40			WHERE RandomEventType='RANDOM_EVENT_DUST_STORM_HABOOB'		AND DamageType='UNIT_DAMAGE_NAVAL';		-- was 60,40,60

-- Tornados
UPDATE RandomEvent_Damages SET Percentage=25								WHERE RandomEventType='RANDOM_EVENT_TORNADO_FAMILY'			AND DamageType='IMPROVEMENT_DESTROYED';	-- was 35
UPDATE RandomEvent_Damages SET Percentage=50								WHERE RandomEventType='RANDOM_EVENT_TORNADO_FAMILY'			AND DamageType='IMPROVEMENT_PILLAGED';	-- was 75
UPDATE RandomEvent_Damages SET Percentage=10								WHERE RandomEventType='RANDOM_EVENT_TORNADO_FAMILY'			AND DamageType='DISTRICT_PILLAGED';		-- was 20
UPDATE RandomEvent_Damages SET Percentage=40								WHERE RandomEventType='RANDOM_EVENT_TORNADO_FAMILY'			AND DamageType='BUILDING_PILLAGED';		-- was 60

UPDATE RandomEvent_Damages SET Percentage=50								WHERE RandomEventType='RANDOM_EVENT_TORNADO_OUTBREAK'		AND DamageType='IMPROVEMENT_DESTROYED';	-- was 75
UPDATE RandomEvent_Damages SET Percentage=100								WHERE RandomEventType='RANDOM_EVENT_TORNADO_OUTBREAK'		AND DamageType='IMPROVEMENT_PILLAGED';	-- was 100
UPDATE RandomEvent_Damages SET Percentage=20								WHERE RandomEventType='RANDOM_EVENT_TORNADO_OUTBREAK'		AND DamageType='DISTRICT_PILLAGED';		-- was 75
UPDATE RandomEvent_Damages SET Percentage=80								WHERE RandomEventType='RANDOM_EVENT_TORNADO_OUTBREAK'		AND DamageType='BUILDING_PILLAGED';		-- was 100

UPDATE RandomEvent_Damages SET Percentage=10								WHERE RandomEventType='RANDOM_EVENT_TORNADO_OUTBREAK'		AND DamageType='POPULATION_LOSS';		-- was 20
UPDATE RandomEvent_Damages SET Percentage=40								WHERE RandomEventType='RANDOM_EVENT_TORNADO_OUTBREAK'		AND DamageType='UNIT_KILLED_CIVILIAN';	-- was 20
UPDATE RandomEvent_Damages SET Percentage=75, MinHP=30, MaxHP=50			WHERE RandomEventType='RANDOM_EVENT_TORNADO_OUTBREAK'		AND DamageType='UNIT_DAMAGE_LAND';		-- was 100,40,60
UPDATE RandomEvent_Damages SET Percentage=75, MinHP=40, MaxHP=60			WHERE RandomEventType='RANDOM_EVENT_TORNADO_OUTBREAK'		AND DamageType='UNIT_DAMAGE_NAVAL';		-- was 100,40,60

-- Hurricanes
UPDATE RandomEvent_Damages SET Percentage=25, CoastalLowlandPercentage=50	WHERE RandomEventType='RANDOM_EVENT_HURRICANE_CAT_4'		AND DamageType='IMPROVEMENT_DESTROYED';	-- was 25
UPDATE RandomEvent_Damages SET Percentage=50, CoastalLowlandPercentage=100	WHERE RandomEventType='RANDOM_EVENT_HURRICANE_CAT_4'		AND DamageType='IMPROVEMENT_PILLAGED';	-- was 50,100
UPDATE RandomEvent_Damages SET Percentage=25, CoastalLowlandPercentage=50	WHERE RandomEventType='RANDOM_EVENT_HURRICANE_CAT_4'		AND DamageType='DISTRICT_PILLAGED';		-- was 15,100
UPDATE RandomEvent_Damages SET Percentage=35, CoastalLowlandPercentage=70	WHERE RandomEventType='RANDOM_EVENT_HURRICANE_CAT_4'		AND DamageType='BUILDING_PILLAGED';		-- was 40
UPDATE RandomEvent_Damages SET Percentage=75, MinHP=40, MaxHP=60			WHERE RandomEventType='RANDOM_EVENT_HURRICANE_CAT_4'		AND DamageType='UNIT_DAMAGE_NAVAL';		-- was 60,40,60

UPDATE RandomEvent_Damages SET Percentage=50, CoastalLowlandPercentage=100	WHERE RandomEventType='RANDOM_EVENT_HURRICANE_CAT_5'		AND DamageType='IMPROVEMENT_DESTROYED';	-- was 50
UPDATE RandomEvent_Damages SET Percentage=100								WHERE RandomEventType='RANDOM_EVENT_HURRICANE_CAT_5'		AND DamageType='IMPROVEMENT_PILLAGED';	-- was 100
UPDATE RandomEvent_Damages SET Percentage=50, CoastalLowlandPercentage=75	WHERE RandomEventType='RANDOM_EVENT_HURRICANE_CAT_5'		AND DamageType='DISTRICT_PILLAGED';		-- was 50, 100
UPDATE RandomEvent_Damages SET Percentage=75, CoastalLowlandPercentage=100	WHERE RandomEventType='RANDOM_EVENT_HURRICANE_CAT_5'		AND DamageType='BUILDING_PILLAGED';		-- was 100

UPDATE RandomEvent_Damages SET Percentage=15								WHERE RandomEventType='RANDOM_EVENT_HURRICANE_CAT_5'		AND DamageType='POPULATION_LOSS';		-- was 15
UPDATE RandomEvent_Damages SET Percentage=20								WHERE RandomEventType='RANDOM_EVENT_HURRICANE_CAT_5'		AND DamageType='UNIT_KILLED_CIVILIAN';	-- was 20
UPDATE RandomEvent_Damages SET Percentage=50,  MinHP=40, MaxHP=60			WHERE RandomEventType='RANDOM_EVENT_HURRICANE_CAT_5'		AND DamageType='UNIT_DAMAGE_LAND';		-- was 100,40,60
UPDATE RandomEvent_Damages SET Percentage=100, MinHP=70, MaxHP=90			WHERE RandomEventType='RANDOM_EVENT_HURRICANE_CAT_5'		AND DamageType='UNIT_DAMAGE_NAVAL';		-- was 100,60,80

-- Droughts
UPDATE RandomEvent_Damages SET Percentage=50								WHERE RandomEventType='RANDOM_EVENT_DROUGHT_EXTREME'		AND DamageType='SPECIFIC_IMPROVEMENT_DESTROYED';	-- was 30

INSERT OR IGNORE INTO RandomEvent_Damages
		(RandomEventType,				DamageType,							Percentage)
VALUES	('RANDOM_EVENT_DROUGHT_MAJOR',	'SPECIFIC_IMPROVEMENT_DESTROYED',	25);
--------------------------------------------------------------

-- RandomEvent_Yields
--------------------------------------------------------------
-- Yield Adjuments
UPDATE RandomEvent_Yields SET Percentage=10 WHERE RandomEventType='RANDOM_EVENT_DUST_STORM_GRADIENT'	AND YieldType='YIELD_FOOD';			-- was 10
UPDATE RandomEvent_Yields SET Percentage=5  WHERE RandomEventType='RANDOM_EVENT_DUST_STORM_GRADIENT'	AND YieldType='YIELD_PRODUCTION';	-- was 20
UPDATE RandomEvent_Yields SET Percentage=10 WHERE RandomEventType='RANDOM_EVENT_DUST_STORM_HABOOB'		AND YieldType='YIELD_FOOD';			-- was 20
UPDATE RandomEvent_Yields SET Percentage=10 WHERE RandomEventType='RANDOM_EVENT_DUST_STORM_HABOOB'		AND YieldType='YIELD_PRODUCTION';	-- was 30

UPDATE RandomEvent_Yields SET Percentage=30 WHERE RandomEventType='RANDOM_EVENT_HURRICANE_CAT_4'		AND YieldType='YIELD_FOOD';			-- was 30
UPDATE RandomEvent_Yields SET Percentage=30 WHERE RandomEventType='RANDOM_EVENT_HURRICANE_CAT_5'		AND YieldType='YIELD_FOOD';			-- was 45
UPDATE RandomEvent_Yields SET Percentage=10 WHERE RandomEventType='RANDOM_EVENT_HURRICANE_CAT_5'		AND YieldType='YIELD_PRODUCTION';	-- was 15

-- New Special Yields
INSERT OR IGNORE INTO RandomEvent_Yields
		(RandomEventType,					YieldType,			FeatureType,						Percentage,	ReplaceFeature)
VALUES	('RANDOM_EVENT_FLOOD_MODERATE',		'YIELD_CULTURE',	'FEATURE_FLOODPLAINS',				5,			0),
		('RANDOM_EVENT_FLOOD_MODERATE',		'YIELD_CULTURE',	'FEATURE_FLOODPLAINS_GRASSLAND',	5,			0),
		('RANDOM_EVENT_FLOOD_MODERATE',		'YIELD_CULTURE',	'FEATURE_FLOODPLAINS_PLAINS',		5,			0),
		('RANDOM_EVENT_FLOOD_MAJOR',		'YIELD_CULTURE',	'FEATURE_FLOODPLAINS',				10,			0),
		('RANDOM_EVENT_FLOOD_MAJOR',		'YIELD_CULTURE',	'FEATURE_FLOODPLAINS_GRASSLAND',	10,			0),
		('RANDOM_EVENT_FLOOD_MAJOR',		'YIELD_CULTURE',	'FEATURE_FLOODPLAINS_PLAINS',		10,			0),
		('RANDOM_EVENT_FLOOD_1000_YEAR',	'YIELD_CULTURE',	'FEATURE_FLOODPLAINS',				15,			0),
		('RANDOM_EVENT_FLOOD_1000_YEAR',	'YIELD_CULTURE',	'FEATURE_FLOODPLAINS_GRASSLAND',	15,			0),
		('RANDOM_EVENT_FLOOD_1000_YEAR',	'YIELD_CULTURE',	'FEATURE_FLOODPLAINS_PLAINS',		15,			0),
		('RANDOM_EVENT_BLIZZARD_CRIPPLING',	'YIELD_SCIENCE',	'FEATURE_ICE',						5,			1),
		('RANDOM_EVENT_DUST_STORM_HABOOB',	'YIELD_GOLD',		'FEATURE_ICE',						5,			1),
		('RANDOM_EVENT_TORNADO_OUTBREAK',	'YIELD_FAITH',		'FEATURE_ICE',						5,			1),
		('RANDOM_EVENT_HURRICANE_CAT_5',	'YIELD_GOLD',		'FEATURE_ICE',						5,			1);

-- Wetlands Compatibility for Tundra Floodplains
INSERT OR IGNORE INTO RandomEvent_Yields
		(RandomEventType,					YieldType,			FeatureType,						Percentage,	ReplaceFeature)
SELECT	'RANDOM_EVENT_FLOOD_MODERATE',		'YIELD_CULTURE',	FeatureType,						5,			0
FROM	Features
WHERE	FeatureType='FEATURE_FLOODPLAINS_TUNDRA';

INSERT OR IGNORE INTO RandomEvent_Yields
		(RandomEventType,					YieldType,			FeatureType,						Percentage,	ReplaceFeature)
SELECT	'RANDOM_EVENT_FLOOD_MAJOR',			'YIELD_CULTURE',	FeatureType,						10,			0
FROM	Features
WHERE	FeatureType='FEATURE_FLOODPLAINS_TUNDRA';

INSERT OR IGNORE INTO RandomEvent_Yields
		(RandomEventType,					YieldType,			FeatureType,						Percentage,	ReplaceFeature)
SELECT	'RANDOM_EVENT_FLOOD_1000_YEAR',		'YIELD_CULTURE',	FeatureType,						15,			0
FROM	Features
WHERE	FeatureType='FEATURE_FLOODPLAINS_TUNDRA';
--------------------------------------------------------------