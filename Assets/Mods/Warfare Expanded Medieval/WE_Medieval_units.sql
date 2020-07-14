----------------
-- Unit Types --
----------------
INSERT INTO Types
(Type,						Kind)
VALUES
('UNIT_ZWEIHANDER',			'KIND_UNIT'),
('UNIT_FEUDAL_SPEARMAN',	'KIND_UNIT'),
('UNIT_YEOMAN_ARCHER',		'KIND_UNIT'),
('UNIT_CONDOTIERRE',		'KIND_UNIT'),
('UNIT_EARLY_KNIGHT',		'KIND_UNIT');

-------------------
-- Unit AI Infos --
-------------------
INSERT INTO UnitAIInfos
(UnitType,					AiType)
VALUES
('UNIT_ZWEIHANDER',			'UNITAI_COMBAT'),
('UNIT_ZWEIHANDER',			'UNITAI_EXPLORE'),
('UNIT_ZWEIHANDER',			'UNITTYPE_MELEE'),
('UNIT_ZWEIHANDER',			'UNITTYPE_LAND_COMBAT'),
('UNIT_FEUDAL_SPEARMAN',	'UNITAI_COMBAT'),
('UNIT_FEUDAL_SPEARMAN',	'UNITAI_EXPLORE'),
('UNIT_FEUDAL_SPEARMAN',	'UNITTYPE_MELEE'),
('UNIT_FEUDAL_SPEARMAN',	'UNITTYPE_LAND_COMBAT'),
('UNIT_YEOMAN_ARCHER',		'UNITAI_COMBAT'),
('UNIT_YEOMAN_ARCHER',		'UNITTYPE_RANGED'),
('UNIT_YEOMAN_ARCHER',		'UNITTYPE_LAND_COMBAT'),
('UNIT_CONDOTIERRE',		'UNITAI_COMBAT'),
('UNIT_CONDOTIERRE',		'UNITAI_EXPLORE'),
('UNIT_CONDOTIERRE',		'UNITTYPE_CAVALRY'),
('UNIT_CONDOTIERRE',		'UNITTYPE_MELEE'),
('UNIT_CONDOTIERRE',		'UNITTYPE_LAND_COMBAT'),
('UNIT_EARLY_KNIGHT',		'UNITAI_COMBAT'),
('UNIT_EARLY_KNIGHT',		'UNITTYPE_MELEE'),
('UNIT_EARLY_KNIGHT',		'UNITTYPE_CAVALRY'),
('UNIT_EARLY_KNIGHT',		'UNITTYPE_LAND_COMBAT');

---------------------
-- Class Type Tags --
---------------------
INSERT INTO TypeTags
(Type,						Tag)
VALUES
('UNIT_ZWEIHANDER',			'CLASS_MELEE'),
('UNIT_FEUDAL_SPEARMAN',	'CLASS_ANTI_CAVALRY'),
('UNIT_YEOMAN_ARCHER',		'CLASS_RANGED'),
('UNIT_CONDOTIERRE',		'CLASS_LIGHT_CAVALRY'),
('UNIT_EARLY_KNIGHT',		'CLASS_HEAVY_CAVALRY');

-----------
-- Units --
-----------
INSERT INTO Units
(UnitType,					BaseMoves,	Cost,	AdvisorType,		BaseSightRange,	ZoneOfControl,	Domain,			FormationClass,					Name,								Description,								PurchaseYield,	PseudoYieldType,	PromotionClass,						Maintenance,	Combat,	RangedCombat,	Range,	Bombard,	StrategicResource,	PrereqTech,						MandatoryObsoleteTech,			CanTargetAir,	AntiAirCombat,	AirSlots,	IgnoreMoves,	Stackable,	PrereqDistrict,	CanCapture,	WMDCapable)
VALUES
('UNIT_ZWEIHANDER',			2,			195,	'ADVISOR_CONQUEST',	2,				'1',			'DOMAIN_LAND',	'FORMATION_CLASS_LAND_COMBAT',	'LOC_UNIT_ZWEIHANDER_NAME',			'LOC_UNIT_ZWEIHANDER_DESCRIPTION',			'YIELD_GOLD',	null,				'PROMOTION_CLASS_MELEE',			3,				48,		0,				0,		0,			'RESOURCE_IRON',	'TECH_MILITARY_ENGINEERING',	'TECH_GUNPOWDER',				'0',			0,				0,			'0',			'0',		null,			'1',		'0'),
('UNIT_FEUDAL_SPEARMAN',	2,			135,	'ADVISOR_CONQUEST',	2,				'1',			'DOMAIN_LAND',	'FORMATION_CLASS_LAND_COMBAT',	'LOC_UNIT_FEUDAL_SPEARMAN_NAME',	'LOC_UNIT_FEUDAL_SPEARMAN_DESCRIPTION',		'YIELD_GOLD',	null,				'PROMOTION_CLASS_ANTI_CAVALRY',		2,				37,		0,				0,		0,			null,				'TECH_MILITARY_TACTICS',		'TECH_STIRRUPS',				'0',			0,				0,			'0',			'0',		null,			'1',		'0'),
('UNIT_YEOMAN_ARCHER',		2,			130,	'ADVISOR_CONQUEST',	2,				'0',			'DOMAIN_LAND',	'FORMATION_CLASS_LAND_COMBAT',	'LOC_UNIT_YEOMAN_ARCHER_NAME',		'LOC_UNIT_YEOMAN_ARCHER_DESCRIPTION',		'YIELD_GOLD',	null,				'PROMOTION_CLASS_RANGED',			2,				26,		36,				2,		0,			null,				'TECH_MACHINERY',				'TECH_MILITARY_ENGINEERING',	'0',			0,				0,			'0',			'0',		null,			'1',		'0'),
('UNIT_CONDOTIERRE',		5,			225,	'ADVISOR_CONQUEST',	2,				'1',			'DOMAIN_LAND',	'FORMATION_CLASS_LAND_COMBAT',	'LOC_UNIT_CONDOTIERRE_NAME',		'LOC_UNIT_CONDOTIERRE_DESCRIPTION',			'YIELD_GOLD',	null,				'PROMOTION_CLASS_LIGHT_CAVALRY',	3,				48,		0,				0,		0,			'RESOURCE_HORSES',	'TECH_STIRRUPS',				'TECH_METAL_CASTING',			'0',			0,				0,			'0',			'0',		null,			'1',		'0'),
('UNIT_EARLY_KNIGHT',		4,			150,	'ADVISOR_CONQUEST',	2,				'1',			'DOMAIN_LAND',	'FORMATION_CLASS_LAND_COMBAT',	'LOC_UNIT_EARLY_KNIGHT_NAME',		'LOC_UNIT_EARLY_KNIGHT_DESCRIPTION',		'YIELD_GOLD',	null,				'PROMOTION_CLASS_HEAVY_CAVALRY',	3,				48,		0,				0,		0,			'RESOURCE_HORSES',	'TECH_APPRENTICESHIP',			'TECH_STIRRUPS',				'0',			0,				0,			'0',			'0',		null,			'1',		'0');

