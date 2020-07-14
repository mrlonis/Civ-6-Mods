-- UC_COM_City_States_Tier3
-- Author: JNR
--------------------------------------------------------------

-- Modifiers
--------------------------------------------------------------
INSERT OR IGNORE INTO Modifiers
		(ModifierId,														ModifierType,	SubjectRequirementSetId)
SELECT	'MINOR_CIV_TRADE_UNIQUE_INFLUENCE_BONUS_COMMODITY_EXCHANGE_JNR',	ModifierType,	SubjectRequirementSetId
FROM	Modifiers
WHERE	ModifierId='MINOR_CIV_TRADE_UNIQUE_INFLUENCE_BONUS_JNR';

INSERT OR IGNORE INTO Modifiers
		(ModifierId,														ModifierType)
SELECT	'MINOR_CIV_TRADE_YIELD_FOR_COMMODITY_EXCHANGE_JNR',					ModifierType
FROM	Modifiers
WHERE	ModifierId='MINOR_CIV_TRADE_YIELD_FOR_STOCK_EXCHANGE_JNR';

INSERT OR IGNORE INTO Modifiers
		(ModifierId,														ModifierType,	SubjectRequirementSetId)
SELECT	'MINOR_CIV_TRADE_UNIQUE_INFLUENCE_BONUS_MARKETING_AGENCY_JNR',		ModifierType,	SubjectRequirementSetId
FROM	Modifiers
WHERE	ModifierId='MINOR_CIV_TRADE_UNIQUE_INFLUENCE_BONUS_JNR';

INSERT OR IGNORE INTO Modifiers
		(ModifierId,														ModifierType)
SELECT	'MINOR_CIV_TRADE_YIELD_FOR_MARKETING_AGENCY_JNR',					ModifierType
FROM	Modifiers
WHERE	ModifierId='MINOR_CIV_TRADE_YIELD_FOR_STOCK_EXCHANGE_JNR';

INSERT OR IGNORE INTO Modifiers
		(ModifierId,														ModifierType,	SubjectRequirementSetId)
SELECT	'MINOR_CIV_TRADE_UNIQUE_INFLUENCE_BONUS_CRUISE_TERMINAL_JNR',		ModifierType,	SubjectRequirementSetId
FROM	Modifiers
WHERE	ModifierId='MINOR_CIV_TRADE_UNIQUE_INFLUENCE_BONUS_SEAPORT_JNR';

INSERT OR IGNORE INTO Modifiers
		(ModifierId,														ModifierType)
SELECT	'MINOR_CIV_TRADE_YIELD_FOR_CRUISE_TERMINAL_JNR',					ModifierType
FROM	Modifiers
WHERE	ModifierId='MINOR_CIV_TRADE_YIELD_FOR_SEAPORT_JNR';
--------------------------------------------------------------

-- ModifierArguments
--------------------------------------------------------------
INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,														Name,				Value)
SELECT	'MINOR_CIV_TRADE_UNIQUE_INFLUENCE_BONUS_COMMODITY_EXCHANGE_JNR',	Name,				'MINOR_CIV_TRADE_YIELD_FOR_COMMODITY_EXCHANGE_JNR'
FROM	ModifierArguments
WHERE	ModifierId='MINOR_CIV_TRADE_UNIQUE_INFLUENCE_BONUS_JNR';

INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,														Name,				Value)
SELECT	'MINOR_CIV_TRADE_YIELD_FOR_COMMODITY_EXCHANGE_JNR',					'YieldType',		'YIELD_GOLD'
FROM	ModifierArguments
WHERE	ModifierId='MINOR_CIV_TRADE_YIELD_FOR_STOCK_EXCHANGE_JNR';

INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,														Name,				Value)
SELECT	'MINOR_CIV_TRADE_YIELD_FOR_COMMODITY_EXCHANGE_JNR',					'BuildingType',		'BUILDING_JNR_CRUISE_TERMINAL'
FROM	ModifierArguments
WHERE	ModifierId='MINOR_CIV_TRADE_YIELD_FOR_STOCK_EXCHANGE_JNR';

INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,														Name,				Value)
SELECT	'MINOR_CIV_TRADE_YIELD_FOR_COMMODITY_EXCHANGE_JNR',					'Amount',			2
FROM	ModifierArguments
WHERE	ModifierId='MINOR_CIV_TRADE_YIELD_FOR_STOCK_EXCHANGE_JNR';

INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,														Name,				Value)
SELECT	'MINOR_CIV_TRADE_YIELD_FOR_COMMODITY_EXCHANGE_JNR',					'CityStatesOnly',	1
FROM	ModifierArguments
WHERE	ModifierId='MINOR_CIV_TRADE_YIELD_FOR_STOCK_EXCHANGE_JNR';

INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,														Name,				Value)
SELECT	'MINOR_CIV_TRADE_UNIQUE_INFLUENCE_BONUS_MARKETING_AGENCY_JNR',		Name,				'MINOR_CIV_TRADE_YIELD_FOR_MARKETING_AGENCY_JNR'
FROM	ModifierArguments
WHERE	ModifierId='MINOR_CIV_TRADE_UNIQUE_INFLUENCE_BONUS_JNR';

INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,														Name,				Value)
SELECT	'MINOR_CIV_TRADE_YIELD_FOR_MARKETING_AGENCY_JNR',					'YieldType',		'YIELD_GOLD'
FROM	ModifierArguments
WHERE	ModifierId='MINOR_CIV_TRADE_YIELD_FOR_STOCK_EXCHANGE_JNR';

INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,														Name,				Value)
SELECT	'MINOR_CIV_TRADE_YIELD_FOR_MARKETING_AGENCY_JNR',					'BuildingType',		'BUILDING_JNR_CRUISE_TERMINAL'
FROM	ModifierArguments
WHERE	ModifierId='MINOR_CIV_TRADE_YIELD_FOR_STOCK_EXCHANGE_JNR';

INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,														Name,				Value)
SELECT	'MINOR_CIV_TRADE_YIELD_FOR_MARKETING_AGENCY_JNR',					'Amount',			2
FROM	ModifierArguments
WHERE	ModifierId='MINOR_CIV_TRADE_YIELD_FOR_STOCK_EXCHANGE_JNR';

INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,														Name,				Value)
SELECT	'MINOR_CIV_TRADE_YIELD_FOR_MARKETING_AGENCY_JNR',					'CityStatesOnly',	1
FROM	ModifierArguments
WHERE	ModifierId='MINOR_CIV_TRADE_YIELD_FOR_STOCK_EXCHANGE_JNR';

INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,														Name,				Value)
SELECT	'MINOR_CIV_TRADE_UNIQUE_INFLUENCE_BONUS_CRUISE_TERMINAL_JNR',		Name,				'MINOR_CIV_TRADE_YIELD_FOR_CRUISE_TERMINAL_JNR'
FROM	ModifierArguments
WHERE	ModifierId='MINOR_CIV_TRADE_UNIQUE_INFLUENCE_BONUS_SEAPORT_JNR';

INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,														Name,				Value)
SELECT	'MINOR_CIV_TRADE_YIELD_FOR_CRUISE_TERMINAL_JNR',					'YieldType',		'YIELD_GOLD'
FROM	ModifierArguments
WHERE	ModifierId='MINOR_CIV_TRADE_YIELD_FOR_SEAPORT_JNR';

INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,														Name,				Value)
SELECT	'MINOR_CIV_TRADE_YIELD_FOR_CRUISE_TERMINAL_JNR',					'BuildingType',		'BUILDING_JNR_CRUISE_TERMINAL'
FROM	ModifierArguments
WHERE	ModifierId='MINOR_CIV_TRADE_YIELD_FOR_SEAPORT_JNR';

INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,														Name,				Value)
SELECT	'MINOR_CIV_TRADE_YIELD_FOR_CRUISE_TERMINAL_JNR',					'Amount',			2
FROM	ModifierArguments
WHERE	ModifierId='MINOR_CIV_TRADE_YIELD_FOR_SEAPORT_JNR';

INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,														Name,				Value)
SELECT	'MINOR_CIV_TRADE_YIELD_FOR_CRUISE_TERMINAL_JNR',					'CityStatesOnly',	1
FROM	ModifierArguments
WHERE	ModifierId='MINOR_CIV_TRADE_YIELD_FOR_SEAPORT_JNR';
--------------------------------------------------------------

-- TraitModifiers
--------------------------------------------------------------
INSERT OR IGNORE INTO TraitModifiers
		(TraitType,	ModifierId)
SELECT	TraitType,	'MINOR_CIV_TRADE_UNIQUE_INFLUENCE_BONUS_COMMODITY_EXCHANGE_JNR'
FROM	TraitModifiers
WHERE	ModifierId='MINOR_CIV_TRADE_UNIQUE_INFLUENCE_BONUS_JNR';

INSERT OR IGNORE INTO TraitModifiers
		(TraitType,	ModifierId)
SELECT	TraitType,	'MINOR_CIV_TRADE_UNIQUE_INFLUENCE_BONUS_MARKETING_AGENCY_JNR'
FROM	TraitModifiers
WHERE	ModifierId='MINOR_CIV_TRADE_UNIQUE_INFLUENCE_BONUS_JNR';

INSERT OR IGNORE INTO TraitModifiers
		(TraitType,	ModifierId)
SELECT	TraitType,	'MINOR_CIV_TRADE_UNIQUE_INFLUENCE_BONUS_CRUISE_TERMINAL_JNR'
FROM	TraitModifiers
WHERE	ModifierId='MINOR_CIV_TRADE_UNIQUE_INFLUENCE_BONUS_SEAPORT_JNR';
--------------------------------------------------------------