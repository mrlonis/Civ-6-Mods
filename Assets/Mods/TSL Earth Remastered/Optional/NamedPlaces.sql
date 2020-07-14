/*
	Author: totalslacker
	This file must be activated in the modinfo file. Delete the comment tags surrounding this file
	and NamedPlaces.xml

*/

DELETE FROM NamedRiverCivilizations 	WHERE CivilizationType = 'CIVILIZATION_AMERICA' AND NamedRiverType='NAMED_RIVER_RIO_GRANDE';
DELETE FROM NamedRiverCivilizations 	WHERE CivilizationType = 'CIVILIZATION_AMERICA' AND NamedRiverType='NAMED_RIVER_COLORADO';
DELETE FROM NamedRiverCivilizations 	WHERE CivilizationType = 'CIVILIZATION_AMERICA' AND NamedRiverType='NAMED_RIVER_COLUMBIA';
DELETE FROM NamedRiverCivilizations 	WHERE CivilizationType = 'CIVILIZATION_AMERICA' AND NamedRiverType='NAMED_RIVER_MISSISSIPPI';
DELETE FROM NamedRiverCivilizations 	WHERE CivilizationType = 'CIVILIZATION_AMERICA' AND NamedRiverType='NAMED_RIVER_SAINT_LAWRENCE';
DELETE FROM NamedRiverCivilizations 	WHERE CivilizationType = 'CIVILIZATION_AMERICA' AND NamedRiverType='NAMED_RIVER_YUKON';
DELETE FROM NamedRiverCivilizations 	WHERE CivilizationType = 'CIVILIZATION_AZTEC' AND NOT NamedRiverType='NAMED_RIVER_RIO_GRANDE';
DELETE FROM NamedRiverCivilizations 	WHERE CivilizationType = 'CIVILIZATION_AZTEC' AND NOT NamedRiverType='NAMED_RIVER_COLORADO';
DELETE FROM NamedRiverCivilizations 	WHERE CivilizationType = 'CIVILIZATION_CANADA' AND NamedRiverType='NAMED_RIVER_COLUMBIA';
DELETE FROM NamedRiverCivilizations 	WHERE CivilizationType = 'CIVILIZATION_CHINA' AND NamedRiverType='NAMED_RIVER_AMUR';
DELETE FROM NamedRiverCivilizations 	WHERE CivilizationType = 'CIVILIZATION_CHINA' AND NamedRiverType='NAMED_RIVER_HAI';
DELETE FROM NamedRiverCivilizations 	WHERE CivilizationType = 'CIVILIZATION_CHINA' AND NamedRiverType='NAMED_RIVER_SALWEEN';
DELETE FROM NamedRiverCivilizations 	WHERE CivilizationType = 'CIVILIZATION_CHINA' AND NamedRiverType='NAMED_RIVER_SONGHUA_RIVER';
DELETE FROM NamedRiverCivilizations 	WHERE CivilizationType = 'CIVILIZATION_CHINA' AND NamedRiverType='NAMED_RIVER_TARIM';
DELETE FROM NamedRiverCivilizations 	WHERE CivilizationType = 'CIVILIZATION_CHINA' AND NamedRiverType='NAMED_RIVER_WEI';
DELETE FROM NamedRiverCivilizations 	WHERE CivilizationType = 'CIVILIZATION_CREE';
DELETE FROM NamedRiverCivilizations 	WHERE CivilizationType = 'CIVILIZATION_EGYPT';
DELETE FROM NamedRiverCivilizations 	WHERE CivilizationType = 'CIVILIZATION_GREECE' AND NOT NamedRiverType='NAMED_RIVER_NESTOS_RIVER';
DELETE FROM NamedRiverCivilizations 	WHERE CivilizationType = 'CIVILIZATION_KONGO';
DELETE FROM NamedRiverCivilizations 	WHERE CivilizationType = 'CIVILIZATION_KOREA' AND NOT NamedRiverType='NAMED_RIVER_HAN_RIVER';
DELETE FROM NamedRiverCivilizations 	WHERE CivilizationType = 'CIVILIZATION_MACEDON' AND NOT NamedRiverType='NAMED_RIVER_VARDAR';
DELETE FROM NamedRiverCivilizations 	WHERE CivilizationType = 'CIVILIZATION_MALI' AND NamedRiverType='NAMED_RIVER_SANKARANI_RIVER';
DELETE FROM NamedRiverCivilizations 	WHERE CivilizationType = 'CIVILIZATION_MONGOLIA' AND NOT NamedRiverType='NAMED_RIVER_YENISEI';
DELETE FROM NamedRiverCivilizations 	WHERE CivilizationType = 'CIVILIZATION_NUBIA' AND NOT NamedRiverType='NAMED_RIVER_NILE';
DELETE FROM NamedRiverCivilizations 	WHERE CivilizationType = 'CIVILIZATION_PHOENICIA' AND NOT NamedRiverType='NAMED_RIVER_ORONTES_RIVER';
DELETE FROM NamedRiverCivilizations 	WHERE CivilizationType = 'CIVILIZATION_RUSSIA' AND NamedRiverType='NAMED_RIVER_AMUR';
DELETE FROM NamedRiverCivilizations 	WHERE CivilizationType = 'CIVILIZATION_RUSSIA' AND NamedRiverType='NAMED_RIVER_DAUGAVA';
DELETE FROM NamedRiverCivilizations 	WHERE CivilizationType = 'CIVILIZATION_RUSSIA' AND NamedRiverType='NAMED_RIVER_LENA';
DELETE FROM NamedRiverCivilizations 	WHERE CivilizationType = 'CIVILIZATION_SCYTHIA' AND NamedRiverType='NAMED_RIVER_SYR_DARYA';
DELETE FROM NamedRiverCivilizations 	WHERE CivilizationType = 'CIVILIZATION_SUMERIA' AND NamedRiverType='NAMED_RIVER_DIYALA_RIVER';
DELETE FROM NamedRiverCivilizations 	WHERE CivilizationType = 'CIVILIZATION_SUMERIA' AND NamedRiverType='NAMED_RIVER_GREAT_ZAB_RIVER';
DELETE FROM NamedRiverCivilizations 	WHERE CivilizationType = 'CIVILIZATION_SUMERIA' AND NamedRiverType='NAMED_RIVER_KHABUR_RIVER';
DELETE FROM NamedRiverCivilizations 	WHERE CivilizationType = 'CIVILIZATION_ZULU' AND NOT NamedRiverType='NAMED_RIVER_ZAMBEZI';

