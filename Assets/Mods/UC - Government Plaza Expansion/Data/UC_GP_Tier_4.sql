-- UC_GP_Tier_4
-- Author: JNR
--------------------------------------------------------------

-- Types
--------------------------------------------------------------
INSERT OR IGNORE INTO Types
		(Type,											Kind)
VALUES	('MODIFIER_JNR_ALL_DISTRICTS_ATTACH_MODIFIER',	'KIND_MODIFIER');
--------------------------------------------------------------

-- DynamicModifiers
--------------------------------------------------------------
INSERT OR IGNORE INTO DynamicModifiers
		(ModifierType,									CollectionType,					EffectType)
VALUES	('MODIFIER_JNR_ALL_DISTRICTS_ATTACH_MODIFIER',	'COLLECTION_PLAYER_DISTRICTS',	'EFFECT_ATTACH_MODIFIER');
--------------------------------------------------------------

-- BuildingReplaces
--------------------------------------------------------------
INSERT OR IGNORE INTO BuildingReplaces
		(CivUniqueBuildingType,				ReplacesBuildingType)
VALUES	('BUILDING_GOV_JNR_DIPLOMACY_US',	'BUILDING_GOV_JNR_DIPLOMACY');
--------------------------------------------------------------

-- BuildingPrereqs
--------------------------------------------------------------
INSERT OR IGNORE INTO BuildingPrereqs
		(Building,							PrereqBuilding)
SELECT	'BUILDING_GOV_JNR_MOCC',			a.BuildingType FROM Buildings a WHERE a.GovernmentTierRequirement='Tier3';

INSERT OR IGNORE INTO BuildingPrereqs
		(Building,							PrereqBuilding)
SELECT	'BUILDING_GOV_JNR_PROPAGANDA',		a.BuildingType FROM Buildings a WHERE a.GovernmentTierRequirement='Tier3';

INSERT OR IGNORE INTO BuildingPrereqs
		(Building,							PrereqBuilding)
SELECT	'BUILDING_GOV_JNR_DIPLOMACY',		a.BuildingType FROM Buildings a WHERE a.GovernmentTierRequirement='Tier3';

INSERT OR IGNORE INTO BuildingPrereqs
		(Building,							PrereqBuilding)
SELECT	'BUILDING_GOV_JNR_DIPLOMACY_US',	a.BuildingType FROM Buildings a WHERE a.GovernmentTierRequirement='Tier3';
--------------------------------------------------------------

-- MutuallyExclusiveBuildings
--------------------------------------------------------------
INSERT OR IGNORE INTO MutuallyExclusiveBuildings
		(Building,							MutuallyExclusiveBuilding)
VALUES	('BUILDING_GOV_JNR_MOCC',			'BUILDING_GOV_JNR_PROPAGANDA'),
		('BUILDING_GOV_JNR_MOCC',			'BUILDING_GOV_JNR_DIPLOMACY'),
		('BUILDING_GOV_JNR_PROPAGANDA',		'BUILDING_GOV_JNR_MOCC'),
		('BUILDING_GOV_JNR_PROPAGANDA',		'BUILDING_GOV_JNR_DIPLOMACY'),
		('BUILDING_GOV_JNR_DIPLOMACY',		'BUILDING_GOV_JNR_MOCC'),
		('BUILDING_GOV_JNR_DIPLOMACY',		'BUILDING_GOV_JNR_PROPAGANDA'),
		('BUILDING_GOV_JNR_DIPLOMACY_US',	'BUILDING_GOV_JNR_MOCC'),
		('BUILDING_GOV_JNR_DIPLOMACY_US',	'BUILDING_GOV_JNR_PROPAGANDA');
--------------------------------------------------------------

-- BuildingModifiers
--------------------------------------------------------------
INSERT OR IGNORE INTO BuildingModifiers
		(ModifierId,								BuildingType)
