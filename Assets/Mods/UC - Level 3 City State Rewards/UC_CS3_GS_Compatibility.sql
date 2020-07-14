-- UC_CS3_GS_Compatibility
-- Author: JNR
--------------------------------------------------------------

-- TraitModifiers
--------------------------------------------------------------
INSERT OR REPLACE INTO TraitModifiers
		(ModifierId,														TraitType)
SELECT	'MINOR_CIV_TRADE_UNIQUE_INFLUENCE_BONUS_SEAPORT_JNR',				'MINOR_CIV_TRADE_TRAIT'			FROM TraitModifiers WHERE ModifierId='MINOR_CIV_TRADE_LARGE_INFLUENCE_BONUS_SHIPYARD';

INSERT OR REPLACE INTO TraitModifiers
		(ModifierId,														TraitType)
SELECT	'MINOR_CIV_INDUSTRIAL_UNIQUE_INFLUENCE_BONUS_COAL_BUILDING_JNR',	'MINOR_CIV_INDUSTRIAL_TRAIT'	FROM Buildings WHERE BuildingType='BUILDING_COAL_POWER_PLANT';
INSERT OR REPLACE INTO TraitModifiers
		(ModifierId,														TraitType)
SELECT	'MINOR_CIV_INDUSTRIAL_UNIQUE_INFLUENCE_BONUS_COAL_DISTRICT_JNR',	'MINOR_CIV_INDUSTRIAL_TRAIT'	FROM Buildings WHERE BuildingType='BUILDING_COAL_POWER_PLANT';
INSERT OR REPLACE INTO TraitModifiers
		(ModifierId,														TraitType)
SELECT	'MINOR_CIV_INDUSTRIAL_UNIQUE_INFLUENCE_BONUS_OIL_BUILDING_JNR',		'MINOR_CIV_INDUSTRIAL_TRAIT'	FROM Buildings WHERE BuildingType='BUILDING_FOSSIL_FUEL_POWER_PLANT';
INSERT OR REPLACE INTO TraitModifiers
		(ModifierId,														TraitType)
SELECT	'MINOR_CIV_INDUSTRIAL_UNIQUE_INFLUENCE_BONUS_OIL_DISTRICT_JNR',		'MINOR_CIV_INDUSTRIAL_TRAIT'	FROM Buildings WHERE BuildingType='BUILDING_FOSSIL_FUEL_POWER_PLANT';
--------------------------------------------------------------

-- Modifiers and ModifierArguments (Attach Modifier System)
--------------------------------------------------------------
INSERT OR REPLACE INTO Modifiers
		(ModifierId,														ModifierType,							SubjectRequirementSetId)
SELECT	'MINOR_CIV_TRADE_UNIQUE_INFLUENCE_BONUS_SEAPORT_JNR',				'MODIFIER_ALL_PLAYERS_ATTACH_MODIFIER',	'JNR_PLAYER_IS_SUZERAIN_OR_HAS_ENORMOUS_INFLUENCE'	FROM TraitModifiers WHERE ModifierId='MINOR_CIV_TRADE_LARGE_INFLUENCE_BONUS_SHIPYARD';

INSERT OR REPLACE INTO Modifiers
		(ModifierId,														ModifierType,							SubjectRequirementSetId)
SELECT	'MINOR_CIV_INDUSTRIAL_UNIQUE_INFLUENCE_BONUS_COAL_BUILDING_JNR',	'MODIFIER_ALL_PLAYERS_ATTACH_MODIFIER',	'JNR_PLAYER_IS_SUZERAIN_OR_HAS_ENORMOUS_INFLUENCE'	FROM Buildings WHERE BuildingType='BUILDING_COAL_POWER_PLANT';
INSERT OR REPLACE INTO Modifiers
		(ModifierId,														ModifierType,							SubjectRequirementSetId)
SELECT	'MINOR_CIV_INDUSTRIAL_UNIQUE_INFLUENCE_BONUS_COAL_DISTRICT_JNR',	'MODIFIER_ALL_PLAYERS_ATTACH_MODIFIER',	'JNR_PLAYER_IS_SUZERAIN_OR_HAS_ENORMOUS_INFLUENCE'	FROM Buildings WHERE BuildingType='BUILDING_COAL_POWER_PLANT';
INSERT OR REPLACE INTO Modifiers
		(ModifierId,														ModifierType,							SubjectRequirementSetId)
SELECT	'MINOR_CIV_INDUSTRIAL_UNIQUE_INFLUENCE_BONUS_OIL_BUILDING_JNR',		'MODIFIER_ALL_PLAYERS_ATTACH_MODIFIER',	'JNR_PLAYER_IS_SUZERAIN_OR_HAS_ENORMOUS_INFLUENCE'	FROM Buildings WHERE BuildingType='BUILDING_FOSSIL_FUEL_POWER_PLANT';
INSERT OR REPLACE INTO Modifiers
		(ModifierId,														ModifierType,							SubjectRequirementSetId)
