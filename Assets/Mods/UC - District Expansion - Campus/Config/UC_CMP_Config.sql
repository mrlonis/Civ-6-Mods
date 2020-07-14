-- UC_CMP_Config
-- Author: JNR
--------------------------------------------------------------

-- Players
--------------------------------------------------------------
UPDATE	Players
SET		CivilizationAbilityDescription='LOC_TRAIT_CIVILIZATION_NOBEL_PRIZE_DESCRIPTION_JNR_UC'
WHERE	CivilizationAbilityDescription='LOC_TRAIT_CIVILIZATION_NOBEL_PRIZE_DESCRIPTION';
--------------------------------------------------------------

-- PlayerItems
--------------------------------------------------------------
UPDATE	PlayerItems
SET		Description='LOC_DISTRICT_OBSERVATORY_DESCRIPTION_JNR_UC'
WHERE	Type='DISTRICT_OBSERVATORY';
--------------------------------------------------------------