-- CB_Flood_Barriers_Cost
-- Author: JNR
--------------------------------------------------------------

-- Buildings
--------------------------------------------------------------
UPDATE Buildings SET Cost=300 WHERE BuildingType='BUILDING_FLOOD_BARRIER';
--------------------------------------------------------------

-- 	Buildings_XP2
--------------------------------------------------------------
UPDATE Buildings_XP2 SET CostMultiplierPerTile=0 WHERE BuildingType='BUILDING_FLOOD_BARRIER';
--------------------------------------------------------------