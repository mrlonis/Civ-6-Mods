-- UC_MIL_WarfareExpanded_XP
-- Author: JNR
--------------------------------------------------------------

-- Tags
--------------------------------------------------------------
INSERT OR IGNORE INTO Tags
		(Tag,								Vocabulary)
SELECT	'CLASS_XP_BONUS_WE_MARINE_JNR',		'ABILITY_CLASS'
FROM	UnitPromotionClasses
WHERE	PromotionClassType='PROMOTION_CLASS_MARINE';

INSERT OR IGNORE INTO Tags
		(Tag,								Vocabulary)
SELECT	'CLASS_XP_BONUS_WE_AUTOGUN_JNR',	'ABILITY_CLASS'
FROM	UnitPromotionClasses
WHERE	PromotionClassType='PROMOTION_CLASS_AUTOMATIC_GUN';
--------------------------------------------------------------

-- TypeTags
--------------------------------------------------------------
INSERT OR IGNORE INTO TypeTags
		(Type,										Tag)
SELECT	'ABILITY_BARRACKS_TRAINED_UNIT_XP',			'CLASS_XP_BONUS_WE_MARINE_JNR'
FROM	UnitPromotionClasses
WHERE	PromotionClassType='PROMOTION_CLASS_MARINE';

INSERT OR IGNORE INTO TypeTags
		(Type,										Tag)
SELECT	'ABILITY_MILITARY_ACADEMY_TRAINED_UNIT_XP',	'CLASS_XP_BONUS_WE_MARINE_JNR'
FROM	UnitPromotionClasses
WHERE	PromotionClassType='PROMOTION_CLASS_MARINE';

INSERT OR IGNORE INTO TypeTags
		(Type,										Tag)
SELECT	'ABILITY_JNR_TARGET_RANGE_TRAINED_UNIT_XP',	'CLASS_XP_BONUS_WE_AUTOGUN_JNR'
FROM	UnitPromotionClasses
WHERE	PromotionClassType='PROMOTION_CLASS_AUTOMATIC_GUN';

INSERT OR IGNORE INTO TypeTags
		(Type,										Tag)
SELECT	'ABILITY_MILITARY_ACADEMY_TRAINED_UNIT_XP',	'CLASS_XP_BONUS_WE_AUTOGUN_JNR'
FROM	UnitPromotionClasses
WHERE	PromotionClassType='PROMOTION_CLASS_AUTOMATIC_GUN';

INSERT OR IGNORE INTO TypeTags
		(Type,		Tag)
SELECT	UnitType,	'CLASS_XP_BONUS_WE_MARINE_JNR'
FROM Units WHERE PromotionClass='PROMOTION_CLASS_MARINE';

INSERT OR IGNORE INTO TypeTags
		(Type,		Tag)
SELECT	UnitType,	'CLASS_XP_BONUS_WE_AUTOGUN_JNR'
FROM Units WHERE PromotionClass='PROMOTION_CLASS_AUTOMATIC_GUN';
--------------------------------------------------------------