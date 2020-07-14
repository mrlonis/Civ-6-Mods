-- UC_GP_Icons
-- Author: JNR
--------------------------------------------------------------

-- IconTextureAtlases
--------------------------------------------------------------
INSERT OR IGNORE INTO IconTextureAtlases
		(Name,									IconSize,	IconsPerRow,	IconsPerColumn,	Filename)
VALUES	('ICON_ATLAS_JNR_UC_GP_BUILDINGS',		32,			2,				2,				'UC_GP_Buildings32.dds'),
		('ICON_ATLAS_JNR_UC_GP_BUILDINGS',		38,			2,				2,				'UC_GP_Buildings38.dds'),
		('ICON_ATLAS_JNR_UC_GP_BUILDINGS',		50,			2,				2,				'UC_GP_Buildings50.dds'),
		('ICON_ATLAS_JNR_UC_GP_BUILDINGS',		80,			2,				2,				'UC_GP_Buildings80.dds'),
		('ICON_ATLAS_JNR_UC_GP_BUILDINGS',		128,		2,				2,				'UC_GP_Buildings128.dds'),
		('ICON_ATLAS_JNR_UC_GP_BUILDINGS',		256,		2,				2,				'UC_GP_Buildings256.dds'),
		('ICON_ATLAS_JNR_UC_GP_BUILDINGS_FOW',	32,			2,				2,				'UC_GP_Buildings32_FOW.dds'),
		('ICON_ATLAS_JNR_UC_GP_BUILDINGS_FOW',	38,			2,				2,				'UC_GP_Buildings38_FOW.dds'),
		('ICON_ATLAS_JNR_UC_GP_BUILDINGS_FOW',	50,			2,				2,				'UC_GP_Buildings50_FOW.dds'),
		('ICON_ATLAS_JNR_UC_GP_BUILDINGS_FOW',	80,			2,				2,				'UC_GP_Buildings80_FOW.dds'),
		('ICON_ATLAS_JNR_UC_GP_BUILDINGS_FOW',	128,		2,				2,				'UC_GP_Buildings128_FOW.dds'),
		('ICON_ATLAS_JNR_UC_GP_BUILDINGS_FOW',	256,		2,				2,				'UC_GP_Buildings256_FOW.dds');
--------------------------------------------------------------

-- IconDefinitions
--------------------------------------------------------------
--INSERT OR IGNORE INTO IconDefinitions
		--(Name,										Atlas,						'Index')
--VALUES	('ICON_PROJECT_JNR_GOV_CAPITAL_MOVE',		'ICON_ATLAS_XP2_PROJECTS',	5),		-- Cothon Move Capital
		--('ICON_BUILDING_GOV_JNR_MOCC',				'ICON_ATLAS_BUILDINGS',		38),	-- Airport
		--('ICON_BUILDING_GOV_JNR_PROPAGANDA',		'ICON_ATLAS_BUILDINGS',		14),	-- Temple
		--('ICON_BUILDING_GOV_JNR_DIPLOMACY',			'ICON_ATLAS_BUILDINGS',		37),	-- Research Lab
		--('ICON_BUILDING_GOV_JNR_DIPLOMACY_US',		'ICON_ATLAS_BUILDINGS',		1),		-- Palace
		--('ICON_BUILDING_GOV_JNR_MOCC_FOW',			'ICON_ATLAS_BUILDINGS_FOW',	38),	-- Airport
		--('ICON_BUILDING_GOV_JNR_PROPAGANDA_FOW',	'ICON_ATLAS_BUILDINGS_FOW',	34),	-- Temple
		--('ICON_BUILDING_GOV_JNR_DIPLOMACY_FOW',		'ICON_ATLAS_BUILDINGS_FOW',	37),	-- Research Lab
		--('ICON_BUILDING_GOV_JNR_DIPLOMACY_US_FOW',	'ICON_ATLAS_BUILDINGS_FOW',	1);		-- Palace

INSERT OR IGNORE INTO IconDefinitions
		(Name,										Atlas,									'Index')
VALUES	('ICON_PROJECT_JNR_GOV_CAPITAL_MOVE',		'ICON_ATLAS_XP2_PROJECTS',				5),		-- Cothon Move Capital
		('ICON_BUILDING_GOV_JNR_MOCC',				'ICON_ATLAS_JNR_UC_GP_BUILDINGS',		0),
		('ICON_BUILDING_GOV_JNR_PROPAGANDA',		'ICON_ATLAS_JNR_UC_GP_BUILDINGS',		1),
		('ICON_BUILDING_GOV_JNR_DIPLOMACY',			'ICON_ATLAS_JNR_UC_GP_BUILDINGS',		2),
		('ICON_BUILDING_GOV_JNR_DIPLOMACY_US',		'ICON_ATLAS_JNR_UC_GP_BUILDINGS',		3),
		('ICON_BUILDING_GOV_JNR_MOCC_FOW',			'ICON_ATLAS_JNR_UC_GP_BUILDINGS_FOW',	0),
		('ICON_BUILDING_GOV_JNR_PROPAGANDA_FOW',	'ICON_ATLAS_JNR_UC_GP_BUILDINGS_FOW',	1),
		('ICON_BUILDING_GOV_JNR_DIPLOMACY_FOW',		'ICON_ATLAS_JNR_UC_GP_BUILDINGS_FOW',	2),
		('ICON_BUILDING_GOV_JNR_DIPLOMACY_US_FOW',	'ICON_ATLAS_JNR_UC_GP_BUILDINGS_FOW',	3);
--------------------------------------------------------------

-- IconAliases
--------------------------------------------------------------
INSERT OR IGNORE INTO IconAliases
		(Name,												OtherName)
VALUES	('ICON_POLICY_JNR_GOV_CORPORATE_LIBERTARIANISM',	'ICON_POLICY_WILDCARD'),
		('ICON_POLICY_JNR_GOV_DIGITAL_DEMOCRACY',			'ICON_POLICY_WILDCARD'),
		('ICON_POLICY_JNR_GOV_SYNTHETIC_TECHNOCRACY',		'ICON_POLICY_WILDCARD');
--------------------------------------------------------------