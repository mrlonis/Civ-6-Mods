-- UC_DHA_Pedia
-- Author: JNR
--------------------------------------------------------------

-- CivilopediaPageGroups
--------------------------------------------------------------
INSERT OR IGNORE INTO CivilopediaPageGroups
		(SectionID,		PageGroupId,			SortIndex,	VisibleIfEmpty,	Tooltip,	Name)
VALUES	('CONCEPTS',	'JNR_URBANCOMPLEXITY',	4,			0,				'',			'LOC_PEDIA_CONCEPTS_PAGEGROUP_JNR_URBANCOMPLEXITY_NAME');
--------------------------------------------------------------

-- CivilopediaPages
--------------------------------------------------------------
INSERT OR IGNORE INTO CivilopediaPages
		(SectionId,		PageId,					PageGroupId,			SortIndex,	PageLayoutId,					Tooltip,	Name)
VALUES	('CONCEPTS',	'JNR_UC_INTRODUCTION',	'JNR_URBANCOMPLEXITY',	1,			'Simple',						'',			'LOC_PEDIA_CONCEPTS_PAGE_JNR_UC_INTRODUCTION_CHAPTER_CONTENT_TITLE'),
		('CONCEPTS',	'JNR_UC_XPGOV',			'JNR_URBANCOMPLEXITY',	190,		'JNR_UC_GovernmentExpansion',	'',			'LOC_PEDIA_CONCEPTS_PAGE_JNR_UC_XPGOV_CHAPTER_JNRGPBASE_TITLE');
--------------------------------------------------------------

-- CivilopediaPageLayouts
--------------------------------------------------------------
INSERT OR IGNORE INTO CivilopediaPageLayouts
		(PageLayoutId,					ScriptTemplate)
VALUES	('JNR_UC_GovernmentExpansion',	'Simple');
--------------------------------------------------------------

-- CivilopediaPageLayoutChapters
--------------------------------------------------------------
INSERT OR IGNORE INTO CivilopediaPageLayoutChapters
		(PageLayoutId,					ChapterId,		SortIndex)	
VALUES	('JNR_UC_GovernmentExpansion',	'JNRGPBASE',	10),
		('JNR_UC_GovernmentExpansion',	'JNRGPT123',	20),
		('JNR_UC_GovernmentExpansion',	'JNRGPMOCC',	30),
		('JNR_UC_GovernmentExpansion',	'JNRGPPROP',	40),
		('JNR_UC_GovernmentExpansion',	'JNRGPWCHQ',	50);
--------------------------------------------------------------