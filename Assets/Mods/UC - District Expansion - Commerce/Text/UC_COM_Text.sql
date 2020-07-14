-- UC_COM_Text
-- Author: JNR
--------------------------------------------------------------

-- BaseGameText
--------------------------------------------------------------
INSERT OR IGNORE INTO BaseGameText
		(Tag,															Text)
VALUES	('LOC_DISTRICT_JNR_UC_OASIS_GOLD',								'+{1_num} [ICON_Gold] Gold from the adjacent Oasis {1_Num : plural 1?tile; other?tiles;}.'),
		('LOC_DISTRICT_JNR_UC_LUXURY_GOLD',								'+{1_num} [ICON_Gold] Gold from the adjacent Luxury {1_Num : plural 1?resource; other?resources;}.'),
		('LOC_DISTRICT_JNR_UC_AERODROME_GOLD',							'+{1_num} [ICON_Gold] Gold from the adjacent Aerodrome {1_Num : plural 2?district; other?districts;}.'),
		('LOC_DISTRICT_JNR_UC_CANAL_GOLD',								'+{1_num} [ICON_Gold] Gold from the adjacent Canal {1_Num : plural 2?district; other?districts;}.'),
		('LOC_DISTRICT_JNR_UC_FAIRGROUNDS_GOLD',						'+{1_num} [ICON_Gold] Gold from the adjacent Entertainment Complex {1_Num : plural 2?district; other?districts;}.'),
		('LOC_DISTRICT_JNR_UC_WATER_PARK_GOLD',							'+{1_num} [ICON_Gold] Gold from the adjacent Water Park {1_Num : plural 2?district; other?districts;}.'),
		('LOC_BUILDING_MARKET_DESCRIPTION_UC_JNR',						'+1 [ICON_TradeRoute] Trade Route capacity (A).[NEWLINE]+1 [ICON_Gold] Gold to all Bonus Resources in this city.[NEWLINE][NEWLINE]International [ICON_TradeRoute] Trade Routes from this city gain +1 [ICON_Gold] Gold.'),
		('LOC_BUILDING_JNR_MINT_NAME',									'Mint'),
		('LOC_BUILDING_JNR_MINT_DESCRIPTION',							'+1 [ICON_TradeRoute] Trade Route capacity (A).[NEWLINE]+1 [ICON_Gold] Gold per [ICON_GOVERNOR] Promotion of a Governor established in this city.[NEWLINE]Provides +2 Loyalty per turn to your cities within 6 tiles (does not stack).[NEWLINE][NEWLINE]International [ICON_TradeRoute] Trade Routes from this city gain +1 [ICON_Gold] Gold.'),
		('LOC_BUILDING_JNR_WAYSTATION_NAME',							'Waystation'),
		('LOC_BUILDING_JNR_WAYSTATION_DESCRIPTION',						'+1 [ICON_TradeRoute] Trade Route capacity (A).[NEWLINE]+1 [ICON_Gold] Gold per turn from each foreign [ICON_TradeRoute] Trade Route passing through the city. +1 [ICON_Gold] Gold per turn from and to each foreign [ICON_TradeRoute] Trade Route to this city.[NEWLINE][NEWLINE]International [ICON_TradeRoute] Trade Routes from this city gain +1 [ICON_Gold] Gold.'),
		('LOC_BUILDING_SUKIENNICE_DESCRIPTION_UC_JNR',					'A building unique to Poland.[NEWLINE]International [ICON_TradeRoute] Trade Routes from this city gain +2 [ICON_Production] Production; domestic [ICON_TradeRoute] Trade Routes gain +4 [ICON_Gold] Gold.[NEWLINE][NEWLINE]+1 [ICON_TradeRoute] Trade Route capacity (A).[NEWLINE]+1 [ICON_Gold] Gold per turn from each foreign [ICON_TradeRoute] Trade Route passing through the city. +1 [ICON_Gold] Gold per turn from and to each foreign [ICON_TradeRoute] Trade Route to this city.[NEWLINE][NEWLINE]International [ICON_TradeRoute] Trade Routes from this city gain +1 [ICON_Gold] Gold.'),
		('LOC_BUILDING_BANK_DESCRIPTION_UC_JNR',						'+0.5 [ICON_Gold] Gold per turn for each [ICON_Citizen] Citizen in the city.[NEWLINE][NEWLINE]International [ICON_TradeRoute] Trade Routes from this city gain +1 [ICON_Gold] Gold.'),
		('LOC_BUILDING_JNR_GUILDHALL_NAME',								'Guildhall'),
		('LOC_BUILDING_JNR_GUILDHALL_DESCRIPTION',						'International [ICON_TradeRoute] Trade Routes from this city gain +1 [ICON_Gold] Gold.'),
		('LOC_BUILDING_JNR_MERCHANT_QUARTER_NAME',						'Merchant Quarter'),
		('LOC_BUILDING_JNR_MERCHANT_QUARTER_DESCRIPTION',				'+2 [ICON_Gold] Gold per ally city this city has trade route to.[NEWLINE][NEWLINE]International [ICON_TradeRoute] Trade Routes from this city gain +1 [ICON_Gold] Gold.'),
		('LOC_BUILDING_GRAND_BAZAAR_DESCRIPTION_UC_JNR',				'A building unique to the Ottomans.[NEWLINE]Accumulate 1 extra Strategic resource for every different type of Strategic resource this city has improved. Receive 1 [ICON_AMENITIES] Amenity for every Luxury resource this city has improved.[NEWLINE][NEWLINE]International [ICON_TradeRoute] Trade Routes from this city gain +1 [ICON_Gold] Gold.'),
		('LOC_BUILDING_STOCK_EXCHANGE_DESCRIPTION_UC_JNR',				'+1 [ICON_TradeRoute] Trade Route capacity (B), if this city also has a Trade Dock building.[NEWLINE]+10% [ICON_Gold] Gold in this city.[NEWLINE][NEWLINE]International [ICON_TradeRoute] Trade Routes from this city gain +1 [ICON_Gold] Gold.'),
		('LOC_BUILDING_JNR_COMMODITY_EXCHANGE_NAME',					'Commodity Exchange'),
		('LOC_BUILDING_JNR_COMMODITY_EXCHANGE_DESCRIPTION',				'+1 [ICON_TradeRoute] Trade Route capacity (B), if this city also has a Trade Dock building.[NEWLINE]International [ICON_TradeRoute] Trade Routes from this city gain +1 [ICON_Gold] Gold for every Bonus resource within 3 tiles of the city and in this city''s territory; domestic [ICON_TradeRoute] Trade Routes gain +1 [ICON_PRODUCTION] Gold for each Strategic resource at the destination city.[NEWLINE][NEWLINE]International [ICON_TradeRoute] Trade Routes from this city gain +1 [ICON_Gold] Gold.'),
		('LOC_BUILDING_JNR_MARKETING_AGENCY_NAME',						'Marketing Agency'),
		('LOC_BUILDING_JNR_MARKETING_AGENCY_DESCRIPTION',				'All tiles in this city gain +1 Appeal.[NEWLINE]+2 [ICON_Gold] Gold from each Great Work in this city.[NEWLINE]+2 [ICON_Gold] Gold from each Entertainment Complex building in this city.[NEWLINE][NEWLINE]International [ICON_TradeRoute] Trade Routes from this city gain +1 [ICON_Gold] Gold.'),
		('LOC_BUILDING_JNR_MARKETING_AGENCY_DESCRIPTION_SKI',			'All tiles in this city gain +1 Appeal.[NEWLINE]+2 [ICON_Gold] Gold from each Great Work in this city.[NEWLINE]+2 [ICON_Gold] Gold from each Entertainment Complex building in this city.[NEWLINE]+1 [ICON_Gold] Gold to each Ski Resort in this city.[NEWLINE][NEWLINE]International [ICON_TradeRoute] Trade Routes from this city gain +1 [ICON_Gold] Gold.'),
		('LOC_BUILDING_JNR_DUMMY_CITY_COASTAL_NAME',					'Coastal Access'),
		('LOC_BUILDING_JNR_DUMMY_CITY_COASTAL_DESCRIPTION',				'DUMMY: City is Coastal'),
		('LOC_BUILDING_JNR_WHARF_BASE_NAME',							'Wharf'),
		('LOC_BUILDING_JNR_WHARF_BASE_DESCRIPTION',						'Automatically created in city which has either direct coastal access or via Canal district (or Panama Canal wonder).'),
		('LOC_BUILDING_JNR_WHARF_FISHING_NAME',							'Fishing Dock (Wharf)'),
		('LOC_BUILDING_JNR_WHARF_FISHING_DESCRIPTION',					'+25% combat experience for all naval units trained in this city.[NEWLINE]+1 [ICON_FOOD] Food on all Coast tiles for this city. +1 [ICON_FOOD] Food on all Ocean tiles for this city once Cartography is discovered. +1 [ICON_Production] Production to each Fishing Boat and Fishery in this city.'),
		('LOC_BUILDING_LIGHTHOUSE_NAME_UC_JNR',							'Fishing Dock (Lighthouse)'),
		('LOC_BUILDING_LIGHTHOUSE_DESCRIPTION_UC_JNR',					'+25% combat experience for all naval units trained in this city.[NEWLINE]+1 [ICON_FOOD] Food on all Coast tiles for this city. +1 [ICON_FOOD] Food on all Ocean tiles for this city once Cartography is discovered. +1 [ICON_Production] Production for each Fishing Boat and Fishery in this city.'),
		('LOC_BUILDING_JNR_WHARF_TRADE_NAME',							'Trade Dock (Wharf)'),
		('LOC_BUILDING_JNR_WHARF_TRADE_DESCRIPTION',					'+1 [ICON_TradeRoute] Trade Route capacity (A).[NEWLINE]+1 [ICON_Gold] Gold to all Luxury Resources in this city.[NEWLINE][NEWLINE]International [ICON_TradeRoute] Trade Routes from this city gain +1 [ICON_Gold] Gold.'),
		('LOC_BUILDING_JNR_LIGHTHOUSE_TRADE_NAME',						'Trade Dock (Lighthouse)'),
		('LOC_BUILDING_JNR_LIGHTHOUSE_TRADE_DESCRIPTION',				'+1 [ICON_TradeRoute] Trade Route capacity (A).[NEWLINE]+1 [ICON_Gold] Gold to all Luxury Resources in this city.[NEWLINE][NEWLINE]International [ICON_TradeRoute] Trade Routes from this city gain +1 [ICON_Gold] Gold.'),
		('LOC_BUILDING_JNR_HAVEN_NAME',									'Haven'),
		('LOC_BUILDING_JNR_HAVEN_DESCRIPTION',							'+1 [ICON_GOLD] Gold on all Coast tiles for this city. +1 [ICON_GOLD] Gold on all Ocean tiles for this city once Electricity is discovered. Doubled if this city is on a different continent from your capital.[NEWLINE]All Naval Raider units trained in this city require only 1 [ICON_Movement] Movement point to pillage.[NEWLINE]+1 [ICON_PRODUCTION] Production on all unimproved Coast tiles for this city.[NEWLINE][NEWLINE]International [ICON_TradeRoute] Trade Routes from this city gain +1 [ICON_Gold] Gold.'),
		('LOC_BUILDING_JNR_CONSULATE_NAME',								'Consulate'),
		('LOC_BUILDING_JNR_CONSULATE_DESCRIPTION',						'+1 [ICON_GOLD] Gold from each city-state you''re Suzerain of.[NEWLINE]+1 [ICON_PRODUCTION] Production on all unimproved Coast tiles for this city.[NEWLINE][NEWLINE]International [ICON_TradeRoute] Trade Routes from this city gain +1 [ICON_Gold] Gold.'),
		('LOC_BUILDING_SEAPORT_DESCRIPTION_UC_JNR_COM',					'+1 [ICON_TradeRoute] Trade Route capacity (B), if this city also has any Commercial Hub building.[NEWLINE]+1 [ICON_Food] Food to each Fishing Boat and Fishery in this city.[NEWLINE]+1 [ICON_Production] Production to each Offshore Oil Rig, Offshore Wind Farm and Seastead in this city.[NEWLINE]+25% combat experience for all naval units trained in this city. Allows Fleets and Armadas to be trained directly. Fleet and Armada training costs reduced 25%.[NEWLINE][NEWLINE]International [ICON_TradeRoute] Trade Routes from this city gain +1 [ICON_Gold] Gold.'),
		('LOC_BUILDING_SEAPORT_DESCRIPTION_UC_JNR_MIL_COM',				'+1 [ICON_TradeRoute] Trade Route capacity (B), if this city also has any Commercial Hub building.[NEWLINE]+1 [ICON_Food] Food to each Fishing Boat and Fishery in this city.[NEWLINE]+1 [ICON_Production] Production to each Offshore Oil Rig, Offshore Wind Farm and Seastead in this city.[NEWLINE]International [ICON_TradeRoute] Trade Routes from this city provide +1 [ICON_Gold] Gold per specialty district in the foreign city.[NEWLINE][NEWLINE]International [ICON_TradeRoute] Trade Routes from this city gain +1 [ICON_Gold] Gold.'),
		('LOC_BUILDING_JNR_CRUISE_TERMINAL_NAME',						'Cruise Terminal'),
		('LOC_BUILDING_JNR_CRUISE_TERMINAL_DESCRIPTION',				'+25% [ICON_Tourism] Tourism from Wonders in this city.[NEWLINE]All world wonders in this city provide +4 [ICON_Gold] Gold.[NEWLINE]+2 [ICON_Gold] Gold from each Water Park building in this city.[NEWLINE]+1 [ICON_Gold] Gold to each Seaside Resort in this city.[NEWLINE][NEWLINE]International [ICON_TradeRoute] Trade Routes from this city gain +1 [ICON_Gold] Gold.'),
		('LOC_BUILDING_HANGAR_DESCRIPTION_UC_JNR_COM',					'+50% combat experience for air units trained in this city.[NEWLINE]+2 air unit slot in Aerodrome district.[NEWLINE][NEWLINE]If this city also has an Airport: Allows the ability to airlift land units between fully-developed Aerodrome districts after the Rapid Deployment civic is unlocked.'),
		('LOC_BUILDING_HANGAR_DESCRIPTION_UC_JNR_MIL_COM',				'+50% [ICON_Production] Production towards all air units trained in this city.[NEWLINE]+50% combat experience for air units trained in this city.[NEWLINE]Air units trained in this city start with a free promotion.[NEWLINE]+2 air unit slots in Aerodrome district.[NEWLINE][NEWLINE]If this city also has an Airport: Allows the ability to airlift land units between fully-developed Aerodrome districts after the Rapid Deployment civic is unlocked.'),
		('LOC_BUILDING_AIRPORT_DESCRIPTION_UC_JNR_COM',					'+1 [ICON_TradeRoute] Trade Route capacity (B).[NEWLINE]+25% [ICON_Tourism] Tourism pressure from this city towards other civilizations in the Modern era.[NEWLINE]Yield and tourism bonuses are extended to all city centers within 6 tiles. This bonus applies once to a city, and multiple copies of this building within 6 tiles of a city center do not provide additional bonuses.[NEWLINE]+1 air unit slot in Aerodrome district.[NEWLINE][NEWLINE]If this city also has a Hangar: Allows the ability to airlift land units between fully-developed Aerodrome districts after the Rapid Deployment civic is unlocked.[NEWLINE][NEWLINE]International [ICON_TradeRoute] Trade Routes from this city gain +1 [ICON_Gold] Gold.'),
		('LOC_ABILITY_JNR_HAVEN_TRAINED_UNIT_PILLAGE_DESCRIPTION',		'Pillaging costs only 1 [ICON_Movement] Movement point.'),
		('LOC_ABILITY_HANGAR_TRAINED_AIRCRAFT_XP_DESCRIPTION_UC_JNR',	'+50% Earned experience from Hangar'),
		('LOC_BOOST_TRIGGER_CAPITALISM_JNR_UC',							'Build 2 Stock Exchanges.'),
		('LOC_BOOST_TRIGGER_SQUARE_RIGGING_JNR_UC',						'Build a Consulate.'),
		('LOC_BOOST_TRIGGER_LONGDESC_SQUARE_RIGGING_JNR_UC',			'As trade ambassadors from far places set up office in your ports, a stronger fleet is needed to protect trade routes.'),
		('LOC_GREATPERSON_HORATIO_NELSON_EXPANSION2_ACTIVE_UC_JNR',		'Instantly builds a Fishing Dock (Lighthouse) and Shipyard in this district. +50% flanking bonus for all naval units.'),
		('LOC_PROMOTION_SURF_ROCK_DESCRIPTION_UC_JNR',					'Performs at Seaside Resorts and Harbors for +500 [ICON_TOURISM] Tourism (+1000 [ICON_TOURISM] Tourism if Harbor has a Shipyard, Haven or Consulate) and 1 level more experienced.'),
		('LOC_PROMOTION_JNR_STUNT_MASTER_NAME',							'Stunt Master'),
		('LOC_PROMOTION_JNR_STUNT_MASTER_DESCRIPTION',					'Performs at Airstrips and Aerodromes for +500 [ICON_TOURISM] Tourism (+1000 [ICON_TOURISM] Tourism if Aerodrome has a Hangar or Cargo Terminal) and 1 level more experienced.'),
		('LOC_POLICY_JNR_ADMIRALITY_COURT_NAME',						'Admirality Court'),
		('LOC_POLICY_JNR_ADMIRALITY_COURT_DESCRIPTION',					'Extra Yields from buildings in Harbors: +1 [ICON_PRODUCTION] if city [ICON_CITIZEN] population is 10 or higher, +1 [ICON_FOOD] Food if district has at least +5 adjacency bonus.'),
		('LOC_POLICY_FREE_MARKET_DESCRIPTION_JNR_UC',					'Extra [ICON_Gold] Gold from buildings in Commercial Hubs: +2 if city [ICON_CITIZEN] population is 10 or higher, +2 if district has at least +5 adjacency bonus.');
