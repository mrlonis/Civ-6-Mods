-- UC_CMP_CX_Config
-- Author: JNR
--------------------------------------------------------------

-- Players
--------------------------------------------------------------
UPDATE	Players
SET		CivilizationAbilityDescription='LOC_TRAIT_CIVILIZATION_DYNASTIC_CYCLE_EXPANSION2_DESCRIPTION_JNR_UC_CX'
WHERE	CivilizationAbilityDescription='LOC_TRAIT_CIVILIZATION_DYNASTIC_CYCLE_EXPANSION2_DESCRIPTION'
		AND EXISTS (SELECT * FROM Players WHERE LeaderAbilityDescription='LOC_P0K_LAUTARO_ABILITY_DESCRIPTION');

UPDATE	Players
SET		CivilizationAbilityDescription='LOC_TRAIT_CIVILIZATION_PAX_BRITANNICA_EXPANSION2_DESCRIPTION_JNR_UC_CX'
WHERE	CivilizationAbilityDescription='LOC_TRAIT_CIVILIZATION_PAX_BRITANNICA_EXPANSION2_DESCRIPTION'
		AND EXISTS (SELECT * FROM Players WHERE LeaderAbilityDescription='LOC_P0K_LAUTARO_ABILITY_DESCRIPTION');

UPDATE	Players
SET		CivilizationAbilityDescription='LOC_TRAIT_CIVILIZATION_IMPERIAL_FREE_CITIES_DESCRIPTION_JNR_UC_CX'
WHERE	CivilizationAbilityDescription='LOC_TRAIT_CIVILIZATION_IMPERIAL_FREE_CITIES_DESCRIPTION'
		AND EXISTS (SELECT * FROM Players WHERE LeaderAbilityDescription='LOC_P0K_LAUTARO_ABILITY_DESCRIPTION');

UPDATE	Players
SET		LeaderAbilityDescription='LOC_TRAIT_LEADER_TRAJANS_COLUMN_DESCRIPTION_JNR_UC_CX'
WHERE	LeaderAbilityDescription='LOC_TRAIT_LEADER_TRAJANS_COLUMN_DESCRIPTION'
		AND EXISTS (SELECT * FROM Players WHERE LeaderAbilityDescription='LOC_P0K_LAUTARO_ABILITY_DESCRIPTION');

UPDATE	Players
SET		LeaderAbilityDescription='LOC_TRAIT_LEADER_HWARANG_DESCRIPTION_JNR_UC_CX'
WHERE	LeaderAbilityDescription='LOC_TRAIT_LEADER_HWARANG_DESCRIPTION'
		AND EXISTS (SELECT * FROM Players WHERE LeaderAbilityDescription='LOC_P0K_LAUTARO_ABILITY_DESCRIPTION');

UPDATE	Players
SET		CivilizationAbilityDescription='LOC_TRAIT_CIVILIZATION_NOBEL_PRIZE_DESCRIPTION_JNR_UC_CX'
WHERE	CivilizationAbilityDescription='LOC_TRAIT_CIVILIZATION_NOBEL_PRIZE_DESCRIPTION_JNR_UC'
		AND EXISTS (SELECT * FROM Players WHERE LeaderAbilityDescription='LOC_P0K_LAUTARO_ABILITY_DESCRIPTION');
--------------------------------------------------------------

-- PlayerItems
--------------------------------------------------------------
UPDATE	PlayerItems
SET		Description='LOC_DISTRICT_OBSERVATORY_DESCRIPTION_JNR_UC_CX'
WHERE	Description='LOC_DISTRICT_OBSERVATORY_DESCRIPTION_JNR_UC'
		AND EXISTS (SELECT * FROM Players WHERE LeaderAbilityDescription='LOC_P0K_LAUTARO_ABILITY_DESCRIPTION');
--------------------------------------------------------------