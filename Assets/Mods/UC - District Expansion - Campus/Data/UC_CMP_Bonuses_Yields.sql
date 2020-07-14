-- UC_CMP_Bonuses_Yields
-- Author: JNR
--------------------------------------------------------------

-- Buildings
--------------------------------------------------------------
UPDATE Buildings SET RegionalRange=6 WHERE BuildingType='BUILDING_JNR_EDUCATION';
--------------------------------------------------------------

-- Building_YieldChanges
--------------------------------------------------------------
INSERT OR IGNORE INTO Building_YieldChanges
		(BuildingType,				YieldType,			YieldChange)
VALUES	('BUILDING_JNR_ACADEMY',	'YIELD_SCIENCE',	1),
		('BUILDING_JNR_SCHOOL',		'YIELD_SCIENCE',	1),
		('BUILDING_JNR_EDUCATION',	'YIELD_SCIENCE',	3);

UPDATE Building_YieldChanges SET YieldChange=1	WHERE BuildingType='BUILDING_LIBRARY'		AND YieldType='YIELD_SCIENCE';
DELETE FROM Building_YieldChanges				WHERE BuildingType='BUILDING_UNIVERSITY'	AND YieldType='YIELD_SCIENCE';
DELETE FROM Building_YieldChanges				WHERE BuildingType=(SELECT CivUniqueBuildingType FROM BuildingReplaces WHERE ReplacesBuildingType='BUILDING_UNIVERSITY') AND YieldType='YIELD_SCIENCE';
--------------------------------------------------------------

-- Building_YieldsPerEra
--------------------------------------------------------------
INSERT OR IGNORE INTO Building_YieldsPerEra
		(BuildingType,			YieldType,			YieldChange)
VALUES	('BUILDING_LIBRARY',	'YIELD_SCIENCE',	1);
--------------------------------------------------------------

-- Building_YieldDistrictCopies
--------------------------------------------------------------
INSERT OR IGNORE INTO Building_YieldDistrictCopies
		(BuildingType,			OldYieldType,		NewYieldType)
VALUES	('BUILDING_UNIVERSITY',	'YIELD_SCIENCE',	'YIELD_SCIENCE');

INSERT OR IGNORE INTO Building_YieldDistrictCopies
		(BuildingType,			OldYieldType,		NewYieldType)
SELECT	CivUniqueBuildingType,	'YIELD_SCIENCE',	'YIELD_SCIENCE'
FROM	BuildingReplaces
WHERE	ReplacesBuildingType='BUILDING_UNIVERSITY';
--------------------------------------------------------------

-- Building_CitizenYieldChanges
--------------------------------------------------------------
INSERT OR IGNORE INTO Building_CitizenYieldChanges
		(BuildingType,					YieldType,			YieldChange)
VALUES	('BUILDING_JNR_ACADEMY',		'YIELD_SCIENCE',	1),
		('BUILDING_JNR_LABORATORY',		'YIELD_SCIENCE',	1),
		('BUILDING_JNR_LIBERAL_ARTS',	'YIELD_SCIENCE',	1),
		('BUILDING_JNR_EDUCATION',		'YIELD_SCIENCE',	1);
--------------------------------------------------------------

-- Building_YieldChangesBonusWithPower
--------------------------------------------------------------
INSERT OR IGNORE INTO Building_YieldChangesBonusWithPower
		(BuildingType,				YieldType,			YieldChange)
SELECT	'BUILDING_JNR_EDUCATION',	'YIELD_SCIENCE',	YieldChange-2
FROM	Building_YieldChangesBonusWithPower
WHERE	BuildingType='BUILDING_RESEARCH_LAB' AND YieldType='YIELD_SCIENCE';
--------------------------------------------------------------

-- Requirements
--------------------------------------------------------------
INSERT OR IGNORE INTO Requirements
		(RequirementId,								RequirementType)
