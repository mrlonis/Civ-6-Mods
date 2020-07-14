-- UC_COM_Misc
-- Author: JNR
--------------------------------------------------------------

----------------------------------------------------------------------------------------------------------------------------
-- Technologies and Civics
----------------------------------------------------------------------------------------------------------------------------

-- Boosts
--------------------------------------------------------------
UPDATE Boosts SET
		TriggerDescription='LOC_BOOST_TRIGGER_PRINTING_JNR_UC'
WHERE	TechnologyType='TECH_PRINTING';

UPDATE	Boosts SET
		TriggerDescription='LOC_BOOST_TRIGGER_CHEMISTRY_JNR_UC',
		TriggerLongDescription='LOC_BOOST_TRIGGER_LONGDESC_CHEMISTRY_JNR_UC',
		BoostClass='BOOST_TRIGGER_HAVE_X_BUILDINGS',
		BuildingType='BUILDING_JNR_LABORATORY'
WHERE	TechnologyType='TECH_CHEMISTRY';

UPDATE	Boosts SET
		TriggerDescription='LOC_BOOST_TRIGGER_NUCLEAR_PROGRAM_JNR_UC'
WHERE	CivicType='CIVIC_NUCLEAR_PROGRAM';
--------------------------------------------------------------

-- Technologies
--------------------------------------------------------------
--
-- Disabled due common adjacency values not being granular enough for 25% increments.
--
--UPDATE Technologies SET
--Description='LOC_TECH_ASTRONOMY_DESCRIPTION_JNR_UC'
--WHERE TechnologyType='TECH_ASTRONOMY';
--------------------------------------------------------------

-- Requirements
--------------------------------------------------------------
INSERT OR IGNORE INTO Requirements
		(RequirementId,								RequirementType)
VALUES	('REQUIRES_PLAYER_HAS_2_SCHOOLS_JNR',		'REQUIREMENT_PLAYER_HAS_AT_LEAST_NUM_BUILDINGS'),
		('REQUIRES_PLAYER_HAS_UNIVERSITY_JNR',		'REQUIREMENT_PLAYER_HAS_BUILDING'),
		('REQUIRES_PLAYER_HAS_SCHOOL_JNR',			'REQUIREMENT_PLAYER_HAS_BUILDING'),
		('REQUIRES_PLAYER_HAS_ASTRONOMY_JNR',		'REQUIREMENT_PLAYER_HAS_TECHNOLOGY');
--------------------------------------------------------------

-- RequirementArguments
--------------------------------------------------------------
INSERT OR IGNORE INTO RequirementArguments
		(RequirementId,								Name,				Value)
VALUES	('REQUIRES_PLAYER_HAS_2_SCHOOLS_JNR',		'BuildingType',		'BUILDING_JNR_SCHOOL'),
		('REQUIRES_PLAYER_HAS_2_SCHOOLS_JNR',		'Amount',			2),
		('REQUIRES_PLAYER_HAS_UNIVERSITY_JNR',		'BuildingType',		'BUILDING_UNIVERSITY'),
		('REQUIRES_PLAYER_HAS_SCHOOL_JNR',			'BuildingType',		'BUILDING_JNR_SCHOOL'),
		('REQUIRES_PLAYER_HAS_ASTRONOMY_JNR',		'TechnologyType',	'TECH_ASTRONOMY');
--------------------------------------------------------------

-- RequirementSets
--------------------------------------------------------------
INSERT OR IGNORE INTO RequirementSets
		(RequirementSetId,										RequirementSetType)
VALUES	('PLAYER_HAS_2_SCHOOLS_REQUIREMENT_JNR',				'REQUIREMENTSET_TEST_ALL'),
		('PLAYER_HAS_UNIVERSITY_AND_SCHOOL_REQUIREMENT_JNR',	'REQUIREMENTSET_TEST_ALL'),
		('ASTRONOMY_MOUNTAIN_IS_ADJACENT_JNR',					'REQUIREMENTSET_TEST_ALL'),
		('ASTRONOMY_MOUNTAIN_IS_ADJACENT_NO_UNIVERSITY_JNR',	'REQUIREMENTSET_TEST_ALL'),
		('PLAYER_HAS_ASTRONOMY_TECHNOLOGY_JNR',					'REQUIREMENTSET_TEST_ALL'),
		('ASTRONOMY_TECHNOLOGY_NO_UNIVERSITY_JNR',				'REQUIREMENTSET_TEST_ALL');
