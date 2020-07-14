-- CB_Carbon_Recapture_Gameplay
-- Author: JNR
--------------------------------------------------------------

-- Civics
--------------------------------------------------------------
UPDATE	Civics
SET		Description='LOC_CIVIC_GLOBAL_WARMING_MITIGATION_DESCRIPTION_JNR_CB'
WHERE	CivicType='CIVIC_GLOBAL_WARMING_MITIGATION';
--------------------------------------------------------------

-- Projects
--------------------------------------------------------------
UPDATE	Projects
SET		Description='LOC_PROJECT_CARBON_RECAPTURE_DESCRIPTION_JNR_CB',
		PrereqCivic=NULL,
		PrereqTech='TECH_SMART_MATERIALS'
WHERE	ProjectType='PROJECT_CARBON_RECAPTURE';
--------------------------------------------------------------

-- Modifiers
--------------------------------------------------------------
UPDATE	Modifiers
SET		SubjectRequirementSetId='PLAYER_HAS_GLOBAL_WARMING_MITIGATION_CIVIC_JNR'
WHERE	ModifierId='PROJECT_COMPLETION_FAVOR_SEQUESTRATION';

INSERT OR IGNORE INTO Modifiers
		(ModifierId,											ModifierType,								SubjectRequirementSetId)
VALUES	('PROJECT_COMPLETION_CARBON_SEQUESTRATION_BONUS_JNR',	'MODIFIER_PLAYER_ADD_SEQUESTERED_CARBON',	'PLAYER_HAS_GLOBAL_WARMING_MITIGATION_CIVIC_JNR');
--------------------------------------------------------------

-- ModifierArguments
--------------------------------------------------------------
UPDATE	ModifierArguments
SET		Value=15
WHERE	ModifierId='PROJECT_COMPLETION_FAVOR_SEQUESTRATION';

UPDATE	ModifierArguments
SET		Value=30000
WHERE	ModifierId='PROJECT_COMPLETION_CARBON_SEQUESTRATION';

INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,											Name,		Value)
VALUES	('PROJECT_COMPLETION_CARBON_SEQUESTRATION_BONUS_JNR',	'Amount',	20000);
--------------------------------------------------------------

-- RequirementSets
--------------------------------------------------------------
INSERT OR IGNORE INTO RequirementSets
		(RequirementSetId,									RequirementSetType)
VALUES	('PLAYER_HAS_GLOBAL_WARMING_MITIGATION_CIVIC_JNR',	'REQUIREMENTSET_TEST_ALL');
--------------------------------------------------------------

-- RequirementSetRequirements
--------------------------------------------------------------
INSERT OR IGNORE INTO RequirementSetRequirements
		(RequirementSetId,									RequirementId)
VALUES	('PLAYER_HAS_GLOBAL_WARMING_MITIGATION_CIVIC_JNR',	'REQUIRES_PLAYER_HAS_GLOBAL_WARMING_MITIGATION_JNR');
--------------------------------------------------------------

-- Requirements
--------------------------------------------------------------
INSERT OR IGNORE INTO Requirements
		(RequirementId,											RequirementType)
VALUES	('REQUIRES_PLAYER_HAS_GLOBAL_WARMING_MITIGATION_JNR',	'REQUIREMENT_PLAYER_HAS_REQUIREMENT_PLAYER_HAS_CIVIC');
--------------------------------------------------------------

-- RequirementArguments
--------------------------------------------------------------
INSERT OR IGNORE INTO RequirementArguments
		(RequirementId,											Name,			Value)
VALUES	('REQUIRES_PLAYER_HAS_GLOBAL_WARMING_MITIGATION_JNR',	'CivicType',	'CIVIC_GLOBAL_WARMING_MITIGATION');
--------------------------------------------------------------