VALUES	('REQUIRES_CITY_HAS_1_TITLE_GOVERNOR_JNR',	'REQUIREMENT_CITY_HAS_GOVERNOR_WITH_X_TITLES'),
		('REQUIRES_CITY_HAS_3_TITLE_GOVERNOR_JNR',	'REQUIREMENT_CITY_HAS_GOVERNOR_WITH_X_TITLES'),
		('REQUIRES_CITY_HAS_4_TITLE_GOVERNOR_JNR',	'REQUIREMENT_CITY_HAS_GOVERNOR_WITH_X_TITLES'),
		('REQUIRES_CITY_HAS_5_TITLE_GOVERNOR_JNR',	'REQUIREMENT_CITY_HAS_GOVERNOR_WITH_X_TITLES'),
		('REQUIRES_CITY_HAS_6_TITLE_GOVERNOR_JNR',	'REQUIREMENT_CITY_HAS_GOVERNOR_WITH_X_TITLES');
--------------------------------------------------------------

-- RequirementArguments
--------------------------------------------------------------
INSERT OR IGNORE INTO RequirementArguments
		(RequirementId,								Name,				Value)
VALUES	('REQUIRES_CITY_HAS_1_TITLE_GOVERNOR_JNR',	'Established',		1),
		('REQUIRES_CITY_HAS_1_TITLE_GOVERNOR_JNR',	'Amount',			1),
		('REQUIRES_CITY_HAS_3_TITLE_GOVERNOR_JNR',	'Established',		1),
		('REQUIRES_CITY_HAS_3_TITLE_GOVERNOR_JNR',	'Amount',			3),
		('REQUIRES_CITY_HAS_4_TITLE_GOVERNOR_JNR',	'Established',		1),
		('REQUIRES_CITY_HAS_4_TITLE_GOVERNOR_JNR',	'Amount',			4),
		('REQUIRES_CITY_HAS_5_TITLE_GOVERNOR_JNR',	'Established',		1),
		('REQUIRES_CITY_HAS_5_TITLE_GOVERNOR_JNR',	'Amount',			5),
		('REQUIRES_CITY_HAS_6_TITLE_GOVERNOR_JNR',	'Established',		1),
		('REQUIRES_CITY_HAS_6_TITLE_GOVERNOR_JNR',	'Amount',			6);
--------------------------------------------------------------

-- RequirementSets
--------------------------------------------------------------
INSERT OR IGNORE INTO RequirementSets
		(RequirementSetId,								RequirementSetType)
VALUES	('CITY_HAS_1_TITLE_GOVERNOR_REQUIREMENTS_JNR',	'REQUIREMENTSET_TEST_ALL'),
		('CITY_HAS_3_TITLE_GOVERNOR_REQUIREMENTS_JNR',	'REQUIREMENTSET_TEST_ALL'),
		('CITY_HAS_4_TITLE_GOVERNOR_REQUIREMENTS_JNR',	'REQUIREMENTSET_TEST_ALL'),
		('CITY_HAS_5_TITLE_GOVERNOR_REQUIREMENTS_JNR',	'REQUIREMENTSET_TEST_ALL'),
		('CITY_HAS_6_TITLE_GOVERNOR_REQUIREMENTS_JNR',	'REQUIREMENTSET_TEST_ALL');
--------------------------------------------------------------

-- RequirementSetRequirements
--------------------------------------------------------------
INSERT OR IGNORE INTO RequirementSetRequirements
		(RequirementSetId,								RequirementId)
VALUES	('CITY_HAS_1_TITLE_GOVERNOR_REQUIREMENTS_JNR',	'REQUIRES_CITY_HAS_1_TITLE_GOVERNOR_JNR'),
		('CITY_HAS_3_TITLE_GOVERNOR_REQUIREMENTS_JNR',	'REQUIRES_CITY_HAS_3_TITLE_GOVERNOR_JNR'),
		('CITY_HAS_4_TITLE_GOVERNOR_REQUIREMENTS_JNR',	'REQUIRES_CITY_HAS_4_TITLE_GOVERNOR_JNR'),
		('CITY_HAS_5_TITLE_GOVERNOR_REQUIREMENTS_JNR',	'REQUIRES_CITY_HAS_5_TITLE_GOVERNOR_JNR'),
		('CITY_HAS_6_TITLE_GOVERNOR_REQUIREMENTS_JNR',	'REQUIRES_CITY_HAS_6_TITLE_GOVERNOR_JNR');
