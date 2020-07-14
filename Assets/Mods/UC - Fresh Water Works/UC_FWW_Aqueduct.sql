-- UC_FWW_Aqueduct
-- Author: JNR
--------------------------------------------------------------

-- Types
--------------------------------------------------------------
INSERT OR REPLACE INTO Types
		(Type,												Kind)
VALUES	('MODIFIER_CITY_ADJUST_DISTRICT_HOUSING_JNR_UC',	'KIND_MODIFIER');
--------------------------------------------------------------

-- DynamicModifiers
--------------------------------------------------------------
INSERT OR REPLACE INTO DynamicModifiers
		(ModifierType,										CollectionType,		EffectType)
VALUES	('MODIFIER_CITY_ADJUST_DISTRICT_HOUSING_JNR_UC',	'COLLECTION_OWNER',	'EFFECT_ADJUST_DISTRICT_HOUSING');
--------------------------------------------------------------

-- DistrictModifiers
--------------------------------------------------------------
INSERT OR REPLACE INTO DistrictModifiers
		(DistrictType,			ModifierId)
VALUES	('DISTRICT_AQUEDUCT',	'AQUEDUCT_JNR_FWW_APPEAL_HOUSING_UNINVITING'),
		('DISTRICT_AQUEDUCT',	'AQUEDUCT_JNR_FWW_APPEAL_HOUSING_AVERAGE'),
		('DISTRICT_AQUEDUCT',	'AQUEDUCT_JNR_FWW_APPEAL_HOUSING_CHARMING'),
		('DISTRICT_AQUEDUCT',	'AQUEDUCT_JNR_FWW_APPEAL_HOUSING_BREATHTAKING');
--------------------------------------------------------------

-- Modifiers
--------------------------------------------------------------
INSERT OR REPLACE INTO Modifiers
		(ModifierId,										ModifierType,									SubjectRequirementSetId)
VALUES	('AQUEDUCT_JNR_FWW_APPEAL_HOUSING_UNINVITING',		'MODIFIER_CITY_ADJUST_DISTRICT_HOUSING_JNR_UC',	'JNR_AQUEDUCT_UNINVITING_APPEAL'),
		('AQUEDUCT_JNR_FWW_APPEAL_HOUSING_AVERAGE',			'MODIFIER_CITY_ADJUST_DISTRICT_HOUSING_JNR_UC',	'JNR_AQUEDUCT_AVERAGE_APPEAL'),
		('AQUEDUCT_JNR_FWW_APPEAL_HOUSING_CHARMING',		'MODIFIER_CITY_ADJUST_DISTRICT_HOUSING_JNR_UC',	'JNR_AQUEDUCT_CHARMING_APPEAL'),
		('AQUEDUCT_JNR_FWW_APPEAL_HOUSING_BREATHTAKING',	'MODIFIER_CITY_ADJUST_DISTRICT_HOUSING_JNR_UC',	'JNR_AQUEDUCT_BREATHTAKING_APPEAL');
--------------------------------------------------------------

-- ModifierArguments
--------------------------------------------------------------
INSERT OR REPLACE INTO ModifierArguments
		(ModifierId,										Name,		Value)
VALUES	('AQUEDUCT_JNR_FWW_APPEAL_HOUSING_UNINVITING',		'Amount',	1),
		('AQUEDUCT_JNR_FWW_APPEAL_HOUSING_AVERAGE',			'Amount',	1),
		('AQUEDUCT_JNR_FWW_APPEAL_HOUSING_CHARMING',		'Amount',	1),
		('AQUEDUCT_JNR_FWW_APPEAL_HOUSING_BREATHTAKING',	'Amount',	1);
--------------------------------------------------------------

-- RequirementSets
--------------------------------------------------------------
INSERT OR REPLACE INTO RequirementSets
		(RequirementSetId,						RequirementSetType)
VALUES	('JNR_AQUEDUCT_UNINVITING_APPEAL',		'REQUIREMENTSET_TEST_ALL'),
		('JNR_AQUEDUCT_AVERAGE_APPEAL',			'REQUIREMENTSET_TEST_ALL'),
		('JNR_AQUEDUCT_CHARMING_APPEAL',		'REQUIREMENTSET_TEST_ALL'),
		('JNR_AQUEDUCT_BREATHTAKING_APPEAL',	'REQUIREMENTSET_TEST_ALL'),
		('JNR_P0K_AQUEDUCT_REQUIREMENTS',		'REQUIREMENTSET_TEST_ALL');
