-- UC_COM_Misc
-- Author: JNR
--------------------------------------------------------------

-- Boosts
--------------------------------------------------------------
UPDATE	Boosts
	SET TriggerDescription='LOC_BOOST_TRIGGER_CAPITALISM_JNR_UC',
		NumItems=2
		WHERE CivicType='CIVIC_CAPITALISM' AND BuildingType='BUILDING_STOCK_EXCHANGE';

UPDATE	Boosts
	SET TriggerDescription='LOC_BOOST_TRIGGER_SQUARE_RIGGING_JNR_UC',
		TriggerLongDescription='LOC_BOOST_TRIGGER_LONGDESC_SQUARE_RIGGING_JNR_UC',
		Unit1Type=NULL,
		BoostClass='BOOST_TRIGGER_HAVE_X_BUILDINGS',
		BuildingType='BUILDING_JNR_CONSULATE',
		NumItems=1
		WHERE TechnologyType='TECH_SQUARE_RIGGING';
--------------------------------------------------------------

-- ModifierStrings
--------------------------------------------------------------
UPDATE ModifierStrings SET Text='LOC_GREATPERSON_HORATIO_NELSON_EXPANSION2_ACTIVE_UC_JNR'	WHERE Text='LOC_GREATPERSON_HORATIO_NELSON_EXPANSION2_ACTIVE';
--------------------------------------------------------------

-- Types
--------------------------------------------------------------
INSERT OR IGNORE INTO Types
		(Type,							Kind)
VALUES	('PROMOTION_JNR_STUNT_MASTER',	'KIND_PROMOTION');
--------------------------------------------------------------

-- UnitPromotions
--------------------------------------------------------------
INSERT OR IGNORE INTO UnitPromotions
		(UnitPromotionType,				Name,									Description,									Level,	PromotionClass)
VALUES	('PROMOTION_JNR_STUNT_MASTER',	'LOC_PROMOTION_JNR_STUNT_MASTER_NAME',	'LOC_PROMOTION_JNR_STUNT_MASTER_DESCRIPTION',	1,		'PROMOTION_CLASS_ROCK_BAND');

UPDATE UnitPromotions SET Description='LOC_PROMOTION_SURF_ROCK_DESCRIPTION_UC_JNR'			WHERE UnitPromotionType='PROMOTION_SURF_ROCK';
--------------------------------------------------------------

-- Modifiers
--------------------------------------------------------------
INSERT OR IGNORE INTO Modifiers
		(ModifierId,										ModifierType)
VALUES	('ROCKBAND_STUNT_MASTER_TOURISM_BOMB_JNR',			'MODIFIER_PLAYER_UNIT_ADJUST_TOURISM_BOMB_IMPROVEMENT'),
		('ROCKBAND_STUNT_MASTER_LEVEL_JNR',					'MODIFIER_PLAYER_UNIT_ADJUST_ROCK_BAND_LEVEL_IMPROVEMENT'),
		('ROCKBAND_STUNT_MASTER_AERODROME_JNR',				'MODIFIER_PLAYER_UNIT_ADJUST_ROCK_BAND_LEVEL_DISTRICT'),
		('ROCKBAND_STUNT_MASTER_AERODROME_MODIFIER_JNR',	'MODIFIER_PLAYER_UNIT_ADJUST_TOURISM_BOMB_DISTRICT');
--------------------------------------------------------------

-- ModifierArguments
--------------------------------------------------------------
INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,										Name,				Value)
VALUES	('ROCKBAND_STUNT_MASTER_TOURISM_BOMB_JNR',			'ImprovementType',	'IMPROVEMENT_AIRSTRIP'),
		('ROCKBAND_STUNT_MASTER_TOURISM_BOMB_JNR',			'Amount',			500),
		('ROCKBAND_STUNT_MASTER_LEVEL_JNR',					'ImprovementType',	'IMPROVEMENT_AIRSTRIP'),
		('ROCKBAND_STUNT_MASTER_LEVEL_JNR',					'Amount',			1),
		('ROCKBAND_STUNT_MASTER_AERODROME_JNR',				'DistrictType',		'DISTRICT_AERODROME'),
		('ROCKBAND_STUNT_MASTER_AERODROME_JNR',				'Amount',			1),
		('ROCKBAND_STUNT_MASTER_AERODROME_MODIFIER_JNR',	'DistrictType',		'DISTRICT_AERODROME'),
		('ROCKBAND_STUNT_MASTER_AERODROME_MODIFIER_JNR',	'Amount',			500);
--------------------------------------------------------------

-- UnitPromotionModifiers
--------------------------------------------------------------
INSERT OR IGNORE INTO UnitPromotionModifiers
		(UnitPromotionType,				ModifierId)
VALUES	('PROMOTION_JNR_STUNT_MASTER',	'ROCKBAND_STUNT_MASTER_TOURISM_BOMB_JNR'),
		('PROMOTION_JNR_STUNT_MASTER',	'ROCKBAND_STUNT_MASTER_LEVEL_JNR'),
		('PROMOTION_JNR_STUNT_MASTER',	'ROCKBAND_STUNT_MASTER_AERODROME_JNR'),
		('PROMOTION_JNR_STUNT_MASTER',	'ROCKBAND_STUNT_MASTER_AERODROME_MODIFIER_JNR');
--------------------------------------------------------------

-- Building_TourismBombs_XP2
--------------------------------------------------------------
INSERT OR IGNORE INTO Building_TourismBombs_XP2
		(BuildingType,					TourismBombValue)
SELECT	'BUILDING_JNR_HAVEN',			TourismBombValue
FROM	Building_TourismBombs_XP2
WHERE	BuildingType='BUILDING_SHIPYARD';

INSERT OR IGNORE INTO Building_TourismBombs_XP2
		(BuildingType,					TourismBombValue)
SELECT	'BUILDING_JNR_CONSULATE',		TourismBombValue
FROM	Building_TourismBombs_XP2
WHERE	BuildingType='BUILDING_SHIPYARD';

INSERT OR IGNORE INTO Building_TourismBombs_XP2
		(BuildingType,					TourismBombValue)
SELECT	'BUILDING_HANGAR',				TourismBombValue
FROM	Building_TourismBombs_XP2
WHERE	BuildingType='BUILDING_SHIPYARD';
--------------------------------------------------------------