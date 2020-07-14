-- UC_CS3_UC_Compatibility
-- Author: JNR
--------------------------------------------------------------

-- TraitModifiers
--------------------------------------------------------------
INSERT OR REPLACE INTO TraitModifiers
		(ModifierId,														TraitType)
SELECT	'MINOR_CIV_INDUSTRIAL_UNIQUE_INFLUENCE_BONUS_BATTERY_BUILDING_JNR',	'MINOR_CIV_INDUSTRIAL_TRAIT'	FROM Buildings WHERE BuildingType='BUILDING_JNR_RENEWABLE_DISTRIBUTION';
INSERT OR REPLACE INTO TraitModifiers
		(ModifierId,														TraitType)
SELECT	'MINOR_CIV_INDUSTRIAL_UNIQUE_INFLUENCE_BONUS_BATTERY_DISTRICT_JNR',	'MINOR_CIV_INDUSTRIAL_TRAIT'	FROM Buildings WHERE BuildingType='BUILDING_JNR_RENEWABLE_DISTRIBUTION';
--------------------------------------------------------------

-- Modifiers and ModifierArguments (Attach Modifier System)
--------------------------------------------------------------
INSERT OR REPLACE INTO Modifiers
		(ModifierId,														ModifierType,							SubjectRequirementSetId)
SELECT	'MINOR_CIV_INDUSTRIAL_UNIQUE_INFLUENCE_BONUS_BATTERY_BUILDING_JNR',	'MODIFIER_ALL_PLAYERS_ATTACH_MODIFIER',	'JNR_PLAYER_IS_SUZERAIN_OR_HAS_ENORMOUS_INFLUENCE'	FROM Buildings WHERE BuildingType='BUILDING_JNR_RENEWABLE_DISTRIBUTION';
INSERT OR REPLACE INTO Modifiers
		(ModifierId,														ModifierType,							SubjectRequirementSetId)
SELECT	'MINOR_CIV_INDUSTRIAL_UNIQUE_INFLUENCE_BONUS_BATTERY_DISTRICT_JNR',	'MODIFIER_ALL_PLAYERS_ATTACH_MODIFIER',	'JNR_PLAYER_IS_SUZERAIN_OR_HAS_ENORMOUS_INFLUENCE'	FROM Buildings WHERE BuildingType='BUILDING_JNR_RENEWABLE_DISTRIBUTION';

INSERT OR REPLACE INTO ModifierArguments
		(ModifierId,														Name,			Value)
SELECT	'MINOR_CIV_INDUSTRIAL_UNIQUE_INFLUENCE_BONUS_BATTERY_BUILDING_JNR',	'ModifierId',	'MINOR_CIV_INDUSTRIAL_BUILDING_PRODUCTION_FOR_BATTERY_POWER_JNR'	FROM Buildings WHERE BuildingType='BUILDING_JNR_RENEWABLE_DISTRIBUTION';
INSERT OR REPLACE INTO ModifierArguments
		(ModifierId,														Name,			Value)
SELECT	'MINOR_CIV_INDUSTRIAL_UNIQUE_INFLUENCE_BONUS_BATTERY_DISTRICT_JNR',	'ModifierId',	'MINOR_CIV_INDUSTRIAL_DISTRICT_PRODUCTION_FOR_BATTERY_POWER_JNR'	FROM Buildings WHERE BuildingType='BUILDING_JNR_RENEWABLE_DISTRIBUTION';
--------------------------------------------------------------

-- Modifiers
--------------------------------------------------------------
INSERT OR REPLACE INTO Modifiers
		(ModifierId,														ModifierType,												SubjectRequirementSetId)
SELECT	'MINOR_CIV_INDUSTRIAL_BUILDING_PRODUCTION_FOR_BATTERY_POWER_JNR',	'MODIFIER_PLAYER_CITIES_ADJUST_BUILDING_PRODUCTION_CHANGE',	'JNR_BUILDING_IS_JNR_RENEWABLE_DISTRIBUTION'	FROM Buildings WHERE BuildingType='BUILDING_JNR_RENEWABLE_DISTRIBUTION';
INSERT OR REPLACE INTO Modifiers
		(ModifierId,														ModifierType,												SubjectRequirementSetId)
