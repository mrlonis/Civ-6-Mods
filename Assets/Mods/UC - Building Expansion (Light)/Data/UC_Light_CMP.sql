-- UC_Light_CMP
-- Author: JNR
--------------------------------------------------------------

-- Buildings
--------------------------------------------------------------
UPDATE Buildings SET Description='LOC_BUILDING_LIBRARY_DESCRIPTION_UC_JNR_LIGHT'		WHERE BuildingType='BUILDING_LIBRARY';
UPDATE Buildings SET Description='LOC_BUILDING_UNIVERSITY_DESCRIPTION_UC_JNR_LIGHT'		WHERE BuildingType='BUILDING_UNIVERSITY';
UPDATE Buildings SET Description='LOC_BUILDING_MADRASA_DESCRIPTION_UC_JNR_LIGHT'		WHERE BuildingType='BUILDING_MADRASA';
UPDATE Buildings SET Description='LOC_BUILDING_RESEARCH_LAB_DESCRIPTION_UC_JNR_LIGHT'	WHERE BuildingType='BUILDING_RESEARCH_LAB';

UPDATE Buildings SET RegionalRange=6 WHERE BuildingType='BUILDING_RESEARCH_LAB';
--------------------------------------------------------------

-- Building_YieldChanges
--------------------------------------------------------------
DELETE FROM Building_YieldChanges								WHERE BuildingType='BUILDING_LIBRARY'		AND YieldType='YIELD_SCIENCE';
UPDATE Building_YieldChanges SET YieldChange=2					WHERE BuildingType='BUILDING_UNIVERSITY'	AND YieldType='YIELD_SCIENCE';
UPDATE Building_YieldChanges SET YieldChange=3					WHERE BuildingType='BUILDING_MADRASA'		AND YieldType='YIELD_SCIENCE';
UPDATE Building_YieldChanges SET YieldChange=3					WHERE BuildingType='BUILDING_RESEARCH_LAB'	AND YieldType='YIELD_SCIENCE';
--------------------------------------------------------------

-- Building_YieldChanges
--------------------------------------------------------------
UPDATE Building_YieldChangesBonusWithPower SET YieldChange=3	WHERE BuildingType='BUILDING_RESEARCH_LAB'	AND YieldType='YIELD_SCIENCE';
--------------------------------------------------------------

-- Building_YieldsPerEra
--------------------------------------------------------------
INSERT OR IGNORE INTO Building_YieldsPerEra
		(BuildingType,			YieldType,			YieldChange)
VALUES	('BUILDING_LIBRARY',	'YIELD_SCIENCE',	1);
--------------------------------------------------------------

-- Modifiers
--------------------------------------------------------------
INSERT OR IGNORE INTO Modifiers
		(ModifierId,										ModifierType,												SubjectRequirementSetId)
VALUES	('JNR_UNIVERSITY_SCIENCE_POPULATION_LIGHT',			'MODIFIER_SINGLE_CITY_ADJUST_CITY_YIELD_PER_POPULATION',	NULL),
		('JNR_RESEARCH_LAB_SCIENCE_MODIFIER_LIGHT',			'MODIFIER_SINGLE_CITY_ADJUST_CITY_YIELD_MODIFIER',			NULL),
		('JNR_RESEARCH_LAB_SCIENCE_MODIFIER_POWERED_LIGHT',	'MODIFIER_SINGLE_CITY_ADJUST_CITY_YIELD_MODIFIER',			'CITY_IS_POWERED');
--------------------------------------------------------------

-- ModifierArguments
--------------------------------------------------------------
INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,										Name,			Value)
VALUES	('JNR_UNIVERSITY_SCIENCE_POPULATION_LIGHT',			'YieldType',	'YIELD_SCIENCE'),
		('JNR_UNIVERSITY_SCIENCE_POPULATION_LIGHT',			'Amount',		0.2),
		('JNR_RESEARCH_LAB_SCIENCE_MODIFIER_LIGHT',			'YieldType',	'YIELD_SCIENCE'),
		('JNR_RESEARCH_LAB_SCIENCE_MODIFIER_LIGHT',			'Amount',		5),
		('JNR_RESEARCH_LAB_SCIENCE_MODIFIER_POWERED_LIGHT',	'YieldType',	'YIELD_SCIENCE'),
		('JNR_RESEARCH_LAB_SCIENCE_MODIFIER_POWERED_LIGHT',	'Amount',		5);
--------------------------------------------------------------

-- BuildingModifiers
--------------------------------------------------------------
INSERT OR IGNORE INTO BuildingModifiers
		(BuildingType,				ModifierId)
VALUES	('BUILDING_UNIVERSITY',		'JNR_UNIVERSITY_SCIENCE_POPULATION_LIGHT'),
		('BUILDING_MADRASA',		'JNR_UNIVERSITY_SCIENCE_POPULATION_LIGHT'),
		('BUILDING_RESEARCH_LAB',	'JNR_RESEARCH_LAB_SCIENCE_MODIFIER_LIGHT'),
		('BUILDING_RESEARCH_LAB',	'JNR_RESEARCH_LAB_SCIENCE_MODIFIER_POWERED_LIGHT');
--------------------------------------------------------------