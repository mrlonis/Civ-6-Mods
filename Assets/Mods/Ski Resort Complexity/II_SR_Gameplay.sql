-- II_SR_Gameplay
-- Author: JNR
--------------------------------------------------------------

-- TraitModifiers
--------------------------------------------------------------
INSERT OR IGNORE INTO TraitModifiers
		(TraitType,					ModifierId)
VALUES	('TRAIT_LEADER_MAJOR_CIV', 'TRAIT_WORK_GRASS_MOUNTAIN'),
		('TRAIT_LEADER_MAJOR_CIV', 'TRAIT_WORK_PLAINS_MOUNTAIN'),
		('TRAIT_LEADER_MAJOR_CIV', 'TRAIT_WORK_DESERT_MOUNTAIN'),
		('TRAIT_LEADER_MAJOR_CIV', 'TRAIT_WORK_TUNDRA_MOUNTAIN'),
		('TRAIT_LEADER_MAJOR_CIV', 'TRAIT_WORK_SNOW_MOUNTAIN');
--------------------------------------------------------------

-- Improvements
--------------------------------------------------------------
UPDATE	Improvements
SET		ValidAdjacentTerrainAmount=5,
		Workable=1,
		Description='LOC_IMPROVEMENT_SKI_RESORT_DESCRIPTION_JNR_II'
WHERE	ImprovementType='IMPROVEMENT_SKI_RESORT';
--------------------------------------------------------------

-- BaseGameText
--------------------------------------------------------------
DELETE	FROM Improvement_ValidTerrains
WHERE	ImprovementType='IMPROVEMENT_SKI_RESORT'
		AND TerrainType='TERRAIN_DESERT_MOUNTAIN';
--------------------------------------------------------------

-- Improvement_ValidAdjacentTerrains
--------------------------------------------------------------
INSERT OR IGNORE INTO Improvement_ValidAdjacentTerrains
		(ImprovementType,			TerrainType)
VALUES	('IMPROVEMENT_SKI_RESORT', 'TERRAIN_GRASS'),
		('IMPROVEMENT_SKI_RESORT', 'TERRAIN_GRASS_HILLS'),
		('IMPROVEMENT_SKI_RESORT', 'TERRAIN_GRASS_MOUNTAIN'),
		('IMPROVEMENT_SKI_RESORT', 'TERRAIN_PLAINS'),
		('IMPROVEMENT_SKI_RESORT', 'TERRAIN_PLAINS_HILLS'),
		('IMPROVEMENT_SKI_RESORT', 'TERRAIN_PLAINS_MOUNTAIN'),
		('IMPROVEMENT_SKI_RESORT', 'TERRAIN_DESERT'),
		('IMPROVEMENT_SKI_RESORT', 'TERRAIN_DESERT_HILLS'),
		('IMPROVEMENT_SKI_RESORT', 'TERRAIN_DESERT_MOUNTAIN'),
		('IMPROVEMENT_SKI_RESORT', 'TERRAIN_TUNDRA'),
		('IMPROVEMENT_SKI_RESORT', 'TERRAIN_TUNDRA_HILLS'),
		('IMPROVEMENT_SKI_RESORT', 'TERRAIN_TUNDRA_MOUNTAIN'),
		('IMPROVEMENT_SKI_RESORT', 'TERRAIN_SNOW'),
		('IMPROVEMENT_SKI_RESORT', 'TERRAIN_SNOW_HILLS'),
		('IMPROVEMENT_SKI_RESORT', 'TERRAIN_SNOW_MOUNTAIN');
--------------------------------------------------------------

-- Improvement_YieldChanges
--------------------------------------------------------------
INSERT OR IGNORE INTO Improvement_YieldChanges
		(ImprovementType,			YieldType,		YieldChange)
VALUES	('IMPROVEMENT_SKI_RESORT', 'YIELD_GOLD',	0),
		('IMPROVEMENT_SKI_RESORT', 'YIELD_CULTURE',	0);
--------------------------------------------------------------

-- Improvement_Adjacencies
--------------------------------------------------------------
INSERT OR IGNORE INTO Improvement_Adjacencies
		(ImprovementType,				YieldChangeId)