--------------------------------------------------------------

-- Modifiers
--------------------------------------------------------------
INSERT OR IGNORE INTO Modifiers
		(ModifierId,										ModifierType,												SubjectRequirementSetId)
VALUES	('JNR_SCHOOL_SCIENCE_1_TITLE',						'MODIFIER_BUILDING_YIELD_CHANGE',							'CITY_HAS_1_TITLE_GOVERNOR_REQUIREMENTS_JNR'),
		('JNR_SCHOOL_SCIENCE_2_TITLE',						'MODIFIER_BUILDING_YIELD_CHANGE',							'CITY_HAS_2_TITLE_GOVERNOR_REQUIREMENTS'),
		('JNR_SCHOOL_SCIENCE_3_TITLE',						'MODIFIER_BUILDING_YIELD_CHANGE',							'CITY_HAS_3_TITLE_GOVERNOR_REQUIREMENTS_JNR'),
		('JNR_SCHOOL_SCIENCE_4_TITLE',						'MODIFIER_BUILDING_YIELD_CHANGE',							'CITY_HAS_4_TITLE_GOVERNOR_REQUIREMENTS_JNR'),
		('JNR_SCHOOL_SCIENCE_5_TITLE',						'MODIFIER_BUILDING_YIELD_CHANGE',							'CITY_HAS_5_TITLE_GOVERNOR_REQUIREMENTS_JNR'),
		('JNR_SCHOOL_SCIENCE_6_TITLE',						'MODIFIER_BUILDING_YIELD_CHANGE',							'CITY_HAS_6_TITLE_GOVERNOR_REQUIREMENTS_JNR'),
		('JNR_LABORATORY_SCIENCE_POPULATION',				'MODIFIER_SINGLE_CITY_ADJUST_CITY_YIELD_PER_POPULATION',	NULL),
		('JNR_INSTITUTE_SCIENCE_PERCENTAGE',				'MODIFIER_SINGLE_CITY_ADJUST_CITY_YIELD_MODIFIER',			NULL),
		('JNR_INSTITUTE_SCIENCE_PERCENTAGE_POWERED',		'MODIFIER_SINGLE_CITY_ADJUST_CITY_YIELD_MODIFIER',			'CITY_IS_POWERED');

INSERT OR IGNORE INTO Modifiers
		(ModifierId,										ModifierType)
SELECT	'JNR_LIBERAL_ARTS_SCIENCE_' || GreatWorkObjectType,	'MODIFIER_SINGLE_CITY_ADJUST_GREATWORK_YIELD'
FROM	GreatWorkObjectTypes
WHERE	GreatWorkObjectType IS NOT NULL;
--------------------------------------------------------------

