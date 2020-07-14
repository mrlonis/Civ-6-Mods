-- UC_MIL_WarfareExpanded_Text
-- Author: JNR
--------------------------------------------------------------

-- BaseGameText
--------------------------------------------------------------
INSERT OR REPLACE INTO BaseGameText
		(Tag,												Text)
SELECT	'LOC_BUILDING_BARRACKS_DESCRIPTION_UC_JNR',			'+50% combat experience for all melee, anti-cavalry, and marine promotion class units trained in this city.[NEWLINE]Enables training Military Engineers in this city.'
FROM	BaseGameText
WHERE	Tag='LOC_PROMOTION_CLASS_MARINE_NAME';

INSERT OR REPLACE INTO BaseGameText
		(Tag,												Text)
SELECT	'LOC_BUILDING_JNR_TARGET_RANGE_DESCRIPTION',		'+25% combat experience for all ranged, recon, siege, and fire support promotion class units trained in this city.[NEWLINE]Recon units trained in this city start with a free promotion.[NEWLINE]Enables training Military Engineers in this city.[NEWLINE]+1 [ICON_Production] Production to all Camps in this city.'
FROM	BaseGameText
WHERE	Tag='LOC_PROMOTION_CLASS_MARINE_NAME';

INSERT OR REPLACE INTO BaseGameText
		(Tag,												Text)
SELECT	'LOC_BUILDING_ARMORY_DESCRIPTION_UC_JNR',			'+50% [ICON_Production] Production towards all melee, anti-cavalry, recon, ranged, marine, and fire support promotion class units in this city.[NEWLINE]+1 [ICON_Production] Production to all [ICON_RESOURCE_IRON] Iron in this city.'
FROM	BaseGameText
WHERE	Tag='LOC_PROMOTION_CLASS_MARINE_NAME';

INSERT OR REPLACE INTO BaseGameText
		(Tag,												Text)
SELECT	'LOC_BUILDING_MILITARY_ACADEMY_DESCRIPTION_UC_JNR',	'+25% combat experience for all melee, anti-cavalry, recon, ranged, marine, and fire support promotion class units trained in this city.[NEWLINE]Melee, anti-cavalry, and ranged promotion class units trained in this city start with a free promotion. Recon units trained in this city start with the Ambush promotion.[NEWLINE]Allows Corps and Armies to be trained directly. Corps and Army training costs reduced 25%.[NEWLINE]Provides more [ICON_GreatGeneral] Great General Points.'
FROM	BaseGameText
WHERE	Tag='LOC_PROMOTION_CLASS_MARINE_NAME';
--------------------------------------------------------------