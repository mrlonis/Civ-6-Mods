-- Settings
-- Author: MadManCam
-- DateCreated: 5/27/2018 6:03:35 AM
--------------------------------------------------------------

/*
    ??????????????????????????????????????????????????????????????????????????????????????????????
    ?                               Auto Builders Default settings                             	 ?
    ??????????????????????????????????????????????????????????????????????????????????????????????                                         
    ? These are the settings loaded by DEFAULT in Auto Builders.                                 ?
    ? 																							 ?
	? Formatting and methodology originally from CQUI, adapted for this mod.					 ?
	?																							 ?
    ? !!! Attention: Don't write your custom settings in the original copy of this file !!!      ?
    ?                                                                                            ?
    ? This file is where all default settings are stored, all changes to this file are lost      ?
    ? whenever updating to a new version (particularly if using the Steam Workshop version).	 ?
    ?                                                                                            ?
    ? To change default settings permanently without the risk of losing them, create a           ?
    ? copy of this file named 'AutoBuilders_LocalSettings.sql' and make your changes there.      ?
    ? The 'AutoBuilders_LocalSettings.sql' file does not need to be a perfect copy and will		 ?
    ? work as long as it's valid SQL.                                                            ?
    ?                                                                                            ?
    ??????????????????????????????????????????????????????????????????????????????????????????????
*/

-- General Options
INSERT INTO CNO_AutoBuilders_Settings -- Don't touch this line!
		( Setting, 								mBoolean 	) -- Don't touch this line!
VALUES 	-- Don't touch this line!
		
		-- Set to 1 (true) to enable automated Builders removing features for improvements (unless they can do something given a higher priority).
		( 'RemoveFeatures',							0		), -- Even if it is set to 0 (false), Builders will still remove features to improve resources. 
		-- Set to 1 (true) to enable automated Builders harvesting resources (unless they can do something given a higher priority).
		( 'HarvestResources',						0		), 
		-- Set to 1 (true) to enable automated Builders building farms 4 tiles out from your cities if the plot is adjacent to another farm that is within 3 tiles of cities after all strategic/luxury or within 3 tiles of cities have been improved.
		( 'FarmsIn4Tiles',							0		), 
		
		-- Set to 0 (false) to disable automated Archaeologists knowing where all artifacts are even if you haven't explored that area.
		( 'ArchaeologistsExplore',					1		), 
		-- Set to 1 (true) to enable automated Archaeologists excavating in other player's territory.
		( 'ArchaeologistsExcavateInOtherBorders',	0		);
		 

INSERT INTO CNO_AutoBuilders_Settings -- Don't touch this line!
		( Setting, 							mValue 	) -- Don't touch this line!
VALUES 	-- Don't touch this line!
		
		-- This is the maximum number of unique improvements OF ONE TYPE that Builders will build in the plots owned by one city.
		( 'MAX_Uniques_PerCity',				3		),
		-- This is a hard cap on the number of unique improvements OF ONE TYPE Automated Builders will ever build in a player's empire.
		( 'MAX_Uniques_Ever',					50		);


-- Priority Settings
INSERT INTO CNO_AutoBuilders_PrioritySettings -- Don't touch this line!
		( mTable,						Setting, 							mValue 	) -- Don't touch this line!
VALUES 	-- Don't touch this line!
		
		-- These are overriding hard cap settings for specific unique improvements.
		-- Colossal heads are just enabled by a city state, so create a lower cap to reduce spam.
		( 'MaxUniques_PerCity',			'IMPROVEMENT_COLOSSAL_HEAD',			1		),
		( 'MaxUniques_Ever',			'IMPROVEMENT_COLOSSAL_HEAD',			10		),
		( 'MaxUniques_PerCity',			'IMPROVEMENT_FISHERY',					5		),
		( 'MaxUniques_Ever',			'IMPROVEMENT_FISHERY',					100		),
		( 'MaxUniques_PerCity',			'IMPROVEMENT_CITY_PARK',				2		),
		( 'MaxUniques_Ever',			'IMPROVEMENT_CITY_PARK',				40		),

		-- These are priorities for certain improvements. If there are multiple options for one plot, the improvement with the highest value will be chosen.
		( 'Improvement_Scoring',		'IMPROVEMENT_MINE',						50		),
		( 'Improvement_Scoring',		'IMPROVEMENT_BEACH_RESORT',				40		),
		( 'Improvement_Scoring',		'IMPROVEMENT_FARM',						30		),
		( 'Improvement_Scoring',		'IMPROVEMENT_COLOSSAL_HEAD',			-20		), -- Colossal head gets a score less than -10 so it won't be chosen over other unique improvements.
		( 'Improvement_Scoring',		'IMPROVEMENT_FISHERY',					-10		),
		( 'Improvement_Scoring',		'IMPROVEMENT_CITY_PARK',				-10		),

		-- Distance: A lower number will have the Builder factor distance into the decision more.
		( 'Scoring',					'BUILDER_DISTANCE',						-5		),
		--		For 0, the Builder will not care how far away a tile is, it will only go by the other scores above.
		--		A higher number will have Builders factor turn distance and plot distance in more to what will be done.

		-- These settings are base scores to give each plot when choosing between the plot to move to.
		-- Higher numbers give the plot action a higher score when choosing a plot.
		-- If you delete a line entirely, the Builder will never perform that action.
		( 'Scoring',					'REPAIR',								200		), -- Repair an improvement
		( 'Scoring',					'REPAIR_ROAD',							180		), -- Repair a road.
		( 'Scoring',					'IMPROVE_STRATEGIC',					160		), -- Improve a strategic resource.
		( 'Scoring',					'IMPROVE_LUXURY',						120		), -- Improve a luxury
		( 'Scoring',					'IMPROVE_BONUS',						60		), -- Improve a bonus resource
		( 'Scoring',					'BUILD_UNIQUE_IMPROVEMENT',				40		), -- a unique improvement from a Trait or City State.
		( 'Scoring',					'BUILD_IMPROVEMENT',					20		), -- A normal improvement on a plot with no resource.
		( 'Scoring',					'REMOVE_FEATURE',						-20		), -- Removing a feature (will never happen if it is disabled above)
		( 'Scoring',					'HARVEST_RESOURCE',						-10		), -- Harvesting a resource (will never happen if it is disabled above)

		-- These settings are the priorities for individual plot actions.
		-- Higher numbers give the action a higher priority when choosing the best action for a plot.
		-- If you delete a line entirely, the Builder will never perform that action.
		( 'Priorities',					'REPAIR',								80		), -- Repair an improvement.
		( 'Priorities',					'REPAIR_ROAD',							70		), -- Repair a road.
		( 'Priorities',					'IMPROVE_STRATEGIC',					60		), -- Improve a strategic resource.
		( 'Priorities',					'IMPROVE_LUXURY',						50		), -- Improve a luxury
		( 'Priorities',					'IMPROVE_BONUS',						40		), -- Improve a bonus resource
		( 'Priorities',					'BUILD_UNIQUE_IMPROVEMENT',				30		), -- Priority for building a unique improvement.
		( 'Priorities',					'BUILD_IMPROVEMENT',					20		), -- A normal improvement on a plot with no resource.
		-- If you want to harvest all bonus resources or remove all features, enable it in the options above then give the below options higher numbers for a higher priority.
		( 'Priorities',					'HARVEST_RESOURCE',						10		), -- Harvesting a bonus resource will never happen if there is an improvement available.
		( 'Priorities',					'REMOVE_FEATURE',						5		); -- Removing a feature to put an improvement on the base terrain is the lowest priority.



