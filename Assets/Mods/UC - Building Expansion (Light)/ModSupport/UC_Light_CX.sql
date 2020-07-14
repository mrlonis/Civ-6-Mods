-- UC_Light_CX
-- Author: JNR
--------------------------------------------------------------

UPDATE Buildings SET Description='LOC_BUILDING_MADRASA_DESCRIPTION_UC_JNR_LIGHT_CX'		WHERE BuildingType=(SELECT BuildingType FROM BuildingModifiers WHERE ModifierId='P0K_MADRASA_DOMESTIC_TRADE_ROUTE_SCIENCE');
UPDATE Buildings SET Description='LOC_BUILDING_TLACHTLI_DESCRIPTION_UC_JNR_LIGHT_CX'	WHERE BuildingType=(SELECT BuildingType FROM BuildingModifiers WHERE ModifierId='P0K_TLACHTLI_FAITH_PURCHASE_ANTI_CAVALRY');
UPDATE Buildings SET Description='LOC_BUILDING_PRASAT_DESCRIPTION_UC_JNR_LIGHT_CX'		WHERE BuildingType=(SELECT BuildingType FROM BuildingModifiers WHERE ModifierId='P0K_PRASAT_FAITH_MARSH_ADJACENCY');