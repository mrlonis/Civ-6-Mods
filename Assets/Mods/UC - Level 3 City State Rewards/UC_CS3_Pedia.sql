-- UC_CS3_Pedia
-- Author: JNR
--------------------------------------------------------------

-- CivilopediaPageGroups
--------------------------------------------------------------
INSERT OR REPLACE INTO CivilopediaPageGroups
		(SectionID,		PageGroupId,			SortIndex,	VisibleIfEmpty,	Tooltip,	Name)
VALUES	('CONCEPTS',	'JNR_URBANCOMPLEXITY',	4,			0,				'',			'LOC_PEDIA_CONCEPTS_PAGEGROUP_JNR_URBANCOMPLEXITY_NAME');
--------------------------------------------------------------

-- CivilopediaPages
--------------------------------------------------------------
INSERT OR REPLACE INTO CivilopediaPages
		(SectionId,		PageId,					PageGroupId,			SortIndex,	PageLayoutId,		Tooltip,	Name)
VALUES	('CONCEPTS',	'JNR_UC_INTRODUCTION',	'JNR_URBANCOMPLEXITY',	1,			'Simple',			'',			'LOC_PEDIA_CONCEPTS_PAGE_JNR_UC_INTRODUCTION_CHAPTER_CONTENT_TITLE'),
		('CONCEPTS',	'JNR_UC_TIER3_CS',		'JNR_URBANCOMPLEXITY',	30,			'JNR_UC_Tier3CS',	'',			'LOC_PEDIA_CONCEPTS_PAGE_JNR_UC_TIER3_CS_CHAPTER_JNRCS3BASE_TITLE');
--------------------------------------------------------------

-- CivilopediaPageLayouts
--------------------------------------------------------------
INSERT OR REPLACE INTO CivilopediaPageLayouts
		(PageLayoutId,		ScriptTemplate)
VALUES	('JNR_UC_Tier3CS',	'Simple');
--------------------------------------------------------------

-- CivilopediaPageLayoutChapters
--------------------------------------------------------------
INSERT OR REPLACE INTO CivilopediaPageLayoutChapters
		(PageLayoutId,		ChapterId,			SortIndex)	
VALUES	('JNR_UC_Tier3CS',	'JNRCS3BASE',		10);

-- DLC
INSERT OR REPLACE INTO CivilopediaPageLayoutChapters
		(PageLayoutId,		ChapterId,			SortIndex)	
SELECT	'JNR_UC_Tier3CS',	'JNRCS3CIVITAS',	20			FROM Leaders WHERE LeaderType='CVS_LEADER_MINOR_CIV_AGRICULTURAL';
--------------------------------------------------------------