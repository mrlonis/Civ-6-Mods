-- UC_COM_CSE_Trade
-- Author: JNR
--------------------------------------------------------------

-- Modifiers
--------------------------------------------------------------
INSERT OR IGNORE INTO Modifiers
		(ModifierId,										ModifierType,	SubjectRequirementSetId)
SELECT	'MODIFIER_CSE_TRADE_MINT_GOLD_JNR',					ModifierType,	SubjectRequirementSetId
FROM	Modifiers
WHERE	ModifierId='MODIFIER_CSE_TRADE_MARKET_GOLD';

INSERT OR IGNORE INTO Modifiers
		(ModifierId,										ModifierType,	SubjectRequirementSetId)
SELECT	'MODIFIER_CSE_TRADE_WAYSTATION_GOLD_JNR',			ModifierType,	SubjectRequirementSetId
FROM	Modifiers
WHERE	ModifierId='MODIFIER_CSE_TRADE_MARKET_GOLD';

INSERT OR IGNORE INTO Modifiers
		(ModifierId,										ModifierType,	SubjectRequirementSetId)
SELECT	'MODIFIER_CSE_TRADE_GUILDHALL_GOLD_JNR',			ModifierType,	SubjectRequirementSetId
FROM	Modifiers
WHERE	ModifierId='MODIFIER_CSE_TRADE_BANK_GOLD';

INSERT OR IGNORE INTO Modifiers
		(ModifierId,										ModifierType,	SubjectRequirementSetId)
SELECT	'MODIFIER_CSE_TRADE_MERCHANT_QUARTER_GOLD_JNR',		ModifierType,	SubjectRequirementSetId
FROM	Modifiers
WHERE	ModifierId='MODIFIER_CSE_TRADE_BANK_GOLD';

INSERT OR IGNORE INTO Modifiers
		(ModifierId,										ModifierType,	SubjectRequirementSetId)
SELECT	'MODIFIER_CSE_TRADE_COMMODITY_EXCHANGE_GOLD_JNR',	ModifierType,	SubjectRequirementSetId
FROM	Modifiers
WHERE	ModifierId='MODIFIER_CSE_TRADE_STOCK_EXCHANGE_GOLD';

INSERT OR IGNORE INTO Modifiers
		(ModifierId,										ModifierType,	SubjectRequirementSetId)
SELECT	'MODIFIER_CSE_TRADE_MARKETING_AGENCY_GOLD_JNR',		ModifierType,	SubjectRequirementSetId
FROM	Modifiers
WHERE	ModifierId='MODIFIER_CSE_TRADE_STOCK_EXCHANGE_GOLD';

INSERT OR IGNORE INTO Modifiers
		(ModifierId,											ModifierType,	SubjectRequirementSetId)
SELECT	'MODIFIER_CSE_TRADE_MINT_GOLD_MOD_JNR',					ModifierType,	SubjectRequirementSetId
FROM	Modifiers
WHERE	ModifierId='MODIFIER_CSE_TRADE_MARKET_GOLD_MOD';

INSERT OR IGNORE INTO Modifiers
		(ModifierId,											ModifierType,	SubjectRequirementSetId)
SELECT	'MODIFIER_CSE_TRADE_WAYSTATION_GOLD_MOD_JNR',			ModifierType,	SubjectRequirementSetId
FROM	Modifiers
WHERE	ModifierId='MODIFIER_CSE_TRADE_MARKET_GOLD_MOD';

INSERT OR IGNORE INTO Modifiers
		(ModifierId,											ModifierType,	SubjectRequirementSetId)
SELECT	'MODIFIER_CSE_TRADE_GUILDHALL_GOLD_MOD_JNR',			ModifierType,	SubjectRequirementSetId
FROM	Modifiers
WHERE	ModifierId='MODIFIER_CSE_TRADE_BANK_GOLD_MOD';

INSERT OR IGNORE INTO Modifiers
		(ModifierId,											ModifierType,	SubjectRequirementSetId)
SELECT	'MODIFIER_CSE_TRADE_MERCHANT_QUARTER_GOLD_MOD_JNR',		ModifierType,	SubjectRequirementSetId
FROM	Modifiers
WHERE	ModifierId='MODIFIER_CSE_TRADE_BANK_GOLD_MOD';

INSERT OR IGNORE INTO Modifiers
		(ModifierId,											ModifierType,	SubjectRequirementSetId)
