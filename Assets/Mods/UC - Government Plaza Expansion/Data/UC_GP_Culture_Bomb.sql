-- UC_GP_Culture_Bomb
-- Author: JNR
--------------------------------------------------------------

-- TraitModifiers
--------------------------------------------------------------
INSERT OR IGNORE INTO TraitModifiers
		(ModifierId,								TraitType)
VALUES	('JNR_CULTURE_BOMB_TRIGGER_GOVERNMENT',		'TRAIT_LEADER_MAJOR_CIV');
--------------------------------------------------------------

-- Modifiers
--------------------------------------------------------------
INSERT OR IGNORE INTO Modifiers
		(ModifierId,								ModifierType)
VALUES	('JNR_CULTURE_BOMB_TRIGGER_GOVERNMENT',		'MODIFIER_PLAYER_ADD_CULTURE_BOMB_TRIGGER');
--------------------------------------------------------------

-- ModifierArguments
--------------------------------------------------------------
INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,								Name,			Value)
VALUES	('JNR_CULTURE_BOMB_TRIGGER_GOVERNMENT',		'DistrictType',	'DISTRICT_GOVERNMENT');
--------------------------------------------------------------