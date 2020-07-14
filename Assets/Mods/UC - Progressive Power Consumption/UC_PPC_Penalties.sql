-- UC_PPC_Penalties
-- Author: JNR
--------------------------------------------------------------

-- Types
--------------------------------------------------------------
INSERT OR IGNORE INTO Types
		(Type,												Kind)
VALUES	('MODIFIER_JNR_PLAYER_CITIES_ADJUST_ENTERTAINMENT',	'KIND_MODIFIER');
--------------------------------------------------------------

-- DynamicModifiers
--------------------------------------------------------------
INSERT OR IGNORE INTO DynamicModifiers
		(ModifierType,										CollectionType,				EffectType)
VALUES	('MODIFIER_JNR_PLAYER_CITIES_ADJUST_ENTERTAINMENT',	'COLLECTION_PLAYER_CITIES',	'EFFECT_ADJUST_CITY_ENTERTAINMENT');
--------------------------------------------------------------

-- Requirements
--------------------------------------------------------------
INSERT OR IGNORE INTO Requirements
		(RequirementId,							RequirementType,				Inverse)
VALUES	('REQUIRES_CITY_IS_NOT_POWERED_JNR',	'REQUIREMENT_CITY_IS_POWERED',	1);
--------------------------------------------------------------

-- RequirementSets
--------------------------------------------------------------
INSERT OR IGNORE INTO RequirementSets
		(RequirementSetId,							RequirementSetType)
VALUES	('CITY_IS_NOT_POWERED_JNR',					'REQUIREMENTSET_TEST_ALL'),
		('PLAYER_GPP_PENALTY_REQUIREMENTSET_JNR',	'REQUIREMENTSET_TEST_ANY');
--------------------------------------------------------------

-- RequirementSetRequirements
--------------------------------------------------------------
INSERT OR IGNORE INTO RequirementSetRequirements
		(RequirementSetId,							RequirementId)
VALUES	('CITY_IS_NOT_POWERED_JNR',					'REQUIRES_CITY_IS_NOT_POWERED_JNR'),
		('PLAYER_GPP_PENALTY_REQUIREMENTSET_JNR',	'REQUIRES_PLAYER_IS_INFORMATION_ERA_JNR'),
		('PLAYER_GPP_PENALTY_REQUIREMENTSET_JNR',	'REQUIRES_PLAYER_HAS_TECH_COMPUTERS_JNR');
--------------------------------------------------------------

-- Modifiers
--------------------------------------------------------------
INSERT OR IGNORE INTO Modifiers
		(ModifierId,											ModifierType,										SubjectRequirementSetId,	OwnerRequirementSetId)
VALUES	('JNR_POWER_UNPOWERED_PENALTY_GPP',						'MODIFIER_CITY_INCREASE_GREAT_PERSON_POINT_BONUS',	'CITY_IS_NOT_POWERED_JNR',	'PLAYER_GPP_PENALTY_REQUIREMENTSET_JNR'),
		('JNR_POWER_UNPOWERED_PENALTY_AMENITY_MODERN',			'MODIFIER_JNR_PLAYER_CITIES_ADJUST_ENTERTAINMENT',	'CITY_IS_NOT_POWERED_JNR',	'PLAYER_HAS_ELECTRICITY_JNR'),
		('JNR_POWER_UNPOWERED_PENALTY_AMENITY_ATOMIC',			'MODIFIER_JNR_PLAYER_CITIES_ADJUST_ENTERTAINMENT',	'CITY_IS_NOT_POWERED_JNR',	'PLAYER_IS_ATOMIC_ERA_TECH_JNR'),
		('JNR_POWER_UNPOWERED_PENALTY_AMENITY_INFORMATION',		'MODIFIER_JNR_PLAYER_CITIES_ADJUST_ENTERTAINMENT',	'CITY_IS_NOT_POWERED_JNR',	'PLAYER_IS_INFORMATION_ERA_TECH_JNR'),
		('JNR_POWER_UNPOWERED_PENALTY_AMENITY_FUTURE',			'MODIFIER_JNR_PLAYER_CITIES_ADJUST_ENTERTAINMENT',	'CITY_IS_NOT_POWERED_JNR',	'PLAYER_IS_FUTURE_ERA_TECH_JNR');
--------------------------------------------------------------

-- ModifierArguments
--------------------------------------------------------------
INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,											Name,		Value)
VALUES	('JNR_POWER_UNPOWERED_PENALTY_GPP',						'Amount',	-75),
		('JNR_POWER_UNPOWERED_PENALTY_AMENITY_MODERN',			'Amount',	-1),
		('JNR_POWER_UNPOWERED_PENALTY_AMENITY_ATOMIC',			'Amount',	-1),
		('JNR_POWER_UNPOWERED_PENALTY_AMENITY_INFORMATION',		'Amount',	-1),
		('JNR_POWER_UNPOWERED_PENALTY_AMENITY_FUTURE',			'Amount',	-1);
--------------------------------------------------------------

-- DistrictModifiers
--------------------------------------------------------------
INSERT OR IGNORE INTO DistrictModifiers
		(DistrictType,				ModifierId)
VALUES	('DISTRICT_CITY_CENTER',	'JNR_POWER_UNPOWERED_PENALTY_GPP');
--------------------------------------------------------------

-- TraitModifiers
--------------------------------------------------------------
INSERT OR IGNORE INTO TraitModifiers
		(TraitType,					ModifierId)
VALUES	('TRAIT_LEADER_MAJOR_CIV',	'JNR_POWER_UNPOWERED_PENALTY_AMENITY_MODERN'),
		('TRAIT_LEADER_MAJOR_CIV',	'JNR_POWER_UNPOWERED_PENALTY_AMENITY_ATOMIC'),
		('TRAIT_LEADER_MAJOR_CIV',	'JNR_POWER_UNPOWERED_PENALTY_AMENITY_INFORMATION'),
		('TRAIT_LEADER_MAJOR_CIV',	'JNR_POWER_UNPOWERED_PENALTY_AMENITY_FUTURE'),
		('MINOR_CIV_DEFAULT_TRAIT',	'JNR_POWER_UNPOWERED_PENALTY_AMENITY_MODERN'),
		('MINOR_CIV_DEFAULT_TRAIT',	'JNR_POWER_UNPOWERED_PENALTY_AMENITY_ATOMIC'),
		('MINOR_CIV_DEFAULT_TRAIT',	'JNR_POWER_UNPOWERED_PENALTY_AMENITY_INFORMATION'),
		('MINOR_CIV_DEFAULT_TRAIT',	'JNR_POWER_UNPOWERED_PENALTY_AMENITY_FUTURE');
--------------------------------------------------------------