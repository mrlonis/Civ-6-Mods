-- UC_COM_CSE_Maritime_Production
-- Author: JNR
--------------------------------------------------------------

-- Modifiers
--------------------------------------------------------------
INSERT OR IGNORE INTO Modifiers
		(ModifierId,											ModifierType,	SubjectRequirementSetId)
SELECT	'MODIFIER_CSE_MARITIME_CRUISE_TERMINAL_GOLD_JNR',		ModifierType,	SubjectRequirementSetId
FROM	Modifiers
WHERE	ModifierId='MODIFIER_CSE_MARITIME_SEAPORT_GOLD';

INSERT OR IGNORE INTO Modifiers
		(ModifierId,											ModifierType,	SubjectRequirementSetId)
SELECT	'MODIFIER_CSE_MARITIME_CRUISE_TERMINAL_GOLD_MOD_JNR',	ModifierType,	SubjectRequirementSetId
FROM	Modifiers
WHERE	ModifierId='MODIFIER_CSE_MARITIME_SEAPORT_GOLD_MOD';
--------------------------------------------------------------

-- ModifierArguments
--------------------------------------------------------------
INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,										Name,				Value)
SELECT	'MODIFIER_CSE_MARITIME_CRUISE_TERMINAL_GOLD_JNR',	Name,				'MODIFIER_CSE_MARITIME_CRUISE_TERMINAL_PRODUCTION_MOD_JNR'
FROM	ModifierArguments
WHERE	ModifierId='MODIFIER_CSE_MARITIME_SEAPORT_GOLD';

INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,											Name,				Value)
SELECT	'MODIFIER_CSE_MARITIME_CRUISE_TERMINAL_GOLD_MOD_JNR',	'BuildingType',		'BUILDING_JNR_CRUISE_TERMINAL'
FROM	ModifierArguments
WHERE	ModifierId='MODIFIER_CSE_MARITIME_SEAPORT_GOLD_MOD';

INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,											Name,				Value)
SELECT	'MODIFIER_CSE_MARITIME_CRUISE_TERMINAL_GOLD_MOD_JNR',	'YieldType',		Value
FROM	ModifierArguments
WHERE	ModifierId='MODIFIER_CSE_MARITIME_SEAPORT_GOLD_MOD'		AND Name='YieldType';

INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,											Name,				Value)
SELECT	'MODIFIER_CSE_MARITIME_CRUISE_TERMINAL_GOLD_MOD_JNR',	'Amount',			Value
FROM	ModifierArguments
WHERE	ModifierId='MODIFIER_CSE_MARITIME_SEAPORT_GOLD_MOD'		AND Name='Amount';

INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,											Name,				Value)
SELECT	'MODIFIER_CSE_MARITIME_CRUISE_TERMINAL_GOLD_MOD_JNR',	'CityStatesOnly',	Value
FROM	ModifierArguments
WHERE	ModifierId='MODIFIER_CSE_MARITIME_SEAPORT_GOLD_MOD'		AND Name='CityStatesOnly';
--------------------------------------------------------------

-- TraitModifiers
--------------------------------------------------------------
INSERT OR IGNORE INTO TraitModifiers
		(TraitType,	ModifierId)
SELECT	TraitType,	'MODIFIER_CSE_MARITIME_CRUISE_TERMINAL_GOLD_JNR'
FROM	TraitModifiers
WHERE	ModifierId='MODIFIER_CSE_MARITIME_SEAPORT_GOLD';
--------------------------------------------------------------