-- UC_MIL_Boosts
-- Author: JNR
--------------------------------------------------------------

-- Boosts
--------------------------------------------------------------
UPDATE Boosts SET
TriggerDescription='LOC_BOOST_TRIGGER_GUNPOWDER_JNR_UC',
TriggerLongDescription='LOC_BOOST_TRIGGER_LONGDESC_GUNPOWDER_JNR_UC'
WHERE TechnologyType='TECH_GUNPOWDER';

UPDATE Boosts SET
TriggerDescription='LOC_BOOST_TRIGGER_TOTALITARIANISM_JNR_UC',
TriggerLongDescription='LOC_BOOST_TRIGGER_LONGDESC_TOTALITARIANISM_JNR_UC',
BuildingType='BUILDING_JNR_PRISON',
NumItems=2
WHERE CivicType='CIVIC_TOTALITARIANISM';
--------------------------------------------------------------

-- BuildingModifiers
--------------------------------------------------------------
INSERT OR IGNORE INTO BuildingModifiers
		(BuildingType,				ModifierId)
VALUES	('BUILDING_JNR_CAVALIER',	'CAVALIER_GUNPOWDER_TECHBOOST_JNR');
--------------------------------------------------------------

-- Modifiers
--------------------------------------------------------------
INSERT OR IGNORE INTO Modifiers
		(ModifierId,							ModifierType,									Permanent,	RunOnce)
VALUES	('CAVALIER_GUNPOWDER_TECHBOOST_JNR',	'MODIFIER_PLAYER_GRANT_SPECIFIC_TECH_BOOST',	1,			1);
--------------------------------------------------------------

-- ModifierArguments
--------------------------------------------------------------
INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,							Name,		Value)
VALUES	('CAVALIER_GUNPOWDER_TECHBOOST_JNR',	'TechType',	'TECH_GUNPOWDER');
--------------------------------------------------------------