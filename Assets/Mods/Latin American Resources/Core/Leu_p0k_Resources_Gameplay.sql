--=============================================================================================================
-- LATIN AMERICAN RESOURCES: GAMEPLAY
--=============================================================================================================
-- Types
---------------------------------------------------------------------------------------------------------------
INSERT INTO Types
		(Type,							Kind)
VALUES	('RESOURCE_LEU_P0K_POTATOES',	'KIND_RESOURCE'),
		('RESOURCE_LEU_P0K_CAPYBARAS',	'KIND_RESOURCE'),
		('RESOURCE_LEU_P0K_COCA',		'KIND_RESOURCE'),
		('RESOURCE_LEU_P0K_LLAMAS',		'KIND_RESOURCE'),
		('RESOURCE_LEU_P0K_QUINOA',		'KIND_RESOURCE'),
		('RESOURCE_LEU_P0K_YERBAMATE',	'KIND_RESOURCE');
---------------------------------------------------------------------------------------------------------------
-- TypeTags
---------------------------------------------------------------------------------------------------------------
INSERT INTO TypeTags
		(Type,							Tag)
VALUES	('RESOURCE_LEU_P0K_POTATOES',	'CLASS_FOOD'),
		('RESOURCE_LEU_P0K_CAPYBARAS',	'CLASS_FOOD'),
		('RESOURCE_LEU_P0K_CAPYBARAS',	'CLASS_GOLD'),
		('RESOURCE_LEU_P0K_COCA',		'CLASS_GOLD'),
		('RESOURCE_LEU_P0K_LLAMAS',		'CLASS_PRODUCTION'),
		('RESOURCE_LEU_P0K_LLAMAS',		'CLASS_GOLD'),
		('RESOURCE_LEU_P0K_QUINOA',		'CLASS_FOOD'),
		('RESOURCE_LEU_P0K_QUINOA',		'CLASS_CULTURE'),
		('RESOURCE_LEU_P0K_YERBAMATE',	'CLASS_FOOD'),
		('RESOURCE_LEU_P0K_YERBAMATE',	'CLASS_PRODUCTION'),
		('RESOURCE_LEU_P0K_YERBAMATE',	'CLASS_GOLD');
---------------------------------------------------------------------------------------------------------------
-- Resources
---------------------------------------------------------------------------------------------------------------
INSERT INTO Resources
		(ResourceType,					Name,									ResourceClassType,		Happiness,	RequiresRiver,	Frequency)
VALUES	('RESOURCE_LEU_P0K_POTATOES',	'LOC_RESOURCE_LEU_P0K_POTATOES_NAME',	'RESOURCECLASS_BONUS',	0,			0,				6),
		('RESOURCE_LEU_P0K_CAPYBARAS',	'LOC_RESOURCE_LEU_P0K_CAPYBARAS_NAME',	'RESOURCECLASS_LUXURY',	4,			1,				2),
		('RESOURCE_LEU_P0K_COCA',		'LOC_RESOURCE_LEU_P0K_COCA_NAME',		'RESOURCECLASS_LUXURY',	4,			0,				2),
		('RESOURCE_LEU_P0K_LLAMAS',		'LOC_RESOURCE_LEU_P0K_LLAMAS_NAME',		'RESOURCECLASS_LUXURY',	4,			0,				2),
		('RESOURCE_LEU_P0K_QUINOA',		'LOC_RESOURCE_LEU_P0K_QUINOA_NAME',		'RESOURCECLASS_LUXURY',	4,			0,				2),
		('RESOURCE_LEU_P0K_YERBAMATE',	'LOC_RESOURCE_LEU_P0K_YERBAMATE_NAME',	'RESOURCECLASS_LUXURY',	4,			1,				2);
---------------------------------------------------------------------------------------------------------------
-- Resource_ValidTerrains
---------------------------------------------------------------------------------------------------------------
INSERT INTO Resource_ValidTerrains
		(ResourceType,					TerrainType)
