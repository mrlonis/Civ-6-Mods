-- UC_COM_RwF
-- Author: JNR
--------------------------------------------------------------

-- Policies
--------------------------------------------------------------
UPDATE Policies SET Description='LOC_POLICY_JFD_FREE_MARKET_DESCRIPTION_UC_JNR' WHERE PolicyType='POLICY_JFD_FREE_MARKET';
--------------------------------------------------------------

-- Modifiers
--------------------------------------------------------------
INSERT OR IGNORE INTO Modifiers
		(ModifierId,										ModifierType)
SELECT	'JFD_FREE_MARKET_MARKET_GOLD_UC_JNR',				'MODIFIER_PLAYER_CITIES_ADJUST_BUILDING_YIELD_CHANGE' FROM Policies WHERE PolicyType='POLICY_JFD_FREE_MARKET';

INSERT OR IGNORE INTO Modifiers
		(ModifierId,										ModifierType)
SELECT	'JFD_FREE_MARKET_MINT_GOLD_UC_JNR',					'MODIFIER_PLAYER_CITIES_ADJUST_BUILDING_YIELD_CHANGE' FROM Policies WHERE PolicyType='POLICY_JFD_FREE_MARKET';

INSERT OR IGNORE INTO Modifiers
		(ModifierId,										ModifierType)
SELECT	'JFD_FREE_MARKET_WAYSTATION_GOLD_UC_JNR',			'MODIFIER_PLAYER_CITIES_ADJUST_BUILDING_YIELD_CHANGE' FROM Policies WHERE PolicyType='POLICY_JFD_FREE_MARKET';

INSERT OR IGNORE INTO Modifiers
		(ModifierId,										ModifierType)
SELECT	'JFD_FREE_MARKET_BANK_GOLD_UC_JNR',					'MODIFIER_PLAYER_CITIES_ADJUST_BUILDING_YIELD_CHANGE' FROM Policies WHERE PolicyType='POLICY_JFD_FREE_MARKET';

INSERT OR IGNORE INTO Modifiers
		(ModifierId,										ModifierType)
SELECT	'JFD_FREE_MARKET_GUILDHALL_GOLD_UC_JNR',			'MODIFIER_PLAYER_CITIES_ADJUST_BUILDING_YIELD_CHANGE' FROM Policies WHERE PolicyType='POLICY_JFD_FREE_MARKET';

INSERT OR IGNORE INTO Modifiers
		(ModifierId,										ModifierType)
SELECT	'JFD_FREE_MARKET_MERCHANT_QUARTER_GOLD_UC_JNR',		'MODIFIER_PLAYER_CITIES_ADJUST_BUILDING_YIELD_CHANGE' FROM Policies WHERE PolicyType='POLICY_JFD_FREE_MARKET';

INSERT OR IGNORE INTO Modifiers
		(ModifierId,										ModifierType)
SELECT	'JFD_FREE_MARKET_STOCK_EXCHANGE_GOLD_UC_JNR',		'MODIFIER_PLAYER_CITIES_ADJUST_BUILDING_YIELD_CHANGE' FROM Policies WHERE PolicyType='POLICY_JFD_FREE_MARKET';

INSERT OR IGNORE INTO Modifiers
		(ModifierId,										ModifierType)
SELECT	'JFD_FREE_MARKET_COMMODITY_EXCHANGE_GOLD_UC_JNR',	'MODIFIER_PLAYER_CITIES_ADJUST_BUILDING_YIELD_CHANGE' FROM Policies WHERE PolicyType='POLICY_JFD_FREE_MARKET';

INSERT OR IGNORE INTO Modifiers
		(ModifierId,										ModifierType)
SELECT	'JFD_FREE_MARKET_MARKETING_AGENCY_GOLD_UC_JNR',		'MODIFIER_PLAYER_CITIES_ADJUST_BUILDING_YIELD_CHANGE' FROM Policies WHERE PolicyType='POLICY_JFD_FREE_MARKET';
--------------------------------------------------------------

-- ModifierArguments
--------------------------------------------------------------
INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,										Name,			Value)
SELECT	'JFD_FREE_MARKET_MARKET_GOLD_UC_JNR',				'BuildingType',	'BUILDING_MARKET'					FROM Policies WHERE PolicyType='POLICY_JFD_FREE_MARKET';

INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,										Name,			Value)
SELECT	'JFD_FREE_MARKET_MINT_GOLD_UC_JNR',					'BuildingType',	'BUILDING_JNR_WAYSTATION'			FROM Policies WHERE PolicyType='POLICY_JFD_FREE_MARKET';

INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,										Name,			Value)
SELECT	'JFD_FREE_MARKET_WAYSTATION_GOLD_UC_JNR',			'BuildingType',	'BUILDING_JNR_MINT'					FROM Policies WHERE PolicyType='POLICY_JFD_FREE_MARKET';

INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,										Name,			Value)
SELECT	'JFD_FREE_MARKET_BANK_GOLD_UC_JNR',					'BuildingType',	'BUILDING_BANK'						FROM Policies WHERE PolicyType='POLICY_JFD_FREE_MARKET';

INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,										Name,			Value)
SELECT	'JFD_FREE_MARKET_GUILDHALL_GOLD_UC_JNR',			'BuildingType',	'BUILDING_JNR_GUILDHALL'			FROM Policies WHERE PolicyType='POLICY_JFD_FREE_MARKET';

INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,										Name,			Value)
SELECT	'JFD_FREE_MARKET_MERCHANT_QUARTER_GOLD_UC_JNR',		'BuildingType',	'BUILDING_JNR_MERCHANT_QUARTER'		FROM Policies WHERE PolicyType='POLICY_JFD_FREE_MARKET';

INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,										Name,			Value)
SELECT	'JFD_FREE_MARKET_STOCK_EXCHANGE_GOLD_UC_JNR',		'BuildingType',	'BUILDING_STOCK_EXCHANGE'			FROM Policies WHERE PolicyType='POLICY_JFD_FREE_MARKET';

INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,										Name,			Value)
SELECT	'JFD_FREE_MARKET_COMMODITY_EXCHANGE_GOLD_UC_JNR',	'BuildingType',	'BUILDING_JNR_COMMODITY_EXCHANGE'	FROM Policies WHERE PolicyType='POLICY_JFD_FREE_MARKET';

INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,										Name,			Value)
SELECT	'JFD_FREE_MARKET_MARKETING_AGENCY_GOLD_UC_JNR',		'BuildingType',	'BUILDING_JNR_MARKETING_AGENCY'		FROM Policies WHERE PolicyType='POLICY_JFD_FREE_MARKET';

INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,										Name,			Value)
SELECT	'JFD_FREE_MARKET_MARKET_GOLD_UC_JNR',				'YieldType',	'YIELD_GOLD'						FROM Policies WHERE PolicyType='POLICY_JFD_FREE_MARKET';

INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,										Name,			Value)
SELECT	'JFD_FREE_MARKET_MINT_GOLD_UC_JNR',					'YieldType',	'YIELD_GOLD'						FROM Policies WHERE PolicyType='POLICY_JFD_FREE_MARKET';

INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,										Name,			Value)
SELECT	'JFD_FREE_MARKET_WAYSTATION_GOLD_UC_JNR',			'YieldType',	'YIELD_GOLD'						FROM Policies WHERE PolicyType='POLICY_JFD_FREE_MARKET';

INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,										Name,			Value)
SELECT	'JFD_FREE_MARKET_BANK_GOLD_UC_JNR',					'YieldType',	'YIELD_GOLD'						FROM Policies WHERE PolicyType='POLICY_JFD_FREE_MARKET';

INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,										Name,			Value)
SELECT	'JFD_FREE_MARKET_GUILDHALL_GOLD_UC_JNR',			'YieldType',	'YIELD_GOLD'						FROM Policies WHERE PolicyType='POLICY_JFD_FREE_MARKET';

INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,										Name,			Value)
SELECT	'JFD_FREE_MARKET_MERCHANT_QUARTER_GOLD_UC_JNR',		'YieldType',	'YIELD_GOLD'						FROM Policies WHERE PolicyType='POLICY_JFD_FREE_MARKET';

INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,										Name,			Value)
SELECT	'JFD_FREE_MARKET_STOCK_EXCHANGE_GOLD_UC_JNR',		'YieldType',	'YIELD_GOLD'						FROM Policies WHERE PolicyType='POLICY_JFD_FREE_MARKET';

INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,										Name,			Value)
SELECT	'JFD_FREE_MARKET_COMMODITY_EXCHANGE_GOLD_UC_JNR',	'YieldType',	'YIELD_GOLD'						FROM Policies WHERE PolicyType='POLICY_JFD_FREE_MARKET';

INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,										Name,			Value)
SELECT	'JFD_FREE_MARKET_MARKETING_AGENCY_GOLD_UC_JNR',		'YieldType',	'YIELD_GOLD'						FROM Policies WHERE PolicyType='POLICY_JFD_FREE_MARKET';

INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,										Name,			Value)
SELECT	'JFD_FREE_MARKET_MARKET_GOLD_UC_JNR',				'Amount',		2									FROM Policies WHERE PolicyType='POLICY_JFD_FREE_MARKET';

INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,										Name,			Value)
SELECT	'JFD_FREE_MARKET_MINT_GOLD_UC_JNR',					'Amount',		2									FROM Policies WHERE PolicyType='POLICY_JFD_FREE_MARKET';

INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,										Name,			Value)
SELECT	'JFD_FREE_MARKET_WAYSTATION_GOLD_UC_JNR',			'Amount',		2									FROM Policies WHERE PolicyType='POLICY_JFD_FREE_MARKET';

INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,										Name,			Value)
SELECT	'JFD_FREE_MARKET_BANK_GOLD_UC_JNR',					'Amount',		2									FROM Policies WHERE PolicyType='POLICY_JFD_FREE_MARKET';

INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,										Name,			Value)
SELECT	'JFD_FREE_MARKET_GUILDHALL_GOLD_UC_JNR',			'Amount',		2									FROM Policies WHERE PolicyType='POLICY_JFD_FREE_MARKET';

INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,										Name,			Value)
SELECT	'JFD_FREE_MARKET_MERCHANT_QUARTER_GOLD_UC_JNR',		'Amount',		2									FROM Policies WHERE PolicyType='POLICY_JFD_FREE_MARKET';

INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,										Name,			Value)
SELECT	'JFD_FREE_MARKET_STOCK_EXCHANGE_GOLD_UC_JNR',		'Amount',		2									FROM Policies WHERE PolicyType='POLICY_JFD_FREE_MARKET';

INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,										Name,			Value)
SELECT	'JFD_FREE_MARKET_COMMODITY_EXCHANGE_GOLD_UC_JNR',	'Amount',		2									FROM Policies WHERE PolicyType='POLICY_JFD_FREE_MARKET';

INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,										Name,			Value)
SELECT	'JFD_FREE_MARKET_MARKETING_AGENCY_GOLD_UC_JNR',		'Amount',		2									FROM Policies WHERE PolicyType='POLICY_JFD_FREE_MARKET';
--------------------------------------------------------------

-- PolicyModifiers
--------------------------------------------------------------
INSERT OR IGNORE INTO PolicyModifiers
		(PolicyType,	ModifierId)
SELECT	PolicyType,		'JFD_FREE_MARKET_MARKET_GOLD_UC_JNR'				FROM Policies WHERE PolicyType='POLICY_JFD_FREE_MARKET';

INSERT OR IGNORE INTO PolicyModifiers
		(PolicyType,	ModifierId)
SELECT	PolicyType,		'JFD_FREE_MARKET_MINT_GOLD_UC_JNR'					FROM Policies WHERE PolicyType='POLICY_JFD_FREE_MARKET';

INSERT OR IGNORE INTO PolicyModifiers
		(PolicyType,	ModifierId)
SELECT	PolicyType,		'JFD_FREE_MARKET_WAYSTATION_GOLD_UC_JNR'			FROM Policies WHERE PolicyType='POLICY_JFD_FREE_MARKET';

INSERT OR IGNORE INTO PolicyModifiers
		(PolicyType,	ModifierId)
SELECT	PolicyType,		'JFD_FREE_MARKET_BANK_GOLD_UC_JNR'					FROM Policies WHERE PolicyType='POLICY_JFD_FREE_MARKET';

INSERT OR IGNORE INTO PolicyModifiers
		(PolicyType,	ModifierId)
SELECT	PolicyType,		'JFD_FREE_MARKET_GUILDHALL_GOLD_UC_JNR'				FROM Policies WHERE PolicyType='POLICY_JFD_FREE_MARKET';

INSERT OR IGNORE INTO PolicyModifiers
		(PolicyType,	ModifierId)
SELECT	PolicyType,		'JFD_FREE_MARKET_MERCHANT_QUARTER_GOLD_UC_JNR'		FROM Policies WHERE PolicyType='POLICY_JFD_FREE_MARKET';

INSERT OR IGNORE INTO PolicyModifiers
		(PolicyType,	ModifierId)
SELECT	PolicyType,		'JFD_FREE_MARKET_STOCK_EXCHANGE_GOLD_UC_JNR'		FROM Policies WHERE PolicyType='POLICY_JFD_FREE_MARKET';

INSERT OR IGNORE INTO PolicyModifiers
		(PolicyType,	ModifierId)
SELECT	PolicyType,		'JFD_FREE_MARKET_COMMODITY_EXCHANGE_GOLD_UC_JNR'	FROM Policies WHERE PolicyType='POLICY_JFD_FREE_MARKET';

INSERT OR IGNORE INTO PolicyModifiers
		(PolicyType,	ModifierId)
SELECT	PolicyType,		'JFD_FREE_MARKET_MARKETING_AGENCY_GOLD_UC_JNR'		FROM Policies WHERE PolicyType='POLICY_JFD_FREE_MARKET';

DELETE FROM PolicyModifiers WHERE PolicyType='POLICY_JFD_FREE_MARKET' AND ModifierId='JFD_FREE_MARKET_MARKET_GOLD';
DELETE FROM PolicyModifiers WHERE PolicyType='POLICY_JFD_FREE_MARKET' AND ModifierId='JFD_FREE_MARKET_BANK_GOLD';
DELETE FROM PolicyModifiers WHERE PolicyType='POLICY_JFD_FREE_MARKET' AND ModifierId='JFD_FREE_MARKET_STOCK_EXCHANGE_GOLD';
--------------------------------------------------------------