-- UC_FWW_Dam
-- Author: JNR
--------------------------------------------------------------

-- DistrictModifiers
--------------------------------------------------------------
INSERT OR REPLACE INTO DistrictModifiers
		(DistrictType,				ModifierId)
VALUES	('DISTRICT_CITY_CENTER',	'DAM_JNR_FWW_HOUSING_AQUEDUCT'),
		('DISTRICT_CITY_CENTER',	'DAM_JNR_FWW_HOUSING_COASTAL'),
		('DISTRICT_CITY_CENTER',	'DAM_JNR_FWW_HOUSING_DRY');
--------------------------------------------------------------

-- Modifiers
--------------------------------------------------------------
INSERT OR REPLACE INTO Modifiers
		(ModifierId,						ModifierType,									SubjectRequirementSetId)
VALUES	('DAM_JNR_FWW_HOUSING_AQUEDUCT',	'MODIFIER_CITY_ADJUST_WATER_HOUSING_JNR_UC',	'JNR_DAM_HOUSING_1_REQUIREMENTS'),
		('DAM_JNR_FWW_HOUSING_COASTAL',		'MODIFIER_CITY_ADJUST_WATER_HOUSING_JNR_UC',	'JNR_DAM_HOUSING_2_REQUIREMENTS'),
		('DAM_JNR_FWW_HOUSING_DRY',			'MODIFIER_CITY_ADJUST_WATER_HOUSING_JNR_UC',	'JNR_DAM_HOUSING_3_REQUIREMENTS');
--------------------------------------------------------------

-- ModifierArguments
--------------------------------------------------------------
INSERT OR REPLACE INTO ModifierArguments
		(ModifierId,						Name,		Value)
VALUES	('DAM_JNR_FWW_HOUSING_AQUEDUCT',	'Amount',	1),
		('DAM_JNR_FWW_HOUSING_COASTAL',		'Amount',	2),
		('DAM_JNR_FWW_HOUSING_DRY',			'Amount',	3);
--------------------------------------------------------------

-- RequirementSets
--------------------------------------------------------------
INSERT OR REPLACE INTO RequirementSets
		(RequirementSetId,					RequirementSetType)
VALUES	('JNR_DAM_HOUSING_1_REQUIREMENTS',	'REQUIREMENTSET_TEST_ALL'),
		('JNR_DAM_HOUSING_2_REQUIREMENTS',	'REQUIREMENTSET_TEST_ALL'),
		('JNR_DAM_HOUSING_3_REQUIREMENTS',	'REQUIREMENTSET_TEST_ALL');
--------------------------------------------------------------

-- RequirementSetRequirements
--------------------------------------------------------------
INSERT OR REPLACE INTO RequirementSetRequirements
		(RequirementSetId,					RequirementId)
VALUES	('JNR_DAM_HOUSING_1_REQUIREMENTS',	'JNR_REQUIRES_WATER_HOUSING_AQUEDUCT_1'),
		('JNR_DAM_HOUSING_1_REQUIREMENTS',	'JNR_REQUIRES_DAM_ADJACENT'),
		('JNR_DAM_HOUSING_2_REQUIREMENTS',	'JNR_REQUIRES_WATER_HOUSING_COASTAL_2'),
		('JNR_DAM_HOUSING_2_REQUIREMENTS',	'JNR_REQUIRES_DAM_ADJACENT'),
		('JNR_DAM_HOUSING_3_REQUIREMENTS',	'JNR_REQUIRES_WATER_HOUSING_DRY_3'),
		('JNR_DAM_HOUSING_3_REQUIREMENTS',	'JNR_REQUIRES_DAM_ADJACENT');
--------------------------------------------------------------