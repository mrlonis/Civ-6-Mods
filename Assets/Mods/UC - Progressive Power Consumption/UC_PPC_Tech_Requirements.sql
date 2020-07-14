-- UC_PPC_Tech_Requirements
-- Author: JNR
--------------------------------------------------------------

-- Requirements
--------------------------------------------------------------
INSERT OR IGNORE INTO Requirements
		(RequirementId,													RequirementType)
VALUES	('REQUIRES_PLAYER_HAS_TECH_INDUSTRIALIZATION_JNR',				'REQUIREMENT_PLAYER_HAS_TECHNOLOGY'),
		('REQUIRES_PLAYER_IS_ATOMIC_ERA_TECH_REQUIREMENTSET_JNR',		'REQUIREMENT_REQUIREMENTSET_IS_MET'),
		('REQUIRES_PLAYER_IS_INFORMATION_ERA_TECH_REQUIREMENTSET_JNR',	'REQUIREMENT_REQUIREMENTSET_IS_MET'),
		('REQUIRES_PLAYER_IS_FUTURE_ERA_TECH_REQUIREMENTSET_JNR',		'REQUIREMENT_REQUIREMENTSET_IS_MET'),
		('REQUIRES_PLAYER_IS_INDUSTRIAL_ERA_JNR',						'REQUIREMENT_PLAYER_ERA_AT_LEAST'),
		('REQUIRES_PLAYER_IS_INFORMATION_ERA_JNR',						'REQUIREMENT_PLAYER_ERA_AT_LEAST');

INSERT OR IGNORE INTO Requirements
		(RequirementId,										RequirementType)
SELECT	 'REQUIRES_PLAYER_HAS_' || TechnologyType ||'_JNR',	'REQUIREMENT_PLAYER_HAS_TECHNOLOGY'
FROM Technologies WHERE EraType='ERA_ATOMIC';

INSERT OR IGNORE INTO Requirements
		(RequirementId,										RequirementType)
SELECT	 'REQUIRES_PLAYER_HAS_' || TechnologyType ||'_JNR',	'REQUIREMENT_PLAYER_HAS_TECHNOLOGY'
FROM Technologies WHERE EraType='ERA_INFORMATION';

INSERT OR IGNORE INTO Requirements
		(RequirementId,										RequirementType)
SELECT	 'REQUIRES_PLAYER_HAS_' || TechnologyType ||'_JNR',	'REQUIREMENT_PLAYER_HAS_TECHNOLOGY'
FROM Technologies WHERE EraType='ERA_FUTURE';
--------------------------------------------------------------

-- RequirementArguments
--------------------------------------------------------------
INSERT OR IGNORE INTO RequirementArguments
		(RequirementId,													Name,				Value)
VALUES	('REQUIRES_PLAYER_HAS_TECH_INDUSTRIALIZATION_JNR',				'TechnologyType',	'TECH_INDUSTRIALIZATION'),
		('REQUIRES_PLAYER_IS_ATOMIC_ERA_TECH_REQUIREMENTSET_JNR',		'RequirementSetId',	'PLAYER_IS_ATOMIC_ERA_TECH_JNR'),
		('REQUIRES_PLAYER_IS_INFORMATION_ERA_TECH_REQUIREMENTSET_JNR',	'RequirementSetId',	'PLAYER_IS_INFORMATION_ERA_TECH_JNR'),
		('REQUIRES_PLAYER_IS_FUTURE_ERA_TECH_REQUIREMENTSET_JNR',		'RequirementSetId',	'PLAYER_IS_FUTURE_ERA_TECH_JNR'),
		('REQUIRES_PLAYER_IS_INDUSTRIAL_ERA_JNR',						'EraType',			'ERA_INDUSTRIAL'),
		('REQUIRES_PLAYER_IS_INFORMATION_ERA_JNR',						'EraType',			'ERA_INFORMATION');

INSERT OR IGNORE INTO RequirementArguments
		(RequirementId,													Name,				Value)
SELECT	 'REQUIRES_PLAYER_HAS_' || TechnologyType ||'_JNR',				'TechnologyType',	TechnologyType
FROM Technologies WHERE EraType='ERA_ATOMIC';

INSERT OR IGNORE INTO RequirementArguments
		(RequirementId,													Name,				Value)
SELECT	 'REQUIRES_PLAYER_HAS_' || TechnologyType ||'_JNR',				'TechnologyType',	TechnologyType
FROM Technologies WHERE EraType='ERA_INFORMATION';

INSERT OR IGNORE INTO RequirementArguments
		(RequirementId,													Name,				Value)
SELECT	 'REQUIRES_PLAYER_HAS_' || TechnologyType ||'_JNR',				'TechnologyType',	TechnologyType
FROM Technologies WHERE EraType='ERA_FUTURE';
--------------------------------------------------------------

-- RequirementSets
--------------------------------------------------------------
INSERT OR IGNORE INTO RequirementSets
		(RequirementSetId,						RequirementSetType)
VALUES	('PLAYER_IS_ATOMIC_ERA_TECH_JNR',		'REQUIREMENTSET_TEST_ANY'),
		('PLAYER_IS_INFORMATION_ERA_TECH_JNR',	'REQUIREMENTSET_TEST_ANY'),
		('PLAYER_IS_FUTURE_ERA_TECH_JNR',		'REQUIREMENTSET_TEST_ANY');
--------------------------------------------------------------

-- RequirementSetRequirements
--------------------------------------------------------------
INSERT OR IGNORE INTO RequirementSetRequirements
		(RequirementSetId,						RequirementId)
SELECT	 'PLAYER_IS_ATOMIC_ERA_TECH_JNR',		'REQUIRES_PLAYER_HAS_' || TechnologyType || '_JNR'
FROM Technologies WHERE EraType='ERA_ATOMIC';

INSERT OR IGNORE INTO RequirementSetRequirements
		(RequirementSetId,						RequirementId)
SELECT	 'PLAYER_IS_INFORMATION_ERA_TECH_JNR',	'REQUIRES_PLAYER_HAS_' || TechnologyType || '_JNR'
FROM Technologies WHERE EraType='ERA_INFORMATION';

INSERT OR IGNORE INTO RequirementSetRequirements
		(RequirementSetId,						RequirementId)
SELECT	 'PLAYER_IS_FUTURE_ERA_TECH_JNR',		'REQUIRES_PLAYER_HAS_' || TechnologyType || '_JNR'
FROM Technologies WHERE EraType='ERA_FUTURE';
--------------------------------------------------------------