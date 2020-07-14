-- UC_COM_Redux_Delete
-- Author: JNR
--------------------------------------------------------------

UPDATE Buildings							SET RegionalRange=0 WHERE BuildingType='BUILDING_RESEARCH_LAB';

UPDATE Building_YieldChangesBonusWithPower	SET YieldChange=5	WHERE BuildingType='BUILDING_RESEARCH_LAB'	AND YieldType='YIELD_SCIENCE';

DELETE FROM BuildingModifiers WHERE BuildingType='BUILDING_UNIVERSITY'		AND ModifierId='JNR_UNIVERSITY_SCIENCE_POPULATION_LIGHT';
DELETE FROM BuildingModifiers WHERE BuildingType='BUILDING_MADRASA'			AND ModifierId='JNR_UNIVERSITY_SCIENCE_POPULATION_LIGHT';
DELETE FROM BuildingModifiers WHERE BuildingType='BUILDING_RESEARCH_LAB'	AND ModifierId='JNR_RESEARCH_LAB_SCIENCE_MODIFIER_LIGHT';
DELETE FROM BuildingModifiers WHERE BuildingType='BUILDING_RESEARCH_LAB'	AND ModifierId='JNR_RESEARCH_LAB_SCIENCE_MODIFIER_POWERED_LIGHT';