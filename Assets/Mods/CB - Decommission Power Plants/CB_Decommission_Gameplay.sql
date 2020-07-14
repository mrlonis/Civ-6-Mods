-- CB_Decommission_Gameplay
-- Author: JNR
--------------------------------------------------------------

-- EmergencyScoreSources
--------------------------------------------------------------
DELETE FROM EmergencyScoreSources WHERE ScoreSourceType='CLIMATE_ACCORDS_SCORE_DECOMMISSION_COAL';
DELETE FROM EmergencyScoreSources WHERE ScoreSourceType='CLIMATE_ACCORDS_SCORE_DECOMMISSION_OIL';
DELETE FROM EmergencyScoreSources WHERE ScoreSourceType='CLIMATE_ACCORDS_SCORE_DECOMMISSION_NUCLEAR';

INSERT OR IGNORE INTO EmergencyScoreSources
		(ScoreSourceType,										EmergencyType,					FromBuilding,								ScoreAmount,	Description)
VALUES	('CLIMATE_ACCORDS_SCORE_JNR_CB_COAL_POWER_PLANT',		'EMERGENCY_CLIMATE_ACCORDS',	'BUILDING_COAL_POWER_PLANT',				-4,				'LOC_EMERGENCY_SCORE_JNR_CB_COAL_POWER_PLANT_DESC'),
		('CLIMATE_ACCORDS_SCORE_JNR_CB_OIL_POWER_PLANT',		'EMERGENCY_CLIMATE_ACCORDS',	'BUILDING_FOSSIL_FUEL_POWER_PLANT',			-2,				'LOC_EMERGENCY_SCORE_JNR_CB_OIL_POWER_PLANT_DESC'),
		('CLIMATE_ACCORDS_SCORE_JNR_CB_NUCLEAR_POWER_PLANT',	'EMERGENCY_CLIMATE_ACCORDS',	'BUILDING_POWER_PLANT',						2,				'LOC_EMERGENCY_SCORE_JNR_CB_NUCLEAR_POWER_PLANT_DESC');

INSERT OR IGNORE INTO EmergencyScoreSources
		(ScoreSourceType,										EmergencyType,					FromProject,								ScoreAmount,	Description)
VALUES	('CLIMATE_ACCORDS_SCORE_JNR_CB_POWER_PROJECT',			'EMERGENCY_CLIMATE_ACCORDS',	'PROJECT_ENHANCE_DISTRICT_INDUSTRIAL_ZONE',	100,			'LOC_EMERGENCY_SCORE_JNR_CB_POWER_PROJECT_DESC');

INSERT OR IGNORE INTO EmergencyScoreSources
		(ScoreSourceType,										EmergencyType,					FromBuilding,								ScoreAmount,	Description)
SELECT	'CLIMATE_ACCORDS_SCORE_JNR_CB_RENEWABLE_POWER_PLANT',	'EMERGENCY_CLIMATE_ACCORDS',	BuildingType,								4,				'LOC_EMERGENCY_SCORE_JNR_CB_RENEWBABLE_POWER_PLANT_DESC'
FROM Buildings WHERE BuildingType='BUILDING_JNR_RENEWABLE_DISTRIBUTION';

INSERT OR IGNORE INTO EmergencyScoreSources
		(ScoreSourceType,										EmergencyType,					FromBuilding,								ScoreAmount,	Description)
SELECT	'CLIMATE_ACCORDS_SCORE_JNR_CB_RENEWABLE_COLLECTION',	'EMERGENCY_CLIMATE_ACCORDS',	BuildingType,								1,				'LOC_EMERGENCY_SCORE_JNR_CB_RENEWBABLE_COLLECTION_DESC'
FROM Buildings WHERE BuildingType='BUILDING_JNR_RENEWABLE_COLLECTION';
--------------------------------------------------------------

-- Projects
--------------------------------------------------------------
UPDATE Projects SET Cost=100 WHERE ProjectType='PROJECT_DECOMMISSION_COAL_POWER_PLANT';
UPDATE Projects SET Cost=150 WHERE ProjectType='PROJECT_DECOMMISSION_OIL_POWER_PLANT';
UPDATE Projects SET Cost=300 WHERE ProjectType='PROJECT_DECOMMISSION_NUCLEAR_POWER_PLANT';
--------------------------------------------------------------

-- Types
--------------------------------------------------------------
INSERT OR IGNORE INTO Types
		(Type,											Kind)
VALUES	('MODIFIER_JNR_PLAYER_MAKE_PROJECT_AVAILABLE',	'KIND_MODIFIER');
--------------------------------------------------------------

-- DynamicModifiers
--------------------------------------------------------------
INSERT OR IGNORE INTO DynamicModifiers
		(ModifierType,									CollectionType,		EffectType)
VALUES	('MODIFIER_JNR_PLAYER_MAKE_PROJECT_AVAILABLE',	'COLLECTION_OWNER',	'EFFECT_ADD_PLAYER_PROJECT_AVAILABILITY');
--------------------------------------------------------------

-- Modifiers
--------------------------------------------------------------
INSERT OR IGNORE INTO Modifiers
		(ModifierId,											ModifierType)
VALUES	('JNR_ENVIRONMENTALISM_DECOMMISSIONING_UNLOCK_COAL',	'MODIFIER_JNR_PLAYER_MAKE_PROJECT_AVAILABLE'),
		('JNR_ENVIRONMENTALISM_DECOMMISSIONING_UNLOCK_OIL',		'MODIFIER_JNR_PLAYER_MAKE_PROJECT_AVAILABLE'),
		('JNR_ENVIRONMENTALISM_DECOMMISSIONING_UNLOCK_NUCLEAR',	'MODIFIER_JNR_PLAYER_MAKE_PROJECT_AVAILABLE');
--------------------------------------------------------------

-- ModifierArguments
--------------------------------------------------------------
INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,											Name,			Value)
VALUES	('JNR_ENVIRONMENTALISM_DECOMMISSIONING_UNLOCK_COAL',	'ProjectType',	'PROJECT_DECOMMISSION_COAL_POWER_PLANT'),
		('JNR_ENVIRONMENTALISM_DECOMMISSIONING_UNLOCK_OIL',		'ProjectType',	'PROJECT_DECOMMISSION_OIL_POWER_PLANT'),
		('JNR_ENVIRONMENTALISM_DECOMMISSIONING_UNLOCK_NUCLEAR',	'ProjectType',	'PROJECT_DECOMMISSION_NUCLEAR_POWER_PLANT');
--------------------------------------------------------------

-- CivicModifiers
--------------------------------------------------------------
INSERT OR IGNORE INTO CivicModifiers
		(CivicType,					ModifierId)
VALUES	('CIVIC_ENVIRONMENTALISM',	'JNR_ENVIRONMENTALISM_DECOMMISSIONING_UNLOCK_COAL'),
		('CIVIC_ENVIRONMENTALISM',	'JNR_ENVIRONMENTALISM_DECOMMISSIONING_UNLOCK_OIL'),
		('CIVIC_ENVIRONMENTALISM',	'JNR_ENVIRONMENTALISM_DECOMMISSIONING_UNLOCK_NUCLEAR');
--------------------------------------------------------------

-- Civics
--------------------------------------------------------------
UPDATE Civics SET Description='LOC_CIVIC_ENVIRONMENTALISM_DESCRIPTION_JNR_CB' WHERE CivicType='CIVIC_ENVIRONMENTALISM';
--------------------------------------------------------------