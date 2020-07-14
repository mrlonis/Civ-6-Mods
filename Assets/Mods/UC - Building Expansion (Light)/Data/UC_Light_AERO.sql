-- UC_Light_AERO
-- Author: JNR
--------------------------------------------------------------

-- Buildings
--------------------------------------------------------------
UPDATE Buildings SET Description='LOC_BUILDING_HANGAR_DESCRIPTION_UC_JNR_LIGHT'		WHERE BuildingType='BUILDING_HANGAR';
UPDATE Buildings SET Description='LOC_BUILDING_AIRPORT_DESCRIPTION_UC_JNR_LIGHT'	WHERE BuildingType='BUILDING_AIRPORT';
--------------------------------------------------------------

-- Modifiers
--------------------------------------------------------------
INSERT OR IGNORE INTO Modifiers
		(ModifierId,							ModifierType,											SubjectRequirementSetId)
VALUES	('JNR_BUILDING_HANGAR_PROMOTION_LIGHT',	'MODIFIER_CITY_TRAINED_UNITS_ADJUST_GRANT_EXPERIENCE',	'HANGAR_UNIT_REQUIREMENTS'),
		('JNR_AIRPORT_TRADE_ROUTE_CAPACITY',	'MODIFIER_PLAYER_ADJUST_TRADE_ROUTE_CAPACITY',			NULL),
		('JNR_AIRPORT_TOURISM_MODERN_ERA',		'MODIFIER_SINGLE_CITY_ADJUST_TOURISM_LATE_ERAS',		NULL);
--------------------------------------------------------------

-- ModifierArguments
--------------------------------------------------------------
INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,							Name,			Value)
VALUES	('JNR_BUILDING_HANGAR_PROMOTION_LIGHT',	'Amount',		-1),
		('JNR_AIRPORT_TRADE_ROUTE_CAPACITY',	'Amount',		1),
		('JNR_AIRPORT_TOURISM_MODERN_ERA',		'MinimumEra',	'ERA_MODERN'),
		('JNR_AIRPORT_TOURISM_MODERN_ERA',		'Modifier',		25);

UPDATE ModifierArguments SET Value=2	WHERE ModifierId='HANGAR_BONUS_AIR_SLOTS';
UPDATE ModifierArguments SET Value=50	WHERE ModifierId='HANGAR_TRAINED_AIRCRAFT_XP';
--------------------------------------------------------------

-- BuildingModifiers
--------------------------------------------------------------
INSERT OR IGNORE INTO BuildingModifiers
		(BuildingType,			ModifierId)
VALUES	('BUILDING_HANGAR',		'JNR_BUILDING_HANGAR_PROMOTION_LIGHT'),
		('BUILDING_AIRPORT',	'JNR_AIRPORT_TRADE_ROUTE_CAPACITY'),
		('BUILDING_AIRPORT',	'JNR_AIRPORT_TOURISM_MODERN_ERA_LIGHT');

DELETE FROM BuildingModifiers WHERE BuildingType='BUILDING_AIRPORT' AND ModifierId='AIRPORT_TRAINED_AIRCRAFT_XP_MODIFIER';
--------------------------------------------------------------