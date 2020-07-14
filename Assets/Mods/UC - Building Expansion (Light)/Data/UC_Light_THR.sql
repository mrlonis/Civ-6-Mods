-- UC_Light_THR
-- Author: JNR
--------------------------------------------------------------

-- Buildings
--------------------------------------------------------------
UPDATE Buildings SET Description='LOC_BUILDING_AMPHITHEATER_DESCRIPTION_UC_JNR_LIGHT'		WHERE BuildingType='BUILDING_AMPHITHEATER';
UPDATE Buildings SET Description='LOC_BUILDING_MUSEUM_ART_DESCRIPTION_UC_JNR_LIGHT'			WHERE BuildingType='BUILDING_MUSEUM_ART';
UPDATE Buildings SET Description='LOC_BUILDING_MUSEUM_ARTIFACT_DESCRIPTION_UC_JNR_LIGHT'	WHERE BuildingType='BUILDING_MUSEUM_ARTIFACT';
UPDATE Buildings SET Description='LOC_BUILDING_BROADCAST_CENTER_DESCRIPTION_UC_JNR_LIGHT'	WHERE BuildingType='BUILDING_BROADCAST_CENTER';
UPDATE Buildings SET Description='LOC_BUILDING_FILM_STUDIO_DESCRIPTION_UC_JNR_LIGHT'		WHERE BuildingType='BUILDING_FILM_STUDIO';

UPDATE Buildings SET RegionalRange=6 WHERE BuildingType='BUILDING_BROADCAST_CENTER';
UPDATE Buildings SET RegionalRange=6 WHERE BuildingType='BUILDING_FILM_STUDIO';
--------------------------------------------------------------

-- Building_YieldChanges
--------------------------------------------------------------
UPDATE Building_YieldChanges				SET YieldChange=1	WHERE BuildingType='BUILDING_AMPHITHEATER'		AND YieldType='YIELD_CULTURE';
DELETE FROM Building_YieldChanges								WHERE BuildingType='BUILDING_MUSEUM_ART'		AND YieldType='YIELD_CULTURE';
UPDATE Building_YieldChanges				SET YieldChange=2	WHERE BuildingType='BUILDING_MUSEUM_ARTIFACT'	AND YieldType='YIELD_CULTURE';
UPDATE Building_YieldChanges				SET YieldChange=3	WHERE BuildingType='BUILDING_BROADCAST_CENTER'	AND YieldType='YIELD_CULTURE';
UPDATE Building_YieldChanges				SET YieldChange=3	WHERE BuildingType='BUILDING_FILM_STUDIO'		AND YieldType='YIELD_CULTURE';
--------------------------------------------------------------

-- Building_YieldChanges
--------------------------------------------------------------
UPDATE Building_YieldChangesBonusWithPower	SET YieldChange=3	WHERE BuildingType='BUILDING_BROADCAST_CENTER'	AND YieldType='YIELD_CULTURE';
UPDATE Building_YieldChangesBonusWithPower	SET YieldChange=3	WHERE BuildingType='BUILDING_FILM_STUDIO'		AND YieldType='YIELD_CULTURE';
--------------------------------------------------------------

-- Building_GreatWorks
--------------------------------------------------------------
UPDATE Building_GreatWorks SET NumSlots=2 WHERE BuildingType='BUILDING_BROADCAST_CENTER'	AND GreatWorkSlotType='GREATWORKSLOT_MUSIC';
UPDATE Building_GreatWorks SET NumSlots=2 WHERE BuildingType='BUILDING_FILM_STUDIO'			AND GreatWorkSlotType='GREATWORKSLOT_MUSIC';
--------------------------------------------------------------

-- Unit_BuildingPrereqs
--------------------------------------------------------------
INSERT OR IGNORE INTO Unit_BuildingPrereqs
		(Unit,				PrereqBuilding,					NumSupported)
VALUES	('UNIT_ROCK_BAND',	'BUILDING_BROADCAST_CENTER',	1);

INSERT OR IGNORE INTO Unit_BuildingPrereqs
		(Unit,				PrereqBuilding,			NumSupported)
SELECT	'UNIT_ROCK_BAND',	CivUniqueBuildingType,	1
FROM	BuildingReplaces
WHERE	ReplacesBuildingType='BUILDING_BROADCAST_CENTER';
--------------------------------------------------------------

-- Tags
--------------------------------------------------------------
INSERT OR IGNORE INTO Tags
		(Tag,									Vocabulary)
VALUES	('CLASS_JNR_RESOURCE_THEME_ARTIFACT',	'RESOURCE_CLASS');
--------------------------------------------------------------