--------------------------------------------------------------

-- RequirementSetRequirements
--------------------------------------------------------------
INSERT OR IGNORE INTO RequirementSetRequirements
		(RequirementSetId,										RequirementId)
VALUES	('PLAYER_HAS_2_SCHOOLS_REQUIREMENT_JNR',				'REQUIRES_PLAYER_HAS_2_SCHOOLS_JNR'),
		('PLAYER_HAS_UNIVERSITY_AND_SCHOOL_REQUIREMENT_JNR',	'REQUIRES_PLAYER_HAS_UNIVERSITY_JNR'),
		('PLAYER_HAS_UNIVERSITY_AND_SCHOOL_REQUIREMENT_JNR',	'REQUIRES_PLAYER_HAS_SCHOOL_JNR'),
		('ASTRONOMY_MOUNTAIN_IS_ADJACENT_JNR',					'REQUIRES_PLAYER_HAS_ASTRONOMY_JNR'),
		('ASTRONOMY_MOUNTAIN_IS_ADJACENT_JNR',					'REQUIRES_PLOT_ADJACENT_TO_MOUNTAIN'),
		('ASTRONOMY_MOUNTAIN_IS_ADJACENT_NO_UNIVERSITY_JNR',	'REQUIRES_PLAYER_HAS_ASTRONOMY_JNR'),
		('ASTRONOMY_MOUNTAIN_IS_ADJACENT_NO_UNIVERSITY_JNR',	'REQUIRES_PLOT_ADJACENT_TO_MOUNTAIN'),
		('ASTRONOMY_MOUNTAIN_IS_ADJACENT_NO_UNIVERSITY_JNR',	'REQUIRES_CITY_HAS_NO_UNIVERSITY_JNR'),
		('PLAYER_HAS_ASTRONOMY_TECHNOLOGY_JNR',					'REQUIRES_PLAYER_HAS_ASTRONOMY_JNR'),
		('ASTRONOMY_TECHNOLOGY_NO_UNIVERSITY_JNR',				'REQUIRES_PLAYER_HAS_ASTRONOMY_JNR'),
		('ASTRONOMY_TECHNOLOGY_NO_UNIVERSITY_JNR',				'REQUIRES_CITY_HAS_NO_UNIVERSITY_JNR');
--------------------------------------------------------------

-- Types
--------------------------------------------------------------
INSERT OR IGNORE INTO Types
		(Type,													Kind)
VALUES	('MODIFIER_JNR_SINGLE_DISTRICT_ADJUST_YIELD_MODIFIER',	'KIND_MODIFIER');
--------------------------------------------------------------

-- DynamicModifiers
--------------------------------------------------------------
INSERT OR IGNORE INTO DynamicModifiers
		(ModifierType,											CollectionType,		EffectType)
VALUES	('MODIFIER_JNR_SINGLE_DISTRICT_ADJUST_YIELD_MODIFIER',	'COLLECTION_OWNER',	'EFFECT_ADJUST_DISTRICT_YIELD_MODIFIER');
--------------------------------------------------------------

-- Modifiers
--------------------------------------------------------------
INSERT OR IGNORE INTO Modifiers
		(ModifierId,									ModifierType,											SubjectRequirementSetId,							Permanent,	RunOnce)