--------------------------------------------------------------

-- RequirementSetRequirements
--------------------------------------------------------------
INSERT OR REPLACE INTO RequirementSetRequirements
		(RequirementSetId,						RequirementId)
VALUES	('JNR_AQUEDUCT_UNINVITING_APPEAL',		'JNR_REQUIRES_MINIMUM_UNINVITING_APPEAL'),
		('JNR_AQUEDUCT_AVERAGE_APPEAL',			'JNR_REQUIRES_MINIMUM_AVERAGE_APPEAL'),
		('JNR_AQUEDUCT_CHARMING_APPEAL',		'JNR_REQUIRES_MINIMUM_CHARMING_APPEAL'),
		('JNR_AQUEDUCT_BREATHTAKING_APPEAL',	'JNR_REQUIRES_MINIMUM_BREATHTAKING_APPEAL'),
		('JNR_AQUEDUCT_UNINVITING_APPEAL',		'JNR_REQUIRES_PLAYER_HAS_URBANIZATION'),
		('JNR_AQUEDUCT_AVERAGE_APPEAL',			'JNR_REQUIRES_PLAYER_HAS_URBANIZATION'),
		('JNR_AQUEDUCT_CHARMING_APPEAL',		'JNR_REQUIRES_PLAYER_HAS_URBANIZATION'),
		('JNR_AQUEDUCT_BREATHTAKING_APPEAL',	'JNR_REQUIRES_PLAYER_HAS_URBANIZATION'),
		('JNR_P0K_AQUEDUCT_REQUIREMENTS',		'JNR_REQUIRES_MINIMUM_CHARMING_APPEAL'),
		('JNR_P0K_AQUEDUCT_REQUIREMENTS',		'JNR_REQUIRES_PLAYER_DOES_NOT_HAVE_URBANIZATION');
--------------------------------------------------------------

-- Requirements
--------------------------------------------------------------
INSERT OR REPLACE INTO Requirements
		(RequirementId,										RequirementType)
VALUES	('JNR_REQUIRES_MINIMUM_UNINVITING_APPEAL',			'REQUIREMENT_PLOT_IS_APPEAL_BETWEEN'),
		('JNR_REQUIRES_MINIMUM_AVERAGE_APPEAL',				'REQUIREMENT_PLOT_IS_APPEAL_BETWEEN'),
		('JNR_REQUIRES_MINIMUM_CHARMING_APPEAL',			'REQUIREMENT_PLOT_IS_APPEAL_BETWEEN'),
		('JNR_REQUIRES_MINIMUM_BREATHTAKING_APPEAL',		'REQUIREMENT_PLOT_IS_APPEAL_BETWEEN'),
		('JNR_REQUIRES_PLAYER_HAS_URBANIZATION',			'REQUIREMENT_PLAYER_HAS_CIVIC');

INSERT OR REPLACE INTO Requirements
		(RequirementId,										RequirementType,				Inverse)
VALUES	('JNR_REQUIRES_PLAYER_DOES_NOT_HAVE_URBANIZATION',	'REQUIREMENT_PLAYER_HAS_CIVIC',	1);
--------------------------------------------------------------

-- RequirementArguments
--------------------------------------------------------------
INSERT OR REPLACE INTO RequirementArguments
		(RequirementId,										Name,				Value)
VALUES	('JNR_REQUIRES_MINIMUM_UNINVITING_APPEAL',			'MinimumAppeal',	-3),
		('JNR_REQUIRES_MINIMUM_AVERAGE_APPEAL',				'MinimumAppeal',	-1),
		('JNR_REQUIRES_MINIMUM_CHARMING_APPEAL',			'MinimumAppeal',	 2),
		('JNR_REQUIRES_MINIMUM_BREATHTAKING_APPEAL',		'MinimumAppeal',	 4),
		('JNR_REQUIRES_PLAYER_HAS_URBANIZATION',			'CivicType',		 'CIVIC_URBANIZATION'),
		('JNR_REQUIRES_PLAYER_DOES_NOT_HAVE_URBANIZATION',	'CivicType',		 'CIVIC_URBANIZATION');
--------------------------------------------------------------