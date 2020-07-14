-- UC_COM_Districts
-- Author: JNR
--------------------------------------------------------------

-- Districts
--------------------------------------------------------------
UPDATE Districts SET PrereqTech=NULL, PrereqCivic='CIVIC_EARLY_EMPIRE'	WHERE DistrictType='DISTRICT_COMMERCIAL_HUB';
UPDATE Districts SET PrereqTech='TECH_SAILING'							WHERE DistrictType='DISTRICT_HARBOR';

UPDATE Districts SET PrereqTech=NULL, PrereqCivic='CIVIC_EARLY_EMPIRE'	WHERE DistrictType=(SELECT CivUniqueDistrictType FROM DistrictReplaces WHERE ReplacesDistrictType='DISTRICT_COMMERCIAL_HUB');
UPDATE Districts SET PrereqTech='TECH_SAILING'							WHERE DistrictType=(SELECT CivUniqueDistrictType FROM DistrictReplaces WHERE ReplacesDistrictType='DISTRICT_HARBOR');
--------------------------------------------------------------

-- District_GreatPersonPoints
--------------------------------------------------------------
INSERT OR IGNORE INTO District_GreatPersonPoints
		(DistrictType,			GreatPersonClassType,			PointsPerTurn)
VALUES	('DISTRICT_AERODROME',	'GREAT_PERSON_CLASS_ADMIRAL',	1);

DELETE FROM District_GreatPersonPoints WHERE DistrictType='DISTRICT_AERODROME' AND GreatPersonClassType='GREAT_PERSON_CLASS_GENERAL';
--------------------------------------------------------------

-- Adjacency_YieldChanges
--------------------------------------------------------------
-- UPDATE Adjacency_YieldChanges SET TilesRequired=1	WHERE ID='District_Gold';
-- UPDATE Adjacency_YieldChanges SET YieldChange=2		WHERE ID='Government_Gold';

INSERT OR IGNORE INTO Adjacency_YieldChanges
		(ID,						Description,							YieldType,		YieldChange,	AdjacentFeature,	AdjacentImprovement,	AdjacentDistrict,						AdjacentResourceClass)
VALUES	('JNR_UC_Oasis_Gold',		'LOC_DISTRICT_JNR_UC_OASIS_GOLD',		'YIELD_GOLD',	2,				'FEATURE_OASIS',	NULL,					NULL,									'NO_RESOURCECLASS'),
		('JNR_UC_Luxury_Gold',		'LOC_DISTRICT_JNR_UC_LUXURY_GOLD',		'YIELD_GOLD',	1,				NULL,				NULL,					NULL,									'RESOURCECLASS_LUXURY'),
		('JNR_UC_Aerodrome_Gold',	'LOC_DISTRICT_JNR_UC_AERODROME_GOLD',	'YIELD_GOLD',	1,				NULL,				NULL,					'DISTRICT_AERODROME',					'NO_RESOURCECLASS'),
		('JNR_UC_Canal_Gold',		'LOC_DISTRICT_JNR_UC_CANAL_GOLD',		'YIELD_GOLD',	1,				NULL,				NULL,					'DISTRICT_CANAL',						'NO_RESOURCECLASS'),
		('JNR_UC_Fairgrounds_Gold',	'LOC_DISTRICT_JNR_UC_FAIRGROUNDS_GOLD',	'YIELD_GOLD',	1,				NULL,				NULL,					'DISTRICT_ENTERTAINMENT_COMPLEX',		'NO_RESOURCECLASS'),
		('JNR_UC_Water_Park_Gold',	'LOC_DISTRICT_JNR_UC_WATER_PARK_GOLD',	'YIELD_GOLD',	1,				NULL,				NULL,					'DISTRICT_WATER_ENTERTAINMENT_COMPLEX',	'NO_RESOURCECLASS'),
		('JNR_UC_Oil_Well_Gold',	'LOC_DISTRICT_JNR_UC_OIL_WELL_GOLD',	'YIELD_GOLD',	1,				NULL,				'IMPROVEMENT_OIL_WELL',	NULL,									'NO_RESOURCECLASS'),
		('JNR_UC_Seastead_Gold',	'LOC_DISTRICT_JNR_UC_SEASTEAD_GOLD',	'YIELD_GOLD',	1,				NULL,				'IMPROVEMENT_SEASTEAD',	NULL,									'NO_RESOURCECLASS');