VALUES	('SCHOOL_PRINTING_TECHBOOST_SCHOOL_JNR',		'MODIFIER_PLAYER_GRANT_SPECIFIC_TECH_BOOST',			'PLAYER_HAS_2_SCHOOLS_REQUIREMENT_JNR',				1,			1),
		('SCHOOL_PRINTING_TECHBOOST_MIX_JNR',			'MODIFIER_PLAYER_GRANT_SPECIFIC_TECH_BOOST',			'PLAYER_HAS_UNIVERSITY_AND_SCHOOL_REQUIREMENT_JNR',	1,			1),
		('CAMPUS_ASTRONOMYSCIENCE_JNR',					'MODIFIER_JNR_SINGLE_DISTRICT_ADJUST_YIELD_MODIFIER',	'ASTRONOMY_MOUNTAIN_IS_ADJACENT_JNR',				0,			0),
		('CAMPUS_ASTRONOMYSCIENCE_NO_UNI_JNR',			'MODIFIER_JNR_SINGLE_DISTRICT_ADJUST_YIELD_MODIFIER',	'ASTRONOMY_MOUNTAIN_IS_ADJACENT_NO_UNIVERSITY_JNR',	0,			0),
		('UNIQUECAMPUS_ASTRONOMYSCIENCE_JNR',			'MODIFIER_JNR_SINGLE_DISTRICT_ADJUST_YIELD_MODIFIER',	'PLAYER_HAS_ASTRONOMY_TECHNOLOGY_JNR',				0,			0),
		('UNIQUECAMPUS_ASTRONOMYSCIENCE_NO_UNI_JNR',	'MODIFIER_JNR_SINGLE_DISTRICT_ADJUST_YIELD_MODIFIER',	'ASTRONOMY_TECHNOLOGY_NO_UNIVERSITY_JNR',			0,			0);
--------------------------------------------------------------

-- ModifierArguments
--------------------------------------------------------------
INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,									Name,			Value)
VALUES	('SCHOOL_PRINTING_TECHBOOST_SCHOOL_JNR',		'TechType',		'TECH_PRINTING'),
		('SCHOOL_PRINTING_TECHBOOST_MIX_JNR',			'TechType',		'TECH_PRINTING'),
		('CAMPUS_ASTRONOMYSCIENCE_JNR',					'YieldType',	'YIELD_SCIENCE'),
		('CAMPUS_ASTRONOMYSCIENCE_JNR',					'Amount',		25),
		('CAMPUS_ASTRONOMYSCIENCE_NO_UNI_JNR',			'YieldType',	'YIELD_SCIENCE'),
		('CAMPUS_ASTRONOMYSCIENCE_NO_UNI_JNR',			'Amount',		25),
		('UNIQUECAMPUS_ASTRONOMYSCIENCE_JNR',			'YieldType',	'YIELD_SCIENCE'),
		('UNIQUECAMPUS_ASTRONOMYSCIENCE_JNR',			'Amount',		25),
		('UNIQUECAMPUS_ASTRONOMYSCIENCE_NO_UNI_JNR',	'YieldType',	'YIELD_SCIENCE'),
		('UNIQUECAMPUS_ASTRONOMYSCIENCE_NO_UNI_JNR',	'Amount',		25);
--------------------------------------------------------------

-- TraitModifiers
--------------------------------------------------------------
INSERT OR IGNORE INTO TraitModifiers
		(TraitType,					ModifierId)
VALUES	('TRAIT_LEADER_MAJOR_CIV',	'SCHOOL_PRINTING_TECHBOOST_SCHOOL_JNR'),
		('TRAIT_LEADER_MAJOR_CIV',	'SCHOOL_PRINTING_TECHBOOST_MIX_JNR');
--------------------------------------------------------------

-- DistrictModifiers
--------------------------------------------------------------
--
-- Disabled due common adjacency values not being granular enough for 25% increments.
-- Reduce buff from policy by half if re-enabled.
--
--INSERT OR IGNORE INTO DistrictModifiers
		--(DistrictType,			ModifierId)
--VALUES	('DISTRICT_CAMPUS',		'CAMPUS_ASTRONOMYSCIENCE_JNR'),
		--('DISTRICT_CAMPUS',		'CAMPUS_ASTRONOMYSCIENCE_NO_UNI_JNR');
--
--INSERT OR IGNORE INTO DistrictModifiers
		--(DistrictType,			ModifierId)
--SELECT	CivUniqueDistrictType,	'UNIQUECAMPUS_ASTRONOMYSCIENCE_JNR'
--FROM	DistrictReplaces
--WHERE	ReplacesDistrictType='DISTRICT_CAMPUS';
--
--INSERT OR IGNORE INTO DistrictModifiers
		--(DistrictType,			ModifierId)
