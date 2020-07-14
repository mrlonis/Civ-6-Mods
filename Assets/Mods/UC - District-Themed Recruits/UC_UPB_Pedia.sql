-- UC_UPB_Pedia
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
		(SectionId,		PageId,								PageGroupId,			SortIndex,	PageLayoutId,						Tooltip,	Name)
VALUES	('CONCEPTS',	'JNR_UC_INTRODUCTION',				'JNR_URBANCOMPLEXITY',	1,			'Simple',							'',			'LOC_PEDIA_CONCEPTS_PAGE_JNR_UC_INTRODUCTION_CHAPTER_CONTENT_TITLE'),
		('CONCEPTS',	'JNR_UC_DISTRICT_UNIT_PRODUCTION',	'JNR_URBANCOMPLEXITY',	70,			'JNR_UC_DistrictUnitProduction',	'',			'LOC_PEDIA_CONCEPTS_PAGE_JNR_UC_DISTRICT_UNIT_PRODUCTION_CHAPTER_JNRUPBBASE_TITLE');
--------------------------------------------------------------

-- CivilopediaPageLayouts
--------------------------------------------------------------
INSERT OR REPLACE INTO CivilopediaPageLayouts
		(PageLayoutId,						ScriptTemplate)
VALUES	('JNR_UC_DistrictUnitProduction',	'Simple');
--------------------------------------------------------------

-- CivilopediaPageLayoutChapters
--------------------------------------------------------------
INSERT OR REPLACE INTO CivilopediaPageLayoutChapters
		(PageLayoutId,						ChapterId,		SortIndex)	
VALUES	('JNR_UC_DistrictUnitProduction',	'JNRUPBBASE',	10);

-- DLC
INSERT OR REPLACE INTO CivilopediaPageLayoutChapters
		(PageLayoutId,						ChapterId,		SortIndex)	
SELECT	'JNR_UC_DistrictUnitProduction',	'JNRUPBXP1',	20			FROM Types	WHERE Type='MODIFIER_CITY_ADJUST_UNIT_TAG_PRODUCTION_JNR_UC';

INSERT OR REPLACE INTO CivilopediaPageLayoutChapters
		(PageLayoutId,						ChapterId,		SortIndex)	
SELECT	'JNR_UC_DistrictUnitProduction',	'JNRUPBXP2',	30			FROM Types	WHERE Type='MODIFIER_CITY_ADJUST_UNIT_TAG_PRODUCTION_JNR_UC';

-- Mod Support - Satrap's Court by P0kiehl
INSERT OR REPLACE INTO CivilopediaPageLayoutChapters
		(PageLayoutId,						ChapterId,		SortIndex)	
SELECT	'JNR_UC_DistrictUnitProduction',	'JNRUPBP0KSC',	101			FROM Types	WHERE Type='POK_DISTRICT_SATRAPS_COURT';
--------------------------------------------------------------

---- CivilopediaPageSearchTerms
----------------------------------------------------------------
--INSERT OR REPLACE INTO CivilopediaPageSearchTerms
		--(SectionId,		PageId,								Term)
--VALUES	('CONCEPTS',	'JNR_UC_INTROUDCTION',				'LOC_PEDIA_CONCEPTS_PAGEGROUP_JNR_URBANCOMPLEXITY_NAME'),
		--('CONCEPTS',	'JNR_UC_DISTRICT_UNIT_PRODUCTION',	'LOC_PEDIA_CONCEPTS_PAGE_JNR_UC_DISTRICT_UNIT_PRODUCTION_CHAPTER_CONTENT_TITLE');
----------------------------------------------------------------