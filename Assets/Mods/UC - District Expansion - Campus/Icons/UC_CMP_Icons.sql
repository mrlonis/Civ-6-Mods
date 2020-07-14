-- UC_CMP_Icons
-- Author: JNR
--------------------------------------------------------------

-- IconTextureAtlases
--------------------------------------------------------------
INSERT INTO IconTextureAtlases
		(Name,									IconSize,	IconsPerRow,	IconsPerColumn,	Filename)
VALUES	('ICON_ATLAS_JNR_UC_CMP_BUILDINGS',		32,			4,				4,				'UC_CMP_Buildings32.dds'),
		('ICON_ATLAS_JNR_UC_CMP_BUILDINGS',		38,			4,				4,				'UC_CMP_Buildings38.dds'),
		('ICON_ATLAS_JNR_UC_CMP_BUILDINGS',		50,			4,				4,				'UC_CMP_Buildings50.dds'),
		('ICON_ATLAS_JNR_UC_CMP_BUILDINGS',		80,			4,				4,				'UC_CMP_Buildings80.dds'),
		('ICON_ATLAS_JNR_UC_CMP_BUILDINGS',		128,		4,				4,				'UC_CMP_Buildings128.dds'),
		('ICON_ATLAS_JNR_UC_CMP_BUILDINGS',		256,		4,				4,				'UC_CMP_Buildings256.dds');
--------------------------------------------------------------

-- IconDefinitions
--------------------------------------------------------------
INSERT OR REPLACE INTO IconDefinitions
		(Name,									Atlas,								'Index')
VALUES	('ICON_BUILDING_LIBRARY',				'ICON_ATLAS_JNR_UC_CMP_BUILDINGS',	1),
		('ICON_BUILDING_JNR_ACADEMY',			'ICON_ATLAS_JNR_UC_CMP_BUILDINGS',	0),
		('ICON_BUILDING_UNIVERSITY',			'ICON_ATLAS_JNR_UC_CMP_BUILDINGS',	2),
		('ICON_BUILDING_JNR_SCHOOL',			'ICON_ATLAS_JNR_UC_CMP_BUILDINGS',	3),
		('ICON_BUILDING_JNR_LABORATORY',		'ICON_ATLAS_JNR_UC_CMP_BUILDINGS',	4),
		('ICON_BUILDING_JNR_LIBERAL_ARTS',		'ICON_ATLAS_JNR_UC_CMP_BUILDINGS',	5),
		('ICON_BUILDING_RESEARCH_LAB',			'ICON_ATLAS_JNR_UC_CMP_BUILDINGS',	6),
		('ICON_BUILDING_JNR_EDUCATION',			'ICON_ATLAS_JNR_UC_CMP_BUILDINGS',	7),

		('ICON_BUILDING_LIBRARY_FOW',			'ICON_ATLAS_BUILDINGS_FOW',			4),
		('ICON_BUILDING_JNR_ACADEMY_FOW',		'ICON_ATLAS_BUILDINGS_FOW',			4),
		('ICON_BUILDING_UNIVERSITY_FOW',		'ICON_ATLAS_BUILDINGS_FOW',			18),
		('ICON_BUILDING_JNR_SCHOOL_FOW',		'ICON_ATLAS_BUILDINGS_FOW',			18),
		('ICON_BUILDING_JNR_LABORATORY_FOW',	'ICON_ATLAS_BUILDINGS_FOW',			37),
		('ICON_BUILDING_JNR_LIBERAL_ARTS_FOW',	'ICON_ATLAS_BUILDINGS_FOW',			37),
		('ICON_BUILDING_RESEARCH_LAB_FOW',		'ICON_ATLAS_BUILDINGS_FOW',			37),
		('ICON_BUILDING_JNR_EDUCATION_FOW',		'ICON_ATLAS_BUILDINGS_FOW',			37);
--------------------------------------------------------------