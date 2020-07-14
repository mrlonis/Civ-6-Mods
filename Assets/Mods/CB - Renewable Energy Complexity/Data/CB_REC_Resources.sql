-- CB_REC_Resources
-- Author: JNR
--------------------------------------------------------------

-- Types
--------------------------------------------------------------
INSERT OR IGNORE INTO Types
		(Type,							Kind)
VALUES	('RESOURCE_JNR_BATTERY_CHARGE',	'KIND_RESOURCE');
--------------------------------------------------------------

-- Resources
--------------------------------------------------------------
INSERT OR IGNORE INTO Resources
		(ResourceType,
		Name,
		ResourceClassType,
		Frequency,
		PrereqTech,
		RevealedEra)
VALUES	('RESOURCE_JNR_BATTERY_CHARGE',
		'LOC_RESOURCE_JNR_BATTERY_CHARGE_NAME',
		'RESOURCECLASS_STRATEGIC',
		0,
		'TECH_NANOTECHNOLOGY',
		8);
--------------------------------------------------------------

-- Resource_Consumption
--------------------------------------------------------------
INSERT OR IGNORE INTO Resource_Consumption
		(ResourceType,
		Accumulate,
		PowerProvided,
		BaseExtractionRate,
		ImprovedExtractionRate,
		StockpileCap)
VALUES	('RESOURCE_JNR_BATTERY_CHARGE',
		1,
		1,
		0,
		0,
		200);
--------------------------------------------------------------