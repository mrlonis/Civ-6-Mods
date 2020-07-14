-- UC_MIL_City_States
-- Author: JNR
--------------------------------------------------------------

-- Modifiers
--------------------------------------------------------------
-- Militaristic CS
UPDATE Modifiers SET SubjectRequirementSetId='BUILDING_IS_ENCAMPMENT_TIER1_JNR'	WHERE ModifierId='MINOR_CIV_MILITARISTIC_PRODUCTION_FOR_BARRACKS_STABLE';
UPDATE Modifiers SET SubjectRequirementSetId='BUILDING_IS_ENCAMPMENT_TIER2_JNR'	WHERE ModifierId='MINOR_CIV_MILITARISTIC_PRODUCTION_FOR_ARMORY';

-- Vanilla CS
UPDATE Modifiers SET SubjectRequirementSetId='BUILDING_IS_ENCAMPMENT_TIER1_JNR'	WHERE ModifierId='MINOR_CIV_PRESLAV_BARRACKS_STABLE_IDENTITY_BONUS';
UPDATE Modifiers SET SubjectRequirementSetId='BUILDING_IS_ENCAMPMENT_TIER2_JNR'	WHERE ModifierId='MINOR_CIV_PRESLAV_ARMORY_IDENTITY_BONUS';
UPDATE Modifiers SET SubjectRequirementSetId='BUILDING_IS_ENCAMPMENT_TIER3_JNR'	WHERE ModifierId='MINOR_CIV_PRESLAV_MILITARY_ACADEMY_IDENTITY_BONUS';

UPDATE Modifiers SET SubjectRequirementSetId='BUILDING_IS_ENCAMPMENT_TIER1_JNR'	WHERE ModifierId='MINOR_CIV_STOCKHOLM_GREAT_GENERAL_POINTS_BONUS';

-- Rise and Fall CS
UPDATE Modifiers SET SubjectRequirementSetId='BUILDING_IS_ENCAMPMENT_TIER1_JNR'	WHERE ModifierId='MINOR_CIV_CARTHAGE_BARRACKS_STABLE_PURCHASE_BONUS';
UPDATE Modifiers SET SubjectRequirementSetId='BUILDING_IS_ENCAMPMENT_TIER2_JNR'	WHERE ModifierId='MINOR_CIV_CARTHAGE_ARMORY_PURCHASE_BONUS';
UPDATE Modifiers SET SubjectRequirementSetId='BUILDING_IS_ENCAMPMENT_TIER3_JNR'	WHERE ModifierId='MINOR_CIV_CARTHAGE_MILITARY_ACADEMY_PURCHASE_BONUS';

-- Gathering Storm CS
UPDATE Modifiers SET SubjectRequirementSetId='BUILDING_IS_ENCAMPMENT_TIER1_JNR'	WHERE ModifierId='MINOR_CIV_NGAZARGAMU_BARRACKS_STABLE_PURCHASE_BONUS';
UPDATE Modifiers SET SubjectRequirementSetId='BUILDING_IS_ENCAMPMENT_TIER2_JNR'	WHERE ModifierId='MINOR_CIV_NGAZARGAMU_ARMORY_PURCHASE_BONUS';
UPDATE Modifiers SET SubjectRequirementSetId='BUILDING_IS_ENCAMPMENT_TIER3_JNR'	WHERE ModifierId='MINOR_CIV_NGAZARGAMU_MILITARY_ACADEMY_PURCHASE_BONUS';

UPDATE Modifiers SET SubjectRequirementSetId='BUILDING_IS_HARBOR_TIER3_JNR'		WHERE ModifierId='MINOR_CIV_CARDIFF_POWER_SEAPORT';

UPDATE Modifiers SET SubjectRequirementSetId='BUILDING_IS_ENCAMPMENT_TIER1_JNR'	WHERE ModifierId='MINOR_CIV_BOLOGNA_GREAT_GENERAL_POINTS_BONUS';

-- Tier 3 Bonus Mod
UPDATE Modifiers SET SubjectRequirementSetId='BUILDING_IS_ENCAMPMENT_TIER3_JNR'	WHERE ModifierId='MINOR_CIV_MILITARISTIC_PRODUCTION_FOR_MILITARY_ACADEMY_JNR';
--------------------------------------------------------------

-- TraitModifiers
--------------------------------------------------------------
INSERT OR IGNORE INTO TraitModifiers
		(TraitType,	ModifierId)
SELECT	TraitType,	'MINOR_CIV_TRADE_UNIQUE_INFLUENCE_BONUS_NAVAL_BASE_JNR'
FROM	TraitModifiers
WHERE	ModifierId='MINOR_CIV_TRADE_UNIQUE_INFLUENCE_BONUS_SEAPORT_JNR';
--------------------------------------------------------------

-- Modifiers
--------------------------------------------------------------
INSERT OR IGNORE INTO Modifiers
		(ModifierId,												ModifierType,	SubjectRequirementSetId)
SELECT	'MINOR_CIV_TRADE_UNIQUE_INFLUENCE_BONUS_NAVAL_BASE_JNR',	ModifierType,	SubjectRequirementSetId
FROM	Modifiers
WHERE	ModifierId='MINOR_CIV_TRADE_UNIQUE_INFLUENCE_BONUS_SEAPORT_JNR';

INSERT OR IGNORE INTO Modifiers
		(ModifierId,											ModifierType)
SELECT	'MINOR_CIV_TRADE_YIELD_FOR_NAVAL_BASE_JNR',				ModifierType
FROM	Modifiers
WHERE	ModifierId='MINOR_CIV_TRADE_YIELD_FOR_SEAPORT_JNR';
--------------------------------------------------------------

-- ModifierArguments
--------------------------------------------------------------
INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,												Name,				Value)
SELECT	'MINOR_CIV_TRADE_UNIQUE_INFLUENCE_BONUS_NAVAL_BASE_JNR',	Name,				'MINOR_CIV_TRADE_YIELD_FOR_NAVAL_BASE_JNR'
FROM	ModifierArguments
WHERE	ModifierId='MINOR_CIV_TRADE_UNIQUE_INFLUENCE_BONUS_SEAPORT_JNR';

INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,												Name,				Value)
SELECT	'MINOR_CIV_TRADE_YIELD_FOR_NAVAL_BASE_JNR',					'YieldType',		'YIELD_GOLD'
FROM	ModifierArguments
WHERE	ModifierId='MINOR_CIV_TRADE_YIELD_FOR_SEAPORT_JNR';

INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,												Name,				Value)
SELECT	'MINOR_CIV_TRADE_YIELD_FOR_NAVAL_BASE_JNR',					'BuildingType',		'BUILDING_JNR_NAVAL_BASE'
FROM	ModifierArguments
WHERE	ModifierId='MINOR_CIV_TRADE_YIELD_FOR_SEAPORT_JNR';

INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,												Name,				Value)
SELECT	'MINOR_CIV_TRADE_YIELD_FOR_NAVAL_BASE_JNR',					'Amount',			2
FROM	ModifierArguments
WHERE	ModifierId='MINOR_CIV_TRADE_YIELD_FOR_SEAPORT_JNR';

INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,												Name,				Value)
SELECT	'MINOR_CIV_TRADE_YIELD_FOR_NAVAL_BASE_JNR',					'CityStatesOnly',	1
FROM	ModifierArguments
WHERE	ModifierId='MINOR_CIV_TRADE_YIELD_FOR_SEAPORT_JNR';
--------------------------------------------------------------