SELECT	'MINOR_CIV_INDUSTRIAL_UNIQUE_INFLUENCE_BONUS_OIL_DISTRICT_JNR',		'MODIFIER_ALL_PLAYERS_ATTACH_MODIFIER',	'JNR_PLAYER_IS_SUZERAIN_OR_HAS_ENORMOUS_INFLUENCE'	FROM Buildings WHERE BuildingType='BUILDING_FOSSIL_FUEL_POWER_PLANT';

INSERT OR REPLACE INTO ModifierArguments
		(ModifierId,														Name,			Value)
SELECT	'MINOR_CIV_TRADE_UNIQUE_INFLUENCE_BONUS_SEAPORT_JNR',				'ModifierId',	'MINOR_CIV_TRADE_YIELD_FOR_SEAPORT_JNR'								FROM TraitModifiers WHERE ModifierId='MINOR_CIV_TRADE_LARGE_INFLUENCE_BONUS_SHIPYARD';

INSERT OR REPLACE INTO ModifierArguments
		(ModifierId,														Name,			Value)
SELECT	'MINOR_CIV_INDUSTRIAL_UNIQUE_INFLUENCE_BONUS_COAL_BUILDING_JNR',	'ModifierId',	'MINOR_CIV_INDUSTRIAL_BUILDING_PRODUCTION_FOR_COAL_POWER_PLANT_JNR'	FROM Buildings WHERE BuildingType='BUILDING_COAL_POWER_PLANT';
INSERT OR REPLACE INTO ModifierArguments
		(ModifierId,														Name,			Value)
SELECT	'MINOR_CIV_INDUSTRIAL_UNIQUE_INFLUENCE_BONUS_COAL_DISTRICT_JNR',	'ModifierId',	'MINOR_CIV_INDUSTRIAL_DISTRICT_PRODUCTION_FOR_COAL_POWER_PLANT_JNR'	FROM Buildings WHERE BuildingType='BUILDING_COAL_POWER_PLANT';
INSERT OR REPLACE INTO ModifierArguments
		(ModifierId,														Name,			Value)
SELECT	'MINOR_CIV_INDUSTRIAL_UNIQUE_INFLUENCE_BONUS_OIL_BUILDING_JNR',		'ModifierId',	'MINOR_CIV_INDUSTRIAL_BUILDING_PRODUCTION_FOR_OIL_POWER_PLANT_JNR'	FROM Buildings WHERE BuildingType='BUILDING_FOSSIL_FUEL_POWER_PLANT';
INSERT OR REPLACE INTO ModifierArguments
		(ModifierId,														Name,			Value)
SELECT	'MINOR_CIV_INDUSTRIAL_UNIQUE_INFLUENCE_BONUS_OIL_DISTRICT_JNR',		'ModifierId',	'MINOR_CIV_INDUSTRIAL_DISTRICT_PRODUCTION_FOR_OIL_POWER_PLANT_JNR'	FROM Buildings WHERE BuildingType='BUILDING_FOSSIL_FUEL_POWER_PLANT';
--------------------------------------------------------------

-- Modifiers
--------------------------------------------------------------
INSERT OR REPLACE INTO Modifiers
		(ModifierId,															ModifierType,												SubjectRequirementSetId)
SELECT	'MINOR_CIV_TRADE_YIELD_FOR_SEAPORT_JNR',								'MODIFIER_PLAYER_CITIES_ADJUST_BUILDING_YIELD_CHANGE',		NULL										FROM TraitModifiers WHERE ModifierId='MINOR_CIV_TRADE_LARGE_INFLUENCE_BONUS_SHIPYARD';

INSERT OR REPLACE INTO Modifiers
		(ModifierId,															ModifierType,												SubjectRequirementSetId)
SELECT	'MINOR_CIV_INDUSTRIAL_BUILDING_PRODUCTION_FOR_COAL_POWER_PLANT_JNR',	'MODIFIER_PLAYER_CITIES_ADJUST_BUILDING_PRODUCTION_CHANGE',	'JNR_BUILDING_IS_COAL_POWER_PLANT'			FROM Buildings WHERE BuildingType='BUILDING_COAL_POWER_PLANT';
INSERT OR REPLACE INTO Modifiers
		(ModifierId,															ModifierType,												SubjectRequirementSetId)
SELECT	'MINOR_CIV_INDUSTRIAL_DISTRICT_PRODUCTION_FOR_COAL_POWER_PLANT_JNR',	'MODIFIER_PLAYER_CITIES_ADJUST_DISTRICT_PRODUCTION_CHANGE',	'JNR_BUILDING_IS_COAL_POWER_PLANT'			FROM Buildings WHERE BuildingType='BUILDING_COAL_POWER_PLANT';
INSERT OR REPLACE INTO Modifiers
		(ModifierId,															ModifierType,												SubjectRequirementSetId)
