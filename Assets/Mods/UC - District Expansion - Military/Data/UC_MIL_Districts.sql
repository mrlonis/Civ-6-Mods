-- UC_MIL_Districts
-- Author: JNR
--------------------------------------------------------------

-- Districts
--------------------------------------------------------------
UPDATE Districts SET
PrereqTech=		NULL,
PrereqCivic=	'CIVIC_MILITARY_TRADITION',
PlunderType=	'PLUNDER_GOLD',
PlunderAmount=	50,
Housing=		1
WHERE DistrictType='DISTRICT_ENCAMPMENT';

UPDATE Districts SET
PrereqTech=		NULL,
PrereqCivic=	'CIVIC_MILITARY_TRADITION',
PlunderType=	'PLUNDER_GOLD',
PlunderAmount=	50,
Housing=		Housing+1
WHERE DistrictType IN (SELECT CivUniqueDistrictType FROM DistrictReplaces WHERE ReplacesDistrictType='DISTRICT_ENCAMPMENT');
--------------------------------------------------------------

-- District_Adjacencies
--------------------------------------------------------------
INSERT OR IGNORE INTO District_Adjacencies
		(DistrictType,			YieldChangeId)
VALUES	('DISTRICT_ENCAMPMENT',	'Strategic_Production'),
		('DISTRICT_ENCAMPMENT',	'District_Production'),
		('DISTRICT_ENCAMPMENT',	'Government_Production');

INSERT OR IGNORE INTO District_Adjacencies
		(DistrictType,			YieldChangeId)
SELECT	CivUniqueDistrictType,	'Strategic_Production'
FROM DistrictReplaces WHERE ReplacesDistrictType='DISTRICT_ENCAMPMENT';

INSERT OR IGNORE INTO District_Adjacencies
		(DistrictType,			YieldChangeId)
SELECT	CivUniqueDistrictType,	'District_Production'
FROM DistrictReplaces WHERE ReplacesDistrictType='DISTRICT_ENCAMPMENT';

INSERT OR IGNORE INTO District_Adjacencies
		(DistrictType,			YieldChangeId)
SELECT	CivUniqueDistrictType,	'Government_Production'
FROM DistrictReplaces WHERE ReplacesDistrictType='DISTRICT_ENCAMPMENT';
--------------------------------------------------------------

-- Modifiers
--------------------------------------------------------------
INSERT OR IGNORE INTO Modifiers
		(ModifierId,													ModifierType)
VALUES	('TRAIT_ADJACENT_DISTRICTS_ENCAMPENT_ADJACENCYPRODUCTION_JNR',	'MODIFIER_PLAYER_CITIES_DISTRICT_ADJACENCY');
--------------------------------------------------------------

-- ModifierArguments
--------------------------------------------------------------
INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,													Name,			Value)
VALUES	('TRAIT_ADJACENT_DISTRICTS_ENCAMPENT_ADJACENCYPRODUCTION_JNR',	'DistrictType',	'DISTRICT_ENCAMPMENT'),
		('TRAIT_ADJACENT_DISTRICTS_ENCAMPENT_ADJACENCYPRODUCTION_JNR',	'YieldType',	'YIELD_PRODUCTION'),
		('TRAIT_ADJACENT_DISTRICTS_ENCAMPENT_ADJACENCYPRODUCTION_JNR',	'Amount',		1),
		('TRAIT_ADJACENT_DISTRICTS_ENCAMPENT_ADJACENCYPRODUCTION_JNR',	'Description',	'LOC_DISTRICT_DISTRICT_1_PRODUCTION');
--------------------------------------------------------------

-- TraitModifiers
--------------------------------------------------------------
INSERT OR IGNORE INTO TraitModifiers
		(TraitType,									ModifierId)
VALUES	('TRAIT_CIVILIZATION_ADJACENT_DISTRICTS',	'TRAIT_ADJACENT_DISTRICTS_ENCAMPENT_ADJACENCYPRODUCTION_JNR');
--------------------------------------------------------------

-- District_GreatPersonPoints
--------------------------------------------------------------
INSERT OR IGNORE INTO District_GreatPersonPoints
		(DistrictType,			GreatPersonClassType,			PointsPerTurn)
VALUES	('DISTRICT_AERODROME',	'GREAT_PERSON_CLASS_GENERAL',	1);

INSERT OR IGNORE INTO District_GreatPersonPoints
		(DistrictType,			GreatPersonClassType,			PointsPerTurn)
SELECT	CivUniqueDistrictType,	'GREAT_PERSON_CLASS_GENERAL',	1
FROM DistrictReplaces WHERE ReplacesDistrictType='DISTRICT_AERODROME';
--------------------------------------------------------------