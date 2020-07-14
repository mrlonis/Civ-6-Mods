-- UC_CMP_CX
-- Author: JNR
--------------------------------------------------------------

-- China - Dynastic Cycle
--------------------------------------------------------------
INSERT OR IGNORE INTO Requirements
		(RequirementId,							RequirementType,					Inverse)
SELECT	'P0K_CHINA_REQUIRES_NO_ACADEMY_JNR_UC',	'REQUIREMENT_CITY_HAS_BUILDING',	1
FROM	Requirements
WHERE	RequirementId='P0K_CHINA_REQUIRES_NO_LIBRARY';

INSERT OR IGNORE INTO RequirementArguments
		(RequirementId,							Name,					Value)
SELECT	'P0K_CHINA_REQUIRES_NO_ACADEMY_JNR_UC',	'BuildingType',			'BUILDING_JNR_ACADEMY'
FROM	Requirements
WHERE	RequirementId='P0K_CHINA_REQUIRES_NO_LIBRARY';
	
INSERT OR IGNORE INTO RequirementArguments
		(RequirementId,							Name,					Value)
SELECT	'P0K_CHINA_REQUIRES_NO_ACADEMY_JNR_UC',	'MustBeFunctioning',	0
FROM	Requirements
WHERE	RequirementId='P0K_CHINA_REQUIRES_NO_LIBRARY';

INSERT OR IGNORE INTO RequirementSetRequirements
		(RequirementSetId,						RequirementId)
SELECT	'P0K_CHINA_CITY_HAS_AMPHITHEATER_ONLY',	'P0K_CHINA_REQUIRES_NO_ACADEMY_JNR_UC'
FROM	Requirements
WHERE	RequirementId='P0K_CHINA_REQUIRES_NO_ACADEMY_JNR_UC';

INSERT OR IGNORE INTO RequirementSetRequirements
		(RequirementSetId,						RequirementId)
SELECT	'P0K_CHINA_CITY_HAS_SHRINE_ONLY',		'P0K_CHINA_REQUIRES_NO_ACADEMY_JNR_UC'
FROM	Requirements
WHERE	RequirementId='P0K_CHINA_REQUIRES_NO_ACADEMY_JNR_UC';

UPDATE	RequirementSetRequirements
SET		RequirementId='REQUIRES_CITY_HAS_CAMPUS_TIER1_JNR'
WHERE	RequirementSetId='P0K_CHINA_CITY_HAS_LIBRARY_ONLY' AND RequirementId='REQUIRES_CITY_HAS_LIBRARY';

UPDATE	Traits
SET		Description='LOC_TRAIT_CIVILIZATION_DYNASTIC_CYCLE_EXPANSION2_DESCRIPTION_JNR_UC_CX'
WHERE	TraitType=(SELECT TraitType FROM TraitModifiers WHERE TraitType='TRAIT_CIVILIZATION_DYNASTIC_CYCLE' AND ModifierId='P0K_TRAIT_CITY_CENTER_SCIENCE');
--------------------------------------------------------------

-- England - Pax Britannica
--------------------------------------------------------------
INSERT OR IGNORE INTO Modifiers
		(ModifierId,															ModifierType,											SubjectRequirementSetId)
SELECT	'P0K_TRAIT_HOME_CONTINENT_CAMPUS_SCIENCE_BONUS' || a.BuildingType,		'MODIFIER_PLAYER_CITIES_ADJUST_BUILDING_YIELD_CHANGE',	b.RequirementSetId
FROM	Buildings a, RequirementSets b
WHERE	a.PrereqDistrict='DISTRICT_CAMPUS'
		AND b.RequirementSetId='P0K_ENGLAND_CITY_ON_HOME_CONTINENT';

INSERT OR IGNORE INTO Modifiers
		(ModifierId,															ModifierType,											SubjectRequirementSetId)