-- ModifierArguments
--------------------------------------------------------------
INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,										Name,					Value)
VALUES	('JNR_SCHOOL_SCIENCE_1_TITLE',						'BuildingType',			'BUILDING_JNR_SCHOOL'),
		('JNR_SCHOOL_SCIENCE_1_TITLE',						'YieldType',			'YIELD_SCIENCE'),
		('JNR_SCHOOL_SCIENCE_1_TITLE',						'Amount',				1),
		('JNR_SCHOOL_SCIENCE_2_TITLE',						'BuildingType',			'BUILDING_JNR_SCHOOL'),
		('JNR_SCHOOL_SCIENCE_2_TITLE',						'YieldType',			'YIELD_SCIENCE'),
		('JNR_SCHOOL_SCIENCE_2_TITLE',						'Amount',				1),
		('JNR_SCHOOL_SCIENCE_3_TITLE',						'BuildingType',			'BUILDING_JNR_SCHOOL'),
		('JNR_SCHOOL_SCIENCE_3_TITLE',						'YieldType',			'YIELD_SCIENCE'),
		('JNR_SCHOOL_SCIENCE_3_TITLE',						'Amount',				1),
		('JNR_SCHOOL_SCIENCE_4_TITLE',						'BuildingType',			'BUILDING_JNR_SCHOOL'),
		('JNR_SCHOOL_SCIENCE_4_TITLE',						'YieldType',			'YIELD_SCIENCE'),
		('JNR_SCHOOL_SCIENCE_4_TITLE',						'Amount',				1),
		('JNR_SCHOOL_SCIENCE_5_TITLE',						'BuildingType',			'BUILDING_JNR_SCHOOL'),
		('JNR_SCHOOL_SCIENCE_5_TITLE',						'YieldType',			'YIELD_SCIENCE'),
		('JNR_SCHOOL_SCIENCE_5_TITLE',						'Amount',				1),
		('JNR_SCHOOL_SCIENCE_6_TITLE',						'BuildingType',			'BUILDING_JNR_SCHOOL'),
		('JNR_SCHOOL_SCIENCE_6_TITLE',						'YieldType',			'YIELD_SCIENCE'),
		('JNR_SCHOOL_SCIENCE_6_TITLE',						'Amount',				1),
		('JNR_LABORATORY_SCIENCE_POPULATION',				'YieldType',			'YIELD_SCIENCE'),
		('JNR_LABORATORY_SCIENCE_POPULATION',				'Amount',				0.4),
		('JNR_INSTITUTE_SCIENCE_PERCENTAGE',				'YieldType',			'YIELD_SCIENCE'),
		('JNR_INSTITUTE_SCIENCE_PERCENTAGE',				'Amount',				5),
		('JNR_INSTITUTE_SCIENCE_PERCENTAGE_POWERED',		'YieldType',			'YIELD_SCIENCE'),
		('JNR_INSTITUTE_SCIENCE_PERCENTAGE_POWERED',		'Amount',				5);

INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,										Name,					Value)
SELECT	'JNR_LIBERAL_ARTS_SCIENCE_' || GreatWorkObjectType,	'GreatWorkObjectType',	GreatWorkObjectType
FROM	GreatWorkObjectTypes
WHERE	GreatWorkObjectType IS NOT NULL;

INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,										Name,					Value)
SELECT	'JNR_LIBERAL_ARTS_SCIENCE_' || GreatWorkObjectType,	'YieldType',			'YIELD_SCIENCE'
FROM	GreatWorkObjectTypes
WHERE	GreatWorkObjectType IS NOT NULL;

INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,										Name,					Value)
SELECT	'JNR_LIBERAL_ARTS_SCIENCE_' || GreatWorkObjectType,	'YieldChange',			1
FROM	GreatWorkObjectTypes
WHERE	GreatWorkObjectType IS NOT NULL;
--------------------------------------------------------------

-- BuildingModifiers
--------------------------------------------------------------
INSERT OR IGNORE INTO BuildingModifiers
		(BuildingType,					ModifierId)
VALUES	('BUILDING_JNR_SCHOOL',			'JNR_SCHOOL_SCIENCE_1_TITLE'),
		('BUILDING_JNR_SCHOOL',			'JNR_SCHOOL_SCIENCE_2_TITLE'),
		('BUILDING_JNR_SCHOOL',			'JNR_SCHOOL_SCIENCE_3_TITLE'),
		('BUILDING_JNR_SCHOOL',			'JNR_SCHOOL_SCIENCE_4_TITLE'),
		('BUILDING_JNR_SCHOOL',			'JNR_SCHOOL_SCIENCE_5_TITLE'),
		('BUILDING_JNR_SCHOOL',			'JNR_SCHOOL_SCIENCE_6_TITLE'),
		('BUILDING_JNR_LABORATORY',		'JNR_LABORATORY_SCIENCE_POPULATION'),
		('BUILDING_RESEARCH_LAB',		'JNR_INSTITUTE_SCIENCE_PERCENTAGE'),
		('BUILDING_RESEARCH_LAB',		'JNR_INSTITUTE_SCIENCE_PERCENTAGE_POWERED');

INSERT OR IGNORE INTO BuildingModifiers
		(BuildingType,					ModifierId)
SELECT	'BUILDING_JNR_LIBERAL_ARTS',	'JNR_LIBERAL_ARTS_SCIENCE_' || GreatWorkObjectType
FROM	GreatWorkObjectTypes
WHERE	GreatWorkObjectType IS NOT NULL;
--------------------------------------------------------------