VALUES	('GOV_JNR_MOCC_MILITARY_CARD',				'BUILDING_GOV_JNR_MOCC'),
		('GOV_JNR_PROPAGANDA_ECONOMIC_CARD',		'BUILDING_GOV_JNR_PROPAGANDA'),
		('GOV_JNR_DIPLOMACY_DIPLOMATIC_CARD',		'BUILDING_GOV_JNR_DIPLOMACY'),
		('GOV_JNR_DIPLOMACY_US_WILD_CARD',			'BUILDING_GOV_JNR_DIPLOMACY_US'),
		('GOV_JNR_MOCC_SPEC_OPS_GRANT_SUPPORT',		'BUILDING_GOV_JNR_MOCC'),
		('GOV_JNR_MOCC_AIRCRAFT_GRANT_DISTANCE',	'BUILDING_GOV_JNR_MOCC'),
		('GOV_JNR_MOCC_HEAL_BONUS',					'BUILDING_GOV_JNR_MOCC'),
		('GOV_JNR_MOCC_LOYALTY_ATTACH',				'BUILDING_GOV_JNR_MOCC'),
		('GOV_JNR_PROPAGANDA_ROCK_IGNORES_BORDERS',	'BUILDING_GOV_JNR_PROPAGANDA'),
		('GOV_JNR_PROPAGANDA_RELIGIOUS_ROCK',		'BUILDING_GOV_JNR_PROPAGANDA'),
		('GOV_JNR_PROPAGANDA_HIDE_RELIGIOUS',		'BUILDING_GOV_JNR_PROPAGANDA'),
		('GOV_JNR_PROPAGANDA_IGNORE_ZOC_RELIGIOUS',	'BUILDING_GOV_JNR_PROPAGANDA'),
		('GOV_JNR_PROPAGANDA_LOYALTY_ATTACH',		'BUILDING_GOV_JNR_PROPAGANDA'),
		('GOV_JNR_DIPLOMACY_GOVERNOR_FAVOR_ATTACH',	'BUILDING_GOV_JNR_DIPLOMACY'),
		('GOV_JNR_DIPLOMACY_FAVOR_RETURN',			'BUILDING_GOV_JNR_DIPLOMACY'),
		('GOV_JNR_DIPLOMACY_DIPLOMATIC_VP',			'BUILDING_GOV_JNR_DIPLOMACY'),
		('GOV_JNR_DIPLOMACY_GOVERNOR_FAVOR',		'BUILDING_GOV_JNR_DIPLOMACY_US'),
		('GOV_JNR_DIPLOMACY_FAVOR_RETURN',			'BUILDING_GOV_JNR_DIPLOMACY_US'),
		('GOV_JNR_DIPLOMACY_DIPLOMATIC_VP',			'BUILDING_GOV_JNR_DIPLOMACY_US');
--------------------------------------------------------------

-- Modifiers
--------------------------------------------------------------
INSERT OR IGNORE INTO Modifiers
		(ModifierId,								ModifierType,														SubjectRequirementSetId)
VALUES	('GOV_JNR_MOCC_MILITARY_CARD',				'MODIFIER_PLAYER_CULTURE_ADJUST_GOVERNMENT_SLOTS_MODIFIER',			NULL											),
		('GOV_JNR_PROPAGANDA_ECONOMIC_CARD',		'MODIFIER_PLAYER_CULTURE_ADJUST_GOVERNMENT_SLOTS_MODIFIER',			NULL											),
		('GOV_JNR_DIPLOMACY_DIPLOMATIC_CARD',		'MODIFIER_PLAYER_CULTURE_ADJUST_GOVERNMENT_SLOTS_MODIFIER',			NULL											),
		('GOV_JNR_DIPLOMACY_US_WILD_CARD',			'MODIFIER_PLAYER_CULTURE_ADJUST_GOVERNMENT_SLOTS_MODIFIER',			NULL											),
		('GOV_JNR_MOCC_HEAL_BONUS',					'MODIFIER_ALL_UNITS_ADJUST_HEAL_PER_TURN',							'JNR_UNIT_IS_LAND_UNIT'							),
		('GOV_JNR_MOCC_LOYALTY_ATTACH',				'MODIFIER_JNR_ALL_DISTRICTS_ATTACH_MODIFIER',						NULL											),
		('GOV_JNR_MOCC_LOYALTY',					'MODIFIER_SINGLE_CITY_ADJUST_IDENTITY_PER_TURN',					'JNR_DRONE_LOYALTY_REQUIREMENTS'				),
		('GOV_JNR_PROPAGANDA_LOYALTY_ATTACH',		'MODIFIER_PLAYER_CITIES_ATTACH_MODIFIER',							NULL											),
		('GOV_JNR_PROPAGANDA_LOYALTY',				'MODIFIER_SINGLE_CITY_ADJUST_IDENTITY_PER_TURN',					NULL											),
		('GOV_JNR_DIPLOMACY_GOVERNOR_FAVOR_ATTACH',	'MODIFIER_PLAYER_CITIES_ATTACH_MODIFIER',							NULL											),
		('GOV_JNR_DIPLOMACY_GOVERNOR_FAVOR',		'MODIFIER_PLAYER_ADJUST_EXTRA_FAVOR_PER_TURN',						'CITY_HAS_4_TITLE_GOVERNOR_JNR_REQUIREMENTS'	),
		('GOV_JNR_DIPLOMACY_FAVOR_RETURN',			'MODIFIER_PLAYER_ADJUST_FAVOR_REFUND_FOR_SUCCESSFUL_RESOLUTION',	NULL											),
		('GOV_JNR_DIPLOMACY_DIPLOMATIC_VP',			'MODIFIER_PLAYER_ADJUST_DIPLOMATIC_VICTORY_POINTS',					NULL											);

