-- BBH_Districts
-- Author: JNR
--------------------------------------------------------------

-- District_BuildChargeProductions
--------------------------------------------------------------
INSERT OR REPLACE INTO District_BuildChargeProductions
		(DistrictType,				UnitType,		PercentProductionPerCharge)
VALUES	('DISTRICT_AQUEDUCT',		'UNIT_BUILDER',	10),
		('DISTRICT_NEIGHBORHOOD',	'UNIT_BUILDER',	10);

INSERT OR REPLACE INTO District_BuildChargeProductions
		(DistrictType,				UnitType,		PercentProductionPerCharge)
SELECT	a.CivUniqueDistrictType,	b.UnitType,		b.PercentProductionPerCharge*2
FROM DistrictReplaces a, District_BuildChargeProductions b WHERE a.ReplacesDistrictType='DISTRICT_AQUEDUCT' AND b.DistrictType='DISTRICT_AQUEDUCT';

INSERT OR REPLACE INTO District_BuildChargeProductions
		(DistrictType,				UnitType,		PercentProductionPerCharge)
SELECT	a.CivUniqueDistrictType,	b.UnitType,		b.PercentProductionPerCharge*2
FROM DistrictReplaces a, District_BuildChargeProductions b WHERE a.ReplacesDistrictType='DISTRICT_NEIGHBORHOOD' AND b.DistrictType='DISTRICT_NEIGHBORHOOD';
--------------------------------------------------------------