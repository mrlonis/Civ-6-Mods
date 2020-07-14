-- UC_Light_HBR
-- Author: JNR
--------------------------------------------------------------

-- Buildings
--------------------------------------------------------------
UPDATE Buildings SET Description='LOC_BUILDING_SEAPORT_DESCRIPTION_UC_JNR_LIGHT' WHERE BuildingType='BUILDING_SEAPORT';
--------------------------------------------------------------

-- Modifiers
--------------------------------------------------------------
INSERT OR IGNORE INTO Modifiers
		(ModifierId,								ModifierType,											SubjectRequirementSetId)
VALUES	('JNR_BUILDING_SEAPORT_PROMOTION_LIGHT',	'MODIFIER_CITY_TRAINED_UNITS_ADJUST_GRANT_EXPERIENCE',	'SEAPORT_SEA_REQUIREMENTS');
--------------------------------------------------------------

-- ModifierArguments
--------------------------------------------------------------
INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,								Name,		Value)
VALUES	('JNR_BUILDING_SEAPORT_PROMOTION_LIGHT',	'Amount',	-1);
--------------------------------------------------------------

-- BuildingModifiers
--------------------------------------------------------------
INSERT OR IGNORE INTO BuildingModifiers
		(BuildingType,			ModifierId)
VALUES	('BUILDING_SEAPORT',	'JNR_BUILDING_SEAPORT_PROMOTION_LIGHT');
--------------------------------------------------------------