-- TypeTags
--------------------------------------------------------------
INSERT OR IGNORE INTO TypeTags
		(Type,						Tag)
VALUES	('RESOURCE_ANTIQUITY_SITE',	'CLASS_JNR_RESOURCE_THEME_ARTIFACT'),
		('RESOURCE_SHIPWRECK',		'CLASS_JNR_RESOURCE_THEME_ARTIFACT');
--------------------------------------------------------------

-- Requirements
--------------------------------------------------------------
INSERT OR IGNORE INTO Requirements
		(RequirementId,								RequirementType)
VALUES	('REQUIRES_PLOT_HAS_ARTIFACT_SITE_JNR',		'REQUIREMENT_PLOT_RESOURCE_TAG_MATCHES'),
		('REQUIRES_CITY_HAS_1_TITLE_GOVERNOR_JNR',	'REQUIREMENT_CITY_HAS_GOVERNOR_WITH_X_TITLES'),
		('REQUIRES_CITY_HAS_3_TITLE_GOVERNOR_JNR',	'REQUIREMENT_CITY_HAS_GOVERNOR_WITH_X_TITLES'),
		('REQUIRES_CITY_HAS_4_TITLE_GOVERNOR_JNR',	'REQUIREMENT_CITY_HAS_GOVERNOR_WITH_X_TITLES'),
		('REQUIRES_CITY_HAS_5_TITLE_GOVERNOR_JNR',	'REQUIREMENT_CITY_HAS_GOVERNOR_WITH_X_TITLES'),
		('REQUIRES_CITY_HAS_6_TITLE_GOVERNOR_JNR',	'REQUIREMENT_CITY_HAS_GOVERNOR_WITH_X_TITLES');
--------------------------------------------------------------

-- RequirementArguments
--------------------------------------------------------------
INSERT OR IGNORE INTO RequirementArguments
		(RequirementId,								Name,				Value)
VALUES	('REQUIRES_PLOT_HAS_ARTIFACT_SITE_JNR',		'Tag',				'CLASS_JNR_RESOURCE_THEME_ARTIFACT'),
		('REQUIRES_CITY_HAS_1_TITLE_GOVERNOR_JNR',	'Established',		1),
		('REQUIRES_CITY_HAS_1_TITLE_GOVERNOR_JNR',	'Amount',			1),
		('REQUIRES_CITY_HAS_3_TITLE_GOVERNOR_JNR',	'Established',		1),
		('REQUIRES_CITY_HAS_3_TITLE_GOVERNOR_JNR',	'Amount',			3),
		('REQUIRES_CITY_HAS_4_TITLE_GOVERNOR_JNR',	'Established',		1),
		('REQUIRES_CITY_HAS_4_TITLE_GOVERNOR_JNR',	'Amount',			4),
		('REQUIRES_CITY_HAS_5_TITLE_GOVERNOR_JNR',	'Established',		1),
		('REQUIRES_CITY_HAS_5_TITLE_GOVERNOR_JNR',	'Amount',			5),
		('REQUIRES_CITY_HAS_6_TITLE_GOVERNOR_JNR',	'Established',		1),
		('REQUIRES_CITY_HAS_6_TITLE_GOVERNOR_JNR',	'Amount',			6);
--------------------------------------------------------------

-- RequirementSets
--------------------------------------------------------------
INSERT OR IGNORE INTO RequirementSets
		(RequirementSetId,								RequirementSetType)
VALUES	('PLOT_HAS_ARTIFACT_SITE_JNR',					'REQUIREMENTSET_TEST_ALL'),
		('CITY_HAS_1_TITLE_GOVERNOR_REQUIREMENTS_JNR',	'REQUIREMENTSET_TEST_ALL'),
		('CITY_HAS_3_TITLE_GOVERNOR_REQUIREMENTS_JNR',	'REQUIREMENTSET_TEST_ALL'),
		('CITY_HAS_4_TITLE_GOVERNOR_REQUIREMENTS_JNR',	'REQUIREMENTSET_TEST_ALL'),
		('CITY_HAS_5_TITLE_GOVERNOR_REQUIREMENTS_JNR',	'REQUIREMENTSET_TEST_ALL'),
		('CITY_HAS_6_TITLE_GOVERNOR_REQUIREMENTS_JNR',	'REQUIREMENTSET_TEST_ALL');
--------------------------------------------------------------

-- RequirementSetRequirements
--------------------------------------------------------------
INSERT OR IGNORE INTO RequirementSetRequirements
		(RequirementSetId,								RequirementId)
