-- UC_PPC_Power_YieldsSCIENCE_YIELD
-- Author: JNR
--------------------------------------------------------------

-- Building_YieldChangesBonusWithPower
--------------------------------------------------------------
DELETE FROM Building_YieldChangesBonusWithPower WHERE BuildingType IN (SELECT BuildingType FROM Buildings_JNRUCPPC_PowerTierYields WHERE BuildingType IS NOT NULL);

INSERT OR IGNORE INTO Building_YieldChangesBonusWithPower
		(BuildingType,	YieldType,	YieldChange)
SELECT	BuildingType,	Yield,		2
FROM Buildings_JNRUCPPC_PowerTierYields WHERE Tier=3 AND Yield<>'HAPPINESS';

UPDATE Building_YieldChangesBonusWithPower SET YieldChange=3 WHERE YieldType='YIELD_GOLD' AND BuildingType IN (SELECT BuildingType FROM Buildings_JNRUCPPC_PowerTierYields WHERE BuildingType IS NOT NULL);

UPDATE Building_YieldChangesBonusWithPower SET YieldChange=3 WHERE BuildingType='BUILDING_ELECTRONICS_FACTORY';
--------------------------------------------------------------

-- RequirementSets
--------------------------------------------------------------
INSERT OR IGNORE INTO RequirementSets
		(RequirementSetId,								RequirementSetType)
VALUES	('PLAYER_HAS_ELECTRICITY_IN_POWERED_CITY_JNR',	'REQUIREMENTSET_TEST_ALL'),
		('PLAYER_HAS_COMPUTERS_IN_POWERED_CITY_JNR',	'REQUIREMENTSET_TEST_ALL');
--------------------------------------------------------------

-- RequirementSetRequirements
--------------------------------------------------------------
INSERT OR IGNORE INTO RequirementSetRequirements
		(RequirementSetId,								RequirementId)
VALUES	('PLAYER_HAS_ELECTRICITY_IN_POWERED_CITY_JNR',	'REQUIRES_PLAYER_HAS_ELECTRICITYTECHNOLOGY'),
		('PLAYER_HAS_ELECTRICITY_IN_POWERED_CITY_JNR',	'REQUIRES_CITY_IS_POWERED'),
		('PLAYER_HAS_COMPUTERS_IN_POWERED_CITY_JNR',	'REQUIRES_PLAYER_HAS_TECH_COMPUTERS_JNR'),
		('PLAYER_HAS_COMPUTERS_IN_POWERED_CITY_JNR',	'REQUIRES_CITY_IS_POWERED');
--------------------------------------------------------------

-- Modifiers
--------------------------------------------------------------
INSERT OR IGNORE INTO Modifiers
		(ModifierId,									ModifierType,													SubjectRequirementSetId)
