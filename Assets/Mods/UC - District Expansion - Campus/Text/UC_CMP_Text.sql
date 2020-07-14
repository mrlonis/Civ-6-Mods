-- UC_CMP_Text
-- Author: JNR
--------------------------------------------------------------

-- BaseGameText
--------------------------------------------------------------
INSERT OR IGNORE INTO BaseGameText
		(Tag,														Text)
VALUES	('LOC_BUILDING_LIBRARY_DESCRIPTION_UC_JNR',					'+1 additional [ICON_SCIENCE] Science for each era since constructed or last repaired.'),
		('LOC_BUILDING_JNR_ACADEMY_NAME',							'School'),
--		('LOC_BUILDING_JNR_ACADEMY_DESCRIPTION',					'Description'),
--		('LOC_BUILDING_UNIVERSITY_DESCRIPTION_UC_JNR',				'Description'),
		('LOC_BUILDING_JNR_SCHOOL_NAME',							'Academy'),
		('LOC_BUILDING_JNR_SCHOOL_DESCRIPTION',						'+1 [ICON_SCIENCE] Science per [ICON_GOVERNOR] Promotion of a Governor established in this city.'),
--		('LOC_BUILDING_MADRASA_DESCRIPTION_UC_JNR',					'A building unique to Arabia.[NEWLINE]Bonus [ICON_Faith] Faith equal to the adjacency bonus of the Campus district.'),
		('LOC_BUILDING_JNR_LABORATORY_NAME',						'Laboratory'),
		('LOC_BUILDING_JNR_LABORATORY_DESCRIPTION',					'+0.4 [ICON_SCIENCE] Science per turn for each [ICON_Citizen] Citizen in the city.'),
		('LOC_BUILDING_JNR_LIBERAL_ARTS_NAME',						'Liberal Arts College'),
		('LOC_BUILDING_JNR_LIBERAL_ARTS_DESCRIPTION',				'+1 [ICON_SCIENCE] Science from each Great Work in this city.'),
		('LOC_BUILDING_RESEARCH_LAB_NAME_UC_JNR',					'Institute of Technology'),
		('LOC_BUILDING_RESEARCH_LAB_DESCRIPTION_UC_JNR',			'+5% [ICON_Science] Science in this city. Another +5% if the city is powered.'),
		('LOC_BUILDING_JNR_EDUCATION_NAME',							'Community College'),
		('LOC_BUILDING_JNR_EDUCATION_DESCRIPTION',					'Its [ICON_SCIENCE] Science bonus is extended to all City Centers within 6 tiles that do not already have a bonus from this building type.'),
		('LOC_DISTRICT_OBSERVATORY_DESCRIPTION_JNR_UC',				'A district unique to the Maya for scientific endeavors. Replaces the Campus district and cheaper to build.[NEWLINE][NEWLINE]+1 [ICON_Science] Science bonus for adjacent Luxury Resources and Plantations. +1 [ICON_Science] Science bonus for every two adjacent Farm or district tiles.'),
		('LOC_BOOST_TRIGGER_PRINTING_JNR_UC',						'Build 2 Universities or Academies.'),
		('LOC_BOOST_TRIGGER_CHEMISTRY_JNR_UC',						'Build 2 Laboratories.'),
		('LOC_BOOST_TRIGGER_LONGDESC_CHEMISTRY_JNR_UC',				'Running experiments in a controlled environment has improved our understanding of the elements significantly.'),
		('LOC_BOOST_TRIGGER_NUCLEAR_PROGRAM_JNR_UC',				'Build an Institute of Technology.'),
		('LOC_TECH_ASTRONOMY_DESCRIPTION_JNR_UC',					'+50% Campus district adjacency bonuses (+25% in Campuses with a University building) in Campuses adjacent to at least 1 Mountain. Unique Campus replacements do not require an adjacent Mountain.'),
		('LOC_GREATPERSON_ACADEMY_SCIENCE_JNR',						'Schools provide +{Amount} [ICON_SCIENCE] Science.'),
		('LOC_GREATPERSON_SCHOOL_SCIENCE_JNR',						'Academies provide +{Amount} [ICON_SCIENCE] Science.'),
		('LOC_GREATPERSON_LIBERAL_ARTS_SCIENCE_JNR',				'Liberal Arts Colleges provide +{Amount} [ICON_SCIENCE] Science.'),
		('LOC_GREATPERSON_LABORATORY_SCIENCE_JNR',					'Laboratories provide +{Amount} [ICON_SCIENCE] Science.'),
		('LOC_GREATPERSON_INSTITUTE_SCIENCE_JNR',					'Institutes of Technology provide +{Amount} [ICON_SCIENCE] Science.'),
		('LOC_GREATPERSON_EDUCATION_SCIENCE_JNR',					'Community Colleges provide +{Amount} [ICON_SCIENCE] Science.'),
		('LOC_GREATPERSON_ACADEMY_JNR',								'Instantly builds a School in this district.'),
		('LOC_GREATPERSON_SCIENTIFICTHEORYTECHBOOST_JNR',			'Triggers the [ICON_TechBoosted] Eureka moment for Scientific Theory.'),
		('LOC_GREATPERSON_1RENAISSANCEINDUSTRIALCIVICBOOST_JNR',	'Triggers the [ICON_CivicBoosted] Inspiration moment for {Amount} random {Amount : plural 1?civic; other?civics;} from the Renaissance or Industrial era.'),
		('LOC_POLICY_NATURAL_PHILOSOPHY_DESCRIPTION_JNR_UC',		'+100% Campus district adjacency bonuses (+50% in Campuses with a University building).'),
		('LOC_POLICY_FIVE_YEAR_PLAN_DESCRIPTION_JNR_UC_CMP',		'+100% Campus district adjacency bonuses (+50% in Campuses with a University building). +100% Industrial Zone district adjacency bonuses.'),
		('LOC_POLICY_FIVE_YEAR_PLAN_DESCRIPTION_JNR_UC',			'+50% Campus and Industrial Zone district adjacency bonuses (+25% in Campuses with a University building).'),
		('LOC_POLICY_RATIONALISM_DESCRIPTION_JNR_UC',				'Extra [ICON_SCIENCE] Science from buildings in Campuses: +1 if city [ICON_CITIZEN] population is 10 or higher, +1 if district has at least +3 adjacency bonus.'),
		('LOC_POLICY_THIRD_ALTERNATIVE_DESCRIPTION_JNR_UC_CMP',		'+2 [ICON_Culture] Culture and +4 [ICON_Gold] Gold from each Institute of Technology, Community College, Military Academy, Coal Power Plant, Oil Power Plant, and Nuclear Power Plant.'),
		('LOC_POLICY_THIRD_ALTERNATIVE_DESCRIPTION_JNR_UC',			'+100% Encampment district adjacency bonuses. +2 [ICON_Culture] Culture and +4 [ICON_Gold] Gold from each Military Academy, Arsenal, Prison, Institute of Technology, and Community College.'),
		('LOC_DISTRICT_JNR_UC_Floodpains_Grass_Science',			'+{1_num} [ICON_Science] Science from the adjacent Grassland Floodplains tiles.'),
		('LOC_DISTRICT_JNR_UC_Floodpains_Plains_Science',			'+{1_num} [ICON_Science] Science from the adjacent Plains Floodplains tiles.'),
		('LOC_DISTRICT_JNR_UC_Floodpains_Desert_Science',			'+{1_num} [ICON_Science] Science from the adjacent Desert Floodplains tiles.'),
		('LOC_DISTRICT_JNR_UC_Spaceport_Science',					'+{1_num} [ICON_SCIENCE] Science from the adjacent Spaceport {1_Num : plural 2?district; other?districts;}.'),
		('LOC_DISTRICT_JNR_UC_Water_Park_Science',					'+{1_num} [ICON_SCIENCE] Science from the adjacent Water Park {1_Num : plural 2?district; other?districts;}.'),
		('LOC_DISTRICT_JNR_UC_Water_Park_Carnival_Science',			'+{1_num} [ICON_SCIENCE] Science from the adjacent Copacabana {1_Num : plural 2?district; other?districts;}.'),
		('LOC_DISTRICT_JNR_UC_Luxury_Science',						'+{1_num} [ICON_SCIENCE] Science from the adjacent Luxury {1_Num : plural 1?resource; other?resources;}.'),
		('LOC_TRAIT_CIVILIZATION_NOBEL_PRIZE_DESCRIPTION_JNR_UC',	'Sweden gains 50 [ICON_Favor] Diplomatic Favor when earning a Great Person (on Standard Speed). Sweden receives +1 [ICON_GreatEngineer] Great Engineer point from Level 2 Industrial Zone buildings and +1 [ICON_GreatScientist] Great Scientist point from Level 2 Campus buildings. Having Sweden in the game adds three unique World Congress competitions starting in the Industrial Era.'),
		('LOC_EMERGENCY_REWARD_NOBEL_PRIZE_PHY_FIRST_PLACE_UNIVERSITY_RESOURCES_DESCRIPTION_JNR_UC',	'Increases the accumulation of resources in cities with a University or Academy by 1.'),
		('LOC_EMERGENCY_REWARD_NOBEL_PRIZE_PHY_TOP_TIER_UNIVERSITY_RESOURCES_DESCRIPTION_JNR_UC',		'Increases the accumulation of resources in cities with a Laboratory or Liberal Arts College by 1.');
