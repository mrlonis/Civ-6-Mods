-- UC_GP_UnitAbilities
-- Author: JNR
--------------------------------------------------------------

-- Types
--------------------------------------------------------------
INSERT OR IGNORE INTO Types
		(Type,										Kind)
VALUES	('ABILITY_JNR_GOV_PROPAGANDA_STEALTH',		'KIND_ABILITY'),
		('ABILITY_JNR_GOV_PROPAGANDA_IGNORE_ZOC',	'KIND_ABILITY'),
		('ABILITY_JNR_GOV_MOCC_SPEC_OPS',			'KIND_ABILITY'),
		('ABILITY_JNR_GOV_MOCC_AIRCRAFT',			'KIND_ABILITY');
--------------------------------------------------------------

-- TypeTags
--------------------------------------------------------------
INSERT OR IGNORE INTO TypeTags
		(Type,										Tag)
VALUES	('ABILITY_JNR_GOV_PROPAGANDA_STEALTH',		'CLASS_RELIGIOUS_ALL'),
		('ABILITY_JNR_GOV_PROPAGANDA_IGNORE_ZOC',	'CLASS_RELIGIOUS_ALL'),
		('ABILITY_JNR_GOV_MOCC_SPEC_OPS',			'CLASS_SNIPER'),
		('ABILITY_JNR_GOV_MOCC_AIRCRAFT',			'CLASS_AIRCRAFT');
--------------------------------------------------------------

-- UnitAbilities
--------------------------------------------------------------
UPDATE UnitAbilities SET Inactive=1 WHERE UnitAbilityType='ABILITY_ROCK_BAND_ENTER_FOREIGN_LANDS';

INSERT OR IGNORE INTO UnitAbilities
		(UnitAbilityType,							Name,										Description,										Inactive)
VALUES	('ABILITY_JNR_GOV_PROPAGANDA_STEALTH',		'LOC_ABILITY_STEALTH_NAME',					'LOC_ABILITY_STEALTH_DESCRIPTION',					1),
		('ABILITY_JNR_GOV_PROPAGANDA_IGNORE_ZOC',	'LOC_ABILITY_IGNORE_ZOC_NAME',				'LOC_ABILITY_IGNORE_ZOC_DESCRIPTION',				1),
		('ABILITY_JNR_GOV_MOCC_SPEC_OPS',			'LOC_ABILITY_JNR_GOV_MOCC_SPEC_OPS_NAME',	'LOC_ABILITY_JNR_GOV_MOCC_SPEC_OPS_DESCRIPTION',	1),
		('ABILITY_JNR_GOV_MOCC_AIRCRAFT',			'LOC_ABILITY_JNR_GOV_MOCC_AIRCRAFT_NAME',	'LOC_ABILITY_JNR_GOV_MOCC_AIRCRAFT_DESCRIPTION',	1);
--------------------------------------------------------------

-- UnitAbilityModifiers
--------------------------------------------------------------
INSERT OR IGNORE INTO UnitAbilityModifiers
		(UnitAbilityType,							ModifierId)
VALUES	('ABILITY_JNR_GOV_PROPAGANDA_STEALTH',		'CAMOUFLAGE_STEALTH'),
		('ABILITY_JNR_GOV_PROPAGANDA_IGNORE_ZOC',	'IGNOREZOC_IGNORE_ZOC'),
		('ABILITY_JNR_GOV_MOCC_SPEC_OPS',			'JNR_GOV_MOCC_SPEC_OPS_ATTACK'),
		('ABILITY_JNR_GOV_MOCC_SPEC_OPS',			'JNR_GOV_MOCC_SPEC_OPS_DEFEND'),
		('ABILITY_JNR_GOV_MOCC_AIRCRAFT',			'JNR_GOV_MOCC_AIRCRAFT_MOVES'),
		('ABILITY_JNR_GOV_MOCC_AIRCRAFT',			'JNR_GOV_MOCC_AIRCRAFT_RANGE');