--SELECT	CivUniqueDistrictType,	'UNIQUECAMPUS_ASTRONOMYSCIENCE_NO_UNI_JNR'
--FROM	DistrictReplaces
--WHERE	ReplacesDistrictType='DISTRICT_CAMPUS';
--------------------------------------------------------------

----------------------------------------------------------------------------------------------------------------------------
-- Nobel Price
----------------------------------------------------------------------------------------------------------------------------

-- EmergencyRewards
--------------------------------------------------------------
UPDATE EmergencyRewards SET Description='LOC_EMERGENCY_REWARD_NOBEL_PRIZE_PHY_FIRST_PLACE_UNIVERSITY_RESOURCES_DESCRIPTION_JNR_UC'	WHERE ModifierID='NOBEL_PRIZE_PHY_FIRST_PLACE_UNIVERSITY_RESOURCES'	AND EmergencyType='EMERGENCY_NOBEL_PRIZE_PHYSICS' AND OnSuccess=1;
UPDATE EmergencyRewards SET Description='LOC_EMERGENCY_REWARD_NOBEL_PRIZE_PHY_TOP_TIER_UNIVERSITY_RESOURCES_DESCRIPTION_JNR_UC'		WHERE ModifierID='NOBEL_PRIZE_PHY_TOP_TIER_RESEARCH_LAB_RESOURCES'	AND EmergencyType='EMERGENCY_NOBEL_PRIZE_PHYSICS' AND OnSuccess=1;
--------------------------------------------------------------

-- RequirementSetRequirements
--------------------------------------------------------------
UPDATE RequirementSetRequirements SET RequirementId='REQUIRES_CITY_HAS_CAMPUS_TIER2_JNR'	WHERE RequirementSetId='NOBEL_PRIZE_FIRST_PLACE_UNIVERSITY_RESOURCES_REQUIREMENTS'	AND RequirementId='REQUIRES_CITY_HAS_UNIVERSITY';
UPDATE RequirementSetRequirements SET RequirementId='REQUIRES_CITY_HAS_CAMPUS_TIER3_JNR'	WHERE RequirementSetId='NOBEL_PRIZE_TOP_TIER_RESEARCH_LAB_RESOURCES_REQUIREMENTS'	AND RequirementId='REQUIRES_CITY_HAS_RESEARCH_LAB';
--------------------------------------------------------------

----------------------------------------------------------------------------------------------------------------------------
-- Pantheons and Traits
----------------------------------------------------------------------------------------------------------------------------

-- Modifiers
--------------------------------------------------------------
UPDATE Modifiers SET SubjectRequirementSetId='BUILDING_IS_CAMPUS_TIER1_JNR'	WHERE ModifierId='DIVINE_SPARK_SCIENTIST_MODIFIER';
UPDATE Modifiers SET SubjectRequirementSetId='BUILDING_IS_CAMPUS_TIER2_JNR'	WHERE ModifierId='TRAIT_GREAT_SCIENTIST_UNIVERSITY_MODIFIER';
--------------------------------------------------------------

-- Traits
--------------------------------------------------------------
UPDATE	Traits SET Description='LOC_TRAIT_CIVILIZATION_NOBEL_PRIZE_DESCRIPTION_JNR_UC' WHERE TraitType='TRAIT_CIVILIZATION_NOBEL_PRIZE';
--------------------------------------------------------------

----------------------------------------------------------------------------------------------------------------------------
-- Great Scientists
----------------------------------------------------------------------------------------------------------------------------

-- Modifiers
--------------------------------------------------------------
INSERT OR IGNORE INTO Modifiers
		(ModifierId,											ModifierType,											SubjectRequirementSetId,	Permanent,	RunOnce)