SELECT	'P0K_TRAIT_FOREIGN_CONTINENT_IZ_PRODUCTION_BONUS' || a.BuildingType,	'MODIFIER_PLAYER_CITIES_ADJUST_BUILDING_YIELD_CHANGE',	'CITY_NOT_OWNER_CAPITAL_CONTINENT_REQUIREMENTS'
FROM	Buildings a, RequirementSets b
WHERE	a.PrereqDistrict='DISTRICT_INDUSTRIAL_ZONE'
		AND b.RequirementSetId='P0K_ENGLAND_CITY_ON_HOME_CONTINENT';

INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,															Name,			Value)
SELECT	'P0K_TRAIT_HOME_CONTINENT_CAMPUS_SCIENCE_BONUS' || a.BuildingType,		'BuildingType',	a.BuildingType
FROM	Buildings a, RequirementSets b
WHERE	a.PrereqDistrict='DISTRICT_CAMPUS'
		AND b.RequirementSetId='P0K_ENGLAND_CITY_ON_HOME_CONTINENT';

INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,															Name,			Value)
SELECT	'P0K_TRAIT_HOME_CONTINENT_CAMPUS_SCIENCE_BONUS' || a.BuildingType,		'YieldType',	'YIELD_SCIENCE'
FROM	Buildings a, RequirementSets b
WHERE	a.PrereqDistrict='DISTRICT_CAMPUS'
		AND b.RequirementSetId='P0K_ENGLAND_CITY_ON_HOME_CONTINENT';

INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,															Name,			Value)
SELECT	'P0K_TRAIT_HOME_CONTINENT_CAMPUS_SCIENCE_BONUS' || a.BuildingType,		'Amount',		a.Maintenance
FROM	Buildings a, RequirementSets b
WHERE	a.PrereqDistrict='DISTRICT_CAMPUS'
		AND b.RequirementSetId='P0K_ENGLAND_CITY_ON_HOME_CONTINENT';

INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,															Name,			Value)
SELECT	'P0K_TRAIT_FOREIGN_CONTINENT_IZ_PRODUCTION_BONUS' || a.BuildingType,	'BuildingType',	a.BuildingType
FROM	Buildings a, RequirementSets b
WHERE	a.PrereqDistrict='DISTRICT_INDUSTRIAL_ZONE'
		AND b.RequirementSetId='P0K_ENGLAND_CITY_ON_HOME_CONTINENT';

INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,															Name,			Value)
SELECT	'P0K_TRAIT_FOREIGN_CONTINENT_IZ_PRODUCTION_BONUS' || a.BuildingType,	'YieldType',	'YIELD_PRODUCTION'
FROM	Buildings a, RequirementSets b
WHERE	a.PrereqDistrict='DISTRICT_INDUSTRIAL_ZONE'
		AND b.RequirementSetId='P0K_ENGLAND_CITY_ON_HOME_CONTINENT';

INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,															Name,			Value)
SELECT	'P0K_TRAIT_FOREIGN_CONTINENT_IZ_PRODUCTION_BONUS' || a.BuildingType,	'Amount',		a.Maintenance
FROM	Buildings a, RequirementSets b
WHERE	a.PrereqDistrict='DISTRICT_INDUSTRIAL_ZONE'
		AND b.RequirementSetId='P0K_ENGLAND_CITY_ON_HOME_CONTINENT';

INSERT OR IGNORE INTO TraitModifiers
		(TraitType,						ModifierId)
SELECT	'TRAIT_LEADER_PAX_BRITANNICA',	'P0K_TRAIT_HOME_CONTINENT_CAMPUS_SCIENCE_BONUS' || a.BuildingType
FROM	Buildings a, RequirementSets b
WHERE	a.PrereqDistrict='DISTRICT_CAMPUS'
		AND b.RequirementSetId='P0K_ENGLAND_CITY_ON_HOME_CONTINENT';

INSERT OR IGNORE INTO TraitModifiers
		(TraitType,						ModifierId)
