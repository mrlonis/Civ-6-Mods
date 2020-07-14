-- UC_PPC_Power_Amenities
-- Author: JNR
--------------------------------------------------------------

-- Requirements
--------------------------------------------------------------
INSERT OR IGNORE INTO Requirements
		(RequirementId,													RequirementType,						Inverse)
VALUES	('REQUIRES_PLAYER_IS_NOT_FUTURE_ERA_TECH_REQUIREMENTSET_JNR',	'REQUIREMENT_REQUIREMENTSET_IS_MET',	1);
--------------------------------------------------------------

-- RequirementArguments
--------------------------------------------------------------
INSERT OR IGNORE INTO RequirementArguments
		(RequirementId,													Name,				Value)
VALUES	('REQUIRES_PLAYER_IS_NOT_FUTURE_ERA_TECH_REQUIREMENTSET_JNR',	'RequirementSetId',	'PLAYER_IS_FUTURE_ERA_TECH_JNR');
--------------------------------------------------------------

-- RequirementSets
--------------------------------------------------------------
INSERT OR IGNORE INTO RequirementSets
		(RequirementSetId,													RequirementSetType)
VALUES	('PLAYER_HAS_ELECTRICITY_NO_FUTURE_ERA_IN_POWERED_CITY_JNR',		'REQUIREMENTSET_TEST_ALL'),
		('PLAYER_IS_INFORMATION_NO_FUTURE_ERA_TECH_IN_POWERED_CITY_JNR',	'REQUIREMENTSET_TEST_ALL'),
		('PLAYER_IS_FUTURE_ERA_TECH_IN_POWERED_CITY_JNR',					'REQUIREMENTSET_TEST_ALL');
--------------------------------------------------------------

-- RequirementSetRequirements
--------------------------------------------------------------
INSERT OR IGNORE INTO RequirementSetRequirements
		(RequirementSetId,													RequirementId)
VALUES	('PLAYER_HAS_ELECTRICITY_NO_FUTURE_ERA_IN_POWERED_CITY_JNR',		'REQUIRES_PLAYER_HAS_ELECTRICITYTECHNOLOGY'),
		('PLAYER_HAS_ELECTRICITY_NO_FUTURE_ERA_IN_POWERED_CITY_JNR',		'REQUIRES_PLAYER_IS_NOT_FUTURE_ERA_TECH_REQUIREMENTSET_JNR'),
		('PLAYER_HAS_ELECTRICITY_NO_FUTURE_ERA_IN_POWERED_CITY_JNR',		'REQUIRES_CITY_IS_POWERED'),
		('PLAYER_IS_INFORMATION_NO_FUTURE_ERA_TECH_IN_POWERED_CITY_JNR',	'REQUIRES_PLAYER_IS_INFORMATION_ERA_TECH_REQUIREMENTSET_JNR'),
		('PLAYER_IS_INFORMATION_NO_FUTURE_ERA_TECH_IN_POWERED_CITY_JNR',	'REQUIRES_PLAYER_IS_NOT_FUTURE_ERA_TECH_REQUIREMENTSET_JNR'),
		('PLAYER_IS_INFORMATION_NO_FUTURE_ERA_TECH_IN_POWERED_CITY_JNR',	'REQUIRES_CITY_IS_POWERED'),
		('PLAYER_IS_FUTURE_ERA_TECH_IN_POWERED_CITY_JNR',					'REQUIRES_PLAYER_IS_FUTURE_ERA_TECH_REQUIREMENTSET_JNR'),
		('PLAYER_IS_FUTURE_ERA_TECH_IN_POWERED_CITY_JNR',					'REQUIRES_CITY_IS_POWERED');
--------------------------------------------------------------

-- Modifiers
--------------------------------------------------------------
INSERT OR IGNORE INTO Modifiers
		(ModifierId,						ModifierType,													SubjectRequirementSetId)
VALUES	('JNR_POWER_AMENITIES_ELECTRICITY',	'MODIFIER_SINGLE_CITY_ADJUST_ENTERTAINMENT',					'PLAYER_HAS_ELECTRICITY_NO_FUTURE_ERA_IN_POWERED_CITY_JNR'),
		('JNR_POWER_AMENITIES_INFORMATION',	'MODIFIER_SINGLE_CITY_ADJUST_ENTERTAINMENT',					'PLAYER_IS_INFORMATION_NO_FUTURE_ERA_TECH_IN_POWERED_CITY_JNR'),
		('JNR_POWER_AMENITIES_FUTURE',		'MODIFIER_PLAYER_DISTRICT_ADJUST_EXTRA_REGIONAL_ENTERTAINMENT',	'PLAYER_IS_FUTURE_ERA_TECH_IN_POWERED_CITY_JNR');
--------------------------------------------------------------

-- ModifierArguments
--------------------------------------------------------------
INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,						Name,		Value)
VALUES	('JNR_POWER_AMENITIES_ELECTRICITY',	'Amount',	1),
		('JNR_POWER_AMENITIES_INFORMATION',	'Amount',	1),
		('JNR_POWER_AMENITIES_FUTURE',		'Amount',	1);
--------------------------------------------------------------

-- BuildingModifiers
--------------------------------------------------------------
INSERT OR IGNORE INTO BuildingModifiers
		(ModifierId,						BuildingType)
SELECT	 'JNR_POWER_AMENITIES_ELECTRICITY',	BuildingType
FROM Buildings_JNRUCPPC_PowerTierYields WHERE Tier=2 AND Yield='HAPPINESS';

INSERT OR IGNORE INTO BuildingModifiers
		(ModifierId,						BuildingType)
SELECT	 'JNR_POWER_AMENITIES_INFORMATION',	BuildingType
FROM Buildings_JNRUCPPC_PowerTierYields WHERE Tier=3 AND Yield='HAPPINESS';
--------------------------------------------------------------

-- DistrictModifiers
--------------------------------------------------------------
INSERT OR IGNORE INTO DistrictModifiers
		(DistrictType,								ModifierId)
VALUES	('DISTRICT_ENTERTAINMENT_COMPLEX',			'JNR_POWER_AMENITIES_FUTURE'),
		('DISTRICT_WATER_ENTERTAINMENT_COMPLEX',	'JNR_POWER_AMENITIES_FUTURE');

INSERT OR IGNORE INTO DistrictModifiers
		(DistrictType,								ModifierId)
SELECT	 CivUniqueDistrictType,						'JNR_POWER_AMENITIES_FUTURE'	FROM DistrictReplaces WHERE ReplacesDistrictType='DISTRICT_ENTERTAINMENT_COMPLEX';

INSERT OR IGNORE INTO DistrictModifiers
		(DistrictType,								ModifierId)
SELECT	 CivUniqueDistrictType,						'JNR_POWER_AMENITIES_FUTURE'	FROM DistrictReplaces WHERE ReplacesDistrictType='DISTRICT_WATER_ENTERTAINMENT_COMPLEX';
--------------------------------------------------------------