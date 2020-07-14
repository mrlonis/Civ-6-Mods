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
		(SectionId,		PageId,					PageGroupId,			SortIndex,	PageLayoutId,	Tooltip,	Name)
VALUES	('CONCEPTS',	'JNR_UC_INTRODUCTION',	'JNR_URBANCOMPLEXITY',	1,			'Simple',		'',			'LOC_PEDIA_CONCEPTS_PAGE_JNR_UC_INTRODUCTION_CHAPTER_CONTENT_TITLE'),
		('CONCEPTS',	'JNR_UC_POWER',			'JNR_URBANCOMPLEXITY',	70,			'JNR_UC_Power',	'',			'LOC_PEDIA_CONCEPTS_PAGE_JNR_UC_POWER_CHAPTER_JNRPPCBASE_TITLE');
--------------------------------------------------------------

-- CivilopediaPageLayouts
--------------------------------------------------------------
INSERT OR IGNORE INTO CivilopediaPageLayouts
		(PageLayoutId,		ScriptTemplate)
VALUES	('JNR_UC_Power',	'Simple');
--------------------------------------------------------------

-- CivilopediaPageLayoutChapters
--------------------------------------------------------------
INSERT OR IGNORE INTO CivilopediaPageLayoutChapters
		(PageLayoutId,		ChapterId,			SortIndex)	
VALUES	('JNR_UC_Power',	'JNRPPCBASE',		10);

INSERT OR IGNORE INTO CivilopediaPageLayoutChapters
		(PageLayoutId,		ChapterId,			SortIndex)	
VALUES	('JNR_UC_Power',	'JNRPPCREQUIRED',	20);

INSERT OR IGNORE INTO CivilopediaPageLayoutChapters
		(PageLayoutId,		ChapterId,			SortIndex)	
VALUES	('JNR_UC_Power',	'JNRPPCBENEFITS',	30);

INSERT OR IGNORE INTO CivilopediaPageLayoutChapters
		(PageLayoutId,		ChapterId,			SortIndex)	
VALUES	('JNR_UC_Power',	'JNRPPCPENALTIES',	40);
--------------------------------------------------------------