VALUES	('JNR_POWER_YIELD_SCIENCE_ATOMIC_TECH',			'MODIFIER_PLAYER_CITIES_ADJUST_YIELD_FROM_POWERED_BUILDINGS',	'PLAYER_IS_ATOMIC_ERA_TECH_JNR'),
		('JNR_POWER_YIELD_SCIENCE_INFORMATION_TECH',	'MODIFIER_PLAYER_CITIES_ADJUST_YIELD_FROM_POWERED_BUILDINGS',	'PLAYER_IS_INFORMATION_ERA_TECH_JNR'),
		('JNR_POWER_YIELD_SCIENCE_FUTURE_TECH',			'MODIFIER_PLAYER_CITIES_ADJUST_YIELD_FROM_POWERED_BUILDINGS',	'PLAYER_IS_FUTURE_ERA_TECH_JNR'),
		('JNR_POWER_YIELD_CULTURE_ATOMIC_TECH',			'MODIFIER_PLAYER_CITIES_ADJUST_YIELD_FROM_POWERED_BUILDINGS',	'PLAYER_IS_ATOMIC_ERA_TECH_JNR'),
		('JNR_POWER_YIELD_CULTURE_INFORMATION_TECH',	'MODIFIER_PLAYER_CITIES_ADJUST_YIELD_FROM_POWERED_BUILDINGS',	'PLAYER_IS_INFORMATION_ERA_TECH_JNR'),
		('JNR_POWER_YIELD_CULTURE_FUTURE_TECH',			'MODIFIER_PLAYER_CITIES_ADJUST_YIELD_FROM_POWERED_BUILDINGS',	'PLAYER_IS_FUTURE_ERA_TECH_JNR'),
		('JNR_POWER_YIELD_GOLD_ATOMIC_TECH',			'MODIFIER_PLAYER_CITIES_ADJUST_YIELD_FROM_POWERED_BUILDINGS',	'PLAYER_IS_ATOMIC_ERA_TECH_JNR'),
		('JNR_POWER_YIELD_GOLD_INFORMATION_TECH',		'MODIFIER_PLAYER_CITIES_ADJUST_YIELD_FROM_POWERED_BUILDINGS',	'PLAYER_IS_INFORMATION_ERA_TECH_JNR'),
		('JNR_POWER_YIELD_GOLD_FUTURE_TECH',			'MODIFIER_PLAYER_CITIES_ADJUST_YIELD_FROM_POWERED_BUILDINGS',	'PLAYER_IS_FUTURE_ERA_TECH_JNR'),
		('JNR_POWER_YIELD_PRODUCTION_ATOMIC_TECH',		'MODIFIER_PLAYER_CITIES_ADJUST_YIELD_FROM_POWERED_BUILDINGS',	'PLAYER_IS_ATOMIC_ERA_TECH_JNR'),
		('JNR_POWER_YIELD_PRODUCTION_INFORMATION_TECH',	'MODIFIER_PLAYER_CITIES_ADJUST_YIELD_FROM_POWERED_BUILDINGS',	'PLAYER_IS_INFORMATION_ERA_TECH_JNR'),
		('JNR_POWER_YIELD_PRODUCTION_FUTURE_TECH',		'MODIFIER_PLAYER_CITIES_ADJUST_YIELD_FROM_POWERED_BUILDINGS',	'PLAYER_IS_FUTURE_ERA_TECH_JNR'),
		('JNR_POWER_YIELD_PRODUCTION_NEIGHBORHOOD',		'MODIFIER_PLAYER_DISTRICT_ADJUST_YIELD_CHANGE',					'PLAYER_HAS_COMPUTERS_IN_POWERED_CITY_JNR');

INSERT OR IGNORE INTO Modifiers
		(ModifierId,												ModifierType,										SubjectRequirementSetId)
SELECT	 'JNR_POWER_' || Yield || '_ELECTRICITY_' || BuildingType,	'MODIFIER_BUILDING_YIELD_CHANGE',					'PLAYER_HAS_ELECTRICITY_IN_POWERED_CITY_JNR'
FROM Buildings_JNRUCPPC_PowerTierYields WHERE Tier=2 AND Yield<>'HAPPINESS';
--------------------------------------------------------------

-- ModifierArguments
--------------------------------------------------------------
INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,										Name,				Value)
VALUES	('JNR_POWER_YIELD_SCIENCE_ATOMIC_TECH',				'YieldType',		'YIELD_SCIENCE'),
		('JNR_POWER_YIELD_SCIENCE_INFORMATION_TECH',		'YieldType',		'YIELD_SCIENCE'),
		('JNR_POWER_YIELD_SCIENCE_FUTURE_TECH',				'YieldType',		'YIELD_SCIENCE'),
		('JNR_POWER_YIELD_CULTURE_ATOMIC_TECH',				'YieldType',		'YIELD_CULTURE'),
		('JNR_POWER_YIELD_CULTURE_INFORMATION_TECH',		'YieldType',		'YIELD_CULTURE'),
		('JNR_POWER_YIELD_CULTURE_FUTURE_TECH',				'YieldType',		'YIELD_CULTURE'),
		('JNR_POWER_YIELD_GOLD_ATOMIC_TECH',				'YieldType',		'YIELD_GOLD'),
		('JNR_POWER_YIELD_GOLD_INFORMATION_TECH',			'YieldType',		'YIELD_GOLD'),
		('JNR_POWER_YIELD_GOLD_FUTURE_TECH',				'YieldType',		'YIELD_GOLD'),
		('JNR_POWER_YIELD_PRODUCTION_ATOMIC_TECH',			'YieldType',		'YIELD_PRODUCTION'),
		('JNR_POWER_YIELD_PRODUCTION_INFORMATION_TECH',		'YieldType',		'YIELD_PRODUCTION'),
		('JNR_POWER_YIELD_PRODUCTION_FUTURE_TECH',			'YieldType',		'YIELD_PRODUCTION'),
		('JNR_POWER_YIELD_PRODUCTION_NEIGHBORHOOD',			'YieldType',		'YIELD_PRODUCTION'),
		('JNR_POWER_YIELD_SCIENCE_ATOMIC_TECH',				'Amount',			2),
		('JNR_POWER_YIELD_SCIENCE_INFORMATION_TECH',		'Amount',			2),
		('JNR_POWER_YIELD_SCIENCE_FUTURE_TECH',				'Amount',			2),
		('JNR_POWER_YIELD_CULTURE_ATOMIC_TECH',				'Amount',			2),
		('JNR_POWER_YIELD_CULTURE_INFORMATION_TECH',		'Amount',			2),
		('JNR_POWER_YIELD_CULTURE_FUTURE_TECH',				'Amount',			2),
		('JNR_POWER_YIELD_GOLD_ATOMIC_TECH',				'Amount',			3),
		('JNR_POWER_YIELD_GOLD_INFORMATION_TECH',			'Amount',			3),
		('JNR_POWER_YIELD_GOLD_FUTURE_TECH',				'Amount',			3),
		('JNR_POWER_YIELD_PRODUCTION_ATOMIC_TECH',			'Amount',			1),
		('JNR_POWER_YIELD_PRODUCTION_INFORMATION_TECH',		'Amount',			1),
		('JNR_POWER_YIELD_PRODUCTION_FUTURE_TECH',			'Amount',			1),
		('JNR_POWER_YIELD_PRODUCTION_NEIGHBORHOOD',			'Amount',			2);
		
INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,												Name,			Value)
SELECT	 'JNR_POWER_' || Yield || '_ELECTRICITY_' || BuildingType,	'YieldType',	Yield
FROM Buildings_JNRUCPPC_PowerTierYields WHERE Tier=2				AND Yield<>'HAPPINESS';

INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,												Name,			Value)
SELECT	 'JNR_POWER_' || Yield || '_ELECTRICITY_' || BuildingType,	'BuildingType',	BuildingType
FROM Buildings_JNRUCPPC_PowerTierYields WHERE Tier=2				AND Yield<>'HAPPINESS';

INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,												Name,			Value)
SELECT	 'JNR_POWER_' || Yield || '_ELECTRICITY_' || BuildingType,	'Amount',		2
FROM Buildings_JNRUCPPC_PowerTierYields WHERE Tier=2				AND Yield='YIELD_SCIENCE';

INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,												Name,			Value)
SELECT	 'JNR_POWER_' || Yield || '_ELECTRICITY_' || BuildingType,	'Amount',		2
FROM Buildings_JNRUCPPC_PowerTierYields WHERE Tier=2				AND Yield='YIELD_CULTURE';

INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,												Name,			Value)
SELECT	 'JNR_POWER_' || Yield || '_ELECTRICITY_' || BuildingType,	'Amount',		3
FROM Buildings_JNRUCPPC_PowerTierYields WHERE Tier=2				AND Yield='YIELD_GOLD';

INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,												Name,			Value)
SELECT	 'JNR_POWER_' || Yield || '_ELECTRICITY_' || BuildingType,	'Amount',		2
FROM Buildings_JNRUCPPC_PowerTierYields WHERE Tier=2				AND Yield='YIELD_PRODUCTION';
--------------------------------------------------------------

-- BuildingModifiers
--------------------------------------------------------------
INSERT OR IGNORE INTO BuildingModifiers
		(ModifierId,												BuildingType)
SELECT	 'JNR_POWER_' || Yield || '_ELECTRICITY_' || BuildingType,	BuildingType
FROM Buildings_JNRUCPPC_PowerTierYields WHERE Tier=2 AND Yield<>'HAPPINESS';
--------------------------------------------------------------

-- TraitModifiers
--------------------------------------------------------------
INSERT OR IGNORE INTO TraitModifiers
		(TraitType,					ModifierId)