VALUES	('RESOURCE_LEU_P0K_POTATOES',	'TERRAIN_PLAINS'),
		('RESOURCE_LEU_P0K_POTATOES',	'TERRAIN_PLAINS_HILLS'),
		('RESOURCE_LEU_P0K_POTATOES',	'TERRAIN_TUNDRA'),
		('RESOURCE_LEU_P0K_POTATOES',	'TERRAIN_TUNDRA_HILLS'),
		('RESOURCE_LEU_P0K_CAPYBARAS',	'TERRAIN_PLAINS'),
		('RESOURCE_LEU_P0K_CAPYBARAS',	'TERRAIN_PLAINS_HILLS'),
		('RESOURCE_LEU_P0K_LLAMAS',		'TERRAIN_PLAINS_HILLS'),
		('RESOURCE_LEU_P0K_LLAMAS',		'TERRAIN_TUNDRA_HILLS'),
		('RESOURCE_LEU_P0K_QUINOA',		'TERRAIN_PLAINS'),
		('RESOURCE_LEU_P0K_QUINOA',		'TERRAIN_PLAINS_HILLS'),
		('RESOURCE_LEU_P0K_QUINOA',		'TERRAIN_DESERT'),
		('RESOURCE_LEU_P0K_YERBAMATE',	'TERRAIN_GRASS'),
		('RESOURCE_LEU_P0K_YERBAMATE',	'TERRAIN_PLAINS');
---------------------------------------------------------------------------------------------------------------
-- Resource_ValidFeatures
---------------------------------------------------------------------------------------------------------------
INSERT INTO Resource_ValidFeatures
		(ResourceType,					FeatureType)
VALUES	('RESOURCE_LEU_P0K_CAPYBARAS',	'FEATURE_FOREST'),
		('RESOURCE_LEU_P0K_CAPYBARAS',	'FEATURE_JUNGLE'),
		('RESOURCE_LEU_P0K_COCA',		'FEATURE_JUNGLE'),
		('RESOURCE_LEU_P0K_YERBAMATE',	'FEATURE_FOREST'),
		('RESOURCE_LEU_P0K_YERBAMATE',	'FEATURE_JUNGLE');
---------------------------------------------------------------------------------------------------------------
-- Resource_Harvests
---------------------------------------------------------------------------------------------------------------
INSERT INTO Resource_Harvests
		(ResourceType,					YieldType,		Amount,		PrereqTech)
VALUES	('RESOURCE_LEU_P0K_POTATOES',	'YIELD_FOOD',	20,			'TECH_POTTERY');
---------------------------------------------------------------------------------------------------------------
-- Resource_YieldChanges
---------------------------------------------------------------------------------------------------------------
INSERT INTO Resource_YieldChanges
		(ResourceType,					YieldType,			YieldChange)
VALUES	('RESOURCE_LEU_P0K_POTATOES',	'YIELD_FOOD',		1),
		('RESOURCE_LEU_P0K_CAPYBARAS',	'YIELD_FOOD',		2),
		('RESOURCE_LEU_P0K_COCA',		'YIELD_FAITH',		1),
		('RESOURCE_LEU_P0K_COCA',		'YIELD_GOLD',		1),
		('RESOURCE_LEU_P0K_LLAMAS',		'YIELD_PRODUCTION',	1),
		('RESOURCE_LEU_P0K_LLAMAS',		'YIELD_GOLD',		1),
		('RESOURCE_LEU_P0K_QUINOA',		'YIELD_FOOD',		1),
		('RESOURCE_LEU_P0K_QUINOA',		'YIELD_CULTURE',	1),
		('RESOURCE_LEU_P0K_YERBAMATE',	'YIELD_FOOD',		1),
		('RESOURCE_LEU_P0K_YERBAMATE',	'YIELD_PRODUCTION',	1);
---------------------------------------------------------------------------------------------------------------
-- Improvement_ValidResources
---------------------------------------------------------------------------------------------------------------
INSERT INTO Improvement_ValidResources
		(ImprovementType,			ResourceType,					MustRemoveFeature)
VALUES	('IMPROVEMENT_FARM',		'RESOURCE_LEU_P0K_POTATOES',	0),
		('IMPROVEMENT_CAMP',		'RESOURCE_LEU_P0K_CAPYBARAS',	0),
		('IMPROVEMENT_PLANTATION',	'RESOURCE_LEU_P0K_COCA',		0),
		('IMPROVEMENT_PASTURE',		'RESOURCE_LEU_P0K_LLAMAS',		0),
		('IMPROVEMENT_FARM',		'RESOURCE_LEU_P0K_QUINOA',		0),
		('IMPROVEMENT_PLANTATION',	'RESOURCE_LEU_P0K_YERBAMATE',	0);