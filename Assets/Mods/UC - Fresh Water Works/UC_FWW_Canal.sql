-- UC_FWW_Canal
-- Author: JNR
--------------------------------------------------------------

-- Types
--------------------------------------------------------------
INSERT OR REPLACE INTO Types
		(Type,												Kind)
VALUES	('MODIFIER_ALL_DISTRICTS_ATTACH_MODIFIER_JNR_UC',	'KIND_MODIFIER');
--------------------------------------------------------------

-- DynamicModifiers
--------------------------------------------------------------
INSERT OR REPLACE INTO DynamicModifiers
		(ModifierType,										CollectionType,				EffectType)
VALUES	('MODIFIER_ALL_DISTRICTS_ATTACH_MODIFIER_JNR_UC',	'COLLECTION_ALL_DISTRICTS',	'EFFECT_ATTACH_MODIFIER');
--------------------------------------------------------------

-- DistrictModifiers
--------------------------------------------------------------
INSERT OR REPLACE INTO DistrictModifiers
		(DistrictType,		ModifierId)
VALUES	('DISTRICT_CANAL',	'CANAL_JNR_FWW_ASSIGN_HOUSING_1'),
		('DISTRICT_CANAL',	'CANAL_JNR_FWW_ASSIGN_HOUSING_2'),
		('DISTRICT_CANAL',	'CANAL_JNR_FWW_ASSIGN_HOUSING_3');
--------------------------------------------------------------

-- Modifiers
--------------------------------------------------------------
INSERT OR REPLACE INTO Modifiers
		(ModifierId,						ModifierType,										SubjectRequirementSetId,			OwnerRequirementSetId,		SubjectStackLimit)
VALUES	('CANAL_JNR_FWW_ASSIGN_HOUSING_1',	'MODIFIER_ALL_DISTRICTS_ATTACH_MODIFIER_JNR_UC',	'JNR_ADJACENT_FRESH_WATER_CANAL',	'JNR_CANAL_FRESH_WATER',	1),
		('CANAL_JNR_FWW_ASSIGN_HOUSING_2',	'MODIFIER_ALL_DISTRICTS_ATTACH_MODIFIER_JNR_UC',	'JNR_ADJACENT_FRESH_WATER_CANAL',	'JNR_CANAL_FRESH_WATER',	1),
		('CANAL_JNR_FWW_ASSIGN_HOUSING_3',	'MODIFIER_ALL_DISTRICTS_ATTACH_MODIFIER_JNR_UC',	'JNR_ADJACENT_FRESH_WATER_CANAL',	'JNR_CANAL_FRESH_WATER',	1),
		('CANAL_JNR_FWW_HOUSING_AQUEDUCT',	'MODIFIER_CITY_ADJUST_WATER_HOUSING_JNR_UC',		'JNR_CANAL_HOUSING_1_REQUIREMENTS',	NULL,						NULL),
		('CANAL_JNR_FWW_HOUSING_COASTAL',	'MODIFIER_CITY_ADJUST_WATER_HOUSING_JNR_UC',		'JNR_CANAL_HOUSING_2_REQUIREMENTS',	NULL,						NULL),
		('CANAL_JNR_FWW_HOUSING_DRY',		'MODIFIER_CITY_ADJUST_WATER_HOUSING_JNR_UC',		'JNR_CANAL_HOUSING_3_REQUIREMENTS',	NULL,						NULL);
--------------------------------------------------------------

-- ModifierArguments
--------------------------------------------------------------
INSERT OR REPLACE INTO ModifierArguments
		(ModifierId,						Name,			Value)
VALUES	('CANAL_JNR_FWW_ASSIGN_HOUSING_1',	'ModifierId',	'CANAL_JNR_FWW_HOUSING_AQUEDUCT'),
		('CANAL_JNR_FWW_ASSIGN_HOUSING_2',	'ModifierId',	'CANAL_JNR_FWW_HOUSING_COASTAL'),
		('CANAL_JNR_FWW_ASSIGN_HOUSING_3',	'ModifierId',	'CANAL_JNR_FWW_HOUSING_DRY'),
		('CANAL_JNR_FWW_HOUSING_AQUEDUCT',	'Amount',		1),
		('CANAL_JNR_FWW_HOUSING_COASTAL',	'Amount',		2),
		('CANAL_JNR_FWW_HOUSING_DRY',		'Amount',		3);
--------------------------------------------------------------

-- RequirementSets
--------------------------------------------------------------
INSERT OR REPLACE INTO RequirementSets
		(RequirementSetId,						RequirementSetType)
VALUES	('JNR_ADJACENT_FRESH_WATER_CANAL',		'REQUIREMENTSET_TEST_ALL'),
		('JNR_CANAL_FRESH_WATER',				'REQUIREMENTSET_TEST_ANY'),
		('JNR_CANAL_HOUSING_1_REQUIREMENTS',	'REQUIREMENTSET_TEST_ALL'),
		('JNR_CANAL_HOUSING_2_REQUIREMENTS',	'REQUIREMENTSET_TEST_ALL'),
		('JNR_CANAL_HOUSING_3_REQUIREMENTS',	'REQUIREMENTSET_TEST_ALL');
--------------------------------------------------------------

-- RequirementSetRequirements
--------------------------------------------------------------
INSERT OR REPLACE INTO RequirementSetRequirements
		(RequirementSetId,						RequirementId)
VALUES	('JNR_ADJACENT_FRESH_WATER_CANAL',		'REQUIRES_DISTRICT_IS_CITY_CENTER'),
		('JNR_ADJACENT_FRESH_WATER_CANAL',		'ADJACENT_TO_OWNER'),
		('JNR_CANAL_FRESH_WATER',				'REQUIRES_PLOT_IS_FRESH_WATER'),
--		('JNR_CANAL_FRESH_WATER',				'JNR_REQUIRES_DAM_ADJACENT'),
--		('JNR_CANAL_FRESH_WATER',				'JNR_REQUIRES_PANAMA_CANAL_ADJACENT'),
		('JNR_CANAL_HOUSING_1_REQUIREMENTS',	'JNR_REQUIRES_WATER_HOUSING_AQUEDUCT_1'),
		('JNR_CANAL_HOUSING_1_REQUIREMENTS',	'JNR_REQUIRES_DAM_NOT_ADJACENT'),
		('JNR_CANAL_HOUSING_2_REQUIREMENTS',	'JNR_REQUIRES_WATER_HOUSING_COASTAL_2'),
		('JNR_CANAL_HOUSING_2_REQUIREMENTS',	'JNR_REQUIRES_DAM_NOT_ADJACENT'),
		('JNR_CANAL_HOUSING_3_REQUIREMENTS',	'JNR_REQUIRES_WATER_HOUSING_DRY_3'),
		('JNR_CANAL_HOUSING_3_REQUIREMENTS',	'JNR_REQUIRES_DAM_NOT_ADJACENT');
--------------------------------------------------------------