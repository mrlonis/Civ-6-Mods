-- UC_Light_ENC
-- Author: JNR
--------------------------------------------------------------

-- Buildings
--------------------------------------------------------------
UPDATE Buildings SET Description='LOC_BUILDING_ARMORY_DESCRIPTION_UC_JNR_LIGHT'				WHERE BuildingType='BUILDING_ARMORY';
UPDATE Buildings SET Description='LOC_BUILDING_MILITARY_ACADEMY_DESCRIPTION_UC_JNR_LIGHT'	WHERE BuildingType='BUILDING_MILITARY_ACADEMY';
--------------------------------------------------------------

-- Building_YieldChanges
--------------------------------------------------------------
UPDATE Building_YieldChanges SET YieldChange=2	WHERE BuildingType='BUILDING_ARMORY'			AND YieldType='YIELD_PRODUCTION';
UPDATE Building_YieldChanges SET YieldChange=3	WHERE BuildingType='BUILDING_MILITARY_ACADEMY'	AND YieldType='YIELD_PRODUCTION';
--------------------------------------------------------------

-- Modifiers
--------------------------------------------------------------
INSERT OR IGNORE INTO Modifiers
		(ModifierId,								ModifierType,											SubjectRequirementSetId)
VALUES	('JNR_ARMORY_PRODUCTION_STRATEGIC_LIGHT',	'MODIFIER_CITY_PLOT_YIELDS_ADJUST_PLOT_YIELD',			'PLOT_HAS_STRATEGIC_IMPROVED_REQUIREMENTS'),
		('JNR_MILITARY_ACADEMY_PROMOTION_LIGHT',	'MODIFIER_CITY_TRAINED_UNITS_ADJUST_GRANT_EXPERIENCE',	'MILITARYACADEMY_XP_LAND_REQUIREMENTS');	
--------------------------------------------------------------

-- ModifierArguments
--------------------------------------------------------------
INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,								Name,			Value)
VALUES	('JNR_ARMORY_PRODUCTION_STRATEGIC_LIGHT',	'YieldType',	'YIELD_PRODUCTION'),
		('JNR_ARMORY_PRODUCTION_STRATEGIC_LIGHT',	'Amount',		1),
		('JNR_MILITARY_ACADEMY_PROMOTION_LIGHT',	'Amount',		-1);
--------------------------------------------------------------

-- BuildingModifiers
--------------------------------------------------------------
INSERT OR IGNORE INTO BuildingModifiers
		(BuildingType,					ModifierId)
VALUES	('BUILDING_ARMORY',				'JNR_ARMORY_PRODUCTION_STRATEGIC_LIGHT'),
		('BUILDING_MILITARY_ACADEMY',	'JNR_MILITARY_ACADEMY_PROMOTION_LIGHT');
--------------------------------------------------------------