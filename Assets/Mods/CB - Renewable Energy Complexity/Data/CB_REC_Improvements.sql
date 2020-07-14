-- CB_REC_Improvements
-- Author: JNR
--------------------------------------------------------------

-- Improvements
--------------------------------------------------------------
UPDATE Improvements SET											Description='LOC_IMPROVEMENT_GEOTHERMAL_PLANT_DESCRIPTION_JNR_REC'		WHERE ImprovementType='IMPROVEMENT_GEOTHERMAL_PLANT';
UPDATE Improvements SET PrereqTech='TECH_SYNTHETIC_MATERIALS',	Description='LOC_IMPROVEMENT_WIND_FARM_DESCRIPTION_JNR_REC'				WHERE ImprovementType='IMPROVEMENT_WIND_FARM';
UPDATE Improvements SET PrereqTech='TECH_COMPOSITES',			Description='LOC_IMPROVEMENT_OFFSHORE_WIND_FARM_DESCRIPTION_JNR_REC'	WHERE ImprovementType='IMPROVEMENT_OFFSHORE_WIND_FARM';
UPDATE Improvements SET											Description='LOC_IMPROVEMENT_SOLAR_FARM_DESCRIPTION_JNR_REC'			WHERE ImprovementType='IMPROVEMENT_SOLAR_FARM';
UPDATE Improvements SET											Description='LOC_IMPROVEMENT_SEASTEAD_DESCRIPTION_JNR_REC'				WHERE ImprovementType='IMPROVEMENT_SEASTEAD';
--------------------------------------------------------------

-- Improvement_ValidTerrains
--------------------------------------------------------------
UPDATE Improvement_ValidTerrains SET PrereqTech='TECH_ADVANCED_POWER_CELLS' WHERE ImprovementType='IMPROVEMENT_SOLAR_FARM' AND TerrainType='TERRAIN_TUNDRA';

INSERT OR IGNORE INTO Improvement_ValidTerrains
		(ImprovementType,					TerrainType,		PrereqTech)
VALUES	('IMPROVEMENT_SOLAR_FARM',			'TERRAIN_SNOW',		'TECH_ADVANCED_POWER_CELLS'),
		('IMPROVEMENT_OFFSHORE_WIND_FARM',	'TERRAIN_OCEAN',	'TECH_SEASTEADS');
--------------------------------------------------------------

-- Improvement_ValidFeatures
--------------------------------------------------------------
INSERT OR IGNORE INTO Improvement_ValidFeatures
		(ImprovementType,					FeatureType)
VALUES	('IMPROVEMENT_GEOTHERMAL_PLANT',	'FEATURE_VOLCANIC_SOIL');
--------------------------------------------------------------

-- Improvement_YieldChanges
--------------------------------------------------------------
UPDATE Improvement_YieldChanges SET YieldChange=1 WHERE YieldType='YIELD_PRODUCTION'	AND ImprovementType='IMPROVEMENT_GEOTHERMAL_PLANT';
UPDATE Improvement_YieldChanges SET YieldChange=1 WHERE YieldType='YIELD_PRODUCTION'	AND ImprovementType='IMPROVEMENT_WIND_FARM';
UPDATE Improvement_YieldChanges SET YieldChange=1 WHERE YieldType='YIELD_PRODUCTION'	AND ImprovementType='IMPROVEMENT_OFFSHORE_WIND_FARM';
UPDATE Improvement_YieldChanges SET YieldChange=1 WHERE YieldType='YIELD_PRODUCTION'	AND ImprovementType='IMPROVEMENT_SOLAR_FARM';

UPDATE Improvement_YieldChanges SET YieldChange=1 WHERE YieldType='YIELD_GOLD'		AND ImprovementType='IMPROVEMENT_WIND_FARM';
UPDATE Improvement_YieldChanges SET YieldChange=1 WHERE YieldType='YIELD_GOLD'		AND ImprovementType='IMPROVEMENT_OFFSHORE_WIND_FARM';
UPDATE Improvement_YieldChanges SET YieldChange=1 WHERE YieldType='YIELD_GOLD'		AND ImprovementType='IMPROVEMENT_SOLAR_FARM';


INSERT OR IGNORE INTO Improvement_YieldChanges
		(ImprovementType,					YieldType,			YieldChange)
VALUES	('IMPROVEMENT_GEOTHERMAL_PLANT',	'YIELD_GOLD',		1),
		('IMPROVEMENT_OFFSHORE_WIND_FARM',	'YIELD_GOLD',		1),
		('IMPROVEMENT_WIND_FARM',			'YIELD_SCIENCE',	1),
		('IMPROVEMENT_OFFSHORE_WIND_FARM',	'YIELD_SCIENCE',	1),
		('IMPROVEMENT_SOLAR_FARM',			'YIELD_SCIENCE',	1);
--------------------------------------------------------------

-- Adjacency_YieldChanges
--------------------------------------------------------------
INSERT OR IGNORE INTO Adjacency_YieldChanges
		(ID,
		Description,
		YieldType,
		YieldChange,
		TilesRequired,
		AdjacentImprovement)
VALUES	('JNR_Seasteads_OffshoreWind_Gold',
		'Placeholder',
		'YIELD_GOLD',
		2,
		1,
		'IMPROVEMENT_OFFSHORE_WIND_FARM');
--------------------------------------------------------------

-- Improvement_Adjacencies
--------------------------------------------------------------
INSERT OR IGNORE INTO Improvement_Adjacencies
		(ImprovementType,			YieldChangeId)
