-- UC_COM_CSE_Maritime_Food
-- Author: JNR
--------------------------------------------------------------

-- Modifiers
--------------------------------------------------------------
INSERT OR IGNORE INTO Modifiers
		(ModifierId,										ModifierType,	SubjectRequirementSetId)
SELECT	'MODIFIER_CSE_MARITIME_LIGHTHOUSE_TRADE_FOOD_JNR',	ModifierType,	SubjectRequirementSetId
FROM	Modifiers
WHERE	ModifierId='MODIFIER_CSE_MARITIME_LIGHTHOUSE_FOOD';

INSERT OR IGNORE INTO Modifiers
		(ModifierId,										ModifierType,	SubjectRequirementSetId)
SELECT	'MODIFIER_CSE_MARITIME_HAVEN_FOOD_JNR',				ModifierType,	SubjectRequirementSetId
FROM	Modifiers
WHERE	ModifierId='MODIFIER_CSE_MARITIME_SHIPYARD_FOOD';

INSERT OR IGNORE INTO Modifiers
		(ModifierId,										ModifierType,	SubjectRequirementSetId)
SELECT	'MODIFIER_CSE_MARITIME_CONSULATE_FOOD_JNR',			ModifierType,	SubjectRequirementSetId
FROM	Modifiers
WHERE	ModifierId='MODIFIER_CSE_MARITIME_SHIPYARD_FOOD';

INSERT OR IGNORE INTO Modifiers
		(ModifierId,										ModifierType,	SubjectRequirementSetId)
SELECT	'MODIFIER_CSE_MARITIME_CRUISE_TERMINAL_FOOD_JNR',	ModifierType,	SubjectRequirementSetId
FROM	Modifiers
WHERE	ModifierId='MODIFIER_CSE_MARITIME_SEAPORT_FOOD';

INSERT OR IGNORE INTO Modifiers
		(ModifierId,											ModifierType,	SubjectRequirementSetId)
SELECT	'MODIFIER_CSE_MARITIME_LIGHTHOUSE_TRADE_FOOD_MOD_JNR',	ModifierType,	SubjectRequirementSetId
FROM	Modifiers
WHERE	ModifierId='MODIFIER_CSE_MARITIME_LIGHTHOUSE_FOOD_MOD';

INSERT OR IGNORE INTO Modifiers
		(ModifierId,											ModifierType,	SubjectRequirementSetId)
SELECT	'MODIFIER_CSE_MARITIME_HAVEN_FOOD_MOD_JNR',				ModifierType,	SubjectRequirementSetId
FROM	Modifiers
WHERE	ModifierId='MODIFIER_CSE_MARITIME_SHIPYARD_FOOD_MOD';

INSERT OR IGNORE INTO Modifiers
		(ModifierId,											ModifierType,	SubjectRequirementSetId)
SELECT	'MODIFIER_CSE_MARITIME_CONSULATE_FOOD_MOD_JNR',			ModifierType,	SubjectRequirementSetId
FROM	Modifiers
WHERE	ModifierId='MODIFIER_CSE_MARITIME_SHIPYARD_FOOD_MOD';

INSERT OR IGNORE INTO Modifiers
		(ModifierId,											ModifierType,	SubjectRequirementSetId)
SELECT	'MODIFIER_CSE_MARITIME_CRUISE_TERMINAL_FOOD_MOD_JNR',	ModifierType,	SubjectRequirementSetId
FROM	Modifiers
WHERE	ModifierId='MODIFIER_CSE_MARITIME_SEAPORT_FOOD_MOD';
--------------------------------------------------------------

-- ModifierArguments
--------------------------------------------------------------
INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,										Name,				Value)
SELECT	'MODIFIER_CSE_MARITIME_LIGHTHOUSE_TRADE_FOOD_JNR',	Name,				'MODIFIER_CSE_MARITIME_LIGHTHOUSE_TRADE_FOOD_MOD_JNR'
FROM	ModifierArguments
WHERE	ModifierId='MODIFIER_CSE_MARITIME_LIGHTHOUSE_FOOD';

INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,										Name,				Value)
SELECT	'MODIFIER_CSE_MARITIME_HAVEN_FOOD_JNR',				Name,				'MODIFIER_CSE_MARITIME_HAVEN_FOOD_MOD_JNR'
FROM	ModifierArguments
WHERE	ModifierId='MODIFIER_CSE_MARITIME_SHIPYARD_FOOD';

INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,										Name,				Value)
SELECT	'MODIFIER_CSE_MARITIME_CONSULATE_FOOD_JNR',			Name,				'MODIFIER_CSE_MARITIME_CONSULATE_FOOD_MOD_JNR'
FROM	ModifierArguments
WHERE	ModifierId='MODIFIER_CSE_MARITIME_SHIPYARD_FOOD';

INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,										Name,				Value)
SELECT	'MODIFIER_CSE_MARITIME_CRUISE_TERMINAL_FOOD_JNR',	Name,				'MODIFIER_CSE_MARITIME_CRUISE_TERMINAL_FOOD_MOD_JNR'
FROM	ModifierArguments
WHERE	ModifierId='MODIFIER_CSE_MARITIME_SEAPORT_FOOD';

INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,											Name,				Value)
SELECT	'MODIFIER_CSE_MARITIME_LIGHTHOUSE_TRADE_FOOD_MOD_JNR',	'BuildingType',		'BUILDING_JNR_LIGHTHOUSE_TRADE'
FROM	ModifierArguments
WHERE	ModifierId='MODIFIER_CSE_MARITIME_LIGHTHOUSE_FOOD_MOD';

INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,											Name,				Value)
SELECT	'MODIFIER_CSE_MARITIME_HAVEN_FOOD_MOD_JNR',				'BuildingType',		'BUILDING_JNR_HAVEN'
FROM	ModifierArguments
WHERE	ModifierId='MODIFIER_CSE_MARITIME_SHIPYARD_FOOD_MOD';

INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,											Name,				Value)
SELECT	'MODIFIER_CSE_MARITIME_CONSULATE_FOOD_MOD_JNR',			'BuildingType',		'BUILDING_JNR_CONSULATE'
FROM	ModifierArguments
WHERE	ModifierId='MODIFIER_CSE_MARITIME_SHIPYARD_FOOD_MOD';

INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,											Name,				Value)
SELECT	'MODIFIER_CSE_MARITIME_CRUISE_TERMINAL_FOOD_MOD_JNR',	'BuildingType',		'BUILDING_JNR_CRUISE_TERMINAL'
FROM	ModifierArguments
WHERE	ModifierId='MODIFIER_CSE_MARITIME_SEAPORT_FOOD_MOD';

INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,											Name,				Value)
SELECT	'MODIFIER_CSE_MARITIME_LIGHTHOUSE_TRADE_FOOD_MOD_JNR',	'YieldType',		Value
FROM	ModifierArguments
WHERE	ModifierId='MODIFIER_CSE_MARITIME_LIGHTHOUSE_FOOD_MOD'	AND Name='YieldType';

INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,											Name,				Value)
SELECT	'MODIFIER_CSE_MARITIME_HAVEN_FOOD_MOD_JNR',				'YieldType',		Value
FROM	ModifierArguments
WHERE	ModifierId='MODIFIER_CSE_MARITIME_SHIPYARD_FOOD_MOD'	AND Name='YieldType';

INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,											Name,				Value)
SELECT	'MODIFIER_CSE_MARITIME_CONSULATE_FOOD_MOD_JNR',			'YieldType',		Value
FROM	ModifierArguments
WHERE	ModifierId='MODIFIER_CSE_MARITIME_SHIPYARD_FOOD_MOD'	AND Name='YieldType';

INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,											Name,				Value)
SELECT	'MODIFIER_CSE_MARITIME_CRUISE_TERMINAL_FOOD_MOD_JNR',	'YieldType',		Value
FROM	ModifierArguments
WHERE	ModifierId='MODIFIER_CSE_MARITIME_SEAPORT_FOOD_MOD'		AND Name='YieldType';

INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,											Name,				Value)
SELECT	'MODIFIER_CSE_MARITIME_LIGHTHOUSE_TRADE_FOOD_MOD_JNR',	'Amount',			Value
FROM	ModifierArguments
WHERE	ModifierId='MODIFIER_CSE_MARITIME_LIGHTHOUSE_FOOD_MOD'	AND Name='Amount';

INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,											Name,				Value)
SELECT	'MODIFIER_CSE_MARITIME_HAVEN_FOOD_MOD_JNR',				'Amount',			Value
FROM	ModifierArguments
WHERE	ModifierId='MODIFIER_CSE_MARITIME_SHIPYARD_FOOD_MOD'	AND Name='Amount';

INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,											Name,				Value)
SELECT	'MODIFIER_CSE_MARITIME_CONSULATE_FOOD_MOD_JNR',			'Amount',			Value
FROM	ModifierArguments
WHERE	ModifierId='MODIFIER_CSE_MARITIME_SHIPYARD_FOOD_MOD'	AND Name='Amount';

INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,											Name,				Value)
SELECT	'MODIFIER_CSE_MARITIME_CRUISE_TERMINAL_FOOD_MOD_JNR',	'Amount',			Value
FROM	ModifierArguments
WHERE	ModifierId='MODIFIER_CSE_MARITIME_SEAPORT_FOOD_MOD'		AND Name='Amount';

INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,											Name,				Value)
SELECT	'MODIFIER_CSE_MARITIME_LIGHTHOUSE_TRADE_FOOD_MOD_JNR',	'CityStatesOnly',	Value
FROM	ModifierArguments
WHERE	ModifierId='MODIFIER_CSE_MARITIME_LIGHTHOUSE_FOOD_MOD'	AND Name='CityStatesOnly';

INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,											Name,				Value)
SELECT	'MODIFIER_CSE_MARITIME_HAVEN_FOOD_MOD_JNR',				'CityStatesOnly',	Value
FROM	ModifierArguments
WHERE	ModifierId='MODIFIER_CSE_MARITIME_SHIPYARD_FOOD_MOD'	AND Name='CityStatesOnly';

INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,											Name,				Value)
SELECT	'MODIFIER_CSE_MARITIME_CONSULATE_FOOD_MOD_JNR',			'CityStatesOnly',	Value
FROM	ModifierArguments
WHERE	ModifierId='MODIFIER_CSE_MARITIME_SHIPYARD_FOOD_MOD'	AND Name='CityStatesOnly';

INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,											Name,				Value)
SELECT	'MODIFIER_CSE_MARITIME_CRUISE_TERMINAL_FOOD_MOD_JNR',	'CityStatesOnly',	Value
FROM	ModifierArguments
WHERE	ModifierId='MODIFIER_CSE_MARITIME_SEAPORT_FOOD_MOD'		AND Name='CityStatesOnly';
--------------------------------------------------------------

-- TraitModifiers
--------------------------------------------------------------
INSERT OR IGNORE INTO TraitModifiers
		(TraitType,	ModifierId)
SELECT	TraitType,	'MODIFIER_CSE_MARITIME_LIGHTHOUSE_TRADE_FOOD_JNR'
FROM	TraitModifiers
WHERE	ModifierId='MODIFIER_CSE_MARITIME_LIGHTHOUSE_FOOD';

INSERT OR IGNORE INTO TraitModifiers
		(TraitType,	ModifierId)
SELECT	TraitType,	'MODIFIER_CSE_MARITIME_HAVEN_FOOD_JNR'
FROM	TraitModifiers
WHERE	ModifierId='MODIFIER_CSE_MARITIME_SHIPYARD_FOOD';

INSERT OR IGNORE INTO TraitModifiers
		(TraitType,	ModifierId)
SELECT	TraitType,	'MODIFIER_CSE_MARITIME_CONSULATE_FOOD_JNR'
FROM	TraitModifiers
WHERE	ModifierId='MODIFIER_CSE_MARITIME_SHIPYARD_FOOD';

INSERT OR IGNORE INTO TraitModifiers
		(TraitType,	ModifierId)
SELECT	TraitType,	'MODIFIER_CSE_MARITIME_CRUISE_TERMINAL_FOOD_JNR'
FROM	TraitModifiers
WHERE	ModifierId='MODIFIER_CSE_MARITIME_SEAPORT_FOOD';
--------------------------------------------------------------