VALUES	('TRAIT_LEADER_MAJOR_CIV',	'JNR_POWER_YIELD_SCIENCE_ATOMIC_TECH'),
		('TRAIT_LEADER_MAJOR_CIV',	'JNR_POWER_YIELD_SCIENCE_INFORMATION_TECH'),
		('TRAIT_LEADER_MAJOR_CIV',	'JNR_POWER_YIELD_SCIENCE_FUTURE_TECH'),
		('TRAIT_LEADER_MAJOR_CIV',	'JNR_POWER_YIELD_CULTURE_ATOMIC_TECH'),
		('TRAIT_LEADER_MAJOR_CIV',	'JNR_POWER_YIELD_CULTURE_INFORMATION_TECH'),
		('TRAIT_LEADER_MAJOR_CIV',	'JNR_POWER_YIELD_CULTURE_FUTURE_TECH'),
		('TRAIT_LEADER_MAJOR_CIV',	'JNR_POWER_YIELD_GOLD_ATOMIC_TECH'),
		('TRAIT_LEADER_MAJOR_CIV',	'JNR_POWER_YIELD_GOLD_INFORMATION_TECH'),
		('TRAIT_LEADER_MAJOR_CIV',	'JNR_POWER_YIELD_GOLD_FUTURE_TECH'),
		('TRAIT_LEADER_MAJOR_CIV',	'JNR_POWER_YIELD_PRODUCTION_ATOMIC_TECH'),
		('TRAIT_LEADER_MAJOR_CIV',	'JNR_POWER_YIELD_PRODUCTION_INFORMATION_TECH'),
		('TRAIT_LEADER_MAJOR_CIV',	'JNR_POWER_YIELD_PRODUCTION_FUTURE_TECH'),
		('TRAIT_LEADER_MAJOR_CIV',	'JNR_POWER_YIELD_PRODUCTION_FUTURE_TECH'),
		('MINOR_CIV_DEFAULT_TRAIT',	'JNR_POWER_YIELD_SCIENCE_ATOMIC_TECH'),
		('MINOR_CIV_DEFAULT_TRAIT',	'JNR_POWER_YIELD_SCIENCE_INFORMATION_TECH'),
		('MINOR_CIV_DEFAULT_TRAIT',	'JNR_POWER_YIELD_SCIENCE_FUTURE_TECH'),
		('MINOR_CIV_DEFAULT_TRAIT',	'JNR_POWER_YIELD_CULTURE_ATOMIC_TECH'),
		('MINOR_CIV_DEFAULT_TRAIT',	'JNR_POWER_YIELD_CULTURE_INFORMATION_TECH'),
		('MINOR_CIV_DEFAULT_TRAIT',	'JNR_POWER_YIELD_CULTURE_FUTURE_TECH'),
		('MINOR_CIV_DEFAULT_TRAIT',	'JNR_POWER_YIELD_GOLD_ATOMIC_TECH'),
		('MINOR_CIV_DEFAULT_TRAIT',	'JNR_POWER_YIELD_GOLD_INFORMATION_TECH'),
		('MINOR_CIV_DEFAULT_TRAIT',	'JNR_POWER_YIELD_GOLD_FUTURE_TECH'),
		('MINOR_CIV_DEFAULT_TRAIT',	'JNR_POWER_YIELD_PRODUCTION_ATOMIC_TECH'),
		('MINOR_CIV_DEFAULT_TRAIT',	'JNR_POWER_YIELD_PRODUCTION_INFORMATION_TECH'),
		('MINOR_CIV_DEFAULT_TRAIT',	'JNR_POWER_YIELD_PRODUCTION_FUTURE_TECH'),
		('MINOR_CIV_DEFAULT_TRAIT',	'JNR_POWER_YIELD_PRODUCTION_FUTURE_TECH');
--------------------------------------------------------------

-- DistrictModifiers
--------------------------------------------------------------
INSERT OR IGNORE INTO DistrictModifiers
		(DistrictType,				ModifierId)
VALUES	('DISTRICT_AQUEDUCT',		'JNR_POWER_YIELD_PRODUCTION_NEIGHBORHOOD'),
		('DISTRICT_NEIGHBORHOOD',	'JNR_POWER_YIELD_PRODUCTION_NEIGHBORHOOD');

INSERT OR IGNORE INTO DistrictModifiers
		(DistrictType,				ModifierId)
SELECT	 CivUniqueDistrictType,		'JNR_POWER_YIELD_PRODUCTION_NEIGHBORHOOD'	FROM DistrictReplaces WHERE ReplacesDistrictType='DISTRICT_AQUEDUCT';

INSERT OR IGNORE INTO DistrictModifiers
		(DistrictType,				ModifierId)
SELECT	 CivUniqueDistrictType,		'JNR_POWER_YIELD_PRODUCTION_NEIGHBORHOOD'	FROM DistrictReplaces WHERE ReplacesDistrictType='DISTRICT_NEIGHBORHOOD';
--------------------------------------------------------------