SELECT	'MINOR_CIV_INDUSTRIAL_BUILDING_PRODUCTION_FOR_OIL_POWER_PLANT_JNR',		'MODIFIER_PLAYER_CITIES_ADJUST_BUILDING_PRODUCTION_CHANGE',	'JNR_BUILDING_IS_FOSSILE_FUEL_POWER_PLANT'	FROM Buildings WHERE BuildingType='BUILDING_FOSSIL_FUEL_POWER_PLANT';
INSERT OR REPLACE INTO Modifiers
		(ModifierId,															ModifierType,												SubjectRequirementSetId)
SELECT	'MINOR_CIV_INDUSTRIAL_DISTRICT_PRODUCTION_FOR_OIL_POWER_PLANT_JNR',		'MODIFIER_PLAYER_CITIES_ADJUST_DISTRICT_PRODUCTION_CHANGE',	'JNR_BUILDING_IS_FOSSILE_FUEL_POWER_PLANT'	FROM Buildings WHERE BuildingType='BUILDING_FOSSIL_FUEL_POWER_PLANT';
--------------------------------------------------------------

-- ModifierArguments
--------------------------------------------------------------
UPDATE ModifierArguments SET Value=2	WHERE ModifierId='MINOR_CIV_TRADE_YIELD_FOR_STOCK_EXCHANGE_JNR' AND Name='Amount';

INSERT OR REPLACE INTO ModifierArguments
		(ModifierId,															Name,			Value)
SELECT	'MINOR_CIV_TRADE_YIELD_FOR_SEAPORT_JNR',								'YieldType',	'YIELD_GOLD'				FROM TraitModifiers WHERE ModifierId='MINOR_CIV_TRADE_LARGE_INFLUENCE_BONUS_SHIPYARD';

INSERT OR REPLACE INTO ModifierArguments
		(ModifierId,															Name,			Value)
SELECT	'MINOR_CIV_TRADE_YIELD_FOR_SEAPORT_JNR',								'BuildingType',	'BUILDING_STOCK_EXCHANGE'	FROM TraitModifiers WHERE ModifierId='MINOR_CIV_TRADE_LARGE_INFLUENCE_BONUS_SHIPYARD';

INSERT OR REPLACE INTO ModifierArguments
		(ModifierId,															Name,			Value)
SELECT	'MINOR_CIV_TRADE_YIELD_FOR_SEAPORT_JNR',								'Amount',		2							FROM TraitModifiers WHERE ModifierId='MINOR_CIV_TRADE_LARGE_INFLUENCE_BONUS_SHIPYARD';

INSERT OR REPLACE INTO ModifierArguments
		(ModifierId,															Name,			Value)
SELECT	'MINOR_CIV_INDUSTRIAL_BUILDING_PRODUCTION_FOR_COAL_POWER_PLANT_JNR',	'Amount',		2							FROM Buildings WHERE BuildingType='BUILDING_COAL_POWER_PLANT';
INSERT OR REPLACE INTO ModifierArguments
		(ModifierId,															Name,			Value)
SELECT	'MINOR_CIV_INDUSTRIAL_DISTRICT_PRODUCTION_FOR_COAL_POWER_PLANT_JNR',	'Amount',		2							FROM Buildings WHERE BuildingType='BUILDING_COAL_POWER_PLANT';
INSERT OR REPLACE INTO ModifierArguments
		(ModifierId,															Name,			Value)
SELECT	'MINOR_CIV_INDUSTRIAL_BUILDING_PRODUCTION_FOR_OIL_POWER_PLANT_JNR',		'Amount',		2							FROM Buildings WHERE BuildingType='BUILDING_FOSSIL_FUEL_POWER_PLANT';
INSERT OR REPLACE INTO ModifierArguments
		(ModifierId,															Name,			Value)
SELECT	'MINOR_CIV_INDUSTRIAL_DISTRICT_PRODUCTION_FOR_OIL_POWER_PLANT_JNR',		'Amount',		2							FROM Buildings WHERE BuildingType='BUILDING_FOSSIL_FUEL_POWER_PLANT';
--------------------------------------------------------------

-- RequirementSets
--------------------------------------------------------------
INSERT OR REPLACE INTO RequirementSets
		(RequirementSetId,							RequirementSetType)
SELECT	'JNR_BUILDING_IS_COAL_POWER_PLANT',			'REQUIREMENTSET_TEST_ALL'	FROM Buildings WHERE BuildingType='BUILDING_COAL_POWER_PLANT';
INSERT OR REPLACE INTO RequirementSets
		(RequirementSetId,							RequirementSetType)
