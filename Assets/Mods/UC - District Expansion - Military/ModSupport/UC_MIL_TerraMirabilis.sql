-- UC_MIL_TerraMirabilis
-- Author: JNR
--------------------------------------------------------------

-- District_Adjacencies
--------------------------------------------------------------
INSERT INTO District_Adjacencies (DistrictType, YieldChangeId)
SELECT	DistrictType, 'ADJ_TM_NW_PRODUCTION'
FROM	Districts WHERE DistrictType = 'DISTRICT_ENCAMPMENT' OR DistrictType IN (SELECT CivUniqueDistrictType FROM DistrictReplaces WHERE ReplacesDistrictType = 'DISTRICT_ENCAMPMENT')
AND		EXISTS (SELECT * FROM TM_UserSettings WHERE Setting = 'NW_ADJACENCY' AND Value = 1);
--------------------------------------------------------------