--------------------------------------------------------------

-- City-State UI
-- BaseGameText
--------------------------------------------------------------
INSERT OR REPLACE INTO BaseGameText
		(Tag,														Text)
VALUES	('LOC_MINOR_CIV_SCIENTIFIC_TRAIT_MEDIUM_INFLUENCE_BONUS',	'+2 [ICON_Science] Science in every Library or School building.'),
		('LOC_MINOR_CIV_SCIENTIFIC_TRAIT_LARGE_INFLUENCE_BONUS',	'+2 [ICON_Science] Science in every University or Academy building.');
--------------------------------------------------------------

-- RwF
-- BaseGameText
--------------------------------------------------------------
INSERT OR IGNORE INTO BaseGameText
		(Tag,														Text)
VALUES	('LOC_POLICY_JFD_SCHOLASTIC_METHOD_DESCRIPTION_UC_JNR',		'+100% [ICON_SCIENCE] adjacency bonus for Campuses (+50% in Campuses with a University building).'),
		('LOC_POLICY_JFD_SCIENCE_ACADEMIES_DESCRIPTION_UC_JNR',		'+100% [ICON_SCIENCE] adjacency bonus for Campuses (+50% in Campuses with a University building). +100% [ICON_PRODUCTION] adjacency bonus and Industrial Zones.'),
		('LOC_POLICY_JFD_RATIONAL_BUREAUCRACY_DESCRIPTION_UC_JNR',	'+2 [ICON_SCIENCE] Science from Campus Buildings.');
