-- UC_COM_City_States
-- Author: JNR
--------------------------------------------------------------

-- Modifiers
--------------------------------------------------------------
INSERT OR IGNORE INTO Modifiers
		(ModifierId,													ModifierType,											SubjectRequirementSetId)
VALUES	('MINOR_CIV_TRADE_MEDIUM_INFLUENCE_BONUS_MINT_JNR',				'MODIFIER_ALL_PLAYERS_ATTACH_MODIFIER',					'PLAYER_HAS_MEDIUM_INFLUENCE'),
		('MINOR_CIV_TRADE_MEDIUM_INFLUENCE_BONUS_WAYSTATION_JNR',		'MODIFIER_ALL_PLAYERS_ATTACH_MODIFIER',					'PLAYER_HAS_MEDIUM_INFLUENCE'),
		('MINOR_CIV_TRADE_MEDIUM_INFLUENCE_BONUS_LIGHTHOUSE_TRADE_JNR',	'MODIFIER_ALL_PLAYERS_ATTACH_MODIFIER',					'PLAYER_HAS_MEDIUM_INFLUENCE'),
		('MINOR_CIV_TRADE_LARGE_INFLUENCE_BONUS_GUILDHALL_JNR',			'MODIFIER_ALL_PLAYERS_ATTACH_MODIFIER',					'PLAYER_HAS_LARGE_INFLUENCE'),
		('MINOR_CIV_TRADE_LARGE_INFLUENCE_BONUS_MERCHANT_QUARTER_JNR',	'MODIFIER_ALL_PLAYERS_ATTACH_MODIFIER',					'PLAYER_HAS_LARGE_INFLUENCE'),
		('MINOR_CIV_TRADE_LARGE_INFLUENCE_BONUS_HAVEN_JNR',				'MODIFIER_ALL_PLAYERS_ATTACH_MODIFIER',					'PLAYER_HAS_LARGE_INFLUENCE'),
		('MINOR_CIV_TRADE_LARGE_INFLUENCE_BONUS_CONSULATE_JNR',			'MODIFIER_ALL_PLAYERS_ATTACH_MODIFIER',					'PLAYER_HAS_LARGE_INFLUENCE'),
		('MINOR_CIV_TRADE_YIELD_FOR_MINT_JNR',							'MODIFIER_PLAYER_CITIES_ADJUST_BUILDING_YIELD_CHANGE',	'PLAYER_HAS_MEDIUM_INFLUENCE'),
		('MINOR_CIV_TRADE_YIELD_FOR_WAYSTATION_JNR',					'MODIFIER_PLAYER_CITIES_ADJUST_BUILDING_YIELD_CHANGE',	'PLAYER_HAS_MEDIUM_INFLUENCE'),
		('MINOR_CIV_TRADE_YIELD_FOR_LIGHTHOUSE_TRADE_JNR',				'MODIFIER_PLAYER_CITIES_ADJUST_BUILDING_YIELD_CHANGE',	'PLAYER_HAS_MEDIUM_INFLUENCE'),
		('MINOR_CIV_TRADE_YIELD_FOR_GUILDHALL_JNR',						'MODIFIER_PLAYER_CITIES_ADJUST_BUILDING_YIELD_CHANGE',	'PLAYER_HAS_LARGE_INFLUENCE'),
		('MINOR_CIV_TRADE_YIELD_FOR_MERCHANT_QUARTER_JNR',				'MODIFIER_PLAYER_CITIES_ADJUST_BUILDING_YIELD_CHANGE',	'PLAYER_HAS_LARGE_INFLUENCE'),
		('MINOR_CIV_TRADE_YIELD_FOR_HAVEN_JNR',							'MODIFIER_PLAYER_CITIES_ADJUST_BUILDING_YIELD_CHANGE',	'PLAYER_HAS_LARGE_INFLUENCE'),
		('MINOR_CIV_TRADE_YIELD_FOR_CONSULATE_JNR',						'MODIFIER_PLAYER_CITIES_ADJUST_BUILDING_YIELD_CHANGE',	'PLAYER_HAS_LARGE_INFLUENCE');

UPDATE Modifiers SET SubjectRequirementSetId='BUILDING_IS_HARBOR_TIER1_JNR'	WHERE ModifierId='MINOR_CIV_CARDIFF_POWER_LIGHTHOUSE';
UPDATE Modifiers SET SubjectRequirementSetId='BUILDING_IS_HARBOR_TIER2_JNR'	WHERE ModifierId='MINOR_CIV_CARDIFF_POWER_SHIPYARD';
UPDATE Modifiers SET SubjectRequirementSetId='BUILDING_IS_HARBOR_TIER3_JNR'	WHERE ModifierId='MINOR_CIV_CARDIFF_POWER_SEAPORT';

