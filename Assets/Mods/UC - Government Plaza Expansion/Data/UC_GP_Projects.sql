-- UC_GP_Projects
-- Author: JNR
--------------------------------------------------------------

-- Types
--------------------------------------------------------------
INSERT OR IGNORE INTO Types
		(Type,								Kind)
VALUES	('PROJECT_JNR_GOV_CAPITAL_MOVE',	'KIND_PROJECT');
--------------------------------------------------------------

-- Projects
--------------------------------------------------------------
INSERT OR IGNORE INTO Projects
		(
		ProjectType,
		Name,
		ShortName,
		Description,
		PrereqDistrict,
		Cost,
		CostProgressionModel,
		CostProgressionParam1,
		MaxPlayerInstances,
		AdvisorType
		)
VALUES	(
		'PROJECT_JNR_GOV_CAPITAL_MOVE',					--ProjectType
		'LOC_PROJECT_JNR_GOV_CAPITAL_MOVE_NAME',		--Name,
		'LOC_PROJECT_JNR_GOV_CAPITAL_MOVE_SHORT_NAME',	--ShortName,
		'LOC_PROJECT_JNR_GOV_CAPITAL_MOVE_DESCRIPTION',	--Description,
		'DISTRICT_GOVERNMENT',							--PrereqDistrict,
		200,											--Cost,
		'COST_PROGRESSION_GAME_PROGRESS',				--CostProgressionModel,
		750,											--CostProgressionParam1,
		1,												--MaxPlayerInstances,
		'ADVISOR_GENERIC'								--AdvisorType
		);
--------------------------------------------------------------

-- Projects_XP2
--------------------------------------------------------------
INSERT OR IGNORE INTO Projects_XP2
		(ProjectType,						UnlocksFromEffect,	MaxSimultaneousInstances)
VALUES	('PROJECT_JNR_GOV_CAPITAL_MOVE',	1,					1);
--------------------------------------------------------------

-- TraitModifiers
--------------------------------------------------------------
INSERT OR IGNORE INTO TraitModifiers
		(ModifierId,						TraitType)
VALUES	('JNR_COMPLETE_MOVE_CAPITAL_GOV',	'TRAIT_LEADER_MAJOR_CIV');
--------------------------------------------------------------

-- Modifiers
--------------------------------------------------------------
INSERT OR IGNORE INTO Modifiers
		(ModifierId,						ModifierType)
VALUES	('JNR_COMPLETE_MOVE_CAPITAL_GOV',	'MODIFIER_PLAYER_ADJUST_CAPITAL');
--------------------------------------------------------------

-- ModifierArguments
--------------------------------------------------------------
INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,						Name,			Value)
VALUES	('JNR_COMPLETE_MOVE_CAPITAL_GOV',	'ProjectType',	'PROJECT_JNR_GOV_CAPITAL_MOVE');
--------------------------------------------------------------