--------------------------------------------------------------

-- City-State UI CSE
-- BaseGameText
--------------------------------------------------------------
INSERT OR REPLACE INTO BaseGameText
		(Tag,														Text)
VALUES	('LOC_CSE_SCIENTIFIC_TRAIT_MEDIUM_INFLUENCE_BONUS',			'+2 [ICON_SCIENCE] Science in every Library or School.'),
		('LOC_CSE_SCIENTIFIC_TRAIT_LARGE_INFLUENCE_BONUS',			'+2 [ICON_SCIENCE] Science in every University or Academy.'),
		('LOC_CSE_SCIENTIFIC_TRAIT_LARGEST_INFLUENCE_BONUS',		'+2 [ICON_SCIENCE] Science in every Laboratory or Liberal Arts College and Institute of Technology or Community College.'),
		('LOC_CSE_SCIENTIFIC_TRAIT_MEDIUM_INFLUENCE_MEKONG_BONUS',	'+1 [ICON_SCIENCE] Science in every Library or School.'),
		('LOC_CSE_SCIENTIFIC_TRAIT_LARGEST_INFLUENCE_MEKONG_BONUS',	'+3 [ICON_SCIENCE] Science in every Laboratory or Liberal Arts College. +4 [ICON_SCIENCE] Science in every Institute of Technology or Community College.');
--------------------------------------------------------------

-- CX
-- LocalizedText
--------------------------------------------------------------
INSERT OR REPLACE INTO LocalizedText
		(Language,	Tag,																		Text)
