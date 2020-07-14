-- UC_PPC_Power_Load
-- Author: JNR
--------------------------------------------------------------

-- Buildings_XP2
--------------------------------------------------------------
UPDATE Buildings_XP2 SET
							RequiredPower=1
WHERE BuildingType IN (SELECT BuildingType FROM Buildings_JNRUCPPC_PowerTierYields WHERE Tier=3 AND Yield<>'HAPPINESS');

UPDATE Buildings_XP2 SET
							RequiredPower=2, EntertainmentBonusWithPower=1
WHERE BuildingType IN (SELECT BuildingType FROM Buildings_JNRUCPPC_PowerTierYields WHERE Tier=3 AND Yield='HAPPINESS');

INSERT OR IGNORE INTO Buildings_XP2
		(BuildingType,		RequiredPower)
SELECT	BuildingType,		1
FROM Buildings_JNRUCPPC_PowerTierYields WHERE Tier=3 AND Yield<>'HAPPINESS';

INSERT OR IGNORE INTO Buildings_XP2
		(BuildingType,		RequiredPower,	EntertainmentBonusWithPower)
SELECT	BuildingType,		2,				1
FROM Buildings_JNRUCPPC_PowerTierYields WHERE Tier=3 AND Yield='HAPPINESS';
--------------------------------------------------------------

-- RequirementSets
--------------------------------------------------------------
INSERT OR IGNORE INTO RequirementSets
		(RequirementSetId,						RequirementSetType)
VALUES	('PLAYER_HAS_INDUSTRIALIZATION_JNR',	'REQUIREMENTSET_TEST_ALL'),
		('PLAYER_HAS_ELECTRICITY_JNR',			'REQUIREMENTSET_TEST_ALL'),
		('PLAYER_HAS_COMPUTERS_JNR',			'REQUIREMENTSET_TEST_ALL'),
		('PLAYER_IS_AI_IS_INDUSTRIAL_ERA_JNR',	'REQUIREMENTSET_TEST_ALL');
--------------------------------------------------------------

-- RequirementSetRequirements
--------------------------------------------------------------
INSERT OR IGNORE INTO RequirementSetRequirements
		(RequirementSetId,						RequirementId)
VALUES	('PLAYER_HAS_INDUSTRIALIZATION_JNR',	'REQUIRES_PLAYER_HAS_TECH_INDUSTRIALIZATION_JNR'),
		('PLAYER_HAS_ELECTRICITY_JNR',			'REQUIRES_PLAYER_HAS_ELECTRICITYTECHNOLOGY'),
		('PLAYER_HAS_COMPUTERS_JNR',			'REQUIRES_PLAYER_HAS_TECH_COMPUTERS_JNR'),
		('PLAYER_IS_AI_IS_INDUSTRIAL_ERA_JNR',	'REQUIRES_PLAYER_IS_AI'),
		('PLAYER_IS_AI_IS_INDUSTRIAL_ERA_JNR',	'REQUIRES_PLAYER_IS_INDUSTRIAL_ERA_JNR');
--------------------------------------------------------------

-- Modifiers
--------------------------------------------------------------
INSERT OR IGNORE INTO Modifiers
		(ModifierId,								ModifierType,									SubjectRequirementSetId)
VALUES	('JNR_POWER_CONSUMPTION_INDUSTRIALIZATION',	'MODIFIER_SINGLE_CITY_ADJUST_REQUIRED_POWER',	'PLAYER_HAS_INDUSTRIALIZATION_JNR'),
		('JNR_POWER_CONSUMPTION_ELECTRICITY',		'MODIFIER_SINGLE_CITY_ADJUST_REQUIRED_POWER',	'PLAYER_HAS_ELECTRICITY_JNR'),
		('JNR_POWER_CONSUMPTION_COMPUTERS',			'MODIFIER_SINGLE_CITY_ADJUST_REQUIRED_POWER',	'PLAYER_HAS_COMPUTERS_JNR'),
		('JNR_POWER_CONSUMPTION_ATOMIC_TECH',		'MODIFIER_SINGLE_CITY_ADJUST_REQUIRED_POWER',	'PLAYER_IS_ATOMIC_ERA_TECH_JNR'),
		('JNR_POWER_CONSUMPTION_INFORMATION_TECH',	'MODIFIER_SINGLE_CITY_ADJUST_REQUIRED_POWER',	'PLAYER_IS_INFORMATION_ERA_TECH_JNR'),
		('JNR_POWER_CONSUMPTION_FUTURE_TECH',		'MODIFIER_SINGLE_CITY_ADJUST_REQUIRED_POWER',	'PLAYER_IS_FUTURE_ERA_TECH_JNR'),
		('JNR_POWER_CONSUMPTION_AI_FREE_POWER',		'MODIFIER_PLAYER_CITIES_ADJUST_FREE_POWER',		'PLAYER_IS_AI_IS_INDUSTRIAL_ERA_JNR');