SELECT	'MODIFIER_CSE_TRADE_COMMODITY_EXCHANGE_GOLD_MOD_JNR',	ModifierType,	SubjectRequirementSetId
FROM	Modifiers
WHERE	ModifierId='MODIFIER_CSE_TRADE_STOCK_EXCHANGE_GOLD_MOD';

INSERT OR IGNORE INTO Modifiers
		(ModifierId,											ModifierType,	SubjectRequirementSetId)
SELECT	'MODIFIER_CSE_TRADE_MARKETING_AGENCY_GOLD_MOD_JNR',		ModifierType,	SubjectRequirementSetId
FROM	Modifiers
WHERE	ModifierId='MODIFIER_CSE_TRADE_STOCK_EXCHANGE_GOLD_MOD';
--------------------------------------------------------------

-- ModifierArguments
--------------------------------------------------------------
INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,										Name,				Value)
SELECT	'MODIFIER_CSE_TRADE_MINT_GOLD_JNR',					Name,				'MODIFIER_CSE_TRADE_MINT_GOLD_MOD_JNR'
FROM	ModifierArguments
WHERE	ModifierId='MODIFIER_CSE_TRADE_MARKET_GOLD';

INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,										Name,				Value)
SELECT	'MODIFIER_CSE_TRADE_WAYSTATION_GOLD_JNR',			Name,				'MODIFIER_CSE_TRADE_WAYSTATION_GOLD_MOD_JNR'
FROM	ModifierArguments
WHERE	ModifierId='MODIFIER_CSE_TRADE_MARKET_GOLD';

INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,										Name,				Value)
SELECT	'MODIFIER_CSE_TRADE_GUILDHALL_GOLD_JNR',			Name,				'MODIFIER_CSE_TRADE_GUILDHALL_GOLD_MOD_JNR'
FROM	ModifierArguments
WHERE	ModifierId='MODIFIER_CSE_TRADE_BANK_GOLD';

INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,										Name,				Value)
SELECT	'MODIFIER_CSE_TRADE_MERCHANT_QUARTER_GOLD_JNR',		Name,				'MODIFIER_CSE_TRADE_MERCHANT_QUARTER_GOLD_MOD_JNR'
FROM	ModifierArguments
WHERE	ModifierId='MODIFIER_CSE_TRADE_BANK_GOLD';

INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,										Name,				Value)
SELECT	'MODIFIER_CSE_TRADE_COMMODITY_EXCHANGE_GOLD_JNR',	Name,				'MODIFIER_CSE_TRADE_COMMODITY_EXCHANGE_GOLD_MOD_JNR'
FROM	ModifierArguments
WHERE	ModifierId='MODIFIER_CSE_TRADE_STOCK_EXCHANGE_GOLD';

INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,										Name,				Value)
SELECT	'MODIFIER_CSE_TRADE_MARKETING_AGENCY_GOLD_JNR',		Name,				'MODIFIER_CSE_TRADE_MARKETING_AGENCY_GOLD_MOD_JNR'
FROM	ModifierArguments
WHERE	ModifierId='MODIFIER_CSE_TRADE_STOCK_EXCHANGE_GOLD';

INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,											Name,				Value)
SELECT	'MODIFIER_CSE_TRADE_MINT_GOLD_MOD_JNR',					'BuildingType',		'BUILDING_JNR_MINT'
FROM	ModifierArguments
WHERE	ModifierId='MODIFIER_CSE_TRADE_MARKET_GOLD_MOD';

INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,											Name,				Value)
SELECT	'MODIFIER_CSE_TRADE_WAYSTATION_GOLD_MOD_JNR',			'BuildingType',		'BUILDING_JNR_WAYSTATION'
FROM	ModifierArguments
WHERE	ModifierId='MODIFIER_CSE_TRADE_MARKET_GOLD_MOD';

INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,											Name,				Value)
SELECT	'MODIFIER_CSE_TRADE_GUILDHALL_GOLD_MOD_JNR',			'BuildingType',		'BUILDING_JNR_GUILDHALL'
FROM	ModifierArguments
WHERE	ModifierId='MODIFIER_CSE_TRADE_BANK_GOLD_MOD';

INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,											Name,				Value)
SELECT	'MODIFIER_CSE_TRADE_MERCHANT_QUARTER_GOLD_MOD_JNR',		'BuildingType',		'BUILDING_JNR_MERCHANT_QUARTER'
FROM	ModifierArguments
WHERE	ModifierId='MODIFIER_CSE_TRADE_BANK_GOLD_MOD';

INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,											Name,				Value)
SELECT	'MODIFIER_CSE_TRADE_COMMODITY_EXCHANGE_GOLD_MOD_JNR',	'BuildingType',		'BUILDING_JNR_COMMODITY_EXCHANGE'
FROM	ModifierArguments
WHERE	ModifierId='MODIFIER_CSE_TRADE_STOCK_EXCHANGE_GOLD_MOD';

INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,											Name,				Value)
SELECT	'MODIFIER_CSE_TRADE_MARKETING_AGENCY_GOLD_MOD_JNR',		'BuildingType',		'BUILDING_JNR_MARKETING_AGENCY'
FROM	ModifierArguments
WHERE	ModifierId='MODIFIER_CSE_TRADE_STOCK_EXCHANGE_GOLD_MOD';

INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,											Name,				Value)
SELECT	'MODIFIER_CSE_TRADE_MINT_GOLD_MOD_JNR',					'YieldType',		Value
FROM	ModifierArguments
WHERE	ModifierId='MODIFIER_CSE_TRADE_MARKET_GOLD_MOD'			AND Name='YieldType';

INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,											Name,				Value)
SELECT	'MODIFIER_CSE_TRADE_WAYSTATION_GOLD_MOD_JNR',			'YieldType',		Value
FROM	ModifierArguments
WHERE	ModifierId='MODIFIER_CSE_TRADE_MARKET_GOLD_MOD'			AND Name='YieldType';

INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,											Name,				Value)
SELECT	'MODIFIER_CSE_TRADE_GUILDHALL_GOLD_MOD_JNR',			'YieldType',		Value
FROM	ModifierArguments
WHERE	ModifierId='MODIFIER_CSE_TRADE_BANK_GOLD_MOD'			AND Name='YieldType';

INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,											Name,				Value)
SELECT	'MODIFIER_CSE_TRADE_MERCHANT_QUARTER_GOLD_MOD_JNR',		'YieldType',		Value
FROM	ModifierArguments
WHERE	ModifierId='MODIFIER_CSE_TRADE_BANK_GOLD_MOD'			AND Name='YieldType';

INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,											Name,				Value)
SELECT	'MODIFIER_CSE_TRADE_COMMODITY_EXCHANGE_GOLD_MOD_JNR',	'YieldType',		Value
FROM	ModifierArguments
WHERE	ModifierId='MODIFIER_CSE_TRADE_STOCK_EXCHANGE_GOLD_MOD'	AND Name='YieldType';

INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,											Name,				Value)
SELECT	'MODIFIER_CSE_TRADE_MARKETING_AGENCY_GOLD_MOD_JNR',		'YieldType',		Value
FROM	ModifierArguments
WHERE	ModifierId='MODIFIER_CSE_TRADE_STOCK_EXCHANGE_GOLD_MOD'	AND Name='YieldType';

INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,											Name,				Value)
SELECT	'MODIFIER_CSE_TRADE_MINT_GOLD_MOD_JNR',					'Amount',			Value
FROM	ModifierArguments
WHERE	ModifierId='MODIFIER_CSE_TRADE_MARKET_GOLD_MOD'			AND Name='Amount';

INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,											Name,				Value)
SELECT	'MODIFIER_CSE_TRADE_WAYSTATION_GOLD_MOD_JNR',			'Amount',			Value
FROM	ModifierArguments
WHERE	ModifierId='MODIFIER_CSE_TRADE_MARKET_GOLD_MOD'			AND Name='Amount';

INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,											Name,				Value)
SELECT	'MODIFIER_CSE_TRADE_GUILDHALL_GOLD_MOD_JNR',			'Amount',			Value
FROM	ModifierArguments
WHERE	ModifierId='MODIFIER_CSE_TRADE_BANK_GOLD_MOD'			AND Name='Amount';

INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,											Name,				Value)
SELECT	'MODIFIER_CSE_TRADE_MERCHANT_QUARTER_GOLD_MOD_JNR',		'Amount',			Value
FROM	ModifierArguments
WHERE	ModifierId='MODIFIER_CSE_TRADE_BANK_GOLD_MOD'			AND Name='Amount';

INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,											Name,				Value)
SELECT	'MODIFIER_CSE_TRADE_COMMODITY_EXCHANGE_GOLD_MOD_JNR',	'Amount',			Value
FROM	ModifierArguments
WHERE	ModifierId='MODIFIER_CSE_TRADE_STOCK_EXCHANGE_GOLD_MOD'	AND Name='Amount';

INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,											Name,				Value)
SELECT	'MODIFIER_CSE_TRADE_MARKETING_AGENCY_GOLD_MOD_JNR',		'Amount',			Value
FROM	ModifierArguments
WHERE	ModifierId='MODIFIER_CSE_TRADE_STOCK_EXCHANGE_GOLD_MOD'	AND Name='Amount';

INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,											Name,				Value)
SELECT	'MODIFIER_CSE_TRADE_MINT_GOLD_MOD_JNR',					'CityStatesOnly',	Value
FROM	ModifierArguments
WHERE	ModifierId='MODIFIER_CSE_TRADE_MARKET_GOLD_MOD'			AND Name='CityStatesOnly';

INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,											Name,				Value)
SELECT	'MODIFIER_CSE_TRADE_WAYSTATION_GOLD_MOD_JNR',			'CityStatesOnly',	Value
FROM	ModifierArguments
WHERE	ModifierId='MODIFIER_CSE_TRADE_MARKET_GOLD_MOD'			AND Name='CityStatesOnly';

INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,											Name,				Value)
SELECT	'MODIFIER_CSE_TRADE_GUILDHALL_GOLD_MOD_JNR',			'CityStatesOnly',	Value
FROM	ModifierArguments
WHERE	ModifierId='MODIFIER_CSE_TRADE_BANK_GOLD_MOD'			AND Name='CityStatesOnly';

INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,											Name,				Value)
SELECT	'MODIFIER_CSE_TRADE_MERCHANT_QUARTER_GOLD_MOD_JNR',		'CityStatesOnly',	Value
FROM	ModifierArguments
WHERE	ModifierId='MODIFIER_CSE_TRADE_BANK_GOLD_MOD'			AND Name='CityStatesOnly';

INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,											Name,				Value)
SELECT	'MODIFIER_CSE_TRADE_COMMODITY_EXCHANGE_GOLD_MOD_JNR',	'CityStatesOnly',	Value
FROM	ModifierArguments
WHERE	ModifierId='MODIFIER_CSE_TRADE_STOCK_EXCHANGE_GOLD_MOD'	AND Name='CityStatesOnly';

INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,											Name,				Value)
SELECT	'MODIFIER_CSE_TRADE_MARKETING_AGENCY_GOLD_MOD_JNR',		'CityStatesOnly',	Value
FROM	ModifierArguments
WHERE	ModifierId='MODIFIER_CSE_TRADE_STOCK_EXCHANGE_GOLD_MOD'	AND Name='CityStatesOnly';
--------------------------------------------------------------

-- TraitModifiers
--------------------------------------------------------------
INSERT OR IGNORE INTO TraitModifiers
		(TraitType,	ModifierId)
SELECT	TraitType,	'MODIFIER_CSE_TRADE_MINT_GOLD_JNR'
FROM	TraitModifiers
WHERE	ModifierId='MODIFIER_CSE_TRADE_MARKET_GOLD';

INSERT OR IGNORE INTO TraitModifiers
		(TraitType,	ModifierId)
SELECT	TraitType,	'MODIFIER_CSE_TRADE_WAYSTATION_GOLD_JNR'
FROM	TraitModifiers
WHERE	ModifierId='MODIFIER_CSE_TRADE_MARKET_GOLD';

INSERT OR IGNORE INTO TraitModifiers
		(TraitType,	ModifierId)
SELECT	TraitType,	'MODIFIER_CSE_TRADE_GUILDHALL_GOLD_JNR'
FROM	TraitModifiers
WHERE	ModifierId='MODIFIER_CSE_TRADE_BANK_GOLD';

INSERT OR IGNORE INTO TraitModifiers
		(TraitType,	ModifierId)
SELECT	TraitType,	'MODIFIER_CSE_TRADE_MERCHANT_QUARTER_GOLD_JNR'
FROM	TraitModifiers
WHERE	ModifierId='MODIFIER_CSE_TRADE_BANK_GOLD';

INSERT OR IGNORE INTO TraitModifiers
		(TraitType,	ModifierId)
SELECT	TraitType,	'MODIFIER_CSE_TRADE_COMMODITY_EXCHANGE_GOLD_JNR'
FROM	TraitModifiers
WHERE	ModifierId='MODIFIER_CSE_TRADE_STOCK_EXCHANGE_GOLD';

INSERT OR IGNORE INTO TraitModifiers
		(TraitType,	ModifierId)
SELECT	TraitType,	'MODIFIER_CSE_TRADE_MARKETING_AGENCY_GOLD_JNR'
FROM	TraitModifiers
WHERE	ModifierId='MODIFIER_CSE_TRADE_STOCK_EXCHANGE_GOLD';
--------------------------------------------------------------