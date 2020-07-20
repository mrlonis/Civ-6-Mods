-- UC_MIL_Redux_Delete
-- Author: JNR
--------------------------------------------------------------

UPDATE ModifierArguments SET Value=1 WHERE ModifierId='HANGAR_BONUS_AIR_SLOTS';

DELETE FROM BuildingModifiers WHERE BuildingType='BUILDING_ARMORY'				AND ModifierId='JNR_ARMORY_PRODUCTION_STRATEGIC_REDUX';
DELETE FROM BuildingModifiers WHERE BuildingType='BUILDING_MILITARY_ACADEMY'	AND ModifierId='JNR_MILITARY_ACADEMY_PROMOTION_REDUX';
DELETE FROM BuildingModifiers WHERE BuildingType='BUILDING_SEAPORT'				AND ModifierId='JNR_BUILDING_SEAPORT_PROMOTION_REDUX';
DELETE FROM BuildingModifiers WHERE BuildingType='BUILDING_HANGAR'				AND ModifierId='JNR_BUILDING_HANGAR_PROMOTION_REDUX';

INSERT OR IGNORE INTO BuildingModifiers
		(BuildingType,			ModifierId)
VALUES	('BUILDING_AIRPORT',	'AIRPORT_TRAINED_AIRCRAFT_XP_MODIFIER');