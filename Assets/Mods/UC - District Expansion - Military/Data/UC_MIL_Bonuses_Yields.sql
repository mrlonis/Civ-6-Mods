-- UC_MIL_Bonuses_Yields
-- Author: JNR
--------------------------------------------------------------

-- Building_YieldChanges
--------------------------------------------------------------
INSERT OR IGNORE INTO Building_YieldChanges
		(BuildingType,					YieldType,			YieldChange)
VALUES	('BUILDING_JNR_TARGET_RANGE',	'YIELD_PRODUCTION',	1),
		('BUILDING_JNR_CAVALIER',		'YIELD_PRODUCTION',	2),
		('BUILDING_JNR_DEPOT',			'YIELD_PRODUCTION',	2),
		('BUILDING_JNR_ARSENAL',		'YIELD_PRODUCTION',	4),
		('BUILDING_JNR_NAVAL_BASE',		'YIELD_PRODUCTION',	3);

UPDATE Building_YieldChanges SET YieldChange=2 WHERE BuildingType='BUILDING_BARRACKS'			AND YieldType='YIELD_PRODUCTION';
UPDATE Building_YieldChanges SET YieldChange=1 WHERE BuildingType='BUILDING_STABLE'				AND YieldType='YIELD_PRODUCTION';
UPDATE Building_YieldChanges SET YieldChange=2 WHERE BuildingType='BUILDING_BASILIKOI_PAIDES'	AND YieldType='YIELD_PRODUCTION';
UPDATE Building_YieldChanges SET YieldChange=1 WHERE BuildingType='BUILDING_ORDU'				AND YieldType='YIELD_PRODUCTION';
UPDATE Building_YieldChanges SET YieldChange=3 WHERE BuildingType='BUILDING_ARMORY'				AND YieldType='YIELD_PRODUCTION';
UPDATE Building_YieldChanges SET YieldChange=3 WHERE BuildingType='BUILDING_MILITARY_ACADEMY'	AND YieldType='YIELD_PRODUCTION';

UPDATE Building_YieldChanges SET YieldChange=3 WHERE BuildingType='BUILDING_HANGAR'				AND YieldType='YIELD_PRODUCTION';
UPDATE Building_YieldChanges SET YieldChange=4 WHERE BuildingType='BUILDING_AIRPORT'			AND YieldType='YIELD_PRODUCTION';

UPDATE Building_YieldChanges SET YieldChange=6 WHERE BuildingType='BUILDING_SEAPORT'			AND YieldType='YIELD_GOLD';
--------------------------------------------------------------

-- Building_YieldDistrictCopies
--------------------------------------------------------------
INSERT OR IGNORE INTO Building_YieldDistrictCopies
		(BuildingType,			OldYieldType,		NewYieldType)
VALUES	('BUILDING_JNR_PRISON',	'YIELD_PRODUCTION',	'YIELD_PRODUCTION');
--------------------------------------------------------------

-- Building_CitizenYieldChanges
--------------------------------------------------------------
INSERT OR IGNORE INTO Building_CitizenYieldChanges
		(BuildingType,				YieldType,			YieldChange)
VALUES	('BUILDING_JNR_ARSENAL',	'YIELD_PRODUCTION',	1),
		('BUILDING_JNR_PRISON',		'YIELD_PRODUCTION',	2),
		('BUILDING_AIRPORT',		'YIELD_PRODUCTION',	1),
		('BUILDING_JNR_NAVAL_BASE',	'YIELD_GOLD',		2);

UPDATE Building_CitizenYieldChanges SET YieldType='YIELD_CULTURE', YieldChange=1	WHERE BuildingType='BUILDING_MILITARY_ACADEMY' AND YieldType='YIELD_PRODUCTION';
--------------------------------------------------------------

-- Types
--------------------------------------------------------------
INSERT OR IGNORE INTO Types
		(Type,														Kind)
VALUES	('MODIFIER_JNR_PLAYER_DISTRICTS_ADJUST_BASE_YIELD_CHANGE',	'KIND_MODIFIER');
--------------------------------------------------------------

