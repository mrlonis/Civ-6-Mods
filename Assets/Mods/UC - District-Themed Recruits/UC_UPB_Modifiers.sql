-- UC_UPB_Modifiers
-- Author: JNR
--------------------------------------------------------------

-- Types
--------------------------------------------------------------
INSERT OR REPLACE INTO Types
		(Type,												Kind)
VALUES	('MODIFIER_CITY_ADJUST_UNIT_TAG_PRODUCTION_JNR_UC',	'KIND_MODIFIER');
--------------------------------------------------------------

-- DynamicModifiers
--------------------------------------------------------------
INSERT OR REPLACE INTO DynamicModifiers
		(ModifierType,										CollectionType,		EffectType)
VALUES	('MODIFIER_CITY_ADJUST_UNIT_TAG_PRODUCTION_JNR_UC',	'COLLECTION_OWNER',	'EFFECT_ADJUST_CITY_ALL_MILITARY_UNITS_PRODUCTION');
--------------------------------------------------------------

-- Modifiers
--------------------------------------------------------------
INSERT OR REPLACE INTO Modifiers
		(ModifierId,									ModifierType)
VALUES	('CAMPUS_JNR_UPB_SUPPORT',						'MODIFIER_CITY_ADJUST_UNIT_TAG_PRODUCTION_JNR_UC'),
		('HOLY_SITE_JNR_UPB_RECON',						'MODIFIER_CITY_ADJUST_UNIT_TAG_PRODUCTION_JNR_UC'),
		('ENCAMPMENT_JNR_UPB_RANGED',					'MODIFIER_CITY_ADJUST_UNIT_TAG_PRODUCTION_JNR_UC'),
		('ENCAMPMENT_JNR_UPB_ANTI_CAVALRY',				'MODIFIER_CITY_ADJUST_UNIT_TAG_PRODUCTION_JNR_UC'),
		('COMMERCIAL_HUB_JNR_UPB_LIGHT_CAVALRY',		'MODIFIER_CITY_ADJUST_UNIT_TAG_PRODUCTION_JNR_UC'),
		('ENTERTAINMENT_COMPLEX_JNR_UPB_HEAVY_CAVALRY',	'MODIFIER_CITY_ADJUST_UNIT_TAG_PRODUCTION_JNR_UC'),
		('THEATER_JNR_UPB_MELEE',						'MODIFIER_CITY_ADJUST_UNIT_TAG_PRODUCTION_JNR_UC'),
		('INDUSTRIAL_ZONE_JNR_UPB_SIEGE',				'MODIFIER_CITY_ADJUST_UNIT_TAG_PRODUCTION_JNR_UC'),
		('GOVERNMENT_JNR_UPB_SPY',						'MODIFIER_CITY_ADJUST_UNIT_TAG_PRODUCTION_JNR_UC'),
		('SPACEPORT_JNR_UPB_GDR',						'MODIFIER_CITY_ADJUST_UNIT_TAG_PRODUCTION_JNR_UC'),
		('HARBOR_JNR_UPB_TRADER',						'MODIFIER_PLAYER_UNITS_ADJUST_UNIT_PRODUCTION'),
		('AQUEDUCT_JNR_UPB_BUILDER',					'MODIFIER_PLAYER_UNITS_ADJUST_UNIT_PRODUCTION');

INSERT OR REPLACE INTO Modifiers
		(ModifierId,									ModifierType,									SubjectRequirementSetId)
VALUES	('CITY_CENTER_JNR_UPB_SETTLER',					'MODIFIER_PLAYER_UNITS_ADJUST_UNIT_PRODUCTION', 'JNR_COASTAL_DISTRICT_REQUIREMENT');
--------------------------------------------------------------

-- ModifierArguments
--------------------------------------------------------------
INSERT OR REPLACE INTO ModifierArguments
		(ModifierId,									Name,					Value)