VALUES	('IMPROVEMENT_SKI_RESORT',		'JNR_Ski_GrassMountainAdjacency'),
		('IMPROVEMENT_SKI_RESORT',		'JNR_Ski_PlainsMountainAdjacency'),
		('IMPROVEMENT_SKI_RESORT',		'JNR_Ski_TundraMountainAdjacency'),
		('IMPROVEMENT_SKI_RESORT',		'JNR_Ski_SnowMountainAdjacency'),
		('IMPROVEMENT_SKI_RESORT',		'JNR_Ski_ForestAdjacency'),
		('IMPROVEMENT_SKI_RESORT',		'JNR_Ski_BeachResortAdjacency'),
		('IMPROVEMENT_SKI_RESORT',		'JNR_Ski_EntertainmentAdjacency'),
		('IMPROVEMENT_SKI_RESORT',		'JNR_Ski_WaterEntertainmentAdjacency'),
		('IMPROVEMENT_SKI_RESORT',		'JNR_Ski_HockeyAdjacency'),
		('IMPROVEMENT_BEACH_RESORT',	'JNR_Beach_SkiAdjacency');

INSERT OR IGNORE INTO Improvement_Adjacencies
		(ImprovementType,				YieldChangeId)
SELECT	'IMPROVEMENT_SKI_RESORT',		'JNR_Ski_Adjacency_'|| CivUniqueDistrictType
FROM	DistrictReplaces
WHERE	ReplacesDistrictType='DISTRICT_ENTERTAINMENT_COMPLEX';

INSERT OR IGNORE INTO Improvement_Adjacencies
		(ImprovementType,				YieldChangeId)
SELECT	'IMPROVEMENT_SKI_RESORT',		'JNR_Ski_Adjacency_'|| CivUniqueDistrictType
FROM	DistrictReplaces
WHERE	ReplacesDistrictType='DISTRICT_WATER_ENTERTAINMENT_COMPLEX';
--------------------------------------------------------------

-- Adjacency_YieldChanges
--------------------------------------------------------------
INSERT OR IGNORE INTO Adjacency_YieldChanges
		(ID,											Description,	YieldType,		YieldChange,	TilesRequired,	AdjacentTerrain,			AdjacentFeature,	AdjacentImprovement,				AdjacentDistrict)
VALUES	('JNR_Ski_GrassMountainAdjacency',				'Placeholder',	'YIELD_GOLD',	1,				1,				'TERRAIN_GRASS_MOUNTAIN',	NULL,				NULL,								NULL),
		('JNR_Ski_PlainsMountainAdjacency',				'Placeholder',	'YIELD_GOLD',	1,				1,				'TERRAIN_PLAINS_MOUNTAIN',	NULL,				NULL,								NULL),
		('JNR_Ski_TundraMountainAdjacency',				'Placeholder',	'YIELD_GOLD',	1,				1,				'TERRAIN_TUNDRA_MOUNTAIN',	NULL,				NULL,								NULL),
		('JNR_Ski_SnowMountainAdjacency',				'Placeholder',	'YIELD_GOLD',	1,				1,				'TERRAIN_SNOW_MOUNTAIN',	NULL,				NULL,								NULL),
		('JNR_Ski_ForestAdjacency',						'Placeholder',	'YIELD_GOLD',	1,				1,				NULL,						'FEATURE_FOREST',	NULL,								NULL),
		('JNR_Ski_BeachResortAdjacency',				'Placeholder',	'YIELD_GOLD',	1,				1,				NULL,						NULL,				'IMPROVEMENT_BEACH_RESORT',					NULL),
		('JNR_Ski_EntertainmentAdjacency',				'Placeholder',	'YIELD_GOLD',	1,				1,				NULL,						NULL,				NULL,							'DISTRICT_ENTERTAINMENT_COMPLEX'),
		('JNR_Ski_WaterEntertainmentAdjacency',			'Placeholder',	'YIELD_GOLD',	1,				1,				NULL,						NULL,				NULL,							'DISTRICT_WATER_ENTERTAINMENT_COMPLEX'),
		('JNR_Ski_HockeyAdjacency',						'Placeholder',	'YIELD_GOLD',	1,				1,				NULL,						NULL,				'IMPROVEMENT_ICE_HOCKEY_RINK',	NULL),
		('JNR_Beach_SkiAdjacency',						'Placeholder',	'YIELD_GOLD',	1,				1,				NULL,						NULL,				'IMPROVEMENT_SKI_RESORT',		NULL);