UPDATE Units SET PrereqTech = 'TECH_STIRRUPS'
WHERE UnitType = 'UNIT_PIKEMAN';

UPDATE Units SET PrereqTech = 'TECH_MILITARY_ENGINEERING'
WHERE UnitType = 'UNIT_CROSSBOWMAN';

UPDATE Units SET PrereqTech = 'TECH_MILITARY_TACTICS'
WHERE UnitType = 'UNIT_COURSER';

UPDATE Units SET Combat = 52
WHERE UnitType = 'UNIT_KNIGHT';

---------------
-- Units_XP2 --
---------------
CREATE TABLE IF NOT EXISTS Units_XP2 (UnitType VARCHAR, ResourceMaintenanceAmount INTEGER, ResourceCost INTEGER, ResourceMaintenanceType VARCHAR, TourismBomb INTEGER, CanEarnExperience BOOLEAN, TourismBombPossible BOOLEAN, CanFormMilitaryFormation BOOLEAN, MajorCivOnly BOOLEAN);

INSERT INTO Units_XP2
(UnitType,				ResourceMaintenanceAmount,	ResourceCost,	ResourceMaintenanceType,	TourismBomb,	CanEarnExperience,	TourismBombPossible,	CanFormMilitaryFormation,	MajorCivOnly)
VALUES
('UNIT_ZWEIHANDER',		0,							20,				NULL,						0,				1,					0,						1,							0),
('UNIT_CONDOTIERRE',	0,							20,				NULL,						0,				1,					0,						1,							0),
('UNIT_EARLY_KNIGHT',	0,							20,				NULL,						0,				1,					0,						1,							0);

-------------------
-- Unit Upgrades --
-------------------
INSERT INTO UnitUpgrades
(Unit,						UpgradeUnit)
VALUES
('UNIT_ZWEIHANDER',			'UNIT_MUSKETMAN'),
('UNIT_FEUDAL_SPEARMAN',	'UNIT_PIKEMAN'),
('UNIT_YEOMAN_ARCHER',		'UNIT_CROSSBOWMAN'),
('UNIT_CONDOTIERRE',		'UNIT_STRADIOT'),
('UNIT_EARLY_KNIGHT',		'UNIT_KNIGHT');

UPDATE UnitUpgrades SET UpgradeUnit = 'UNIT_ZWEIHANDER'
WHERE Unit = 'UNIT_LONGSWORDSMAN';

UPDATE UnitUpgrades SET UpgradeUnit = 'UNIT_FEUDAL_SPEARMAN'
WHERE Unit = 'UNIT_HEAVY_INFANTRY';

UPDATE UnitUpgrades SET UpgradeUnit = 'UNIT_YEOMAN_ARCHER'
WHERE Unit = 'UNIT_COMPOSITE_BOWMAN';

UPDATE UnitUpgrades SET UpgradeUnit = 'UNIT_CONDOTIERRE'
WHERE Unit = 'UNIT_COURSER';

UPDATE UnitUpgrades SET UpgradeUnit = 'UNIT_EARLY_KNIGHT'
WHERE Unit = 'UNIT_ARMORED_HORSEMAN';

------------------
-- Unit Replaces --
------------------
UPDATE UnitReplaces SET ReplacesUnitType = 'UNIT_KNIGHT'
WHERE CivUniqueUnitType = 'UNIT_ARABIAN_MAMLUK';

UPDATE UnitReplaces SET ReplacesUnitType = 'UNIT_ZWEIHANDER'
WHERE CivUniqueUnitType = 'UNIT_JAPANESE_SAMURAI';

UPDATE UnitReplaces SET ReplacesUnitType = 'UNIT_ZWEIHANDER'
WHERE CivUniqueUnitType = 'UNIT_GEORGIAN_KHEVSURETI' AND EXISTS (SELECT 1 FROM Units WHERE UnitType = 'UNIT_GEORGIAN_KHEVSURETI');

UPDATE UnitReplaces SET ReplacesUnitType = 'UNIT_CONDOTIERRE'
WHERE CivUniqueUnitType = 'UNIT_HUNGARY_BLACK_ARMY' AND EXISTS (SELECT 1 FROM Units WHERE UnitType = 'UNIT_HUNGARY_BLACK_ARMY');