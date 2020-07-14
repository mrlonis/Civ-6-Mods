-- UC_Light_ENT
-- Author: JNR
--------------------------------------------------------------

-- Buildings
--------------------------------------------------------------
UPDATE Buildings SET Description='LOC_BUILDING_ARENA_DESCRIPTION_UC_JNR_LIGHT'			WHERE BuildingType='BUILDING_ARENA';
UPDATE Buildings SET Description='LOC_BUILDING_TLACHTLI_DESCRIPTION_UC_JNR_LIGHT'		WHERE BuildingType='BUILDING_TLACHTLI';
UPDATE Buildings SET Description='LOC_BUILDING_FERRIS_WHEEL_DESCRIPTION_UC_JNR_LIGHT'	WHERE BuildingType='BUILDING_FERRIS_WHEEL';
--------------------------------------------------------------

-- Building_YieldChanges
--------------------------------------------------------------
DELETE FROM Building_YieldChanges WHERE BuildingType='BUILDING_ARENA'			AND YieldType='YIELD_CULTURE';
DELETE FROM Building_YieldChanges WHERE BuildingType='BUILDING_TLACHTLI'		AND YieldType='YIELD_CULTURE';
DELETE FROM Building_YieldChanges WHERE BuildingType='BUILDING_FERRIS_WHEEL'	AND YieldType='YIELD_CULTURE';
--------------------------------------------------------------

-- CivicModifiers
--------------------------------------------------------------
DELETE FROM CivicModifiers WHERE CivicType='CIVIC_CONSERVATION' AND ModifierId='CONSERVATION_ARENA_TOURISM';
--------------------------------------------------------------

-- Building_GreatWorks
--------------------------------------------------------------
INSERT OR IGNORE INTO Building_GreatWorks
		(BuildingType,			NumSlots,	GreatWorkSlotType)
VALUES	('BUILDING_ARENA',		1,			'GREATWORKSLOT_MUSIC'),
		('BUILDING_TLACHTLI',	1,			'GREATWORKSLOT_MUSIC');
--------------------------------------------------------------

-- Requirements
--------------------------------------------------------------
INSERT OR IGNORE INTO Requirements
		(RequirementId,					RequirementType)
VALUES	('REQUIRES_HORSES_IN_PLOT_JNR',	'REQUIREMENT_PLOT_RESOURCE_TYPE_MATCHES');
--------------------------------------------------------------

-- RequirementArguments
--------------------------------------------------------------
INSERT OR IGNORE INTO RequirementArguments
		(RequirementId,					Name,			Value)
VALUES	('REQUIRES_HORSES_IN_PLOT_JNR',	'ResourceType',	'RESOURCE_HORSES');
--------------------------------------------------------------

-- RequirementSets
--------------------------------------------------------------
INSERT OR IGNORE INTO RequirementSets
		(RequirementSetId,		RequirementSetType)
VALUES	('PLOT_HAS_HORSES_JNR',	'REQUIREMENTSET_TEST_ALL');
--------------------------------------------------------------

-- RequirementSetRequirements
--------------------------------------------------------------
INSERT OR IGNORE INTO RequirementSetRequirements
		(RequirementSetId,		RequirementId)
VALUES	('PLOT_HAS_HORSES_JNR',	'REQUIRES_HORSES_IN_PLOT_JNR');
--------------------------------------------------------------

-- Modifiers
--------------------------------------------------------------
INSERT OR IGNORE INTO Modifiers
		(ModifierId,									ModifierType,									SubjectRequirementSetId)
VALUES	('JNR_ARENA_CULTURE_HORSES_LIGHT',				'MODIFIER_CITY_PLOT_YIELDS_ADJUST_PLOT_YIELD',	'PLOT_HAS_HORSES_JNR'),
		('JNR_TLACHTLI_CULTURE_STONE_LIGHT',			'MODIFIER_CITY_PLOT_YIELDS_ADJUST_PLOT_YIELD',	'PLOT_HAS_QUARRY_REQUIREMENTS'),
		('JNR_FERRIS_WHEEL_GOLD_BREATHTAKING_LIGHT',	'MODIFIER_CITY_PLOT_YIELDS_ADJUST_PLOT_YIELD',	'PLOT_BREATHTAKING_APPEAL');
--------------------------------------------------------------

-- ModifierArguments
--------------------------------------------------------------
INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,									Name,			Value)
VALUES	('JNR_ARENA_CULTURE_HORSES_LIGHT',				'YieldType',	'YIELD_CULTURE'),
		('JNR_ARENA_CULTURE_HORSES_LIGHT',				'Amount',		1),
		('JNR_TLACHTLI_CULTURE_STONE_LIGHT',			'YieldType',	'YIELD_CULTURE'),
		('JNR_TLACHTLI_CULTURE_STONE_LIGHT',			'Amount',		1),
		('JNR_FERRIS_WHEEL_GOLD_BREATHTAKING_LIGHT',	'YieldType',	'YIELD_GOLD'),
		('JNR_FERRIS_WHEEL_GOLD_BREATHTAKING_LIGHT',	'Amount',		1);
--------------------------------------------------------------

-- BuildingModifiers
--------------------------------------------------------------
INSERT OR IGNORE INTO BuildingModifiers
		(BuildingType,				ModifierId)
VALUES	('BUILDING_ARENA',			'JNR_ARENA_CULTURE_HORSES_LIGHT'),
		('BUILDING_TLACHTLI',		'JNR_TLACHTLI_CULTURE_STONE_LIGHT'),
		('BUILDING_FERRIS_WHEEL',	'JNR_FERRIS_WHEEL_GOLD_BREATHTAKING_LIGHT');
--------------------------------------------------------------