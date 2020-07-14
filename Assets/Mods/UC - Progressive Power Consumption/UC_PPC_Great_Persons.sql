-- UC_PPC_Great_Persons
-- Author: JNR
--------------------------------------------------------------

-- Modifiers
--------------------------------------------------------------
INSERT OR IGNORE INTO Modifiers
		(ModifierId,					ModifierType,									SubjectRequirementSetId)
VALUES	('JNR_POWER_SCIENTIST_POINTS',	'MODIFIER_PLAYER_ADJUST_GREAT_PERSON_POINTS',	'CITY_IS_POWERED'),
		('JNR_POWER_MERCHANT_POINTS',	'MODIFIER_PLAYER_ADJUST_GREAT_PERSON_POINTS',	'CITY_IS_POWERED'),
		('JNR_POWER_ENGINEER_POINTS',	'MODIFIER_PLAYER_ADJUST_GREAT_PERSON_POINTS',	'CITY_IS_POWERED'),
		('JNR_POWER_GENERAL_POINTS',	'MODIFIER_PLAYER_ADJUST_GREAT_PERSON_POINTS',	'CITY_IS_POWERED'),
		('JNR_POWER_ADMIRAL_POINTS',	'MODIFIER_PLAYER_ADJUST_GREAT_PERSON_POINTS',	'CITY_IS_POWERED'),
		('JNR_POWER_WRITER_POINTS',		'MODIFIER_PLAYER_ADJUST_GREAT_PERSON_POINTS',	'CITY_IS_POWERED'),
		('JNR_POWER_ARTIST_POINTS',		'MODIFIER_PLAYER_ADJUST_GREAT_PERSON_POINTS',	'CITY_IS_POWERED'),
		('JNR_POWER_MUSICIAN_POINTS',	'MODIFIER_PLAYER_ADJUST_GREAT_PERSON_POINTS',	'CITY_IS_POWERED');
--------------------------------------------------------------

-- ModifierArguments
--------------------------------------------------------------
INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,					Name,					Value)
VALUES	('JNR_POWER_SCIENTIST_POINTS',	'GreatPersonClassType',	'GREAT_PERSON_CLASS_SCIENTIST'),
		('JNR_POWER_MERCHANT_POINTS',	'GreatPersonClassType',	'GREAT_PERSON_CLASS_MERCHANT'),
		('JNR_POWER_ENGINEER_POINTS',	'GreatPersonClassType',	'GREAT_PERSON_CLASS_ENGINEER'),
		('JNR_POWER_GENERAL_POINTS',	'GreatPersonClassType',	'GREAT_PERSON_CLASS_GENERAL'),
		('JNR_POWER_ADMIRAL_POINTS',	'GreatPersonClassType',	'GREAT_PERSON_CLASS_ADMIRAL'),
		('JNR_POWER_WRITER_POINTS',		'GreatPersonClassType',	'GREAT_PERSON_CLASS_WRITER'),
		('JNR_POWER_ARTIST_POINTS',		'GreatPersonClassType',	'GREAT_PERSON_CLASS_ARTIST'),
		('JNR_POWER_MUSICIAN_POINTS',	'GreatPersonClassType',	'GREAT_PERSON_CLASS_MUSICIAN'),
		('JNR_POWER_SCIENTIST_POINTS',	'Amount',				1),
		('JNR_POWER_MERCHANT_POINTS',	'Amount',				1),
		('JNR_POWER_ENGINEER_POINTS',	'Amount',				1),
		('JNR_POWER_GENERAL_POINTS',	'Amount',				1),
		('JNR_POWER_ADMIRAL_POINTS',	'Amount',				1),
		('JNR_POWER_WRITER_POINTS',		'Amount',				1),
		('JNR_POWER_ARTIST_POINTS',		'Amount',				1),
		('JNR_POWER_MUSICIAN_POINTS',	'Amount',				1);
--------------------------------------------------------------

-- BuildingModifiers
--------------------------------------------------------------
INSERT OR IGNORE INTO BuildingModifiers
		(ModifierId,					BuildingType)
SELECT	 'JNR_POWER_SCIENTIST_POINTS',	BuildingType
FROM Buildings_JNRUCPPC_PowerTierYields WHERE Tier=3 AND GPP='SCIENTIST';

INSERT OR IGNORE INTO BuildingModifiers
		(ModifierId,					BuildingType)
SELECT	 'JNR_POWER_MERCHANT_POINTS',	BuildingType
FROM Buildings_JNRUCPPC_PowerTierYields WHERE Tier=3 AND GPP='MERCHANT';

INSERT OR IGNORE INTO BuildingModifiers
		(ModifierId,					BuildingType)
SELECT	 'JNR_POWER_ENGINEER_POINTS',	BuildingType
FROM Buildings_JNRUCPPC_PowerTierYields WHERE Tier=3 AND GPP='ENGINEER';

INSERT OR IGNORE INTO BuildingModifiers
		(ModifierId,					BuildingType)
SELECT	 'JNR_POWER_GENERAL_POINTS',	BuildingType
FROM Buildings_JNRUCPPC_PowerTierYields WHERE Tier=3 AND GPP='GENERAL';

INSERT OR IGNORE INTO BuildingModifiers
		(ModifierId,					BuildingType)
SELECT	 'JNR_POWER_ADMIRAL_POINTS',	BuildingType
FROM Buildings_JNRUCPPC_PowerTierYields WHERE Tier=3 AND GPP='ADMIRAL';

INSERT OR IGNORE INTO BuildingModifiers
		(ModifierId,					BuildingType)
SELECT	 'JNR_POWER_WRITER_POINTS',		BuildingType
FROM Buildings_JNRUCPPC_PowerTierYields WHERE Tier=3 AND GPP='GWAM';

INSERT OR IGNORE INTO BuildingModifiers
		(ModifierId,					BuildingType)
SELECT	 'JNR_POWER_ARTIST_POINTS',		BuildingType
FROM Buildings_JNRUCPPC_PowerTierYields WHERE Tier=3 AND GPP='GWAM';

INSERT OR IGNORE INTO BuildingModifiers
		(ModifierId,					BuildingType)
SELECT	 'JNR_POWER_MUSICIAN_POINTS',	BuildingType
FROM Buildings_JNRUCPPC_PowerTierYields WHERE Tier=3 AND GPP='GWAM';
--------------------------------------------------------------