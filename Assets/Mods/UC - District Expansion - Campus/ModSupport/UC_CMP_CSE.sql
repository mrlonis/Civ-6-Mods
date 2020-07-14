-- UC_CMP_CSE
-- Author: JNR
--------------------------------------------------------------

-- Modifiers
--------------------------------------------------------------
INSERT OR IGNORE INTO Modifiers
		(ModifierId,										ModifierType,	SubjectRequirementSetId)
SELECT	'MODIFIER_CSE_SCIENTIFIC_ACADEMY_SCIENCE_JNR',		ModifierType,	SubjectRequirementSetId
FROM	Modifiers
WHERE	ModifierId='MODIFIER_CSE_SCIENTIFIC_LIBRARY_SCIENCE';

INSERT OR IGNORE INTO Modifiers
		(ModifierId,										ModifierType,	SubjectRequirementSetId)
SELECT	'MODIFIER_CSE_SCIENTIFIC_SCHOOL_SCIENCE_JNR',		ModifierType,	SubjectRequirementSetId
FROM	Modifiers
WHERE	ModifierId='MODIFIER_CSE_SCIENTIFIC_UNIVERSITY_SCIENCE';

INSERT OR IGNORE INTO Modifiers
		(ModifierId,										ModifierType,	SubjectRequirementSetId)
SELECT	'MODIFIER_CSE_SCIENTIFIC_LABORATORY_SCIENCE_JNR',	ModifierType,	SubjectRequirementSetId
FROM	Modifiers
WHERE	ModifierId='MODIFIER_CSE_SCIENTIFIC_RESEARCH_LAB_SCIENCE';

INSERT OR IGNORE INTO Modifiers
		(ModifierId,										ModifierType,	SubjectRequirementSetId)
SELECT	'MODIFIER_CSE_SCIENTIFIC_LIBERAL_ARTS_SCIENCE_JNR',	ModifierType,	SubjectRequirementSetId
FROM	Modifiers
WHERE	ModifierId='MODIFIER_CSE_SCIENTIFIC_RESEARCH_LAB_SCIENCE';

INSERT OR IGNORE INTO Modifiers
		(ModifierId,										ModifierType,	SubjectRequirementSetId)
SELECT	'MODIFIER_CSE_SCIENTIFIC_EDUCATION_SCIENCE_JNR',	ModifierType,	SubjectRequirementSetId
FROM	Modifiers
WHERE	ModifierId='MODIFIER_CSE_SCIENTIFIC_RESEARCH_LAB_SCIENCE';

INSERT OR IGNORE INTO Modifiers
		(ModifierId,											ModifierType,	SubjectRequirementSetId)
SELECT	'MODIFIER_CSE_SCIENTIFIC_ACADEMY_SCIENCE_MOD_JNR',		ModifierType,	SubjectRequirementSetId
FROM	Modifiers
WHERE	ModifierId='MODIFIER_CSE_SCIENTIFIC_LIBRARY_SCIENCE_MOD';

INSERT OR IGNORE INTO Modifiers
		(ModifierId,											ModifierType,	SubjectRequirementSetId)
SELECT	'MODIFIER_CSE_SCIENTIFIC_SCHOOL_SCIENCE_MOD_JNR',		ModifierType,	SubjectRequirementSetId
FROM	Modifiers
WHERE	ModifierId='MODIFIER_CSE_SCIENTIFIC_UNIVERSITY_SCIENCE_MOD';

INSERT OR IGNORE INTO Modifiers
		(ModifierId,											ModifierType,	SubjectRequirementSetId)
SELECT	'MODIFIER_CSE_SCIENTIFIC_LABORATORY_SCIENCE_MOD_JNR',	ModifierType,	SubjectRequirementSetId
FROM	Modifiers
WHERE	ModifierId='MODIFIER_CSE_SCIENTIFIC_RESEARCH_LAB_SCIENCE_MOD';

INSERT OR IGNORE INTO Modifiers
		(ModifierId,											ModifierType,	SubjectRequirementSetId)
SELECT	'MODIFIER_CSE_SCIENTIFIC_LIBERAL_ARTS_SCIENCE_MOD_JNR',	ModifierType,	SubjectRequirementSetId
FROM	Modifiers
WHERE	ModifierId='MODIFIER_CSE_SCIENTIFIC_RESEARCH_LAB_SCIENCE_MOD';

