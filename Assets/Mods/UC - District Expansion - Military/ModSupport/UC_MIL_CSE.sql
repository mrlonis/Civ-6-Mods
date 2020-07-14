-- UC_MIL_CSE
-- Author: JNR
--------------------------------------------------------------

-- RequirementSets
--------------------------------------------------------------
INSERT OR IGNORE INTO RequirementSets
		(RequirementSetId,							RequirementSetType)
VALUES	('REQSET_CSE_CITY_HAS_TARGET_RANGE_JNR',	'REQUIREMENTSET_TEST_ALL');
--------------------------------------------------------------

-- RequirementSetRequirements
--------------------------------------------------------------
INSERT OR IGNORE INTO RequirementSetRequirements
		(RequirementSetId,							RequirementId)
VALUES	('REQSET_CSE_CITY_HAS_TARGET_RANGE_JNR',	'REQUIRES_CITY_HAS_TARGET_RANGE_JNR');
--------------------------------------------------------------

-- Modifiers
--------------------------------------------------------------
UPDATE Modifiers SET SubjectRequirementSetId='BUILDING_IS_ENCAMPMENT_TIER3_JNR'	WHERE ModifierId='MODIFIER_CSE_MILITARISTIC_ACADEMY_UNITS_MOD';
UPDATE Modifiers SET SubjectRequirementSetId='BUILDING_IS_ENCAMPMENT_TIER2_JNR'	WHERE ModifierId='MODIFIER_CSE_MILITARISTIC_ARMORY_UNITS_MOD';

INSERT OR IGNORE INTO Modifiers
		(ModifierId,												ModifierType,	SubjectRequirementSetId)
SELECT	'MODIFIER_CSE_MILITARISTIC_TARGET_RANGE_UNITS_JNR',			ModifierType,	SubjectRequirementSetId
FROM	Modifiers
WHERE	ModifierId='MODIFIER_CSE_MILITARISTIC_BARRACKS_UNITS';

INSERT OR IGNORE INTO Modifiers
		(ModifierId,												ModifierType,	SubjectRequirementSetId)
SELECT	'MODIFIER_CSE_TRADE_NAVAL_BASE_GOLD_JNR',					ModifierType,	SubjectRequirementSetId
FROM	Modifiers
WHERE	ModifierId='MODIFIER_CSE_TRADE_SEAPORT_GOLD';

INSERT OR IGNORE INTO Modifiers
		(ModifierId,												ModifierType,	SubjectRequirementSetId)
SELECT	'MODIFIER_CSE_MARITIME_NAVAL_BASE_FOOD_JNR',				ModifierType,	SubjectRequirementSetId
FROM	Modifiers
WHERE	ModifierId='MODIFIER_CSE_MARITIME_SEAPORT_FOOD';

INSERT OR IGNORE INTO Modifiers
		(ModifierId,												ModifierType,	SubjectRequirementSetId)
SELECT	'MODIFIER_CSE_MARITIME_NAVAL_BASE_PRODUCTION_JNR',			ModifierType,	SubjectRequirementSetId
FROM	Modifiers
WHERE	ModifierId='MODIFIER_CSE_MARITIME_SEAPORT_PRODUCTION';

INSERT OR IGNORE INTO Modifiers
		(ModifierId,												ModifierType,	SubjectRequirementSetId)
SELECT	'MODIFIER_CSE_MARITIME_NAVAL_BASE_GOLD_JNR',				ModifierType,	SubjectRequirementSetId
FROM	Modifiers
WHERE	ModifierId='MODIFIER_CSE_MARITIME_SEAPORT_GOLD';

INSERT OR IGNORE INTO Modifiers
		(ModifierId,											ModifierType,	SubjectRequirementSetId)
SELECT	'MODIFIER_CSE_MILITARISTIC_TARGET_RANGE_UNITS_MOD_JNR',	ModifierType,	'REQSET_CSE_CITY_HAS_TARGET_RANGE_JNR'
FROM	Modifiers
WHERE	ModifierId='MODIFIER_CSE_MILITARISTIC_BARRACKS_UNITS_MOD';

INSERT OR IGNORE INTO Modifiers
		(ModifierId,											ModifierType)
SELECT	'MODIFIER_CSE_TRADE_NAVAL_BASE_GOLD_MOD',				ModifierType
FROM	Modifiers
WHERE	ModifierId='MODIFIER_CSE_TRADE_SEAPORT_GOLD_MOD';

INSERT OR IGNORE INTO Modifiers
		(ModifierId,											ModifierType)
SELECT	'MODIFIER_CSE_MARITIME_NAVAL_BASE_FOOD_MOD_JNR',		ModifierType
FROM	Modifiers
WHERE	ModifierId='MODIFIER_CSE_MARITIME_SEAPORT_FOOD_MOD';

INSERT OR IGNORE INTO Modifiers
		(ModifierId,											ModifierType)
SELECT	'MODIFIER_CSE_MARITIME_NAVAL_BASE_PRODUCTION_MOD_JNR',	ModifierType
FROM	Modifiers
WHERE	ModifierId='MODIFIER_CSE_MARITIME_SEAPORT_PRODUCTION_MOD';