--------------------------------------------------------------

-- ModifierArguments
--------------------------------------------------------------
INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,								Name,			Value)
VALUES	('JNR_POWER_CONSUMPTION_INDUSTRIALIZATION',	'Amount',		1),
		('JNR_POWER_CONSUMPTION_ELECTRICITY',		'Amount',		1),	
		('JNR_POWER_CONSUMPTION_COMPUTERS',			'Amount',		1),	
		('JNR_POWER_CONSUMPTION_ATOMIC_TECH',		'Amount',		1),	
		('JNR_POWER_CONSUMPTION_INFORMATION_TECH',	'Amount',		1),	
		('JNR_POWER_CONSUMPTION_FUTURE_TECH',		'Amount',		1),
		('JNR_POWER_CONSUMPTION_AI_FREE_POWER',		'Amount',		5),
		('JNR_POWER_CONSUMPTION_AI_FREE_POWER',		'SourceType',	'FREE_POWER_SOURCE_MISC');
--------------------------------------------------------------

-- BuildingModifiers
--------------------------------------------------------------
INSERT OR IGNORE INTO BuildingModifiers
		(BuildingType,	ModifierId)
SELECT	 BuildingType,	'JNR_POWER_CONSUMPTION_ELECTRICITY'			FROM Buildings_JNRUCPPC_PowerTierYields WHERE Tier=2;

INSERT OR IGNORE INTO BuildingModifiers
		(BuildingType,	ModifierId)
SELECT	 BuildingType,	'JNR_POWER_CONSUMPTION_ATOMIC_TECH'			FROM Buildings_JNRUCPPC_PowerTierYields WHERE Tier=3 AND Yield<>'HAPPINESS';

INSERT OR IGNORE INTO BuildingModifiers
		(BuildingType,	ModifierId)
SELECT	 BuildingType,	'JNR_POWER_CONSUMPTION_INFORMATION_TECH'	FROM Buildings_JNRUCPPC_PowerTierYields WHERE Tier=3;

INSERT OR IGNORE INTO BuildingModifiers
		(BuildingType,	ModifierId)
SELECT	 BuildingType,	'JNR_POWER_CONSUMPTION_FUTURE_TECH'			FROM Buildings_JNRUCPPC_PowerTierYields WHERE Tier=3;
--------------------------------------------------------------

-- DistrictModifiers
--------------------------------------------------------------
INSERT OR IGNORE INTO DistrictModifiers
		(DistrictType,					ModifierId)
VALUES	('DISTRICT_CITY_CENTER',		'JNR_POWER_CONSUMPTION_INDUSTRIALIZATION'),
		('DISTRICT_CITY_CENTER',		'JNR_POWER_CONSUMPTION_ELECTRICITY'),
		('DISTRICT_AQUEDUCT',			'JNR_POWER_CONSUMPTION_COMPUTERS'),
		('DISTRICT_NEIGHBORHOOD',		'JNR_POWER_CONSUMPTION_COMPUTERS');

INSERT OR IGNORE INTO DistrictModifiers
		(DistrictType,					ModifierId)
SELECT	 CivUniqueDistrictType,			'JNR_POWER_CONSUMPTION_ELECTRICITY'			FROM DistrictReplaces WHERE ReplacesDistrictType='DISTRICT_AQUEDUCT';

INSERT OR IGNORE INTO DistrictModifiers
		(DistrictType,					ModifierId)
SELECT	 CivUniqueDistrictType,			'JNR_POWER_CONSUMPTION_ELECTRICITY'			FROM DistrictReplaces WHERE ReplacesDistrictType='DISTRICT_NEIGHBORHOOD';
--------------------------------------------------------------

-- TraitModifiers
--------------------------------------------------------------
INSERT OR IGNORE INTO TraitModifiers
		(TraitType,					ModifierId)
VALUES	('TRAIT_LEADER_MAJOR_CIV',	'JNR_POWER_CONSUMPTION_AI_FREE_POWER'),
		('MINOR_CIV_DEFAULT_TRAIT',	'JNR_POWER_CONSUMPTION_AI_FREE_POWER');
--------------------------------------------------------------