VALUES	('PLOT_HAS_ARTIFACT_SITE_JNR',					'REQUIRES_PLOT_HAS_ARTIFACT_SITE_JNR'),
		('CITY_HAS_1_TITLE_GOVERNOR_REQUIREMENTS_JNR',	'REQUIRES_CITY_HAS_1_TITLE_GOVERNOR_JNR'),
		('CITY_HAS_3_TITLE_GOVERNOR_REQUIREMENTS_JNR',	'REQUIRES_CITY_HAS_3_TITLE_GOVERNOR_JNR'),
		('CITY_HAS_4_TITLE_GOVERNOR_REQUIREMENTS_JNR',	'REQUIRES_CITY_HAS_4_TITLE_GOVERNOR_JNR'),
		('CITY_HAS_5_TITLE_GOVERNOR_REQUIREMENTS_JNR',	'REQUIRES_CITY_HAS_5_TITLE_GOVERNOR_JNR'),
		('CITY_HAS_6_TITLE_GOVERNOR_REQUIREMENTS_JNR',	'REQUIRES_CITY_HAS_6_TITLE_GOVERNOR_JNR');
--------------------------------------------------------------

-- Modifiers
--------------------------------------------------------------
INSERT OR IGNORE INTO Modifiers
		(ModifierId,											ModifierType,												SubjectRequirementSetId)
VALUES	('JNR_AMPHITHEATER_CULTURE_POPULATION_LIGHT',			'MODIFIER_SINGLE_CITY_ADJUST_CITY_YIELD_PER_POPULATION',	NULL),
		('JNR_MUSEUM_ART_CULTURE_1_TITLE_LIGHT',				'MODIFIER_BUILDING_YIELD_CHANGE',							'CITY_HAS_1_TITLE_GOVERNOR_REQUIREMENTS_JNR'),
		('JNR_MUSEUM_ART_CULTURE_2_TITLE_LIGHT',				'MODIFIER_BUILDING_YIELD_CHANGE',							'CITY_HAS_2_TITLE_GOVERNOR_REQUIREMENTS'),
		('JNR_MUSEUM_ART_CULTURE_3_TITLE_LIGHT',				'MODIFIER_BUILDING_YIELD_CHANGE',							'CITY_HAS_3_TITLE_GOVERNOR_REQUIREMENTS_JNR'),
		('JNR_MUSEUM_ART_CULTURE_4_TITLE_LIGHT',				'MODIFIER_BUILDING_YIELD_CHANGE',							'CITY_HAS_4_TITLE_GOVERNOR_REQUIREMENTS_JNR'),
		('JNR_MUSEUM_ART_CULTURE_5_TITLE_LIGHT',				'MODIFIER_BUILDING_YIELD_CHANGE',							'CITY_HAS_5_TITLE_GOVERNOR_REQUIREMENTS_JNR'),
		('JNR_MUSEUM_ART_CULTURE_6_TITLE_LIGHT',				'MODIFIER_BUILDING_YIELD_CHANGE',							'CITY_HAS_6_TITLE_GOVERNOR_REQUIREMENTS_JNR'),
		('JNR_MUSEUM_ARTIFACT_CULTURE_ARTIFACT_SITE_LIGHT',		'MODIFIER_CITY_PLOT_YIELDS_ADJUST_PLOT_YIELD',				'PLOT_HAS_ARTIFACT_SITE_JNR'),
		('JNR_BROADCAST_CENTER_CULTURE_MODIFIER_LIGHT',			'MODIFIER_SINGLE_CITY_ADJUST_CITY_YIELD_MODIFIER',			NULL),
		('JNR_BROADCAST_CENTER_CULTURE_MODIFIER_POWERED_LIGHT',	'MODIFIER_SINGLE_CITY_ADJUST_CITY_YIELD_MODIFIER',			'CITY_IS_POWERED');
--------------------------------------------------------------

