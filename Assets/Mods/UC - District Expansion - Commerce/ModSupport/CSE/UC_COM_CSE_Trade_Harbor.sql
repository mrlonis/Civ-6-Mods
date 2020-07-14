-- UC_COM_CSE_Trade_Harbor
-- Author: JNR
--------------------------------------------------------------

-- Modifiers
--------------------------------------------------------------
INSERT OR IGNORE INTO Modifiers
		(ModifierId,									ModifierType,	SubjectRequirementSetId)
SELECT	'MODIFIER_CSE_TRADE_LIGHTHOUSE_TRADE_GOLD_JNR',	ModifierType,	SubjectRequirementSetId
FROM	Modifiers
WHERE	ModifierId='MODIFIER_CSE_TRADE_LIGHTHOUSE_GOLD';

INSERT OR IGNORE INTO Modifiers
		(ModifierId,									ModifierType,	SubjectRequirementSetId)
SELECT	'MODIFIER_CSE_TRADE_HAVEN_GOLD_JNR',			ModifierType,	SubjectRequirementSetId
FROM	Modifiers
WHERE	ModifierId='MODIFIER_CSE_TRADE_SHIPYARD_GOLD';

INSERT OR IGNORE INTO Modifiers
		(ModifierId,									ModifierType,	SubjectRequirementSetId)
SELECT	'MODIFIER_CSE_TRADE_CONSULATE_GOLD_JNR',		ModifierType,	SubjectRequirementSetId
FROM	Modifiers
WHERE	ModifierId='MODIFIER_CSE_TRADE_SHIPYARD_GOLD';

INSERT OR IGNORE INTO Modifiers
		(ModifierId,									ModifierType,	SubjectRequirementSetId)
SELECT	'MODIFIER_CSE_TRADE_CRUISE_TERMINAL_GOLD_JNR',	ModifierType,	SubjectRequirementSetId
FROM	Modifiers
WHERE	ModifierId='MODIFIER_CSE_TRADE_SEAPORT_GOLD';

INSERT OR IGNORE INTO Modifiers
		(ModifierId,										ModifierType,	SubjectRequirementSetId)
SELECT	'MODIFIER_CSE_TRADE_LIGHTHOUSE_TRADE_GOLD_MOD_JNR',	ModifierType,	SubjectRequirementSetId
FROM	Modifiers
WHERE	ModifierId='MODIFIER_CSE_TRADE_LIGHTHOUSE_GOLD_MOD';

INSERT OR IGNORE INTO Modifiers
		(ModifierId,										ModifierType,	SubjectRequirementSetId)
SELECT	'MODIFIER_CSE_TRADE_HAVEN_GOLD_MOD_JNR',			ModifierType,	SubjectRequirementSetId
FROM	Modifiers
WHERE	ModifierId='MODIFIER_CSE_TRADE_SHIPYARD_GOLD_MOD';

INSERT OR IGNORE INTO Modifiers
		(ModifierId,										ModifierType,	SubjectRequirementSetId)
SELECT	'MODIFIER_CSE_TRADE_CONSULATE_GOLD_MOD_JNR',		ModifierType,	SubjectRequirementSetId
FROM	Modifiers
WHERE	ModifierId='MODIFIER_CSE_TRADE_SHIPYARD_GOLD_MOD';

INSERT OR IGNORE INTO Modifiers
		(ModifierId,										ModifierType,	SubjectRequirementSetId)
SELECT	'MODIFIER_CSE_TRADE_CRUISE_TERMINAL_GOLD_MOD_JNR',	ModifierType,	SubjectRequirementSetId
FROM	Modifiers
WHERE	ModifierId='MODIFIER_CSE_TRADE_SEAPORT_GOLD_MOD';
--------------------------------------------------------------

-- ModifierArguments
--------------------------------------------------------------
INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,									Name,				Value)
SELECT	'MODIFIER_CSE_TRADE_LIGHTHOUSE_TRADE_GOLD_JNR',	Name,				'MODIFIER_CSE_TRADE_LIGHTHOUSE_TRADE_GOLD_MOD_JNR'
FROM	ModifierArguments
WHERE	ModifierId='MODIFIER_CSE_TRADE_LIGHTHOUSE_GOLD';

INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,									Name,				Value)
SELECT	'MODIFIER_CSE_TRADE_HAVEN_GOLD_JNR',			Name,				'MODIFIER_CSE_TRADE_HAVEN_GOLD_MOD_JNR'
FROM	ModifierArguments
WHERE	ModifierId='MODIFIER_CSE_TRADE_SHIPYARD_GOLD';

INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,									Name,				Value)
SELECT	'MODIFIER_CSE_TRADE_CONSULATE_GOLD_JNR',		Name,				'MODIFIER_CSE_TRADE_CONSULATE_GOLD_MOD_JNR'
FROM	ModifierArguments
WHERE	ModifierId='MODIFIER_CSE_TRADE_SHIPYARD_GOLD';

INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,									Name,				Value)
SELECT	'MODIFIER_CSE_TRADE_CRUISE_TERMINAL_GOLD_JNR',	Name,				'MODIFIER_CSE_TRADE_CRUISE_TERMINAL_GOLD_MOD_JNR'
FROM	ModifierArguments
WHERE	ModifierId='MODIFIER_CSE_TRADE_SEAPORT_GOLD';

INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,										Name,				Value)
SELECT	'MODIFIER_CSE_TRADE_LIGHTHOUSE_TRADE_GOLD_MOD_JNR',	'BuildingType',		'BUILDING_JNR_LIGHTHOUSE_TRADE'
FROM	ModifierArguments
WHERE	ModifierId='MODIFIER_CSE_TRADE_LIGHTHOUSE_GOLD_MOD';

INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,										Name,				Value)
SELECT	'MODIFIER_CSE_TRADE_HAVEN_GOLD_MOD_JNR',			'BuildingType',		'BUILDING_JNR_HAVEN'
FROM	ModifierArguments
WHERE	ModifierId='MODIFIER_CSE_TRADE_SHIPYARD_GOLD_MOD';

INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,										Name,				Value)
SELECT	'MODIFIER_CSE_TRADE_CONSULATE_GOLD_MOD_JNR',		'BuildingType',		'BUILDING_JNR_CONSULATE'
FROM	ModifierArguments
WHERE	ModifierId='MODIFIER_CSE_TRADE_SHIPYARD_GOLD_MOD';

INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,										Name,				Value)
SELECT	'MODIFIER_CSE_TRADE_CRUISE_TERMINAL_GOLD_MOD_JNR',	'BuildingType',		'BUILDING_JNR_CRUISE_TERMINAL'
FROM	ModifierArguments
WHERE	ModifierId='MODIFIER_CSE_TRADE_SEAPORT_GOLD_MOD';

INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,										Name,				Value)
SELECT	'MODIFIER_CSE_TRADE_LIGHTHOUSE_TRADE_GOLD_MOD_JNR',	'YieldType',		Value
FROM	ModifierArguments
WHERE	ModifierId='MODIFIER_CSE_TRADE_LIGHTHOUSE_GOLD_MOD'	AND Name='YieldType';

INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,										Name,				Value)
SELECT	'MODIFIER_CSE_TRADE_HAVEN_GOLD_MOD_JNR',			'YieldType',		Value
FROM	ModifierArguments
WHERE	ModifierId='MODIFIER_CSE_TRADE_SHIPYARD_GOLD_MOD'	AND Name='YieldType';

INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,										Name,				Value)
SELECT	'MODIFIER_CSE_TRADE_CONSULATE_GOLD_MOD_JNR',		'YieldType',		Value
FROM	ModifierArguments
WHERE	ModifierId='MODIFIER_CSE_TRADE_SHIPYARD_GOLD_MOD'	AND Name='YieldType';

INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,										Name,				Value)
SELECT	'MODIFIER_CSE_TRADE_CRUISE_TERMINAL_GOLD_MOD_JNR',	'YieldType',		Value
FROM	ModifierArguments
WHERE	ModifierId='MODIFIER_CSE_TRADE_SEAPORT_GOLD_MOD'	AND Name='YieldType';

INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,										Name,				Value)
SELECT	'MODIFIER_CSE_TRADE_LIGHTHOUSE_TRADE_GOLD_MOD_JNR',	'Amount',			Value
FROM	ModifierArguments
WHERE	ModifierId='MODIFIER_CSE_TRADE_LIGHTHOUSE_GOLD_MOD'	AND Name='Amount';

INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,										Name,				Value)
SELECT	'MODIFIER_CSE_TRADE_HAVEN_GOLD_MOD_JNR',			'Amount',			Value
FROM	ModifierArguments
WHERE	ModifierId='MODIFIER_CSE_TRADE_SHIPYARD_GOLD_MOD'	AND Name='Amount';

INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,										Name,				Value)
SELECT	'MODIFIER_CSE_TRADE_CONSULATE_GOLD_MOD_JNR',		'Amount',			Value
FROM	ModifierArguments
WHERE	ModifierId='MODIFIER_CSE_TRADE_SHIPYARD_GOLD_MOD'	AND Name='Amount';

INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,										Name,				Value)
SELECT	'MODIFIER_CSE_TRADE_CRUISE_TERMINAL_GOLD_MOD_JNR',	'Amount',			Value
FROM	ModifierArguments
WHERE	ModifierId='MODIFIER_CSE_TRADE_SEAPORT_GOLD_MOD'	AND Name='Amount';

INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,										Name,				Value)
SELECT	'MODIFIER_CSE_TRADE_LIGHTHOUSE_TRADE_GOLD_MOD_JNR',	'CityStatesOnly',	Value
FROM	ModifierArguments
WHERE	ModifierId='MODIFIER_CSE_TRADE_LIGHTHOUSE_GOLD_MOD'	AND Name='CityStatesOnly';

INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,										Name,				Value)
SELECT	'MODIFIER_CSE_TRADE_HAVEN_GOLD_MOD_JNR',			'CityStatesOnly',	Value
FROM	ModifierArguments
WHERE	ModifierId='MODIFIER_CSE_TRADE_SHIPYARD_GOLD_MOD'	AND Name='CityStatesOnly';

INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,										Name,				Value)
SELECT	'MODIFIER_CSE_TRADE_CONSULATE_GOLD_MOD_JNR',		'CityStatesOnly',	Value
FROM	ModifierArguments
WHERE	ModifierId='MODIFIER_CSE_TRADE_SHIPYARD_GOLD_MOD'	AND Name='CityStatesOnly';

INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,										Name,				Value)
SELECT	'MODIFIER_CSE_TRADE_CRUISE_TERMINAL_GOLD_MOD_JNR',	'CityStatesOnly',	Value
FROM	ModifierArguments
WHERE	ModifierId='MODIFIER_CSE_TRADE_SEAPORT_GOLD_MOD'	AND Name='CityStatesOnly';
--------------------------------------------------------------

-- TraitModifiers
--------------------------------------------------------------
INSERT OR IGNORE INTO TraitModifiers
		(TraitType,	ModifierId)
SELECT	TraitType,	'MODIFIER_CSE_TRADE_LIGHTHOUSE_TRADE_GOLD_JNR'
FROM	TraitModifiers
WHERE	ModifierId='MODIFIER_CSE_TRADE_LIGHTHOUSE_GOLD';

INSERT OR IGNORE INTO TraitModifiers
		(TraitType,	ModifierId)
SELECT	TraitType,	'MODIFIER_CSE_TRADE_HAVEN_GOLD_JNR'
FROM	TraitModifiers
WHERE	ModifierId='MODIFIER_CSE_TRADE_SHIPYARD_GOLD';

INSERT OR IGNORE INTO TraitModifiers
		(TraitType,	ModifierId)
SELECT	TraitType,	'MODIFIER_CSE_TRADE_CONSULATE_GOLD_JNR'
FROM	TraitModifiers
WHERE	ModifierId='MODIFIER_CSE_TRADE_SHIPYARD_GOLD';

INSERT OR IGNORE INTO TraitModifiers
		(TraitType,	ModifierId)
SELECT	TraitType,	'MODIFIER_CSE_TRADE_CRUISE_TERMINAL_GOLD_JNR'
FROM	TraitModifiers
WHERE	ModifierId='MODIFIER_CSE_TRADE_SEAPORT_GOLD';
--------------------------------------------------------------