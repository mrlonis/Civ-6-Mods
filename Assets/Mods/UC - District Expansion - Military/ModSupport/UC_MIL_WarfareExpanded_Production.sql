-- UC_MIL_WarfareExpanded_Production
-- Author: JNR
--------------------------------------------------------------

-- Modifiers
--------------------------------------------------------------
INSERT OR IGNORE INTO Modifiers
		(ModifierId,								ModifierType)
SELECT	'JNR_ARMORY_TRAIN_MARINE_PRODUCTION',		'MODIFIER_JNR_SINGLE_CITY_ADJUST_MILITARY_UNITS_PRODUCTION'
FROM	UnitPromotionClasses
WHERE	PromotionClassType='PROMOTION_CLASS_MARINE';

INSERT OR IGNORE INTO Modifiers
		(ModifierId,								ModifierType)
SELECT	'JNR_ARMORY_TRAIN_AUTOGUN_PRODUCTION',		'MODIFIER_JNR_SINGLE_CITY_ADJUST_MILITARY_UNITS_PRODUCTION'
FROM	UnitPromotionClasses
WHERE	PromotionClassType='PROMOTION_CLASS_AUTOMATIC_GUN';

INSERT OR IGNORE INTO Modifiers
		(ModifierId,								ModifierType)
SELECT	'JNR_SHIPYARD_TRAIN_NAVBOMBARD_PRODUCTION',	'MODIFIER_JNR_SINGLE_CITY_ADJUST_MILITARY_UNITS_PRODUCTION'
FROM	UnitPromotionClasses
WHERE	PromotionClassType='PROMOTION_CLASS_NAVAL_BOMBARD';

INSERT OR IGNORE INTO Modifiers
		(ModifierId,								ModifierType)
SELECT	'JNR_ARMORY_TRAIN_AIRATTACK_PRODUCTION',	'MODIFIER_JNR_SINGLE_CITY_ADJUST_MILITARY_UNITS_PRODUCTION'
FROM	UnitPromotionClasses
WHERE	PromotionClassType='PROMOTION_CLASS_AIR_ATTACK';
--------------------------------------------------------------

-- ModifierArguments
--------------------------------------------------------------
INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,								Name,				Value)
SELECT	'JNR_ARMORY_TRAIN_MARINE_PRODUCTION',		'Amount',			50
FROM	UnitPromotionClasses
WHERE	PromotionClassType='PROMOTION_CLASS_MARINE';

INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,								Name,				Value)
SELECT	'JNR_ARMORY_TRAIN_AUTOGUN_PRODUCTION',		'Amount',			50
FROM	UnitPromotionClasses
WHERE	PromotionClassType='PROMOTION_CLASS_AUTOMATIC_GUN';

INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,								Name,				Value)
SELECT	'JNR_SHIPYARD_TRAIN_NAVBOMBARD_PRODUCTION',	'Amount',			50
FROM	UnitPromotionClasses
WHERE	PromotionClassType='PROMOTION_CLASS_NAVAL_BOMBARD';

INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,								Name,				Value)
SELECT	'JNR_ARMORY_TRAIN_AIRATTACK_PRODUCTION',	'Amount',			50
FROM	UnitPromotionClasses
WHERE	PromotionClassType='PROMOTION_CLASS_AIR_ATTACK';

INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,								Name,				Value)
SELECT	'JNR_ARMORY_TRAIN_MARINE_PRODUCTION',		'PromotionClass',	PromotionClassType
FROM	UnitPromotionClasses
WHERE	PromotionClassType='PROMOTION_CLASS_MARINE';

INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,								Name,				Value)
SELECT	'JNR_ARMORY_TRAIN_AUTOGUN_PRODUCTION',		'PromotionClass',	PromotionClassType
FROM	UnitPromotionClasses
WHERE	PromotionClassType='PROMOTION_CLASS_AUTOMATIC_GUN';

INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,								Name,				Value)
SELECT	'JNR_SHIPYARD_TRAIN_NAVBOMBARD_PRODUCTION',	'PromotionClass',	PromotionClassType
FROM	UnitPromotionClasses
WHERE	PromotionClassType='PROMOTION_CLASS_NAVAL_BOMBARD';

INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,								Name,				Value)
SELECT	'JNR_ARMORY_TRAIN_AIRATTACK_PRODUCTION',	'PromotionClass',	PromotionClassType
FROM	UnitPromotionClasses
WHERE	PromotionClassType='PROMOTION_CLASS_AIR_ATTACK';
--------------------------------------------------------------

-- BuildingModifiers
--------------------------------------------------------------
INSERT OR IGNORE INTO BuildingModifiers
		(ModifierId,								BuildingType)
SELECT	'JNR_ARMORY_TRAIN_MARINE_PRODUCTION',		'BUILDING_ARMORY'
FROM	UnitPromotionClasses
WHERE	PromotionClassType='PROMOTION_CLASS_MARINE';

INSERT OR IGNORE INTO BuildingModifiers
		(ModifierId,								BuildingType)
SELECT	'JNR_ARMORY_TRAIN_AUTOGUN_PRODUCTION',		'BUILDING_ARMORY'
FROM	UnitPromotionClasses
WHERE	PromotionClassType='PROMOTION_CLASS_AUTOMATIC_GUN';

INSERT OR IGNORE INTO BuildingModifiers
		(ModifierId,								BuildingType)
SELECT	'JNR_SHIPYARD_TRAIN_NAVBOMBARD_PRODUCTION',	'BUILDING_SHIPYARD'
FROM	UnitPromotionClasses
WHERE	PromotionClassType='PROMOTION_CLASS_NAVAL_BOMBARD';

INSERT OR IGNORE INTO BuildingModifiers
		(ModifierId,								BuildingType)
SELECT	'JNR_ARMORY_TRAIN_AIRATTACK_PRODUCTION',	'BUILDING_HANGAR'
FROM	UnitPromotionClasses
WHERE	PromotionClassType='PROMOTION_CLASS_AIR_ATTACK';
--------------------------------------------------------------