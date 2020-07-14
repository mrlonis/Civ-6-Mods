-- CB_REC_Icons
-- Author: JNR
--------------------------------------------------------------

-- IconTextureAtlases
--------------------------------------------------------------
INSERT OR IGNORE INTO IconTextureAtlases
		(Name,									IconSize,	IconsPerRow,	IconsPerColumn,	Filename)
VALUES	('ICON_ATLAS_JNR_RENEWABLE_RESOURCES',	38,			1,				1,				'JNRRenewableEnergyResource38.dds'),
		('ICON_ATLAS_JNR_RENEWABLE_RESOURCES',	50,			1,				1,				'JNRRenewableEnergyResource50.dds'),
		('ICON_ATLAS_JNR_RENEWABLE_RESOURCES',	64,			1,				1,				'JNRRenewableEnergyResource64.dds'),
		('ICON_ATLAS_JNR_RENEWABLE_RESOURCES',	256,		1,				1,				'JNRRenewableEnergyResource256.dds'),
		
		('ICON_ATLAS_JNR_CB_REC_BUILDINGS',		32,			2,				2,				'CB_REC_Buildings32.dds'),
		('ICON_ATLAS_JNR_CB_REC_BUILDINGS',		38,			2,				2,				'CB_REC_Buildings38.dds'),
		('ICON_ATLAS_JNR_CB_REC_BUILDINGS',		50,			2,				2,				'CB_REC_Buildings50.dds'),
		('ICON_ATLAS_JNR_CB_REC_BUILDINGS',		80,			2,				2,				'CB_REC_Buildings80.dds'),
		('ICON_ATLAS_JNR_CB_REC_BUILDINGS',		128,		2,				2,				'CB_REC_Buildings128.dds'),
		('ICON_ATLAS_JNR_CB_REC_BUILDINGS',		256,		2,				2,				'CB_REC_Buildings256.dds');

-- IconTextureAtlases
--------------------------------------------------------------
INSERT OR IGNORE INTO IconTextureAtlases
		(Name,										Baseline,	IconSize,	IconsPerRow,	IconsPerColumn,	Filename)
VALUES	('ICON_ATLAS_JNR_RENEWABLE_RESOURCES_FONT',	6,			22,			1,				1,				'JNRRenewableEnergyResourceFontIcon.dds');
--------------------------------------------------------------

-- IconDefinitions
--------------------------------------------------------------
INSERT OR REPLACE INTO IconDefinitions
		(Name,												Atlas,										'Index')
VALUES	('ICON_RESOURCE_JNR_BATTERY_CHARGE',				'ICON_ATLAS_JNR_RENEWABLE_RESOURCES',		0),
		('RESOURCE_JNR_BATTERY_CHARGE',						'ICON_ATLAS_JNR_RENEWABLE_RESOURCES_FONT',	0),
		('ICON_BUILDING_JNR_RENEWABLE_DISTRIBUTION',		'ICON_ATLAS_JNR_CB_REC_BUILDINGS',			0),
		('ICON_BUILDING_JNR_RENEWABLE_COLLECTION',			'ICON_ATLAS_JNR_CB_REC_BUILDINGS',			1),
		('ICON_BUILDING_JNR_RENEWABLE_COLLECTION_FOW',		'ICON_ATLAS_BUILDINGS_FOW',					27),
		('ICON_BUILDING_JNR_RENEWABLE_DISTRIBUTION_FOW',	'ICON_ATLAS_BUILDINGS_FOW',					27),
		('ICON_PROJECT_JNR_CONVERT_REACTOR_TO_BATTERY',		'ICON_ATLAS_JNR_CB_REC_BUILDINGS',			2);
--------------------------------------------------------------