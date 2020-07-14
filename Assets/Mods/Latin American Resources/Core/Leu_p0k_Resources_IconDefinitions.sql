--==========================================================================================================================
-- ICONS
--==========================================================================================================================
-- IconTextureAtlases
-------------------------------------	
INSERT INTO IconTextureAtlases	
		(Name,									IconSize,	IconsPerRow,	IconsPerColumn,	Filename)
VALUES  ('ICON_ATLAS_LEU_P0K_RESOURCES',		256,	 	8,				8,				'Leu_p0k_Resource_Atlas_256.dds'),
		('ICON_ATLAS_LEU_P0K_RESOURCES',		64,	 		8,				8,				'Leu_p0k_Resource_Atlas_64.dds'),
		('ICON_ATLAS_LEU_P0K_RESOURCES',		50,	 		8,				8,				'Leu_p0k_Resource_Atlas_50.dds'),
		('ICON_ATLAS_LEU_P0K_RESOURCES',		38,	 		8,				8,				'Leu_p0k_Resource_Atlas_38.dds'),
		('ICON_ATLAS_LEU_P0K_RESOURCES_FOW',	256,	 	8,				8,				'Leu_p0k_Resource_Atlas_256_FOW.dds'),
		('ICON_ATLAS_LEU_P0K_RESOURCES_FOW',	64,	 		8,				8,				'Leu_p0k_Resource_Atlas_64_FOW.dds');

INSERT INTO IconTextureAtlases	
		(Name,								Baseline,	IconSize,	IconsPerRow,	IconsPerColumn,		Filename)
VALUES  ('ICON_ATLAS_LEU_P0K_RESOURCES',	6,			22,	 		8,				8,					'Leu_p0k_Resource_Atlas_22.dds');		
-------------------------------------
-- IconDefinitions
-------------------------------------	
INSERT OR REPLACE INTO IconDefinitions	
		(Name,									Atlas, 								'Index')
VALUES  ('ICON_RESOURCE_LEU_P0K_POTATOES',		'ICON_ATLAS_LEU_P0K_RESOURCES',		0),
		('RESOURCE_LEU_P0K_POTATOES',			'ICON_ATLAS_LEU_P0K_RESOURCES',		0),
		('ICON_RESOURCE_LEU_P0K_POTATOES_FOW',	'ICON_ATLAS_LEU_P0K_RESOURCES_FOW',	0),

		('ICON_RESOURCE_LEU_P0K_CAPYBARAS',		'ICON_ATLAS_LEU_P0K_RESOURCES',		1),
		('RESOURCE_LEU_P0K_CAPYBARAS',			'ICON_ATLAS_LEU_P0K_RESOURCES',		1),
		('ICON_RESOURCE_LEU_P0K_CAPYBARAS_FOW',	'ICON_ATLAS_LEU_P0K_RESOURCES_FOW',	1),

		('ICON_RESOURCE_LEU_P0K_COCA',			'ICON_ATLAS_LEU_P0K_RESOURCES',		2),
		('RESOURCE_LEU_P0K_COCA',				'ICON_ATLAS_LEU_P0K_RESOURCES',		2),
		('ICON_RESOURCE_LEU_P0K_COCA_FOW',		'ICON_ATLAS_LEU_P0K_RESOURCES_FOW',	2),

		('ICON_RESOURCE_LEU_P0K_LLAMAS',		'ICON_ATLAS_LEU_P0K_RESOURCES',		3),
		('RESOURCE_LEU_P0K_LLAMAS',				'ICON_ATLAS_LEU_P0K_RESOURCES',		3),
		('ICON_RESOURCE_LEU_P0K_LLAMAS_FOW',	'ICON_ATLAS_LEU_P0K_RESOURCES_FOW',	3),

		('ICON_RESOURCE_LEU_P0K_QUINOA',		'ICON_ATLAS_LEU_P0K_RESOURCES',		4),
		('RESOURCE_LEU_P0K_QUINOA',				'ICON_ATLAS_LEU_P0K_RESOURCES',		4),
		('ICON_RESOURCE_LEU_P0K_QUINOA_FOW',	'ICON_ATLAS_LEU_P0K_RESOURCES_FOW',	4),

		('ICON_RESOURCE_LEU_P0K_YERBAMATE',		'ICON_ATLAS_LEU_P0K_RESOURCES',		5),
		('RESOURCE_LEU_P0K_YERBAMATE',			'ICON_ATLAS_LEU_P0K_RESOURCES',		5),
		('ICON_RESOURCE_LEU_P0K_YERBAMATE_FOW',	'ICON_ATLAS_LEU_P0K_RESOURCES_FOW',	5);							
--==========================================================================================================================
--==========================================================================================================================