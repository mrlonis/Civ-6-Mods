-- UC_FWW_Shared
-- Author: JNR
--------------------------------------------------------------

-- Types
--------------------------------------------------------------
INSERT OR REPLACE INTO Types
		(Type,											Kind)
VALUES	('MODIFIER_CITY_ADJUST_WATER_HOUSING_JNR_UC',	'KIND_MODIFIER');
--------------------------------------------------------------

-- DynamicModifiers
--------------------------------------------------------------
INSERT OR REPLACE INTO DynamicModifiers
		(ModifierType,									CollectionType,		EffectType)
VALUES	('MODIFIER_CITY_ADJUST_WATER_HOUSING_JNR_UC',	'COLLECTION_OWNER',	'EFFECT_ADJUST_WATER_HOUSING');
--------------------------------------------------------------

-- RequirementSets
--------------------------------------------------------------
INSERT OR REPLACE INTO RequirementSets
		(RequirementSetId,								RequirementSetType)
VALUES	('JNR_WATER_HOUSING_AQUEDUCT_1_REQUIREMENTS',	'REQUIREMENTSET_TEST_ALL'),
		('JNR_WATER_HOUSING_COASTAL_2_REQUIREMENTS',	'REQUIREMENTSET_TEST_ALL'),
		('JNR_WATER_HOUSING_DRY_3_REQUIREMENTS',		'REQUIREMENTSET_TEST_ALL');
--------------------------------------------------------------

-- RequirementSetRequirements
--------------------------------------------------------------
INSERT OR REPLACE INTO RequirementSetRequirements
		(RequirementSetId,								RequirementId)
VALUES	('JNR_WATER_HOUSING_AQUEDUCT_1_REQUIREMENTS',	'JNR_REQUIRES_PLOT_IS_NOT_FRESH_WATER'),
		('JNR_WATER_HOUSING_AQUEDUCT_1_REQUIREMENTS',	'JNR_REQUIRES_CITY_HAS_AQUEDUCT'),
		('JNR_WATER_HOUSING_COASTAL_2_REQUIREMENTS',	'JNR_REQUIRES_PLOT_IS_NOT_FRESH_WATER'),
		('JNR_WATER_HOUSING_COASTAL_2_REQUIREMENTS',	'JNR_REQUIRES_CITY_DOES_NOT_HAVE_AQUEDUCT'),
		('JNR_WATER_HOUSING_COASTAL_2_REQUIREMENTS',	'REQUIRES_PLOT_IS_ADJACENT_TO_COAST'),
		('JNR_WATER_HOUSING_DRY_3_REQUIREMENTS',		'JNR_REQUIRES_PLOT_IS_NOT_FRESH_WATER'),
		('JNR_WATER_HOUSING_DRY_3_REQUIREMENTS',		'JNR_REQUIRES_CITY_DOES_NOT_HAVE_AQUEDUCT'),
		('JNR_WATER_HOUSING_DRY_3_REQUIREMENTS',		'JNR_REQUIRES_PLOT_NOT_ADJACENT_TO_COAST');
--------------------------------------------------------------

-- Requirements
--------------------------------------------------------------
INSERT OR REPLACE INTO Requirements
		(RequirementId,									RequirementType,									Inverse)
VALUES	('JNR_REQUIRES_DAM_ADJACENT',					'REQUIREMENT_PLOT_ADJACENT_DISTRICT_TYPE_MATCHES',	NULL),
		('JNR_REQUIRES_DAM_NOT_ADJACENT',				'REQUIREMENT_PLOT_ADJACENT_DISTRICT_TYPE_MATCHES',	1),
		('JNR_REQUIRES_CITY_HAS_AQUEDUCT',				'REQUIREMENT_CITY_HAS_DISTRICT',					NULL),
		('JNR_REQUIRES_CITY_DOES_NOT_HAVE_AQUEDUCT',	'REQUIREMENT_CITY_HAS_DISTRICT',					1),
--		(	 'REQUIRES_PLOT_IS_ADJACENT_TO_COAST',		'REQUIREMENT_PLOT_ADJACENT_TO_COAST'				NULL),
		('JNR_REQUIRES_PLOT_NOT_ADJACENT_TO_COAST',		'REQUIREMENT_PLOT_ADJACENT_TO_COAST',				1),
--		(	 'REQUIRES_PLOT_IS_FRESH_WATER',			'REQUIREMENT_PLOT_IS_FRESH_WATER'					NULL),
		('JNR_REQUIRES_PLOT_IS_NOT_FRESH_WATER',		'REQUIREMENT_PLOT_IS_FRESH_WATER',					1),

		('JNR_REQUIRES_WATER_HOUSING_AQUEDUCT_1',		'REQUIREMENT_REQUIREMENTSET_IS_MET',				NULL),
		('JNR_REQUIRES_WATER_HOUSING_COASTAL_2',		'REQUIREMENT_REQUIREMENTSET_IS_MET',				NULL),
		('JNR_REQUIRES_WATER_HOUSING_DRY_3',			'REQUIREMENT_REQUIREMENTSET_IS_MET',				NULL);
--------------------------------------------------------------

-- RequirementArguments
--------------------------------------------------------------
INSERT OR REPLACE INTO RequirementArguments
		(RequirementId,									Name,				Value)
VALUES	('JNR_REQUIRES_DAM_ADJACENT',					'DistrictType',		'DISTRICT_DAM'),
		('JNR_REQUIRES_DAM_NOT_ADJACENT',				'DistrictType',		'DISTRICT_DAM'),
		('JNR_REQUIRES_CITY_HAS_AQUEDUCT',				'DistrictType',		'DISTRICT_AQUEDUCT'),
		('JNR_REQUIRES_CITY_DOES_NOT_HAVE_AQUEDUCT',	'DistrictType',		'DISTRICT_AQUEDUCT'),

		('JNR_REQUIRES_WATER_HOUSING_AQUEDUCT_1',		'RequirementSetId',	'JNR_WATER_HOUSING_AQUEDUCT_1_REQUIREMENTS'),
		('JNR_REQUIRES_WATER_HOUSING_COASTAL_2',		'RequirementSetId',	'JNR_WATER_HOUSING_COASTAL_2_REQUIREMENTS'),
		('JNR_REQUIRES_WATER_HOUSING_DRY_3',			'RequirementSetId',	'JNR_WATER_HOUSING_DRY_3_REQUIREMENTS');
--------------------------------------------------------------