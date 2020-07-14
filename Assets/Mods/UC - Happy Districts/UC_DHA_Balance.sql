-- UC_DHA_Balance
-- Author: JNR
--------------------------------------------------------------

-- EIFFEL TOWER
--------------------------------------------------------------
UPDATE Buildings			SET Description='LOC_BUILDING_EIFFEL_TOWER_DESCRIPTION_JNR_APPEAL_AMENITIES'	WHERE BuildingType='BUILDING_EIFFEL_TOWER';
UPDATE ModifierArguments	SET Value=1																		WHERE ModifierId='EIFFEL_TOWER_ADDAPPEAL' AND Name='Amount';
--------------------------------------------------------------

-- AUSTRALIA

-- TraitModifiers
--------------------------------------------------------------
INSERT OR REPLACE INTO TraitModifiers
		(TraitType,								ModifierId)
SELECT	'TRAIT_CIVILIZATION_LAND_DOWN_UNDER',	'JNR_AUSTRALIA_APPEAL_PENALTY_FLOODPLAINS'				FROM Civilizations	WHERE CivilizationType='CIVILIZATION_AUSTRALIA';

INSERT OR REPLACE INTO TraitModifiers
		(TraitType,								ModifierId)
SELECT	'TRAIT_CIVILIZATION_LAND_DOWN_UNDER',	'JNR_AUSTRALIA_APPEAL_PENALTY_FLOODPLAINS_GRASSLAND'	FROM Civilizations	WHERE CivilizationType='CIVILIZATION_AUSTRALIA';

INSERT OR REPLACE INTO TraitModifiers
		(TraitType,								ModifierId)
SELECT	'TRAIT_CIVILIZATION_LAND_DOWN_UNDER',	'JNR_AUSTRALIA_APPEAL_PENALTY_FLOODPLAINS_PLAINS'		FROM Civilizations	WHERE CivilizationType='CIVILIZATION_AUSTRALIA';

INSERT OR REPLACE INTO TraitModifiers
		(TraitType,								ModifierId)
SELECT	'TRAIT_CIVILIZATION_LAND_DOWN_UNDER',	'JNR_AUSTRALIA_APPEAL_PENALTY_MARSH'					FROM Civilizations	WHERE CivilizationType='CIVILIZATION_AUSTRALIA';
--------------------------------------------------------------

-- Modifiers
--------------------------------------------------------------
INSERT OR REPLACE INTO Modifiers
		(ModifierId,											ModifierType)
VALUES	('JNR_AUSTRALIA_APPEAL_PENALTY_FLOODPLAINS',			'MODIFIER_PLAYER_CITIES_ADJUST_FEATURE_APPEAL_MODIFIER'),
		('JNR_AUSTRALIA_APPEAL_PENALTY_FLOODPLAINS_GRASSLAND',	'MODIFIER_PLAYER_CITIES_ADJUST_FEATURE_APPEAL_MODIFIER'),
		('JNR_AUSTRALIA_APPEAL_PENALTY_FLOODPLAINS_PLAINS',		'MODIFIER_PLAYER_CITIES_ADJUST_FEATURE_APPEAL_MODIFIER'),
		('JNR_AUSTRALIA_APPEAL_PENALTY_MARSH',					'MODIFIER_PLAYER_CITIES_ADJUST_FEATURE_APPEAL_MODIFIER');
--------------------------------------------------------------

-- ModifierArguments
--------------------------------------------------------------
INSERT OR REPLACE INTO ModifierArguments
		(ModifierId,											Name,			Value)
VALUES	('JNR_AUSTRALIA_APPEAL_PENALTY_FLOODPLAINS',			'FeatureType',	'FEATURE_FLOODPLAINS'),
		('JNR_AUSTRALIA_APPEAL_PENALTY_FLOODPLAINS',			'Amount',		-1),
		('JNR_AUSTRALIA_APPEAL_PENALTY_FLOODPLAINS_GRASSLAND',	'FeatureType',	'FEATURE_FLOODPLAINS_GRASSLAND'),
		('JNR_AUSTRALIA_APPEAL_PENALTY_FLOODPLAINS_GRASSLAND',	'Amount',		-1),
		('JNR_AUSTRALIA_APPEAL_PENALTY_FLOODPLAINS_PLAINS',		'FeatureType',	'FEATURE_FLOODPLAINS_PLAINS'),
		('JNR_AUSTRALIA_APPEAL_PENALTY_FLOODPLAINS_PLAINS',		'Amount',		-1),
		('JNR_AUSTRALIA_APPEAL_PENALTY_MARSH',					'FeatureType',	'FEATURE_MARSH'),
		('JNR_AUSTRALIA_APPEAL_PENALTY_MARSH',					'Amount',		-1);