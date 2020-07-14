-- UC_MIL_WarfareExpanded_Promotions
-- Author: JNR
--------------------------------------------------------------

-- Requirements
--------------------------------------------------------------
INSERT OR IGNORE INTO Requirements
		(RequirementId,							RequirementType)
SELECT	'REQUIRES_UNIT_IS_WE_MARINE_JNR',		'REQUIREMENT_UNIT_PROMOTION_CLASS_MATCHES'
FROM	UnitPromotionClasses
WHERE	PromotionClassType='PROMOTION_CLASS_MARINE';

INSERT OR IGNORE INTO Requirements
		(RequirementId,							RequirementType)
SELECT	'REQUIRES_UNIT_IS_WE_AUTOGUN_JNR',		'REQUIREMENT_UNIT_PROMOTION_CLASS_MATCHES'
FROM	UnitPromotionClasses
WHERE	PromotionClassType='PROMOTION_CLASS_AUTOMATIC_GUN';

INSERT OR IGNORE INTO Requirements
		(RequirementId,							RequirementType)
SELECT	'REQUIRES_UNIT_IS_WE_NAVBOMBARD_JNR',	'REQUIREMENT_UNIT_PROMOTION_CLASS_MATCHES'
FROM	UnitPromotionClasses
WHERE	PromotionClassType='PROMOTION_CLASS_NAVAL_BOMBARD';

INSERT OR IGNORE INTO Requirements
		(RequirementId,							RequirementType)
SELECT	'REQUIRES_UNIT_IS_AIRATTACK_JNR',		'REQUIREMENT_UNIT_PROMOTION_CLASS_MATCHES'
FROM	UnitPromotionClasses
WHERE	PromotionClassType='PROMOTION_CLASS_AIR_ATTACK';
--------------------------------------------------------------

-- RequirementArguments
--------------------------------------------------------------
INSERT OR IGNORE INTO RequirementArguments
		(RequirementId,							Name,					Value)
SELECT	'REQUIRES_UNIT_IS_WE_MARINE_JNR',		'UnitPromotionClass',	PromotionClassType
FROM	UnitPromotionClasses
WHERE	PromotionClassType='PROMOTION_CLASS_MARINE';

INSERT OR IGNORE INTO RequirementArguments
		(RequirementId,							Name,					Value)
SELECT	'REQUIRES_UNIT_IS_WE_AUTOGUN_JNR',		'UnitPromotionClass',	PromotionClassType
FROM	UnitPromotionClasses
WHERE	PromotionClassType='PROMOTION_CLASS_AUTOMATIC_GUN';

INSERT OR IGNORE INTO RequirementArguments
		(RequirementId,							Name,					Value)
SELECT	'REQUIRES_UNIT_IS_WE_NAVBOMBARD_JNR',	'UnitPromotionClass',	PromotionClassType
FROM	UnitPromotionClasses
WHERE	PromotionClassType='PROMOTION_CLASS_NAVAL_BOMBARD';

INSERT OR IGNORE INTO RequirementArguments
		(RequirementId,							Name,					Value)
SELECT	'REQUIRES_UNIT_IS_AIRATTACK_JNR',		'UnitPromotionClass',	PromotionClassType
FROM	UnitPromotionClasses
WHERE	PromotionClassType='PROMOTION_CLASS_AIR_ATTACK';
--------------------------------------------------------------

-- RequirementSetRequirements
--------------------------------------------------------------
INSERT OR IGNORE INTO RequirementSetRequirements
		(RequirementSetId,								RequirementId)
SELECT	'MILITARY_ACADEMY_PROMOTION_REQUIREMENTS_JNR',	'REQUIRES_UNIT_IS_WE_MARINE_JNR'
FROM	UnitPromotionClasses
WHERE	PromotionClassType='PROMOTION_CLASS_MARINE';

INSERT OR IGNORE INTO RequirementSetRequirements
		(RequirementSetId,								RequirementId)
SELECT	'MILITARY_ACADEMY_PROMOTION_REQUIREMENTS_JNR',	'REQUIRES_UNIT_IS_WE_AUTOGUN_JNR'
FROM	UnitPromotionClasses
WHERE	PromotionClassType='PROMOTION_CLASS_AUTOMATIC_GUN';

INSERT OR IGNORE INTO RequirementSetRequirements
		(RequirementSetId,								RequirementId)
SELECT	'MILITARY_ACADEMY_PROMOTION_REQUIREMENTS_JNR',	'REQUIRES_UNIT_IS_WE_NAVBOMBARD_JNR'
FROM	UnitPromotionClasses
WHERE	PromotionClassType='PROMOTION_CLASS_NAVAL_BOMBARD';

INSERT OR IGNORE INTO RequirementSetRequirements
		(RequirementSetId,								RequirementId)
SELECT	'MILITARY_ACADEMY_PROMOTION_REQUIREMENTS_JNR',	'REQUIRES_UNIT_IS_AIRATTACK_JNR'
FROM	UnitPromotionClasses
WHERE	PromotionClassType='PROMOTION_CLASS_AIR_ATTACK';
--------------------------------------------------------------