SELECT	'MINOR_CIV_INDUSTRIAL_DISTRICT_PRODUCTION_FOR_BATTERY_POWER_JNR',	'MODIFIER_PLAYER_CITIES_ADJUST_DISTRICT_PRODUCTION_CHANGE',	'JNR_BUILDING_IS_JNR_RENEWABLE_DISTRIBUTION'	FROM Buildings WHERE BuildingType='BUILDING_JNR_RENEWABLE_DISTRIBUTION';
--------------------------------------------------------------

-- ModifierArguments
--------------------------------------------------------------
INSERT OR REPLACE INTO ModifierArguments
		(ModifierId,														Name,		Value)
SELECT	'MINOR_CIV_INDUSTRIAL_BUILDING_PRODUCTION_FOR_BATTERY_POWER_JNR',	'Amount',	2	FROM Buildings WHERE BuildingType='BUILDING_JNR_RENEWABLE_DISTRIBUTION';
INSERT OR REPLACE INTO ModifierArguments
		(ModifierId,														Name,		Value)
SELECT	'MINOR_CIV_INDUSTRIAL_DISTRICT_PRODUCTION_FOR_BATTERY_POWER_JNR',	'Amount',	2	FROM Buildings WHERE BuildingType='BUILDING_JNR_RENEWABLE_DISTRIBUTION';
--------------------------------------------------------------

-- RequirementSets
--------------------------------------------------------------
INSERT OR REPLACE INTO RequirementSets
		(RequirementSetId,								RequirementSetType)
SELECT	'JNR_BUILDING_IS_JNR_RENEWABLE_DISTRIBUTION',	'REQUIREMENTSET_TEST_ALL'	FROM Buildings WHERE BuildingType='BUILDING_JNR_RENEWABLE_DISTRIBUTION';
--------------------------------------------------------------

-- RequirementSetRequirements
--------------------------------------------------------------
INSERT OR REPLACE INTO RequirementSetRequirements
		(RequirementSetId,								RequirementId)
SELECT	'JNR_BUILDING_IS_JNR_RENEWABLE_DISTRIBUTION',	'JNR_CITY_HAS_JNR_RENEWABLE_DISTRIBUTION'	FROM Buildings WHERE BuildingType='BUILDING_JNR_RENEWABLE_DISTRIBUTION';
--------------------------------------------------------------

-- Requirements
--------------------------------------------------------------
INSERT OR REPLACE INTO Requirements
		(RequirementId,								RequirementType)
SELECT	'JNR_CITY_HAS_JNR_RENEWABLE_DISTRIBUTION',	'REQUIREMENT_CITY_HAS_BUILDING'	FROM Buildings WHERE BuildingType='BUILDING_JNR_RENEWABLE_DISTRIBUTION';
--------------------------------------------------------------

-- RequirementArguments
--------------------------------------------------------------
INSERT OR REPLACE INTO RequirementArguments
		(RequirementId,								Name,			Value)
SELECT	'JNR_CITY_HAS_JNR_RENEWABLE_DISTRIBUTION',	'BuildingType',	'BUILDING_JNR_RENEWABLE_DISTRIBUTION'	FROM Buildings WHERE BuildingType='BUILDING_JNR_RENEWABLE_DISTRIBUTION';
--------------------------------------------------------------

-- ModifierStrings
--------------------------------------------------------------
INSERT OR REPLACE INTO ModifierStrings
		(ModifierId,														Context,	Text)
SELECT	'MINOR_CIV_INDUSTRIAL_UNIQUE_INFLUENCE_BONUS_BATTERY_BUILDING_JNR',	'Preview',	'LOC_MINOR_CIV_INDUSTRIAL_UNIQUE_INFLUENCE_BONUS_BATTERY_BUILDING_JNR'	FROM Buildings WHERE BuildingType='BUILDING_JNR_RENEWABLE_DISTRIBUTION';
INSERT OR REPLACE INTO ModifierStrings
		(ModifierId,														Context,	Text)
SELECT	'MINOR_CIV_INDUSTRIAL_UNIQUE_INFLUENCE_BONUS_BATTERY_DISTRICT_JNR',	'Preview',	'LOC_MINOR_CIV_INDUSTRIAL_UNIQUE_INFLUENCE_BONUS_BATTERY_DISTRICT_JNR'	FROM Buildings WHERE BuildingType='BUILDING_JNR_RENEWABLE_DISTRIBUTION';
--------------------------------------------------------------