INSERT OR IGNORE INTO Adjacency_YieldChanges
		(ID,											Description,	YieldType,		YieldChange,	TilesRequired,	AdjacentDistrict)
SELECT	'JNR_Ski_Adjacency_'|| CivUniqueDistrictType,	'Placeholder',	'YIELD_GOLD',	1,				1,				CivUniqueDistrictType
FROM	DistrictReplaces
WHERE	ReplacesDistrictType='DISTRICT_ENTERTAINMENT_COMPLEX';

INSERT OR IGNORE INTO Adjacency_YieldChanges
		(ID,											Description,	YieldType,		YieldChange,	TilesRequired,	AdjacentDistrict)
SELECT	'JNR_Ski_Adjacency_'|| CivUniqueDistrictType,	'Placeholder',	'YIELD_GOLD',	1,				1,				CivUniqueDistrictType
FROM	DistrictReplaces
WHERE	ReplacesDistrictType='DISTRICT_WATER_ENTERTAINMENT_COMPLEX';
--------------------------------------------------------------

-- Improvement_Tourism
--------------------------------------------------------------
UPDATE	Improvement_Tourism
SET		TourismSource='TOURISMSOURCE_GOLD'
WHERE	ImprovementType='IMPROVEMENT_SKI_RESORT'
		AND TourismSource='TOURISMSOURCE_APPEAL';
--------------------------------------------------------------

-- Requirements
--------------------------------------------------------------
INSERT OR IGNORE INTO Requirements
		(RequirementId,							RequirementType)
VALUES	('REQUIRES_JNR_PLOT_HAS_SKI_RESORT',	'REQUIREMENT_PLOT_IMPROVEMENT_TYPE_MATCHES');
--------------------------------------------------------------

-- RequirementArguments
--------------------------------------------------------------
INSERT OR IGNORE INTO RequirementArguments
		(RequirementId,							Name,				Value)
VALUES	('REQUIRES_JNR_PLOT_HAS_SKI_RESORT',	'ImprovementType',	'IMPROVEMENT_SKI_RESORT');
--------------------------------------------------------------

-- RequirementSets
--------------------------------------------------------------
INSERT OR IGNORE INTO RequirementSets
		(RequirementSetId,			RequirementSetType)
VALUES	('PLOT_IS_SKI_RESORT_JNR',	'REQUIREMENTSET_TEST_ALL');
--------------------------------------------------------------

-- RequirementSetRequirements
--------------------------------------------------------------
INSERT OR IGNORE INTO RequirementSetRequirements
		(RequirementSetId,			RequirementId)
VALUES	('PLOT_IS_SKI_RESORT_JNR',	'REQUIRES_JNR_PLOT_HAS_SKI_RESORT');
--------------------------------------------------------------

-- Modifiers
--------------------------------------------------------------
INSERT OR IGNORE INTO Modifiers
		(ModifierId,				ModifierType,							SubjectRequirementSetId)
VALUES	('JNR_ASRS_SKI_CULTURE',	'MODIFIER_PLAYER_ADJUST_PLOT_YIELD',	'PLOT_IS_SKI_RESORT_JNR');
--------------------------------------------------------------

-- ModifierArguments
--------------------------------------------------------------
INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,				Name,			Value)
VALUES	('JNR_ASRS_SKI_CULTURE',	'YieldType',	'YIELD_CULTURE'),
		('JNR_ASRS_SKI_CULTURE',	'Amount',		1);
--------------------------------------------------------------

-- BuildingModifiers
--------------------------------------------------------------
INSERT OR IGNORE INTO BuildingModifiers
		(BuildingType,	ModifierId)
SELECT	BuildingType,	'JNR_ASRS_SKI_CULTURE'
FROM	Buildings
WHERE	BuildingType='BUILDING_AMUNDSEN_SCOTT_RESEARCH_STATION';
--------------------------------------------------------------