-- DynamicModifiers
--------------------------------------------------------------
INSERT OR IGNORE INTO DynamicModifiers
		(ModifierType,												CollectionType,					EffectType)
VALUES	('MODIFIER_JNR_PLAYER_DISTRICTS_ADJUST_BASE_YIELD_CHANGE',	'COLLECTION_PLAYER_DISTRICTS',	'EFFECT_ADJUST_DISTRICT_YIELD_CHANGE');
--------------------------------------------------------------

-- Requirements
--------------------------------------------------------------
INSERT OR IGNORE INTO Requirements
		(RequirementId,						RequirementType)
VALUES	('REQUIRES_HORSES_IN_PLOT_JNR',		'REQUIREMENT_PLOT_RESOURCE_TYPE_MATCHES'),
		('REQUIRES_IRON_IN_PLOT_JNR',		'REQUIREMENT_PLOT_RESOURCE_TYPE_MATCHES'),
		('REQUIRES_NITER_IN_PLOT_JNR',		'REQUIREMENT_PLOT_RESOURCE_TYPE_MATCHES'),
		('REQUIRES_ALUMINUM_IN_PLOT_JNR',	'REQUIREMENT_PLOT_RESOURCE_TYPE_MATCHES');
--------------------------------------------------------------

-- RequirementArguments
--------------------------------------------------------------
INSERT OR IGNORE INTO RequirementArguments
		(RequirementId,						Name,			Value)
VALUES	('REQUIRES_HORSES_IN_PLOT_JNR',		'ResourceType',	'RESOURCE_HORSES'),
		('REQUIRES_IRON_IN_PLOT_JNR',		'ResourceType',	'RESOURCE_IRON'),
		('REQUIRES_NITER_IN_PLOT_JNR',		'ResourceType',	'RESOURCE_NITER'),
		('REQUIRES_ALUMINUM_IN_PLOT_JNR',	'ResourceType',	'RESOURCE_ALUMINUM');
--------------------------------------------------------------

-- RequirementSets
--------------------------------------------------------------
INSERT OR IGNORE INTO RequirementSets
		(RequirementSetId,							RequirementSetType)
VALUES	('PLOT_HAS_HORSES_JNR',						'REQUIREMENTSET_TEST_ALL'),
		('PLOT_HAS_IRON_JNR',						'REQUIREMENTSET_TEST_ALL'),
		('PLOT_HAS_NITER_JNR',						'REQUIREMENTSET_TEST_ALL'),
		('PLOT_HAS_ALUMINUM_JNR',					'REQUIREMENTSET_TEST_ALL'),
		('PLOT_HAS_PRISON_ADJACENT_TO_OWNER_JNR',	'REQUIREMENTSET_TEST_ALL');
--------------------------------------------------------------

-- RequirementSetRequirements
--------------------------------------------------------------
INSERT OR IGNORE INTO RequirementSetRequirements
		(RequirementSetId,							RequirementId)
VALUES	('PLOT_HAS_HORSES_JNR',						'REQUIRES_HORSES_IN_PLOT_JNR'),
		('PLOT_HAS_IRON_JNR',						'REQUIRES_IRON_IN_PLOT_JNR'),
		('PLOT_HAS_NITER_JNR',						'REQUIRES_NITER_IN_PLOT_JNR'),
		('PLOT_HAS_ALUMINUM_JNR',					'REQUIRES_ALUMINUM_IN_PLOT_JNR'),
		('PLOT_HAS_PRISON_ADJACENT_TO_OWNER_JNR',	'REQUIRES_DISTRICT_IS_ENCAMPMENT'),
		('PLOT_HAS_PRISON_ADJACENT_TO_OWNER_JNR',	'REQUIRES_CITY_HAS_PRISON_JNR'),
		('PLOT_HAS_PRISON_ADJACENT_TO_OWNER_JNR',	'ADJACENT_TO_OWNER');
--------------------------------------------------------------

-- Modifiers
--------------------------------------------------------------
INSERT OR IGNORE INTO Modifiers
		(ModifierId,							ModifierType,												SubjectRequirementSetId)
