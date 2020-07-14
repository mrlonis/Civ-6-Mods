-- UC_DHA_Pedia
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
		(SectionId,		PageId,								PageGroupId,			SortIndex,	PageLayoutId,				Tooltip,	Name)
VALUES	('CONCEPTS',	'JNR_UC_INTRODUCTION',				'JNR_URBANCOMPLEXITY',	1,			'Simple',					'',			'LOC_PEDIA_CONCEPTS_PAGE_JNR_UC_INTRODUCTION_CHAPTER_CONTENT_TITLE'),
		('CONCEPTS',	'JNR_UC_DISTRICT_HAPPINESS',		'JNR_URBANCOMPLEXITY',	60,			'JNR_UC_DistrictHappiness',	'',			'LOC_PEDIA_CONCEPTS_PAGE_JNR_UC_DISTRICT_HAPPINESS_CHAPTER_JNRDHABASE_TITLE');
--------------------------------------------------------------

-- CivilopediaPageLayouts
--------------------------------------------------------------
INSERT OR REPLACE INTO CivilopediaPageLayouts
		(PageLayoutId,					ScriptTemplate)
VALUES	('JNR_UC_DistrictHappiness',	'Simple');
--------------------------------------------------------------

-- CivilopediaPageLayoutChapters
--------------------------------------------------------------
INSERT OR REPLACE INTO CivilopediaPageLayoutChapters
		(PageLayoutId,					ChapterId,			SortIndex)	
VALUES	('JNR_UC_DistrictHappiness',	'JNRDHABASE',		10);

INSERT OR REPLACE INTO CivilopediaPageLayoutChapters
		(PageLayoutId,					ChapterId,			SortIndex)	
VALUES	('JNR_UC_DistrictHappiness',	'JNRDHASOURCES',	20);

INSERT OR REPLACE INTO CivilopediaPageLayoutChapters
		(PageLayoutId,					ChapterId,			SortIndex)	
VALUES	('JNR_UC_DistrictHappiness',	'JNRDHABALANCE',	30);

-- DLC
INSERT OR REPLACE INTO CivilopediaPageLayoutChapters
		(PageLayoutId,					ChapterId,			SortIndex)	
SELECT	'JNR_UC_DistrictHappiness',		'JNRDHAAUSSIE',		40			FROM Civilizations	WHERE CivilizationType='CIVILIZATION_AUSTRALIA';
--------------------------------------------------------------