-- ModifierArguments
--------------------------------------------------------------
INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,											Name,			Value)
VALUES	('JNR_AMPHITHEATER_CULTURE_POPULATION_LIGHT',			'YieldType',	'YIELD_CULTURE'),
		('JNR_AMPHITHEATER_CULTURE_POPULATION_LIGHT',			'Amount',		0.2),
		('JNR_MUSEUM_ART_CULTURE_1_TITLE_LIGHT',				'BuildingType',	'BUILDING_MUSEUM_ART'),
		('JNR_MUSEUM_ART_CULTURE_1_TITLE_LIGHT',				'YieldType',	'YIELD_CULTURE'),
		('JNR_MUSEUM_ART_CULTURE_1_TITLE_LIGHT',				'Amount',		1),
		('JNR_MUSEUM_ART_CULTURE_2_TITLE_LIGHT',				'BuildingType',	'BUILDING_MUSEUM_ART'),
		('JNR_MUSEUM_ART_CULTURE_2_TITLE_LIGHT',				'YieldType',	'YIELD_CULTURE'),
		('JNR_MUSEUM_ART_CULTURE_2_TITLE_LIGHT',				'Amount',		1),
		('JNR_MUSEUM_ART_CULTURE_3_TITLE_LIGHT',				'BuildingType',	'BUILDING_MUSEUM_ART'),
		('JNR_MUSEUM_ART_CULTURE_3_TITLE_LIGHT',				'YieldType',	'YIELD_CULTURE'),
		('JNR_MUSEUM_ART_CULTURE_3_TITLE_LIGHT',				'Amount',		1),
		('JNR_MUSEUM_ART_CULTURE_4_TITLE_LIGHT',				'BuildingType',	'BUILDING_MUSEUM_ART'),
		('JNR_MUSEUM_ART_CULTURE_4_TITLE_LIGHT',				'YieldType',	'YIELD_CULTURE'),
		('JNR_MUSEUM_ART_CULTURE_4_TITLE_LIGHT',				'Amount',		1),
		('JNR_MUSEUM_ART_CULTURE_5_TITLE_LIGHT',				'BuildingType',	'BUILDING_MUSEUM_ART'),
		('JNR_MUSEUM_ART_CULTURE_5_TITLE_LIGHT',				'YieldType',	'YIELD_CULTURE'),
		('JNR_MUSEUM_ART_CULTURE_5_TITLE_LIGHT',				'Amount',		1),
		('JNR_MUSEUM_ART_CULTURE_6_TITLE_LIGHT',				'BuildingType',	'BUILDING_MUSEUM_ART'),
		('JNR_MUSEUM_ART_CULTURE_6_TITLE_LIGHT',				'YieldType',	'YIELD_CULTURE'),
		('JNR_MUSEUM_ART_CULTURE_6_TITLE_LIGHT',				'Amount',		1),
		('JNR_MUSEUM_ARTIFACT_CULTURE_ARTIFACT_SITE_LIGHT',		'YieldType',	'YIELD_CULTURE'),
		('JNR_MUSEUM_ARTIFACT_CULTURE_ARTIFACT_SITE_LIGHT',		'Amount',		3),
		('JNR_BROADCAST_CENTER_CULTURE_MODIFIER_LIGHT',			'YieldType',	'YIELD_CULTURE'),
		('JNR_BROADCAST_CENTER_CULTURE_MODIFIER_LIGHT',			'Amount',		5),
		('JNR_BROADCAST_CENTER_CULTURE_MODIFIER_POWERED_LIGHT',	'YieldType',	'YIELD_CULTURE'),
		('JNR_BROADCAST_CENTER_CULTURE_MODIFIER_POWERED_LIGHT',	'Amount',		5);
--------------------------------------------------------------

-- BuildingModifiers
--------------------------------------------------------------
INSERT OR IGNORE INTO BuildingModifiers
		(BuildingType,					ModifierId)
VALUES	('BUILDING_AMPHITHEATER',		'JNR_AMPHITHEATER_CULTURE_POPULATION_LIGHT'),
		('BUILDING_MUSEUM_ART',			'JNR_MUSEUM_ART_CULTURE_1_TITLE_LIGHT'),
		('BUILDING_MUSEUM_ART',			'JNR_MUSEUM_ART_CULTURE_2_TITLE_LIGHT'),
		('BUILDING_MUSEUM_ART',			'JNR_MUSEUM_ART_CULTURE_3_TITLE_LIGHT'),
		('BUILDING_MUSEUM_ART',			'JNR_MUSEUM_ART_CULTURE_4_TITLE_LIGHT'),
		('BUILDING_MUSEUM_ART',			'JNR_MUSEUM_ART_CULTURE_5_TITLE_LIGHT'),
		('BUILDING_MUSEUM_ART',			'JNR_MUSEUM_ART_CULTURE_6_TITLE_LIGHT'),
		('BUILDING_MUSEUM_ARTIFACT',	'JNR_MUSEUM_ARTIFACT_CULTURE_ARTIFACT_SITE_LIGHT'),
		('BUILDING_BROADCAST_CENTER',	'JNR_UNIVERSITY_SCIENCE_POPULATION_LIGHT'),
		('BUILDING_BROADCAST_CENTER',	'JNR_UNIVERSITY_SCIENCE_POPULATION_LIGHT');
--------------------------------------------------------------