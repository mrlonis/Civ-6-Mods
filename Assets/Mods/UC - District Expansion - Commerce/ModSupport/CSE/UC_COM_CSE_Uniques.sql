-- UC_COM_CSE_Uniques
-- Author: JNR
--------------------------------------------------------------

-- Requirements
--------------------------------------------------------------
INSERT OR IGNORE INTO Requirements
		(RequirementId,							RequirementType)
VALUES	('REQUIRES_CITY_HAS_HARBOR_TIER1_JNR',	'REQUIREMENT_REQUIREMENTSET_IS_MET'),
		('REQUIRES_CITY_HAS_HARBOR_TIER2_JNR',	'REQUIREMENT_REQUIREMENTSET_IS_MET'),
		('REQUIRES_CITY_HAS_HARBOR_TIER3_JNR',	'REQUIREMENT_REQUIREMENTSET_IS_MET');
--------------------------------------------------------------

-- RequirementArguments
--------------------------------------------------------------
INSERT OR IGNORE INTO RequirementArguments
		(RequirementId,							Name,				Value)
VALUES	('REQUIRES_CITY_HAS_HARBOR_TIER1_JNR',	'RequirementSetId',	'BUILDING_IS_HARBOR_TIER1_JNR'),
		('REQUIRES_CITY_HAS_HARBOR_TIER2_JNR',	'RequirementSetId',	'BUILDING_IS_HARBOR_TIER2_JNR'),
		('REQUIRES_CITY_HAS_HARBOR_TIER3_JNR',	'RequirementSetId',	'BUILDING_IS_HARBOR_TIER3_JNR');
--------------------------------------------------------------

-- RequirementSetRequirements
--------------------------------------------------------------
UPDATE RequirementSetRequirements SET RequirementId='REQUIRES_CITY_HAS_HARBOR_TIER1_JNR' WHERE RequirementId='REQ_CSE_DAKAR_CITY_HAS_LIGHTHOUSE';
UPDATE RequirementSetRequirements SET RequirementId='REQUIRES_CITY_HAS_HARBOR_TIER2_JNR' WHERE RequirementId='REQ_CSE_DAKAR_CITY_HAS_SHIPYARD';
UPDATE RequirementSetRequirements SET RequirementId='REQUIRES_CITY_HAS_HARBOR_TIER3_JNR' WHERE RequirementId='REQ_CSE_DAKAR_CITY_HAS_SEAPORT';
--------------------------------------------------------------
-- Modifiers
--------------------------------------------------------------
UPDATE Modifiers SET SubjectRequirementSetId='BUILDING_IS_HARBOR_TIER1_JNR'	WHERE ModifierId='CSE_HAVANA_LIGHTHOUSE_WRITING';
UPDATE Modifiers SET SubjectRequirementSetId='BUILDING_IS_HARBOR_TIER1_JNR'	WHERE ModifierId='CSE_HAVANA_LIGHTHOUSE_SCULPTURE';
UPDATE Modifiers SET SubjectRequirementSetId='BUILDING_IS_HARBOR_TIER1_JNR'	WHERE ModifierId='CSE_HAVANA_LIGHTHOUSE_LANDSCAPE';
UPDATE Modifiers SET SubjectRequirementSetId='BUILDING_IS_HARBOR_TIER1_JNR'	WHERE ModifierId='CSE_HAVANA_LIGHTHOUSE_RELIGIOUS';
UPDATE Modifiers SET SubjectRequirementSetId='BUILDING_IS_HARBOR_TIER1_JNR'	WHERE ModifierId='CSE_HAVANA_LIGHTHOUSE_MUSIC';
UPDATE Modifiers SET SubjectRequirementSetId='BUILDING_IS_HARBOR_TIER2_JNR'	WHERE ModifierId='CSE_HAVANA_SHIPYARD_WRITING';
UPDATE Modifiers SET SubjectRequirementSetId='BUILDING_IS_HARBOR_TIER2_JNR'	WHERE ModifierId='CSE_HAVANA_SHIPYARD_SCULPTURE';
UPDATE Modifiers SET SubjectRequirementSetId='BUILDING_IS_HARBOR_TIER2_JNR'	WHERE ModifierId='CSE_HAVANA_SHIPYARD_LANDSCAPE';
UPDATE Modifiers SET SubjectRequirementSetId='BUILDING_IS_HARBOR_TIER2_JNR'	WHERE ModifierId='CSE_HAVANA_SHIPYARD_RELIGIOUS';
UPDATE Modifiers SET SubjectRequirementSetId='BUILDING_IS_HARBOR_TIER2_JNR'	WHERE ModifierId='CSE_HAVANA_SHIPYARD_MUSIC';
UPDATE Modifiers SET SubjectRequirementSetId='BUILDING_IS_HARBOR_TIER3_JNR'	WHERE ModifierId='CSE_HAVANA_SEAPORT_WRITING';
UPDATE Modifiers SET SubjectRequirementSetId='BUILDING_IS_HARBOR_TIER3_JNR'	WHERE ModifierId='CSE_HAVANA_SEAPORT_SCULPTURE';
UPDATE Modifiers SET SubjectRequirementSetId='BUILDING_IS_HARBOR_TIER3_JNR'	WHERE ModifierId='CSE_HAVANA_SEAPORT_LANDSCAPE';
UPDATE Modifiers SET SubjectRequirementSetId='BUILDING_IS_HARBOR_TIER3_JNR'	WHERE ModifierId='CSE_HAVANA_SEAPORT_RELIGIOUS';
UPDATE Modifiers SET SubjectRequirementSetId='BUILDING_IS_HARBOR_TIER3_JNR'	WHERE ModifierId='CSE_HAVANA_SEAPORT_MUSIC';
--------------------------------------------------------------