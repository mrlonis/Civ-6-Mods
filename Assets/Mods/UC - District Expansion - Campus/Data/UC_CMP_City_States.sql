-- UC_CMP_City_States
-- Author: JNR
--------------------------------------------------------------

-- Modifiers
--------------------------------------------------------------
INSERT OR IGNORE INTO Modifiers
		(ModifierId,												ModifierType,											SubjectRequirementSetId)
VALUES	('MINOR_CIV_SCIENTIFIC_MEDIUM_INFLUENCE_BONUS_ACADEMY_JNR',	'MODIFIER_ALL_PLAYERS_ATTACH_MODIFIER',					'PLAYER_HAS_MEDIUM_INFLUENCE'),
		('MINOR_CIV_SCIENTIFIC_LARGE_INFLUENCE_BONUS_SCHOOL_JNR',	'MODIFIER_ALL_PLAYERS_ATTACH_MODIFIER',					'PLAYER_HAS_LARGE_INFLUENCE'),
		('MINOR_CIV_SCIENTIFIC_YIELD_FOR_ACADEMY_JNR',				'MODIFIER_PLAYER_CITIES_ADJUST_BUILDING_YIELD_CHANGE',	NULL),
		('MINOR_CIV_SCIENTIFIC_YIELD_FOR_SCHOOL_JNR',				'MODIFIER_PLAYER_CITIES_ADJUST_BUILDING_YIELD_CHANGE',	NULL);

UPDATE Modifiers SET SubjectRequirementSetId='BUILDING_IS_CAMPUS_TIER1_JNR'	WHERE ModifierId='MINOR_CIV_STOCKHOLM_GREAT_SCIENTIST_POINTS_BONUS';
UPDATE Modifiers SET SubjectRequirementSetId='BUILDING_IS_CAMPUS_TIER1_JNR'	WHERE ModifierId='MINOR_CIV_BOLOGNA_GREAT_SCIENTIST_POINTS_BONUS';
--------------------------------------------------------------

-- ModifierArguments
--------------------------------------------------------------
INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,												Name,				Value)
VALUES	('MINOR_CIV_SCIENTIFIC_MEDIUM_INFLUENCE_BONUS_ACADEMY_JNR',	'ModifierId',		'MINOR_CIV_SCIENTIFIC_YIELD_FOR_ACADEMY_JNR'),
		('MINOR_CIV_SCIENTIFIC_LARGE_INFLUENCE_BONUS_SCHOOL_JNR',	'ModifierId',		'MINOR_CIV_SCIENTIFIC_YIELD_FOR_SCHOOL_JNR'),
		('MINOR_CIV_SCIENTIFIC_YIELD_FOR_ACADEMY_JNR',				'BuildingType',		'BUILDING_JNR_ACADEMY'),
		('MINOR_CIV_SCIENTIFIC_YIELD_FOR_SCHOOL_JNR',				'BuildingType',		'BUILDING_JNR_SCHOOL'),
		('MINOR_CIV_SCIENTIFIC_YIELD_FOR_ACADEMY_JNR',				'YieldType',		'YIELD_SCIENCE'),
		('MINOR_CIV_SCIENTIFIC_YIELD_FOR_SCHOOL_JNR',				'YieldType',		'YIELD_SCIENCE'),
		('MINOR_CIV_SCIENTIFIC_YIELD_FOR_ACADEMY_JNR',				'Amount',			2),
		('MINOR_CIV_SCIENTIFIC_YIELD_FOR_SCHOOL_JNR',				'Amount',			2),
		('MINOR_CIV_SCIENTIFIC_YIELD_FOR_ACADEMY_JNR',				'CityStatesOnly',	1),
		('MINOR_CIV_SCIENTIFIC_YIELD_FOR_SCHOOL_JNR',				'CityStatesOnly',	1);
--------------------------------------------------------------

-- TraitModifiers
--------------------------------------------------------------
INSERT OR IGNORE INTO TraitModifiers
		(TraitType,	ModifierId)
SELECT	TraitType,	'MINOR_CIV_SCIENTIFIC_MEDIUM_INFLUENCE_BONUS_ACADEMY_JNR'
FROM	TraitModifiers
WHERE	ModifierId='MINOR_CIV_SCIENTIFIC_MEDIUM_INFLUENCE_BONUS';

INSERT OR IGNORE INTO TraitModifiers
		(TraitType,	ModifierId)
SELECT	TraitType,	'MINOR_CIV_SCIENTIFIC_LARGE_INFLUENCE_BONUS_SCHOOL_JNR'
FROM	TraitModifiers
WHERE	ModifierId='MINOR_CIV_SCIENTIFIC_LARGE_INFLUENCE_BONUS';
--------------------------------------------------------------