VALUES	('GREATPERSON_ACADEMY_SCIENCE_JNR',						'MODIFIER_PLAYER_CITIES_ADJUST_BUILDING_YIELD_CHANGE',	NULL,						1,			0),
		('GREATPERSON_SCHOOL_SCIENCE_JNR',						'MODIFIER_PLAYER_CITIES_ADJUST_BUILDING_YIELD_CHANGE',	NULL,						1,			0),
		('GREATPERSON_LABORATORY_SCIENCE_JNR',					'MODIFIER_PLAYER_CITIES_ADJUST_BUILDING_YIELD_CHANGE',	NULL,						1,			0),
		('GREATPERSON_LIBERAL_ARTS_SCIENCE_JNR',				'MODIFIER_PLAYER_CITIES_ADJUST_BUILDING_YIELD_CHANGE',	NULL,						1,			0),
		('GREATPERSON_INSTITUTE_SCIENCE_JNR',					'MODIFIER_PLAYER_CITIES_ADJUST_BUILDING_YIELD_CHANGE',	NULL,						1,			0),
		('GREATPERSON_EDUCATION_SCIENCE_JNR',					'MODIFIER_PLAYER_CITIES_ADJUST_BUILDING_YIELD_CHANGE',	NULL,						1,			0),

		('GREATPERSON_ACADEMY_JNR',								'MODIFIER_SINGLE_CITY_GRANT_BUILDING_IN_CITY_IGNORE',	NULL,						1,			1),
		('GREATPERSON_SCIENTIFICTHEORYTECHBOOST_JNR',			'MODIFIER_PLAYER_GRANT_SPECIFIC_TECH_BOOST',			NULL,						1,			1),
		('GREATPERSON_1RENAISSANCEINDUSTRIALCIVICBOOST_JNR',	'MODIFIER_PLAYER_GRANT_RANDOM_CIVIC_BOOST_BY_ERA',		NULL,						1,			1);
--------------------------------------------------------------

-- ModifierArguments
--------------------------------------------------------------
INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,											Name,			Value)
VALUES	('GREATPERSON_ACADEMY_SCIENCE_JNR',						'YieldType',	'YIELD_SCIENCE'),
		('GREATPERSON_ACADEMY_SCIENCE_JNR',						'BuildingType',	'BUILDING_JNR_ACADEMY'),
		('GREATPERSON_ACADEMY_SCIENCE_JNR',						'Amount',		1),
		('GREATPERSON_SCHOOL_SCIENCE_JNR',						'YieldType',	'YIELD_SCIENCE'),
		('GREATPERSON_SCHOOL_SCIENCE_JNR',						'BuildingType',	'BUILDING_JNR_SCHOOL'),
		('GREATPERSON_SCHOOL_SCIENCE_JNR',						'Amount',		2),
		('GREATPERSON_LABORATORY_SCIENCE_JNR',					'YieldType',	'YIELD_SCIENCE'),
		('GREATPERSON_LABORATORY_SCIENCE_JNR',					'BuildingType',	'BUILDING_JNR_LABORATORY'),
		('GREATPERSON_LABORATORY_SCIENCE_JNR',					'Amount',		3),
		('GREATPERSON_LIBERAL_ARTS_SCIENCE_JNR',				'YieldType',	'YIELD_SCIENCE'),
		('GREATPERSON_LIBERAL_ARTS_SCIENCE_JNR',				'BuildingType',	'BUILDING_JNR_LIBERAL_ARTS'),
		('GREATPERSON_LIBERAL_ARTS_SCIENCE_JNR',				'Amount',		3),
		('GREATPERSON_INSTITUTE_SCIENCE_JNR',					'YieldType',	'YIELD_SCIENCE'),
		('GREATPERSON_INSTITUTE_SCIENCE_JNR',					'BuildingType',	'BUILDING_RESEARCH_LAB'),
		('GREATPERSON_INSTITUTE_SCIENCE_JNR',					'Amount',		4),
		('GREATPERSON_EDUCATION_SCIENCE_JNR',					'YieldType',	'YIELD_SCIENCE'),
		('GREATPERSON_EDUCATION_SCIENCE_JNR',					'BuildingType',	'BUILDING_JNR_EDUCATION'),
		('GREATPERSON_EDUCATION_SCIENCE_JNR',					'Amount',		4),

		('GREATPERSON_ACADEMY_JNR',								'BuildingType',	'BUILDING_JNR_ACADEMY'),
		('GREATPERSON_SCIENTIFICTHEORYTECHBOOST_JNR',			'TechType',		'TECH_SCIENTIFIC_THEORY'),
		('GREATPERSON_1RENAISSANCEINDUSTRIALCIVICBOOST_JNR',	'StartEraType',	'ERA_RENAISSANCE'),
		('GREATPERSON_1RENAISSANCEINDUSTRIALCIVICBOOST_JNR',	'EndEraType',	'ERA_INDUSTRIAL'),
		('GREATPERSON_1RENAISSANCEINDUSTRIALCIVICBOOST_JNR',	'Amount',		1);
