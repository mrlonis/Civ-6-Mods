-- UC_Light_PRD
-- Author: JNR
--------------------------------------------------------------

-- Buildings
--------------------------------------------------------------
UPDATE Buildings SET Description='LOC_BUILDING_WORKSHOP_DESCRIPTION_UC_JNR_LIGHT'					WHERE BuildingType='BUILDING_WORKSHOP';
UPDATE Buildings SET Description= NULL																WHERE BuildingType='BUILDING_FACTORY';
UPDATE Buildings SET Description='LOC_BUILDING_ELECTRONICS_FACTORY_DESCRIPTION_UC_JNR_LIGHT'		WHERE BuildingType='BUILDING_ELECTRONICS_FACTORY';
UPDATE Buildings SET Description='LOC_BUILDING_COAL_POWER_PLANT_DESCRIPTION_UC_JNR_LIGHT'			WHERE BuildingType='BUILDING_COAL_POWER_PLANT';
UPDATE Buildings SET Description='LOC_BUILDING_FOSSIL_FUEL_POWER_PLANT_DESCRIPTION_UC_JNR_LIGHT'	WHERE BuildingType='BUILDING_FOSSIL_FUEL_POWER_PLANT';
UPDATE Buildings SET Description='LOC_BUILDING_POWER_PLANT_DESCRIPTION_UC_JNR_LIGHT'				WHERE BuildingType='BUILDING_POWER_PLANT';

UPDATE Buildings SET Description='LOC_BUILDING_JNR_RENEWABLE_DISTRIBUTION_DESCRIPTION_UC_JNR_LIGHT'	WHERE BuildingType='BUILDING_JNR_RENEWABLE_DISTRIBUTION';

UPDATE Buildings SET RegionalRange=0 WHERE BuildingType='BUILDING_FACTORY';
UPDATE Buildings SET RegionalRange=0 WHERE BuildingType='BUILDING_ELECTRONICS_FACTORY';
UPDATE Buildings SET RegionalRange=6 WHERE BuildingType='BUILDING_COAL_POWER_PLANT';
--------------------------------------------------------------

-- Building_YieldChanges
--------------------------------------------------------------
UPDATE Building_YieldChanges SET YieldChange=2	WHERE BuildingType='BUILDING_WORKSHOP'				AND YieldType='YIELD_PRODUCTION';
DELETE FROM Building_YieldChanges				WHERE BuildingType='BUILDING_FACTORY'				AND YieldType='YIELD_PRODUCTION';
DELETE FROM Building_YieldChanges				WHERE BuildingType='BUILDING_ELECTRONICS_FACTORY'	AND YieldType='YIELD_PRODUCTION';

INSERT OR IGNORE INTO Building_YieldChanges
		(BuildingType,					YieldType,			YieldChange)
VALUES	('BUILDING_COAL_POWER_PLANT',	'YIELD_PRODUCTION',	2);
--------------------------------------------------------------

-- Building_YieldDistrictCopies
--------------------------------------------------------------
INSERT OR IGNORE INTO Building_YieldDistrictCopies
		(BuildingType,						OldYieldType,		NewYieldType)
VALUES	('BUILDING_FACTORY',				'YIELD_PRODUCTION',	'YIELD_PRODUCTION'),
		('BUILDING_ELECTRONICS_FACTORY',	'YIELD_PRODUCTION',	'YIELD_PRODUCTION');

DELETE FROM Building_YieldDistrictCopies WHERE BuildingType='BUILDING_COAL_POWER_PLANT';
--------------------------------------------------------------

-- Modifiers
--------------------------------------------------------------
INSERT OR IGNORE INTO Modifiers
		(ModifierId,											ModifierType,												SubjectRequirementSetId)
VALUES	('JNR_WORKSHOP_PRODUCTION_POPULATION_LIGHT',			'MODIFIER_SINGLE_CITY_ADJUST_CITY_YIELD_PER_POPULATION',	NULL),
		('JNR_POWER_PLANT_PRODUCTION_MODIFIER_POWERED_LIGHT',	'MODIFIER_SINGLE_CITY_ADJUST_CITY_YIELD_MODIFIER',			'CITY_IS_POWERED'),
		('JNR_COAL_POWER_PLANT_APPEAL_PENALTY_LIGHT',			'MODIFIER_SINGLE_CITY_ADJUST_CITY_APPEAL',					NULL),
		('JNR_FOSSILE_FUEL_POWER_PLANT_APPEAL_PENALTY_LIGHT',	'MODIFIER_SINGLE_CITY_ADJUST_CITY_APPEAL',					NULL);
--------------------------------------------------------------

-- ModifierArguments
--------------------------------------------------------------
INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,											Name,			Value)
VALUES	('JNR_WORKSHOP_PRODUCTION_POPULATION_LIGHT',			'YieldType',	'YIELD_PRODUCTION'),
		('JNR_WORKSHOP_PRODUCTION_POPULATION_LIGHT',			'Amount',		0.2),
		('JNR_POWER_PLANT_PRODUCTION_MODIFIER_POWERED_LIGHT',	'YieldType',	'YIELD_PRODUCTION'),
		('JNR_POWER_PLANT_PRODUCTION_MODIFIER_POWERED_LIGHT',	'Amount',		10),
		('JNR_COAL_POWER_PLANT_APPEAL_PENALTY_LIGHT',			'Amount',		-2),
		('JNR_FOSSILE_FUEL_POWER_PLANT_APPEAL_PENALTY_LIGHT',	'Amount',		-1);
--------------------------------------------------------------

-- BuildingModifiers
--------------------------------------------------------------
INSERT OR IGNORE INTO BuildingModifiers
		(BuildingType,							ModifierId)
VALUES	('BUILDING_WORKSHOP',					'JNR_WORKSHOP_PRODUCTION_POPULATION_LIGHT'),
		('BUILDING_COAL_POWER_PLANT',			'JNR_POWER_PLANT_PRODUCTION_MODIFIER_POWERED_LIGHT'),
		('BUILDING_FOSSIL_FUEL_POWER_PLANT',	'JNR_POWER_PLANT_PRODUCTION_MODIFIER_POWERED_LIGHT'),
		('BUILDING_POWER_PLANT',				'JNR_POWER_PLANT_PRODUCTION_MODIFIER_POWERED_LIGHT'),
		('BUILDING_COAL_POWER_PLANT',			'JNR_COAL_POWER_PLANT_APPEAL_PENALTY_LIGHT'),
		('BUILDING_FOSSIL_FUEL_POWER_PLANT',	'JNR_FOSSILE_FUEL_POWER_PLANT_APPEAL_PENALTY_LIGHT');

INSERT OR IGNORE INTO BuildingModifiers
		(BuildingType,							ModifierId)
SELECT	'BUILDING_JNR_RENEWABLE_DISTRIBUTION',	'JNR_POWER_PLANT_PRODUCTION_MODIFIER_POWERED_LIGHT'
FROM	Buildings
WHERE	BuildingType='BUILDING_JNR_RENEWABLE_DISTRIBUTION';
--------------------------------------------------------------