UPDATE Modifiers SET SubjectRequirementSetId='BUILDING_IS_COMMERCIAL_TIER1_JNR'	WHERE ModifierId='MINOR_CIV_STOCKHOLM_GREAT_MERCHANT_POINTS_BONUS';
UPDATE Modifiers SET SubjectRequirementSetId='BUILDING_IS_HARBOR_TIER1_JNR'		WHERE ModifierId='MINOR_CIV_STOCKHOLM_GREAT_ADMIRAL_POINTS_BONUS';
UPDATE Modifiers SET SubjectRequirementSetId='BUILDING_IS_COMMERCIAL_TIER1_JNR'	WHERE ModifierId='MINOR_CIV_BOLOGNA_GREAT_MERCHANT_POINTS_BONUS';
UPDATE Modifiers SET SubjectRequirementSetId='BUILDING_IS_HARBOR_TIER1_JNR'		WHERE ModifierId='MINOR_CIV_BOLOGNA_GREAT_ADMIRAL_POINTS_BONUS';
--------------------------------------------------------------

-- ModifierArguments
--------------------------------------------------------------
INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,													Name,				Value)
VALUES	('MINOR_CIV_TRADE_MEDIUM_INFLUENCE_BONUS_MINT_JNR',				'ModifierId',		'MINOR_CIV_TRADE_YIELD_FOR_MINT_JNR'),
		('MINOR_CIV_TRADE_MEDIUM_INFLUENCE_BONUS_WAYSTATION_JNR',		'ModifierId',		'MINOR_CIV_TRADE_YIELD_FOR_WAYSTATION_JNR'),
		('MINOR_CIV_TRADE_MEDIUM_INFLUENCE_BONUS_LIGHTHOUSE_TRADE_JNR',	'ModifierId',		'MINOR_CIV_TRADE_YIELD_FOR_LIGHTHOUSE_TRADE_JNR'),
		('MINOR_CIV_TRADE_LARGE_INFLUENCE_BONUS_GUILDHALL_JNR',			'ModifierId',		'MINOR_CIV_TRADE_YIELD_FOR_GUILDHALL_JNR'),
		('MINOR_CIV_TRADE_LARGE_INFLUENCE_BONUS_MERCHANT_QUARTER_JNR',	'ModifierId',		'MINOR_CIV_TRADE_YIELD_FOR_MERCHANT_QUARTER_JNR'),
		('MINOR_CIV_TRADE_LARGE_INFLUENCE_BONUS_HAVEN_JNR',				'ModifierId',		'MINOR_CIV_TRADE_YIELD_FOR_HAVEN_JNR'),
		('MINOR_CIV_TRADE_LARGE_INFLUENCE_BONUS_CONSULATE_JNR',			'ModifierId',		'MINOR_CIV_TRADE_YIELD_FOR_CONSULATE_JNR'),
		('MINOR_CIV_TRADE_YIELD_FOR_MINT_JNR',							'BuildingType',		'BUILDING_JNR_MINT'),
		('MINOR_CIV_TRADE_YIELD_FOR_WAYSTATION_JNR',					'BuildingType',		'BUILDING_JNR_WAYSTATION'),
		('MINOR_CIV_TRADE_YIELD_FOR_LIGHTHOUSE_TRADE_JNR',				'BuildingType',		'BUILDING_JNR_LIGHTHOUSE_TRADE'),
		('MINOR_CIV_TRADE_YIELD_FOR_GUILDHALL_JNR',						'BuildingType',		'BUILDING_JNR_GUILDHALL'),
		('MINOR_CIV_TRADE_YIELD_FOR_MERCHANT_QUARTER_JNR',				'BuildingType',		'BUILDING_JNR_MERCHANT_QUARTER'),
		('MINOR_CIV_TRADE_YIELD_FOR_HAVEN_JNR',							'BuildingType',		'BUILDING_JNR_HAVEN'),
		('MINOR_CIV_TRADE_YIELD_FOR_CONSULATE_JNR',						'BuildingType',		'BUILDING_JNR_CONSULATE'),
		('MINOR_CIV_TRADE_YIELD_FOR_MINT_JNR',							'YieldType',		'YIELD_GOLD'),
		('MINOR_CIV_TRADE_YIELD_FOR_WAYSTATION_JNR',					'YieldType',		'YIELD_GOLD'),
		('MINOR_CIV_TRADE_YIELD_FOR_LIGHTHOUSE_TRADE_JNR',				'YieldType',		'YIELD_GOLD'),
		('MINOR_CIV_TRADE_YIELD_FOR_GUILDHALL_JNR',						'YieldType',		'YIELD_GOLD'),
		('MINOR_CIV_TRADE_YIELD_FOR_MERCHANT_QUARTER_JNR',				'YieldType',		'YIELD_GOLD'),
		('MINOR_CIV_TRADE_YIELD_FOR_HAVEN_JNR',							'YieldType',		'YIELD_GOLD'),
		('MINOR_CIV_TRADE_YIELD_FOR_CONSULATE_JNR',						'YieldType',		'YIELD_GOLD'),
		('MINOR_CIV_TRADE_YIELD_FOR_MINT_JNR',							'Amount',			2),
		('MINOR_CIV_TRADE_YIELD_FOR_WAYSTATION_JNR',					'Amount',			2),
		('MINOR_CIV_TRADE_YIELD_FOR_LIGHTHOUSE_TRADE_JNR',				'Amount',			2),
		('MINOR_CIV_TRADE_YIELD_FOR_GUILDHALL_JNR',						'Amount',			2),
		('MINOR_CIV_TRADE_YIELD_FOR_MERCHANT_QUARTER_JNR',				'Amount',			2),
		('MINOR_CIV_TRADE_YIELD_FOR_HAVEN_JNR',							'Amount',			2),
		('MINOR_CIV_TRADE_YIELD_FOR_CONSULATE_JNR',						'Amount',			2),
		('MINOR_CIV_TRADE_YIELD_FOR_MINT_JNR',							'CityStatesOnly',	1),
		('MINOR_CIV_TRADE_YIELD_FOR_WAYSTATION_JNR',					'CityStatesOnly',	1),
		('MINOR_CIV_TRADE_YIELD_FOR_LIGHTHOUSE_TRADE_JNR',				'CityStatesOnly',	1),
		('MINOR_CIV_TRADE_YIELD_FOR_GUILDHALL_JNR',						'CityStatesOnly',	1),
		('MINOR_CIV_TRADE_YIELD_FOR_MERCHANT_QUARTER_JNR',				'CityStatesOnly',	1),
		('MINOR_CIV_TRADE_YIELD_FOR_HAVEN_JNR',							'CityStatesOnly',	1),
		('MINOR_CIV_TRADE_YIELD_FOR_CONSULATE_JNR',						'CityStatesOnly',	1);
