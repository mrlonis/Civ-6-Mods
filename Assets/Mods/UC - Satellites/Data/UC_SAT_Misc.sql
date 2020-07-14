-- UC_SAT_Misc
-- Author: JNR
--------------------------------------------------------------

-- Types
--------------------------------------------------------------
INSERT OR IGNORE INTO Types
		(Type,											Kind)
VALUES	('MODIFIER_JNR_OWNER_MAKE_PROJECT_AVAILABLE',	'KIND_MODIFIER');
--------------------------------------------------------------

-- DynamicModifiers
--------------------------------------------------------------
INSERT OR IGNORE INTO DynamicModifiers
		(ModifierType,									CollectionType,				EffectType)
VALUES	('MODIFIER_JNR_OWNER_MAKE_PROJECT_AVAILABLE',	'COLLECTION_OWNER',			'EFFECT_ADD_PLAYER_PROJECT_AVAILABILITY');
--------------------------------------------------------------

-- DiplomaticVisibilitySources
--------------------------------------------------------------
INSERT OR IGNORE INTO DiplomaticVisibilitySources
		(VisibilitySourceType,
		Description,
		ActionDescription,
		GossipString,
		TraitType,
		FromCitizen)
VALUES	('SOURCE_JNR_PROJECT_SATELLITE',
		'LOC_VIZSOURCE_JNR_PROJECT_SATELLITE',
		'LOC_VIZSOURCE_ACTION_JNR_PROJECT_SATELLITE',
		'LOC_GOSSIP_SOURCE_JNR_PROJECT_SATELLITE',
		'TRAIT_LEADER_MAJOR_CIV',
		1);
--------------------------------------------------------------

-- Boosts
--------------------------------------------------------------
UPDATE	Boosts
SET		TriggerDescription='LOC_BOOST_TRIGGER_SATELLITES_JNR_UC',
		TriggerLongDescription='LOC_BOOST_TRIGGER_LONGDESC_SATELLITES_JNR_UC'
WHERE	BoostID=105;
--------------------------------------------------------------

-- Modifiers
--------------------------------------------------------------
INSERT OR IGNORE INTO Modifiers
		(ModifierId,						ModifierType,									RunOnce,	Permanent)
VALUES	('FREE_TECH_BOOST_SATELLITES_JNR',	'MODIFIER_PLAYER_GRANT_SPECIFIC_TECH_BOOST',	1,			1);
--------------------------------------------------------------

-- ModifierArguments
--------------------------------------------------------------
INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,						Name,		Value)
VALUES	('FREE_TECH_BOOST_SATELLITES_JNR',	'TechType',	'TECH_SATELLITES');
--------------------------------------------------------------

-- ProjectCompletionModifiers
--------------------------------------------------------------
INSERT OR IGNORE INTO ProjectCompletionModifiers
		(ProjectType,						ModifierId)
VALUES	('PROJECT_LAUNCH_EARTH_SATELLITE',	'FREE_TECH_BOOST_SATELLITES_JNR');
--------------------------------------------------------------

-- Technologies
--------------------------------------------------------------
UPDATE Technologies SET Description='LOC_TECH_SATELLITES_DESCRIPTION_JNR_UC' WHERE TechnologyType='TECH_SATELLITES';
--------------------------------------------------------------

-- Great People
--------------------------------------------------------------
UPDATE GreatPersonIndividuals	SET ActionCharges=3																WHERE GreatPersonIndividualType='GREAT_PERSON_INDIVIDUAL_SERGEI_KOROLEV';
UPDATE GreatPersonIndividuals	SET ActionCharges=3																WHERE GreatPersonIndividualType='GREAT_PERSON_INDIVIDUAL_CARL_SAGAN';
UPDATE ModifierArguments		SET Value=450																	WHERE ModifierId='GREATPERSON_GRANT_PRODUCTION_IN_CITY_EARLY_SPACE_RACE'	AND Name='Amount';
UPDATE ModifierArguments		SET Value=900																	WHERE ModifierId='GREATPERSON_GRANT_PRODUCTION_IN_CITY_LATE_SPACE_RACE'		AND Name='Amount';
UPDATE ModifierStrings			SET 'Text'='LOC_GREATPERSON_GRANT_PRODUCTION_IN_CITY_EARLY_SPACE_RACE_JNR_UC'	WHERE ModifierId='GREATPERSON_GRANT_PRODUCTION_IN_CITY_EARLY_SPACE_RACE';
UPDATE ModifierStrings			SET 'Text'='LOC_GREATPERSON_GRANT_PRODUCTION_IN_CITY_LATE_SPACE_RACE_JNR_UC'	WHERE ModifierId='GREATPERSON_GRANT_PRODUCTION_IN_CITY_LATE_SPACE_RACE';
UPDATE ModifierStrings			SET 'Text'='LOC_GREATPERSON_SPACE_RACE_PRODUCTION_RATE_SMALL_JNR_UC'			WHERE ModifierId='GREATPERSON_SPACE_RACE_PRODUCTION_RATE_SMALL';
UPDATE ModifierStrings			SET 'Text'='LOC_GREATPERSON_SPACE_RACE_PRODUCTION_RATE_LARGE_JNR_UC'			WHERE ModifierId='GREATPERSON_SPACE_RACE_PRODUCTION_RATE_LARGE';
--------------------------------------------------------------