DELETE FROM NamedDesertCivilizations 	WHERE CivilizationType = 'CIVILIZATION_ARABIA'  AND NOT NamedDesertType = 'NAMED_DESERT_ARABIAN';
DELETE FROM NamedDesertCivilizations 	WHERE CivilizationType = 'CIVILIZATION_EGYPT' AND NOT NamedDesertType = 'NAMED_DESERT_SAHARA';
DELETE FROM NamedDesertCivilizations 	WHERE CivilizationType = 'CIVILIZATION_INCA' AND NOT NamedDesertType = 'NAMED_DESERT_ATACAMA';
DELETE FROM NamedDesertCivilizations 	WHERE CivilizationType = 'CIVILIZATION_KONGO' AND NOT NamedDesertType = 'NAMED_DESERT_KALAHARI';
DELETE FROM NamedDesertCivilizations 	WHERE CivilizationType = 'CIVILIZATION_MALI' AND NOT NamedDesertType = 'NAMED_DESERT_SAHARA';
DELETE FROM NamedDesertCivilizations 	WHERE CivilizationType = 'CIVILIZATION_MAPUCHE' AND NOT NamedDesertType = 'NAMED_DESERT_PATAGONIAN';
DELETE FROM NamedDesertCivilizations 	WHERE CivilizationType = 'CIVILIZATION_MONGOLIA' AND NOT NamedDesertType = 'NAMED_DESERT_GOBI';
DELETE FROM NamedDesertCivilizations 	WHERE CivilizationType = 'CIVILIZATION_NUBIA' AND NOT NamedDesertType = 'NAMED_DESERT_SAHARA';
DELETE FROM NamedDesertCivilizations 	WHERE CivilizationType = 'CIVILIZATION_PHOENICIA' AND NOT NamedDesertType = 'NAMED_DESERT_ARABIAN';
DELETE FROM NamedDesertCivilizations 	WHERE CivilizationType = 'CIVILIZATION_ZULU';


DELETE FROM NamedMountainCivilizations 	WHERE CivilizationType = 'CIVILIZATION_AMERICA';
DELETE FROM NamedMountainCivilizations 	WHERE CivilizationType = 'CIVILIZATION_BRAZIL';
DELETE FROM NamedMountainCivilizations 	WHERE CivilizationType = 'CIVILIZATION_CHINA' AND NOT NamedMountainType = 'NAMED_MOUNTAIN_HIMALAYAS';
DELETE FROM NamedMountainCivilizations 	WHERE CivilizationType = 'CIVILIZATION_CREE';
DELETE FROM NamedMountainCivilizations 	WHERE CivilizationType = 'CIVILIZATION_MALI' AND NOT NamedMountainType = 'NAMED_MOUNTAIN_ATLAS';
DELETE FROM NamedMountainCivilizations 	WHERE CivilizationType = 'CIVILIZATION_MAPUCHE' AND NOT NamedMountainType = 'NAMED_MOUNTAIN_ANDES';
DELETE FROM NamedMountainCivilizations 	WHERE CivilizationType = 'CIVILIZATION_MONGOLIA' AND NOT NamedMountainType = 'NAMED_MOUNTAIN_ALTAI';
DELETE FROM NamedMountainCivilizations 	WHERE CivilizationType = 'CIVILIZATION_SCYTHIA';
DELETE FROM NamedMountainCivilizations 	WHERE CivilizationType = 'CIVILIZATION_SPAIN' AND NOT NamedMountainType = 'NAMED_MOUNTAIN_ATLAS';
DELETE FROM NamedMountainCivilizations 	WHERE CivilizationType = 'CIVILIZATION_INDIA' AND NOT NamedMountainType = 'NAMED_MOUNTAIN_HIMALAYAS';
DELETE FROM NamedMountainCivilizations 	WHERE CivilizationType = 'CIVILIZATION_INCA' AND NOT NamedMountainType = 'NAMED_MOUNTAIN_ANDES';

DELETE FROM NamedVolcanoCivilizations 	WHERE CivilizationType = 'CIVILIZATION_GREECE' AND NOT NamedVolcanoType = 'NAMED_VOLCANO_THERA';
