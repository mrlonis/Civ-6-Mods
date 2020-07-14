-- CB_REC_Projects
-- Author: JNR
--------------------------------------------------------------

-- Types
--------------------------------------------------------------
INSERT OR IGNORE INTO Types
		(Type,										Kind)
VALUES	('PROJECT_JNR_CONVERT_REACTOR_TO_BATTERY',	'KIND_PROJECT');
--------------------------------------------------------------

-- Projects
--------------------------------------------------------------
INSERT OR IGNORE INTO Projects
		(ProjectType,
		Name,
		ShortName,
		Description,
		PrereqDistrict,
		PrereqTech,
		Cost,
		AdvisorType)
VALUES	('PROJECT_JNR_CONVERT_REACTOR_TO_BATTERY',
		'LOC_PROJECT_JNR_CONVERT_REACTOR_TO_BATTERY',
		'LOC_PROJECT_JNR_CONVERT_REACTOR_TO_BATTERY_SHORT_NAME',
		'LOC_PROJECT_JNR_CONVERT_REACTOR_TO_BATTERY_DESCRIPTION',
		'DISTRICT_INDUSTRIAL_ZONE',
		'TECH_NANOTECHNOLOGY',
		500,
		'ADVISOR_GENERIC');
--------------------------------------------------------------

-- Projects_XP2
--------------------------------------------------------------
INSERT OR IGNORE INTO Projects_XP2
		(ProjectType,								CreateBuilding)
VALUES	('PROJECT_JNR_CONVERT_REACTOR_TO_BATTERY',	'BUILDING_JNR_RENEWABLE_DISTRIBUTION');
--------------------------------------------------------------

-- Project_BuildingCosts
--------------------------------------------------------------
INSERT OR IGNORE INTO Project_BuildingCosts
		(ProjectType,								ConsumedBuildingType)
VALUES	('PROJECT_JNR_CONVERT_REACTOR_TO_BATTERY',	'BUILDING_COAL_POWER_PLANT'),
		('PROJECT_JNR_CONVERT_REACTOR_TO_BATTERY',	'BUILDING_FOSSIL_FUEL_POWER_PLANT'),
		('PROJECT_JNR_CONVERT_REACTOR_TO_BATTERY',	'BUILDING_POWER_PLANT'),
		('PROJECT_CONVERT_REACTOR_TO_COAL',			'BUILDING_JNR_RENEWABLE_DISTRIBUTION'),
		('PROJECT_CONVERT_REACTOR_TO_OIL',			'BUILDING_JNR_RENEWABLE_DISTRIBUTION'),
		('PROJECT_CONVERT_REACTOR_TO_URANIUM',		'BUILDING_JNR_RENEWABLE_DISTRIBUTION');
--------------------------------------------------------------