--------------------------------------------------------------

-- GreatPersonIndividualActionModifiers
--------------------------------------------------------------
DELETE FROM GreatPersonIndividualActionModifiers WHERE GreatPersonIndividualType='GREAT_PERSON_INDIVIDUAL_ARYABHATA'			AND ModifierId='GREATPERSON_3CLASSICALMEDIEVALTECHBOOSTS';
DELETE FROM GreatPersonIndividualActionModifiers WHERE GreatPersonIndividualType='GREAT_PERSON_INDIVIDUAL_OMAR_KHAYYAM'			AND ModifierId='GREATPERSON_2MEDIEVALRENAISSANCETECHBOOSTS';
DELETE FROM GreatPersonIndividualActionModifiers WHERE GreatPersonIndividualType='GREAT_PERSON_INDIVIDUAL_ISAAC_NEWTON'			AND ModifierId='GREATPERSON_LIBRARY';
DELETE FROM GreatPersonIndividualActionModifiers WHERE GreatPersonIndividualType='GREAT_PERSON_INDIVIDUAL_ISAAC_NEWTON'			AND ModifierId='GREATPERSON_UNIVERSITY';
DELETE FROM GreatPersonIndividualActionModifiers WHERE GreatPersonIndividualType='GREAT_PERSON_INDIVIDUAL_EMILIE_DU_CHATELET'	AND ModifierId='GREATPERSON_3RENAISSANCEINDUSTRIALTECHBOOSTS';
DELETE FROM GreatPersonIndividualActionModifiers WHERE GreatPersonIndividualType='GREAT_PERSON_INDIVIDUAL_DMITRI_MENDELEEV'		AND ModifierId='GREATPERSON_1INDUSTRIALTECHBOOST';
DELETE FROM GreatPersonIndividualActionModifiers WHERE GreatPersonIndividualType='GREAT_PERSON_INDIVIDUAL_ALBERT_EINSTEIN'		AND ModifierId='GREATPERSON_1MODERNATOMICTECHBOOST';
DELETE FROM GreatPersonIndividualActionModifiers WHERE GreatPersonIndividualType='GREAT_PERSON_INDIVIDUAL_ALBERT_EINSTEIN'		AND ModifierId='GREATPERSON_UNIVERSITIES_BIG_SCIENCE';

INSERT OR IGNORE INTO GreatPersonIndividualActionModifiers
		(GreatPersonIndividualType,						ModifierId,											AttachmentTargetType)