VALUES	('IMPROVEMENT_SEASTEAD',	'JNR_Seasteads_OffshoreWind_Gold');
--------------------------------------------------------------

-- ModifierArguments
--------------------------------------------------------------
UPDATE ModifierArguments SET Value=1 WHERE Name='Amount' AND ModifierId='SOLAR_FARM_GENERATE_POWER';
UPDATE ModifierArguments SET Value=1 WHERE Name='Amount' AND ModifierId='WIND_FARM_GENERATE_POWER';
UPDATE ModifierArguments SET Value=2 WHERE Name='Amount' AND ModifierId='OFFSHORE_WIND_FARM_GENERATE_POWER';
UPDATE ModifierArguments SET Value=2 WHERE Name='Amount' AND ModifierId='GEOTHERMAL_GENERATE_POWER';
--------------------------------------------------------------

-- Modifiers
--------------------------------------------------------------
INSERT OR IGNORE INTO Modifiers
		(ModifierId,								ModifierType,								SubjectRequirementSetId)
VALUES	('JNR_GEOTHERMAL_PLANT_FISSURE_PRODUCTION',	'MODIFIER_SINGLE_PLOT_ADJUST_PLOT_YIELDS',	'PLOT_HAS_FISSURE_REQUIREMENTS_JNR'),
		('JNR_GEOTHERMAL_PLANT_FISSURE_GOLD',		'MODIFIER_SINGLE_PLOT_ADJUST_PLOT_YIELDS',	'PLOT_HAS_FISSURE_REQUIREMENTS_JNR'),
		('JNR_WIND_FARM_COASTAL_GOLD',				'MODIFIER_SINGLE_PLOT_ADJUST_PLOT_YIELDS',	'PLOT_IS_COASTAL_LAND_REQUIREMENTS'),
		('JNR_OFFSHORE_WIND_FARM_OCEAN_GOLD',		'MODIFIER_SINGLE_PLOT_ADJUST_PLOT_YIELDS',	'PLOT_HAS_OCEAN_REQUIREMENTS_JNR'),
		('JNR_SOLAR_FARM_GRASS_GOLD',				'MODIFIER_SINGLE_PLOT_ADJUST_PLOT_YIELDS',	'PLOT_HAS_GRASS_REQUIREMENTS_JNR'),
		('JNR_SOLAR_FARM_PLAINS_GOLD',				'MODIFIER_SINGLE_PLOT_ADJUST_PLOT_YIELDS',	'PLOT_HAS_PLAINS_REQUIREMENTS_JNR'),
		('JNR_SOLAR_FARM_DESERT_GOLD',				'MODIFIER_SINGLE_PLOT_ADJUST_PLOT_YIELDS',	'PLOT_HAS_DESERT_REQUIREMENTS_JNR');
--------------------------------------------------------------

-- ModifierArguments
--------------------------------------------------------------
INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,								Name,			Value)
VALUES	('JNR_GEOTHERMAL_PLANT_FISSURE_PRODUCTION',	'YieldType',	'YIELD_PRODUCTION'),
		('JNR_GEOTHERMAL_PLANT_FISSURE_PRODUCTION',	'Amount',		1),
		('JNR_GEOTHERMAL_PLANT_FISSURE_GOLD',		'YieldType',	'YIELD_GOLD'),
		('JNR_GEOTHERMAL_PLANT_FISSURE_GOLD',		'Amount',		2),
		('JNR_WIND_FARM_COASTAL_GOLD',				'YieldType',	'YIELD_GOLD'),
		('JNR_WIND_FARM_COASTAL_GOLD',				'Amount',		2),
		('JNR_OFFSHORE_WIND_FARM_OCEAN_GOLD',		'YieldType',	'YIELD_GOLD'),
		('JNR_OFFSHORE_WIND_FARM_OCEAN_GOLD',		'Amount',		2),
		('JNR_SOLAR_FARM_GRASS_GOLD',				'YieldType',	'YIELD_GOLD'),
		('JNR_SOLAR_FARM_GRASS_GOLD',				'Amount',		1),
		('JNR_SOLAR_FARM_PLAINS_GOLD',				'YieldType',	'YIELD_GOLD'),
		('JNR_SOLAR_FARM_PLAINS_GOLD',				'Amount',		1),
		('JNR_SOLAR_FARM_DESERT_GOLD',				'YieldType',	'YIELD_GOLD'),
		('JNR_SOLAR_FARM_DESERT_GOLD',				'Amount',		2);
--------------------------------------------------------------

-- ImprovementModifiers
--------------------------------------------------------------
INSERT OR IGNORE INTO ImprovementModifiers
		(ImprovementType,					ModifierId)
VALUES	('IMPROVEMENT_GEOTHERMAL_PLANT',	'JNR_GEOTHERMAL_PLANT_FISSURE_PRODUCTION'),
		('IMPROVEMENT_GEOTHERMAL_PLANT',	'JNR_GEOTHERMAL_PLANT_FISSURE_GOLD'),
		('IMPROVEMENT_WIND_FARM',			'JNR_WIND_FARM_COASTAL_GOLD'),
		('IMPROVEMENT_OFFSHORE_WIND_FARM',	'JNR_OFFSHORE_WIND_FARM_OCEAN_GOLD'),
		('IMPROVEMENT_SOLAR_FARM',			'JNR_SOLAR_FARM_GRASS_GOLD'),
		('IMPROVEMENT_SOLAR_FARM',			'JNR_SOLAR_FARM_PLAINS_GOLD'),
		('IMPROVEMENT_SOLAR_FARM',			'JNR_SOLAR_FARM_DESERT_GOLD');
--------------------------------------------------------------