--------------------------------------------------------------

-- District_Adjacencies
--------------------------------------------------------------
INSERT OR IGNORE INTO District_Adjacencies
		(DistrictType,				YieldChangeId)
VALUES	('DISTRICT_COMMERCIAL_HUB',	'JNR_UC_Oasis_Gold'),
		('DISTRICT_COMMERCIAL_HUB',	'JNR_UC_Luxury_Gold'),
		('DISTRICT_COMMERCIAL_HUB',	'JNR_UC_Aerodrome_Gold'),
		('DISTRICT_COMMERCIAL_HUB',	'JNR_UC_Canal_Gold'),
		('DISTRICT_COMMERCIAL_HUB',	'JNR_UC_Fairgrounds_Gold'),
		('DISTRICT_HARBOR',			'JNR_UC_Aerodrome_Gold'),
		('DISTRICT_HARBOR',			'JNR_UC_Canal_Gold'),
		('DISTRICT_HARBOR',			'JNR_UC_Water_Park_Gold'),
		('DISTRICT_HARBOR',			'JNR_UC_Oil_Well_Gold'),
		('DISTRICT_HARBOR',			'JNR_UC_Seastead_Gold');

INSERT OR IGNORE INTO District_Adjacencies
		(DistrictType,				YieldChangeId)
SELECT	CivUniqueDistrictType,		'JNR_UC_Oasis_Gold'
FROM	DistrictReplaces
WHERE	ReplacesDistrictType='DISTRICT_COMMERCIAL_HUB';

INSERT OR IGNORE INTO District_Adjacencies
		(DistrictType,				YieldChangeId)
SELECT	CivUniqueDistrictType,		'JNR_UC_Luxury_Gold'
FROM	DistrictReplaces
WHERE	ReplacesDistrictType='DISTRICT_COMMERCIAL_HUB';

INSERT OR IGNORE INTO District_Adjacencies
		(DistrictType,				YieldChangeId)
SELECT	CivUniqueDistrictType,		'JNR_UC_Aerodrome_Gold'
FROM	DistrictReplaces
WHERE	ReplacesDistrictType='DISTRICT_COMMERCIAL_HUB';

INSERT OR IGNORE INTO District_Adjacencies
		(DistrictType,				YieldChangeId)
SELECT	CivUniqueDistrictType,		'JNR_UC_Canal_Gold'
FROM	DistrictReplaces
WHERE	ReplacesDistrictType='DISTRICT_COMMERCIAL_HUB';

INSERT OR IGNORE INTO District_Adjacencies
		(DistrictType,				YieldChangeId)
SELECT	CivUniqueDistrictType,		'JNR_UC_Fairgrounds_Gold'
FROM	DistrictReplaces
WHERE	ReplacesDistrictType='DISTRICT_COMMERCIAL_HUB';

INSERT OR IGNORE INTO District_Adjacencies
		(DistrictType,				YieldChangeId)
SELECT	CivUniqueDistrictType,		'JNR_UC_Aerodrome_Gold'
FROM	DistrictReplaces
WHERE	ReplacesDistrictType='DISTRICT_HARBOR';

INSERT OR IGNORE INTO District_Adjacencies
		(DistrictType,				YieldChangeId)
SELECT	CivUniqueDistrictType,		'JNR_UC_Canal_Gold'
FROM	DistrictReplaces
WHERE	ReplacesDistrictType='DISTRICT_HARBOR';

INSERT OR IGNORE INTO District_Adjacencies
		(DistrictType,				YieldChangeId)
SELECT	CivUniqueDistrictType,		'JNR_UC_Water_Park_Gold'
FROM	DistrictReplaces
WHERE	ReplacesDistrictType='DISTRICT_HARBOR';

INSERT OR IGNORE INTO District_Adjacencies
		(DistrictType,				YieldChangeId)
SELECT	CivUniqueDistrictType,		'JNR_UC_Oil_Well_Gold'
FROM	DistrictReplaces
WHERE	ReplacesDistrictType='DISTRICT_HARBOR';

INSERT OR IGNORE INTO District_Adjacencies
		(DistrictType,				YieldChangeId)
SELECT	CivUniqueDistrictType,		'JNR_UC_Seastead_Gold'
FROM	DistrictReplaces
WHERE	ReplacesDistrictType='DISTRICT_HARBOR';
--------------------------------------------------------------