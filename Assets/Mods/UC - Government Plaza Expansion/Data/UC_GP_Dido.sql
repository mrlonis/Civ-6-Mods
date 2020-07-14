-- UC_GP_Dido
-- Author: JNR
--------------------------------------------------------------

-- TraitModifiers
--------------------------------------------------------------
INSERT OR IGNORE INTO TraitModifiers
		(ModifierId,									TraitType)
VALUES	('TRADE_ROUTE_GOVERNMENT_JNR_TIER_4_BUILDING',	'TRAIT_LEADER_FOUNDER_CARTHAGE');
--------------------------------------------------------------

-- Modifiers
--------------------------------------------------------------
INSERT OR IGNORE INTO Modifiers
		(ModifierId,									ModifierType,											SubjectRequirementSetId)
VALUES	('TRADE_ROUTE_GOVERNMENT_JNR_TIER_4_BUILDING',	'MODIFIER_PLAYER_CITIES_ADJUST_TRADE_ROUTE_CAPACITY',	'CITY_HAS_JNR_TIER_4_GOV_BUILDING');
--------------------------------------------------------------

-- ModifierArguments
--------------------------------------------------------------
INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,										Name,		Value)
VALUES	('TRADE_ROUTE_GOVERNMENT_JNR_TIER_4_BUILDING',		'Amount',	1);
--------------------------------------------------------------

-- RequirementSets
--------------------------------------------------------------
INSERT OR IGNORE INTO RequirementSets
		(RequirementSetId,						RequirementSetType)
VALUES	('CITY_HAS_JNR_TIER_4_GOV_BUILDING',	'REQUIREMENTSET_TEST_ALL');
--------------------------------------------------------------

-- RequirementSetRequirements
--------------------------------------------------------------
INSERT OR IGNORE INTO RequirementSetRequirements
		(RequirementSetId,						RequirementId)
VALUES	('CITY_HAS_JNR_TIER_4_GOV_BUILDING',	'REQUIRES_CITY_HAS_JNR_TIER_4_GOV_BUILDING');
--------------------------------------------------------------

-- Requirements
--------------------------------------------------------------
INSERT OR IGNORE INTO Requirements
		(RequirementId,									RequirementType)
VALUES	('REQUIRES_CITY_HAS_JNR_TIER_4_GOV_BUILDING',	'REQUIREMENT_CITY_HAS_GOVERNMENT_BUILDING_TIER');
--------------------------------------------------------------

-- RequirementArguments
--------------------------------------------------------------
INSERT OR IGNORE INTO RequirementArguments
		(RequirementId,									Name,						Value)
VALUES	('REQUIRES_CITY_HAS_JNR_TIER_4_GOV_BUILDING',	'GovernmentBuildingTier',	'Tier4');
--------------------------------------------------------------