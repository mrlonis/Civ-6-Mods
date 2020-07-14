-- UC_GP_Tier_123
-- Author: JNR
--------------------------------------------------------------

-- Types
--------------------------------------------------------------
INSERT OR IGNORE INTO Types
		(Type,											Kind)
VALUES	('MODIFIER_JNR_OWNER_MAKE_PROJECT_AVAILABLE',	'KIND_MODIFIER');
--------------------------------------------------------------

-- DynamicModifiers
--------------------------------------------------------------
INSERT OR IGNORE INTO DynamicModifiers
		(ModifierType,									CollectionType,		EffectType)
VALUES	('MODIFIER_JNR_OWNER_MAKE_PROJECT_AVAILABLE',	'COLLECTION_OWNER',	'EFFECT_ADD_PLAYER_PROJECT_AVAILABILITY');
--------------------------------------------------------------

-- Districts
--------------------------------------------------------------
UPDATE Districts SET Description='LOC_DISTRICT_GOVERNMENT_DESCRIPTION_JNR_UC' WHERE DistrictType='DISTRICT_GOVERNMENT';
--------------------------------------------------------------

-- BuildingModifiers
--------------------------------------------------------------
INSERT OR IGNORE INTO BuildingModifiers
		(ModifierId,							BuildingType)
SELECT	'JNR_UC_GP_GOV_1_MOVE_CAPITAL_UNLOCK',	a.BuildingType FROM Buildings a WHERE a.GovernmentTierRequirement='Tier1';

INSERT OR IGNORE INTO BuildingModifiers
		(ModifierId,							BuildingType)
SELECT	'JNR_UC_GP_GOV_2_SETTLER_PRODUCTION',	a.BuildingType FROM Buildings a WHERE a.GovernmentTierRequirement='Tier2';

INSERT OR IGNORE INTO BuildingModifiers
		(ModifierId,							BuildingType)
SELECT	'JNR_UC_GP_GOV_3_TILE_PURCHASE_COST',	a.BuildingType FROM Buildings a WHERE a.GovernmentTierRequirement='Tier3';

INSERT OR IGNORE INTO BuildingModifiers
		(ModifierId,							BuildingType)
SELECT	'JNR_UC_GP_GOV_3_FAST_BORDER_GROWTH',	a.BuildingType FROM Buildings a WHERE a.GovernmentTierRequirement='Tier3';
--------------------------------------------------------------

-- Modifiers
--------------------------------------------------------------
INSERT OR IGNORE INTO Modifiers
		(ModifierId,							ModifierType,										SubjectRequirementSetId)
VALUES	('JNR_UC_GP_GOV_1_MOVE_CAPITAL_UNLOCK',	'MODIFIER_JNR_OWNER_MAKE_PROJECT_AVAILABLE',		'JNR_PLOT_IS_OWNER_CAPITAL_CONTINENT'),
		('JNR_UC_GP_GOV_2_SETTLER_PRODUCTION',	'MODIFIER_PLAYER_UNITS_ADJUST_UNIT_PRODUCTION',		NULL),
		('JNR_UC_GP_GOV_3_TILE_PURCHASE_COST',	'MODIFIER_PLAYER_CITIES_ADJUST_PLOT_PURCHASE_COST',	NULL),
		('JNR_UC_GP_GOV_3_FAST_BORDER_GROWTH',	'MODIFIER_ALL_CITIES_CULTURE_BORDER_EXPANSION',		NULL);
--------------------------------------------------------------

-- ModifierArguments
--------------------------------------------------------------
INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,							Name,			Value)
VALUES	('JNR_UC_GP_GOV_1_MOVE_CAPITAL_UNLOCK',	'ProjectType',	'PROJECT_JNR_GOV_CAPITAL_MOVE'),
		('JNR_UC_GP_GOV_2_SETTLER_PRODUCTION',	'UnitType',		'UNIT_SETTLER'),
		('JNR_UC_GP_GOV_2_SETTLER_PRODUCTION',	'Amount',		50),
		('JNR_UC_GP_GOV_3_TILE_PURCHASE_COST',	'Amount',		-50),
		('JNR_UC_GP_GOV_3_FAST_BORDER_GROWTH',	'Amount',		200);
--------------------------------------------------------------

-- RequirementSets
--------------------------------------------------------------
INSERT OR IGNORE INTO RequirementSets
		(RequirementSetId,						RequirementSetType)
VALUES	('JNR_PLOT_IS_OWNER_CAPITAL_CONTINENT',	'REQUIREMENTSET_TEST_ALL');
--------------------------------------------------------------

-- RequirementSetRequirements
--------------------------------------------------------------
INSERT OR IGNORE INTO RequirementSetRequirements
		(RequirementSetId,						RequirementId)
VALUES	('JNR_PLOT_IS_OWNER_CAPITAL_CONTINENT',	'REQUIRES_JNR_PLOT_IS_OWNER_CAPITAL_CONTINENT');
--------------------------------------------------------------

-- Requirements
--------------------------------------------------------------
INSERT OR IGNORE INTO Requirements
		(RequirementId,										RequirementType)
VALUES	('REQUIRES_JNR_PLOT_IS_OWNER_CAPITAL_CONTINENT',	'REQUIREMENT_PLOT_IS_OWNER_CAPITAL_CONTINENT');
--------------------------------------------------------------