--------------------------------------------------------------

-- City-State UI
-- BaseGameText
--------------------------------------------------------------
INSERT OR REPLACE INTO BaseGameText
		(Tag,													Text)
VALUES	('LOC_MINOR_CIV_TRADE_TRAIT_MEDIUM_INFLUENCE_BONUS',	'+2 [ICON_Gold] Gold in every Market, Mint, Waystation or Lighthouse (both types) building.'),
		('LOC_MINOR_CIV_TRADE_TRAIT_LARGE_INFLUENCE_BONUS',		'+2 [ICON_Gold] Gold in every Bank, Guildhall, Merchant Quarter, Shipyard, Haven or Consulate building.');
--------------------------------------------------------------

-- RwF
-- BaseGameText
--------------------------------------------------------------
INSERT OR IGNORE INTO BaseGameText
		(Tag,														Text)
VALUES	('LOC_POLICY_JFD_FREE_MARKET_DESCRIPTION_UC_JNR',			'+2 [ICON_GOLD] Gold from Commercial Hub Buildings.');
--------------------------------------------------------------

-- City-State UI CSE
-- BaseGameText
--------------------------------------------------------------
INSERT OR REPLACE INTO BaseGameText
		(Tag,														Text)
VALUES	('LOC_CSE_TRADE_TRAIT_MEDIUM_INFLUENCE_BONUS',				'+4 [ICON_GOLD] Gold in every Market, Mint, Waystation or Lighthouse (both types).'),
		('LOC_CSE_TRADE_TRAIT_MEDIUM_INFLUENCE_BONUS_ALT',			'+4 [ICON_GOLD] Gold in every Market, Mint or Waystation.'),
		('LOC_CSE_TRADE_TRAIT_LARGE_INFLUENCE_BONUS',				'+4 [ICON_GOLD] Gold in every Bank, Guildhall, Merchant Quarter, Shipyard, Haven or Consulate.'),
		('LOC_CSE_TRADE_TRAIT_LARGE_INFLUENCE_BONUS_ALT',			'+4 [ICON_GOLD] Gold in every Bank, Guildhall or Merchant Quarter.'),
		('LOC_CSE_TRADE_TRAIT_LARGEST_INFLUENCE_BONUS',				'+4 [ICON_GOLD] Gold in every Stock Exchange, Commodity Exchange, Marketing Agency, Seaport, Cruise Terminal or Naval Base.'),
		('LOC_CSE_TRADE_TRAIT_LARGEST_INFLUENCE_BONUS_ALT',			'+4 [ICON_GOLD] Gold in every Stock Exchange, Commodity Exchange or Marketing Agency.'),
		('LOC_CSE_MARITIME_TRAIT_MEDIUM_INFLUENCE_BONUS',			'+1 [ICON_FOOD] Food and +1 [ICON_PRODUCTION] Production in every Lighthouse (both types).'),
		('LOC_CSE_MARITIME_TRAIT_LARGE_INFLUENCE_BONUS',			'+1 [ICON_FOOD] Food and +1 [ICON_PRODUCTION] Production in every Shipyard, Haven or Consulate.'),
		('LOC_CSE_MARITIME_TRAIT_LARGEST_INFLUENCE_BONUS',			'+1 [ICON_FOOD] Food and +1 [ICON_PRODUCTION] Production in every Seaport, Cruise Terminal or Naval Base.'),
		('LOC_CSE_TRADE_TRAIT_MEDIUM_INFLUENCE_MEKONG_BONUS',		'+2 [ICON_GOLD] Gold in every Market, Mint, Waystation or Lighthouse (both types).'),
		('LOC_CSE_TRADE_TRAIT_MEDIUM_INFLUENCE_MEKONG_BONUS_ALT',	'+2 [ICON_GOLD] Gold in every Market, Mint or Waystation.'),
		('LOC_CSE_TRADE_TRAIT_LARGEST_INFLUENCE_MEKONG_BONUS',		'+6 [ICON_GOLD] Gold in every Stock Exchange, Commodity Exchange, Marketing Agency, Seaport, Cruise Terminal or Naval Base.'),
		('LOC_CSE_TRADE_TRAIT_LARGEST_INFLUENCE_MEKONG_BONUS_ALT',	'+6 [ICON_GOLD] Gold in every Stock Exchange, Commodity Exchange or Marketing Agency.'),
		('LOC_CSE_MARITIME_TRAIT_MEDIUM_INFLUENCE_MEKONG_BONUS',	'+1 [ICON_FOOD] Food in every Lighthouse (both types).'),
		('LOC_CSE_MARITIME_TRAIT_LARGEST_INFLUENCE_MEKONG_BONUS',	'+1 [ICON_FOOD] Food, +1 [ICON_PRODUCTION] Production and +2 [ICON_GOLD] Gold in every Seaport, Cruise Terminal or Naval Base.');
--------------------------------------------------------------