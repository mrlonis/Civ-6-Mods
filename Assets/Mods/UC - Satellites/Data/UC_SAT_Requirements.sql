-- UC_SAT_Requirements
-- Author: JNR
--------------------------------------------------------------

-- RequirementSets
--------------------------------------------------------------
INSERT OR IGNORE INTO RequirementSets
		(RequirementSetId,						RequirementSetType)
VALUES	('BUILDING_IS_CAMPUS_TIER3_JNR',		'REQUIREMENTSET_TEST_ANY'),
		('BUILDING_IS_THEATER_TIER3_JNR',		'REQUIREMENTSET_TEST_ANY'),
		('BUILDING_IS_INDUSTRIAL_TIER2_JNR',	'REQUIREMENTSET_TEST_ANY'),
		('BUILDING_IS_COMMERCIAL_TIER3_JNR',	'REQUIREMENTSET_TEST_ANY'),
		('BUILDING_IS_HARBOR_TIER3_JNR',		'REQUIREMENTSET_TEST_ANY'),
		('BUILDING_IS_ENCAMPMENT_TIER3_JNR',	'REQUIREMENTSET_TEST_ANY');
--------------------------------------------------------------

-- RequirementSetRequirements
--------------------------------------------------------------
INSERT OR IGNORE INTO RequirementSetRequirements
		(RequirementSetId,						RequirementId)
VALUES	('BUILDING_IS_CAMPUS_TIER3_JNR',		'REQUIRES_CITY_HAS_RESEARCH_LAB'),
		('BUILDING_IS_THEATER_TIER3_JNR',		'REQUIRES_CITY_HAS_BROADCAST_CENTER_JNR'),
		('BUILDING_IS_INDUSTRIAL_TIER2_JNR',	'REQUIRES_CITY_HAS_FACTORY'),
		('BUILDING_IS_COMMERCIAL_TIER3_JNR',	'REQUIRES_CITY_HAS_STOCK_EXCHANGE'),
		('BUILDING_IS_HARBOR_TIER3_JNR',		'REQUIRES_CITY_HAS_SEAPORT'),
		('BUILDING_IS_ENCAMPMENT_TIER3_JNR',	'REQUIRES_CITY_HAS_MILITARY_ACADEMY');
--------------------------------------------------------------

-- Requirements
--------------------------------------------------------------
INSERT OR IGNORE INTO Requirements
		(RequirementId,								RequirementType)
VALUES	('REQUIRES_CITY_HAS_BROADCAST_CENTER_JNR',	'REQUIREMENT_CITY_HAS_BUILDING');
--------------------------------------------------------------

-- RequirementArguments
--------------------------------------------------------------
INSERT OR IGNORE INTO RequirementArguments
		(RequirementId,								Name,			Value)
VALUES	('REQUIRES_CITY_HAS_BROADCAST_CENTER_JNR',	'BuildingType',	'BUILDING_BROADCAST_CENTER');
--------------------------------------------------------------