INSERT OR IGNORE INTO Modifiers
		(ModifierId,								ModifierType,								Permanent)
VALUES	('GOV_JNR_MOCC_SPEC_OPS_GRANT_SUPPORT',		'MODIFIER_PLAYER_UNITS_GRANT_ABILITY',		1),
		('GOV_JNR_MOCC_AIRCRAFT_GRANT_DISTANCE',	'MODIFIER_PLAYER_UNITS_GRANT_ABILITY',		1),
		('GOV_JNR_PROPAGANDA_ROCK_IGNORES_BORDERS',	'MODIFIER_PLAYER_UNITS_GRANT_ABILITY',		1),
		('GOV_JNR_PROPAGANDA_HIDE_RELIGIOUS',		'MODIFIER_PLAYER_UNITS_GRANT_ABILITY',		1),
		('GOV_JNR_PROPAGANDA_IGNORE_ZOC_RELIGIOUS',	'MODIFIER_PLAYER_UNITS_GRANT_ABILITY',		1),
		('GOV_JNR_PROPAGANDA_RELIGIOUS_ROCK',		'MODIFIER_PLAYER_UNITS_GRANT_PROMOTION',	1);
--------------------------------------------------------------

-- ModifierArguments
--------------------------------------------------------------
INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,								Name,					Value)
VALUES	('GOV_JNR_MOCC_MILITARY_CARD',				'GovernmentSlotType',	'SLOT_MILITARY'							),
		('GOV_JNR_PROPAGANDA_ECONOMIC_CARD',		'GovernmentSlotType',	'SLOT_ECONOMIC'							),
		('GOV_JNR_DIPLOMACY_DIPLOMATIC_CARD',		'GovernmentSlotType',	'SLOT_DIPLOMATIC'						),
		('GOV_JNR_DIPLOMACY_US_WILD_CARD',			'GovernmentSlotType',	'SLOT_WILDCARD'							),
		('GOV_JNR_MOCC_SPEC_OPS_GRANT_SUPPORT',		'AbilityType',			'ABILITY_JNR_GOV_MOCC_SPEC_OPS'			),
		('GOV_JNR_MOCC_AIRCRAFT_GRANT_DISTANCE',	'AbilityType',			'ABILITY_JNR_GOV_MOCC_AIRCRAFT'			),
		('GOV_JNR_MOCC_HEAL_BONUS',					'Amount',				5										),
		('GOV_JNR_MOCC_LOYALTY_ATTACH',				'ModifierId',			'GOV_JNR_MOCC_LOYALTY'					),
		('GOV_JNR_MOCC_LOYALTY',					'Amount',				3										),
		('GOV_JNR_PROPAGANDA_ROCK_IGNORES_BORDERS',	'AbilityType',			'ABILITY_ROCK_BAND_ENTER_FOREIGN_LANDS'	),
		('GOV_JNR_PROPAGANDA_RELIGIOUS_ROCK',		'PromotionType',		'PROMOTION_RELIGIOUS_ROCK'				),
		('GOV_JNR_PROPAGANDA_HIDE_RELIGIOUS',		'AbilityType',			'ABILITY_JNR_GOV_PROPAGANDA_STEALTH'	),
		('GOV_JNR_PROPAGANDA_IGNORE_ZOC_RELIGIOUS',	'AbilityType',			'ABILITY_JNR_GOV_PROPAGANDA_IGNORE_ZOC'	),
		('GOV_JNR_PROPAGANDA_LOYALTY_ATTACH',		'ModifierId',			'GOV_JNR_PROPAGANDA_LOYALTY'			),
		('GOV_JNR_PROPAGANDA_LOYALTY',				'Amount',				2										),
		('GOV_JNR_DIPLOMACY_GOVERNOR_FAVOR_ATTACH',	'ModifierId',			'GOV_JNR_DIPLOMACY_GOVERNOR_FAVOR'		),
		('GOV_JNR_DIPLOMACY_GOVERNOR_FAVOR',		'Amount',				4										),
		('GOV_JNR_DIPLOMACY_FAVOR_RETURN',			'ResolutionType',		'WC_RES_DIPLOVICTORY'					),
		('GOV_JNR_DIPLOMACY_FAVOR_RETURN',			'WhichEffect',			1										),
		('GOV_JNR_DIPLOMACY_FAVOR_RETURN',			'Percent',				25										),
		('GOV_JNR_DIPLOMACY_DIPLOMATIC_VP',			'Amount',				1										);