VALUES	('CAMPUS_JNR_UPB_SUPPORT',						'PromotionClass',	'PROMOTION_CLASS_SUPPORT'		),
		('CAMPUS_JNR_UPB_SUPPORT',						'StartEra',				'ERA_ANCIENT'				),
		('CAMPUS_JNR_UPB_SUPPORT',						'EndEra',				'ERA_INFORMATION'			),
		('CAMPUS_JNR_UPB_SUPPORT',						'Amount',				20							),
		('HOLY_SITE_JNR_UPB_RECON',						'PromotionClass',		'PROMOTION_CLASS_RECON'		),
		('HOLY_SITE_JNR_UPB_RECON',						'StartEra',				'ERA_ANCIENT'				),
		('HOLY_SITE_JNR_UPB_RECON',						'EndEra',				'ERA_INFORMATION'			),
		('HOLY_SITE_JNR_UPB_RECON',						'Amount',				20							),
		('ENCAMPMENT_JNR_UPB_RANGED',					'PromotionClass',		'PROMOTION_CLASS_RANGED'	),
		('ENCAMPMENT_JNR_UPB_RANGED',					'StartEra',				'ERA_ANCIENT'				),
		('ENCAMPMENT_JNR_UPB_RANGED',					'EndEra',				'ERA_INFORMATION'			),
		('ENCAMPMENT_JNR_UPB_RANGED',					'Amount',				20							),
		('ENCAMPMENT_JNR_UPB_ANTI_CAVALRY',				'PromotionClass',	'PROMOTION_CLASS_ANTI_CAVALRY'	),
		('ENCAMPMENT_JNR_UPB_ANTI_CAVALRY',				'StartEra',				'ERA_ANCIENT'				),
		('ENCAMPMENT_JNR_UPB_ANTI_CAVALRY',				'EndEra',				'ERA_INFORMATION'			),
		('ENCAMPMENT_JNR_UPB_ANTI_CAVALRY',				'Amount',				20							),
		('COMMERCIAL_HUB_JNR_UPB_LIGHT_CAVALRY',		'PromotionClass',	'PROMOTION_CLASS_LIGHT_CAVALRY'	),
		('COMMERCIAL_HUB_JNR_UPB_LIGHT_CAVALRY',		'StartEra',				'ERA_ANCIENT'				),
		('COMMERCIAL_HUB_JNR_UPB_LIGHT_CAVALRY',		'EndEra',				'ERA_INFORMATION'			),
		('COMMERCIAL_HUB_JNR_UPB_LIGHT_CAVALRY',		'Amount',				20							),
		('ENTERTAINMENT_COMPLEX_JNR_UPB_HEAVY_CAVALRY',	'PromotionClass',	'PROMOTION_CLASS_HEAVY_CAVALRY'	),
		('ENTERTAINMENT_COMPLEX_JNR_UPB_HEAVY_CAVALRY',	'StartEra',				'ERA_ANCIENT'				),
		('ENTERTAINMENT_COMPLEX_JNR_UPB_HEAVY_CAVALRY',	'EndEra',				'ERA_INFORMATION'			),
		('ENTERTAINMENT_COMPLEX_JNR_UPB_HEAVY_CAVALRY',	'Amount',				20							),
		('THEATER_JNR_UPB_MELEE',						'PromotionClass',	'PROMOTION_CLASS_MELEE'			),
		('THEATER_JNR_UPB_MELEE',						'StartEra',				'ERA_ANCIENT'				),
		('THEATER_JNR_UPB_MELEE',						'EndEra',				'ERA_INFORMATION'			),
		('THEATER_JNR_UPB_MELEE',						'Amount',				20							),
		('INDUSTRIAL_ZONE_JNR_UPB_SIEGE',				'PromotionClass',	'PROMOTION_CLASS_SIEGE'			),
		('INDUSTRIAL_ZONE_JNR_UPB_SIEGE',				'StartEra',				'ERA_ANCIENT'				),
		('INDUSTRIAL_ZONE_JNR_UPB_SIEGE',				'EndEra',				'ERA_INFORMATION'			),
		('INDUSTRIAL_ZONE_JNR_UPB_SIEGE',				'Amount',				20							),
		('GOVERNMENT_JNR_UPB_SPY',						'PromotionClass',	'PROMOTION_CLASS_SPY'			),
		('GOVERNMENT_JNR_UPB_SPY',						'StartEra',				'ERA_ANCIENT'				),
		('GOVERNMENT_JNR_UPB_SPY',						'EndEra',				'ERA_INFORMATION'			),
		('GOVERNMENT_JNR_UPB_SPY',						'Amount',				20							);

INSERT OR REPLACE INTO ModifierArguments (ModifierId, Name,	Value)
SELECT	'SPACEPORT_JNR_UPB_GDR',						'PromotionClass',	'PROMOTION_CLASS_GIANT_DEATH_ROBOT'
FROM Units		WHERE UnitType='UNIT_GIANT_DEATH_ROBOT';

INSERT OR REPLACE INTO ModifierArguments (ModifierId, Name,	Value)
SELECT	'SPACEPORT_JNR_UPB_GDR',						'StartEra',				'ERA_ANCIENT'
FROM Units		WHERE UnitType='UNIT_GIANT_DEATH_ROBOT';

INSERT OR REPLACE INTO ModifierArguments (ModifierId, Name,	Value)
SELECT	'SPACEPORT_JNR_UPB_GDR',						'EndEra',				'ERA_INFORMATION'
FROM Units		WHERE UnitType='UNIT_GIANT_DEATH_ROBOT';

INSERT OR REPLACE INTO ModifierArguments (ModifierId, Name,	Value)
SELECT	'SPACEPORT_JNR_UPB_GDR',						'Amount',				20
FROM Units		WHERE UnitType='UNIT_GIANT_DEATH_ROBOT';

INSERT OR REPLACE INTO ModifierArguments
		(ModifierId,									Name,					Value)
VALUES	('CITY_CENTER_JNR_UPB_SETTLER',					'UnitType',				'UNIT_SETTLER'),
		('CITY_CENTER_JNR_UPB_SETTLER',					'Amount',				20),
		('HARBOR_JNR_UPB_TRADER',						'UnitType',				'UNIT_TRADER'),
		('HARBOR_JNR_UPB_TRADER',						'Amount',				20),
		('AQUEDUCT_JNR_UPB_BUILDER',					'UnitType',				'UNIT_BUILDER'),
		('AQUEDUCT_JNR_UPB_BUILDER',					'Amount',				20);
--------------------------------------------------------------

-- RequirementSets
--------------------------------------------------------------
INSERT OR REPLACE INTO RequirementSets
		(RequirementSetId,						RequirementSetType)
VALUES	('JNR_COASTAL_DISTRICT_REQUIREMENT',	'REQUIREMENTSET_TEST_ALL');
--------------------------------------------------------------

-- RequirementSetRequirements
--------------------------------------------------------------
INSERT OR REPLACE INTO RequirementSetRequirements
		(RequirementSetId,						RequirementId)
VALUES	('JNR_COASTAL_DISTRICT_REQUIREMENT',	'REQUIRES_PLOT_IS_ADJACENT_TO_COAST');
--------------------------------------------------------------
