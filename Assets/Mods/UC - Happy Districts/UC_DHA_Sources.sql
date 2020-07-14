-- UC_DHA_Sources
-- Author: JNR
--------------------------------------------------------------

-- TraitModifiers
--------------------------------------------------------------
INSERT OR REPLACE INTO TraitModifiers
		(TraitType,					ModifierId)
VALUES	('TRAIT_LEADER_MAJOR_CIV',	'JNR_MARSH_EXTRA_APPEAL_CONSERVATION'),
		('TRAIT_LEADER_MAJOR_CIV',	'JNR_FOREST_EXTRA_APPEAL_CONSERVATION'),
		('TRAIT_LEADER_MAJOR_CIV',	'JNR_GEOTHERMAL_APPEAL_NEUTRALIZED'),
		('MINOR_CIV_DEFAULT_TRAIT',	'JNR_MARSH_EXTRA_APPEAL_CONSERVATION'),
		('MINOR_CIV_DEFAULT_TRAIT',	'JNR_FOREST_EXTRA_APPEAL_CONSERVATION'),
		('MINOR_CIV_DEFAULT_TRAIT',	'JNR_GEOTHERMAL_APPEAL_NEUTRALIZED');
--------------------------------------------------------------

-- Features
--------------------------------------------------------------
UPDATE Features		SET Appeal=0	WHERE FeatureType='FEATURE_FLOODPLAINS';
UPDATE Features		SET Appeal=0	WHERE FeatureType='FEATURE_FLOODPLAINS_GRASSLAND';
UPDATE Features		SET Appeal=0	WHERE FeatureType='FEATURE_FLOODPLAINS_PLAINS';
UPDATE Features		SET Appeal=1	WHERE FeatureType='FEATURE_REEF';
UPDATE Features		SET Appeal=1	WHERE FeatureType='FEATURE_GEOTHERMAL_FISSURE';
UPDATE Features		SET Appeal=-1	WHERE FeatureType='FEATURE_VOLCANO';
--------------------------------------------------------------

-- Improvements
--------------------------------------------------------------
UPDATE Improvements	SET Description='LOC_IMPROVEMENT_GEOTHERMAL_PLANT_DESCRIPTION_JNR_DHA'						WHERE ImprovementType='IMPROVEMENT_GEOTHERMAL_PLANT' AND Description='LOC_IMPROVEMENT_GEOTHERMAL_PLANT_DESCRIPTION';
UPDATE Improvements	SET Description='LOC_IMPROVEMENT_GEOTHERMAL_PLANT_DESCRIPTION_JNR_TERRAIN_COMPLEXITY_DHA'	WHERE ImprovementType='IMPROVEMENT_GEOTHERMAL_PLANT' AND Description='LOC_IMPROVEMENT_GEOTHERMAL_PLANT_DESCRIPTION_JNR_TERRAIN_COMPLEXITY';
--------------------------------------------------------------

-- Modifiers
--------------------------------------------------------------
INSERT OR REPLACE INTO Modifiers
		(ModifierId,								ModifierType,												SubjectRequirementSetId)
VALUES	('JNR_MARSH_EXTRA_APPEAL_CONSERVATION',		'MODIFIER_PLAYER_CITIES_ADJUST_FEATURE_APPEAL_MODIFIER',	'JNR_CIVIC_UNLOCKED_CONSERVATION'),
		('JNR_FOREST_EXTRA_APPEAL_CONSERVATION',	'MODIFIER_PLAYER_CITIES_ADJUST_FEATURE_APPEAL_MODIFIER',	'JNR_PROTECTED_FOREST_REQUIREMENTSET'),
		('JNR_GEOTHERMAL_APPEAL_NEUTRALIZED',		'MODIFIER_PLAYER_CITIES_ADJUST_FEATURE_APPEAL_MODIFIER',	'JNR_PLOT_HAS_GEOTHERMAL_PLANT');
--------------------------------------------------------------

-- ModifierArguments
--------------------------------------------------------------
INSERT OR REPLACE INTO ModifierArguments
		(ModifierId,								Name,			Value)
VALUES	('JNR_MARSH_EXTRA_APPEAL_CONSERVATION',		'FeatureType',	'FEATURE_MARSH'),
		('JNR_MARSH_EXTRA_APPEAL_CONSERVATION',		'Amount',		2),
		('JNR_FOREST_EXTRA_APPEAL_CONSERVATION',	'FeatureType',	'FEATURE_FOREST'),
		('JNR_FOREST_EXTRA_APPEAL_CONSERVATION',	'Amount',		1),
		('JNR_GEOTHERMAL_APPEAL_NEUTRALIZED',		'FeatureType',	'FEATURE_GEOTHERMAL_FISSURE'),
		('JNR_GEOTHERMAL_APPEAL_NEUTRALIZED',		'Amount',		-1);
--------------------------------------------------------------

-- RequirementSets
--------------------------------------------------------------
INSERT OR REPLACE INTO RequirementSets
		(RequirementSetId,						RequirementSetType)
VALUES	('JNR_CIVIC_UNLOCKED_CONSERVATION',		'REQUIREMENTSET_TEST_ALL'),
		('JNR_PROTECTED_FOREST_REQUIREMENTSET',	'REQUIREMENTSET_TEST_ALL'),
		('JNR_PLOT_HAS_GEOTHERMAL_PLANT',		'REQUIREMENTSET_TEST_ALL');
--------------------------------------------------------------

-- RequirementSetRequirements
--------------------------------------------------------------
INSERT OR REPLACE INTO RequirementSetRequirements
		(RequirementSetId,						RequirementId)
VALUES	('JNR_CIVIC_UNLOCKED_CONSERVATION',		'JNR_CIVIC_CONSERVATION_REQUIREMENT'),
		('JNR_PROTECTED_FOREST_REQUIREMENTSET',	'JNR_CIVIC_CONSERVATION_REQUIREMENT'),
		('JNR_PROTECTED_FOREST_REQUIREMENTSET',	'REQUIRES_PLOT_HAS_NO_IMPROVEMENT'),
		('JNR_PLOT_HAS_GEOTHERMAL_PLANT',		'REQUIRES_PLOT_HAS_GEOTHERMAL_PLANT');
--------------------------------------------------------------

-- Requirements
--------------------------------------------------------------
INSERT OR REPLACE INTO Requirements
		(RequirementId,								RequirementType,								Inverse)
VALUES	('JNR_CIVIC_CONSERVATION_REQUIREMENT',		'REQUIREMENT_PLAYER_HAS_CIVIC',					NULL),
		('REQUIRES_PLOT_HAS_NO_IMPROVEMENT',		'REQUIREMENT_PLOT_HAS_ANY_IMPROVEMENT',			1),
		('REQUIRES_PLOT_HAS_GEOTHERMAL_PLANT',		'REQUIREMENT_PLOT_IMPROVEMENT_TYPE_MATCHES',	NULL);
--------------------------------------------------------------

-- RequirementArguments
--------------------------------------------------------------
INSERT OR REPLACE INTO RequirementArguments
		(RequirementId,							Name,				Value)
VALUES	('JNR_CIVIC_CONSERVATION_REQUIREMENT',	'CivicType',		'CIVIC_CONSERVATION'),
		('REQUIRES_PLOT_HAS_GEOTHERMAL_PLANT',	'ImprovementType',	'IMPROVEMENT_GEOTHERMAL_PLANT');