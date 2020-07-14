-- UC_COM_RwF
-- Author: JNR
--------------------------------------------------------------

-- Requirements
--------------------------------------------------------------
INSERT INTO Requirements
		(RequirementId,													RequirementType)
SELECT	'P0K_PHOENICIA_REQUIRES_WITHIN_2_OF_LIGHTHOUSE_TRADE_UC_JNR',	RequirementType
FROM	Requirements
WHERE	RequirementId='P0K_PHOENICIA_REQUIRES_WITHIN_2_OF_LIGHTHOUSE';
--------------------------------------------------------------

-- RequirementArguments
--------------------------------------------------------------
INSERT INTO RequirementArguments
		(RequirementId,													Name,			Value)
SELECT	'P0K_PHOENICIA_REQUIRES_WITHIN_2_OF_LIGHTHOUSE_TRADE_UC_JNR',	'BuildingType',	'BUILDING_JNR_LIGHTHOUSE_TRADE'
FROM	Requirements
WHERE	RequirementId='P0K_PHOENICIA_REQUIRES_WITHIN_2_OF_LIGHTHOUSE';

INSERT INTO RequirementArguments
		(RequirementId,													Name,			Value)
SELECT	'P0K_PHOENICIA_REQUIRES_WITHIN_2_OF_LIGHTHOUSE_TRADE_UC_JNR',	'MinRange',		0
FROM	Requirements
WHERE	RequirementId='P0K_PHOENICIA_REQUIRES_WITHIN_2_OF_LIGHTHOUSE';

INSERT INTO RequirementArguments
		(RequirementId,													Name,			Value)
SELECT	'P0K_PHOENICIA_REQUIRES_WITHIN_2_OF_LIGHTHOUSE_TRADE_UC_JNR',	'MaxRange',		2
FROM	Requirements
WHERE	RequirementId='P0K_PHOENICIA_REQUIRES_WITHIN_2_OF_LIGHTHOUSE';
--------------------------------------------------------------

-- RequirementSets
--------------------------------------------------------------
UPDATE RequirementSets SET RequirementSetType='REQUIREMENTSET_TEST_ANY' WHERE RequirementSetId='P0K_PHOENICIA_WITHIN_2_OF_LIGHTHOUSE';
--------------------------------------------------------------

-- RequirementSets
--------------------------------------------------------------
INSERT INTO RequirementSetRequirements
		(RequirementSetId,						RequirementId)
SELECT	'P0K_PHOENICIA_WITHIN_2_OF_LIGHTHOUSE',	'P0K_PHOENICIA_REQUIRES_WITHIN_2_OF_LIGHTHOUSE_TRADE_UC_JNR'
FROM	Requirements
WHERE	RequirementId='P0K_PHOENICIA_REQUIRES_WITHIN_2_OF_LIGHTHOUSE';
--------------------------------------------------------------