VALUES	('JNR_STABLE_HORSE_PRODUCTION',			'MODIFIER_CITY_PLOT_YIELDS_ADJUST_PLOT_YIELD',				'PLOT_HAS_HORSES_JNR'),
		('JNR_TARGET_RANGE_CAMP_PRODUCTION',	'MODIFIER_CITY_PLOT_YIELDS_ADJUST_PLOT_YIELD',				'PLOT_HAS_CAMP_REQUIREMENTS'),
		('JNR_ARMORY_IRON_PRODUCTION',			'MODIFIER_CITY_PLOT_YIELDS_ADJUST_PLOT_YIELD',				'PLOT_HAS_IRON_JNR'),
		('JNR_CAVALIER_NITER_PRODUCTION',		'MODIFIER_CITY_PLOT_YIELDS_ADJUST_PLOT_YIELD',				'PLOT_HAS_NITER_JNR'),
		('JNR_HANGAR_ALUMINUM_PRODUCTION',		'MODIFIER_CITY_PLOT_YIELDS_ADJUST_PLOT_YIELD',				'PLOT_HAS_ALUMINUM_JNR'),
		('JNR_PRISON_QUARRY_ADJACENCY',			'MODIFIER_JNR_PLAYER_DISTRICTS_ADJUST_BASE_YIELD_CHANGE',	'PLOT_HAS_PRISON_ADJACENT_TO_OWNER_JNR');
-----------------------------------------------------------

-- ModifierArguments
--------------------------------------------------------------
INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,							Name,			Value)
VALUES	('JNR_STABLE_HORSE_PRODUCTION',			'YieldType',	'YIELD_PRODUCTION'),
		('JNR_STABLE_HORSE_PRODUCTION',			'Amount',		1),
		('JNR_TARGET_RANGE_CAMP_PRODUCTION',	'YieldType',	'YIELD_PRODUCTION'),
		('JNR_TARGET_RANGE_CAMP_PRODUCTION',	'Amount',		1),
		('JNR_ARMORY_IRON_PRODUCTION',			'YieldType',	'YIELD_PRODUCTION'),
		('JNR_ARMORY_IRON_PRODUCTION',			'Amount',		1),
		('JNR_CAVALIER_NITER_PRODUCTION',		'YieldType',	'YIELD_PRODUCTION'),
		('JNR_CAVALIER_NITER_PRODUCTION',		'Amount',		1),
		('JNR_HANGAR_ALUMINUM_PRODUCTION',		'YieldType',	'YIELD_PRODUCTION'),
		('JNR_HANGAR_ALUMINUM_PRODUCTION',		'Amount',		1),
		('JNR_PRISON_QUARRY_ADJACENCY',			'YieldType',	'YIELD_PRODUCTION'),
		('JNR_PRISON_QUARRY_ADJACENCY',			'Amount',		1);
--------------------------------------------------------------

-- BuildingModifiers
--------------------------------------------------------------
INSERT OR IGNORE INTO BuildingModifiers
		(BuildingType,					ModifierId)
VALUES	('BUILDING_STABLE',				'JNR_STABLE_HORSE_PRODUCTION');
--		('BUILDING_JNR_TARGET_RANGE',	'JNR_TARGET_RANGE_CAMP_PRODUCTION'),
--		('BUILDING_ARMORY',				'JNR_ARMORY_IRON_PRODUCTION'),
--		('BUILDING_JNR_CAVALIER',		'JNR_CAVALIER_NITER_PRODUCTION'),
--		('BUILDING_HANGAR',				'JNR_HANGAR_ALUMINUM_PRODUCTION');

INSERT OR IGNORE INTO BuildingModifiers
		(BuildingType,					ModifierId)
SELECT	 'BUILDING_ORDU',				'JNR_STABLE_HORSE_PRODUCTION'
FROM Buildings WHERE BuildingType='BUILDING_ORDU';
--------------------------------------------------------------

-- ImprovementModifiers
--------------------------------------------------------------
INSERT OR IGNORE INTO ImprovementModifiers
		(ImprovementType,		ModifierId)
VALUES	('IMPROVEMENT_QUARRY',	'JNR_PRISON_QUARRY_ADJACENCY');
--------------------------------------------------------------