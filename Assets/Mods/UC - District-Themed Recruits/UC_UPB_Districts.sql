-- UC_UPB_Districts
-- Author: JNR
--------------------------------------------------------------

-- DistrictModifiers
--------------------------------------------------------------
INSERT OR REPLACE INTO DistrictModifiers
		(DistrictType,	ModifierId)
VALUES	('DISTRICT_CITY_CENTER',			'CITY_CENTER_JNR_UPB_SETTLER'),
		('DISTRICT_CAMPUS',					'CAMPUS_JNR_UPB_SUPPORT'),
		('DISTRICT_HOLY_SITE',				'HOLY_SITE_JNR_UPB_RECON'),
		('DISTRICT_ENCAMPMENT',				'ENCAMPMENT_JNR_UPB_RANGED'),
		('DISTRICT_ENCAMPMENT',				'ENCAMPMENT_JNR_UPB_ANTI_CAVALRY'),
		('DISTRICT_COMMERCIAL_HUB',			'COMMERCIAL_HUB_JNR_UPB_LIGHT_CAVALRY'),
		('DISTRICT_ENTERTAINMENT_COMPLEX',	'ENTERTAINMENT_COMPLEX_JNR_UPB_HEAVY_CAVALRY'),
		('DISTRICT_THEATER',				'THEATER_JNR_UPB_MELEE'),
		('DISTRICT_HARBOR',					'HARBOR_JNR_UPB_TRADER'),
		('DISTRICT_INDUSTRIAL_ZONE',		'INDUSTRIAL_ZONE_JNR_UPB_SIEGE'),
		('DISTRICT_AQUEDUCT',				'AQUEDUCT_JNR_UPB_BUILDER');
-- DLC
INSERT OR REPLACE INTO DistrictModifiers
		(DistrictType,			ModifierId)
SELECT	'DISTRICT_GOVERNMENT',	'GOVERNMENT_JNR_UPB_SPY'	FROM Districts	WHERE DistrictType='DISTRICT_GOVERNMENT';

INSERT OR REPLACE INTO DistrictModifiers
		(DistrictType,			ModifierId)
SELECT	'DISTRICT_SPACEPORT',	'SPACEPORT_JNR_UPB_GDR'		FROM Units		WHERE UnitType='UNIT_GIANT_DEATH_ROBOT';

-- Mod Support - Satrap's Court by P0kiehl
INSERT OR REPLACE INTO DistrictModifiers
		(DistrictType,					ModifierId)
SELECT	'POK_DISTRICT_SATRAPS_COURT',	'GOVERNMENT_JNR_UPB_SPY'	FROM Districts	WHERE DistrictType='POK_DISTRICT_SATRAPS_COURT';

-- Uniques
INSERT OR REPLACE INTO DistrictModifiers
		(DistrictType,				ModifierId)
SELECT	a.CivUniqueDistrictType,	'CITY_CENTER_JNR_UPB_SETTLER'					FROM DistrictReplaces a WHERE a.ReplacesDistrictType='DISTRICT_CITY_CENTER';

INSERT OR REPLACE INTO DistrictModifiers
		(DistrictType,				ModifierId)
SELECT	a.CivUniqueDistrictType,	'CAMPUS_JNR_UPB_SUPPORT'						FROM DistrictReplaces a WHERE a.ReplacesDistrictType='DISTRICT_CAMPUS';

INSERT OR REPLACE INTO DistrictModifiers
		(DistrictType,				ModifierId)
SELECT	a.CivUniqueDistrictType,	'HOLY_SITE_JNR_UPB_RECON'						FROM DistrictReplaces a WHERE a.ReplacesDistrictType='DISTRICT_HOLY_SITE';

INSERT OR REPLACE INTO DistrictModifiers
		(DistrictType,				ModifierId)
SELECT	a.CivUniqueDistrictType,	'ENCAMPMENT_JNR_UPB_RANGED'						FROM DistrictReplaces a WHERE a.ReplacesDistrictType='DISTRICT_ENCAMPMENT';

INSERT OR REPLACE INTO DistrictModifiers
		(DistrictType,				ModifierId)
SELECT	a.CivUniqueDistrictType,	'ENCAMPMENT_JNR_UPB_ANTI_CAVALRY'				FROM DistrictReplaces a WHERE a.ReplacesDistrictType='DISTRICT_ENCAMPMENT';

INSERT OR REPLACE INTO DistrictModifiers
		(DistrictType,				ModifierId)
SELECT	a.CivUniqueDistrictType,	'COMMERCIAL_HUB_JNR_UPB_LIGHT_CAVALRY'			FROM DistrictReplaces a WHERE a.ReplacesDistrictType='DISTRICT_COMMERCIAL_HUB';

INSERT OR REPLACE INTO DistrictModifiers
		(DistrictType,				ModifierId)
SELECT	a.CivUniqueDistrictType,	'ENTERTAINMENT_COMPLEX_JNR_UPB_HEAVY_CAVALRY'	FROM DistrictReplaces a WHERE a.ReplacesDistrictType='DISTRICT_ENTERTAINMENT_COMPLEX';

INSERT OR REPLACE INTO DistrictModifiers
		(DistrictType,				ModifierId)
SELECT	a.CivUniqueDistrictType,	'THEATER_JNR_UPB_MELEE'							FROM DistrictReplaces a WHERE a.ReplacesDistrictType='DISTRICT_THEATER';

INSERT OR REPLACE INTO DistrictModifiers
		(DistrictType,				ModifierId)
SELECT	a.CivUniqueDistrictType,	'HARBOR_JNR_UPB_TRADER'							FROM DistrictReplaces a WHERE a.ReplacesDistrictType='DISTRICT_HARBOR';

INSERT OR REPLACE INTO DistrictModifiers
		(DistrictType,				ModifierId)
SELECT	a.CivUniqueDistrictType,	'INDUSTRIAL_ZONE_JNR_UPB_SIEGE'					FROM DistrictReplaces a WHERE a.ReplacesDistrictType='DISTRICT_INDUSTRIAL_ZONE';

INSERT OR REPLACE INTO DistrictModifiers
		(DistrictType,				ModifierId)
SELECT	a.CivUniqueDistrictType,	'AQUEDUCT_JNR_UPB_BUILDER'						FROM DistrictReplaces a WHERE a.ReplacesDistrictType='DISTRICT_AQUEDUCT';

INSERT OR REPLACE INTO DistrictModifiers
		(DistrictType,				ModifierId)
SELECT	a.CivUniqueDistrictType,	'GOVERNMENT_JNR_UPB_SPY'						FROM DistrictReplaces a WHERE a.ReplacesDistrictType='DISTRICT_GOVERNMENT';

INSERT OR REPLACE INTO DistrictModifiers
		(DistrictType,				ModifierId)
SELECT	a.CivUniqueDistrictType,	'SPACEPORT_JNR_UPB_GDR'							FROM DistrictReplaces a WHERE a.ReplacesDistrictType='DISTRICT_SPACEPORT';
--------------------------------------------------------------