SELECT	'JNR_BUILDING_IS_FOSSILE_FUEL_POWER_PLANT',	'REQUIREMENTSET_TEST_ALL'	FROM Buildings WHERE BuildingType='BUILDING_FOSSIL_FUEL_POWER_PLANT';
--------------------------------------------------------------

-- RequirementSetRequirements
--------------------------------------------------------------
INSERT OR REPLACE INTO RequirementSetRequirements
		(RequirementSetId,							RequirementId)
SELECT	'JNR_BUILDING_IS_COAL_POWER_PLANT',			'JNR_CITY_HAS_COAL_POWER_PLANT'			FROM Buildings WHERE BuildingType='BUILDING_COAL_POWER_PLANT';
INSERT OR REPLACE INTO RequirementSetRequirements
		(RequirementSetId,							RequirementId)
SELECT	'JNR_BUILDING_IS_FOSSILE_FUEL_POWER_PLANT',	'JNR_CITY_HAS_FOSSILE_FUEL_POWER_PLANT'	FROM Buildings WHERE BuildingType='BUILDING_FOSSIL_FUEL_POWER_PLANT';
--------------------------------------------------------------

-- Requirements
--------------------------------------------------------------
INSERT OR REPLACE INTO Requirements
		(RequirementId,								RequirementType)
SELECT	'JNR_CITY_HAS_COAL_POWER_PLANT',			'REQUIREMENT_CITY_HAS_BUILDING'	FROM Buildings WHERE BuildingType='BUILDING_COAL_POWER_PLANT';
INSERT OR REPLACE INTO Requirements
		(RequirementId,								RequirementType)
SELECT	'JNR_CITY_HAS_FOSSILE_FUEL_POWER_PLANT',	'REQUIREMENT_CITY_HAS_BUILDING'	FROM Buildings WHERE BuildingType='BUILDING_FOSSIL_FUEL_POWER_PLANT';
--------------------------------------------------------------

-- RequirementArguments
--------------------------------------------------------------
INSERT OR REPLACE INTO RequirementArguments
		(RequirementId,								Name,			Value)
SELECT	'JNR_CITY_HAS_COAL_POWER_PLANT',			'BuildingType',	'BUILDING_COAL_POWER_PLANT'	FROM Buildings WHERE BuildingType='BUILDING_COAL_POWER_PLANT';
INSERT OR REPLACE INTO RequirementArguments
		(RequirementId,								Name,			Value)
SELECT	'JNR_CITY_HAS_FOSSILE_FUEL_POWER_PLANT',	'BuildingType',	'BUILDING_FOSSIL_FUEL_POWER_PLANT'	FROM Buildings WHERE BuildingType='BUILDING_FOSSIL_FUEL_POWER_PLANT';
--------------------------------------------------------------

-- ModifierStrings
--------------------------------------------------------------
INSERT OR REPLACE INTO ModifierStrings
		(ModifierId,														Context,	Text)
SELECT	'MINOR_CIV_INDUSTRIAL_UNIQUE_INFLUENCE_BONUS_COAL_BUILDING_JNR',	'Preview',	'LOC_MINOR_CIV_INDUSTRIAL_UNIQUE_INFLUENCE_BONUS_COAL_BUILDING_JNR'	FROM Buildings WHERE BuildingType='BUILDING_COAL_POWER_PLANT';
INSERT OR REPLACE INTO ModifierStrings
		(ModifierId,														Context,	Text)
SELECT	'MINOR_CIV_INDUSTRIAL_UNIQUE_INFLUENCE_BONUS_COAL_DISTRICT_JNR',	'Preview',	'LOC_MINOR_CIV_INDUSTRIAL_UNIQUE_INFLUENCE_BONUS_COAL_DISTRICT_JNR'	FROM Buildings WHERE BuildingType='BUILDING_COAL_POWER_PLANT';
INSERT OR REPLACE INTO ModifierStrings
		(ModifierId,														Context,	Text)
SELECT	'MINOR_CIV_INDUSTRIAL_UNIQUE_INFLUENCE_BONUS_OIL_BUILDING_JNR',		'Preview',	'LOC_MINOR_CIV_INDUSTRIAL_UNIQUE_INFLUENCE_BONUS_OIL_BUILDING_JNR'	FROM Buildings WHERE BuildingType='BUILDING_FOSSIL_FUEL_POWER_PLANT';
INSERT OR REPLACE INTO ModifierStrings
		(ModifierId,														Context,	Text)
SELECT	'MINOR_CIV_INDUSTRIAL_UNIQUE_INFLUENCE_BONUS_OIL_DISTRICT_JNR',		'Preview',	'LOC_MINOR_CIV_INDUSTRIAL_UNIQUE_INFLUENCE_BONUS_OIL_DISTRICT_JNR'	FROM Buildings WHERE BuildingType='BUILDING_FOSSIL_FUEL_POWER_PLANT';
--------------------------------------------------------------