--------------------------------------------------------------

-- RequirementSets
--------------------------------------------------------------
INSERT OR IGNORE INTO RequirementSets
		(RequirementSetId,								RequirementSetType)
VALUES	('JNR_UNIT_IS_LAND_UNIT',						'REQUIREMENTSET_TEST_ALL'),
		('JNR_DRONE_LOYALTY_REQUIREMENTS',				'REQUIREMENTSET_TEST_ALL'),
		('CITY_HAS_4_TITLE_GOVERNOR_JNR_REQUIREMENTS',	'REQUIREMENTSET_TEST_ALL');
--------------------------------------------------------------

-- RequirementSetRequirements
--------------------------------------------------------------
INSERT OR IGNORE INTO RequirementSetRequirements
		(RequirementSetId,								RequirementId)
VALUES	('JNR_UNIT_IS_LAND_UNIT',						'REQUIRES_LAND_UNIT'),
		('JNR_DRONE_LOYALTY_REQUIREMENTS',				'REQUIRES_JNR_ADJACENT_DRONE'),
		('JNR_DRONE_LOYALTY_REQUIREMENTS',				'REQUIRES_JNR_DISTRICT_IS_CITY_CENTER'),
		('CITY_HAS_4_TITLE_GOVERNOR_JNR_REQUIREMENTS',	'REQUIRES_CITY_HAS_4_TITLE_GOVERNOR_JNR');
--------------------------------------------------------------

-- Requirements
--------------------------------------------------------------
INSERT OR IGNORE INTO Requirements
		(RequirementId,										RequirementType)
VALUES	('REQUIRES_JNR_ADJACENT_DRONE',						'REQUIREMENT_PLOT_ADJACENT_FRIENDLY_UNIT_TAG_MATCHES'),
		('REQUIRES_JNR_DISTRICT_IS_CITY_CENTER',			'REQUIREMENT_DISTRICT_TYPE_MATCHES'),
		('REQUIRES_CITY_HAS_4_TITLE_GOVERNOR_JNR',			'REQUIREMENT_CITY_HAS_GOVERNOR_WITH_X_TITLES');
--------------------------------------------------------------

-- RequirementArguments
--------------------------------------------------------------
INSERT OR REPLACE INTO RequirementArguments
		(RequirementId,										Name,				Value)
VALUES	('REQUIRES_JNR_ADJACENT_DRONE',						'IncludeCenter',	1),
		('REQUIRES_JNR_ADJACENT_DRONE',						'Tag',				'CLASS_DRONE'),
		('REQUIRES_JNR_DISTRICT_IS_CITY_CENTER',			'DistrictType',		'DISTRICT_CITY_CENTER'),
		('REQUIRES_CITY_HAS_4_TITLE_GOVERNOR_JNR',			'Established',		1),
		('REQUIRES_CITY_HAS_4_TITLE_GOVERNOR_JNR',			'Amount',			4);
--------------------------------------------------------------