INSERT OR IGNORE INTO Modifiers
		(ModifierId,											ModifierType)
SELECT	'MODIFIER_CSE_MARITIME_NAVAL_BASE_GOLD_MOD_JNR',		ModifierType
FROM	Modifiers
WHERE	ModifierId='MODIFIER_CSE_MARITIME_SEAPORT_GOLD_MOD';
--------------------------------------------------------------

-- ModifierArguments
--------------------------------------------------------------
INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,												Name,				Value)
SELECT	'MODIFIER_CSE_MILITARISTIC_TARGET_RANGE_UNITS_JNR',			Name,				'MODIFIER_CSE_MILITARISTIC_TARGET_RANGE_UNITS_MOD_JNR'
FROM	ModifierArguments
WHERE	ModifierId='MODIFIER_CSE_MILITARISTIC_BARRACKS_UNITS';

INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,												Name,				Value)
SELECT	'MODIFIER_CSE_MILITARISTIC_TARGET_RANGE_UNITS_MOD_JNR',		Name,				Value
FROM	ModifierArguments
WHERE	ModifierId='MODIFIER_CSE_MILITARISTIC_BARRACKS_UNITS_MOD';

INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,												Name,				Value)
SELECT	'MODIFIER_CSE_TRADE_NAVAL_BASE_GOLD_JNR',					Name,				'MODIFIER_CSE_TRADE_NAVAL_BASE_GOLD_MOD'
FROM	ModifierArguments
WHERE	ModifierId='MODIFIER_CSE_TRADE_SEAPORT_GOLD';

INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,												Name,				Value)
SELECT	'MODIFIER_CSE_TRADE_NAVAL_BASE_GOLD_MOD',					'YieldType',		'YIELD_GOLD'
FROM	ModifierArguments
WHERE	ModifierId='MODIFIER_CSE_TRADE_SEAPORT_GOLD_MOD';

INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,												Name,				Value)
SELECT	'MODIFIER_CSE_TRADE_NAVAL_BASE_GOLD_MOD',					'BuildingType',		'BUILDING_JNR_NAVAL_BASE'
FROM	ModifierArguments
WHERE	ModifierId='MODIFIER_CSE_TRADE_SEAPORT_GOLD_MOD';

INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,												Name,				Value)
SELECT	'MODIFIER_CSE_TRADE_NAVAL_BASE_GOLD_MOD',					'Amount',			Value
FROM	ModifierArguments
WHERE	ModifierId='MODIFIER_CSE_TRADE_SEAPORT_GOLD_MOD';

INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,												Name,				Value)
SELECT	'MODIFIER_CSE_TRADE_NAVAL_BASE_GOLD_MOD',					'CityStatesOnly',	1
FROM	ModifierArguments
WHERE	ModifierId='MODIFIER_CSE_TRADE_SEAPORT_GOLD_MOD';

INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,												Name,				Value)
SELECT	'MODIFIER_CSE_MARITIME_NAVAL_BASE_FOOD_JNR',				Name,				'MODIFIER_CSE_MARITIME_NAVAL_BASE_FOOD_MOD_JNR'
FROM	ModifierArguments
WHERE	ModifierId='MODIFIER_CSE_MARITIME_SEAPORT_FOOD';

INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,												Name,				Value)
SELECT	'MODIFIER_CSE_MARITIME_NAVAL_BASE_FOOD_MOD_JNR',			'YieldType',		'YIELD_FOOD'
FROM	ModifierArguments
WHERE	ModifierId='MODIFIER_CSE_MARITIME_SEAPORT_FOOD_MOD';

INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,												Name,				Value)
SELECT	'MODIFIER_CSE_MARITIME_NAVAL_BASE_FOOD_MOD_JNR',			'BuildingType',		'BUILDING_JNR_NAVAL_BASE'
FROM	ModifierArguments
WHERE	ModifierId='MODIFIER_CSE_MARITIME_SEAPORT_FOOD_MOD';

INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,												Name,				Value)
SELECT	'MODIFIER_CSE_MARITIME_NAVAL_BASE_FOOD_MOD_JNR',			'Amount',			Value
FROM	ModifierArguments
WHERE	ModifierId='MODIFIER_CSE_MARITIME_SEAPORT_FOOD_MOD';

INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,												Name,				Value)
SELECT	'MODIFIER_CSE_MARITIME_NAVAL_BASE_FOOD_MOD_JNR',			'CityStatesOnly',	1
FROM	ModifierArguments
WHERE	ModifierId='MODIFIER_CSE_MARITIME_SEAPORT_FOOD_MOD';

INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,												Name,				Value)
SELECT	'MODIFIER_CSE_MARITIME_NAVAL_BASE_PRODUCTION_JNR',			Name,				'MODIFIER_CSE_MARITIME_NAVAL_BASE_PRODUCTION_MOD_JNR'
FROM	ModifierArguments
WHERE	ModifierId='MODIFIER_CSE_MARITIME_SEAPORT_PRODUCTION';

INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,												Name,				Value)
SELECT	'MODIFIER_CSE_MARITIME_NAVAL_BASE_PRODUCTION_MOD_JNR',		'YieldType',		'YIELD_PRODUCTION'
FROM	ModifierArguments
WHERE	ModifierId='MODIFIER_CSE_MARITIME_SEAPORT_PRODUCTION_MOD';

INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,												Name,				Value)
SELECT	'MODIFIER_CSE_MARITIME_NAVAL_BASE_PRODUCTION_MOD_JNR',		'BuildingType',		'BUILDING_JNR_NAVAL_BASE'
FROM	ModifierArguments
WHERE	ModifierId='MODIFIER_CSE_MARITIME_SEAPORT_PRODUCTION_MOD';

INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,												Name,				Value)
SELECT	'MODIFIER_CSE_MARITIME_NAVAL_BASE_PRODUCTION_MOD_JNR',		'Amount',			Value
FROM	ModifierArguments
WHERE	ModifierId='MODIFIER_CSE_MARITIME_SEAPORT_PRODUCTION_MOD';

INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,												Name,				Value)
SELECT	'MODIFIER_CSE_MARITIME_NAVAL_BASE_PRODUCTION_MOD_JNR',		'CityStatesOnly',	1
FROM	ModifierArguments
WHERE	ModifierId='MODIFIER_CSE_MARITIME_SEAPORT_PRODUCTION_MOD';

INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,												Name,				Value)
SELECT	'MODIFIER_CSE_MARITIME_NAVAL_BASE_GOLD_JNR',				Name,				'MODIFIER_CSE_MARITIME_NAVAL_BASE_GOLD_MOD_JNR'
FROM	ModifierArguments
WHERE	ModifierId='MODIFIER_CSE_MARITIME_SEAPORT_GOLD';

INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,												Name,				Value)
SELECT	'MODIFIER_CSE_MARITIME_NAVAL_BASE_GOLD_MOD_JNR',			'YieldType',		'YIELD_GOLD'
FROM	ModifierArguments
WHERE	ModifierId='MODIFIER_CSE_MARITIME_SEAPORT_GOLD_MOD';

INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,												Name,				Value)
SELECT	'MODIFIER_CSE_MARITIME_NAVAL_BASE_GOLD_MOD_JNR',			'BuildingType',		'BUILDING_JNR_NAVAL_BASE'
FROM	ModifierArguments
WHERE	ModifierId='MODIFIER_CSE_MARITIME_SEAPORT_GOLD_MOD';

INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,												Name,				Value)
SELECT	'MODIFIER_CSE_MARITIME_NAVAL_BASE_GOLD_MOD_JNR',			'Amount',			Value
FROM	ModifierArguments
WHERE	ModifierId='MODIFIER_CSE_MARITIME_SEAPORT_GOLD_MOD';

INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,												Name,				Value)
SELECT	'MODIFIER_CSE_MARITIME_NAVAL_BASE_GOLD_MOD_JNR',			'CityStatesOnly',	1
FROM	ModifierArguments
WHERE	ModifierId='MODIFIER_CSE_MARITIME_SEAPORT_GOLD_MOD';
--------------------------------------------------------------

-- TraitModifiers
--------------------------------------------------------------
INSERT OR IGNORE INTO TraitModifiers
		(TraitType,	ModifierId)
SELECT	TraitType,	'MODIFIER_CSE_MILITARISTIC_TARGET_RANGE_UNITS_JNR'
FROM	TraitModifiers
WHERE	ModifierId='MODIFIER_CSE_MILITARISTIC_BARRACKS_UNITS';

INSERT OR IGNORE INTO TraitModifiers
		(TraitType,	ModifierId)
SELECT	TraitType,	'MODIFIER_CSE_TRADE_NAVAL_BASE_GOLD_JNR'
FROM	TraitModifiers
WHERE	ModifierId='MODIFIER_CSE_TRADE_SEAPORT_GOLD';

INSERT OR IGNORE INTO TraitModifiers
		(TraitType,	ModifierId)
SELECT	TraitType,	'MODIFIER_CSE_MARITIME_NAVAL_BASE_FOOD_MOD_JNR'
FROM	TraitModifiers
WHERE	ModifierId='MODIFIER_CSE_MARITIME_SEAPORT_FOOD';

INSERT OR IGNORE INTO TraitModifiers
		(TraitType,	ModifierId)
SELECT	TraitType,	'MODIFIER_CSE_MARITIME_NAVAL_BASE_PRODUCTION_JNR'
FROM	TraitModifiers
WHERE	ModifierId='MODIFIER_CSE_MARITIME_SEAPORT_PRODUCTION';

INSERT OR IGNORE INTO TraitModifiers
		(TraitType,	ModifierId)
SELECT	TraitType,	'MODIFIER_CSE_MARITIME_NAVAL_BASE_GOLD_JNR'
FROM	TraitModifiers
WHERE	ModifierId='MODIFIER_CSE_MARITIME_SEAPORT_GOLD';
--------------------------------------------------------------