SELECT	'TRAIT_LEADER_PAX_BRITANNICA',	'P0K_TRAIT_FOREIGN_CONTINENT_IZ_PRODUCTION_BONUS' || a.BuildingType
FROM	Buildings a, RequirementSets b
WHERE	a.PrereqDistrict='DISTRICT_INDUSTRIAL_ZONE'
		AND b.RequirementSetId='P0K_ENGLAND_CITY_ON_HOME_CONTINENT';

DELETE FROM TraitModifiers WHERE TraitType='TRAIT_LEADER_PAX_BRITANNICA' AND ModifierId='P0K_TRAIT_HOME_CONTINENT_CAMPUS_BUILDING_SCIENCE_BONUS';
DELETE FROM TraitModifiers WHERE TraitType='TRAIT_LEADER_PAX_BRITANNICA' AND ModifierId='P0K_TRAIT_FOREIGN_CONTINENT_IZ_BUILDING_PRODUCTION_BONUS';

UPDATE	Traits
SET		Description='LOC_TRAIT_CIVILIZATION_PAX_BRITANNICA_EXPANSION2_DESCRIPTION_JNR_UC_CX'
WHERE	TraitType=(SELECT TraitType FROM TraitModifiers WHERE TraitType='TRAIT_LEADER_PAX_BRITANNICA' AND ModifierId='P0K_TRAIT_HOME_CONTINENT_AMENITY');
--------------------------------------------------------------

-- Germany - Hanseatic League
--------------------------------------------------------------
UPDATE	Modifiers
SET		SubjectRequirementSetId='BUILDING_IS_CAMPUS_TIER2_JNR'
WHERE	ModifierId='P0K_TRAIT_UNIVERSITY_POPULATION_BOOST';

UPDATE	Modifiers
SET		SubjectRequirementSetId='BUILDING_IS_CAMPUS_TIER2_JNR'
WHERE	ModifierId='P0K_TRAIT_UNIVERSITY_HOUSING';

INSERT OR IGNORE INTO Modifiers
		(ModifierId,									ModifierType)
SELECT	'P0K_TRAIT_UNIVERSITY_SCIENCE_BOOST_JNR_UC',	'MODIFIER_PLAYER_CITIES_ADJUST_BUILDING_YIELD_CHANGE'
FROM	Modifiers
WHERE	ModifierId='P0K_TRAIT_UNIVERSITY_SCIENCE_BOOST';

INSERT OR IGNORE INTO Modifiers
		(ModifierId,									ModifierType)
SELECT	'P0K_TRAIT_SCHOOL_SCIENCE_BOOST_JNR_UC',		'MODIFIER_PLAYER_CITIES_ADJUST_BUILDING_YIELD_CHANGE'
FROM	Modifiers
WHERE	ModifierId='P0K_TRAIT_UNIVERSITY_SCIENCE_BOOST';

INSERT OR IGNORE INTO Modifiers
		(ModifierId,									ModifierType)
SELECT	'P0K_TRAIT_FACTORY_PRODUCTION_BOOST_JNR_UC',	'MODIFIER_PLAYER_CITIES_ADJUST_BUILDING_YIELD_CHANGE'
FROM	Modifiers
WHERE	ModifierId='P0K_TRAIT_FACTORY_PRODUCTION_BOOST';

INSERT OR IGNORE INTO Modifiers
		(ModifierId,									ModifierType)
SELECT	'P0K_TRAIT_BANK_GOLD_BOOST_JNR_UC',				'MODIFIER_PLAYER_CITIES_ADJUST_BUILDING_YIELD_CHANGE'
FROM	Modifiers
WHERE	ModifierId='P0K_TRAIT_BANK_GOLD_BOOST';

INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,									Name,			Value)
SELECT	'P0K_TRAIT_UNIVERSITY_SCIENCE_BOOST_JNR_UC',	'BuildingType',	'BUILDING_UNIVERSITY'
FROM	Modifiers
WHERE	ModifierId='P0K_TRAIT_UNIVERSITY_SCIENCE_BOOST';

INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,									Name,			Value)
SELECT	'P0K_TRAIT_UNIVERSITY_SCIENCE_BOOST_JNR_UC',	'YieldType',	'YIELD_SCIENCE'
FROM	Modifiers
WHERE	ModifierId='P0K_TRAIT_UNIVERSITY_SCIENCE_BOOST';

INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,									Name,			Value)
SELECT	'P0K_TRAIT_UNIVERSITY_SCIENCE_BOOST_JNR_UC',	'Amount',		2
FROM	Modifiers
WHERE	ModifierId='P0K_TRAIT_UNIVERSITY_SCIENCE_BOOST';

INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,									Name,			Value)
SELECT	'P0K_TRAIT_SCHOOL_SCIENCE_BOOST_JNR_UC',		'BuildingType',	'BUILDING_JNR_SCHOOL'
FROM	Modifiers
WHERE	ModifierId='P0K_TRAIT_UNIVERSITY_SCIENCE_BOOST';

INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,									Name,			Value)
SELECT	'P0K_TRAIT_SCHOOL_SCIENCE_BOOST_JNR_UC',		'YieldType',	'YIELD_SCIENCE'
FROM	Modifiers
WHERE	ModifierId='P0K_TRAIT_UNIVERSITY_SCIENCE_BOOST';

INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,									Name,			Value)
SELECT	'P0K_TRAIT_SCHOOL_SCIENCE_BOOST_JNR_UC',		'Amount',		2
FROM	Modifiers
WHERE	ModifierId='P0K_TRAIT_UNIVERSITY_SCIENCE_BOOST';

INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,									Name,			Value)
SELECT	'P0K_TRAIT_FACTORY_PRODUCTION_BOOST_JNR_UC',	'BuildingType',	'BUILDING_FACTORY'
FROM	Modifiers
WHERE	ModifierId='P0K_TRAIT_FACTORY_PRODUCTION_BOOST';

INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,									Name,			Value)
SELECT	'P0K_TRAIT_FACTORY_PRODUCTION_BOOST_JNR_UC',	'YieldType',	'YIELD_PRODUCTION'
FROM	Modifiers
WHERE	ModifierId='P0K_TRAIT_FACTORY_PRODUCTION_BOOST';

INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,									Name,			Value)
SELECT	'P0K_TRAIT_FACTORY_PRODUCTION_BOOST_JNR_UC',	'Amount',		2
FROM	Modifiers
WHERE	ModifierId='P0K_TRAIT_FACTORY_PRODUCTION_BOOST';

INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,									Name,			Value)
SELECT	'P0K_TRAIT_BANK_GOLD_BOOST_JNR_UC',				'BuildingType',	'BUILDING_BANK'
FROM	Modifiers
WHERE	ModifierId='P0K_TRAIT_BANK_GOLD_BOOST';

INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,									Name,			Value)
SELECT	'P0K_TRAIT_BANK_GOLD_BOOST_JNR_UC',				'YieldType',	'YIELD_GOLD'
FROM	Modifiers
WHERE	ModifierId='P0K_TRAIT_BANK_GOLD_BOOST';

INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,									Name,			Value)
SELECT	'P0K_TRAIT_BANK_GOLD_BOOST_JNR_UC',				'Amount',		2
FROM	Modifiers
WHERE	ModifierId='P0K_TRAIT_BANK_GOLD_BOOST';

INSERT OR IGNORE INTO TraitModifiers
		(TraitType,									ModifierId)
SELECT	'TRAIT_CIVILIZATION_IMPERIAL_FREE_CITIES',	ModifierId
FROM	Modifiers
WHERE	ModifierId='P0K_TRAIT_UNIVERSITY_SCIENCE_BOOST_JNR_UC';

INSERT OR IGNORE INTO TraitModifiers
		(TraitType,									ModifierId)
SELECT	'TRAIT_CIVILIZATION_IMPERIAL_FREE_CITIES',	ModifierId
FROM	Modifiers
WHERE	ModifierId='P0K_TRAIT_SCHOOL_SCIENCE_BOOST_JNR_UC';

