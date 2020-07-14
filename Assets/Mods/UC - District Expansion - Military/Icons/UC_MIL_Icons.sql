-- UC_MIL_Icons
-- Author: JNR
--------------------------------------------------------------

-- IconTextureAtlases
--------------------------------------------------------------
INSERT OR IGNORE INTO IconTextureAtlases
		(Name,									IconSize,	IconsPerRow,	IconsPerColumn,	Filename)
VALUES	('ICON_ATLAS_JNR_UC_MIL_BUILDINGS',		32,			4,				4,				'UC_MIL_Buildings32.dds'),
		('ICON_ATLAS_JNR_UC_MIL_BUILDINGS',		38,			4,				4,				'UC_MIL_Buildings38.dds'),
		('ICON_ATLAS_JNR_UC_MIL_BUILDINGS',		50,			4,				4,				'UC_MIL_Buildings50.dds'),
		('ICON_ATLAS_JNR_UC_MIL_BUILDINGS',		80,			4,				4,				'UC_MIL_Buildings80.dds'),
		('ICON_ATLAS_JNR_UC_MIL_BUILDINGS',		128,		4,				4,				'UC_MIL_Buildings128.dds'),
		('ICON_ATLAS_JNR_UC_MIL_BUILDINGS',		256,		4,				4,				'UC_MIL_Buildings256.dds');
--------------------------------------------------------------

-- IconDefinitions
--------------------------------------------------------------
INSERT OR REPLACE INTO IconDefinitions
		(Name,									Atlas,									'Index')
VALUES	('ICON_BUILDING_JNR_TARGET_RANGE',		'ICON_ATLAS_JNR_UC_MIL_BUILDINGS',		2),
		('ICON_BUILDING_ARMORY',				'ICON_ATLAS_JNR_UC_MIL_BUILDINGS',		4),
		('ICON_BUILDING_JNR_CAVALIER',			'ICON_ATLAS_JNR_UC_MIL_BUILDINGS',		5),
		('ICON_BUILDING_JNR_DEPOT',				'ICON_ATLAS_JNR_UC_MIL_BUILDINGS',		6),
		('ICON_BUILDING_MILITARY_ACADEMY',		'ICON_ATLAS_JNR_UC_MIL_BUILDINGS',		8),
		('ICON_BUILDING_JNR_ARSENAL',			'ICON_ATLAS_JNR_UC_MIL_BUILDINGS',		9),
		('ICON_BUILDING_JNR_PRISON',			'ICON_ATLAS_JNR_UC_MIL_BUILDINGS',		10),
		('ICON_BUILDING_JNR_NAVAL_BASE',		'ICON_ATLAS_JNR_UC_MIL_BUILDINGS',		15),

		('ICON_BUILDING_JNR_TARGET_RANGE_FOW',	'ICON_ATLAS_BUILDINGS_FOW',	13),
		('ICON_BUILDING_JNR_CAVALIER_FOW',		'ICON_ATLAS_BUILDINGS_FOW',	21),
		('ICON_BUILDING_JNR_DEPOT_FOW',			'ICON_ATLAS_BUILDINGS_FOW',	21),
		('ICON_BUILDING_JNR_ARSENAL_FOW',		'ICON_ATLAS_BUILDINGS_FOW',	29),
		('ICON_BUILDING_JNR_PRISON_FOW',		'ICON_ATLAS_BUILDINGS_FOW',	29),
		('ICON_BUILDING_JNR_NAVAL_BASE_FOW',	'ICON_ATLAS_BUILDINGS_FOW',	33);
--------------------------------------------------------------