--------------------------------------------------------------

-- TraitModifiers
--------------------------------------------------------------
INSERT OR IGNORE INTO TraitModifiers
		(TraitType,	ModifierId)
SELECT	TraitType,	'MINOR_CIV_TRADE_MEDIUM_INFLUENCE_BONUS_MINT_JNR'
FROM	TraitModifiers
WHERE	ModifierId='MINOR_CIV_TRADE_MEDIUM_INFLUENCE_BONUS';

INSERT OR IGNORE INTO TraitModifiers
		(TraitType,	ModifierId)
SELECT	TraitType,	'MINOR_CIV_TRADE_MEDIUM_INFLUENCE_BONUS_WAYSTATION_JNR'
FROM	TraitModifiers
WHERE	ModifierId='MINOR_CIV_TRADE_MEDIUM_INFLUENCE_BONUS';

INSERT OR IGNORE INTO TraitModifiers
		(TraitType,	ModifierId)
SELECT	TraitType,	'MINOR_CIV_TRADE_MEDIUM_INFLUENCE_BONUS_LIGHTHOUSE_TRADE_JNR'
FROM	TraitModifiers
WHERE	ModifierId='MINOR_CIV_TRADE_MEDIUM_INFLUENCE_BONUS_LIGHTHOUSE';

INSERT OR IGNORE INTO TraitModifiers
		(TraitType,	ModifierId)
SELECT	TraitType,	'MINOR_CIV_TRADE_LARGE_INFLUENCE_BONUS_GUILDHALL_JNR'
FROM	TraitModifiers
WHERE	ModifierId='MINOR_CIV_TRADE_LARGE_INFLUENCE_BONUS';

INSERT OR IGNORE INTO TraitModifiers
		(TraitType,	ModifierId)
SELECT	TraitType,	'MINOR_CIV_TRADE_LARGE_INFLUENCE_BONUS_MERCHANT_QUARTER_JNR'
FROM	TraitModifiers
WHERE	ModifierId='MINOR_CIV_TRADE_LARGE_INFLUENCE_BONUS';

INSERT OR IGNORE INTO TraitModifiers
		(TraitType,	ModifierId)
SELECT	TraitType,	'MINOR_CIV_TRADE_LARGE_INFLUENCE_BONUS_HAVEN_JNR'
FROM	TraitModifiers
WHERE	ModifierId='MINOR_CIV_TRADE_LARGE_INFLUENCE_BONUS_SHIPYARD';

INSERT OR IGNORE INTO TraitModifiers
		(TraitType,	ModifierId)
SELECT	TraitType,	'MINOR_CIV_TRADE_LARGE_INFLUENCE_BONUS_CONSULATE_JNR'
FROM	TraitModifiers
WHERE	ModifierId='MINOR_CIV_TRADE_LARGE_INFLUENCE_BONUS_SHIPYARD';
--------------------------------------------------------------