INSERT OR IGNORE INTO TraitModifiers
		(TraitType,									ModifierId)
SELECT	'TRAIT_CIVILIZATION_IMPERIAL_FREE_CITIES',	ModifierId
FROM	Modifiers
WHERE	ModifierId='P0K_TRAIT_FACTORY_PRODUCTION_BOOST_JNR_UC';

INSERT OR IGNORE INTO TraitModifiers
		(TraitType,									ModifierId)
SELECT	'TRAIT_CIVILIZATION_IMPERIAL_FREE_CITIES',	ModifierId
FROM	Modifiers
WHERE	ModifierId='P0K_TRAIT_BANK_GOLD_BOOST_JNR_UC';

DELETE FROM TraitModifiers WHERE TraitType='TRAIT_CIVILIZATION_IMPERIAL_FREE_CITIES' AND ModifierId='P0K_TRAIT_UNIVERSITY_SCIENCE_BOOST';
DELETE FROM TraitModifiers WHERE TraitType='TRAIT_CIVILIZATION_IMPERIAL_FREE_CITIES' AND ModifierId='P0K_TRAIT_FACTORY_PRODUCTION_BOOST';
DELETE FROM TraitModifiers WHERE TraitType='TRAIT_CIVILIZATION_IMPERIAL_FREE_CITIES' AND ModifierId='P0K_TRAIT_BANK_GOLD_BOOST';

UPDATE	Traits
SET		Description='LOC_TRAIT_CIVILIZATION_IMPERIAL_FREE_CITIES_DESCRIPTION_JNR_UC_CX'
WHERE	TraitType=(SELECT TraitType FROM TraitModifiers WHERE TraitType='TRAIT_CIVILIZATION_IMPERIAL_FREE_CITIES' AND ModifierId='P0K_TRAIT_UNIVERSITY_SCIENCE_BOOST_JNR_UC');
--------------------------------------------------------------

-- Rome - Optimus Princeps
--------------------------------------------------------------
INSERT OR IGNORE INTO Requirements
		(RequirementId,												RequirementType)
SELECT	'P0K_ROME_REQUIRES_PLOT_ADJACENT_TO_ACADEMY_UC_JNR',		RequirementType
FROM	Requirements
WHERE	RequirementId='P0K_ROME_REQUIRES_PLOT_ADJACENT_TO_LIBRARY';

INSERT OR IGNORE INTO Requirements
		(RequirementId,												RequirementType)
SELECT	'P0K_ROME_REQUIRES_PLOT_ADJACENT_TO_CAMPUS_TIER1_UC_JNR',	'REQUIREMENT_REQUIREMENTSET_IS_MET'
FROM	Requirements
WHERE	RequirementId='P0K_ROME_REQUIRES_PLOT_ADJACENT_TO_LIBRARY';

INSERT OR IGNORE INTO RequirementArguments
		(RequirementId,												Name,				Value)
SELECT	'P0K_ROME_REQUIRES_PLOT_ADJACENT_TO_ACADEMY_UC_JNR',		'BuildingType',		'BUILDING_JNR_ACADEMY'
FROM	Requirements
WHERE	RequirementId='P0K_ROME_REQUIRES_PLOT_ADJACENT_TO_LIBRARY';

INSERT OR IGNORE INTO RequirementArguments
		(RequirementId,												Name,				Value)
SELECT	'P0K_ROME_REQUIRES_PLOT_ADJACENT_TO_CAMPUS_TIER1_UC_JNR',	'RequirementSetId',	'P0K_ROME_PLOT_ADJACENT_TO_CAMPUS_TIER1_REQUIREMENTS_UC_JNR'
FROM	Requirements
WHERE	RequirementId='P0K_ROME_REQUIRES_PLOT_ADJACENT_TO_LIBRARY';

INSERT OR IGNORE INTO RequirementSets
		(RequirementSetId,												RequirementSetType)
