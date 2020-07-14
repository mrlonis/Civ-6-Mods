-- UC_Light_REL
-- Author: JNR
--------------------------------------------------------------

-- Buildings
--------------------------------------------------------------
UPDATE Buildings SET Description='LOC_BUILDING_TEMPLE_DESCRIPTION_UC_JNR_LIGHT'			WHERE BuildingType='BUILDING_TEMPLE';
UPDATE Buildings SET Description='LOC_BUILDING_STAVE_CHURCH_DESCRIPTION_UC_JNR_LIGHT'	WHERE BuildingType='BUILDING_STAVE_CHURCH';
UPDATE Buildings SET Description='LOC_BUILDING_PRASAT_DESCRIPTION_UC_JNR_LIGHT'			WHERE BuildingType='BUILDING_PRASAT';
--------------------------------------------------------------

-- Building_YieldChanges
--------------------------------------------------------------
UPDATE Building_YieldChanges SET YieldChange=2 WHERE BuildingType='BUILDING_TEMPLE' AND YieldType='YIELD_FAITH';
--------------------------------------------------------------

-- Modifiers
--------------------------------------------------------------
INSERT OR IGNORE INTO Modifiers
		(ModifierId,							ModifierType)
VALUES	('JNR_TEMPLE_FAITH_POPULATION_LIGHT',	'MODIFIER_SINGLE_CITY_ADJUST_CITY_YIELD_PER_POPULATION');
--------------------------------------------------------------

-- ModifierArguments
--------------------------------------------------------------
INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,							Name,			Value)
VALUES	('JNR_TEMPLE_FAITH_POPULATION_LIGHT',	'YieldType',	'YIELD_FAITH'),
		('JNR_TEMPLE_FAITH_POPULATION_LIGHT',	'Amount',		0.2);
--------------------------------------------------------------

-- BuildingModifiers
--------------------------------------------------------------
INSERT OR IGNORE INTO BuildingModifiers
		(BuildingType,				ModifierId)
VALUES	('BUILDING_TEMPLE',			'JNR_TEMPLE_FAITH_POPULATION_LIGHT');

INSERT OR IGNORE INTO BuildingModifiers
		(BuildingType,				ModifierId)
SELECT	'BUILDING_STAVE_CHURCH',	'JNR_TEMPLE_FAITH_POPULATION_LIGHT'
FROM	Buildings
WHERE	BuildingType='BUILDING_STAVE_CHURCH';

INSERT OR IGNORE INTO BuildingModifiers
		(BuildingType,				ModifierId)
SELECT	'BUILDING_PRASAT',			'JNR_TEMPLE_FAITH_POPULATION_LIGHT'
FROM	Buildings
WHERE	BuildingType='BUILDING_PRASAT';
--------------------------------------------------------------