VALUES	('GREAT_PERSON_INDIVIDUAL_ARYABHATA',			'GREATPERSON_ACADEMY_SCIENCE_JNR',					'GREAT_PERSON_ACTION_ATTACHMENT_TARGET_DISTRICT_IN_TILE'),
		('GREAT_PERSON_INDIVIDUAL_OMAR_KHAYYAM',		'GREATPERSON_SCHOOL_SCIENCE_JNR',					'GREAT_PERSON_ACTION_ATTACHMENT_TARGET_DISTRICT_IN_TILE'),
		('GREAT_PERSON_INDIVIDUAL_EMILIE_DU_CHATELET',	'GREATPERSON_LIBERAL_ARTS_SCIENCE_JNR',				'GREAT_PERSON_ACTION_ATTACHMENT_TARGET_DISTRICT_IN_TILE'),
		('GREAT_PERSON_INDIVIDUAL_DMITRI_MENDELEEV',	'GREATPERSON_LABORATORY_SCIENCE_JNR',				'GREAT_PERSON_ACTION_ATTACHMENT_TARGET_DISTRICT_IN_TILE'),
		('GREAT_PERSON_INDIVIDUAL_ALBERT_EINSTEIN',		'GREATPERSON_INSTITUTE_SCIENCE_JNR',				'GREAT_PERSON_ACTION_ATTACHMENT_TARGET_DISTRICT_IN_TILE'),
		('GREAT_PERSON_INDIVIDUAL_ALBERT_EINSTEIN',		'GREATPERSON_EDUCATION_SCIENCE_JNR',				'GREAT_PERSON_ACTION_ATTACHMENT_TARGET_DISTRICT_IN_TILE'),

		('GREAT_PERSON_INDIVIDUAL_ARYABHATA',			'GREATPERSON_ACADEMY_JNR',							'GREAT_PERSON_ACTION_ATTACHMENT_TARGET_DISTRICT_IN_TILE'),
		('GREAT_PERSON_INDIVIDUAL_ISAAC_NEWTON',		'GREATPERSON_SCIENTIFICTHEORYTECHBOOST_JNR',		'GREAT_PERSON_ACTION_ATTACHMENT_TARGET_DISTRICT_IN_TILE'),
		('GREAT_PERSON_INDIVIDUAL_EMILIE_DU_CHATELET',	'GREATPERSON_1RENAISSANCEINDUSTRIALCIVICBOOST_JNR',	'GREAT_PERSON_ACTION_ATTACHMENT_TARGET_DISTRICT_IN_TILE');
--------------------------------------------------------------

-- ModifierStrings
--------------------------------------------------------------
INSERT OR IGNORE INTO ModifierStrings
		(ModifierId,											Context,	Text)
VALUES	('GREATPERSON_ACADEMY_SCIENCE_JNR',						'Summary',	'LOC_GREATPERSON_ACADEMY_SCIENCE_JNR'),
		('GREATPERSON_SCHOOL_SCIENCE_JNR',						'Summary',	'LOC_GREATPERSON_SCHOOL_SCIENCE_JNR'),
		('GREATPERSON_LIBERAL_ARTS_SCIENCE_JNR',				'Summary',	'LOC_GREATPERSON_LIBERAL_ARTS_SCIENCE_JNR'),
		('GREATPERSON_LABORATORY_SCIENCE_JNR',					'Summary',	'LOC_GREATPERSON_LABORATORY_SCIENCE_JNR'),
		('GREATPERSON_INSTITUTE_SCIENCE_JNR',					'Summary',	'LOC_GREATPERSON_INSTITUTE_SCIENCE_JNR'),
		('GREATPERSON_EDUCATION_SCIENCE_JNR',					'Summary',	'LOC_GREATPERSON_EDUCATION_SCIENCE_JNR'),

		('GREATPERSON_ACADEMY_JNR',								'Summary',	'LOC_GREATPERSON_ACADEMY_JNR'),
		('GREATPERSON_SCIENTIFICTHEORYTECHBOOST_JNR',			'Summary',	'LOC_GREATPERSON_SCIENTIFICTHEORYTECHBOOST_JNR'),
		('GREATPERSON_1RENAISSANCEINDUSTRIALCIVICBOOST_JNR',	'Summary',	'LOC_GREATPERSON_1RENAISSANCEINDUSTRIALCIVICBOOST_JNR');
--------------------------------------------------------------

-- GreatPersonIndividuals
--------------------------------------------------------------
UPDATE GreatPersonIndividuals SET ActionEffectTextOverride=NULL	WHERE GreatPersonIndividualType='GREAT_PERSON_INDIVIDUAL_OMAR_KHAYYAM';
UPDATE GreatPersonIndividuals SET ActionEffectTextOverride=NULL	WHERE GreatPersonIndividualType='GREAT_PERSON_INDIVIDUAL_ISAAC_NEWTON';
UPDATE GreatPersonIndividuals SET ActionEffectTextOverride=NULL	WHERE GreatPersonIndividualType='GREAT_PERSON_INDIVIDUAL_DMITRI_MENDELEEV';
--------------------------------------------------------------