--------------------------------------------------------------

-- Modifiers
--------------------------------------------------------------
INSERT OR IGNORE INTO Modifiers
		(ModifierId,								ModifierType,									SubjectRequirementSetId)
VALUES	('JNR_GOV_MOCC_SPEC_OPS_ATTACK',	'MODIFIER_PLAYER_UNIT_ADJUST_FLANKING_BONUS_MODIFIER',	'JNR_HELICOPTER_IS_ADJACENT_ATTACK'),
		('JNR_GOV_MOCC_SPEC_OPS_DEFEND',	'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH',					'JNR_MECHANIZED_IS_ADJACENT_DEFEND'),
		('JNR_GOV_MOCC_AIRCRAFT_MOVES',		'MODIFIER_PLAYER_UNIT_ADJUST_MOVEMENT', 				NULL),
		('JNR_GOV_MOCC_AIRCRAFT_RANGE',		'MODIFIER_UNIT_ADJUST_ATTACK_RANGE',					NULL);
--------------------------------------------------------------

-- ModifierArguments
--------------------------------------------------------------
INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,						Name,		Value)
VALUES	('JNR_GOV_MOCC_SPEC_OPS_ATTACK',	'Amount',	150),
		('JNR_GOV_MOCC_SPEC_OPS_DEFEND',	'Amount',	15),
		('JNR_GOV_MOCC_AIRCRAFT_MOVES',		'Amount',	3),
		('JNR_GOV_MOCC_AIRCRAFT_RANGE',		'Amount',	2);
--------------------------------------------------------------

-- RequirementSets
--------------------------------------------------------------
INSERT OR IGNORE INTO RequirementSets
		(RequirementSetId,				RequirementSetType)
VALUES	('JNR_HELICOPTER_IS_ADJACENT_ATTACK',	'REQUIREMENTSET_TEST_ALL'),
		('JNR_MECHANIZED_IS_ADJACENT_DEFEND',	'REQUIREMENTSET_TEST_ALL');
--------------------------------------------------------------

-- RequirementSetRequirements
--------------------------------------------------------------
INSERT OR IGNORE INTO RequirementSetRequirements
		(RequirementSetId,						RequirementId)
VALUES	('JNR_HELICOPTER_IS_ADJACENT_ATTACK',	'UNIT_STRONG_WHEN_ATTACKING_REQUIREMENT'),
		('JNR_MECHANIZED_IS_ADJACENT_DEFEND',	'UNIT_WEAK_WHEN_DEFENDING_REQUIREMENT'),
		('JNR_HELICOPTER_IS_ADJACENT_ATTACK',	'REQUIRES_ADJACENT_HELICOPTER'),
		('JNR_MECHANIZED_IS_ADJACENT_DEFEND',	'REQUIRES_ADJACENT_MECHANIZED');
--------------------------------------------------------------

-- Requirements
--------------------------------------------------------------
INSERT OR IGNORE INTO Requirements
		(RequirementId,						RequirementType)
VALUES	('REQUIRES_ADJACENT_HELICOPTER',	'REQUIREMENT_PLOT_ADJACENT_FRIENDLY_UNIT_TYPE_MATCHES'),
		('REQUIRES_ADJACENT_MECHANIZED',	'REQUIREMENT_PLOT_ADJACENT_FRIENDLY_UNIT_TYPE_MATCHES');
--------------------------------------------------------------

-- RequirementArguments
--------------------------------------------------------------
INSERT OR IGNORE INTO RequirementArguments
		(RequirementId,						Name,		Value)
VALUES	('REQUIRES_ADJACENT_HELICOPTER',	'UnitType',	'UNIT_HELICOPTER'),
		('REQUIRES_ADJACENT_MECHANIZED',	'UnitType',	'UNIT_MECHANIZED_INFANTRY');
--------------------------------------------------------------