INSERT OR IGNORE INTO Modifiers
		(ModifierId,											ModifierType,	SubjectRequirementSetId)
SELECT	'MODIFIER_CSE_SCIENTIFIC_EDUCATION_SCIENCE_MOD_JNR',	ModifierType,	SubjectRequirementSetId
FROM	Modifiers
WHERE	ModifierId='MODIFIER_CSE_SCIENTIFIC_RESEARCH_LAB_SCIENCE_MOD';
--------------------------------------------------------------

-- ModifierArguments
--------------------------------------------------------------
INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,										Name,	Value)
SELECT	'MODIFIER_CSE_SCIENTIFIC_ACADEMY_SCIENCE_JNR',		Name,	'MODIFIER_CSE_SCIENTIFIC_ACADEMY_SCIENCE_MOD_JNR'
FROM	ModifierArguments
WHERE	ModifierId='MODIFIER_CSE_SCIENTIFIC_LIBRARY_SCIENCE';

INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,										Name,	Value)
SELECT	'MODIFIER_CSE_SCIENTIFIC_SCHOOL_SCIENCE_JNR',		Name,	'MODIFIER_CSE_SCIENTIFIC_SCHOOL_SCIENCE_MOD_JNR'
FROM	ModifierArguments
WHERE	ModifierId='MODIFIER_CSE_SCIENTIFIC_UNIVERSITY_SCIENCE';

INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,										Name,	Value)
SELECT	'MODIFIER_CSE_SCIENTIFIC_LABORATORY_SCIENCE_JNR',	Name,	'MODIFIER_CSE_SCIENTIFIC_LABORATORY_SCIENCE_MOD_JNR'
FROM	ModifierArguments
WHERE	ModifierId='MODIFIER_CSE_SCIENTIFIC_RESEARCH_LAB_SCIENCE';

INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,										Name,	Value)
SELECT	'MODIFIER_CSE_SCIENTIFIC_LIBERAL_ARTS_SCIENCE_JNR',	Name,	'MODIFIER_CSE_SCIENTIFIC_LIBERAL_ARTS_SCIENCE_MOD_JNR'
FROM	ModifierArguments
WHERE	ModifierId='MODIFIER_CSE_SCIENTIFIC_RESEARCH_LAB_SCIENCE';

INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,										Name,	Value)
SELECT	'MODIFIER_CSE_SCIENTIFIC_EDUCATION_SCIENCE_JNR',	Name,	'MODIFIER_CSE_SCIENTIFIC_EDUCATION_SCIENCE_MOD_JNR'
FROM	ModifierArguments
WHERE	ModifierId='MODIFIER_CSE_SCIENTIFIC_RESEARCH_LAB_SCIENCE';

INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,											Name,				Value)
SELECT	'MODIFIER_CSE_SCIENTIFIC_ACADEMY_SCIENCE_MOD_JNR',		'BuildingType',		'BUILDING_JNR_ACADEMY'
FROM	ModifierArguments
WHERE	ModifierId='MODIFIER_CSE_SCIENTIFIC_LIBRARY_SCIENCE_MOD';

INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,											Name,				Value)
SELECT	'MODIFIER_CSE_SCIENTIFIC_SCHOOL_SCIENCE_MOD_JNR',		'BuildingType',		'BUILDING_JNR_SCHOOL'
FROM	ModifierArguments
WHERE	ModifierId='MODIFIER_CSE_SCIENTIFIC_UNIVERSITY_SCIENCE_MOD';

INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,											Name,				Value)
SELECT	'MODIFIER_CSE_SCIENTIFIC_LABORATORY_SCIENCE_MOD_JNR',	'BuildingType',		'BUILDING_JNR_LABORATORY'
FROM	ModifierArguments
WHERE	ModifierId='MODIFIER_CSE_SCIENTIFIC_RESEARCH_LAB_SCIENCE_MOD';

INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,											Name,				Value)
SELECT	'MODIFIER_CSE_SCIENTIFIC_LIBERAL_ARTS_SCIENCE_MOD_JNR',	'BuildingType',		'BUILDING_JNR_LIBERAL_ARTS'
FROM	ModifierArguments
WHERE	ModifierId='MODIFIER_CSE_SCIENTIFIC_RESEARCH_LAB_SCIENCE_MOD';

INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,											Name,				Value)
SELECT	'MODIFIER_CSE_SCIENTIFIC_EDUCATION_SCIENCE_MOD_JNR',	'BuildingType',		'BUILDING_JNR_EDUCATION'
FROM	ModifierArguments
WHERE	ModifierId='MODIFIER_CSE_SCIENTIFIC_RESEARCH_LAB_SCIENCE_MOD';

INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,											Name,				Value)
SELECT	'MODIFIER_CSE_SCIENTIFIC_ACADEMY_SCIENCE_MOD_JNR',		'YieldType',		Value
FROM	ModifierArguments
WHERE	ModifierId='MODIFIER_CSE_SCIENTIFIC_RESEARCH_LAB_SCIENCE_MOD'	AND Name='YieldType';

INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,											Name,				Value)
SELECT	'MODIFIER_CSE_SCIENTIFIC_SCHOOL_SCIENCE_MOD_JNR',		'YieldType',		Value
FROM	ModifierArguments
WHERE	ModifierId='MODIFIER_CSE_SCIENTIFIC_UNIVERSITY_SCIENCE_MOD'		AND Name='YieldType';

INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,											Name,				Value)
SELECT	'MODIFIER_CSE_SCIENTIFIC_LABORATORY_SCIENCE_MOD_JNR',	'YieldType',		Value
FROM	ModifierArguments
WHERE	ModifierId='MODIFIER_CSE_SCIENTIFIC_RESEARCH_LAB_SCIENCE_MOD'	AND Name='YieldType';

INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,											Name,				Value)
SELECT	'MODIFIER_CSE_SCIENTIFIC_LIBERAL_ARTS_SCIENCE_MOD_JNR',	'YieldType',		Value
FROM	ModifierArguments
WHERE	ModifierId='MODIFIER_CSE_SCIENTIFIC_RESEARCH_LAB_SCIENCE_MOD'	AND Name='YieldType';

INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,											Name,				Value)
SELECT	'MODIFIER_CSE_SCIENTIFIC_EDUCATION_SCIENCE_MOD_JNR',	'YieldType',		Value
FROM	ModifierArguments
WHERE	ModifierId='MODIFIER_CSE_SCIENTIFIC_RESEARCH_LAB_SCIENCE_MOD'	AND Name='YieldType';

INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,											Name,				Value)
SELECT	'MODIFIER_CSE_SCIENTIFIC_ACADEMY_SCIENCE_MOD_JNR',		'Amount',			Value
FROM	ModifierArguments
WHERE	ModifierId='MODIFIER_CSE_SCIENTIFIC_LIBRARY_SCIENCE_MOD'		AND Name='Amount';

INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,											Name,				Value)
SELECT	'MODIFIER_CSE_SCIENTIFIC_SCHOOL_SCIENCE_MOD_JNR',		'Amount',			Value
FROM	ModifierArguments
WHERE	ModifierId='MODIFIER_CSE_SCIENTIFIC_UNIVERSITY_SCIENCE_MOD'		AND Name='Amount';

INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,											Name,				Value)
SELECT	'MODIFIER_CSE_SCIENTIFIC_LABORATORY_SCIENCE_MOD_JNR',	'Amount',			Value
FROM	ModifierArguments
WHERE	ModifierId='MODIFIER_CSE_SCIENTIFIC_RESEARCH_LAB_SCIENCE_MOD'	AND Name='Amount';

INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,											Name,				Value)
SELECT	'MODIFIER_CSE_SCIENTIFIC_LIBERAL_ARTS_SCIENCE_MOD_JNR',	'Amount',			Value
FROM	ModifierArguments
WHERE	ModifierId='MODIFIER_CSE_SCIENTIFIC_RESEARCH_LAB_SCIENCE_MOD'	AND Name='Amount';

UPDATE ModifierArguments SET Value=4 WHERE ModifierId='MODIFIER_CSE_SCIENTIFIC_RESEARCH_LAB_SCIENCE_MOD' AND Name='Amount' AND Value=3;

INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,											Name,				Value)
SELECT	'MODIFIER_CSE_SCIENTIFIC_EDUCATION_SCIENCE_MOD_JNR',	'Amount',			Value
FROM	ModifierArguments
WHERE	ModifierId='MODIFIER_CSE_SCIENTIFIC_RESEARCH_LAB_SCIENCE_MOD'	AND Name='Amount';

INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,											Name,				Value)
SELECT	'MODIFIER_CSE_SCIENTIFIC_ACADEMY_SCIENCE_MOD_JNR',		'CityStatesOnly',	Value
FROM	ModifierArguments
WHERE	ModifierId='MODIFIER_CSE_SCIENTIFIC_LIBRARY_SCIENCE_MOD'		AND Name='CityStatesOnly';

INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,											Name,				Value)
SELECT	'MODIFIER_CSE_SCIENTIFIC_SCHOOL_SCIENCE_MOD_JNR',		'CityStatesOnly',	Value
FROM	ModifierArguments
WHERE	ModifierId='MODIFIER_CSE_SCIENTIFIC_UNIVERSITY_SCIENCE_MOD'		AND Name='CityStatesOnly';

INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,											Name,				Value)
SELECT	'MODIFIER_CSE_SCIENTIFIC_LABORATORY_SCIENCE_MOD_JNR',	'CityStatesOnly',	Value
FROM	ModifierArguments
WHERE	ModifierId='MODIFIER_CSE_SCIENTIFIC_RESEARCH_LAB_SCIENCE_MOD'	AND Name='CityStatesOnly';

INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,											Name,				Value)
SELECT	'MODIFIER_CSE_SCIENTIFIC_LIBERAL_ARTS_SCIENCE_MOD_JNR',	'CityStatesOnly',	Value
FROM	ModifierArguments
WHERE	ModifierId='MODIFIER_CSE_SCIENTIFIC_RESEARCH_LAB_SCIENCE_MOD'	AND Name='CityStatesOnly';

INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,											Name,				Value)
SELECT	'MODIFIER_CSE_SCIENTIFIC_EDUCATION_SCIENCE_MOD_JNR',	'CityStatesOnly',	Value
FROM	ModifierArguments
WHERE	ModifierId='MODIFIER_CSE_SCIENTIFIC_RESEARCH_LAB_SCIENCE_MOD'	AND Name='CityStatesOnly';
--------------------------------------------------------------

-- TraitModifiers
--------------------------------------------------------------
INSERT OR IGNORE INTO TraitModifiers
		(TraitType,	ModifierId)
SELECT	TraitType,	'MODIFIER_CSE_SCIENTIFIC_ACADEMY_SCIENCE_JNR'
FROM	TraitModifiers
WHERE	ModifierId='MODIFIER_CSE_SCIENTIFIC_LIBRARY_SCIENCE';

INSERT OR IGNORE INTO TraitModifiers
		(TraitType,	ModifierId)
SELECT	TraitType,	'MODIFIER_CSE_SCIENTIFIC_SCHOOL_SCIENCE_JNR'
FROM	TraitModifiers
WHERE	ModifierId='MODIFIER_CSE_SCIENTIFIC_UNIVERSITY_SCIENCE';

INSERT OR IGNORE INTO TraitModifiers
		(TraitType,	ModifierId)
SELECT	TraitType,	'MODIFIER_CSE_SCIENTIFIC_LABORATORY_SCIENCE_JNR'
FROM	TraitModifiers
WHERE	ModifierId='MODIFIER_CSE_SCIENTIFIC_RESEARCH_LAB_SCIENCE';

INSERT OR IGNORE INTO TraitModifiers
		(TraitType,	ModifierId)
SELECT	TraitType,	'MODIFIER_CSE_SCIENTIFIC_LIBERAL_ARTS_SCIENCE_JNR'
FROM	TraitModifiers
WHERE	ModifierId='MODIFIER_CSE_SCIENTIFIC_RESEARCH_LAB_SCIENCE';

INSERT OR IGNORE INTO TraitModifiers
		(TraitType,	ModifierId)
SELECT	TraitType,	'MODIFIER_CSE_SCIENTIFIC_EDUCATION_SCIENCE_JNR'
FROM	TraitModifiers
WHERE	ModifierId='MODIFIER_CSE_SCIENTIFIC_RESEARCH_LAB_SCIENCE';
--------------------------------------------------------------