SELECT	'P0K_ROME_PLOT_ADJACENT_TO_CAMPUS_TIER1_REQUIREMENTS_UC_JNR',	'REQUIREMENTSET_TEST_ANY'
FROM	Requirements
WHERE	RequirementId='P0K_ROME_REQUIRES_PLOT_ADJACENT_TO_LIBRARY';

INSERT OR IGNORE INTO RequirementSetRequirements
		(RequirementSetId,												RequirementId)
SELECT	'P0K_ROME_PLOT_ADJACENT_TO_CAMPUS_TIER1_REQUIREMENTS_UC_JNR',	'P0K_ROME_REQUIRES_PLOT_ADJACENT_TO_LIBRARY'
FROM	Requirements
WHERE	RequirementId='P0K_ROME_REQUIRES_PLOT_ADJACENT_TO_LIBRARY';

INSERT OR IGNORE INTO RequirementSetRequirements
		(RequirementSetId,												RequirementId)
SELECT	'P0K_ROME_PLOT_ADJACENT_TO_CAMPUS_TIER1_REQUIREMENTS_UC_JNR',	'P0K_ROME_REQUIRES_PLOT_ADJACENT_TO_ACADEMY_UC_JNR'
FROM	Requirements
WHERE	RequirementId='P0K_ROME_REQUIRES_PLOT_ADJACENT_TO_LIBRARY';

UPDATE	RequirementSetRequirements
SET		RequirementId='P0K_ROME_REQUIRES_PLOT_ADJACENT_TO_CAMPUS_TIER1_UC_JNR'
WHERE	RequirementSetId='P0K_ROME_FARM_ADJACENT_TO_LIBRARY'
		AND RequirementId='P0K_ROME_REQUIRES_PLOT_ADJACENT_TO_LIBRARY';

UPDATE	Traits
SET		Description='LOC_TRAIT_LEADER_TRAJANS_COLUMN_DESCRIPTION_JNR_UC_CX'
WHERE	TraitType=(SELECT TraitType FROM TraitModifiers WHERE TraitType='TRAJANS_COLUMN_TRAIT' AND ModifierId='P0K_TRAIT_FARMS_SCIENCE_ADJACENT_LIBRARY');
--------------------------------------------------------------

-- Korea - Tower of the Moon and Stars
--------------------------------------------------------------
INSERT OR IGNORE INTO Modifiers
		(ModifierId,							ModifierType)
SELECT	'P0K_TRAIT_ACADEMY_FAITH_JNR_UC',		ModifierType
FROM	Modifiers
WHERE	ModifierId='P0K_TRAIT_LIBRARY_FAITH';

INSERT OR IGNORE INTO Modifiers
		(ModifierId,							ModifierType)
SELECT	'P0K_TRAIT_SCHOOL_FAITH_JNR_UC',		ModifierType
FROM	Modifiers
WHERE	ModifierId='P0K_TRAIT_LIBRARY_FAITH';

INSERT OR IGNORE INTO Modifiers
		(ModifierId,							ModifierType)
SELECT	'P0K_TRAIT_LABORATORY_FAITH_JNR_UC',	ModifierType
FROM	Modifiers
WHERE	ModifierId='P0K_TRAIT_LIBRARY_FAITH';

INSERT OR IGNORE INTO Modifiers
		(ModifierId,							ModifierType)
SELECT	'P0K_TRAIT_LIBERAL_ARTS_FAITH_JNR_UC',	ModifierType
FROM	Modifiers
WHERE	ModifierId='P0K_TRAIT_LIBRARY_FAITH';

INSERT OR IGNORE INTO Modifiers
		(ModifierId,							ModifierType)
SELECT	'P0K_TRAIT_EDUCATION_FAITH_JNR_UC',		ModifierType
FROM	Modifiers
WHERE	ModifierId='P0K_TRAIT_LIBRARY_FAITH';

INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,							Name,			Value)
SELECT	'P0K_TRAIT_ACADEMY_FAITH_JNR_UC',		'BuildingType',	'BUILDING_JNR_ACADEMY'
FROM	Modifiers
WHERE	ModifierId='P0K_TRAIT_LIBRARY_FAITH';

INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,							Name,			Value)
SELECT	'P0K_TRAIT_ACADEMY_FAITH_JNR_UC',		'YieldType',	'YIELD_FAITH'
FROM	Modifiers
WHERE	ModifierId='P0K_TRAIT_LIBRARY_FAITH';

INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,							Name,			Value)
SELECT	'P0K_TRAIT_ACADEMY_FAITH_JNR_UC',		'Amount',		2
FROM	Modifiers
WHERE	ModifierId='P0K_TRAIT_LIBRARY_FAITH';

INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,							Name,			Value)
SELECT	'P0K_TRAIT_SCHOOL_FAITH_JNR_UC',		'BuildingType',	'BUILDING_JNR_SCHOOL'
FROM	Modifiers
WHERE	ModifierId='P0K_TRAIT_LIBRARY_FAITH';

INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,							Name,			Value)
SELECT	'P0K_TRAIT_SCHOOL_FAITH_JNR_UC',		'YieldType',	'YIELD_FAITH'
FROM	Modifiers
WHERE	ModifierId='P0K_TRAIT_LIBRARY_FAITH';

INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,							Name,			Value)
SELECT	'P0K_TRAIT_SCHOOL_FAITH_JNR_UC',		'Amount',		3
FROM	Modifiers
WHERE	ModifierId='P0K_TRAIT_LIBRARY_FAITH';

INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,							Name,			Value)
SELECT	'P0K_TRAIT_LABORATORY_FAITH_JNR_UC',	'BuildingType',	'BUILDING_JNR_LABORATORY'
FROM	Modifiers
WHERE	ModifierId='P0K_TRAIT_LIBRARY_FAITH';

INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,							Name,			Value)
SELECT	'P0K_TRAIT_LABORATORY_FAITH_JNR_UC',	'YieldType',	'YIELD_FAITH'
FROM	Modifiers
WHERE	ModifierId='P0K_TRAIT_LIBRARY_FAITH';

INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,							Name,			Value)
SELECT	'P0K_TRAIT_LABORATORY_FAITH_JNR_UC',	'Amount',		4
FROM	Modifiers
WHERE	ModifierId='P0K_TRAIT_LIBRARY_FAITH';

INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,							Name,			Value)
SELECT	'P0K_TRAIT_LIBERAL_ARTS_FAITH_JNR_UC',	'BuildingType',	'BUILDING_JNR_LIBERAL_ARTS'
FROM	Modifiers
WHERE	ModifierId='P0K_TRAIT_LIBRARY_FAITH';

INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,							Name,			Value)
SELECT	'P0K_TRAIT_LIBERAL_ARTS_FAITH_JNR_UC',	'YieldType',	'YIELD_FAITH'
FROM	Modifiers
WHERE	ModifierId='P0K_TRAIT_LIBRARY_FAITH';

INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,							Name,			Value)
SELECT	'P0K_TRAIT_LIBERAL_ARTS_FAITH_JNR_UC',	'Amount',		4
FROM	Modifiers
WHERE	ModifierId='P0K_TRAIT_LIBRARY_FAITH';

INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,							Name,			Value)
SELECT	'P0K_TRAIT_EDUCATION_FAITH_JNR_UC',		'BuildingType',	'BUILDING_JNR_EDUCATION'
FROM	Modifiers
WHERE	ModifierId='P0K_TRAIT_LIBRARY_FAITH';

INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,							Name,			Value)
SELECT	'P0K_TRAIT_EDUCATION_FAITH_JNR_UC',		'YieldType',	'YIELD_FAITH'
FROM	Modifiers
WHERE	ModifierId='P0K_TRAIT_LIBRARY_FAITH';

INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,							Name,			Value)
SELECT	'P0K_TRAIT_EDUCATION_FAITH_JNR_UC',		'Amount',		5
FROM	Modifiers
WHERE	ModifierId='P0K_TRAIT_LIBRARY_FAITH';