VALUES	('en_US',	'LOC_DISTRICT_OBSERVATORY_DESCRIPTION_JNR_UC_CX',							'A district unique to the Maya for scientific endeavors. Replaces the Campus. Buildings in this district may be purchased with [ICON_Faith] Faith. +1 [ICON_GreatProphet] Great Prophet point.[NEWLINE][NEWLINE]+1 [ICON_Science] Science bonus for each adjacent Luxury Resource and Plantation. +1 [ICON_Science] Science bonus for every two adjacent Farms or districts.[NEWLINE][NEWLINE]Unlocks the Venus Observations unique project, which provides [ICON_Faith] Faith and increased [ICON_Religion] Religious pressure while active, and [ICON_GreatProphet] Great Prophet points and a random [ICON_TechBoosted] Eureka upon completion.'),
		('en_US',	'LOC_TRAIT_CIVILIZATION_DYNASTIC_CYCLE_EXPANSION2_DESCRIPTION_JNR_UC_CX',	'Dedications for [ICON_Glory_Golden_Age] Golden Ages also grant the normal [ICON_Glory_Normal_Age] Era Score bonus. +1 [ICON_Amenities] Amenity and +1 [ICON_Housing] Housing in all cities during [ICON_Glory_Golden_Age] Golden Ages. Receive a random Civic after unlocking the Political Philosophy civic. [ICON_TechBoosted] Eurekas and [ICON_CivicBoosted] Inspirations grant an additional +10% boost. City Centers gain bonus yields based on which district building is constructed first: +2 [ICON_Science] Science from Level 1 Campus buildings, +2 [ICON_Culture] Culture from Level 1 Theater Square buildings, and +2 [ICON_Faith] Faith from Level 1 Holy Site buildings.'),
		('en_US',	'LOC_TRAIT_CIVILIZATION_PAX_BRITANNICA_EXPANSION2_DESCRIPTION_JNR_UC_CX',	'Cities on England''s home continent receive [ICON_Science] Science from Campus buildings equal to the building level and +1 [ICON_Amenities] Amenity. Cities on foreign continents receive [ICON_Production] Production from Industrial Zone buildings equal to the building level and +1 [ICON_Housing] Housing. Completing an Industrial Zone triggers a Culture Bomb. +1 [ICON_TradeRoute] Trade Route capacity for each type of Strategic resource improved in English territory. Gain access to the Redcoat unique unit after unlocking the Military Science technology.'),
		('en_US',	'LOC_TRAIT_CIVILIZATION_IMPERIAL_FREE_CITIES_DESCRIPTION_JNR_UC_CX',		'Each city may construct one more district than usual (exceeding the normal limit based on [ICON_Citizen] Population). [ICON_TradeRoute] Trade Routes to German cities gain +1 [ICON_Food] Food, +1 [ICON_Production] Production, and +1 [ICON_Gold] Gold per specialty district in the destination city. Level 2 buildings in Campuses, Industrial Zones, and Commercial Hubs provide +2 of their respective yields. Additionally, these buildings each grant +1 [ICON_Citizen] Population and +1 [ICON_Housing] Housing.'),
		('en_US',	'LOC_TRAIT_LEADER_TRAJANS_COLUMN_DESCRIPTION_JNR_UC_CX',					'Each city begins with a free Monument. City borders expand 15% faster. Farms receive +1 of the appropriate yield when adjacent to a Level 1 Building from the Campus, Theater Square, Holy Site, Industrial Zone, Commercial Hub, or Habor. Receive a Settler in the [ICON_Capital] Capital upon unlocking the Political Philosophy civic.'),
		('en_US',	'LOC_TRAIT_LEADER_HWARANG_DESCRIPTION_JNR_UC_CX',							'Recruiting a [ICON_GreatProphet] Great Prophet or a [ICON_GreatScientist] Great Scientist grants +1 [ICON_Governor] Governor Title and +1 [ICON_TradeRoute] Trade Route capacity. [ICON_Governor] Governors provide +3% [ICON_Science] Science and +3% [ICON_Culture] Culture to their cities for each Promotion. Campus buildings provide [ICON_Faith] Faith equal to their level +1.'),
		('en_US',	'LOC_TRAIT_CIVILIZATION_NOBEL_PRIZE_DESCRIPTION_JNR_UC_CX',					'+25% [ICON_GreatPerson] Great Person points in cities that have a Campus with a high [ICON_Science] Science adjacency bonus. Receive a random [ICON_TechBoosted] Eureka upon constructing a University or Academy. Earning a [ICON_GreatPerson] Great Person grants 50 [ICON_Favor] Diplomatic Favor. +20% [ICON_Production] Production towards district projects.');
--------------------------------------------------------------