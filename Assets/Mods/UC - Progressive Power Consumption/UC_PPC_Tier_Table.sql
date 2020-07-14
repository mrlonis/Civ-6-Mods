-- UC_PPC_Tier_Table
-- Author: JNR
--------------------------------------------------------------
CREATE TABLE IF NOT EXISTS Buildings_JNRUCPPC_PowerTierYields
	(
	BuildingType TEXT PRIMARY KEY,
	Tier INTEGER,
	Yield TEXT,
	GPP TEXT,
	IsFactory BOOLEAN
	);

-- Base Buildings
INSERT OR IGNORE INTO Buildings_JNRUCPPC_PowerTierYields
		(BuildingType,					Tier,	Yield,				GPP)
VALUES	('BUILDING_WORKSHOP',			2,		'YIELD_PRODUCTION',	'ENGINEER'),
		('BUILDING_ARMORY',				2,		'YIELD_PRODUCTION',	'GENERAL'),
		('BUILDING_BANK',				2,		'YIELD_GOLD',		'MERCHANT'),
		('BUILDING_SHIPYARD',			2,		'YIELD_GOLD',		'ADMIRAL'),
		('BUILDING_UNIVERSITY',			2,		'YIELD_SCIENCE',	'SCIENTIST'),
		('BUILDING_MUSEUM_ART',			2,		'YIELD_CULTURE',	'GWAM'),
		('BUILDING_ZOO',				2,		'HAPPINESS',		'NONE'),
		('BUILDING_AQUARIUM',			2,		'HAPPINESS',		'NONE'),
		('BUILDING_FACTORY',			3,		'YIELD_PRODUCTION',	'ENGINEER'),
		('BUILDING_MILITARY_ACADEMY',	3,		'YIELD_PRODUCTION',	'GENERAL'),
		('BUILDING_STOCK_EXCHANGE',		3,		'YIELD_GOLD',		'MERCHANT'),
		('BUILDING_RESEARCH_LAB',		3,		'YIELD_SCIENCE',	'SCIENTIST'),
		('BUILDING_BROADCAST_CENTER',	3,		'YIELD_CULTURE',	'GWAM'),
		('BUILDING_STADIUM',			3,		'HAPPINESS',		'NONE'),
		('BUILDING_AQUATICS_CENTER',	3,		'HAPPINESS',		'NONE');

-- District Expansion Support: Seaport
INSERT OR IGNORE INTO Buildings_JNRUCPPC_PowerTierYields
		(BuildingType,					Tier,	Yield,				GPP)
SELECT	'BUILDING_SEAPORT',				3,		'YIELD_GOLD',		'ADMIRAL'
FROM	Building_GreatPersonPoints
WHERE	BuildingType='BUILDING_SEAPORT' AND GreatPersonClassType='GREAT_PERSON_CLASS_ADMIRAL';

INSERT OR IGNORE INTO Buildings_JNRUCPPC_PowerTierYields
		(BuildingType,					Tier,	Yield,				GPP)
SELECT	'BUILDING_SEAPORT',				3,		'YIELD_GOLD',		'MERCHANT'
FROM	Building_GreatPersonPoints
WHERE	BuildingType='BUILDING_SEAPORT' AND GreatPersonClassType='GREAT_PERSON_CLASS_MERCHANT';

-- District Expansion Support: Airport
INSERT OR IGNORE INTO Buildings_JNRUCPPC_PowerTierYields
		(BuildingType,					Tier,	Yield,				GPP)
SELECT	'BUILDING_HANGAR',				2,		'YIELD_PRODUCTION',	'GENERAL'
FROM	BuildingPrereqs
WHERE	Building='BUILDING_AIRPORT' AND PrereqBuilding='BUILDING_HANGAR';

INSERT OR IGNORE INTO Buildings_JNRUCPPC_PowerTierYields
		(BuildingType,					Tier,	Yield,				GPP)
SELECT	'BUILDING_HANGAR',				3,		'YIELD_PRODUCTION',	'GENERAL'
FROM	BuildingPrereqs
WHERE	NOT EXISTS (SELECT * FROM BuildingPrereqs WHERE Building='BUILDING_AIRPORT' AND PrereqBuilding='BUILDING_HANGAR');

INSERT OR IGNORE INTO Buildings_JNRUCPPC_PowerTierYields
		(BuildingType,					Tier,	Yield,				GPP)
SELECT	'BUILDING_AIRPORT',				3,		'YIELD_PRODUCTION',	'GENERAL'
FROM	BuildingPrereqs
WHERE	Building='BUILDING_AIRPORT' AND PrereqBuilding='BUILDING_HANGAR';

INSERT OR IGNORE INTO Buildings_JNRUCPPC_PowerTierYields
		(BuildingType,					Tier,	Yield,				GPP)
SELECT	'BUILDING_AIRPORT',				3,		'YIELD_GOLD',		'MERCHANT'
FROM	BuildingPrereqs
WHERE	NOT EXISTS (SELECT * FROM BuildingPrereqs WHERE Building='BUILDING_AIRPORT' AND PrereqBuilding='BUILDING_HANGAR');

-- District Expansion Support: Campus
UPDATE	Buildings_JNRUCPPC_PowerTierYields
SET		BuildingType='BUILDING_JNR_LABORATORY'
WHERE	BuildingType=(SELECT PrereqBuilding FROM BuildingPrereqs WHERE Building='BUILDING_JNR_LABORATORY' AND PrereqBuilding='BUILDING_UNIVERSITY');

-- All Variants of a Tier
INSERT OR IGNORE INTO Buildings_JNRUCPPC_PowerTierYields
		(BuildingType,					Tier,	Yield,		GPP)
SELECT	a.Building,						b.Tier,	b.Yield,	b.GPP
FROM	MutuallyExclusiveBuildings a,	Buildings_JNRUCPPC_PowerTierYields b
WHERE	a.MutuallyExclusiveBuilding=b.BuildingType AND b.BuildingType=a.MutuallyExclusiveBuilding;

-- Divergent building options
UPDATE	Buildings_JNRUCPPC_PowerTierYields	SET	Yield='YIELD_CULTURE'						WHERE BuildingType='BUILDING_MILITARY_ACADEMY';
UPDATE	Buildings_JNRUCPPC_PowerTierYields	SET	Yield='YIELD_PRODUCTION',	GPP='ADMIRAL'	WHERE BuildingType='BUILDING_JNR_NAVAL_BASE';
UPDATE	Buildings_JNRUCPPC_PowerTierYields	SET								GPP='MERCHANT'	WHERE BuildingType='BUILDING_JNR_HAVEN';
UPDATE	Buildings_JNRUCPPC_PowerTierYields	SET								GPP='MERCHANT'	WHERE BuildingType='BUILDING_JNR_CONSULATE';
UPDATE	Buildings_JNRUCPPC_PowerTierYields	SET								GPP='MERCHANT'	WHERE BuildingType='BUILDING_JNR_CRUISE_TERMINAL';

-- Uniques
INSERT OR IGNORE INTO Buildings_JNRUCPPC_PowerTierYields
		(BuildingType,					Tier,	Yield,		GPP)
SELECT	a.CivUniqueBuildingType,		b.Tier,	b.Yield,	b.GPP
FROM	BuildingReplaces a,				Buildings_JNRUCPPC_PowerTierYields b
WHERE	a.ReplacesBuildingType=b.BuildingType AND b.BuildingType=a.ReplacesBuildingType;