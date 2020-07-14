-- CB_REC_Text
-- Author: JNR
--------------------------------------------------------------

-- BaseGameText
--------------------------------------------------------------
INSERT OR IGNORE INTO BaseGameText
		(Tag, Text)
VALUES	-- Tech descriptions for improvement bonuses
		('LOC_TECH_OFFWORLD_MISSION_DESCRIPTION_JNR_REC',
		'Extra +1 [ICON_Power] Power per turn from each Geothermal Plant.'),
		('LOC_TECH_PREDICTIVE_SYSTEMS_DESCRIPTION_JNR_REC',
		'Extra +1 [ICON_Power] Power per turn from each Solar Farm and each Offshore Wind Farm.'),
		('LOC_TECH_COMPOSITES_DESCRIPTION_JNR_REC',
		'Extra +1 [ICON_Power] Power per turn from each Wind Farm (on land).'),
		('LOC_TECH_COMPUTERS_DESCRIPTION_JNR_REC',
		'Grants the ability to construct an additional Spy. +25% [ICON_Tourism] Tourism across your empire.[NEWLINE][NEWLINE]Extra +3 [ICON_Power] Power per turn from each Hydroelectric Dam.'),
		-- Resources
		('LOC_RESOURCE_JNR_BATTERY_CHARGE_NAME',
		'Renewable Battery Charges'),
		-- Building Names
		('LOC_BUILDING_JNR_RENEWABLE_COLLECTION_NAME',
		'Battery Substation'),
		('LOC_BUILDING_JNR_RENEWABLE_DISTRIBUTION_NAME',
		'Battery Power Station'),
		-- Building Descriptions
		('LOC_BUILDING_JNR_RENEWABLE_COLLECTION_DESCRIPTION',
		'Converts some [ICON_Power] Power from local renewable sources into [ICON_RESOURCE_JNR_BATTERY_CHARGE] Renewable Battery Charges resource for use at a {LOC_BUILDING_JNR_RENEWABLE_DISTRIBUTION_NAME} at a 1:1 ratio.[NEWLINE][ICON_Bullet]Any renewable [ICON_Power] Power added from improvements and buildings from technology upgrades.[NEWLINE][ICON_Bullet]Any renewable [ICON_Power] Power from improvements from terrain and feature bonuses.'),
		('LOC_BUILDING_JNR_RENEWABLE_DISTRIBUTION_DESCRIPTION',
		'Automatically converts any amount of [ICON_RESOURCE_JNR_BATTERY_CHARGE] Renewable Battery Charges into [ICON_Power] Power for cities within 6 tiles that need it each turn, at the rate of:[NEWLINE][ICON_Bullet]1 [ICON_RESOURCE_JNR_BATTERY_CHARGE] Renewable Battery Charges [ICON_PowerRight] 1 [ICON_Power] Power[NEWLINE][ICON_Bullet]No CO2 into the atmosphere[NEWLINE]Its [ICON_Production] Production, [ICON_Science] Science, and [ICON_Culture] Culture bonus is extended to all City Centers within 6 tiles that do not already have a bonus from a Power Plant building.'),
		-- Convert Reactor Project
		('LOC_PROJECT_JNR_CONVERT_REACTOR_TO_BATTERY',
		'Convert to Battery Power Station'),
		('LOC_PROJECT_JNR_CONVERT_REACTOR_TO_BATTERY_SHORT_NAME',
		'Convert to Battery Power Station'),
		('LOC_PROJECT_JNR_CONVERT_REACTOR_TO_BATTERY_DESCRIPTION',
		'Decommissions the current Power Plant in this city, and replaces it with the {LOC_BUILDING_JNR_RENEWABLE_DISTRIBUTION_NAME}.[NEWLINE][NEWLINE]{LOC_BUILDING_JNR_RENEWABLE_DISTRIBUTION_NAME}:[NEWLINE]{LOC_BUILDING_JNR_RENEWABLE_DISTRIBUTION_DESCRIPTION}'),
		-- Governor Update
		('LOC_GOVERNOR_PROMOTION_MERCHANT_RENEWABLE_DESCRIPTION_ENERGY_JNR_REC',
		'All Offshore Wind Farms, Solar Farms, Wind Farms, Geothermal Plants, and Hydroelectric Dams in this city receive +2 [ICON_Gold] Gold and produce +1 [ICON_POWER] Power and +1 [ICON_RESOURCE_JNR_BATTERY_CHARGE] Renewable Battery Charges.'),
		-- New Renewable Descriptions
		('LOC_IMPROVEMENT_GEOTHERMAL_PLANT_DESCRIPTION_JNR_REC',
		'Unlocks the Builder ability to construct a Geothermal Plant.[NEWLINE]Provides +2 [ICON_Power] Power per turn from renewable geothermal sources.[NEWLINE][ICON_Bullet]Extra +1 [ICON_Power] Power, +1 [ICON_Production] Production and +2 [ICON_Gold] Gold per turn if built on a Geothermal Fissure.[NEWLINE][ICON_Bullet]Extra +1 [ICON_Power] Power per turn when the Offworld Mission technology is researched.[NEWLINE]If a Battery Substatio buildingn is present in this city, the extra [ICON_Power] Power bonuses from Terrain and Technology will be granted as [ICON_RESOURCE_JNR_BATTERY_CHARGE] Renewable Battery Charges instead.[NEWLINE][NEWLINE]Must be built on a Geothermal Fissure or on Volcanic Soil.'),
		('LOC_IMPROVEMENT_WIND_FARM_DESCRIPTION_JNR_REC',
		'Unlocks the Builder ability to construct a Wind Farm.[NEWLINE]Provides +2 [ICON_Power] Power per turn from renewable wind sources.[NEWLINE][ICON_Bullet]Extra +1 [ICON_Power] Power and +2 [ICON_Gold] Gold per turn if built adjacent to coast.[NEWLINE][ICON_Bullet]Extra +1 [ICON_Power] Power per turn when the Composites technology is researched.[NEWLINE]If a Battery Substation building is present in this city, the extra [ICON_Power] Power bonuses from Terrain and Technology will be granted as [ICON_RESOURCE_JNR_BATTERY_CHARGE] Renewable Battery Charges instead.[NEWLINE][NEWLINE]Must be built on Hills terrain.'),
		('LOC_IMPROVEMENT_OFFSHORE_WIND_FARM_DESCRIPTION_JNR_REC',
		'Unlocks the Builder ability to construct an Offshore Wind Farm.[NEWLINE]Provides +2 [ICON_Power] Power per turn from renewable wind sources.[NEWLINE][ICON_Bullet]Extra +1 [ICON_Power] Power and +2 [ICON_Gold] Gold per turn if built on Ocean.[NEWLINE][ICON_Bullet]Extra +1 [ICON_Power] Power per turn when the Predictive Systems technology is reseached.[NEWLINE]If a Battery Substation building is present in this city, the extra [ICON_Power] Power bonuses from Terrain and Technology will be granted as [ICON_RESOURCE_JNR_BATTERY_CHARGE] Renewable Battery Charges instead.[NEWLINE][NEWLINE]Must be built on Coast, Lake, or Ocean terrain.[NEWLINE]Requires the Seasteads technology to be built on Ocean terrain.'),
		('LOC_IMPROVEMENT_SOLAR_FARM_DESCRIPTION_JNR_REC',
		'Unlocks the Builder ability to construct a Solar Farm.[NEWLINE]Provides +1 [ICON_Power] Power per turn from renewable solar sources.[NEWLINE][ICON_Bullet]Extra +1 [ICON_Power] Power and +1 [ICON_Gold] Gold per turn if built on Grasslands or Plains.[NEWLINE][ICON_Bullet]Extra +2 [ICON_Power] Power and +2 [ICON_Gold] Gold per turn if built on Desert.[NEWLINE][ICON_Bullet]Extra +1 [ICON_Power] Power per turn when the Predictive Systems technology is reseached.[NEWLINE]If a Battery Substation building is present in this city, the extra [ICON_Power] Power bonuses from Terrain (only on Desert) and Technology will be granted as [ICON_RESOURCE_JNR_BATTERY_CHARGE] Renewable Battery Charges instead.[NEWLINE][NEWLINE]Must be built on flat terrain.[NEWLINE]Requires the Advanced Power Cells technology to be built on Tundra or Snow terrain.'),
		('LOC_BUILDING_HYDROELECTRIC_DAM_DESCRIPTION_JNR_REC',
		'Provides +4 [ICON_Power] Power per turn from renewable water sources.[NEWLINE][ICON_Bullet]Extra +3 [ICON_Power] Power per turn when the Computers technology is researched.[NEWLINE]If a Battery Substation building is present in this city, the extra [ICON_Power] Power bonuses from Technology will be granted as [ICON_RESOURCE_JNR_BATTERY_CHARGE] Renewable Battery Charges instead.'),
		-- Other Improvements
		('LOC_IMPROVEMENT_SEASTEAD_DESCRIPTION_JNR_REC',
		'Unlocks the Builder ability to construct a Seastead.[NEWLINE][NEWLINE]+2 [ICON_FOOD] Food. +2 [ICON_Gold] Gold for each adjacent Offshore Wind Farm. +1 [ICON_Production] Production for each adjacent Fishing Boats. Fishing Boats receive +1 [ICON_Production] Production for each adjacent Seastead. +1 [ICON_Culture] Culture and [ICON_Tourism] Tourism for every adjacent Reef. +2 [ICON_HOUSING] Housing. Must be built on Coast, Lake or Ocean terrain. Cannot be placed adjacent to another Seastead. ');
--------------------------------------------------------------