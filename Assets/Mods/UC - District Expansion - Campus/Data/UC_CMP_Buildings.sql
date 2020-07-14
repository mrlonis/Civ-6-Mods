-- UC_CMP_Buildings
-- Author: JNR
--------------------------------------------------------------

-- Types
--------------------------------------------------------------
INSERT OR IGNORE INTO Types
		(Type,							Kind)
VALUES	('BUILDING_JNR_ACADEMY',		'KIND_BUILDING'),
		('BUILDING_JNR_SCHOOL',			'KIND_BUILDING'),
		('BUILDING_JNR_LABORATORY',		'KIND_BUILDING'),
		('BUILDING_JNR_LIBERAL_ARTS',	'KIND_BUILDING'),
		('BUILDING_JNR_EDUCATION',		'KIND_BUILDING');
--------------------------------------------------------------

-- Buildings
--------------------------------------------------------------
INSERT INTO Buildings
		(BuildingType,					PrereqDistrict,		PrereqTech,					Cost,	Maintenance,	CitizenSlots,	Housing,	PurchaseYield,	AdvisorType,			Name,									Description)
VALUES	('BUILDING_JNR_ACADEMY',		'DISTRICT_CAMPUS',	'TECH_WRITING',				90,		1,				2,				0,			'YIELD_GOLD',	'ADVISOR_TECHNOLOGY',	'LOC_BUILDING_JNR_ACADEMY_NAME',		NULL),
		('BUILDING_JNR_SCHOOL',			'DISTRICT_CAMPUS',	'TECH_EDUCATION',			250,	2,				1,				1,			'YIELD_GOLD',	'ADVISOR_TECHNOLOGY',	'LOC_BUILDING_JNR_SCHOOL_NAME',			'LOC_BUILDING_JNR_SCHOOL_DESCRIPTION'),
		('BUILDING_JNR_LABORATORY',		'DISTRICT_CAMPUS',	'TECH_SCIENTIFIC_THEORY',	330,	3,				1,				1,			'YIELD_GOLD',	'ADVISOR_TECHNOLOGY',	'LOC_BUILDING_JNR_LABORATORY_NAME',		'LOC_BUILDING_JNR_LABORATORY_DESCRIPTION'),
		('BUILDING_JNR_LIBERAL_ARTS',	'DISTRICT_CAMPUS',	'TECH_SCIENTIFIC_THEORY',	330,	3,				1,				1,			'YIELD_GOLD',	'ADVISOR_TECHNOLOGY',	'LOC_BUILDING_JNR_LIBERAL_ARTS_NAME',	'LOC_BUILDING_JNR_LIBERAL_ARTS_DESCRIPTION'),
		('BUILDING_JNR_EDUCATION',		'DISTRICT_CAMPUS',	'TECH_COMPUTERS',			440,	4,				1,				0,			'YIELD_GOLD',	'ADVISOR_TECHNOLOGY',	'LOC_BUILDING_JNR_EDUCATION_NAME',		'LOC_BUILDING_JNR_EDUCATION_DESCRIPTION');

UPDATE Buildings SET	PrereqTech='TECH_COMPUTERS', Maintenance=4, Name='LOC_BUILDING_RESEARCH_LAB_NAME_UC_JNR'	WHERE BuildingType='BUILDING_RESEARCH_LAB';

UPDATE Buildings SET	Description='LOC_BUILDING_LIBRARY_DESCRIPTION_UC_JNR'		WHERE BuildingType='BUILDING_LIBRARY';
UPDATE Buildings SET	Description=NULL											WHERE BuildingType='BUILDING_UNIVERSITY';
-- UPDATE Buildings SET	Description='LOC_BUILDING_MADRASA_DESCRIPTION_UC_JNR'		WHERE BuildingType='BUILDING_MADRASA';
UPDATE Buildings SET	Description='LOC_BUILDING_RESEARCH_LAB_DESCRIPTION_UC_JNR'	WHERE BuildingType='BUILDING_RESEARCH_LAB';
--------------------------------------------------------------

-- Buildings_XP2
--------------------------------------------------------------
INSERT OR IGNORE INTO Buildings_XP2
		(BuildingType,				RequiredPower)
SELECT	'BUILDING_RESEARCH_LAB',	RequiredPower
FROM	Buildings_XP2
WHERE	BuildingType='BUILDING_RESEARCH_LAB';
--------------------------------------------------------------

-- BuildingPrereqs
--------------------------------------------------------------
INSERT OR IGNORE INTO BuildingPrereqs
		(Building,						PrereqBuilding)
VALUES	('BUILDING_JNR_LABORATORY',		'BUILDING_UNIVERSITY'),
		('BUILDING_JNR_LIBERAL_ARTS',	'BUILDING_UNIVERSITY'),
		('BUILDING_RESEARCH_LAB',		'BUILDING_JNR_LABORATORY'),
		('BUILDING_RESEARCH_LAB',		'BUILDING_JNR_LIBERAL_ARTS'),
		('BUILDING_JNR_EDUCATION',		'BUILDING_JNR_LABORATORY'),
		('BUILDING_JNR_EDUCATION',		'BUILDING_JNR_LIBERAL_ARTS');

