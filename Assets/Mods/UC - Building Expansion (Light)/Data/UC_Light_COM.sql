-- UC_Light_COM
-- Author: JNR
--------------------------------------------------------------

-- Buildings
--------------------------------------------------------------
UPDATE Buildings SET Description='LOC_BUILDING_BANK_DESCRIPTION_UC_JNR_LIGHT'			WHERE BuildingType='BUILDING_BANK';
UPDATE Buildings SET Description='LOC_BUILDING_GRAND_BAZAAR_DESCRIPTION_UC_JNR_LIGHT'	WHERE BuildingType='BUILDING_GRAND_BAZAAR';
UPDATE Buildings SET Description='LOC_BUILDING_STOCK_EXCHANGE_DESCRIPTION_UC_JNR_LIGHT'	WHERE BuildingType='BUILDING_STOCK_EXCHANGE';

UPDATE Buildings SET RegionalRange=6 WHERE BuildingType='BUILDING_STOCK_EXCHANGE';
--------------------------------------------------------------

-- Building_YieldChanges
--------------------------------------------------------------
DELETE FROM Building_YieldChanges								WHERE BuildingType='BUILDING_BANK'				AND YieldType='YIELD_GOLD';
DELETE FROM Building_YieldChanges								WHERE BuildingType='BUILDING_GRAND_BAZAAR'		AND YieldType='YIELD_GOLD';
UPDATE Building_YieldChanges SET YieldChange=3					WHERE BuildingType='BUILDING_STOCK_EXCHANGE'	AND YieldType='YIELD_GOLD';
--------------------------------------------------------------

-- Modifiers
--------------------------------------------------------------
INSERT OR IGNORE INTO Modifiers
		(ModifierId,										ModifierType,												SubjectRequirementSetId)
VALUES	('JNR_BANK_GOLD_POPULATION_LIGHT',					'MODIFIER_SINGLE_CITY_ADJUST_CITY_YIELD_PER_POPULATION',	NULL),
		('JNR_STOCK_EXCHANGE_GOLD_MODIFIER_LIGHT',			'MODIFIER_SINGLE_CITY_ADJUST_CITY_YIELD_MODIFIER',			NULL),
		('JNR_STOCK_EXCHANGE_GOLD_MODIFIER_POWERED_LIGHT',	'MODIFIER_SINGLE_CITY_ADJUST_CITY_YIELD_MODIFIER',			'CITY_IS_POWERED');
--------------------------------------------------------------

-- ModifierArguments
--------------------------------------------------------------
INSERT OR IGNORE INTO ModifierArguments
		(ModifierId,										Name,			Value)
VALUES	('JNR_BANK_GOLD_POPULATION_LIGHT',					'YieldType',	'YIELD_GOLD'),
		('JNR_BANK_GOLD_POPULATION_LIGHT',					'Amount',		0.4),
		('JNR_STOCK_EXCHANGE_GOLD_MODIFIER_LIGHT',			'YieldType',	'YIELD_GOLD'),
		('JNR_STOCK_EXCHANGE_GOLD_MODIFIER_LIGHT',			'Amount',		5),
		('JNR_STOCK_EXCHANGE_GOLD_MODIFIER_POWERED_LIGHT',	'YieldType',	'YIELD_GOLD'),
		('JNR_STOCK_EXCHANGE_GOLD_MODIFIER_POWERED_LIGHT',	'Amount',		5);
--------------------------------------------------------------

-- BuildingModifiers
--------------------------------------------------------------
INSERT OR IGNORE INTO BuildingModifiers
		(BuildingType,				ModifierId)
VALUES	('BUILDING_BANK',			'JNR_BANK_GOLD_POPULATION_LIGHT'),
		('BUILDING_GRAND_BAZAAR',	'JNR_BANK_GOLD_POPULATION_LIGHT'),
		('BUILDING_STOCK_EXCHANGE',	'JNR_STOCK_EXCHANGE_GOLD_MODIFIER_LIGHT'),
		('BUILDING_STOCK_EXCHANGE',	'JNR_STOCK_EXCHANGE_GOLD_MODIFIER_POWERED_LIGHT');
--------------------------------------------------------------