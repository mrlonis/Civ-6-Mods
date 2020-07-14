-- UC_CMP_Districts
-- Author: JNR
--------------------------------------------------------------

-- Districts
--------------------------------------------------------------
UPDATE Districts SET Description='LOC_DISTRICT_OBSERVATORY_DESCRIPTION_JNR_UC'	WHERE DistrictType='DISTRICT_OBSERVATORY';
--------------------------------------------------------------

-- Adjacency_YieldChanges
--------------------------------------------------------------
UPDATE Adjacency_YieldChanges SET YieldChange=1	WHERE ID='Geothermal_Science';
UPDATE Adjacency_YieldChanges SET YieldChange=1	WHERE ID='Reef_Science';
UPDATE Adjacency_YieldChanges SET YieldChange=1	WHERE ID='Plantation_Science';

INSERT OR IGNORE INTO Adjacency_YieldChanges
		(ID,									Description,										YieldType,			YieldChange,	TilesRequired,	AdjacentFeature,					AdjacentDistrict,						AdjacentResourceClass)
VALUES	('JNR_UC_Floodpains_Grass_Science',		'LOC_DISTRICT_JNR_UC_Floodpains_Grass_Science',		'YIELD_SCIENCE',	1,				2,				'FEATURE_FLOODPLAINS_GRASSLAND',	NULL,									'NO_RESOURCECLASS'),
		('JNR_UC_Floodpains_Plains_Science',	'LOC_DISTRICT_JNR_UC_Floodpains_Plains_Science',	'YIELD_SCIENCE',	1,				2,				'FEATURE_FLOODPLAINS_PLAINS',		NULL,									'NO_RESOURCECLASS'),
		('JNR_UC_Floodpains_Desert_Science',	'LOC_DISTRICT_JNR_UC_Floodpains_Desert_Science',	'YIELD_SCIENCE',	1,				2,				'FEATURE_FLOODPLAINS',				NULL,									'NO_RESOURCECLASS'),
		('JNR_UC_Spaceport_Science',			'LOC_DISTRICT_JNR_UC_Spaceport_Science',			'YIELD_SCIENCE',	2,				1,				NULL,								'DISTRICT_SPACEPORT',					'NO_RESOURCECLASS'),
		('JNR_UC_Water_Park_Science',			'LOC_DISTRICT_JNR_UC_Water_Park_Science',			'YIELD_SCIENCE',	1,				1,				NULL,								'DISTRICT_WATER_ENTERTAINMENT_COMPLEX',	'NO_RESOURCECLASS'),
		('JNR_UC_Water_Park_Carnival_Science',	'LOC_DISTRICT_JNR_UC_Water_Park_Carnival_Science',	'YIELD_SCIENCE',	1,				1,				NULL,								'DISTRICT_WATER_STREET_CARNIVAL',		'NO_RESOURCECLASS'),
		('JNR_UC_Luxury_Science',				'LOC_DISTRICT_JNR_UC_Luxury_Science',				'YIELD_SCIENCE',	1,				1,				NULL,								NULL,									'RESOURCECLASS_LUXURY');
--------------------------------------------------------------

-- District_Adjacencies
--------------------------------------------------------------
INSERT OR IGNORE INTO District_Adjacencies
		(DistrictType,				YieldChangeId)
VALUES	('DISTRICT_CAMPUS',			'JNR_UC_Floodpains_Grass_Science'),
		('DISTRICT_CAMPUS',			'JNR_UC_Floodpains_Plains_Science'),
		('DISTRICT_CAMPUS',			'JNR_UC_Floodpains_Desert_Science'),
		('DISTRICT_CAMPUS',			'JNR_UC_Spaceport_Science'),
		('DISTRICT_CAMPUS',			'JNR_UC_Water_Park_Science'),
		('DISTRICT_CAMPUS',			'JNR_UC_Water_Park_Carnival_Science');
		
INSERT OR IGNORE INTO District_Adjacencies
		(DistrictType,				YieldChangeId)
SELECT	DistrictType,				'JNR_UC_Spaceport_Science'
FROM	Districts
WHERE	DistrictType='DISTRICT_SEOWON';

INSERT OR IGNORE INTO District_Adjacencies
		(DistrictType,				YieldChangeId)
SELECT	DistrictType,				'JNR_UC_Spaceport_Science'
FROM	Districts
WHERE	DistrictType='DISTRICT_OBSERVATORY';

INSERT OR IGNORE INTO District_Adjacencies
		(DistrictType,				YieldChangeId)
SELECT	DistrictType,				'JNR_UC_Luxury_Science'
FROM	Districts
WHERE	DistrictType='DISTRICT_OBSERVATORY';
--------------------------------------------------------------