UPDATE	ModifierArguments SET Value=3 WHERE ModifierId='P0K_TRAIT_UNIVERSITY_FAITH'		AND Name='Amount';
UPDATE	ModifierArguments SET Value=5 WHERE ModifierId='P0K_TRAIT_RESEARCH_LAB_FAITH'	AND Name='Amount';

INSERT OR IGNORE INTO TraitModifiers
		(TraitType,				ModifierId)
SELECT	'TRAIT_LEADER_HWARANG',	ModifierId
FROM	Modifiers
WHERE	ModifierId='P0K_TRAIT_ACADEMY_FAITH_JNR_UC';

INSERT OR IGNORE INTO TraitModifiers
		(TraitType,				ModifierId)
SELECT	'TRAIT_LEADER_HWARANG',	ModifierId
FROM	Modifiers
WHERE	ModifierId='P0K_TRAIT_SCHOOL_FAITH_JNR_UC';

INSERT OR IGNORE INTO TraitModifiers
		(TraitType,				ModifierId)
SELECT	'TRAIT_LEADER_HWARANG',	ModifierId
FROM	Modifiers
WHERE	ModifierId='P0K_TRAIT_LABORATORY_FAITH_JNR_UC';

INSERT OR IGNORE INTO TraitModifiers
		(TraitType,				ModifierId)
SELECT	'TRAIT_LEADER_HWARANG',	ModifierId
FROM	Modifiers
WHERE	ModifierId='P0K_TRAIT_LIBERAL_ARTS_FAITH_JNR_UC';

INSERT OR IGNORE INTO TraitModifiers
		(TraitType,				ModifierId)
SELECT	'TRAIT_LEADER_HWARANG',	ModifierId
FROM	Modifiers
WHERE	ModifierId='P0K_TRAIT_EDUCATION_FAITH_JNR_UC';

DELETE FROM TraitModifiers WHERE TraitType='TRAIT_LEADER_HWARANG' AND ModifierId='P0K_TRAIT_RESEARCH_LAB_FAITH_POWERED';

UPDATE	Traits
SET		Description='LOC_TRAIT_LEADER_HWARANG_DESCRIPTION_JNR_UC_CX'
WHERE	TraitType=(SELECT TraitType FROM TraitModifiers WHERE TraitType='TRAIT_LEADER_HWARANG' AND ModifierId='P0K_TRAIT_ACADEMY_FAITH_JNR_UC');
--------------------------------------------------------------

-- Sweden - Nobel Prize
--------------------------------------------------------------
UPDATE	Modifiers SET SubjectRequirementSetId='BUILDING_IS_CAMPUS_TIER2_JNR' WHERE ModifierId='P0K_TRAIT_UNIVERSITY_EUREKA';

UPDATE	Traits
SET		Description='LOC_TRAIT_CIVILIZATION_NOBEL_PRIZE_DESCRIPTION_JNR_UC_CX'
WHERE	TraitType=(SELECT TraitType FROM TraitModifiers WHERE TraitType='TRAIT_CIVILIZATION_NOBEL_PRIZE' AND ModifierId='P0K_TRAIT_UNIVERSITY_EUREKA');
--------------------------------------------------------------

-- Maya - Observatory
--------------------------------------------------------------
UPDATE	Modifiers SET SubjectRequirementSetId='BUILDING_IS_CAMPUS_TIER2_JNR' WHERE ModifierId='P0K_TRAIT_UNIVERSITY_EUREKA';

UPDATE	Districts
SET		Description='LOC_DISTRICT_OBSERVATORY_DESCRIPTION_JNR_UC_CX'
WHERE	DistrictType=(SELECT DistrictType FROM DistrictModifiers WHERE DistrictType='DISTRICT_OBSERVATORY' AND ModifierId='P0K_OBSERVATORY_FAITH_PURCHASE_BUILDINGS');
--------------------------------------------------------------