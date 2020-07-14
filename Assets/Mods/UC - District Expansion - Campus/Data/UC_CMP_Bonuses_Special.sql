-- UC_CMP_Bonuses_Special
-- Author: JNR
--------------------------------------------------------------

-- Building_GreatPersonPoints
--------------------------------------------------------------
INSERT OR IGNORE INTO Building_GreatPersonPoints
		(BuildingType,					GreatPersonClassType,			PointsPerTurn)
VALUES	('BUILDING_JNR_ACADEMY',		'GREAT_PERSON_CLASS_SCIENTIST',	1),
		('BUILDING_JNR_SCHOOL',			'GREAT_PERSON_CLASS_SCIENTIST',	1),
		('BUILDING_JNR_LABORATORY',		'GREAT_PERSON_CLASS_SCIENTIST',	1),
		('BUILDING_JNR_LIBERAL_ARTS',	'GREAT_PERSON_CLASS_SCIENTIST',	1),
		('BUILDING_JNR_EDUCATION',		'GREAT_PERSON_CLASS_SCIENTIST',	1);
--------------------------------------------------------------

-- Building_TourismBombs_XP2
--------------------------------------------------------------
INSERT OR IGNORE INTO Building_TourismBombs_XP2
		(BuildingType,			TourismBombValue)
SELECT	'BUILDING_JNR_SCHOOL',	TourismBombValue
FROM	Building_TourismBombs_XP2
WHERE	BuildingType='BUILDING_UNIVERSITY';
--------------------------------------------------------------