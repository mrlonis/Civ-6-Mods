-- UC_CMP_Requirements
-- Author: JNR
--------------------------------------------------------------

-- Requirements
--------------------------------------------------------------
INSERT OR IGNORE INTO Requirements
		(RequirementId,							RequirementType)
VALUES	('REQUIRES_CITY_HAS_ACADEMY_JNR',		'REQUIREMENT_CITY_HAS_BUILDING'),
		('REQUIRES_CITY_HAS_SCHOOL_JNR',		'REQUIREMENT_CITY_HAS_BUILDING'),
		('REQUIRES_CITY_HAS_LABORATORY_JNR',	'REQUIREMENT_CITY_HAS_BUILDING'),
		('REQUIRES_CITY_HAS_LIBERAL_ARTS_JNR',	'REQUIREMENT_CITY_HAS_BUILDING'),
		('REQUIRES_CITY_HAS_EDUCATION_JNR',		'REQUIREMENT_CITY_HAS_BUILDING'),
		('REQUIRES_CITY_HAS_CAMPUS_TIER1_JNR',	'REQUIREMENT_REQUIREMENTSET_IS_MET'),
		('REQUIRES_CITY_HAS_CAMPUS_TIER2_JNR',	'REQUIREMENT_REQUIREMENTSET_IS_MET'),
		('REQUIRES_CITY_HAS_CAMPUS_TIER3_JNR',	'REQUIREMENT_REQUIREMENTSET_IS_MET');
--------------------------------------------------------------

-- RequirementArguments
--------------------------------------------------------------
INSERT OR IGNORE INTO RequirementArguments
		(RequirementId,							Name,				Value)
VALUES	('REQUIRES_CITY_HAS_ACADEMY_JNR',		'BuildingType',		'BUILDING_JNR_ACADEMY'),
		('REQUIRES_CITY_HAS_SCHOOL_JNR',		'BuildingType',		'BUILDING_JNR_SCHOOL'),
		('REQUIRES_CITY_HAS_LABORATORY_JNR',	'BuildingType',		'BUILDING_JNR_LABORATORY'),
		('REQUIRES_CITY_HAS_LIBERAL_ARTS_JNR',	'BuildingType',		'BUILDING_JNR_LIBERAL_ARTS'),
		('REQUIRES_CITY_HAS_EDUCATION_JNR',		'BuildingType',		'BUILDING_JNR_EDUCATION'),
		('REQUIRES_CITY_HAS_CAMPUS_TIER1_JNR',	'RequirementSetId',	'BUILDING_IS_CAMPUS_TIER1_JNR'),
		('REQUIRES_CITY_HAS_CAMPUS_TIER2_JNR',	'RequirementSetId',	'BUILDING_IS_CAMPUS_TIER2_JNR'),
		('REQUIRES_CITY_HAS_CAMPUS_TIER3_JNR',	'RequirementSetId',	'BUILDING_IS_CAMPUS_TIER3_JNR');
--------------------------------------------------------------

-- RequirementSets
--------------------------------------------------------------
INSERT OR IGNORE INTO RequirementSets
		(RequirementSetId,						RequirementSetType)
VALUES	('BUILDING_IS_CAMPUS_TIER1_JNR',		'REQUIREMENTSET_TEST_ANY'),
		('BUILDING_IS_CAMPUS_TIER2_JNR',		'REQUIREMENTSET_TEST_ANY'),
		('BUILDING_IS_CAMPUS_TIER3_JNR',		'REQUIREMENTSET_TEST_ANY'),
		('BUILDING_IS_CAMPUS_TIER4_JNR',		'REQUIREMENTSET_TEST_ANY');
--------------------------------------------------------------

-- RequirementSetRequirements
--------------------------------------------------------------
INSERT OR IGNORE INTO RequirementSetRequirements
		(RequirementSetId,							RequirementId)
VALUES	('BUILDING_IS_CAMPUS_TIER1_JNR',			'REQUIRES_CITY_HAS_LIBRARY'),
		('BUILDING_IS_CAMPUS_TIER1_JNR',			'REQUIRES_CITY_HAS_ACADEMY_JNR'),
		('BUILDING_IS_CAMPUS_TIER2_JNR',			'REQUIRES_CITY_HAS_UNIVERSITY'),
		('BUILDING_IS_CAMPUS_TIER2_JNR',			'REQUIRES_CITY_HAS_SCHOOL_JNR'),
		('BUILDING_IS_CAMPUS_TIER3_JNR',			'REQUIRES_CITY_HAS_LABORATORY_JNR'),
		('BUILDING_IS_CAMPUS_TIER3_JNR',			'REQUIRES_CITY_HAS_LIBERAL_ARTS_JNR'),
		('BUILDING_IS_CAMPUS_TIER4_JNR',			'REQUIRES_CITY_HAS_RESEARCH_LAB'),
		('BUILDING_IS_CAMPUS_TIER4_JNR',			'REQUIRES_CITY_HAS_EDUCATION_JNR');
--------------------------------------------------------------