DELETE FROM BuildingPrereqs WHERE Building='BUILDING_RESEARCH_LAB'	AND PrereqBuilding='BUILDING_UNIVERSITY';

INSERT OR IGNORE INTO BuildingPrereqs
		(Building,							PrereqBuilding)
SELECT	Building,							'BUILDING_JNR_ACADEMY'
FROM	BuildingPrereqs	WHERE	PrereqBuilding='BUILDING_LIBRARY';

INSERT OR IGNORE INTO BuildingPrereqs
		(Building,							PrereqBuilding)
SELECT	Building,							'BUILDING_JNR_SCHOOL'
FROM	BuildingPrereqs	WHERE	PrereqBuilding='BUILDING_UNIVERSITY';

INSERT OR IGNORE INTO BuildingPrereqs
		(Building,							PrereqBuilding)
SELECT	Building,							'BUILDING_JNR_EDUCATION'
FROM	BuildingPrereqs	WHERE	PrereqBuilding='BUILDING_RESEARCH_LAB';

INSERT OR IGNORE INTO BuildingPrereqs
		(Building,							PrereqBuilding)
SELECT	'BUILDING_JNR_SCHOOL',				PrereqBuilding
FROM	BuildingPrereqs	WHERE	Building='BUILDING_UNIVERSITY';

INSERT OR IGNORE INTO BuildingPrereqs
		(Building,							PrereqBuilding)
SELECT	'BUILDING_JNR_EDUCATION',			PrereqBuilding
FROM	BuildingPrereqs	WHERE	Building='BUILDING_RESEARCH_LAB';

DELETE FROM BuildingPrereqs WHERE Building='BUILDING_GREAT_LIBRARY'						AND PrereqBuilding='BUILDING_JNR_ACADEMY';
DELETE FROM BuildingPrereqs WHERE Building='BUILDING_OXFORD_UNIVERSITY'					AND PrereqBuilding='BUILDING_JNR_SCHOOL';
DELETE FROM BuildingPrereqs WHERE Building='BUILDING_UNIVERSITY_SANKORE'				AND PrereqBuilding='BUILDING_JNR_SCHOOL';
DELETE FROM BuildingPrereqs WHERE Building='BUILDING_AMUNDSEN_SCOTT_RESEARCH_STATION'	AND PrereqBuilding='BUILDING_JNR_EDUCATION';
--------------------------------------------------------------

-- MutuallyExclusiveBuildings
--------------------------------------------------------------
INSERT OR IGNORE INTO MutuallyExclusiveBuildings
		(Building,						MutuallyExclusiveBuilding)
VALUES	('BUILDING_LIBRARY',			'BUILDING_JNR_ACADEMY'),
		('BUILDING_JNR_ACADEMY',		'BUILDING_LIBRARY'),
		('BUILDING_UNIVERSITY',			'BUILDING_JNR_SCHOOL'),
		('BUILDING_JNR_SCHOOL',			'BUILDING_UNIVERSITY'),
		('BUILDING_JNR_LABORATORY',		'BUILDING_JNR_LIBERAL_ARTS'),
		('BUILDING_JNR_LIBERAL_ARTS',	'BUILDING_JNR_LABORATORY'),
		('BUILDING_RESEARCH_LAB',		'BUILDING_JNR_EDUCATION'),
		('BUILDING_JNR_EDUCATION',		'BUILDING_RESEARCH_LAB');

-- Uniques
INSERT OR IGNORE INTO MutuallyExclusiveBuildings
		(Building,							MutuallyExclusiveBuilding)
SELECT	CivUniqueBuildingType,				'BUILDING_JNR_ACADEMY'
FROM	BuildingReplaces	WHERE	ReplacesBuildingType='BUILDING_LIBRARY';

INSERT OR IGNORE INTO MutuallyExclusiveBuildings
		(Building,							MutuallyExclusiveBuilding)
SELECT	CivUniqueBuildingType,				'BUILDING_JNR_SCHOOL'
FROM	BuildingReplaces	WHERE	ReplacesBuildingType='BUILDING_UNIVERSITY';

INSERT OR IGNORE INTO MutuallyExclusiveBuildings
		(Building,							MutuallyExclusiveBuilding)
SELECT	CivUniqueBuildingType,				'BUILDING_JNR_EDUCATION'
FROM	BuildingReplaces	WHERE	ReplacesBuildingType='BUILDING_RESEARCH_LAB';
--------------------------------------------------------------

-- StartingBuildings
--------------------------------------------------------------
DELETE FROM StartingBuildings WHERE District='DISTRICT_CAMPUS';
--------------------------------------------------------------