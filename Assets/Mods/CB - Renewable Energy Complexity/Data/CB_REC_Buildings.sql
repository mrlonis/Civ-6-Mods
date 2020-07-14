-- CB_REC_Buildings
-- Author: JNR
--------------------------------------------------------------

-- Types
--------------------------------------------------------------
INSERT OR IGNORE INTO Types
		(Type,									Kind)
VALUES	('BUILDING_JNR_RENEWABLE_COLLECTION',	'KIND_BUILDING'),
		('BUILDING_JNR_RENEWABLE_DISTRIBUTION',	'KIND_BUILDING');
--------------------------------------------------------------

-- Buildings
--------------------------------------------------------------
INSERT INTO Buildings
		(BuildingType,							PrereqDistrict,				PrereqTech,				Cost,	Maintenance,	CitizenSlots,	RegionalRange,	PurchaseYield,	AdvisorType,		Name,											Description)
VALUES	('BUILDING_JNR_RENEWABLE_COLLECTION',	'DISTRICT_CITY_CENTER',		'TECH_NANOTECHNOLOGY',	300,	1,				0,				0,				'YIELD_GOLD',	'ADVISOR_GENERIC',	'LOC_BUILDING_JNR_RENEWABLE_COLLECTION_NAME',	'LOC_BUILDING_JNR_RENEWABLE_COLLECTION_DESCRIPTION'),
		('BUILDING_JNR_RENEWABLE_DISTRIBUTION',	'DISTRICT_INDUSTRIAL_ZONE',	'TECH_NANOTECHNOLOGY',	750,	4,				1,				6,				'YIELD_GOLD',	'ADVISOR_GENERIC',	'LOC_BUILDING_JNR_RENEWABLE_DISTRIBUTION_NAME',	'LOC_BUILDING_JNR_RENEWABLE_DISTRIBUTION_DESCRIPTION');

UPDATE Buildings SET Maintenance=2, Description='LOC_BUILDING_HYDROELECTRIC_DAM_DESCRIPTION_JNR_REC' WHERE BuildingType='BUILDING_HYDROELECTRIC_DAM';
--------------------------------------------------------------

-- Buildings_XP2
--------------------------------------------------------------
INSERT OR IGNORE INTO Buildings_XP2
		(BuildingType,							ResourceTypeConvertedToPower)
VALUES	('BUILDING_JNR_RENEWABLE_DISTRIBUTION',	'RESOURCE_JNR_BATTERY_CHARGE');
--------------------------------------------------------------

-- BuildingPrereqs
--------------------------------------------------------------
INSERT OR IGNORE INTO BuildingPrereqs
		(Building,								PrereqBuilding)
VALUES	('BUILDING_JNR_RENEWABLE_DISTRIBUTION',	'BUILDING_FACTORY');
--------------------------------------------------------------

-- MutuallyExclusiveBuildings
--------------------------------------------------------------
INSERT OR IGNORE INTO MutuallyExclusiveBuildings
		(Building,								MutuallyExclusiveBuilding)
VALUES	('BUILDING_JNR_RENEWABLE_DISTRIBUTION',	'BUILDING_COAL_POWER_PLANT'),
		('BUILDING_JNR_RENEWABLE_DISTRIBUTION',	'BUILDING_FOSSIL_FUEL_POWER_PLANT'),
		('BUILDING_JNR_RENEWABLE_DISTRIBUTION',	'BUILDING_POWER_PLANT'),
		('BUILDING_COAL_POWER_PLANT',			'BUILDING_JNR_RENEWABLE_DISTRIBUTION'),
		('BUILDING_FOSSIL_FUEL_POWER_PLANT',	'BUILDING_JNR_RENEWABLE_DISTRIBUTION'),
		('BUILDING_POWER_PLANT',				'BUILDING_JNR_RENEWABLE_DISTRIBUTION');
--------------------------------------------------------------

-- Building_YieldChanges
--------------------------------------------------------------
INSERT OR IGNORE INTO Building_YieldChanges
		(BuildingType,							YieldType,			YieldChange)
VALUES	('BUILDING_HYDROELECTRIC_DAM',			'YIELD_PRODUCTION',	3),
		('BUILDING_JNR_RENEWABLE_DISTRIBUTION',	'YIELD_PRODUCTION',	5),
		('BUILDING_JNR_RENEWABLE_DISTRIBUTION',	'YIELD_SCIENCE',	4),
		('BUILDING_JNR_RENEWABLE_DISTRIBUTION',	'YIELD_CULTURE',	2);
--------------------------------------------------------------

-- ModifierArguments
--------------------------------------------------------------
UPDATE ModifierArguments SET Value=4 WHERE ModifierId='HYDROELECTRIC_DAM_FREE_POWER' AND Name='Amount';
--------------------------------------------------------------

-- Requirements
--------------------------------------------------------------
INSERT OR IGNORE INTO Requirements
		(RequirementId,											RequirementType,					Inverse)
VALUES	('REQUIRES_RENEWABLE_ENERGY_COLLECTION_ACTIVE_JNR',		'REQUIREMENT_CITY_HAS_BUILDING',	0),
		('REQUIRES_RENEWABLE_ENERGY_COLLECTION_INACTIVE_JNR',	'REQUIREMENT_CITY_HAS_BUILDING',	1);
--------------------------------------------------------------

INSERT OR IGNORE INTO RequirementArguments
		(RequirementId,											Name,			Value)
VALUES	('REQUIRES_RENEWABLE_ENERGY_COLLECTION_ACTIVE_JNR',		'BuildingType',	'BUILDING_JNR_RENEWABLE_COLLECTION'),
		('REQUIRES_RENEWABLE_ENERGY_COLLECTION_INACTIVE_JNR',	'BuildingType',	'BUILDING_JNR_RENEWABLE_COLLECTION');
--------------------------------------------------------------