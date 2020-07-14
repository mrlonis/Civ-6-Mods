-- UC_CMP_City_States_Tier3
-- Author: JNR
--------------------------------------------------------------

-- Modifiers
--------------------------------------------------------------
INSERT OR IGNORE INTO Modifiers
		(ModifierId,													ModifierType,	SubjectRequirementSetId)
SELECT	'MINOR_CIV_SCIENTIFIC_UNIQUE_INFLUENCE_BONUS_LABORATORY_JNR',	ModifierType,	SubjectRequirementSetId
FROM	Modifiers
WHERE	ModifierId='MINOR_CIV_SCIENTIFIC_UNIQUE_INFLUENCE_BONUS_JNR';

INSERT OR IGNORE INTO Modifiers
		(ModifierId,													ModifierType)
SELECT	'MINOR_CIV_SCIENTIFIC_YIELD_FOR_LABORATORY_JNR',				ModifierType
FROM	Modifiers
WHERE	ModifierId='MINOR_CIV_SCIENTIFIC_YIELD_FOR_RESEARCH_LAB_JNR';

INSERT OR IGNORE INTO Modifiers
		(ModifierId,													ModifierType,	SubjectRequirementSetId)
SELECT	'MINOR_CIV_SCIENTIFIC_UNIQUE_INFLUENCE_BONUS_LIBERAL_ARTS_JNR',	ModifierType,	SubjectRequirementSetId
FROM	Modifiers
WHERE	ModifierId='MINOR_CIV_SCIENTIFIC_UNIQUE_INFLUENCE_BONUS_JNR';

INSERT OR IGNORE INTO Modifiers
		(ModifierId,													ModifierType)
SELECT	'MINOR_CIV_SCIENTIFIC_YIELD_FOR_LIBERAL_ARTS_JNR',				ModifierType
FROM	Modifiers
WHERE	ModifierId='MINOR_CIV_SCIENTIFIC_YIELD_FOR_RESEARCH_LAB_JNR';

INSERT OR IGNORE INTO Modifiers
		(ModifierId,													ModifierType,	SubjectRequirementSetId)
SELECT	'MINOR_CIV_SCIENTIFIC_UNIQUE_INFLUENCE_BONUS_EDUCATION_JNR',	ModifierType,	SubjectRequirementSetId
FROM	Modifiers
WHERE	ModifierId='MINOR_CIV_SCIENTIFIC_UNIQUE_INFLUENCE_BONUS_JNR';

INSERT OR IGNORE INTO Modifiers
		(ModifierId,													ModifierType)
SELECT	'MINOR_CIV_SCIENTIFIC_YIELD_FOR_EDUCATION_JNR',					ModifierType
FROM	Modifiers
WHERE	ModifierId='MINOR_CIV_SCIENTIFIC_YIELD_FOR_RESEARCH_LAB_JNR';
--------------------------------------------------------------

-- ModifierArguments
--------------------------------------------------------------
INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,													Name,				Value)
SELECT	'MINOR_CIV_SCIENTIFIC_UNIQUE_INFLUENCE_BONUS_LABORATORY_JNR',	Name,				'MINOR_CIV_SCIENTIFIC_YIELD_FOR_LABORATORY_JNR'
FROM	ModifierArguments
WHERE	ModifierId='MINOR_CIV_SCIENTIFIC_UNIQUE_INFLUENCE_BONUS_JNR';

INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,													Name,				Value)
SELECT	'MINOR_CIV_SCIENTIFIC_YIELD_FOR_LABORATORY_JNR',				'YieldType',		'YIELD_SCIENCE'
FROM	ModifierArguments
WHERE	ModifierId='MINOR_CIV_SCIENTIFIC_YIELD_FOR_RESEARCH_LAB_JNR';

INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,													Name,				Value)
SELECT	'MINOR_CIV_SCIENTIFIC_YIELD_FOR_LABORATORY_JNR',				'BuildingType',		'BUILDING_JNR_LABORATORY'
FROM	ModifierArguments
WHERE	ModifierId='MINOR_CIV_SCIENTIFIC_YIELD_FOR_RESEARCH_LAB_JNR';

INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,													Name,				Value)
SELECT	'MINOR_CIV_SCIENTIFIC_YIELD_FOR_LABORATORY_JNR',				'Amount',			2
FROM	ModifierArguments
WHERE	ModifierId='MINOR_CIV_SCIENTIFIC_YIELD_FOR_RESEARCH_LAB_JNR';

INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,													Name,				Value)
SELECT	'MINOR_CIV_SCIENTIFIC_YIELD_FOR_LABORATORY_JNR',				'CityStatesOnly',	1
FROM	ModifierArguments
WHERE	ModifierId='MINOR_CIV_SCIENTIFIC_YIELD_FOR_RESEARCH_LAB_JNR';

INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,													Name,				Value)
SELECT	'MINOR_CIV_SCIENTIFIC_UNIQUE_INFLUENCE_BONUS_LIBERAL_ARTS_JNR',	Name,				'MINOR_CIV_SCIENTIFIC_YIELD_FOR_LIBERAL_ARTS_JNR'
FROM	ModifierArguments
WHERE	ModifierId='MINOR_CIV_SCIENTIFIC_UNIQUE_INFLUENCE_BONUS_JNR';

INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,													Name,				Value)
SELECT	'MINOR_CIV_SCIENTIFIC_YIELD_FOR_LIBERAL_ARTS_JNR',				'YieldType',		'YIELD_SCIENCE'
FROM	ModifierArguments
WHERE	ModifierId='MINOR_CIV_SCIENTIFIC_YIELD_FOR_RESEARCH_LAB_JNR';

INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,													Name,				Value)
SELECT	'MINOR_CIV_SCIENTIFIC_YIELD_FOR_LIBERAL_ARTS_JNR',				'BuildingType',		'BUILDING_JNR_LIBERAL_ARTS'
FROM	ModifierArguments
WHERE	ModifierId='MINOR_CIV_SCIENTIFIC_YIELD_FOR_RESEARCH_LAB_JNR';

INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,													Name,				Value)
SELECT	'MINOR_CIV_SCIENTIFIC_YIELD_FOR_LIBERAL_ARTS_JNR',				'Amount',			2
FROM	ModifierArguments
WHERE	ModifierId='MINOR_CIV_SCIENTIFIC_YIELD_FOR_RESEARCH_LAB_JNR';

INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,													Name,				Value)
SELECT	'MINOR_CIV_SCIENTIFIC_YIELD_FOR_LIBERAL_ARTS_JNR',				'CityStatesOnly',	1
FROM	ModifierArguments
WHERE	ModifierId='MINOR_CIV_SCIENTIFIC_YIELD_FOR_RESEARCH_LAB_JNR';

INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,													Name,				Value)
SELECT	'MINOR_CIV_SCIENTIFIC_UNIQUE_INFLUENCE_BONUS_EDUCATION_JNR',	Name,				'MINOR_CIV_SCIENTIFIC_YIELD_FOR_EDUCATION_JNR'
FROM	ModifierArguments
WHERE	ModifierId='MINOR_CIV_SCIENTIFIC_UNIQUE_INFLUENCE_BONUS_JNR';

INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,													Name,				Value)
SELECT	'MINOR_CIV_SCIENTIFIC_YIELD_FOR_EDUCATION_JNR',					'YieldType',		'YIELD_SCIENCE'
FROM	ModifierArguments
WHERE	ModifierId='MINOR_CIV_SCIENTIFIC_YIELD_FOR_RESEARCH_LAB_JNR';

INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,													Name,				Value)
SELECT	'MINOR_CIV_SCIENTIFIC_YIELD_FOR_EDUCATION_JNR',					'BuildingType',		'BUILDING_JNR_EDUCATION'
FROM	ModifierArguments
WHERE	ModifierId='MINOR_CIV_SCIENTIFIC_YIELD_FOR_RESEARCH_LAB_JNR';

INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,													Name,				Value)
SELECT	'MINOR_CIV_SCIENTIFIC_YIELD_FOR_EDUCATION_JNR',					'Amount',			2
FROM	ModifierArguments
WHERE	ModifierId='MINOR_CIV_SCIENTIFIC_YIELD_FOR_RESEARCH_LAB_JNR';

INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,													Name,				Value)
SELECT	'MINOR_CIV_SCIENTIFIC_YIELD_FOR_EDUCATION_JNR',					'CityStatesOnly',	1
FROM	ModifierArguments
WHERE	ModifierId='MINOR_CIV_SCIENTIFIC_YIELD_FOR_RESEARCH_LAB_JNR';
--------------------------------------------------------------

-- TraitModifiers
--------------------------------------------------------------
INSERT OR IGNORE INTO TraitModifiers
		(TraitType,	ModifierId)
SELECT	TraitType,	'MINOR_CIV_SCIENTIFIC_UNIQUE_INFLUENCE_BONUS_LABORATORY_JNR'
FROM	TraitModifiers
WHERE	ModifierId='MINOR_CIV_SCIENTIFIC_UNIQUE_INFLUENCE_BONUS_JNR';

INSERT OR IGNORE INTO TraitModifiers
		(TraitType,	ModifierId)
SELECT	TraitType,	'MINOR_CIV_SCIENTIFIC_UNIQUE_INFLUENCE_BONUS_LIBERAL_ARTS_JNR'
FROM	TraitModifiers
WHERE	ModifierId='MINOR_CIV_SCIENTIFIC_UNIQUE_INFLUENCE_BONUS_JNR';

INSERT OR IGNORE INTO TraitModifiers
		(TraitType,	ModifierId)
SELECT	TraitType,	'MINOR_CIV_SCIENTIFIC_UNIQUE_INFLUENCE_BONUS_EDUCATION_JNR'
FROM	TraitModifiers
WHERE	ModifierId='MINOR_CIV_SCIENTIFIC_UNIQUE_INFLUENCE_BONUS_JNR';
--------------------------------------------------------------