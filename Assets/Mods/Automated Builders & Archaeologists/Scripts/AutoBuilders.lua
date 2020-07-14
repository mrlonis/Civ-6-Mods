--------------------------------------------------------------------------------------------------------


-- ATTENTION:

-- SETTINGS ARE NO LONGER CONTAINED IN THIS FILE. SEE the AutoBuilders_Settings.sql TO CHANGE SETTINGS


--------------------------------------------------------------------------------------------------------
local debug				:boolean = true; -- Set to true to enable basic debug messages in the Lua.log
local debug_FindAction 	:boolean = false; -- Set to true to enable LOTS of debug messages for finding plot actions and scoring them.
local debug_GameInfo	:boolean = false; -- Set to true to enable printing all of the resources, improvements, features, and terrains loaded into mod.
--------------------------------------------------------------------------------------------------------
--[[

AUTOMATED BUILDERS SCRIPT

Mod Version: 0.98.2
Script Version: 0.97
Contributors: MadManCam
Created: 27 Nov 2017
Last Edited: 8 Jul 2018

This script contains the processing and logic for the Automated Builders Mod for Civilization 6.

Steam Workshop Mod: http://steamcommunity.com/sharedfiles/filedetails/?id=1243167006
Civ Fanatics Resource: https://forums.civfanatics.com/resources/automated-builders-archaeologists.26662/


CHANGELOG
Version 0.97 ( MadManCam )
- Removed UnitPanel.lua replacement, added a separate panel to automate units and show their current status.
- This new method makes the ability to automate units more reliable. It also means this mod is now compatible with other mods that replace the UnitPanel.lua file.
- Units now calculate their moves primarily on number of turns away, rather than plot distance (although it is still used).
- Enforce sea/land domain rule for improvements. This fixes issues with improving resources that have both land and sea improvements (such as Amber).
- Enforce a maximum number of unique improvements of a certain type per city/empire to reduce possible unique improvement spam. Changeable in the mod settings (default of 3 unique improvements of one type per city).
- You can also override the maximums for specific unique improvements. By default, Colossal Head unique improvement caps are reduced at 1 per city and 10 per empire.
- Added support for hot seat mode. Automated Builders/Archaelogists will now stay automated even after the UI is refreshed.
- Fixed script definitions for traders/civilian/religious units so that new units of that type added by mods or DLC will be recognized.
- At the beginning of every turn, the Unit Manager will reprocess automated builder actions and reassign builders to closer plots.

Version 0.96 ( MadManCam )
- Fixed an issue where automated units would try to target plots in National Parks.

Version 0.95 ( MadManCam )
- Fixed a bug where the mod would only ever recognize one leader/civilization with a unique improvement. This would have caused issues 
	if you were playing with a mod that gives a trait for a unique improvement to multiple default/modded leaders.
- Fixed a "ghost unit" issue where newly created units had a small chance of becoming automated right away and bugging out, 
	taking on the automation from a previously destroyed/spent unit if the game assigned them the old unit's ID.
- Tried to fix an issue where there was a small chance a Builder could target a plot outside of player's borders. 
- Implemented a basic virtual moderator for the automated units: if a unit tries to do something and there is an error, 
	that action on that plot will be banned for all automated units for that session (the data is reset when the UI is refreshed 
	or when you re-load the game). Please post a bug report if you ever see a unit doing something bad like moving back and forth for several turns.
- Changed how required techs/civics were checked so that if a modder ever makes both a Tech AND Civic required for an 
	improvement that the mod will check for both.

Version 0.94 ( MadManCam )
- Updated actual automation code for compatibility with games without the Fall 2017 patch: If the Fall 2017 patch is not installed,
	Automated units will no longer try to target plots that have religious units since they did not have their own layer until this patch.
- Enemy spies should no longer block Automated units targeting the plot. This didn't really affect automated Builders or Archaeologists 
	since they never targeted plots with districts anyways, but it will be important for future mods with other automated units.
	
Version 0.93 ( MadManCam )
- Fixed debug settings (there were extra copies later in the file that would overwrite user settings).

Version 0.92 ( MadManCam )
- Finding Builder actions was previously set up so that Builders would only repair stuff within 3 tiles of your cities 
	(or strategic/luxury resources anywhere). Fixed so that after they are done doing everything within 3 tiles of your cities 
	(or improving/repairing strategic/luxury anywhere), Builders will check all of your tiles for possible repairs if you have roads 
	or have manually built improvements out there.

Version 0.91 ( MadManCam )
- For automated Builder settings, I've updated how they work so that if a line is deleted entirely from the settings then the Builder 
	will never perform that action.
- Once automated Builders have finished building improvements within 3 tiles of your cities (or strategic or luxury resources anywhere 
	in your borders), you can turn on a setting to have them build farms on plots adjacent to other farms within 4 tiles of your cities 
	for the food adjacency bonus. This feature must be turned on in settings (see discussion).

Version 0.90 ( MadManCam )
- Added script.


CONTRIBUTOR NOTES
- Not tested on Mac or Linux.


END USER DESCRIPTION
Notes/Features
- Automated Builders will automatically move around and improve your tiles, obeying all relevant rules defined in the game database (including from any mods). If there is nothing to do, they will sleep and check for stuff to do at the beginning of each turn.
- Automated Builders will improve strategic or luxury resources anywhere, but otherwise will only build improvements within 3 tiles of your cities. If there is nothing to do, they will check all of your tiles for possible repairs.
- Automated Builders will do stuff when your turn activates or when you press the Automate button. Sorry, right now I haven't found a way to make them do stuff right before your turn ends.
- After all strategic/luxury resources are improved and everything else within 3 tiles of cities is improved, you can turn on a setting in the mod settings (see discussion) to enable Builders building farms within 4 tiles of your cities as long as it is adjacent to a farm in the 3 tile range for food adjacency bonus.
- Automated Builders have no care for their own safety. If you are worried, it's best to link them with a military unit and then automate the Builder. Keep in mind, however, that a Builder in formation with a military unit means they cannot move to and improve a plot with another military unit.
- Harvesting resources is disabled by default. Even if it is enabled, Builders will by default try to improve the bonus resource if they can.
- Removing features is disabled by default unless removing a feature to improve a resource. Even if it is enabled, Builders will by default put an improvement over the feature if they can.
- Builders will never replace an improvement, unless they are removing an improvement to replace it with the correct improvement for a newly discovered resource.
- Any improvement that must be built on the frontier, such as China's Great Wall, is not currently implemented. Automated Builders will not build these improvements.
- For now, automated Builders will not perform any actions on districts or wonder tiles, such as Aztec district completion or China's Wonder completion.
- At the beginning of every turn, the Unit Manager will reprocess automated builder actions and reassign builders to closer plots.

How do automated Builders decide what to do?
- For any given plot, the default priority for selecting an action is Repair > Repair road > Improve Resource > Build unique improvement > Build improvement
- If a Builder has to choose between multiple non-unique improvements on a plot, it will go by some numbers in the settings. By default it is Mine > Beach Resort > Farm  for normal improvements. If there are multiple unique improvements possible, by default Colossal Head (from La Venta suzerain) will not be chosen.
- When a Builder is deciding what to do, each plot in your territory is given a base score based on the action determined for that plot.
- The base score for each plot is reduced based on how far away the plot is from the Builder. The plot with the highest score is chosen.
- You can check out the mod settings (see discussion) to see the numbers, but repairing stuff and improving resources is given a very high priority, they have to be very far away before a Builder will ignore them.
- Automated Builders will not choose the same plot. They will also not choose a plot that they cannot move to, if it is occupied by an enemy or another civilian.
- If an enemy unit or another civilian moves into the plot a Builder is targeting, the Builder's action will be refreshed and they will target something else.

--]]
--------------------------------------------------------------------------------------------------------


--======================================================================================================
-- MEMBERS
--======================================================================================================
local b_RemoveFeatures		= GameInfo.CNO_AutoBuilders_Settings[ "RemoveFeatures" ].mBoolean;
local b_HarvestResources	= GameInfo.CNO_AutoBuilders_Settings[ "HarvestResources" ].mBoolean;
local b_FarmsIn4Tiles		= GameInfo.CNO_AutoBuilders_Settings[ "FarmsIn4Tiles" ].mBoolean;
b_RemoveFeatures = b_RemoveFeatures == 1 or b_RemoveFeatures == true;
b_HarvestResources = b_HarvestResources == 1 or b_HarvestResources == true;
b_FarmsIn4Tiles = b_FarmsIn4Tiles == 1 or b_FarmsIn4Tiles == true;

--local b_UseAutoBuilderManager = GameInfo.CNO_AutoBuilders_Settings[ "AutoBuilderManager" ].mBoolean;
--b_UseAutoBuilderManager = b_UseAutoBuilderManager == 1 or b_UseAutoBuilderManager == true;
local b_UseAutoBuilderManager = false;

local MAX_Uniques_PerCity	= GameInfo.CNO_AutoBuilders_Settings[ "MAX_Uniques_PerCity" ].mValue;
local MAX_Uniques_Ever		= GameInfo.CNO_AutoBuilders_Settings[ "MAX_Uniques_Ever" ].mValue;
if MAX_Uniques_PerCity < 0 then MAX_Uniques_PerCity = 0; end
if MAX_Uniques_Ever < 0 then MAX_Uniques_Ever = 0; end

local m_MaxUniques_Ever = {}; 
local m_MaxUniques_PerCity = {};
local m_Scoring = {};
local m_Improvement_Scoring = {};
local m_Priorities = {};

local BAD_DISTANCE = 9999;
local BAD_SCORE = -99;

--------------------------------------------------------------------------------------------------------
-- Setting to value (just for priorities).
local function SettingToValue( setting )
	--local value = setting;
	if setting == nil then return nil; end
	if setting < -99 then setting = BAD_SCORE; end -- For now, just limit value range. 
	if setting > 400 then setting = 400; end
	return setting;
end

local debug_AllActions = false; -- Set to true to enable EVEN MORE debug messages printed to log for each plot.
if debug == nil then debug = false; end
if debug_FindAction == nil then debug_FindAction = false; end
if debug_GameInfo == nil then debug_GameInfo = false; end

-- Some functions for debug/error usage.
local function Error() print( "AutoBuilder ERROR!" ); end
local function Error( message ) if not message then Error() else print( "AutoBuilder ERROR: " .. message ); end end
local function DebugError() print( "AutoBuilder debug ERROR" ); end
local function Debug( message ) if debug == true then if message then print( "AutoBuilder Debug: " .. message ); else DebugError(); end end end
local function Debug_Actions( message ) if debug_FindAction == true then if message then print( "AutoBuilder Debug: " .. message ); else DebugError(); end end end
local function Debug_AllActions( message ) if debug_AllActions == true then if message then print( "AutoBuilder Debug: " .. message ); else DebugError(); end end end

-- A user setting not yet implemented.
local b_PlantForests		:boolean = true; -- Set to false to disable automated Bilders planting forests.

local pref = "AutoBuilders_";
local function OnUpdateAutoBuilderSettings()
	b_RemoveFeatures 	= GameConfiguration.GetValue( pref .. "RemoveFeatures_Boolean" );
	b_HarvestResources 	= GameConfiguration.GetValue( pref .. "HarvestResources_Boolean" );
	b_FarmsIn4Tiles 	= GameConfiguration.GetValue( pref .. "FarmsIn4Tiles_Boolean" );
	MAX_Uniques_PerCity = GameConfiguration.GetValue( pref .. "MAX_Uniques_PerCity_Value" );
	MAX_Uniques_Ever 	= GameConfiguration.GetValue( pref .. "MAX_Uniques_Ever_Value" );
	if b_RemoveFeatures == nil then 	b_RemoveFeatures	= GameInfo.CNO_AutoBuilders_Settings[ "RemoveFeatures" ].mBoolean; end
	if b_HarvestResources == nil then 	b_HarvestResources 	= GameInfo.CNO_AutoBuilders_Settings[ "HarvestResources" ].mBoolean; end
	if b_FarmsIn4Tiles == nil then 		b_FarmsIn4Tiles 	= GameInfo.CNO_AutoBuilders_Settings[ "FarmsIn4Tiles" ].mBoolean; end
	if MAX_Uniques_PerCity == nil then 	MAX_Uniques_PerCity = GameInfo.CNO_AutoBuilders_Settings[ "MAX_Uniques_PerCity" ].mValue; end
	if MAX_Uniques_Ever == nil then 	MAX_Uniques_Ever	= GameInfo.CNO_AutoBuilders_Settings[ "MAX_Uniques_Ever" ].mValue; end
	b_RemoveFeatures 	= b_RemoveFeatures == 1 or b_RemoveFeatures == true;
	b_HarvestResources 	= b_HarvestResources == 1 or b_HarvestResources == true;
	b_FarmsIn4Tiles 	= b_FarmsIn4Tiles == 1 or b_FarmsIn4Tiles == true;
end
local function OnUpdateAutoBuilderPrioritySettings()
	for row in GameInfo.CNO_AutoBuilders_PrioritySettings() do
		local value = SettingToValue( GameConfiguration.GetValue( pref .. row.mTable .. "_" .. row.Setting .. "_Value" ) );
		if value == nil then value = SettingToValue( row.mValue ); end
		if row.mTable == "MaxUniques_PerCity" then
			m_MaxUniques_PerCity[ row.Setting ] = value;
			--print( "MaxUniques_PerCity: " .. row.Setting .. " = " .. value );
		elseif row.mTable == "MaxUniques_Ever" then
			m_MaxUniques_Ever[ row.Setting ] = value;
			--print( "MaxUniques_Ever: " .. row.Setting .. " = " .. value );
		elseif row.mTable == "Scoring" then
			m_Scoring[ row.Setting ] = value;
		elseif row.mTable == "Priorities" then
			m_Priorities[ row.Setting ] = value;
		elseif row.mTable == "Improvement_Scoring" then
			m_Improvement_Scoring[ row.Setting ] = value;	
		end
	end
end
OnUpdateAutoBuilderSettings();
OnUpdateAutoBuilderPrioritySettings();


-- Recreate settings if they are not present.
if b_RemoveFeatures	== nil then b_RemoveFeatures = false; end
if b_HarvestResources == nil then b_HarvestResources = false; end
if b_FarmsIn4Tiles == nil then b_FarmsIn4Tiles = false; end
if b_PlantForests == nil then b_PlantForests = false; end

if not MAX_Uniques_PerCity then MAX_Uniques_PerCity = 3; end
if not MAX_Uniques_Ever then MAX_Uniques_Ever = 50; end
if not m_MaxUniques_Ever then m_MaxUniques_Ever = {}; end
if not m_MaxUniques_PerCity then m_MaxUniques_PerCity = {}; end
if not m_MaxUniques_PerCity["IMPROVEMENT_COLOSSAL_HEAD"] then m_MaxUniques_PerCity["IMPROVEMENT_COLOSSAL_HEAD"] = 1; end
if not m_MaxUniques_Ever["IMPROVEMENT_COLOSSAL_HEAD"] then m_MaxUniques_Ever["IMPROVEMENT_COLOSSAL_HEAD"] = 10; end

if not m_Scoring then m_Scoring = {}; end
if not m_Scoring["REPAIR"] then m_Scoring["REPAIR"] = BAD_SCORE; end
if not m_Scoring["REPAIR_ROAD"] then m_Scoring["REPAIR_ROAD"]= BAD_SCORE; end
if not m_Scoring["IMPROVE_STRATEGIC"] then m_Scoring["IMPROVE_STRATEGIC"] = BAD_SCORE; end
if not m_Scoring["IMPROVE_LUXURY"] then m_Scoring["IMPROVE_LUXURY"] = BAD_SCORE; end
if not m_Scoring["IMPROVE_BONUS"] then m_Scoring["IMPROVE_BONUS"] = BAD_SCORE; end
if not m_Scoring["BUILD_IMPROVEMENT"] then m_Scoring["BUILD_IMPROVEMENT"] = BAD_SCORE; end
if not m_Scoring["BUILD_UNIQUE_IMPROVEMENT"] then m_Scoring["BUILD_UNIQUE_IMPROVEMENT"] = BAD_SCORE; end
if not m_Scoring["HARVEST_RESOURCE"] then m_Scoring["HARVEST_RESOURCE"] = BAD_SCORE; end
if not m_Scoring["REMOVE_FEATURE"] then m_Scoring["REMOVE_FEATURE"] = BAD_SCORE; end
if not m_Scoring["BUILDER_DISTANCE"] then m_Scoring["BUILDER_DISTANCE"] = 0; end

if not m_Improvement_Scoring then m_Improvement_Scoring = {}; end
if not m_Improvement_Scoring["IMPROVEMENT_MINE"] then m_Improvement_Scoring["IMPROVEMENT_MINE"] = -1; end
if not m_Improvement_Scoring["IMPROVEMENT_FARM"] then m_Improvement_Scoring["IMPROVEMENT_FARM"] = -1; end
if not m_Improvement_Scoring["IMPROVEMENT_BEACH_RESORT"] then m_Improvement_Scoring["IMPROVEMENT_BEACH_RESORT"] = -1; end
if not m_Improvement_Scoring["IMPROVEMENT_COLOSSAL_HEAD"] then m_Improvement_Scoring["IMPROVEMENT_COLOSSAL_HEAD"] = -1; end

if not m_Priorities then m_Priorities = {}; end
if not m_Priorities["REPAIR"] then m_Priorities["REPAIR"] = BAD_SCORE; end
if not m_Priorities["REPAIR_ROAD"] then m_Priorities["REPAIR_ROAD"]= BAD_SCORE; end
if not m_Priorities["IMPROVE_STRATEGIC"] then m_Priorities["IMPROVE_STRATEGIC"] = BAD_SCORE; end
if not m_Priorities["IMPROVE_LUXURY"] then m_Priorities["IMPROVE_LUXURY"] = BAD_SCORE; end
if not m_Priorities["IMPROVE_BONUS"] then m_Priorities["IMPROVE_BONUS"] = BAD_SCORE; end
if not m_Priorities["BUILD_IMPROVEMENT"] then m_Priorities["BUILD_IMPROVEMENT"] = BAD_SCORE; end
if not m_Priorities["BUILD_UNIQUE_IMPROVEMENT"] then m_Priorities["BUILD_UNIQUE_IMPROVEMENT"] = BAD_SCORE; end
if not m_Priorities["HARVEST_RESOURCE"] then m_Priorities["HARVEST_RESOURCE"] = BAD_SCORE; end
if not m_Priorities["REMOVE_FEATURE"] then m_Priorities["REMOVE_FEATURE"] = BAD_SCORE; end

-- for key, aScore in pairs( m_Scoring ) do if aScore < 0 then m_Scoring[key] = math.abs( aScore ); end end-- Keep the scores for everything positive.
m_Scoring["BUILDER_DISTANCE"] = -1 * math.abs( m_Scoring["BUILDER_DISTANCE"] ); -- Keep the distance value negative.

local m_Player = Players[0]; -- Stores player data for local processing.
local m_PlayerTechs = m_Player:GetTechs();
local m_PlayerCulture = m_Player:GetCulture();

local m_Builder = {}; --  stores Builder object data for local processing.
local m_BuilderManager = {}; -- Functions for managing builder route efficiency.
local m_Plot = {}; -- stores TargetPlot object data for local processing.
local m_PlayerPlots = {}; -- Contains a list of plots owned by each human player.
local m_PlayerImprovements = {}; -- Contains a list of valid improvements for each human player.
local m_PlayerFeatureRemovals = {}; -- Contains a list of valid improvements for each human player.
local m_PlayerResourceHarvests = {}; -- Contains a list of harvestable resources for each human player.
local m_PlayerResources = {}; -- Contains a list of visible resources for each human player.
local m_BannedPlotActions = {}; -- Table of banned plot actions so Builders will not attempt them again.
m_BannedPlotActions.X = {};
m_BannedPlotActions.Y = {};
m_BannedPlotActions.Actions = {};
m_BannedPlotActions.ActionTypes = {};

-- Object tables.
local m_Builders = { members = {}; };
local m_Plots = { members = {}; };

local m_PlayerTotalImprovements = 0;

local m_AutoBuilder_GP = {}; -- Gameplay script for storing tables
local m_isAutoBuilder_GP_Loaded = false;

-- Check if the Fall 2017 patch is installed:
local b_Fall2017Patch_Installed = false;
if GameInfo.Units["UNIT_GURU"] then 
	b_Fall2017Patch_Installed = true; 
	print( "The Fall 2017 Patch is installed for this game." );
else
	print( "The Fall 2017 Patch is NOT installed for this game." );
end

if debug == true then -- Debug settings values.
	--[[
	for row in GameInfo.CNO_AutoBuilders_Settings() do 
		print( "Found Setting: " .. row.Setting .. " with boolean: " .. tostring(row.mBoolean) .. " and value: " .. tostring(row.mValue) );
	end
	for row in GameInfo.AutoBuilders_Settings_Value() do
		print( "Found Setting: " .. row.Setting .. " with value: " .. tostring(row.Value) );
	end
	--]]
end

-- Firaxis function:
--	Selects a unit but firsts deselect any current unit, thereby forcing
--	a cache refresh.
local function SelectUnit( kUnit:table )	
	UI.DeselectUnit(kUnit);
	UI.SelectUnit(kUnit);
end

--======================================================================================================
-- CONSTANTS
--======================================================================================================

local STATUSES = {};-- Used for UI unit status text.
STATUSES[ "IMPROVE_LUXURY" ] 			= { string=Locale.Lookup( "LOC_CNO_AUTOBUILDERS_STATUS_IMPROVE_LUXURY" ),				Resource = true,	Improvement = true,	Feature = false	};
STATUSES[ "IMPROVE_STRATEGIC" ] 		= { string=Locale.Lookup( "LOC_CNO_AUTOBUILDERS_STATUS_IMPROVE_STRATEGIC" ),			Resource = true,	Improvement = true,	Feature = false	};
STATUSES[ "IMPROVE_BONUS" ]		 		= { string=Locale.Lookup( "LOC_CNO_AUTOBUILDERS_STATUS_IMPROVE_BONUS" ),				Resource = true,	Improvement = true,	Feature = false	};
STATUSES[ "REMOVE_FEATURE" ] 			= { string=Locale.Lookup( "LOC_CNO_AUTOBUILDERS_STATUS_REMOVE_FEATURE" ),				Resource = false,	Improvement = true,	Feature = true	};
STATUSES[ "HARVEST_RESOURCE" ] 			= { string=Locale.Lookup( "LOC_CNO_AUTOBUILDERS_STATUS_HARVEST_RESOURCE" ),				Resource = true,	Improvement = false,Feature = false	};
STATUSES[ "REPAIR" ] 					= { string=Locale.Lookup( "LOC_CNO_AUTOBUILDERS_STATUS_REPAIR" ),						Resource = false,	Improvement = true,	Feature = false	};
STATUSES[ "REPAIR_ROAD" ] 				= { string=Locale.Lookup( "LOC_CNO_AUTOBUILDERS_STATUS_REPAIR_ROAD" ),					Resource = false,	Improvement = false,Feature = false	};
STATUSES[ "REPAIR_ROUTE" ] 				= { string=Locale.Lookup( "LOC_CNO_AUTOBUILDERS_STATUS_REPAIR_ROAD" ),					Resource = false,	Improvement = false,Feature = false	};
STATUSES[ "BUILD_IMPROVEMENT" ] 		= { string=Locale.Lookup( "LOC_CNO_AUTOBUILDERS_STATUS_BUILD_IMPROVEMENT" ),			Resource = false,	Improvement = true,	Feature = false	};
STATUSES[ "BUILD_UNIQUE_IMPROVEMENT" ] 	= { string=Locale.Lookup( "LOC_CNO_AUTOBUILDERS_STATUS_BUILD_UNIQUE_IMPROVEMENT" ),		Resource = false,	Improvement = true,	Feature = false	};

-- Returns a unit status string given an action type and optional resource/improvement object.
local function GetStatusString( actionType, resource, improvement, feature )
	local status_string = "";
	local foundStatus = false;
	local status = STATUSES[ actionType ];
	if status then
		status_string = status.string;
		if resource and status.Resource == true then
			status_string = status_string .. " " .. Locale.Lookup( resource.TEXT );
			if improvement and status.Improvement == true then
				status_string = status_string .. " " .. Locale.Lookup( "LOC_CNO_AUTOBUILDERS_STATUS_WITH" ) .. " " .. Locale.Lookup( improvement.TEXT );	
			end
		elseif status.Resource == false and status.Feature == true then
			if feature then
				status_string = status_string .. " " .. Locale.Lookup( feature.TEXT );
				if improvement and status.Improvement == true then
					status_string = status_string .. " " .. Locale.Lookup( "LOC_CNO_AUTOBUILDERS_STATUS_FOR" ) .. " " .. Locale.Lookup( improvement.TEXT );
				end
			end
		elseif status.Resource == false and status.Feature == false then
			if improvement and status.Improvement == true then
				status_string = status_string .. " " .. Locale.Lookup( improvement.TEXT );
			end
		end
	else
		status_string = Locale.Lookup( "LOC_CNO_AUTOBUILDERS_STATUS_SLEEP" );
	end
	return status_string;
end

local RESOURCES = {};
local IMPROVEMENTS = {};
local FEATURES = {};
local TERRAINS = {};
local RESOURCE_HARVESTS = {};
local UNIT_COMMANDS = {};
local UNIT_OPS = {};
local map_width, map_height = Map.GetGridSize();

--------------------------------------------------------------------------------------------------------
local function GetCivFromTrait( trait )
	local civs = {};
	for row in GameInfo.CivilizationTraits() do 
		if row.TraitType == trait then table.insert( civs, row.CivilizationType ); end
	end
	if civs[1] then return civs; else return nil; end
end

--------------------------------------------------------------------------------------------------------
local function GetLeaderFromTrait( trait )
	local leaders = {};
	for row in GameInfo.LeaderTraits() do 
		if row.TraitType == trait then table.insert( leaders, row.LeaderType ); end
	end
	if leaders[1] then return leaders; else return nil; end
end

--------------------------------------------------------------------------------------------------------
local function GetGameResources()
	if debug_GameInfo then print( "Populating RESOURCES table from GameInfo: " ); end
	for row in GameInfo.Resources() do 
		local o = {};
		-- Associate Builder priority actions with the different resources.
		if row.ResourceClassType == "RESOURCECLASS_STRATEGIC" then o.TYPE = "IMPROVE_STRATEGIC";
		elseif row.ResourceClassType == "RESOURCECLASS_LUXURY" then o.TYPE = "IMPROVE_LUXURY";
		elseif row.ResourceClassType == "RESOURCECLASS_BONUS" then o.TYPE = "IMPROVE_BONUS";
		elseif row.ResourceClassType == "RESOURCECLASS_ARTIFACT" then o.TYPE = "ARTIFACT";
		else o.TYPE = "NON_CONVENTIONAL_RESOURCE"; end
		
		o.NAME = row.ResourceType;
		o.TEXT = row.Name;
		o.HASH = row.Hash;
		if row.PrereqTech then o.TECH = row.PrereqTech; end
		if row.PrereqCivic then o.CIVIC = row.PrereqCivic; end
		
		if debug_GameInfo then 
			print( "Added resource: " );
			for key, data in pairs( o ) do print( tostring( key ) .. ": " .. tostring( data ) ); end
			print();
		end
		RESOURCES[o.NAME] = o;
	end
end

--------------------------------------------------------------------------------------------------------
local function GetGameImprovements()
	if debug_GameInfo then print( "Populating IMPROVEMENTS table from GameInfo: " ); end
	for row in GameInfo.Improvements() do 
		-- Only add buildable improvements
		if row.Buildable or row.EnforceTerrain then 
			for buildUnitRow in GameInfo.Improvement_ValidBuildUnits() do -- Check Valid Build Units.
				-- For now, this AI is only for builders, so only include improvements that can be built by them.
				if row.ImprovementType == buildUnitRow.ImprovementType and buildUnitRow.UnitType == "UNIT_BUILDER" then
					local o = {};
					o.TYPE = "BUILD_IMPROVEMENT"; -- Type of Builder action for this data type.
					o.NAME = row.ImprovementType;
					o.TEXT = row.Name;
					o.HASH = row.Hash;
					if row.PrereqTech then o.TECH = row.PrereqTech; end
					if row.PrereqCivic then o.CIVIC = row.PrereqCivic; end
					if row.BuildOnFrontier then o.FRONTIER = row.BuildOnFrontier; end -- Great Wall frontier only.
					if row.RequiresRiver == 1 or row.RequiresRiver == true then o.RIVER = true; end -- Must be on a river.
					if row.SameAdjacentValid == 0 or row.SameAdjacentValid == false then o.ADJACENT = false; end -- Cannot have same adjacent improvement.
					if row.Coast == 1 or row.Coast == true then o.COAST = true; end -- Must be built on coast
					if row.MinimumAppeal then o.APPEAL = row.MinimumAppeal; end -- Minimum tile appeal to build.
					if row.Domain then o.DOMAIN = row.Domain; else o.DOMAIN = "DOMAIN_LAND"; end -- Domain of plots this improvement can be used for.
					 -- Enforce terrain is used for the oil well and offshore platform.
					if row.EnforceTerrain == 1 or row.EnforceTerrain == true then o.ENFORCE_TERRAIN = true; end
					if row.OnePerCity == 1 or row.OnePerCity == true then o.ONE_PER_CITY = true; end
					if row.RequiresAdjacentBonusOrLuxury == 1 or row.RequiresAdjacentBonusOrLuxury == true then o.REQUIRES_BONUS_LUXURY = true; end
					if row.ValidAdjacentTerrainAmount == 1 or row.ValidAdjacentTerrainAmount == true then o.ADJACENT_VALID_TERRAIN = true; end
					if row.AdjacentSeaResource == 1 or row.AdjacentSeaResource == true then o.REQUIRES_SEA_RESOURCE = true; end
					if row.TraitType then 
						if row.TraitType == "TRAIT_CIVILIZATION_NO_PLAYER" then
							o.CIV = "TRAIT_CIVILIZATION_NO_PLAYER";
							o.TYPE = "BUILD_UNIQUE_IMPROVEMENT";
						else
							if GetCivFromTrait( row.TraitType ) then 
								o.CIV = GetCivFromTrait( row.TraitType );
								o.TYPE = "BUILD_UNIQUE_IMPROVEMENT";
							elseif GetLeaderFromTrait( row.TraitType ) then 
								o.LEADER = GetLeaderFromTrait( row.TraitType );
								o.TYPE = "BUILD_UNIQUE_IMPROVEMENT";
							end
						end
					end
					if debug_GameInfo then 
						print( "Added improvement: " );
						for key, data in pairs( o ) do print( tostring( key ) .. ": " .. tostring( data ) ); end
						print();
					end
					IMPROVEMENTS[o.NAME] = o;
				end
			end
		end
	end
end

--------------------------------------------------------------------------------------------------------
local function GetGameFeatures()
	for row in GameInfo.Features() do 
		if not row.NaturalWonder == true then -- Don't add natural wonders to this particular list.
			local o = {};
			o.TYPE = "REMOVE_FEATURE"; -- Type of Builder action for this data type.
			o.NAME = row.FeatureType;
			o.TEXT = row.Name;
			o.REMOVABLE = false;
			-- o.HASH = row.Hash;
			if row.Removable then
				--o.TYPE = "REMOVE_FEATURE";
				if row.Removable == 1 or row.Removable == true then o.REMOVABLE = true; end
				if row.RemoveTech then
					o.TECH = row.RemoveTech;
				end
			end
			if debug_GameInfo then 
				print( "Added feature: " );
				for key, data in pairs( o ) do print( tostring( key ) .. ": " .. tostring( data ) ); end
				print();
			end
			FEATURES[o.NAME] = o;
		end
	end
end

--------------------------------------------------------------------------------------------------------
local function GetGameHarvests()
	for row in GameInfo.Resource_Harvests() do 
		local o = {};
		o.NAME = row.ResourceType;
		o.TYPE = "HARVEST_RESOURCE"; -- Type of Builder action for this data type.
		-- o.HASH = row.Hash;
		if row.PrereqTech then
			o.TECH = row.PrereqTech;
		end
		if debug_GameInfo then 
			print( "Added resource harvest info: " );
			for key, data in pairs( o ) do print( tostring( key ) .. ": " .. tostring( data ) ); end
			print();
		end
		RESOURCE_HARVESTS[o.NAME] = o;
	end
end

--------------------------------------------------------------------------------------------------------
local function GetGameTerrains()
	for row in GameInfo.Terrains() do 
		local o = {};
		o.NAME = row.TerrainType;
		o.TEXT = row.Name;
		-- o.HASH = row.Hash;
		if debug_GameInfo then 
			print( "Added terrain: " );
			for key, data in pairs( o ) do print( tostring( key ) .. ": " .. tostring( data ) ); end
			print();
		end
		TERRAINS[o.NAME] = o;
	end
end

--------------------------------------------------------------------------------------------------------
local function GetGameUnitCommands()
	for row in GameInfo.UnitCommands() do 
		local o = {};
		o.NAME = row.CommandType;
		o.HASH = row.Hash;
		if debug_GameInfo then 
			print( "Added unit command: " );
			for key, data in pairs( o ) do print( tostring( key ) .. ": " .. tostring( data ) ); end
			print();
		end
		UNIT_COMMANDS[o.NAME] = o;
	end
end

--------------------------------------------------------------------------------------------------------
local function GetGameUnitOps()
	for row in GameInfo.UnitOperations() do 
		local o = {};
		o.NAME = row.OperationType;
		o.HASH = row.Hash;
		if debug_GameInfo then 
			print( "Added unit operation: " );
			for key, data in pairs( o ) do print( tostring( key ) .. ": " .. tostring( data ) ); end
			print();
		end
		UNIT_OPS[o.NAME] = o;
	end
end

-- Load some game data whenever the UI is refreshed, including that from all mods enabled.
GetGameResources();
GetGameImprovements();
GetGameFeatures();
GetGameTerrains();
GetGameHarvests();
GetGameUnitCommands();
GetGameUnitOps();

--======================================================================================================
-- STATIC OBJECTS
--======================================================================================================

function m_Builders:count() -- Number of builders currently automated.
	local totalAutomated = 0;
	for key, keyData in ipairs( self.members ) do
		if keyData.isAutomated then totalAutomated = totalAutomated + 1; end
	end
	return totalAutomated;
end
function m_Builders:add( o ) -- Adds a new object to the table.
	if not o then Error( "Nil data passed to mBuilders' add function! No data was added." ); end
	table.insert( self.members, o );
end
function m_Builders:get( unit, iUnit ) -- Returns a Builder object from the table.
	if not unit then Error( "Nil data passed to mBuilders' get function!" ); return nil; end
	for _, aBuilder in ipairs( self.members ) do 
		if iUnit ~= nil then
			if ( aBuilder.owner == unit ) and ( aBuilder.ID == iUnit ) then
				return aBuilder;
			end
		elseif ( type( unit ) == "table" ) then -- Check if a table was given.
			if ( unit.GetID ~= nil and aBuilder.ID == unit:GetID() and unit.GetOwner ~= nil and aBuilder:getOwner() == unit:GetOwner() ) 
				or ( aBuilder.ID == unit.ID and aBuilder:getOwner() == unit:getOwner() ) then 
				return aBuilder;
			end
		end
	end return nil;
end
function m_Builders:save( o ) -- Overwrites updated Builder object data into the table.
	if not o then Error( "Nil data passed to mBuilders' save function! No data was saved." ); return; end
	for key, aBuilder in ipairs( self.members ) do 
		if ( aBuilder.ID == o.ID and ( ( aBuilder:getOwner() == o:getOwner() ) or ( aBuilder.owner == o.owner ) ) ) then self.members[key] = o; end
	end
end

function m_Plots:count() -- Number of plots currently targeted.
	local totalTargeted = 0;
	for key, keyData in ipairs( self.members ) do
		if keyData.isTargeted then totalTargeted = totalTargeted + 1; end
	end
	return totalTargeted;
end
function m_Plots:add( o ) -- Adds a new object to the table.
	if not o then Error( "Nil data passed to m_Plots' add function! No data was added." );
	else table.insert( self.members, o ); end
end
function m_Plots:get( iPlot ) -- Returns a TargetPlot object from the table.
	if not iPlot then Error( "Nil data passed to m_Plots' get function!" ); return nil; end
	for _, aPlot in ipairs( self.members ) do 
		if aPlot.ID == iPlot then -- Check if a iPlot ID number was given.
			return aPlot;
		elseif ( type( iPlot ) == "table" ) then -- Check if a table was given.
			if ( iPlot.GetIndex ~= nil and aPlot.ID == iPlot:GetIndex() ) or aPlot.ID == iPlot.ID then 
				return aPlot;
			end
		end
	end return nil;
end
function m_Plots:save( o ) -- Overwrites updated TargetPlot object data into the table.
	if not o then Error( "Nil data passed to m_Plots' save function! No data was saved." ); return; end
	for key, aPlot in ipairs( self.members ) do if aPlot.ID == o.ID then self.members[key] = o; end end
end

-- Functions to release data from table.
--------------------------------------------------------------------------------------------------------
-- Release a plot from being targeted by an automated Builder.
local function ReleasePlot( iPlot )
	m_Plot = m_Plots:get( iPlot );
	if m_Plot then 
		m_Plot:setTargeted( false ); -- Set plot to untargeted.
		m_Plots:save( m_Plot ); -- Save the data back to the list.
		-- Debug( "Released Plot ( x=" .. m_Plot.plot_data:GetX() .. " ; y=" .. m_Plot.plot_data:GetY() .. " ) from being targeted." );
	else end
end

--------------------------------------------------------------------------------------------------------
-- Releases all plots from being targeted.
local function ReleaseAll()
	for _, aTarget in pairs( m_Plots.members ) do
		aTarget:setTargeted( false );
		m_Plots:save( aTarget );
	end
end

--------------------------------------------------------------------------------------------------------
-- -- Sets a builder in the game to not automated.
local function StopAutomateBuilder( unit )
	m_Builder = m_Builders:get( unit );
	if m_Builder then 
		if m_Builder.isAutomated then
			m_Builder:setAutomated( false ); -- Set builder to not automated.
			m_Builder.ID = unit:GetID(); -- Refresh unit ID
			m_Builder.unit_data = unit; -- Refresh unit data.
			m_Builder:resetAction();
			m_Builder:resetPreviousAction();
			m_Builder:cancel(); -- Cancel anything the Builder is doing.
			m_Builders:save( m_Builder ); -- Save the data back to the list.
			Debug( "Stopped Automation for Builder (" .. m_Builder.ID .. ")." );
		else Error( "Attempt to stop Builder automation for a Builder that is already not automated." ); end
	else Error( "Nil data for m_Plot entry when entering function StopAutomateBuilder." ); end
end


--======================================================================================================
-- OBJECT CLASSES AND METHODS
--======================================================================================================

---[[
-- TargetPlot Object Class
local TargetPlotClass = { 
	ID = nil; -- The plot's ID for this game.
	isTargeted = true; -- Is this plot currently targeted by a Builder?
	x = 0;
	y = 0;
	plot_data = {};
};
 -- Sets this TargetPlot object's targeted value.
function TargetPlotClass:setTargeted( targeted:boolean ) self.isTargeted = targeted; end
-- Object Constructor
function TargetPlotClass:new ( o )
	o = o or {};
	setmetatable( o, self );
	self.__index = self;
	return o;
end
function TargetPlotClass:GetIndex()
	if self then
		if self.plot_data then 
			return self.plot_data:GetIndex();
		else return nil; end 
	else return nil; end
end
function TargetPlotClass:GetID()
	return self:GetIndex();
end
function TargetPlotClass:GetX()
	if self then
		if self.plot_data then 
			return self.plot_data:GetX();
		else return nil; end 
	else return nil; end
end
function TargetPlotClass:GetY()
	if self then
		if self.plot_data then 
			return self.plot_data:GetY(); 
		else return nil; end 
	else return nil; end
end

--------------------------------------------------------------------------------------------------------
-- Sets a plot as being targeted by an automated Builder.
local function TargetPlot( iPlot )
	m_Plot = m_Plots:get( iPlot );  -- Get any existing object data for this plot.
	if not m_Plot then -- Make a new TargetPlot object and add it to the list.
		m_Plots:add( 
			TargetPlotClass:new{
				ID = iPlot:GetIndex();
				x = iPlot:GetX();
				y = iPlot:GetY();
				plot_data = Map.GetPlotByIndex( iPlot:GetIndex() );
			}
		 );
		--Debug( "Added a new TargetPlot ( x=" .. iPlot:GetX() .. " ; y=" .. iPlot:GetY() .. " ) object to the list." );
	else 
		m_Plot:setTargeted( true ); -- If it already exists, then set it to Targeted.
		m_Plot.plot_data = Map.GetPlotByIndex( iPlot:GetIndex() );
		m_Plots:save( m_Plot ); -- Save the data back to the list.
		--Debug( "Set an existing TargetPlot ( x=" .. m_Plot.plot_data:GetX() .. " ; y=" .. m_Plot.plot_data:GetY() .. " ) as targeted." );
	end
end

--]]

--------------------------------------------------------------------------------------------------------
-- Returns true if plotA is adjacent to plotB and improvementA and improvementB are the same.
local function WasPreviousActionSuccessful( action, plot, improvement )
	if action then
		if plot and plot.GetX then
			local plot_improvement = plot:GetImprovementType();
			local plot_resource = plot:GetResourceType();
			local plot_feature = plot:GetFeatureType();
			if action == "SLEEP" or action == "none" then
				return true;
			elseif action == "BUILD_IMPROVEMENT" and improvement then 
				if plot_improvement < 0 then return false; end
				if GameInfo.Improvements[plot_improvement].ImprovementType == improvement.NAME then return true; end
			elseif action == "BUILD_UNIQUE_IMPROVEMENT" and improvement then 
				if plot_improvement < 0 then return false; end
				if GameInfo.Improvements[plot_improvement].ImprovementType == improvement.NAME then return true; end
			elseif action == "IMPROVE_STRATEGIC" and improvement then 
				if plot_improvement < 0 then return false; end
				if GameInfo.Improvements[plot_improvement].ImprovementType == improvement.NAME then return true; end
			elseif action == "IMPROVE_LUXURY" and improvement then  
				if plot_improvement < 0 then return false; end
				if GameInfo.Improvements[plot_improvement].ImprovementType == improvement.NAME then return true; end
			elseif action == "IMPROVE_BONUS" and improvement then  
				if plot_improvement < 0 then return false; end
				if GameInfo.Improvements[plot_improvement].ImprovementType == improvement.NAME then return true; end
			elseif action == "HARVEST_RESOURCE" then  
				if plot_resource < 0 then return true; end
			elseif action == "REMOVE_FEATURE" then  
				if plot_feature < 0 then return true; end
			elseif action == "REMOVE_IMPROVEMENT" then  
				if plot_improvement < 0 then return true; end
			elseif action == "REPAIR" then  
				if plot:IsImprovementPillaged() == false then return true; end
			elseif action == "REPAIR_ROUTE" then  
				if plot:IsRoutePillaged() == false then return true; end
			elseif action == "REPAIR_ROAD" then  
				if plot:IsRoutePillaged() == false then return true; end
			end
			return false;
		else
			return true;
		end
	else
		return true;
	end
end

--------------------------------------------------------------------------------------------------------
-- Returns true if the given action was successfully performed by the builder.
local function IsSameAction( actionA, actionB, plotA, plotB )
	if actionA and actionB then
		if actionA == actionB then -- same action
			if plotA and plotB and plotA.GetIndex and plotB.GetIndex then
				if plotA:GetIndex() == plotB:GetIndex() then -- same plot.
					return true;
				end
			end
		end
	end
	return false;
end

--------------------------------------------------------------------------------------------------------
-- Returns true if the given action was successfully performed by the builder.
local function IsPlotAdjacentToSameImprovement( plotA, plotB, improvementA, improvementB )
	if improvementA and improvementB then
		if improvementA.NAME and improvementB.NAME then
			if improvementA.Name == improvementB.NAME then -- same improvement
				if plotA and plotB and plotA.GetX and plotB.GetX then
					local x_dif = math.abs( plotA:GetX() - plotB:GetX() );
					local y_dif = math.abs( plotA:GetY() - plotB:GetY() );
					if ( x_dif <= 1 ) and ( y_dif <= 1 ) then -- plotA is adjacent to plotB
						return true;
					end
				end
			end
		end
	end
	return false;
end


-- Builder Object Class
local BuilderClass = {
	ID = 0; -- The builder's unit ID for this game.
	owner = -1;
	unit_data = nil; -- Unit data for this Builder.
	isAutomated = true; -- If this builder is currently automated.
	targetPlot = nil; -- The plot this builder is currently targeting.
	previousPlot = nil;
	distanceToTarget = 0; -- The distance in tiles to the Builder's current target.
	queuedAction = "none"; -- The type of action that the Builder is trying to perform.
	previousAction = "SLEEP"; -- Stores action the Builder last attempted to perform.
	improvement = nil; -- The improvement this Builder is attempting to build.
	resource = nil; -- The resource this Builder is trying to improve.
	feature = nil; -- The feature the Builder is trying to remove.
	previousImprovement = nil;
	previousResource = nil;
	previousFeature = nil;
	has_error = false; -- Error flag
};
function BuilderClass:x() 
	if self and self.unit_data then 
		local unit = UnitManager.GetUnit( self:getOwner(), self.unit_data:GetID() );
		if unit then return unit:GetX(); else return 0; end
	else return 0; end 
end
function BuilderClass:y() 
	if self and self.unit_data then 
		local unit = UnitManager.GetUnit( self:getOwner(), self.unit_data:GetID() );
		if unit then return unit:GetY(); else return 0; end
	else return 0; end 
end
 -- Sets this Builder object's automation.
function BuilderClass:setAutomated( automated:boolean ) if self then self.isAutomated = automated; end end
 -- Sets this Builder object's target plot.
function BuilderClass:setTargetPlot( target ) if self then self.targetPlot = target; end end
-- Resets Builder action
function BuilderClass:resetAction()
	if self.targetPlot then ReleasePlot( self.targetPlot ); end
	self.targetPlot = nil; -- The plot this builder is currently targeting.
	self.distanceToTarget = 0; -- The distance in tiles to the Builder's current target.
	self.queuedAction = "none"; -- The type of action that the Builder is trying to perform.
	self.improvement = nil; -- The improvement this Builder is attempting to build.
	self.resource = nil; -- The resource this Builder is trying to improve.
	self.feature = nil; -- The feature the Builder is trying to remove.
	self.has_error = false; -- Error flag
end
-- Copys and overwrites action data in from another object
function BuilderClass:getActionObject()
	return {
		targetPlot = self.targetPlot,
		action_type = self.queuedAction,
		distanceToTarget = self.distanceToTarget or 0,
		improvement = self.improvement,
		resource = self.resource,
		feature = self.feature
	};
end
-- Copys and overwrites action data in from another object
function BuilderClass:setAction( action )
	if not action.targetPlot then 
		Error( "BuilderClass:setAction(): Attempt to set Builder action with no target plot." );
		return;
	end
	self:resetAction();
	self.targetPlot = action.targetPlot;
	self.queuedAction = action.queuedAction or "none";
	self.distanceToTarget = action.distanceToTarget or 0;
	self.improvement = action.improvement;
end
-- Resets Builder action
function BuilderClass:resetPreviousAction()
	self.previousAction = "SLEEP"; -- Stores action the Builder last attempted to perform.
	self.targetPlot = nil;
	self.improvement = nil;
	self.resource = nil;
	self.feature = nil;
end
-- Builder targets the plot it is on.
function BuilderClass:targetSelf()
	self:setTargetPlot( Map.GetPlot( self:x(), self:y() ) );
end
function BuilderClass:getOwner() 
	-- return UnitManager.GetUnit( self.unit_data:GetOwner(), self.unit_data:GetID() ):GetOwner(); 
	local unit = UnitManager.GetUnit( self.unit_data:GetOwner(), self.unit_data:GetID() );
	if unit then self.owner = unit:GetOwner(); return unit:GetOwner(); else return -1; end
end
-- Returns true if this builder has reached its target plot.
function BuilderClass:hasReachedTarget()
	local hasReachedTarget = false;
	if self and self.isAutomated then 
		if self.targetPlot then 
			if self.targetPlot:GetX() == self:x() and self.targetPlot:GetY() == self:y() then hasReachedTarget = true; end
		else Error( "Nil target plot data when using Builder's HasReachedTargetPlot." ); end
	else Error( "Invalid object data when using Builder's HasReachedTargetPlot." ); end
	return hasReachedTarget;
end

 -- Asks this builder to remove a feature
function BuilderClass:removeFeature()
	if not self then Error( "Nil object data when using Builder's RemoveFeature." ); return; end
	Debug( Locale.Lookup( PlayerConfigurations[self:getOwner()]:GetLeaderTypeName() ) .. " commanded Builder (" .. self.ID ..") to remove feature at" .. 
	 " x=" .. self:x() .. " ; y=" .. self:y() );
	UnitManager.RequestOperation( UnitManager.GetUnit( self:getOwner(), self.ID ), UNIT_OPS["UNITOPERATION_REMOVE_FEATURE"].HASH );
end

 -- Commands this builder to remove an Improvement
function BuilderClass:removeImprovement()
	if not self then Error( "Nil object data when using Builder's RemoveImprovement." ); return; end
	UnitManager.RequestOperation( UnitManager.GetUnit( unit:GetOwner(), unit:GetID() ), UNIT_OPS["UNITOPERATION_REMOVE_IMPROVEMENT"].HASH );
	Debug( Locale.Lookup( PlayerConfigurations[self:getOwner()]:GetLeaderTypeName() ) .. " commanded Builder (" .. self.ID ..") to remove improvement at" .. 
	 " x=" .. self:x() .. " ; y=" .. self:y() );
end

 -- Asks this builder to harvest a resource
function BuilderClass:harvestResource()
	if not self then Error( "Nil object data when using Builder's HarvestResource." ); return; end
	Debug( Locale.Lookup( PlayerConfigurations[self:getOwner()]:GetLeaderTypeName() ) .. " commanded Builder (" .. self.ID ..") to harvest resource at" .. 
	 " x=" .. self:x() .. " ; y=" .. self:y() );
	UnitManager.RequestOperation( UnitManager.GetUnit( self:getOwner(), self.ID ), UNIT_OPS["UNITOPERATION_HARVEST_RESOURCE"].HASH );
end

 -- Asks this builder to build an improvement
function BuilderClass:buildImprovement()
	if not self then Error( "Nil object data when using Builder's BuildImprovement." ); return; end
	local plot = Map.GetPlot( self:x(), self:y() );
	local plot_improvement = plot:GetImprovementType();
	local plot_feature = plot:GetFeatureType();

	if plot_improvement == -1 then
		if plot_feature == -1 then -- No improvement and no feature, good to go ahead and build the improvement.
			local tParameters = {};
			tParameters[UnitOperationTypes.PARAM_X] = self:x();
			tParameters[UnitOperationTypes.PARAM_Y] = self:y();
			tParameters[UnitOperationTypes.PARAM_IMPROVEMENT_TYPE] = self.improvement.HASH;
			UnitManager.RequestOperation( UnitManager.GetUnit( self:getOwner(), self.ID ), UNIT_OPS["UNITOPERATION_BUILD_IMPROVEMENT"].HASH, tParameters );
			Debug( Locale.Lookup( PlayerConfigurations[self:getOwner()]:GetLeaderTypeName() ) .. " commanded Builder (" .. self.ID ..") to build improvement: " .. 
				self.improvement.NAME .. " on Plot: x = " .. self:x() .. " , y = " .. self:y() );
		elseif self and self.resource and self.resource.REMOVES_FEATURE then -- Before we can build this improvement, feature must be removed.
			self:removeFeature(); -- Try to remove the feature.
		else
			if self.feature ~= nil then
				--self:removeFeature();
				Error( "Builder (" .. self.ID .. ") attempted to build an improvement but had a non nil feature object. No action taken" );
			else
				local tParameters = {};
				tParameters[UnitOperationTypes.PARAM_X] = self:x();
				tParameters[UnitOperationTypes.PARAM_Y] = self:y();
				tParameters[UnitOperationTypes.PARAM_IMPROVEMENT_TYPE] = self.improvement.HASH;
				UnitManager.RequestOperation( UnitManager.GetUnit( self:getOwner(), self.ID ), UNIT_OPS["UNITOPERATION_BUILD_IMPROVEMENT"].HASH, tParameters );
				Debug( Locale.Lookup( PlayerConfigurations[self:getOwner()]:GetLeaderTypeName() ) .. " commanded Builder (" .. self.ID ..") to build improvement: " .. 
					self.improvement.NAME .. " on Plot: x = " .. self:x() .. " , y = " .. self:y() );
			end
		end
	else  -- Plot has an improvement, remove it to build another.
		if GameInfo.Improvements[self.improvement.NAME].Index ~= plot_improvement then
			self:removeImprovement(); -- Remove the improvement if we are trying to build a different improvement.
		end
	end
end

 -- Commands this builder to repair an Improvement
function BuilderClass:repairImprovement()
	if not self then Error( "Nil object data when using Builder's RepairImprovement." ); return; end
	UnitManager.RequestOperation( UnitManager.GetUnit( self:getOwner(), self.ID ), UNIT_OPS["UNITOPERATION_REPAIR"].HASH );
	Debug( Locale.Lookup( PlayerConfigurations[self:getOwner()]:GetLeaderTypeName() ) .. " commanded Builder (" .. self.ID ..") to repair improvement at" .. 
	 " x=" .. self:x() .. " ; y=" .. self:y() );
end

 -- Commands this builder to repair a route
function BuilderClass:repairRoute()
	if not self then Error( "Nil object data when using Builder's RepairRoute." ); return; end
	UnitManager.RequestOperation( UnitManager.GetUnit( self:getOwner(), self.ID ), UNIT_OPS["UNITOPERATION_REPAIR_ROUTE"].HASH );
	Debug( Locale.Lookup( PlayerConfigurations[self:getOwner()]:GetLeaderTypeName() ) .. " commanded Builder (" .. self.ID ..") to repair route at" .. 
	 " x=" .. self:x() .. " ; y=" .. self:y() );
end

 -- Commands this builder to plant a forest
function BuilderClass:plantForest()
	if not self then Error( "Nil object data when using Builder's PlantForest." ); return; end
	UnitManager.RequestOperation( UnitManager.GetUnit( self:getOwner(), self.ID ), UNIT_OPS["UNITOPERATION_PLANT_FOREST"].HASH );
	Debug( Locale.Lookup( PlayerConfigurations[self:getOwner()]:GetLeaderTypeName() ) .. " commanded Builder (" .. self.ID ..") to plant forest at" .. 
	 " x=" .. self:x() .. " ; y=" .. self:y() );
end

 -- Commands this builder to clear nuclear contamination
function BuilderClass:clearContamination()
	if not self then Error( "Nil object data when using Builder's ClearContamination." ); return; end
	UnitManager.RequestOperation( UnitManager.GetUnit( self:getOwner(), self.ID ), UNIT_OPS["UNITOPERATION_CLEAR_CONTAMINATION"].HASH );
	Debug( Locale.Lookup( PlayerConfigurations[self:getOwner()]:GetLeaderTypeName() ) .. " commanded Builder (" .. self.ID ..") to clear contamination at" .. 
	 " x=" .. self:x() .. " ; y=" .. self:y() );
end

-- Commands the builder to cancel whatever it is doing.
function BuilderClass:cancel()
	if not self then Error( "Nil object data when using Builder's Cancel." ); return; end
	local unit = UnitManager.GetUnit( self:getOwner(), self.ID );
	UnitManager.RequestCommand( unit, UNIT_COMMANDS["UNITCOMMAND_CANCEL"].HASH );
	UnitManager.RequestCommand( unit, UNIT_COMMANDS["UNITCOMMAND_WAKE"].HASH ); -- Wake the unit.
end

-- Commands the builder to sleep.
function BuilderClass:sleep()
	if not self then Error( "Nil object data when using Builder's Sleep." ); return; end
	local unit = UnitManager.GetUnit( self:getOwner(), self.ID );
	UnitManager.RequestOperation( unit, UNIT_OPS["UNITOPERATION_SLEEP"].HASH );
	Debug( Locale.Lookup( PlayerConfigurations[self:getOwner()]:GetLeaderTypeName() ) .. " commanded Builder (" .. self.ID ..") to sleep at" .. 
	 " x=" .. self:x() .. " ; y=" .. self:y() );
end

-- Returns true if this Builder unit has more than 0 moves remaining.
function BuilderClass:hasMovementLeft()
	if not self then Error( "Nil object data when using Builder's HasMovementLeft" ); return; end
	local unit = UnitManager.GetUnit( self:getOwner(), self.ID );
	if unit and unit:GetMovesRemaining() > 0 then return true; else return false; end
end

 -- Commands this builder to move to a plot coordinate.
function BuilderClass:moveTo( new_x, new_y )
	if not self then Error( "Nil object data when using Builder's MoveTo." ); return; end
	if not ( new_x or new_y ) then Error( "Nil x and y coordinates passed to Builder's MoveTo." ); return; end
	---[[
	local tParameters = {};
	tParameters[UnitOperationTypes.PARAM_X] = new_x;
	tParameters[UnitOperationTypes.PARAM_Y] = new_y;
	local unit = UnitManager.GetUnit( self:getOwner(), self.ID );
	UnitManager.RequestOperation( unit, UNIT_OPS["UNITOPERATION_MOVE_TO"].HASH, tParameters );
	--]]
	-- MoveUnitToPlot( unit, move_x, move_y );
	--[[
	Debug( Locale.Lookup( PlayerConfigurations[self:getOwner()]:GetLeaderTypeName() ) .. " commanded Builder " .. 
	" (" .. self.ID .. ") to move from plot x=" .. self:x() .. 
		" , y = " .. self:y() .. " to new plot x=" .. new_x .. " ; y=" .. new_y );
	--]]
end

 -- Commands this builder to perform its queued action
function BuilderClass:performAction()
	if not self then Error( "Nil object data when using Builder's PerformAction." ); return; end
	-- Debug("Telling this unit to perform its queued action.");
	if self.queuedAction then -- Attempt to perform the Builder's queued action.
		UnitManager.RequestCommand( UnitManager.GetUnit( self:getOwner(), self.ID ), UNIT_COMMANDS["UNITCOMMAND_WAKE"].HASH ); -- Wake the unit.
		-- Debug("Told this unit to wake up.");
		local unit = UnitManager.GetUnit( self:getOwner(), self.ID );
		if unit then
			local buildsLeft = unit:GetBuildCharges();
			local actionTaken = true;
			-- Do a check if previous (different) action was succesful. Can't check right after action taken as a UI request is sent, code isn't run right away.
			-- This is necessary due to possible bugs in action switching after movement end.
			if IsSameAction( self.queuedAction, self.previousAction, self.targetPlot, self.previousPlot ) == false then
				if WasPreviousActionSuccessful( self.previousAction, self.previousPlot, self.previousImprovement ) == false then
					if self.has_error == false then -- Only switch back to previous action if it didn't create an error.
						Debug( "Previous action for Builder (" .. self.ID .. ") was unsuccessful. Assigning to previous action." );
						self.queuedAction = self.previousAction;
						self.targetPlot = self.previousPlot;
						self.improvement = self.previousImprovement;
						self.feature = nil;
						--self:realizeAction();
						return; -- Don't proceed farther into function.
					end
				end
			end
			self.has_error = false;
			if self.queuedAction == "BUILD_IMPROVEMENT" then self:buildImprovement(); buildsLeft = buildsLeft - 1;
			elseif self.queuedAction == "BUILD_UNIQUE_IMPROVEMENT" then self:buildImprovement(); buildsLeft = buildsLeft - 1;
			elseif self.queuedAction == "IMPROVE_STRATEGIC" then self:buildImprovement(); buildsLeft = buildsLeft - 1;
			elseif self.queuedAction == "IMPROVE_LUXURY" then self:buildImprovement(); buildsLeft = buildsLeft - 1;
			elseif self.queuedAction == "IMPROVE_BONUS" then self:buildImprovement(); buildsLeft = buildsLeft - 1;
			elseif self.queuedAction == "HARVEST_RESOURCE" then self:harvestResource(); buildsLeft = buildsLeft - 1;
			elseif self.queuedAction == "REMOVE_FEATURE" then 
				-- Special case: After removing feature, set next queued action to building improvement.
				self:removeFeature(); buildsLeft = buildsLeft - 1; 
				if buildsLeft > 0 then
					self.previousAction = self.queuedAction;
					self.previousPlot = self.targetPlot;
					self.previousImprovement = self.improvement;
					self.queuedAction = self.improvement.TYPE;
					self.feature = nil;
					--self:realizeAction();
					return; -- Don't proceed farther into function.
				end
			elseif self.queuedAction == "REMOVE_IMPROVEMENT" then self:removeImprovement();
			elseif self.queuedAction == "REPAIR" then self:repairImprovement();
			elseif self.queuedAction == "REPAIR_ROUTE" then self:repairRoute();
			elseif self.queuedAction == "REPAIR_ROAD" then self:repairRoute();
			elseif self.queuedAction == "PLANT_FOREST" then self:plantForest(); buildsLeft = buildsLeft - 1;
			elseif self.queuedAction == "CLEAR_CONTAMINATION" then self:clearContamination(); buildsLeft = buildsLeft - 1;
			else
				actionTaken = false;
				self:sleep(); -- Otherwise, put the builder to sleep for this turn.
			end
			if actionTaken then 
				self.previousAction = self.queuedAction;
				self.previousPlot = self.targetPlot;
				self.previousImprovement = self.improvement;
				if ( buildsLeft > 0 ) then
					self:getActionSwitch(); -- Builds remaining, get a new action for the builder.
					if self.targetPlot:GetIndex() ~= self.previousPlot:GetIndex() then 
						-- Check if the new action is an adjacent plot with the same improvement as just built.
						if IsPlotAdjacentToSameImprovement( self.targetPlot, self.previousPlot, self.improvement, self.previousImprovement ) == false then
							self:realizeAction(); -- Tell unit to move to next action (for UI visibility) if it is on a different plot.
						else
							if self.improvement and self.improvement.ADJACENT == false then -- Improvement cannot be adjacent to the same improvement.
								Debug( "Prevented an Automated Builder from making an invalid build selection (INVALID ADJACENT UNIQUE IMPROVEMENT)." );
								self:resetAction(); -- Reset builder action so it is re-determined next turn.
								self:sleep();
							else -- Same improvement but no adjacency restriction. Proceed.
								self:realizeAction();
							end
						end
					end 
				end
			else 
				self:resetPreviousAction();
				self:resetAction();
			end
		else
			self:resetAction();
			self:sleep();
		end
	else
		Error("Nil queued action data for this builder.");
		self:resetAction();
		self:sleep();
	end
end

 -- Gives this builder something to do based on its action.
function BuilderClass:realizeAction()
	if not self then Error( "Nil object data when using Builder's RealizeAction." ); return; end
	if not self.targetPlot then Error( "Nil target plot data when using Builder's RealizeAction." ); return; end
	if self:hasReachedTarget() and self:hasMovementLeft() then -- Do something if the builder has reached its target.
		self:performAction();
	else -- Otherwise move it towards its target.
		self:moveTo( self.targetPlot:GetX(), self.targetPlot:GetY() );
	end
end

-- Returns the unit's current status.
function BuilderClass:GetStatus()
	if not self then Error( "Nil object data when using Builder's GetStatus." ); return; end
	return GetStatusString( self.queuedAction, self.resource, self.improvement, self.feature );
end

-- Object Constructor
function BuilderClass:new ( o )
	o = o or {};
	setmetatable( o, self );
	self.__index = self;
	return o;
end


--======================================================================================================
-- FUNCTIONS
--======================================================================================================

--------------------------------------------------------------------------------------------------------
-- Sets a builder in the game to automated.
local function AutomateBuilder( unit )
	m_Builder = m_Builders:get( unit ); -- Get any existing object data for this builder.
	if not m_Builder then -- Make a new Builder object and add it to the list.
		m_Builder = 
			BuilderClass:new{ 
				ID = unit:GetID();
				owner = unit:GetOwner();
				unit_data = unit;
			};
		m_Builder:getAction(); -- Find something for the builder to do.
		m_Builder:realizeAction(); -- Have the builder do something right away.
		m_Builders:add( m_Builder ); -- Add Builder to the list.
		Debug( "Added a new Builder (" .. m_Builder.ID .. ") object to the list." );
	else
		m_Builder:setAutomated( true ); -- If it already exists, then set it to Automated.
		m_Builder.ID = unit:GetID(); -- Refresh unit ID
		m_Builder.unit_data = unit; -- Refresh unit data.
		m_Builder:getAction(); -- Find something for the builder to do.
		m_Builder:realizeAction(); -- Have the builder do something right away.
		m_Builders:save( m_Builder ); -- Save the data back to the list.
		Debug( "Set an existing Builder (" .. m_Builder.ID .. ") to automated." );
	end
end

--------------------------------------------------------------------------------------------------------
-- If the given value is above or below the max, rescale it between 0 and the max - 1 (unless non_zero_based parameter is true).
-- The scaling is done circularly, that is -1 --> max value - 1, that is the values wrap around.
-- If the non_zero_based parameter is set to true, then scaling will be done between 1 and max value.
local function rescale( value, max, non_zero_based )
	local new_value = value;
	if non_zero_based == nil or non_zero_based == false then -- scale between 0 and max - 1
		while (new_value < 0) do new_value = new_value + max; end
		while (new_value >= max) do new_value = new_value - max; end
	elseif non_zero_based == true then -- scale between 1 and max value
		while (new_value <= 0) do new_value = new_value + max; end
		while (new_value > max) do new_value = new_value - max; end
	else
		print( "ERROR in rescale function. Unrecognized value for parameter: 'non-zero-based'!" );
	end
	return new_value;
end

--------------------------------------------------------------------------------------------------------
-- Bans a specific action for a plot.
local function BanPlotAction( aPlot, anAction, anActionType )
	if aPlot and aPlot.GetX then
		if ( anAction ~= nil ) and ( anAction ~= "none" ) and ( anAction ~= "sleep" ) and ( anAction ~= "SLEEP" ) then
			table.insert( m_BannedPlotActions.X, aPlot:GetX() );
			table.insert( m_BannedPlotActions.Y, aPlot:GetY() );
			table.insert( m_BannedPlotActions.Actions, anAction );
			if anActionType then 
				table.insert( m_BannedPlotActions.ActionTypes, anActionType );
				Debug( "BANNED action: " .. anAction .. " for type: " .. anActionType .. 
					" on plot: x=" .. aPlot:GetX() .. "; y=" .. aPlot:GetY() .. " for automated Builders for this session." );
			else
				table.insert( m_BannedPlotActions.ActionTypes, "nothing" );
				Debug( "BANNED action: " .. anAction .. " on plot: x=" .. aPlot:GetX() .. "; y=" .. aPlot:GetY() .. 
					" for automated Builders for this session." );
			end
		else
			Error( "Attempted to ban nil/'none'/sleep action. No action was banned for automated Builders." );
		end
	else
		Error( "Attempted to ban action on nil plot. No action was banned for automated Builders." );
	end
end

--------------------------------------------------------------------------------------------------------
-- Returns true if the given action on the given plot is banned based on the black list.
local function IsPlotActionBanned( aPlot, anAction, anActionType )
	for key, action in ipairs( m_BannedPlotActions.Actions ) do
		if action == anAction then -- action match
			local x = m_BannedPlotActions.X;
			local y = m_BannedPlotActions.Y;
			if ( ( x[key] == aPlot:GetX() ) and ( y[key] == aPlot:GetY() ) ) then -- Plot x and y coords match
				if anActionType then -- Function call requested to check if there was only a specific improvement or sub action type banned.
					local actionTypes = m_BannedPlotActions.ActionTypes;
					if actionTypes[key] == anActionType then
						return true; -- The action and given improvement/action sub-type are banned for this plot.
					end
				else
					-- Nil specific action type data given to function. No need to check, the general action on this plot is banned.
					return true;
				end
			end
		end
	end
	return false;
end

--------------------------------------------------------------------------------------------------------
-- Returns true if an automated Builder is targeting this plot.
local function IsPlotTargeted( iPlot )
	m_Plot = m_Plots:get( iPlot );
	if m_Plot then 
		return m_Plot.isTargeted;
	else 
		return false;
	end
end

--------------------------------------------------------------------------------------------------------
-- Returns true if the given unit is an automated Builder
local function IsBuilderAutomated( pUnit )
	m_Builder = m_Builders:get( pUnit );
	if m_Builder then 
		return m_Builder.isAutomated;
	else 
		return false;
	end
end

--------------------------------------------------------------------------------------------------------
-- Returns string status of the given unit if it is an automated Builder.
local function GetBuilderStatus( pUnit )
	m_Builder = m_Builders:get( pUnit );
	if m_Builder and m_Builder.isAutomated then 
		return m_Builder:GetStatus();
	else 
		return "";
	end
end

--------------------------------------------------------------------------------------------------------
-- Refreshes a table of plots currently owned by the player and able to be worked.
local function RefreshPlayerValidPlots( iPlayer )
	m_Player = Players[iPlayer];
	if m_Player:IsHuman() then -- Only store the plots of human players.
		local map_width, map_height = Map.GetGridSize();
		local playerPlots = {};
		for x = 0, ( map_width - 1 ) do
			for y = 0, ( map_height - 1 ) do
				local thePlot = Map.GetPlot( x, y );
				if thePlot then -- Skip nil plot data.
					if thePlot:GetOwner() == m_Player:GetID() then 
						table.insert( playerPlots, thePlot );
					end
				end
			end
		end
		m_PlayerPlots[iPlayer] = playerPlots;
		--[[
		Debug( "Refreshed valid plots for playerID: " .. iPlayer .. 
			" ( " .. Locale.Lookup( PlayerConfigurations[iPlayer]:GetCivilizationTypeName() ) .. 
			" Led by " .. Locale.Lookup( PlayerConfigurations[iPlayer]:GetLeaderTypeName() ) .. " )" );
		--]]
	end
end

--------------------------------------------------------------------------------------------------------
-- Returns the ID of the city owning the given plot.
local function GetCityOwningPlot( plot )
	if plot then
		local owningCity = Cities.GetPlotPurchaseCity( plot );
		return owningCity:GetID();
	else return -1; end
end

--------------------------------------------------------------------------------------------------------
-- Returns a table of plots owned by the given city.
local function GetCityPlots( iPlayer, iCity )
	local city = CityManager.GetCity( iPlayer, iCity )
	local cityPlots = {};
	for key, aPlot in pairs( m_PlayerPlots[ iPlayer ] ) do
		local plotCity = GetCityOwningPlot( aPlot );
		if plotCity == city:GetID() then
			table.insert( cityPlots, aPlot );
		end
	end
	return cityPlots;
end

--------------------------------------------------------------------------------------------------------
-- Returns and sets m_PlayerTotalImprovements with number of improvements owned by the player of the given type and player city.
local function CountPlayerImprovementsInCity( iPlayer, ImprovementType, iCity )
	local cityPlots = GetCityPlots( iPlayer, iCity );
	local total = 0;
	local improvement = -1;
	for key, aPlot in pairs( cityPlots ) do
		improvement = aPlot:GetImprovementType();
		if improvement == ImprovementType then
			total = total + 1;
		elseif improvement == GameInfo.Improvements[ ImprovementType ].Index then
			total = total + 1;
		end
	end
	--m_PlayerTotalImprovements = total;
	return total;
end

--------------------------------------------------------------------------------------------------------
-- Returns and sets m_PlayerTotalImprovements with number of improvements owned by the player of the given type.
local function CountPlayerImprovements( iPlayer, ImprovementType )
	RefreshPlayerValidPlots( iPlayer );
	local total = 0;
	local improvement = -1;
	for key, aPlot in pairs( m_PlayerPlots[ iPlayer ] ) do
		improvement = aPlot:GetImprovementType();
		if improvement == ImprovementType then
			total = total + 1;
		elseif improvement == GameInfo.Improvements[ ImprovementType ].Index then
			total = total + 1;
		end
	end
	--m_PlayerTotalImprovements = total;
	return total;
end

--[[ debugging improvement counts
Debug( "Player's total number of farms: " .. CountPlayerImprovements( 0, GameInfo.Improvements[ "IMPROVEMENT_FARM" ].Index ) );
Debug( "Player's total number of mines: " .. CountPlayerImprovements( 0, GameInfo.Improvements[ "IMPROVEMENT_MINE" ].Index ) );
local m_playerCities_test = Players[0];
m_playerCities_test = m_playerCities_test:GetCities();
m_playerCities_test = m_playerCities_test:GetCapitalCity();
m_playerCities_test = m_playerCities_test:GetID();
Debug( "Player's capital city has total number of farms: " .. CountPlayerImprovementsInCity( 0, GameInfo.Improvements[ "IMPROVEMENT_FARM" ].Index, m_playerCities_test ) );
Debug( "Player's capital city has total number of mines: " .. CountPlayerImprovementsInCity( 0, GameInfo.Improvements[ "IMPROVEMENT_MINE" ].Index, m_playerCities_test ) );
--]]

--------------------------------------------------------------------------------------------------------
-- Returns true if a given resource is validly improved.
local function IsResourceValidlyImproved( resource, improvement )
	local improved = false;
	for row in GameInfo.Improvement_ValidResources() do -- Go through the Valid Resources for improvements in game info.
		-- Check if the resource tag matches input resource.
		if resource == GameInfo.Resources[row.ResourceType].Index then
			-- Check if the same row's improvement tag matches input improvement.
			if improvement == GameInfo.Improvements[row.ImprovementType].Index then
				improved = true;
			end
		end
	end
	return improved;
end

--------------------------------------------------------------------------------------------------------
-- Returns a game RESOURCE object if a given resource is visible to the player.
local function IsResourceVisibleForPlayer( resource, iPlayer )
	if iPlayer then m_Player = Players[iPlayer]; end
	if not m_Player then Error( "Nil player data passed to function IsResourceVisibleForPlayer." ); return false; end
	if not resource then Error( "Nil resource data passed to function IsResourceVisibleForPlayer." ); return false; end
	for _, aResource in pairs( m_PlayerResources[m_Player:GetID()] ) do -- go through resources visible to player.
		if resource == GameInfo.Resources[aResource.NAME].Index then return aResource; end
	end
	return false;
end

--------------------------------------------------------------------------------------------------------
-- Returns a game FEATURE object if a given feature is removable by the player.
local function IsFeatureRemovableForPlayer( feature, iPlayer )
	if iPlayer then m_Player = Players[iPlayer]; end
	if not m_Player then Error( "Nil player data passed to function IsFeatureRemovableForPlayer." ); return false; end
	if not feature then Error( "Nil feature data passed to function IsFeatureRemovableForPlayer." ); return false; end
	for _, aFeatureRemoval in pairs( m_PlayerFeatureRemovals[m_Player:GetID()] ) do -- go through features removable for player.
		if feature == GameInfo.Features[aFeatureRemoval.NAME].Index then return aFeatureRemoval; end
	end
	return false;
end

--------------------------------------------------------------------------------------------------------
-- Returns a game RESOURCE object if a given resource is harvestable by the player.
local function IsResourceHarvestableForPlayer( resource, iPlayer )
	if iPlayer then m_Player = Players[iPlayer]; end
	if not m_Player then Error( "Nil player data passed to function IsResourceHarvestableForPlayer." ); return false; end
	if not resource then Error( "Nil resource data passed to function IsResourceHarvestableForPlayer." ); return false; end
	for _, aResourceHarvest in pairs( m_PlayerResourceHarvests[m_Player:GetID()] ) do -- go through resources harvestable for player.
		if resource == GameInfo.Resources[aResourceHarvest.NAME].Index then return aResourceHarvest; end
	end
	return false;
end

--------------------------------------------------------------------------------------------------------
-- Get valid improvements for a plot given a terrain.
local function GetImprovementsForPlot_Terrain( Improvements, aPlot, iPlayer )
	--Debug_AllActions( "Entered function: GetImprovementsForPlot_Terrain" );
	if iPlayer then m_Player = Players[iPlayer]; end
	if not m_Player then Error( "Nil player data passed to function GetImprovementsForPlot_Terrain." ); return Improvements; end
	if not Improvements then Error( "Nil valid Improvement table passed to function GetImprovementsForPlot_Terrain." ); return Improvements; end
	if not aPlot then Error( "Nil plot data passed to function GetImprovementsForPlot_Terrain." ); return Improvements; end
	local terrain = aPlot:GetTerrainType();
	
	m_PlayerTechs = m_Player:GetTechs();
	m_PlayerCulture = m_Player:GetCulture();

	for _, anImprovement in pairs( m_PlayerImprovements[m_Player:GetID()] ) do -- Go through all improvements currently available to player.
		for row in GameInfo.Improvement_ValidTerrains() do -- Go through the Valid Terrains for improvements in game info.
			if anImprovement.NAME == row.ImprovementType then -- Check for the improvement on the list.
				if not anImprovement.ENFORCE_TERRAIN then -- Check for the enforce terrain tag. I still have to figure out how this tag works.
				-- For now, EnforceTerrain is used for the Oil improvements. Even though they are on ValidTerrains, don't include because they improve Oil.
					if terrain == GameInfo.Terrains[row.TerrainType].Index then -- Check if the terrain tag matches input terrain.
						if row.PrereqTech then -- Check if this valid terrain requires a tech
							if m_PlayerTechs:HasTech( GameInfo.Technologies[row.PrereqTech].Index ) then table.insert( Improvements, anImprovement ); end
						elseif row.PrereqCivic then -- Check if this valid terrain requires a civic
							if m_PlayerCulture:HasCivic( GameInfo.Civics[row.PrereqCivic].Index ) then table.insert( Improvements, anImprovement ); end
						else table.insert( Improvements, anImprovement ); end -- Otherwise add it.
					end
				end
			end
		end
	end
	return Improvements;
end

--------------------------------------------------------------------------------------------------------
-- Get valid improvements for a plot given a feature.
local function GetImprovementsForPlot_Feature( Improvements, aPlot, iPlayer )
	if iPlayer then m_Player = Players[iPlayer]; end
	--Debug_AllActions( "Entered function: GetImprovementsForPlot_Feature" );
	if not m_Player then Error( "Nil player data passed to function GetImprovementsForPlot_Feature." ); return Improvements; end
	if not Improvements then Error( "Nil valid Improvement table passed to function GetImprovementsForPlot_Feature." ); return Improvements; end
	if not aPlot then Error( "Nil plot data passed to function GetImprovementsForPlot_Feature." ); return Improvements; end
	local improvement = aPlot:GetImprovementType();
	local terrain = aPlot:GetTerrainType();
	local feature = aPlot:GetFeatureType();
	
	local featureObject = IsFeatureRemovableForPlayer( feature, iPlayer );
	-- If the feature is removable and the user has allowed non-resource feature removal, then return actions also available on base terrain.
	if featureObject and b_RemoveFeatures and ( improvement == -1 ) then 
		Improvements = GetImprovementsForPlot_Terrain( Improvements, aPlot, iPlayer );
		-- Set the feature tag, indicating that the feature must be removed for this improvement to work.
		for key, anImprovement in pairs( Improvements ) do 
			if not anImprovement.FEATURE then 
				anImprovement.FEATURE = featureObject; 
				--anImprovement.TYPE = featureObject.TYPE; -- Give an action type tag of REMOVE_FEATURE
				Improvements[key] = anImprovement;
			end 
		end
	end

	for _, anImprovement in pairs( m_PlayerImprovements[ m_Player:GetID() ] ) do -- Go through all improvements currently available to player.
		for row in GameInfo.Improvement_ValidFeatures() do -- Go through the Valid Features for improvements in game info.
			-- Check for the improvement on the list and if the feature tag matches input feature.
			if anImprovement.NAME == row.ImprovementType and feature == GameInfo.Features[row.FeatureType].Index then 
				table.insert( Improvements, anImprovement );
			end
		end
	end
	return Improvements;
end

--------------------------------------------------------------------------------------------------------
-- Get valid improvements for a plot given a resource.
local function GetImprovementsForPlot_Resource( Improvements, aPlot, iPlayer )
	if iPlayer then m_Player = Players[iPlayer]; end
	--Debug_AllActions( "Entered function: GetImprovementsForPlot_Resource" );
	if not m_Player then Error( "Nil player data passed to function GetImprovementsForPlot_Resource." ); return Improvements; end
	if not Improvements then Error( "Nil valid Improvement table passed to function GetImprovementsForPlot_Resource." ); return Improvements; end
	if not aPlot then Error( "Nil plot data passed to function GetImprovementsForPlot_Resource." ); return Improvements; end
	local terrain = aPlot:GetTerrainType();
	local improvement = aPlot:GetImprovementType();
	local resource = aPlot:GetResourceType();
	local feature = aPlot:GetFeatureType();
	
	if resource ~= -1 then
		
		local resourceObject = IsResourceVisibleForPlayer( resource, iPlayer );
		if not resourceObject then -- player cannot see resource, return feature or base terrain improvements
			Debug_AllActions( "Resource is not currently visible to player. Returning base/terrain feature result." );
			if feature ~= -1 then
				Improvements = GetImprovementsForPlot_Feature( Improvements, aPlot, iPlayer ); -- Return feature result if there is a feature
				for key, anImprovement in pairs( Improvements ) do anImprovement.RESOURCE = "INVISIBLE_FEATURE"; Improvements[key] = anImprovement; end
				return Improvements;
			else
				Improvements = GetImprovementsForPlot_Terrain( Improvements, aPlot, iPlayer ); -- Return base terrain result if there is no feature.
				for key, anImprovement in pairs( Improvements ) do anImprovement.RESOURCE = "INVISIBLE_NO_FEATURE"; Improvements[key] = anImprovement; end
				return Improvements;
			end
		else

			local resourceHarvest = IsResourceHarvestableForPlayer( resource, iPlayer );
			-- If there is no improvement, the resource is harvestable and the user has enabled resource harvesting, then possibly harvest resource.
			if resourceHarvest and b_HarvestResources and ( improvement == -1 ) then 
				Improvements = GetImprovementsForPlot_Terrain( Improvements, aPlot, iPlayer );
				for key, anImprovement in pairs( Improvements ) do 
					anImprovement.RESOURCE = resourceHarvest; 
					--anImprovement.TYPE = resourceHarvest.TYPE; -- Give an action type tag of HARVEST_RESOURCE
					Improvements[key] = anImprovement;
				end
			end

			for _, anImprovement in pairs( m_PlayerImprovements[ m_Player:GetID() ] ) do -- Go through all improvements currently available to player.
				
				for row in GameInfo.Improvement_ValidResources() do -- Go through the Valid Resources for improvements in game info.
					-- Check for the improvement on the list and if the resource tag matches input resource.
					if anImprovement.NAME == row.ImprovementType and resource == GameInfo.Resources[row.ResourceType].Index then 
						-- Only add an action if the current plot improvement doesn't match the improvement valid for this resource.
						if improvement ~= GameInfo.Improvements[anImprovement.NAME].Index then 
						
							-- Check if the resource has multiple valid improvements and is already validly improved. If so, don't add the action.
							if IsResourceValidlyImproved( resource, improvement ) == false then

								local addResource = true;
								anImprovement.RESOURCE = resourceObject; -- Add the resource object as a tag.
								if row.MustRemoveFeature == 1 or row.MustRemoveFeature == true then
									 -- Add a tag if building this improvement must remove a feature.
									if feature ~= -1 then -- Resourcce improvement must remove feature but plot has feature.
										local featureObject = IsFeatureRemovableForPlayer( feature, iPlayer ); -- Check if feature is removable
										-- If the feature is removable then we can proceed with adding this action
										if featureObject then
											if improvement == -1 then
												anImprovement.RESOURCE.REMOVES_FEATURE = true;
												--anImprovement.RESOURCE.TYPE = "REMOVE_FEATURE";
											else
												--anImprovement.RESOURCE.TYPE = "REMOVE_IMPROVEMENT";
											end
										else -- Can't remove the feature, cannot improve resource here yet.
											addResource = false;
										end
									else
										-- There is no feature on the plot, fine to go ahead and improve resource.
									end
								end
								if addResource and anImprovement.ENFORCE_TERRAIN then -- Currently used for oil wells and offshore platforms, check if valid terrain matches.
									addResource = false;
									for valid_terrain_row in GameInfo.Improvement_ValidTerrains() do
										if valid_terrain_row.ImprovementType == anImprovement.NAME then -- improvement is in valid terrain table
											if terrain == GameInfo.Terrains[valid_terrain_row.TerrainType].Index then -- plot terrain matches valid terrain in table.
												addResource = true;
												break;
											end
										end
									end
								end
								if addResource then table.insert( Improvements, anImprovement ); end

							end
						end
					end
				end

			end

		end
	end

	return Improvements;
end

--------------------------------------------------------------------------------------------------------
-- Returns the distance between two plots.
local function GetDistance( firstPlot, secondPlot )
	local distance = BAD_DISTANCE;
	if firstPlot and secondPlot and firstPlot.GetX and secondPlot.GetX then -- Check for good data.
		distance = Map.GetPlotDistance( firstPlot:GetX(), firstPlot:GetY(), secondPlot:GetX(), secondPlot:GetY() );
	else
		Debug( "GetDistance: Bad plot data given, returned BAD_DISTANCE." );
	end
	return distance;
end

--------------------------------------------------------------------------------------------------------
-- Returns the number of turns it will take for the given unit to move to the plot.
local function GetTurnDistance( unit, plot, iPlayer )
	local turnsList		= nil;
	local obstacles		= nil;
	local pathPlots		: table = {};
	local endPlotId		:number = -1;
	local nTurnCount 	:number = BAD_DISTANCE;
	local validInput = false;
	if unit and plot and plot.GetIndex then
		endPlotID = plot:GetIndex();
		validInput = true;
	end
	if ( validInput == true ) then
		if unit.ID then -- Builder object was given.
			local iPlayer = iPlayer or unit:getOwner();
			unit = UnitManager.GetUnit( iPlayer, unit.ID );
			if not unit then validInput = false; end
		end
	end
	--SelectUnit( unit );
	if not validInput then return nTurnCount; end
	pathPlots, turnsList, obstacles = UnitManager.GetMoveToPath( unit, endPlotId );
	if not turnsList then return nTurnCount; end
	nTurnCount = table.count(pathPlots) or turnsList[ table.count(turnsList) ] or table.count(turnsList) or nTurnCount;
	if nTurnCount > 1 then
		print( "GetTurnDistance: Unit (" .. unit:GetID() .. ") is " .. tostring(nTurnCount) .. " turn(s) away from plot: " .. tostring( endPlotID ) );
		return nTurnCount;
	else
		-- No path; is it a bad path or is the player have the cursor on the same hex as the unit?
		local startPlotId :number = Map.GetPlot(unit:GetX(),unit:GetY()):GetIndex();
		if startPlotId == endPlotId then				
			print( "GetTurnDistance: Unit (" .. unit:GetID() .. ") is " .. tostring(nTurnCount) .. " turns away from plot: " .. tostring( endPlotID ) );
			return nTurnCount; -- unit is truly 0 turns away from this plot.
		else
			--print( "GetTurnDistance: UnitManager returned bad data for Unit (" .. unit:GetID() .. ") to plot: " .. tostring( endPlotID ) );
			return BAD_DISTANCE;
		end
	end
	return nTurnCount;
end

--------------------------------------------------------------------------------------------------------
-- Returns true if the given plot is within "range" tiles of one of the player's cities
local function IsInCityRange( aPlot, iPlayer, range )
	if not Players[iPlayer] then return false; end
	local cities = Players[iPlayer]:GetCities();
	for _, aCity in cities:Members() do
		local cityPlot = Map.GetPlot( aCity:GetX(), aCity:GetY() );
		local tilesAway = GetDistance( cityPlot, aPlot );
		if tilesAway <= range then return true; end
	end
	return false;
end

--------------------------------------------------------------------------------------------------------
-- Returns true if the given plot has an adjacent plot within a certain range of cities and with the given improvement
local function IsPlotAdjacentToImprovementRange( aPlot, improvement, range )
	local x_start = aPlot:GetX();
	local y_start = aPlot:GetY();
	local x_s = {0, -1, 1, -1, 0, -1}; -- x changes for adjacent hexes.
	local y_s = {1, 1, 0, 0, -1, -1};
	for key, x_change in pairs( x_s ) do
		local x = x_start + x_s[key];
		local y = y_start + y_s[key];
		x = rescale( x, map_width, false ); -- Rescale x around based on map width.
		local plot = Map.GetPlot( x, y );
		if plot and IsInCityRange( plot, plot:GetOwner(), range ) then
			local plot_improvement = plot:GetImprovementType();
			if improvement then
				if plot_improvement == improvement then 
					return true;
				end
			end
		end
	end
	return false;
end

--------------------------------------------------------------------------------------------------------
-- Returns true if the given plot has an adjacent plot with the given improvement
local function IsPlotAdjacentToImprovement( aPlot, improvement )
	local x_start = aPlot:GetX();
	local y_start = aPlot:GetY();
	local x_s = {0, -1, 1, -1, 0, -1}; -- x changes for adjacent hexes.
	local y_s = {1, 1, 0, 0, -1, -1};
	for key, x_change in pairs( x_s ) do
		local x = x_start + x_s[key];
		local y = y_start + y_s[key];
		x = rescale( x, map_width, false ); -- Rescale x around based on map width.
		local plot = Map.GetPlot( x, y );
		if plot then
			local plot_improvement = plot:GetImprovementType();
			if improvement then
				if plot_improvement == improvement then 
					return true;
				end
			end
		end
	end
	return false;
end

--------------------------------------------------------------------------------------------------------
-- Returns true if the aPlot is adjacent to a bonus or luxury resource
local function IsPlotAdjacentToBonusOrLuxury( aPlot, minimum )
	local x_start = aPlot:GetX();
	local y_start = aPlot:GetY();
	local x_s = {0, -1, 1, -1, 0, -1}; -- x changes for adjacent hexes.
	local y_s = {1, 1, 0, 0, -1, -1};
	local resource_count = 0;
	for key, x_change in pairs( x_s ) do
		local x = x_start + x_s[key];
		local y = y_start + y_s[key];
		x = rescale( x, map_width, false ); -- Rescale x around based on map width.
		local plot = Map.GetPlot( x, y );
		if plot then
			local resource = plot:GetResourceType();
			if resource > -1 then
				if GameInfo.Resources[resource].ResourceClassType == "RESOURCECLASS_LUXURY" 
					or GameInfo.Resources[resource].ResourceClassType == "RESOURCECLASS_BONUS" then 
					if minimum == nil then return true; end
					resource_count = resource_count + 1;
				end
			end
		end
	end
	if minimum == nil then return false; end
	if resource_count >= minimum then return true; else return false; end
end

--------------------------------------------------------------------------------------------------------
-- Returns true if the aPlot is adjacent to a sea resource
local function IsPlotAdjacentToSeaResource( aPlot, minimum )
	local x_start = aPlot:GetX();
	local y_start = aPlot:GetY();
	local x_s = {0, -1, 1, -1, 0, -1}; -- x changes for adjacent hexes.
	local y_s = {1, 1, 0, 0, -1, -1};
	local resource_count = 0;
	for key, x_change in pairs( x_s ) do
		local x = x_start + x_s[key];
		local y = y_start + y_s[key];
		x = rescale( x, map_width, false ); -- Rescale x around based on map width.
		local plot = Map.GetPlot( x, y );
		if plot then
			if plot:IsWater() == true then
				local resource = plot:GetResourceType();
				if resource > -1 then
					if minimum == nil then return true; end
					resource_count = resource_count + 1;
				end
			end
		end
	end
	if minimum == nil then return false; end
	if resource_count >= minimum then return true; else return false; end
end

--------------------------------------------------------------------------------------------------------
-- Returns number of plots adjacent to aPlot with valid adjacent terrains for anImprovement
local function GetPlotImprovementValidAdjacentTerrains( aPlot, anImprovement )
	local count = 0;
	local x_start = aPlot:GetX();
	local y_start = aPlot:GetY();
	local x_s = {0, -1, 1, -1, 0, -1}; -- x changes for adjacent hexes.
	local y_s = {1, 1, 0, 0, -1, -1};
	for key, x_change in pairs( x_s ) do
		local x = x_start + x_s[key];
		local y = y_start + y_s[key];
		x = rescale( x, map_width, false ); -- Rescale x around based on map width.
		local plot = Map.GetPlot( x, y );
		if plot then
			local terrain = plot:GetTerrainType();
			if terrain > -1 then
				for row in GameInfo.Improvement_ValidAdjacentTerrains() do
					if row.ImprovementType == anImprovement.NAME and GameInfo.Terrains[row.TerrainType].Index == terrain then
						count = count + 1;
					end
				end
			end
		end
	end
	return count;
end

--------------------------------------------------------------------------------------------------------
-- Returns number of plots adjacent to aPlot with valid adjacent terrains for anImprovement
local function PlotHasCityWithGovernerPromotion( aPlot, promotionName )
	local iCity = GetCityOwningPlot( aPlot );
	local pCity = CityManager.GetCity( aPlot:GetOwner(), iCity );
	if pCity then
		local pAssignedGovernor = pCity:GetAssignedGovernor();
		if (pAssignedGovernor ~= nil) then
			local bIsEstablished = pAssignedGovernor:IsEstablished();
			if (bIsEstablished) then
				local hasPromotion:boolean = pAssignedGovernor:HasPromotion(DB.MakeHash(promotionName));
				if hasPromotion == true then return true; end
			end
		end
	end
	return false;
end

--------------------------------------------------------------------------------------------------------
-- Check special rules for improvement placement such as domain, adjacency, requires a river, is on the frontier, requires coast, minimum appeal, etc.
local function ProcessImprovements_SpecialRules( Improvements, aPlot )
	--Debug_AllActions( "Entered function: ProcessImprovements_SpecialRules" );
	if not aPlot then Error("Nil plot data in function parameter for ProcessImprovements_SpecialRules."); return {}; end
	if not Improvements then Error("Nil improvement table in function parameter for ProcessImprovements_SpecialRules."); return {}; end
	local validMembers = {};
	local check_again = false;
	local terrain = aPlot:GetTerrainType();

	for key, anImprovement in ipairs( Improvements ) do -- Go through the given table of Builder Actions
		local x_start = aPlot:GetX();
		local y_start = aPlot:GetY();
		local keepImprovement = true;
		
		-- Check if the improvment domain matches that of the plot terrain
		local valid_domain = true;
		if anImprovement.DOMAIN == "DOMAIN_LAND" then
			if GameInfo.Terrains[terrain].Water == true or GameInfo.Terrains[terrain].Water == 1 then 
				keepImprovement = false;
				Debug_AllActions("Improvement: " .. anImprovement.NAME .. " has DOMAIN_LAND and does not match plot terrain at: x="  
					.. x_start .. " ; y=" .. y_start .. ". Removing improvement: " .. GameInfo.Improvements[anImprovement.NAME].Index .. 
					" (" .. anImprovement.NAME .. ") from the table."); 
			end
		elseif anImprovement.DOMAIN == "DOMAIN_SEA" then
			if GameInfo.Terrains[terrain].Water == false or GameInfo.Terrains[terrain].Water == 0 then 
				keepImprovement = false;
				Debug_AllActions("Improvement: " .. anImprovement.NAME .. " has DOMAIN_SEA and does not match plot terrain at: x="  
					.. x_start .. " ; y=" .. y_start .. ". Removing improvement: " .. GameInfo.Improvements[anImprovement.NAME].Index .. 
					" (" .. anImprovement.NAME .. ") from the table.");
			end
		end
		
		-- Unique improvement limits.
		if keepImprovement and anImprovement.TYPE == "BUILD_UNIQUE_IMPROVEMENT" then
			local improvementType = GameInfo.Improvements[ anImprovement.NAME ].Index;
			local owner = aPlot:GetOwner();
			local max_uniques = MAX_Uniques_Ever or 100;
			if m_MaxUniques_Ever[ anImprovement.NAME ] then -- use specific cap set for this improvement.
				max_uniques = m_MaxUniques_Ever[ anImprovement.NAME ];
			end
			local count = CountPlayerImprovements( owner, improvementType );
			if count >= max_uniques then -- don't build this unique improvement anywhere in the empire.
				Debug_AllActions("Too many unique improvements of the same type in player civilization. Removing improvement: " .. 
					GameInfo.Improvements[anImprovement.NAME].Index .. " (" .. anImprovement.NAME .. ") from the table."); --
				keepImprovement = false;
			else -- Check city plots hard cap
				max_uniques = MAX_Uniques_PerCity;
				if m_MaxUniques_PerCity[ anImprovement.NAME ] then -- use specific cap set for this improvement.
					max_uniques = m_MaxUniques_PerCity[ anImprovement.NAME ];
				end
				count = CountPlayerImprovementsInCity( owner, improvementType, GetCityOwningPlot( aPlot ) ); -- Get city plots 
				if count >= max_uniques then -- don't build any more of this type of unique improvement on this city's plots.
					Debug_AllActions("Too many unique improvements of the same type in this city. Removing improvement: " .. 
						GameInfo.Improvements[anImprovement.NAME].Index .. " (" .. anImprovement.NAME .. ") from the table.");
					keepImprovement = false;
				end
			end
		end
		if keepImprovement and anImprovement.ADJACENT == false then -- cannot be built adjacent to the same improvement.
			if IsPlotAdjacentToImprovement( aPlot, GameInfo.Improvements[anImprovement.NAME].Index ) == true then
				Debug_AllActions("Improvement: " .. anImprovement.NAME .. " was found adjacent to plot: x=" .. x_start .. 
					" ; y=" .. y_start .. ". Removing improvement: " .. GameInfo.Improvements[anImprovement.NAME].Index .. 
					" (" .. anImprovement.NAME .. ") from the table.");
				keepImprovement = false;
			end
		end
		if keepImprovement and anImprovement.RIVER == true then -- requires a plot with a river.
			if aPlot:IsRiver() == false then 
				Debug_AllActions("Found that plot: x=" .. x_start .. " ; y=" .. y_start .. 
				" does not have a river. Removing improvement: " .. GameInfo.Improvements[anImprovement.NAME].Index .. 
					" (" .. anImprovement.NAME .. ") from the table.");
				keepImprovement = false;
			end
		end
		if keepImprovement and anImprovement.FRONTIER == true then -- must be built on frontier.
			--[[
			-- This is used by China's Great Wall improvement. A way to check if a plot is on the frontier hasn't been implemented yet.

				Debug_AllActions("Found that plot: x=" .. x_start .. " ; y=" .. y_start .. 
				" does not have a river. Removing improvement: " .. GameInfo.Improvements[anImprovement.NAME].Index .. 
					" (" .. anImprovement.NAME .. ") from the table.");
			--]]
			keepImprovement = false; -- For now, just don't try to build the Great Wall improvement.
		end
		if keepImprovement and anImprovement.COAST == true then -- must be built on coast
			if aPlot:IsCoastalLand() == false then
				Debug_AllActions("Found that plot: x=" .. x_start .. " ; y=" .. y_start .. 
				" is not coastal land. Removing improvement: " .. GameInfo.Improvements[anImprovement.NAME].Index .. 
					" (" .. anImprovement.NAME .. ") from the table.");
				keepImprovement = false;
			end
		end
		if keepImprovement and anImprovement.APPEAL then
			local appeal = aPlot:GetAppeal();
			if appeal < anImprovement.APPEAL then
				Debug_AllActions("Found that plot: x=" .. x_start .. " ; y=" .. y_start .. 
				" has an appeal value less than " .. anImprovement.APPEAL .. ". Removing improvement: " .. 
				GameInfo.Improvements[anImprovement.NAME].Index .. " (" .. anImprovement.NAME .. ") from the table.");
				keepImprovement = false;
			end
		end
		if keepImprovement and anImprovement.ONE_PER_CITY then
			local count = CountPlayerImprovementsInCity( aPlot:GetOwner(), GameInfo.Improvements[anImprovement.NAME].Index, GetCityOwningPlot( aPlot ) );
			if count >= 1 then
				Debug_AllActions("Found that plot: x=" .. x_start .. " ; y=" .. y_start .. 
				" city already has the same improvement (with one per city limit). Removing improvement: " .. 
				GameInfo.Improvements[anImprovement.NAME].Index .. " (" .. anImprovement.NAME .. ") from the table.");
				keepImprovement = false;
			end
		end
		if keepImprovement and anImprovement.ADJACENT_VALID_TERRAIN then
			local count = GetPlotImprovementValidAdjacentTerrains( aPlot, anImprovement );
			if count < anImprovement.ADJACENT_VALID_TERRAIN then
				Debug_AllActions("Found that plot: x=" .. x_start .. " ; y=" .. y_start .. 
				" is not adjacent to " .. anImprovement.ADJACENT_VALID_TERRAIN .. " valid terrain types. Removing improvement: " .. 
				GameInfo.Improvements[anImprovement.NAME].Index .. " (" .. anImprovement.NAME .. ") from the table.");
				keepImprovement = false;
			end
		end
		if keepImprovement and anImprovement.CIV then
			if anImprovement.CIV == "TRAIT_CIVILIZATION_NO_PLAYER" then
				if anImprovement.NAME == "IMPROVEMENT_FISHERY" then
					if PlotHasCityWithGovernerPromotion( aPlot, "GOVERNOR_PROMOTION_AQUACULTURE" ) == false then
						Debug_AllActions("Found that plot: x=" .. x_start .. " ; y=" .. y_start .. 
						" isn't owned by a city with governer with the Aquaculture promotion. Removing improvement: " .. 
						GameInfo.Improvements[anImprovement.NAME].Index .. " (" .. anImprovement.NAME .. ") from the table.");
						keepImprovement = false;
					end
				elseif anImprovement.NAME == "IMPROVEMENT_CITY_PARK" then
					if PlotHasCityWithGovernerPromotion( aPlot, "GOVERNOR_PROMOTION_PARKS_RECREATION" ) == false then
						Debug_AllActions("Found that plot: x=" .. x_start .. " ; y=" .. y_start .. 
						" isn't owned by a city with governer with the Parks and Recreation promotion. Removing improvement: " .. 
						GameInfo.Improvements[anImprovement.NAME].Index .. " (" .. anImprovement.NAME .. ") from the table.");
						keepImprovement = false;
					elseif ( ( aPlot:IsRiver() == false ) and ( aPlot:IsCoastalLand() == false ) ) then -- Only build City Parks on coast or river for extra amenity.
						Debug_AllActions("Found that plot: x=" .. x_start .. " ; y=" .. y_start .. 
						" isn't on the coast or on a river. Removing improvement: " .. 
						GameInfo.Improvements[anImprovement.NAME].Index .. " (" .. anImprovement.NAME .. ") from the table.");
						keepImprovement = false;
					end
				else -- Not a base game or expansion improvement. Can't say for certain how its activated so don't try to build it.
					Debug_AllActions("Found that plot: x=" .. x_start .. " ; y=" .. y_start .. 
					" has an action granted by a special modifier, cannot 100% certainly calculate action validity. Removing improvement: " .. 
					GameInfo.Improvements[anImprovement.NAME].Index .. " (" .. anImprovement.NAME .. ") from the table.");
					keepImprovement = false;
				end
			end
		end
		
		if keepImprovement and anImprovement.REQUIRES_BONUS_LUXURY then
			-- Do nothing for now, check this later after valid improvements have been populated.
			check_again = true;
		end
		if keepImprovement and anImprovement.REQUIRES_SEA_RESOURCE then
			-- Do nothing for now, check this later after valid improvements have been populated.
			check_again = true;
		end
		
		if keepImprovement == true then table.insert( validMembers, anImprovement ); end
	end
	
	if check_again == true then -- Go through list again. Some rules require decisions based on available tile improvements.
		local nextMembers = validMembers;
		validMembers = {};
		for key, anImprovement in ipairs( nextMembers ) do -- Go through the given table of Builder Actions
			local x_start = aPlot:GetX();
			local y_start = aPlot:GetY();
			local keepImprovement = true;
			if keepImprovement and anImprovement.REQUIRES_BONUS_LUXURY then
				if #nextMembers > 1 then 
					if IsPlotAdjacentToBonusOrLuxury( aPlot, 2 ) == false then -- Only build these kind of improvements next to 2 or more resources.
						Debug_AllActions("Found that plot: x=" .. x_start .. " ; y=" .. y_start .. 
						" doesn't have 2 adjacent bonus or luxury resources as required. Removing improvement: " .. 
						GameInfo.Improvements[anImprovement.NAME].Index .. " (" .. anImprovement.NAME .. ") from the table.");
						keepImprovement = false;
					end
				elseif IsPlotAdjacentToBonusOrLuxury( aPlot ) == false then -- This is the only improvement available on the plot. Only check for 1 required bonus/luxury resource.
					Debug_AllActions("Found that plot: x=" .. x_start .. " ; y=" .. y_start .. 
					" has no bonus or luxury resource nearby as required. Removing improvement: " .. 
					GameInfo.Improvements[anImprovement.NAME].Index .. " (" .. anImprovement.NAME .. ") from the table.");
					keepImprovement = false;
				end
			end
			if keepImprovement and anImprovement.REQUIRES_SEA_RESOURCE then
				if #nextMembers > 1 then 
					if IsPlotAdjacentToSeaResource( aPlot, 2 ) == false then -- Only build these kind of improvements next to 2 or more resources.
						Debug_AllActions("Found that plot: x=" .. x_start .. " ; y=" .. y_start .. 
						" doesn't have 2 adjacent sea resource as required. Removing improvement: " .. 
						GameInfo.Improvements[anImprovement.NAME].Index .. " (" .. anImprovement.NAME .. ") from the table.");
						keepImprovement = false;
					end
				elseif IsPlotAdjacentToSeaResource( aPlot ) == false then -- Only improvement available. Only check for the 1 required sea resource.
					Debug_AllActions("Found that plot: x=" .. x_start .. " ; y=" .. y_start .. 
					" has no adjacent sea resource as required. Removing improvement: " .. 
					GameInfo.Improvements[anImprovement.NAME].Index .. " (" .. anImprovement.NAME .. ") from the table.");
					keepImprovement = false;
				end
				
			end
			
			if keepImprovement == true then table.insert( validMembers, anImprovement ); end
		end
	end
	
	return validMembers; -- Return the data that match the conditions.
end

--------------------------------------------------------------------------------------------------------
local m_BuilderActionClass = {
	action_type = "";
	target_plot = {};
	turnDistance = BAD_DISTANCE;
	distance = BAD_DISTANCE;
	improvement = nil;
	resource = nil;
	feature = nil;
};
--------------------------------------------------------------------------------------------------------
function m_BuilderActionClass:new ( o )
	o = o or {};
	setmetatable( o, self );
	self.__index = self;
	return o;
end

--------------------------------------------------------------------------------------------------------
-- Get valid actions for a given plot, such as repair improvement, remove improvement, and build improvement types.
local function PlotGetValidActions( aPlot, iPlayer )
	local validActions = {};
	local returnedActionTable = {};
	local actionO = {};
	if iPlayer then m_Player = Players[iPlayer]; end
	if not m_Player then Error( "Nil player data in function PlotGetValidActions." ); return validActions; end
	if aPlot then -- Check for nil data.
		if m_Player:GetID() == aPlot:GetOwner() then -- Double check if the player owns the plot.
			local district = aPlot:GetDistrictType(); 
			if district == -1 then -- Plot has no district
				if aPlot:IsMountain() == false then -- Plot has no mountain
					-- Plot is valid, owned by the player, has no district, and is not a mountain. Print some debug info.
					if debug_AllActions then 
						-- print( " " );
						print( "----------------------------------------------------------------------------------" );
						print( "AutoBuilder Debug: Checking Plot ID: " .. aPlot:GetIndex() .. " (x=" .. aPlot:GetX() .. 
							" ; y=" .. aPlot:GetY() .. ") for work that can be done by a builder." ); 
					end
					if aPlot:IsImprovementPillaged() then -- Check for a pillaged improvement.
						actionO = m_BuilderActionClass:new{
							action_type = "REPAIR";
							target_plot = aPlot;
						};
						table.insert( returnedActionTable, actionO );
						Debug_AllActions( "Plot has a pillaged improvement." );
						-- if m_Priorities:isHighest( "REPAIR" ) then return validActions; end
					end
					if aPlot:IsRoutePillaged() then -- Check for a pillaged road.
						actionO = m_BuilderActionClass:new{
							action_type = "REPAIR_ROAD";
							target_plot = aPlot;
						};
						table.insert( returnedActionTable, actionO );
						Debug_AllActions( "Plot has a pillaged road." );
						-- if m_Priorities:isHighest( "REPAIR_ROAD" ) then return validActions; end
					end
					local improvement = aPlot:GetImprovementType();
					local resource = aPlot:GetResourceType();
					local terrain = aPlot:GetTerrainType();
					local feature = aPlot:GetFeatureType();
					if terrain then Debug_AllActions("Plot has terrain: " .. Locale.Lookup( GameInfo.Terrains[terrain].Name ) ); end
					if improvement == -1 then -- Plot has no improvement
						if resource == -1 then -- Plot has no improvement and no resource
							if feature == -1 then -- Plot has no improvement, no resource, and no feature
								-- Get improvements to build based on just terrain with no features.
								validActions = GetImprovementsForPlot_Terrain( validActions, aPlot, iPlayer );
								-- validActions must flow through this function after it is filled by the others.
								validActions = ProcessImprovements_SpecialRules( validActions, aPlot ); 
								if validActions then
									for key, anAction in pairs( validActions ) do
										actionO = m_BuilderActionClass:new{
											action_type = anAction.TYPE;
											target_plot = aPlot;
											improvement = IMPROVEMENTS[anAction.NAME];
										};
										table.insert( returnedActionTable, actionO );
									end
								end
								
							else -- Plot has no improvement or resource, but it has a feature.
								Debug_AllActions( "Plot has feature type: " .. Locale.Lookup( GameInfo.Features[feature].Name ) );
								-- validActions_terrain = GetImprovementsForPlot_Terrain( validActions, terrain );
								validActions = GetImprovementsForPlot_Feature( validActions, aPlot, iPlayer );
								-- This combines the valid actions from terrain and feature restrictions.
								-- validActions = GetImprovementsForPlot( validActions_terrain, validActions_feature, nil );
								validActions = ProcessImprovements_SpecialRules( validActions, aPlot );
								if validActions then
									for key, anAction in pairs( validActions ) do
										local featureO = nil;
										local action = anAction.TYPE;
										local featureData = anAction.FEATURE;
										if featureData then
											action = featureData.TYPE;
											featureO = featureData;
										end
										actionO = m_BuilderActionClass:new{
											action_type = action;
											target_plot = aPlot;
											improvement = IMPROVEMENTS[anAction.NAME];
											feature = featureO;
										};
										table.insert( returnedActionTable, actionO );
									end
								end									
							end 
						else -- Plot has no improvement and has a resource
							Debug_AllActions( "Plot has resource type: " .. Locale.Lookup( GameInfo.Resources[resource].Name ) );
							if feature == -1 then -- Plot has no improvement and no feature, but has a resource.
								validActions = GetImprovementsForPlot_Resource( validActions, aPlot, iPlayer );
								validActions = ProcessImprovements_SpecialRules( validActions, aPlot ); 
								if validActions then
									for key, anAction in pairs( validActions ) do
										local action = anAction.TYPE;
										local resourceO = nil;
										local resourceData = anAction.RESOURCE;
										if resourceData == "INVISIBLE_NO_FEATURE" then -- Resource is invisible for player, plot has no feature.
											--
										elseif resourceData then
											action = resourceData.TYPE;
											resourceO = resourceData;
										else
											--
										end
										actionO = m_BuilderActionClass:new{
											action_type = action;
											target_plot = aPlot;
											improvement = IMPROVEMENTS[anAction.NAME];
											resource = resourceO;
										};
										table.insert( returnedActionTable, actionO );
									end
								end
								
							else -- Plot has no improvement, but it has a resource and a feature.
								Debug_AllActions( "Plot has feature type: " .. Locale.Lookup( GameInfo.Features[feature].Name ) );
								validActions = GetImprovementsForPlot_Resource( validActions, aPlot, iPlayer );
								validActions = ProcessImprovements_SpecialRules( validActions, aPlot );
								if validActions then
									for key, anAction in pairs( validActions ) do
										local action = anAction.TYPE;
										local resourceO = nil;
										local featureO = nil;
										local resourceData = anAction.RESOURCE;
										local featureData = anAction.FEATURE;
										if resourceData == "INVISIBLE_FEATURE" then -- Resource is invisible for player, plot has feature.
											if featureData then
												action = featureData.TYPE;
												featureO = featureData;
											else
												--
											end
										elseif resourceData == "INVISIBLE_NO_FEATURE" then -- Resource is invisible for player, plot has no feature.
											--
										elseif resourceData then
											action = resourceData.TYPE;
											resourceO = resourceData;
										else
											--
										end
										actionO = m_BuilderActionClass:new{
											action_type = action;
											target_plot = aPlot;
											improvement = IMPROVEMENTS[anAction.NAME];
											resource = resourceO;
											feature = featureO;
										};
										table.insert( returnedActionTable, actionO );
									end
								end
							end
						end

					else -- Plot has an improvement
						Debug_AllActions( "Plot already has an improvement." );
						-- Check if a Builder should remove the improvement to build a better one.
						if resource == -1 then -- Plot has an improvement and no resource
							if feature == -1 then -- Plot has an improvement, but no resource and no feature
								-- Do nothing, don't replace an existing improvement if there is no resource.
							else -- Plot has an improvement and a feature, but has no resource.
								-- Do nothing, don't replace an existing improvement if there is no resource.
							end 
						else -- Plot has an improvement and a resource
							Debug_AllActions( "Plot has resource type: " .. Locale.Lookup( GameInfo.Resources[resource].Name ) ); 
							if feature == -1 then -- Plot has an improvement, a resource, and no feature
								-- Add all the possible replacement improvements to the table (for replacing improvements over resources).
								validActions = GetImprovementsForPlot_Resource( validActions, aPlot, iPlayer );
								validActions = ProcessImprovements_SpecialRules( validActions, aPlot ); 
								if validActions then
									for key, anAction in pairs( validActions ) do
										local action = anAction.TYPE;
										local resourceO = nil;
										local resourceData = anAction.RESOURCE;
										if resourceData == "INVISIBLE_NO_FEATURE" then -- Resource is invisible for player, plot has no feature.
											--
										elseif resourceData then
											action = resourceData.TYPE;
											resourceO = resourceData;
										else
											--
										end
										actionO = m_BuilderActionClass:new{
											action_type = action;
											target_plot = aPlot;
											improvement = IMPROVEMENTS[anAction.NAME];
											resource = resourceO;
										};
										table.insert( returnedActionTable, actionO );
									end
								end
								
							else -- Plot has an improvement, a resource, and a feature.
								Debug_AllActions( "Plot has feature type: " .. Locale.Lookup( GameInfo.Features[feature].Name ) );
								-- Add all the possible replacement improvements to the table (for replacing improvements over resources).
								validActions = GetImprovementsForPlot_Resource( validActions, aPlot, iPlayer );
								validActions = ProcessImprovements_SpecialRules( validActions, aPlot ); 
								if validActions then
									for key, anAction in pairs( validActions ) do
										local action = anAction.TYPE;
										local resourceO = nil;
										local featureO = nil;
										local resourceData = anAction.RESOURCE;
										local featureData = anAction.FEATURE;
										if resourceData == "INVISIBLE_FEATURE" then -- Resource is invisible for player, plot has feature.
											if featureData then
												action = featureData.TYPE;
												featureO = featureData;
											else
												--
											end
										elseif resourceData == "INVISIBLE_NO_FEATURE" then -- Resource is invisible for player, plot has no feature.
											--
										elseif resourceData then
											action = resourceData.TYPE;
											resourceO = resourceData;
										else
											--
										end
										actionO = m_BuilderActionClass:new{
											action_type = action;
											target_plot = aPlot;
											improvement = IMPROVEMENTS[anAction.NAME];
											resource = resourceO;
											feature = featureO;
										};
										table.insert( returnedActionTable, actionO );
									end
								end
							end
						end
					end
					if debug_AllActions then -- Print any valid actions found for a Builder.
						print( "AutoBuilder Debug: Finished Checking Plot ID: " .. aPlot:GetIndex() .. ". Found Valid Builder actions: " );
						for key, action in ipairs( actions ) do 
							if not action.improvement.NAME then
								print( "AutoBuilder Debug: Action: " .. action.action_type );
							else 
								print( "AutoBuilder Debug: Action: " .. action.action_type .. " Improvement: " .. improvement.NAME );
							end
						end
						print( "----------------------------------------------------------------------------------" );
					end
				else Debug_AllActions( "Cannot build on Plot ID: " .. aPlot:GetIndex() .. " (x=" .. aPlot:GetX() .. 
							" ; y=" .. aPlot:GetY() .. ") because there is a Mountain." );
				end
			else Debug_AllActions( "Cannot build on Plot ID: " .. aPlot:GetIndex() .. " (x=" .. aPlot:GetX() .. 
							" ; y=" .. aPlot:GetY() .. ") because plot has DistrictType: " .. Locale.Lookup( GameInfo.Districts[district].Name ) );
			end
		else Debug_AllActions( "PlayerID: " .. Players[iPlayer]:GetID() .. 
			" cannot build improvements on Plot ID: " .. aPlot:GetIndex() .. " (x=" .. aPlot:GetX() .. 
							" ; y=" .. aPlot:GetY() .. ") because it is owned by: " .. thePlot:GetOwner() );
		end
	else Error( "Nil plot data in function parameter for PlotGetValidActions." ); end
	return returnedActionTable;
end

--------------------------------------------------------------------------------------------------------
-- Returns true if the given unit is a civilian
local function IsCivilian( Unit )
	local isCivilian = false;
	local unitType = Unit:GetUnitType();
	if unitType == GameInfo.Units["UNIT_SETTLER"].Index then isCivilian = true;
	elseif unitType == GameInfo.Units["UNIT_BUILDER"].Index then isCivilian = true;
	elseif unitType == GameInfo.Units["UNIT_BUILDER"].Index then isCivilian = true;
	elseif unitType == GameInfo.Units["UNIT_NATURALIST"].Index then isCivilian = true;
	elseif unitType == GameInfo.Units["UNIT_GREAT_GENERAL"].Index then isCivilian = true;
	--elseif unitType == GameInfo.Units["UNIT_GREAT_ADMIRAL"].Index then isCivilian = true;
	elseif unitType == GameInfo.Units["UNIT_GREAT_ENGINEER"].Index then isCivilian = true;
	elseif unitType == GameInfo.Units["UNIT_GREAT_MERCHANT"].Index then isCivilian = true;
	elseif unitType == GameInfo.Units["UNIT_GREAT_PROPHET"].Index then isCivilian = true;
	elseif unitType == GameInfo.Units["UNIT_GREAT_SCIENTIST"].Index then isCivilian = true;
	elseif unitType == GameInfo.Units["UNIT_GREAT_WRITER"].Index then isCivilian = true;
	elseif unitType == GameInfo.Units["UNIT_GREAT_ARTIST"].Index then isCivilian = true;
	elseif unitType == GameInfo.Units["UNIT_GREAT_MUSICIAN"].Index then isCivilian = true;
	elseif 
	( GameInfo.Units[ unitType ].Domain == "DOMAIN_LAND" and GameInfo.Units[ unitType ].FormationClass == "FORMATION_CLASS_CIVILIAN" and 
		GameInfo.Units[ unitType ].ReligiousStrength <= 0 and -- not religious. 
		GameInfo.Units[ unitType ].MakeTradeRoute ~= 1 and GameInfo.Units[ unitType ].MakesTradeRoute ~= true and -- not trader
		GameInfo.Units[ unitType ].Spy ~= 1 and GameInfo.Units[ unitType ].Spy ~= true ) -- not a spy.
		then isCivilian = true;
	end
	return isCivilian;
end

--------------------------------------------------------------------------------------------------------
-- Returns true if the given unit is a religious unit
local function IsReligious( Unit )
	local isReligious = false;
	local unitType = Unit:GetUnitType();
	if unitType == GameInfo.Units["UNIT_MISSIONARY"].Index then isReligious = true;
	elseif unitType == GameInfo.Units["UNIT_APOSTLE"].Index then isReligious = true;
	elseif unitType == GameInfo.Units["UNIT_INQUISITOR"].Index then isReligious = true;
	-- Only check for a Guru if the fall 2017 patch is installed.
	elseif b_Fall2017Patch_Installed and unitType == GameInfo.Units["UNIT_GURU"].Index then isReligious = true;
	elseif GameInfo.Units[ unitType ].FormationClass == "FORMATION_CLASS_CIVILIAN" and 
		GameInfo.Units[ unitType ].ReligiousStrength > 0 then isReligious = true;
	end
	return isReligious;
end

--------------------------------------------------------------------------------------------------------
-- Returns true if the given unit is a trader unit
local function IsTrader( Unit )
	local isTrader = false;
	local unitType = Unit:GetUnitType();
	if unitType == GameInfo.Units["UNIT_TRADER"].Index then isTrader = true; 
	elseif GameInfo.Units[ unitType ].MakeTradeRoute == true then isTrader = true;
	end
	return isTrader;
end

--------------------------------------------------------------------------------------------------------
-- Returns true if the given unit is a spy unit
local function IsSpy( Unit )
	local isSpy = false;
	local unitType = Unit:GetUnitType();
	if unitType == GameInfo.Units["UNIT_SPY"].Index then isSpy = true;
	elseif GameInfo.Units[ unitType ].FormationClass == "FORMATION_CLASS_CIVILIAN" and 
		( GameInfo.Units[ unitType ].Spy == 1 or GameInfo.Units[ unitType ].Spy == true ) then isSpy = true;
	end
	return isSpy;
end

--------------------------------------------------------------------------------------------------------
-- Returns true if a Builder can move here to perform an action.
local function CanMoveToPlot( unit, aPlot )
	if ( not unit ) or ( not aPlot ) then return false; end
	local canMoveToPlot = true;
	if aPlot:IsNationalPark() then -- Can't improve plots in a National Park.
		Debug_AllActions( "Plot x=" .. aPlot:GetX() .. " ; y=" .. aPlot:GetY() .. " is in a National Park! Builder cannot build here." );
		return false; 
	end 
	local district = aPlot:GetDistrictType();
	if district ~= -1 then -- Plot has a district, can't build here anymore.
		Debug_AllActions( "Plot x=" .. aPlot:GetX() .. " ; y=" .. aPlot:GetY() .. " contains a district! Builder cannot build here." );
		return false;
	end
	local units = Units.GetUnitsInPlot( aPlot );
	-- Debug( "Entered CanMoveToPlot" );
	for _, aUnit in pairs( units ) do
		if aUnit:GetID() ~= unit:GetID() then -- Its fine if the unit in the plot is itself.
			if ( IsTrader( unit ) == false ) and ( IsSpy( unit ) == false ) then -- Traders and spies do not block movement.
				-- Unit in plot is owned by another player.
				if aUnit:GetOwner() ~= unit:GetOwner() then  
					-- Fall 2017 patch is installed, so it also doesn't matter if the unit is religious.
					if b_Fall2017Patch_Installed and ( IsReligious( unit ) == false ) then
						Debug_AllActions( "Plot x=" .. aPlot:GetX() .. " ; y=" .. aPlot:GetY() .. 
							" contains a non-religious, non-trader, non-spy unit owned by another player! Builder cannot move here." );
						return false;
					elseif ( b_Fall2017Patch_Installed == false ) then -- Fall 2017 patch is not installed, religious units will block movement.
						Debug_AllActions( "Plot x=" .. aPlot:GetX() .. " ; y=" .. aPlot:GetY() .. 
							" contains a non-trader, non-spy unit owned by another player! Builder cannot move here." );
						return false;
					end
				else -- Unit is friendly, owned by the same player. Check if it is another civilian that will block movement.
					-- Fall 2017 patch is installed, so friendly religious units will not block movement.
					if b_Fall2017Patch_Installed and IsCivilian( aUnit ) then 
						Debug_AllActions( "Plot x=" .. aPlot:GetX() .. " ; y=" .. aPlot:GetY() .. 
							" contains a friendly civilian! Builder cannot move here." );
						return false;
					-- Fall 2017 patch is not installed, friendly civilian or religious units will block movement.
					elseif ( b_Fall2017Patch_Installed == false ) and ( IsCivilian( aUnit ) or IsReligious( unit ) ) then
						Debug_AllActions( "Plot x=" .. aPlot:GetX() .. " ; y=" .. aPlot:GetY() .. 
							" contains a friendly civilian or religious unit! Builder cannot move here." );
						return false;
					end
				end
			end
		end
	end
	-- Don't move to a spot with a military unit if Builder is in a formation with military unit
	if unit:GetFormationUnitCount() > 1 then
		local otherUnits = Units.GetUnitsInPlot( Map.GetPlot( unit:GetX(), unit:GetY() ) );
		local otherLandUnit = unit;
		local otherSupportUnit = unit;
		local otherNavalUnit = unit;
		for _, aUnit in pairs( otherUnits ) do 
			if GameInfo.Units[aUnit:GetUnitType()].FormationClass == "FORMATION_CLASS_LAND_COMBAT" then otherLandUnit = aUnit; end
			if GameInfo.Units[aUnit:GetUnitType()].FormationClass == "FORMATION_CLASS_SUPPORT" then otherSupportUnit = aUnit; end
			if GameInfo.Units[aUnit:GetUnitType()].FormationClass == "FORMATION_CLASS_NAVAL" then otherNavalUnit = aUnit; end
		end
		for _, aUnit in pairs( units ) do
			-- It's fine if the units in the plot are current formation units
			if aUnit:GetID() ~= unit:GetID() and aUnit:GetID() ~= otherLandUnit:GetID() 
			and aUnit:GetID() ~= otherSupportUnit:GetID() and aUnit:GetID() ~= otherNavalUnit:GetID() then
				if unit:GetID() ~= otherLandUnit:GetID() then -- currently in formation with land combat unit
					if GameInfo.Units[aUnit:GetUnitType()].FormationClass == "FORMATION_CLASS_LAND_COMBAT" then 
						Debug_AllActions( "Plot x=" .. aPlot:GetX() .. " ; y=" .. aPlot:GetY() .. " contains another land military unit!" ..
							" Builder cannot move here since it is currently in formation with another military land unit." );
						return false; -- Unit in target plot is also a military land unit with a different ID, can't move here while in formation.
					end
				end
			end
		end
	end
	-- For a final check use the game's CanStartOperation function.
	if unit:GetMovesRemaining() > 0 and unit:GetX() ~= aPlot:GetX() and unit:GetY() ~= aPlot:GetY() then
		if UnitManager.CanStartOperation( unit, UNIT_OPS["UNITOPERATION_MOVE_TO"].HASH, nil, false, false) then -- Check if unit can start movement at all.
			local tParameters = {};
			tParameters[UnitOperationTypes.PARAM_X] = aPlot:GetX();
			tParameters[UnitOperationTypes.PARAM_Y] = aPlot:GetY();
			if not UnitManager.CanStartOperation( unit, UNIT_OPS["UNITOPERATION_MOVE_TO"].HASH, nil, tParameters) then
				Debug( "Plot x=" .. aPlot:GetX() .. " ; y=" .. aPlot:GetY() .. 
					": UnitManager.CanStartOperation query returned false, Builder cannot move here." );
				return false;
			end
		end
	end
	return canMoveToPlot;
end

--------------------------------------------------------------------------------------------------------
-- Returns the sort index of the highest priority
local function GetSortIndex( actionType )
	for key, anIndex in pairs( m_Priorities ) do
		if key == actionType then return anIndex; end -- Return the priority number.
	end
	return BAD_SCORE;
end

--------------------------------------------------------------------------------------------------------
-- Populates the possible new actions a Builder can take.
local function PopulateBuilderPossiblePlots( aBuilder )
	local Actions = {};
	local foundIn3TileRange = false;
	local foundIn4TileRange = false;
	local owner = aBuilder:getOwner();
	local startPlot = Map.GetPlot( aBuilder:x(), aBuilder:y() );
									
	for key, aPlot in pairs( m_PlayerPlots[ owner ] ) do
	
		local resource = aPlot:GetResourceType();
		local resource_type = "";
		if resource ~= -1 then resource_type = GameInfo.Resources[resource].ResourceClassType; end
		-- Only proceed if this plot is not targeted by another automated Builder.
		-- Check if the tile is inside 3 tile range, or if it is outside 3 tile range but is a strategic or luxury resource.
		local inRange = IsInCityRange( aPlot, owner, 3 );
		if ( IsPlotTargeted( aPlot ) == false ) and ( inRange or ( ( inRange == false ) and 
			( resource_type == "RESOURCECLASS_LUXURY" or resource_type == "RESOURCECLASS_STRATEGIC" ) ) ) then 
			if CanMoveToPlot( UnitManager.GetUnit( owner, aBuilder.ID ), aPlot ) then -- Only proceed if the Builder can move here.
				local highPriority = BAD_SCORE; -- Start off the previous priority as lower than all.
				local bestKey = -1;
				local actions = PlotGetValidActions( aPlot, owner ); -- Get all valid actions for this plot.
				if actions then
					local improvement_sort = BAD_SCORE; -- Used for sorting action.improvement if there are multiple options
					local improvement_best = BAD_SCORE;
					for key, action in ipairs( actions ) do -- Sort all the actions for this plot to determine the best action for it.
						if action.action_type then
							-- Check if this action on this plot has been black-listed.
							if ( action.improvement and ( not IsPlotActionBanned( aPlot, action_type, action.improvement.NAME ) ) ) 
								or ( ( not ( action.improvement ) ) and ( not IsPlotActionBanned( aPlot, action.action_type, nil ) ) ) then
								local sort = GetSortIndex( action.action_type );
								local proceed = true;
								improvement_sort = BAD_SCORE;
								if action.improvement then
									if m_Improvement_Scoring[ action.improvement.NAME ] ~= nil then
										if m_Improvement_Scoring[ action.improvement.NAME ] > BAD_SCORE then
											improvement_sort = m_Improvement_Scoring[ action.improvement.NAME ];
											Debug_AllActions( "Improvement: " .. action.improvement.NAME .. " has a priority of " .. improvement_sort ); --_AllActions
										else -- Improvement disabled.
											proceed = false;
										end
									else
										improvement_sort = 0;
									end
									if improvement_sort > improvement_best then
										improvement_best = improvement_sort;
									end
								end
								if proceed == true then 
									-- If this priority is higher than the previous minimum, then it is preferred and will be the best action.
									-- Also check to see if we should choose between farm and mine, farm and beach resort, etc.
									if sort > BAD_SCORE then -- Don't do stuff with a sort value out of range.
										foundIn3TileRange = true; -- found a valid action within 3 tiles.
										if sort > highPriority then
											highPriority = sort;
											bestKey = key;
										elseif sort == highPriority then -- Check if it ties for the highest priority. Check improvement scoring in this case.
											-- Check if this improvement gets a better score than the best improvement score. Choose it if it does.
											--Debug_AllActions( "Action type: " .. action.action_type .. " tied for highest priority of " .. highPriority );
											if improvement_sort > BAD_SCORE then
												if improvement_sort == improvement_best then 
													Debug_AllActions( "Improvement: " .. action.improvement.NAME .. " with more priority replaced old improvement." ); --
													bestKey = key; 
												end
											end
										end
									end
								end
							
							end
						end
					end
					if actions[ bestKey ] then -- Only proceed if there is an action for the plot.
						local action = actions[ bestKey ];
						local actionO = m_BuilderActionClass:new{
							action_type = action.action_type;
							turnDistance = GetTurnDistance( aBuilder, aPlot );
							distance = GetDistance( aPlot, Map.GetPlot( aBuilder:x(), aBuilder:y() ) );
							target_plot = aPlot;
							improvement = action.improvement;
							resource = action.resource;
							feature = action.feature;
						};
						table.insert( Actions, actionO );
					end
				else
					Error( "Nil action data returned for plot!" );
				end
			end
		end
	end
	-- Check in range of 4 plots if no plots were available in 3 tile city range.
	if ( not foundIn3TileRange ) and b_FarmsIn4Tiles then
		for key, aPlot in pairs( m_PlayerPlots[ owner ] ) do
			local resource = aPlot:GetResourceType();
			local resource_type = "";
			if resource ~= -1 then resource_type = GameInfo.Resources[resource].ResourceClassType; end
			-- Only proceed if this plot is not targeted by another automated Builder.
			-- Check untargeted plots not in a 3 tile range and within 4 tile range and also for plots adjacent to farms within 3 tiles.
			if ( not IsPlotTargeted( aPlot ) ) and ( not IsInCityRange( aPlot, owner, 3 ) ) and IsInCityRange( aPlot, owner, 4 ) 
				and IsPlotAdjacentToImprovementRange( aPlot, GameInfo.Improvements["IMPROVEMENT_FARM"].Index, 3 ) then 
				-- Debug( "Found a plot within 4 tiles." );
				if CanMoveToPlot( UnitManager.GetUnit( owner, aBuilder.ID ), aPlot ) then -- Only proceed if the Builder can move here.
					local highPriority = BAD_SCORE; -- Start off the previous priority as lower than all.
					local bestKey = -1;
					local actions = PlotGetValidActions( aPlot, owner ); -- Get all valid actions for this plot.
					if actions then
						local improvement_sort = BAD_SCORE; -- Used for sorting improvements if there are multiple options
						local improvement_best = BAD_SCORE;
						for key, action in ipairs( actions ) do -- Sort all the actions for this plot to determine the best action for it.
							if action.action_type then
								-- Check if this action on this plot has been black-listed.
								if ( action.improvement and ( not IsPlotActionBanned( aPlot, action.action_type, action.improvement.NAME ) ) ) 
									or ( ( not ( action.improvement ) ) and ( not IsPlotActionBanned( aPlot, action.action_type, nil ) ) ) then
									local sort = GetSortIndex( action.action_type );
									local proceed = true;
									improvement_sort = BAD_SCORE;
									if ( action.improvement and (
									-- Only build certain improvements outside 3 tile range.
									action.improvement.NAME == "IMPROVEMENT_FARM" 
									) ) or
									action.action_type == "REPAIR" or action.action_type == "REPAIR_ROAD" -- or if there is something to repair.
									then
										if action.improvement then
											if m_Improvement_Scoring[ action.improvement.NAME ] then
												if m_Improvement_Scoring[ action.improvement.NAME ] > BAD_SCORE then
													improvement_sort = m_Improvement_Scoring[ action.improvement.NAME ];
													--Debug_AllActions( "Improvement: " .. action.improvement.NAME .. " has a priority of " .. improvement_sort );
												else -- Improvement disabled.
													proceed = false;
												end
											else
												improvement_sort = 0;
											end
											if improvement_sort > improvement_best then
												improvement_best = improvement_sort;
											end
										end
										if proceed == true then 
											-- If this priority is higher than the previous minimum, then it is preferred and will be the best action.
											-- Also check to see if we should choose between farm and mine, farm and beach resort, etc.
											if sort > BAD_SCORE then -- Don't do stuff with a sort value out of range.
												foundIn3TileRange = true; -- found a valid action within 3 tiles.
												if sort > highPriority then
													highPriority = sort;
													bestKey = key;
												elseif sort == highPriority then -- Check if it ties for the highest priority. Check improvement scoring in this case.
													-- Check if this improvement gets a better score than the best improvement score. Choose it if it does.
													--Debug_AllActions( "Action type: " .. action.action_type .. " tied for highest priority of " .. highPriority );
													if improvement_sort > BAD_SCORE then
														if improvement_sort == improvement_best then 
															--Debug_AllActions( "Improvement: " .. action.improvement.NAME .. " with higher priority replaced old improvement." );
															bestKey = key; 
														end
													end
												end
											end
										end
									end
								end
							end
						end
						if actions[ bestKey ] then -- Only proceed if there is an action for the plot.
							local action = actions[ bestKey ];
							local actionO = m_BuilderActionClass:new{
								action_type = action.action_type;
								turnDistance = GetTurnDistance( aBuilder, aPlot );
								distance = GetDistance( aPlot, Map.GetPlot( aBuilder:x(), aBuilder:y() ) );
								target_plot = aPlot;
								improvement = action.improvement;
								resource = action.resource;
								feature = action.feature;
							};
							table.insert( Actions, actionO );
						end
					else
						Error( "Nil action data returned for plot!" );
					end
				end
			end
		end
	end
	-- If there is nothing to do within 3 tiles and not farms to improve in 4 tiles, check all tiles to see if a repair is available.
	if not foundIn4TileRange then
		for key, aPlot in pairs( m_PlayerPlots[ owner ] ) do
			-- Just make sure its not targeted by another Builder.
			if ( not IsPlotTargeted( aPlot ) ) then 
				if CanMoveToPlot( UnitManager.GetUnit( owner, aBuilder.ID ), aPlot ) then -- Only proceed if the Builder can move here.
					local highPriority = BAD_SCORE; -- Start off the previous priority as lower than all.
					local bestKey = -1;
					local actions = PlotGetValidActions( aPlot, owner ); -- Get all valid actions for this plot.
					if actions then
						for key, action in ipairs( actions ) do -- Sort all the actions for this plot to determine the best action for it.
							if action.action_type then
								-- Check if this action on this plot has been black-listed.
								if ( action.improvement and ( not IsPlotActionBanned( aPlot, action.action_type, action.improvement.NAME ) ) ) 
									or ( ( not ( action.improvement ) ) and ( not IsPlotActionBanned( aPlot, action.action_type, nil ) ) ) then
									local sort = GetSortIndex( action.action_type );
									if action.action_type == "REPAIR" or action.action_type == "REPAIR_ROAD" then -- Only repair stuff outside 3 tiles.
										if sort > BAD_SCORE then
											if sort > highPriority then
												highPriority = sort;
												bestKey = key;
											end
										end
									end
								end
							end
						end
						if actions[ bestKey ] then -- Only proceed if there is an action for the plot.
							local action = actions[ bestKey ];
							local actionO = m_BuilderActionClass:new{
								action_type = action.action_type;
								turnDistance = GetTurnDistance( aBuilder, aPlot );
								distance = GetDistance( aPlot, Map.GetPlot( aBuilder:x(), aBuilder:y() ) );
								target_plot = aPlot;
								improvement = action.improvement;
								resource = action.resource;
								feature = action.feature;
							}
							table.insert( Actions, actionO );
						end
					else
						Error( "Nil action data returned for plot!" );
					end
				end
			end
		end
	end
	return Actions;
end

--------------------------------------------------------------------------------------------------------
-- Picks an action for a Builder to take based on distance. Returns the same structure but with only one element in each column.
local function GetBestPossiblePlot( actions, builderID )
	Debug_Actions("-------------------------------------------------------------------------------------------------");
	Debug_Actions( "Calculating next move by scoring possible plot actions:" );
	local scores = {};
	local Action = {};
	-- Give each plot a base score based on the Scoring table and distance away from Builder.
	for a_key, action in ipairs( actions ) do
		local finalScore = BAD_SCORE;
		--if action.feature then action.action_type = action.feature.TYPE; end -- Save intended action, but 
		--if action.resource then action.action_type = action.resource.TYPE; end
		for key, aScore in pairs( m_Scoring ) do
			if key == action.action_type then 
				local scale = math.floor( m_Scoring["BUILDER_DISTANCE"] ); -- Scalar controlled by setting.
				local value = action.distance; 
				if action.turnDistance < BAD_DISTANCE then value = value + action.turnDistance; end
				-- Calculate score based on both move turn distance and plot distance.
				finalScore = aScore + ( scale * value ); 
				if not ( action.improvement ) then
					Debug_Actions( action.action_type .. " received a final score of " .. finalScore .. 
						" (" .. action.distance .. " tiles away at x=" .. action.target_plot:GetX() .. "; y=" .. action.target_plot:GetY() .. ")." );
				else
					if action.target_plot:GetResourceType() == -1 then
						if action.target_plot:GetFeatureType() ~= -1 then
							--[[
							Debug_Actions( action.action_type .. " with " .. action.improvement.NAME .. " over terrain: " .. 
								Locale.Lookup( GameInfo.Terrains[action.target_plot:GetTerrainType()].Name ) .. " with feature: " .. 
								Locale.Lookup( GameInfo.Features[action.target_plot:GetFeatureType()].Name ) ..
								" received a final score of " .. finalScore .. " (" .. action.distance .. " tiles away at x=" .. action.target_plot:GetX() .. 
								"; y=" .. action.target_plot:GetY() .. ")." );
							--]]
						else
							--[[
							Debug_Actions( action.action_type .. " with " .. action.improvement.NAME .. " over terrain: " .. 
								Locale.Lookup( GameInfo.Terrains[action.target_plot:GetTerrainType()].Name ) .. 
								" received a final score of " .. finalScore .. " (" .. action.distance .. " tiles away at x=" .. action.target_plot:GetX() .. 
								"; y=" .. action.target_plot:GetY() .. ")." );
							--]]
						end
					else
						if action.target_plot:GetFeatureType() ~= -1 then
							--[[
							Debug_Actions( action.action_type .. " with " .. action.improvement.NAME .. " over terrain: " .. 
								Locale.Lookup( GameInfo.Terrains[action.target_plot:GetTerrainType()].Name ) .. " with feature: " .. 
								Locale.Lookup( GameInfo.Features[action.target_plot:GetFeatureType()].Name ) .. " and with resource: " .. 
								Locale.Lookup( GameInfo.Resources[action.target_plot:GetResourceType()].Name ) ..
								" received a final score of " .. finalScore .. " (" .. action.distance .. " tiles away at x=" .. action.target_plot:GetX() .. 
								"; y=" .. action.target_plot:GetY() .. ")." );
							--]]
						else
							--[[
							Debug_Actions( action.action_type .. " with " .. action.improvement.NAME .. " over terrain: " .. 
								Locale.Lookup( GameInfo.Terrains[action.target_plot:GetTerrainType()].Name ) .. " and with resource: " .. 
								Locale.Lookup( GameInfo.Resources[action.target_plot:GetResourceType()].Name ) ..
								" received a final score of " .. finalScore .. " (" .. action.distance .. " tiles away at x=" .. action.target_plot:GetX() .. 
								"; y=" .. action.target_plot:GetY() .. ")." );
							--]]
						end
					end
				end
			end
		end
		table.insert( scores, finalScore );
	end
	Debug_Actions("Finished scoring all un-targeted plots.");
	Debug_Actions("-------------------------------------------------------------------------------------------------");

	local bestKey = -1;
	local bestScore = BAD_SCORE; -- the best score a plot has received.
	local leastDistance = 10000; -- least distance to a plot
	
	for key, aScore in ipairs( scores ) do
		if aScore > BAD_SCORE then
			if aScore > bestScore then
				bestScore = aScore;
				bestKey = key;
				leastDistance = actions[ key ].turnDistance;
			elseif aScore == bestScore then -- there is a tie for best score, check if distance is shorter.
				if actions[ key ].turnDistance < BAD_DISTANCE then
					if actions[ key ].turnDistance < leastDistance then 
						bestKey = key;
						leastDistance = actions[ key ].turnDistance;
					elseif actions[ key ].turnDistance == leastDistance then
						if actions[ key ].distance < leastDistance then
							bestKey = key;
							leastDistance = actions[ key ].turnDistance;
						end
					end
				else -- Bad turn data. Go by plot distance alone.
					if actions[ key ].distance < leastDistance then
						bestKey = key;
						leastDistance = actions[ key ].distance;
					end
				end
			end
		end
	end
	if bestScore > BAD_SCORE then
		local action = actions[ bestKey ];
		local newPlot = action.target_plot;
		if builderID == nil then builderID = ""; else builderID = tostring( builderID ); end
		if action.improvement then
			Debug("Builder (" .. builderID .. ") found that action type: " .. action.action_type .. " with improvement type: " .. tostring( action.improvement.NAME ) ..
			" (final score: " .. bestScore .. ") on plot: x=" .. newPlot:GetX() .. " ; y=" .. newPlot:GetY() .. " at a distance of " .. action.distance .. 
			" tiles away was the best choice.");
		else
			Debug("Builder (" .. builderID .. ") found that action type: " .. action.action_type ..
			" (final score: " .. bestScore .. ") on plot: x=" .. newPlot:GetX() .. " ; y=" .. newPlot:GetY() .. " at a distance of " .. action.distance .. 
			" tiles away was the best choice.");
		end
		Action = action;
	else
		Action = nil;
		--Debug("Builder could not find any valid actions within 3 tiles of player's cities and could not build any farms within 4 tiles of the player's cities.");
	end
	
	return Action;
end

--------------------------------------------------------------------------------------------------------
-- Checks if player has required techs and/or civics for an object.
local function PlayerHasResearchFor( o, iPlayer )
	local addO = false;
	if iPlayer then 
		m_Player = Players[iPlayer];
		m_PlayerTechs = m_Player:GetTechs();
		m_PlayerCulture = m_Player:GetCulture();
	end
	if o.TECH and GameInfo.Technologies[o.TECH] then -- Check for required tech and valid database data.
		if m_PlayerTechs:HasTech( GameInfo.Technologies[o.TECH].Index ) then 
			if o.CIVIC and GameInfo.Civics[o.CIVIC] then -- Check if a Civic is also required
				if m_PlayerCulture:HasCivic( GameInfo.Civics[o.CIVIC].Index ) then addO = true; end -- Player has both required Tech and Civic.
			else addO = true; end -- Player has required tech and there is no required civic.
		end
	elseif o.CIVIC and GameInfo.Civics[o.CIVIC] then -- No required tech, check for required civic
		if m_PlayerCulture:HasCivic( GameInfo.Civics[o.CIVIC].Index ) then addO = true; end
	else addO = true; end -- No required tech or civic.
	return addO;
end

--------------------------------------------------------------------------------------------------------
-- Add valid improvements, resources, feature removals, etc. to a player based on traits, technologies, and civics.
local function PopulateListData( Table, iPlayer )
	if iPlayer then m_Player = Players[iPlayer]; end
	m_PlayerTechs = m_Player:GetTechs();
	m_PlayerCulture = m_Player:GetCulture();
	-- Get out of function if there is nil data.
	if not m_PlayerTechs then Error( "Nil player Tech data when entering function PopulateListData." ); return nil; end
	if not m_PlayerCulture then Error( "Nil player Culture data when entering function PopulateListData." ); return nil; end
	local List = {};
	for _, o in pairs( Table ) do
		local addO = false;
		if o.CIV then -- check for a CIV tag
			-- Civ trait unlocked:
			if type( o.CIV ) == "table" then
				for _, aCiv in pairs( o.CIV ) do
					if PlayerConfigurations[iPlayer]:GetCivilizationTypeName() == aCiv then 
						addO = PlayerHasResearchFor( o );
						-- Debug( "Player has Civilization: " .. aCiv .. ", granting " .. o.NAME );
					end
				end
			elseif type( o.CIV ) == "string" then
				addO = PlayerHasResearchFor( o );
			end
		elseif o.LEADER then -- check for a LEADER tag
			-- Leader trait unlocked:
			if type( o.LEADER ) == "table" then
				for _, aLeader in pairs( o.LEADER ) do
					if ( PlayerConfigurations[iPlayer]:GetLeaderTypeName() == aLeader ) then 
						addO = PlayerHasResearchFor( o );
						-- Debug( "Player has Leader: " .. aLeader .. ", granting " .. o.NAME );
					else
						-- City State unlocked:
						for ID = 0, PlayerManager.GetWasEverAliveCount() - 1 do -- go through players.
							if ( PlayerConfigurations[ID]:GetLeaderTypeName() == aLeader ) then -- Check for the leader/city state.
								local Influence = Players[ID]:GetInfluence();
								-- Check if this player is a currently active city state.
								if ( Influence and Players[ID]:IsAlive() and Influence:CanReceiveInfluence() ) then
									if ( Influence:GetSuzerain() == iPlayer ) then -- Check if current player is Suzerain of the city state.
										addO = PlayerHasResearchFor( o );
										Debug( "Player is suzerain of " .. aLeader .. ", granting " .. o.NAME );
									end
								end
							end
						end
					end
				end
			end
		elseif o.REMOVABLE ~= nil then -- Check for removable feature tag
			--Debug( "REMOVABLE tag is present for object: " .. o.NAME );
			if o.REMOVABLE == true then -- Check if the feature is removable
				--Debug( "Object: " .. o.NAME .. " is a removable feature." );
				addO = PlayerHasResearchFor( o );
			else
				addO = false;
			end
		else -- Otherwise, there is no CIV or LEADER tag, so it is available for everyone.
			addO = PlayerHasResearchFor( o );
		end

		if addO then List[o.NAME] = o; end

	end

	return List;
end

--------------------------------------------------------------------------------------------------------
-- Refresh player's available Feature removals
local function RefreshPlayerValidFeatureRemovals( iPlayer )
	m_Player = Players[iPlayer];
	if not m_Player then Error( "Nil player data when entering function RefreshPlayerValidFeatureRemovals." ); return; end
	-- Only create a list for human players.
	if m_Player:IsHuman() then 
		m_PlayerFeatureRemovals[iPlayer] = PopulateListData( FEATURES, iPlayer ); 
		--[[
		Debug( "Refreshed valid feature removals for playerID: " .. iPlayer .. 
			" ( " .. Locale.Lookup( PlayerConfigurations[iPlayer]:GetCivilizationTypeName() ) .. 
			" Led by " .. Locale.Lookup( PlayerConfigurations[iPlayer]:GetLeaderTypeName() ) .. " )" );
		--]]
	end
end

--------------------------------------------------------------------------------------------------------
-- Refresh player's available Resource Harvests
local function RefreshPlayerValidResourceHarvests( iPlayer )
	m_Player = Players[iPlayer];
	if not m_Player then Error( "Nil player data when entering function RefreshPlayerValidResourceHarvests." ); return; end
	-- Only create a list for human players.
	if m_Player:IsHuman() then 
		m_PlayerResourceHarvests[iPlayer] = PopulateListData( RESOURCE_HARVESTS, iPlayer ); 
		--[[
		Debug( "Refreshed valid resource harvests for playerID: " .. iPlayer .. 
			" ( " .. Locale.Lookup( PlayerConfigurations[iPlayer]:GetCivilizationTypeName() ) .. 
			" Led by " .. Locale.Lookup( PlayerConfigurations[iPlayer]:GetLeaderTypeName() ) .. " )" );
		--]]
	end
end

--------------------------------------------------------------------------------------------------------
-- Refresh valid improvements for a player.
local function RefreshPlayerValidImprovements( iPlayer )
	m_Player = Players[iPlayer];
	if not m_Player then Error( "Nil player data when entering function RefreshPlayerValidImprovements." ); return; end
	-- Only create a list for human players.
	if m_Player:IsHuman() then 
		m_PlayerImprovements[iPlayer] = PopulateListData( IMPROVEMENTS, iPlayer );
		-- if debug_GameInfo then for _, anImprovement in pairs( m_PlayerImprovements[iPlayer] ) do print( anImprovement.NAME ); end end
		--[[
		Debug( "Refreshed valid improvements for playerID: " .. iPlayer .. 
			" ( " .. Locale.Lookup( PlayerConfigurations[iPlayer]:GetCivilizationTypeName() ) .. 
			" Led by " .. Locale.Lookup( PlayerConfigurations[iPlayer]:GetLeaderTypeName() ) .. " )" );
		--]]
	end
end

--------------------------------------------------------------------------------------------------------
-- Refresh visible resources for a player.
local function RefreshPlayerVisibleResources( iPlayer )
	m_Player = Players[iPlayer];
	if not m_Player then Error( "Nil player data when entering function RefreshPlayerVisibleResources." ); return; end
	if m_Player:IsHuman() then
		m_PlayerResources[iPlayer] = PopulateListData( RESOURCES, iPlayer );
		--[[
		Debug( "Refreshed visible resources for playerID: " .. iPlayer .. 
			" ( " .. Locale.Lookup( PlayerConfigurations[iPlayer]:GetCivilizationTypeName() ) .. 
			" Led by " .. Locale.Lookup( PlayerConfigurations[iPlayer]:GetLeaderTypeName() ) .. " )" );
		--]]
	end
end

--------------------------------------------------------------------------------------------------------
 -- Gets an updated action for the Builder to perform
function BuilderClass:getAction()
	local unit = nil;
	if UnitManager and UnitManager.GetUnit then unit = UnitManager.GetUnit( self:getOwner(), self.ID ); end
	if unit then
		m_Player = Players[self:getOwner()];
		if self.targetPlot then ReleasePlot( self.targetPlot ); end -- Release plot builder is currently targeting because a new target will be obtained.
		self.resource = nil;
		self.feature = nil;
		self.improvement = nil;
		RefreshPlayerValidImprovements( m_Player:GetID() ); -- Refresh improvements in case of suzerain change.
		RefreshPlayerValidPlots( m_Player:GetID() ); -- Refresh valid plots in case borders have changed.
		local builderActions = PopulateBuilderPossiblePlots( self );
		local bestAction = GetBestPossiblePlot( builderActions, self.ID );
		if bestAction then
			if bestAction.target_plot == "SELF" then self:targetSelf(); else self:setTargetPlot( bestAction.target_plot ); end
			if bestAction.turnDistance < BAD_DISTANCE then 
				self.distanceToTarget = bestAction.turnDistance;
			else
				self.distanceToTarget = bestAction.distance;
			end
			self.improvement = bestAction.improvement;
			self.resource = bestAction.resource;
			self.feature = bestAction.feature;
			self.queuedAction = bestAction.action_type;
		else 
			Debug( "No action found when trying to obtain the best action in player's territory." ); 
			self:resetAction();
			self:targetSelf();
		end
		TargetPlot( self.targetPlot ); -- Set this Builder's target plot.
	end
end

--------------------------------------------------------------------------------------------------------
 -- Gets an updated action for the Builder to perform, but doesn't release its current target plot before, so it will switch targets.
function BuilderClass:getActionSwitch()
	local unit = nil;
	if UnitManager and UnitManager.GetUnit then unit = UnitManager.GetUnit( self:getOwner(), self.ID ); end
	if unit then
		self.distanceToTarget = 0; 
		self.queuedAction = "none"; 
		self.improvement = nil;
		self.resource = nil; 
		self.feature = nil; 
		m_Player = Players[self:getOwner()];
		RefreshPlayerValidImprovements( m_Player:GetID() ); -- Refresh improvements in case of suzerain change.
		RefreshPlayerValidPlots( m_Player:GetID() ); -- Refresh valid plots in case borders have changed.
		local builderActions = PopulateBuilderPossiblePlots( self );
		local bestAction = GetBestPossiblePlot( builderActions, self.ID );
		if bestAction then
			if self.targetPlot then ReleasePlot( self.targetPlot ); end -- Release plot builder is currently targeting because a new target will be obtained.
			if bestAction.target_plot == "SELF" then self:targetSelf(); else self:setTargetPlot( bestAction.target_plot ); end
			if bestAction.turnDistance < BAD_DISTANCE then 
				self.distanceToTarget = bestAction.turnDistance;
			else
				self.distanceToTarget = bestAction.distance;
			end
			self.improvement = bestAction.improvement;
			self.resource = bestAction.resource;
			self.feature = bestAction.feature;
			self.queuedAction = bestAction.action_type;
		else 
			Debug( "No action found when trying to obtain the best action in player's territory." ); 
			self:resetAction();
			self:targetSelf();
		end
		TargetPlot( self.targetPlot ); -- Set this Builder's target plot.
	end
end

--------------------------------------------------------------------------------------------------------
-- Returns the plot closest to the given builder amongst the given table of plots.
local function GetClosestPlotToBuilder( builder, plots )
	local closestPlot = nil;
	local leastDistance = BAD_DISTANCE;
	for _, aPlot in pairs( plots ) do
		local turnDistance = GetTurnDistance( builder, aPlot );		
		if turnDistance < BAD_DISTANCE then
			if turnDistance < leastDistance then
				leastDistance = distance;
				closestPlot = aPlot;
			elseif turnDistance == leastDistance then -- Encountered another plot same number of turns away, check if it is closer in tiles.
				if not closestPlot then
					closestPlot = aPlot;
				else
					local newDistance = GetDistance( aPlot, Map.GetPlot( builder:x(), builder:y() ) ); -- Get the actual tile distance away
					local oldDistance = GetDistance( closestPlot, Map.GetPlot( builder:x(), builder:y() ) );
					if newDistance < oldDistance then -- Actual tile distance is closer, replace with new plot.
						leastDistance = turnDistance;
						closestPlot = aPlot;
					end
				end
			end
		else -- Bad turn data. Go by plot distance alone.
			local newDistance = GetDistance( aPlot, Map.GetPlot( builder:x(), builder:y() ) ); -- Get the actual tile distance away
			if newDistance < leastDistance then
				leastDistance = newDistance;
				closestPlot = aPlot;
			end
		end
	end
	return closestPlot;
end

--------------------------------------------------------------------------------------------------------
-- Returns the plot second closest to the given builder amongst the given table of plots.
local function GetSecondClosestPlotToBuilder( builder, plots )
	local closestPlot = nil;
	local secondClosestPlot = nil;
	local leastDistance = BAD_DISTANCE;
	local secondLeastDistance = BAD_DISTANCE;
	for _, aPlot in pairs( plots ) do
		local turnDistance = GetTurnDistance( builder, aPlot );
		if turnDistance < BAD_DISTANCE then
			if turnDistance > leastDistance and turnDistance < secondLeastDistance then
				secondLeastDistance = distance;
				secondClosestPlot = aPlot;
			elseif turnDistance > leastDistance and turnDistance == secondLeastDistance then -- tie for second place for number of turns away.
				local newDistance = GetDistance( aPlot, Map.GetPlot( builder:x(), builder:y() ) );
				local oldDistance = GetDistance( closestPlot, Map.GetPlot( builder:x(), builder:y() ) );
				if newDistance < oldDistance then -- new plot is closer by actual tile number, replace and shift
					secondLeastDistance = newDistance;
					secondClosestPlot = aPlot;
				end
			elseif turnDistance < leastDistance then -- New plot is less turns away than previously found
				secondLeastDistance = leastDistance;
				secondClosestPlot = closestPlot;
				leastDistance = turnDistance;
				closestPlot = aPlot;
			elseif turnDistance == leastDistance then -- same number of turns away.
				local newDistance = GetDistance( aPlot, Map.GetPlot( builder:x(), builder:y() ) );
				local oldDistance = GetDistance( closestPlot, Map.GetPlot( builder:x(), builder:y() ) );
				if newDistance < oldDistance then -- new plot is closer by actual tile number, replace and shift
					secondLeastDistance = leastDistance;
					secondClosestPlot = closestPlot;
					leastDistance = turnDistance;
					closestPlot = aPlot;
				end
			end
		else -- Bad turn data, use only plot distance.
			local newDistance = GetDistance( aPlot, Map.GetPlot( builder:x(), builder:y() ) );
			if newDistance > leastDistance and newDistance < secondLeastDistance then
				secondLeastDistance = distance;
				secondClosestPlot = aPlot;
			elseif newDistance > leastDistance and newDistance == secondLeastDistance then -- tie for second place for number of turns away.
				secondLeastDistance = newDistance;
				secondClosestPlot = aPlot;
			elseif newDistance < leastDistance then -- New plot is less turns away than previously found
				secondLeastDistance = leastDistance;
				secondClosestPlot = closestPlot;
				leastDistance = newDistance;
				closestPlot = aPlot;
			end
		end
	end
	return secondClosestPlot;
end

-- MergeSort: Modified lua implementation from LouisBC at https://gist.github.com/LouiseBC/ab5ab8c3aa9434ce6217b355d0ec6e08
--------------------------------------------------------------------------------------------------------
local function mergeHalves(array:table, o:table, first:number, last:number)
	local left = first;
	local leftTail = math.floor((first + last) / 2);
	local right = leftTail + 1;
	local temp = {unpack(array)};
	local temp_o = {};
	local useO = false;
	if o and type(o) == "table" and #o == #array then useO = true; end
	if useO then temp_o = {unpack(o)}; end
	for i = first, last do
		if (right > last or ((array[left] <= array[right]) and left <= leftTail)) then
			temp[i] = array[left];
			if useO then temp_o[i] = o[left]; end
			left = left + 1;
		else 
			temp[i] = array[right];
			if useO then temp_o[i] = o[right]; end
			right = right + 1;
		end
	end
	for i = first, last do 
		array[i] = temp[i];
		if useO then o[i] = temp_o[i]; end
	end
	return {array, o};
end
--------------------------------------------------------------------------------------------------------
-- MergeSort: Modified lua implementation from LouisBC at https://gist.github.com/LouiseBC/ab5ab8c3aa9434ce6217b355d0ec6e08
local function MergeSort(array:table, o:table, first:number, last:number)
	local first = first or 1;
	local last = last or #array;
	if first >= last then if o then return o, array; else return array; end end
	local middle = math.floor((first + last) / 2);
	MergeSort(array, o, first, middle);
	MergeSort(array, o, (middle+1), last);
	local result = mergeHalves(array, o, first, last);
	array = result[1];
	o = result[2];
	if o then return o, array; else return array; end
end


--------------------------------------------------------------------------------------------------------
local BM_TargetPlotClass = {
	old_builder = -1;
	plot = {};
	action = {};
	distance = BAD_DISTANCE;
	id = -1;
	assigned = false;
};
--------------------------------------------------------------------------------------------------------
function BM_TargetPlotClass:new ( o )
	o = o or {};
	setmetatable( o, self );
	self.__index = self;
	return o;
end
--------------------------------------------------------------------------------------------------------
local BM_BuilderClass = {
	id = -1;
	owner = -1;
	targetPlot = {};
	turnDistance = BAD_DISTANCE;
	distance = BAD_DISTANCE;
	assigned = false;
};
--------------------------------------------------------------------------------------------------------
function BM_BuilderClass:new ( o )
	o = o or {};
	setmetatable( o, self );
	self.__index = self;
	return o;
end

--------------------------------------------------------------------------------------------------------
-- Return a table of builders that aren't currently assigned.
local function BM_GetAvailableBuilders( builders )
	local available_builders = {};
	for _j, builder in ipairs( builders ) do
		if builder.assigned == false then -- eligible for targeting.
			local unit = nil;
			if UnitManager and UnitManager.GetUnit then unit = UnitManager.GetUnit( builder.owner, builder.id ); end
			if unit and GameInfo.Units[unit:GetUnitType()].Index == GameInfo.Units["UNIT_BUILDER"].Index then
				-- builder.turnDistance = GetTurnDistance( unit, plot );
				-- builder.distance = GetDistance( plot, Map.GetPlot( unit:GetX(), unit:GetY() ) );
				table.insert( available_builders, builder );
			end
		end
	end
	return available_builders;
end

--------------------------------------------------------------------------------------------------------
-- Populate plot objects with closest builder ids
local function BM_PopulateClosestBuildersForPlots( plots, builders, idx )
	local idx = idx or 1;
	local available_builders = BM_GetAvailableBuilders( builders );
	for i = idx, #plots do -- Go through plots
		local o = plots[ i ];
		--print( "BM_PopulateClosestBuildersForPlots: i=" .. i .. ", o=plots[i]=" .. tostring( o ) );
		local leastDistance = BAD_DISTANCE;
		local bestID = -1;
		local bestPlot = nil;
		for _, builder in ipairs( available_builders ) do -- Go through unassigned builders.
			local turnDistance = BAD_DISTANCE;
			local unit = nil;
			if UnitManager and UnitManager.GetUnit then unit = UnitManager.GetUnit( builder.owner, builder.id ); end
			if unit then
				turnDistance = GetTurnDistance( unit, o.plot );
				if turnDistance < BAD_DISTANCE then
					if turnDistance < leastDistance then -- this builder is closer by number of turns.
						leastDistance = turnDistance;
						bestID = builder.id;
					elseif turnDistance == leastDistance then -- equal number of turns away.
						local oldUnit = UnitManager.GetUnit( builder.owner, bestID );
						local newDistance = GetDistance( o.plot, Map.GetPlot( unit:GetX(), unit:GetY() ) );
						local oldDistance = GetDistance( o.plot, Map.GetPlot( oldUnit:GetX(), oldUnit:GetY() ) );
						if newDistance < oldDistance then -- new builder is closer by actual number of plots, replace.
							leastDistance = turnDistance;
							bestID = builder.id;
						end
					end
				else -- Bad turn data, go only by plot distance.
					--print( "BM_PopulateClosestBuildersForPlots: unit plot=" .. tostring(Map.GetPlot( unit:GetX(), unit:GetY() )) );
					local newDistance = GetDistance( o.plot, Map.GetPlot( unit:GetX(), unit:GetY() ) );
					if newDistance < leastDistance then
						leastDistance = newDistance;
						bestID = builder.id;
					end
				end
			end
		end
		o.distance = leastDistance;
		o.id = bestID;
		plots[ i ] = o; -- Save object back to table.
	end
	return plots;
end

--------------------------------------------------------------------------------------------------------
-- Sorts a table of plots based on least plot distance and turn distance away from assigned builder.
local function BM_SortPlots( iPlayer, plots, idx )
	local idx = idx or 1;
	local turn_distances = {};
	local distances = {};
	local useTurnDistance = true;
	--print("Entered BM_SortPlots");
	for i = idx, #plots do -- Go through plots
		local o = plots[ i ];
		local unit = nil;
		if UnitManager and UnitManager.GetUnit then unit = UnitManager.GetUnit( iPlayer, o.id ); end
		if unit then
			local turnDistance = GetTurnDistance( unit, o.plot );
			if turnDistance >= BAD_DISTANCE then useTurnDistance = false; end
			table.insert( turn_distances, turnDistance );
			table.insert( distances, GetDistance( o.plot, Map.GetPlot( unit:GetX(), unit:GetY() ) ) );
			---[[
			--print( "Sort found turn distance: " .. tostring(GetTurnDistance( unit, o.plot )) .. " from unit: " .. unit:GetID() .. 
			--	" at x=" .. unit:GetX() .. ", y=" .. unit:GetY() .. " to plot at x=" .. o.plot:GetX() .. ", y=" .. o.plot:GetY() );
			print( "Sort found plot distance: " .. tostring(GetDistance( Map.GetPlot( unit:GetX(), unit:GetY() ), o.plot )) .. " from unit: " .. unit:GetID() .. 
				" at x=" .. unit:GetX() .. ", y=" .. unit:GetY() .. " to plot at x=" .. o.plot:GetX() .. ", y=" .. o.plot:GetY() );
			--]]
		end
	end
	--print("Done finding distances.");
	--[[ Debug info
	print( "MergeSort test (before):" );
	for key, element in ipairs( distances ) do print( element .. ": " .. plots[key].id .. " (" .. plots[key].distance .. ")" ); end
	plots = MergeSort( distances, plots ); -- Use mergesort algorithm to sort object table by using the least distance array.
	distances = MergeSort( distances );
	print( "MergeSort test (after):" );
	for key, element in ipairs( distances ) do print( element .. ": " .. plots[key].id .. " (" .. plots[key].distance .. ")" ); end
	--]]
	-- The Merge Sort algorithm is stable, so after sorting by least plot distance, that order plots will be preserved for plots with the same move turns.
	plots = MergeSort( distances, plots, idx ); -- Sort by plot distance first.
	if useTurnDistance == true then
		plots = MergeSort( turn_distances, plots, idx ); -- Then sort by turns away
	end
	if not plots then plots = {}; end
	return plots;
end

--------------------------------------------------------------------------------------------------------
-- Returns the builder currently assigned to this plot.
local function BM_GetBuilderAssignedToPlot( iPlayer, plot, builders )
	local iPlayer = iPlayer or 0;
	if ( not plot ) or ( not plot.GetIndex ) then return nil; end
	local builder = nil;
	for _, aBuilder in pairs( builders ) do
		if aBuilder.targetPlot and aBuilder.targetPlot.GetIndex and aBuilder.targetPlot:GetIndex() == plot:GetIndex() then
			builder = aBuilder;
			break;
		end
	end
	return builder;
end

--------------------------------------------------------------------------------------------------------
-- Higher level function taking consideration before assigning a builder to a new plot.
local function BM_ShouldBuilderTakeOver( unit, oldUnit, plot, plots )
	local takeOver = false;
	if unit and unit.GetID and oldUnit and oldUnit.GetID and plot and plot.GetIndex then
		local oldTurnDistance = GetTurnDistance( oldUnit, plot );
		local newTurnDistance = GetTurnDistance( unit, plot );
		if oldTurnDistance < BAD_DISTANCE and newTurnDistance < BAD_DISTANCE then -- Valid turn distance data.
			if newTurnDistance < oldTurnDistance then -- reassign
				takeOver = true;
			elseif newTurnDistance == oldTurnDistance then -- check actual plot distance.
				local oldDistance = GetDistance( plot, Map.GetPlot( oldUnit:GetX(), oldUnit:GetY() ) );
				local newDistance = GetDistance( plot, Map.GetPlot( unit:GetX(), unit:GetY() ) );
				if newDistance < oldDistance then -- New builder has the same turns but is closer in plot distance, reassign.
					takeOver = true;
				elseif newDistance == oldDistance then -- New Buulder is just as close via plot distance as well, need to calculate if it should be assigned.
					
					-- Check the second closest unassigned plot to each Builder and compare
					local unassigned_plots = {};
					for _, o in ipairs( plots ) do
						if o.assigned == false then table.insert( unassigned_plots, o.plot ); end
					end
					if #unassigned_plots > 1 then
						local newBuilder = nil;
						local oldBuilder = nil;
						newBuilder = m_Builders:get( unit );
						if not newBuilder then return false; end
						print( "BM_ShouldBuilderTakeOver: Reached 5." );
						oldBuilder = m_Builders:get( oldUnit );
						if not oldBuilder then return true; end
						local old_secondClosestPlot = GetSecondClosestPlotToBuilder( oldBuilder, unassigned_plots ); 
						local new_secondClosestPlot = GetSecondClosestPlotToBuilder( newBuilder, unassigned_plots );
						local old_second_turn_distance = GetTurnDistance( oldUnit, old_secondClosestPlot );
						local new_second_turn_distance = GetTurnDistance( newUnit, new_secondClosestPlot );
						if old_second_turn_distance < BAD_DISTANCE and new_second_turn_distance < BAD_DISTANCE then
							if old_second_turn_distance < new_second_turn_distance then -- Old builder has shorter turns to travel for second closest plot, reassign.
								takeOver = true;
							elseif old_second_turn_distance == new_second_turn_distance then -- Its a tie for turns to the second closest plot.
								
								-- Calculate plot distances to second closest plot.
								local old_second_distance = GetDistance( old_secondClosestPlot, Map.GetPlot( oldBuilder:x(), oldBuilder:y() ) );
								local new_second_distance = GetDistance( new_secondClosestPlot, Map.GetPlot( newBuilder:x(), newBuilder:y() ) );
								if old_second_distance < new_second_distance then -- old builder has shorter plot distance to travel for second closest plot, reassign.
									takeOver = true;
								elseif old_second_distance == new_second_distance then
									takeOver = false; -- Could check third closest plot here, but then a third builder may have to be taken into account.
								else -- New builder has shorter plot distance to travel for second closest plot. Don't reassign.
									takeOver = false;
								end
								
							else -- New builder has shorter turns to travel for second closest plot. Don't reassign.
								takeOver = false;
							end
						else -- Bad turn data.
							-- Calculate plot distances to second closest plot.
							local old_second_distance = GetDistance( old_secondClosestPlot, Map.GetPlot( oldBuilder:x(), oldBuilder:y() ) );
							local new_second_distance = GetDistance( new_secondClosestPlot, Map.GetPlot( newBuilder:x(), newBuilder:y() ) );
							if old_second_distance < new_second_distance then -- old builder has shorter plot distance to travel for second closest plot, reassign.
								takeOver = true;
							elseif old_second_distance == new_second_distance then
								takeOver = false; -- Could check third closest plot here, but then a third builder may have to be taken into account.
							else -- New builder has shorter plot distance to travel for second closest plot. Don't reassign.
								takeOver = false;
							end
						end
					else
						takeOver = false;
					end
					
				else -- Old plot is closer to Builder, don't reassign
					takeOver = false; 
				end
			end
		
		else -- Bad turn distance data, only go by plot distance.
			
			local oldDistance = GetDistance( plot, Map.GetPlot( oldUnit:GetX(), oldUnit:GetY() ) );
			local newDistance = GetDistance( plot, Map.GetPlot( unit:GetX(), unit:GetY() ) );
			if newDistance < oldDistance then -- reassign
				takeOver = true;
			elseif newDistance == oldDistance then -- New Buulder is just as close via plot distance as well, need to calculate if it should be assigned.
				-- Check the second closest unassigned plot to each Builder and compare
				local unassigned_plots = {};
				for _, o in ipairs( plots ) do
					if o.assigned == false then table.insert( unassigned_plots, o.plot ); end
				end
				if #unassigned_plots > 1 then
					local newBuilder = nil;
					local oldBuilder = nil;
					newBuilder = m_Builders:get( unit );
					if not newBuilder then return false; end
					oldBuilder = m_Builders:get( oldUnit );
					if not oldBuilder then return true; end
					local old_secondClosestPlot = GetSecondClosestPlotToBuilder( oldBuilder, unassigned_plots ); 
					local new_secondClosestPlot = GetSecondClosestPlotToBuilder( newBuilder, unassigned_plots );
					-- Calculate plot distances to second closest plot.
					local old_second_distance = GetDistance( old_secondClosestPlot, Map.GetPlot( oldBuilder:x(), oldBuilder:y() ) );
					local new_second_distance = GetDistance( new_secondClosestPlot, Map.GetPlot( newBuilder:x(), newBuilder:y() ) );
					if old_second_distance < new_second_distance then -- old builder has shorter plot distance to travel for second closest plot, reassign.
						takeOver = true;
					elseif old_second_distance == new_second_distance then
						takeOver = false; -- Could check third closest plot here, but then a third builder may have to be taken into account.
					else -- New builder has shorter plot distance to travel for second closest plot. Don't reassign.
						takeOver = false;
					end
				else
					takeOver = false;
				end
			end
			
		end
	else
		Error( "BM_ShouldBuilderTakeOver: Nil data was passed into function, returned false." );
	end
	return takeOver;
end

--------------------------------------------------------------------------------------------------------
-- Mark plots and builders as assigned until a conflict has been found.
local function BM_FindNextConflict( iPlayer, plots, builders, idx, IDs_seen )
	local idx = idx or 1;
	local IDs_seen = IDs_seen or {};
	-- Go through and mark builders as assigned. 
	for i = idx, #plots do
		local already_seen = false;
		local o = plots[ i ];
		--print( "BM_FindNextConflict: i=" .. i .. ", idx=" .. idx );
		for _i, anID in pairs( IDs_seen ) do
			if anID == o.id then 
				already_seen = true; 
				break;
			end -- Check if this id is already in the table.
		end
		if not already_seen then
			local new_unit = UnitManager.GetUnit( iPlayer, o.id );
			local old_unit = nil;
			local old_builder = BM_GetBuilderAssignedToPlot( iPlayer, o.plot, builders );
			if old_builder then old_unit = UnitManager.GetUnit( iPlayer, old_builder.id ); end
			local takeOver = true;
			if old_unit then
				if new_unit:GetID() == old_unit:GetID() then -- Same unit we are checking, don't take over.
					takeOver = false;
				else -- Check if old builder has not been assigned yet.
					for _, oB in ipairs( builders ) do
						if ( oB.id == old_unit:GetID() ) and ( oB.assigned == false ) then -- ID match and not marked as assinged.
							takeOver = BM_ShouldBuilderTakeOver( new_unit, old_unit, o.plot, plots );
							break;
						end
					end
				end
			end
			if takeOver == true then
				if old_unit then
					Debug( "Builder Manager re-assigned plot (" .. tostring(o.plot:GetIndex()) .. ") from builder " 
						.. tostring(old_unit:GetID()) .. " to builder " .. tostring(o.id) );
				else
					Debug( "Builder Manager re-assigned plot (" .. tostring(o.plot:GetIndex()) .. ") from builder " 
						.. tostring(o.old_builder) .. " to builder " .. tostring(o.id) );
				end
			else
				o.id = old_unit:GetID();
			end
			-- Also go through builders and mark this builder as assigned.
			for j, oB in ipairs( builders ) do
				if o.id == oB.id then
					oB.assigned = true;
					oB.targetPlot = o.plot;
					builders[ j ] = oB;
					break;
				end
			end
			table.insert( IDs_seen, o.id );
			o.assigned = true; -- Mark plot as okay to be assigned.
			plots[ i ] = o; -- Save data back to table.
		end
		if already_seen == true then break; end -- Builder has appeared twice in the table. Break out of table.
		idx = idx + 1;
	end
	
	return plots, builders, idx, IDs_seen, false;
end

--------------------------------------------------------------------------------------------------------
-- Recursive function used for optimizing builder efficiency.
local function BM_ProcessMethod_1( iPlayer:number, plots:table, builders:table, idx:number, IDs_seen:table )
	local iPlayer = iPlayer or 0;
	local idx = idx or 1;
	local IDs_seen = IDs_seen or {};
	if ( not plots ) or ( not builders ) or ( type( plots ) ~= "table" ) or ( type( builders ) ~= "table" ) then
		return plots, builders, true; -- early escape
	end
	if #builders ~= #plots then -- early escape
		Error( "Attempt to process builder action optimization with different numbers of plots and builders." );
		return plots, builders, true;
	end
	local hasError = false;
	print("BM_ProcessMethod_1: Entered. idx=" .. idx .. ", #plots=" .. tostring(#plots));
	plots = BM_PopulateClosestBuildersForPlots( plots, builders, idx ); -- populate plots with closest builder ids.
	print("BM_ProcessMethod_1: Populated Closest Builders for plots, #plots=" .. tostring(#plots));
	plots = BM_SortPlots( iPlayer, plots, idx );
	print("BM_ProcessMethod_1: Sorted plots, #plots=" .. tostring(#plots));
	plots, builders, idx, IDs_seen, hasError = BM_FindNextConflict( iPlayer, plots, builders, idx, IDs_seen );
	print("BM_ProcessMethod_1: Processed until a conflict was found. idx=" .. idx .. ", #plots=" .. tostring(#plots));
	
	if hasError == true then return plots, builders, true; end -- Escape if there was a processing error.
	if idx > #plots or idx > #builders then -- no plots or builders left to assign
		print("BM_ProcessMethod_1: Reached base case, returning good data.");
		return plots, builders, false; -- This is the base case that will stop recursion.
	end
	return BM_ProcessMethod_1( iPlayer, plots, builders, idx, IDs_seen ); -- Call self with updated idx to search.
end

--------------------------------------------------------------------------------------------------------
-- Populate plots and builders with appropriate objects.
local function BM_PopulateTables( iPlayer )
	local plots = {};
	local builders = {};
	for _, aBuilder in pairs( m_Builders.members ) do -- Go through builders.
		if aBuilder.isAutomated and aBuilder:getOwner() == iPlayer then -- Check if they are automated and belong to the player
			local unit = nil;
			if UnitManager and UnitManager.GetUnit then unit = UnitManager.GetUnit( iPlayer, aBuilder.ID ); end
			if unit and GameInfo.Units[unit:GetUnitType()].Index == GameInfo.Units["UNIT_BUILDER"].Index then
				if aBuilder.targetPlot and aBuilder.targetPlot.GetIndex then 
					table.insert( plots, BM_TargetPlotClass:new{ plot = aBuilder.targetPlot, action = aBuilder:getActionObject(), id = aBuilder.ID, old_builder = aBuilder.ID } );
					table.insert( builders, BM_BuilderClass:new{ id = aBuilder.ID, owner = iPlayer, targetPlot = aBuilder.targetPlot } );
				end
			end
		end
	end
	return plots, builders;
end

--------------------------------------------------------------------------------------------------------
-- Processes and switches Automated Builder targets to optimize routes and efficiency.
local function BM_ProcessBuilderActionsOptimization( iPlayer )
	
	local plots = {};
	local builders = {};
	plots, builders = BM_PopulateTables( iPlayer ); -- Load in automated builders and their assignments.
	if not plots[1] then return; end -- early escape if no builders are automated.
	local hasError = false;
	plots, builders, hasError = BM_ProcessMethod_1( iPlayer, plots, builders ); -- Recursive method for returning the optimized tables.
	if hasError == true then return; end -- early escape if there was a processing error.
	
	-- Plots should be all sorted and assigned, switch builder actions.
	for i, o in ipairs( plots ) do
		print( "Found plot with ID=" .. tostring(o.id) .. ", plot=" .. tostring(o.plot) );
		if o.assigned == true then
			local oldBuilder = o.old_builder;
			print( "Found old builder with ID=" .. tostring(o.old_builder) );
			if o.id ~= o.old_builder then
				local newUnit = nil;
				if UnitManager and UnitManager.GetUnit then newUnit = UnitManager.GetUnit( iPlayer, o.id ); end
				if newUnit then
					local newBuilder = m_Builders:get( newUnit );
					if newBuilder then
						newBuilder:setAction( o.action ); -- Copy this action into new builder object.
						--oldBuilder:resetAction(); -- Reset old builder action
						TargetPlot( newBuilder.targetPlot ); -- Set plot as targeted again.
						m_Builders:save( newBuilder );
						--m_Builders:save( oldBuilder );
					end
				end
			end
		end
	end
	print( "Builder Manager processed optimization for Automated Builder actions using Method 1." );
end
m_BuilderManager.Process = BM_ProcessBuilderActionsOptimization;

--------------------------------------------------------------------------------------------------------
-- Refreshes Automated Builder instructions and automatically gives a command to each Builder.
local function ProcessAutomatedBuilderActions( iPlayer )
	
	-- Refresh all Automated Builder Actions
	for _, aBuilder in ipairs( m_Builders.members ) do -- Go through builders.
		if aBuilder.isAutomated and aBuilder:getOwner() == iPlayer then -- Check if they are automated and belong to the player
			local unit = UnitManager.GetUnit( iPlayer, aBuilder.ID );
			if unit and GameInfo.Units[unit:GetUnitType()].Index == GameInfo.Units["UNIT_BUILDER"].Index then
				if aBuilder.queuedAction == "none" then -- Get a new action if the Builder has finished performing their current action.
					Debug( "ProcessAutomatedBuilderActions: Builder has no queued action, getting new action." );
					aBuilder:getAction(); -- Refresh the Builder's next action.
					m_Builders:save( aBuilder ); -- Save the data to m_Builders table.
				elseif not CanMoveToPlot( unit, aBuilder.targetPlot ) then -- Else check if the Builder can no longer move to its target plot.
					Debug( "ProcessAutomatedBuilderActions: Builder can no longer perform queued operation at target plot, getting new action." );
					aBuilder:getAction(); -- Refresh the Builder's next action.
					m_Builders:save( aBuilder ); -- Save the data to m_Builders table.
				elseif aBuilder.improvement then -- Check special rules for improvement again, as other improvements may have been built.
					local improvements = { aBuilder.improvement };
					improvements = ProcessImprovements_SpecialRules( improvements, aBuilder.targetPlot );
					if improvements[1] then 
						--aBuilder.improvement = improvements[1];
					else -- Improvement no longer valid on this plot. Get new action.
						aBuilder:getAction();
						m_Builders:save( aBuilder );
					end
				end
			end
		end
	end
	
	-- Process refreshed builder actions to maximize efficiency
	if b_UseAutoBuilderManager == true then m_BuilderManager.Process( iPlayer ); end
	LuaEvents.CNO_AutoBuilder_OnBuilderActionsUpdate(); -- Tell other scripts that unit statuses were probably updated.
	
	-- Have all Builders realize their actions.
	for _, aBuilder in ipairs( m_Builders.members ) do -- Go through builders.
		if aBuilder.isAutomated and aBuilder:getOwner() == iPlayer then -- Check if they are automated and belong to the player
			local unit = UnitManager.GetUnit( iPlayer, aBuilder.ID );
			if unit and GameInfo.Units[unit:GetUnitType()].Index == GameInfo.Units["UNIT_BUILDER"].Index then
				aBuilder:realizeAction(); -- Do something based on current goal.
				m_Builders:save( aBuilder ); -- Save the data to m_Builders table.
			end
		end
	end
	
end

--------------------------------------------------------------------------------------------------------
local function SleepAutomatedUnits( iPlayer )
	for _, aBuilder in pairs( m_Builders.members ) do
		if aBuilder.isAutomated and aBuilder:getOwner() == iPlayer then
			local unit = UnitManager.GetUnit( aBuilder:getOwner(), aBuilder.ID );
			if unit:IsReadyToMove() or unit:IsReadyToSelect() then 
				aBuilder:sleep(); -- Don't make the user have to select the unit's action.
			end
		end
	end
end

--------------------------------------------------------------------------------------------------------
local function OnUnitOperationDeactivated( iPlayer, iUnit, hOperation, iData1 )
	local unit = nil;
	if UnitManager then unit = UnitManager.GetUnit( iPlayer, iUnit ); end
	if unit and unit:GetMovesRemaining() > 0 then -- check if selected unit has moves
		local builder = m_Builders:get( unit );
		if builder and builder.isAutomated and builder:getOwner() == iPlayer then -- check for an automated builder and owned by player.
			if ( builder.targetPlot ) and ( not CanMoveToPlot( unit, builder.targetPlot ) ) then -- Check if the Builder cannot move to its target plot.
				Debug( "OnUnitOperationDeactivated: Unit operation deactivated and op is no longer valid for Builder's target, getting new action." );
				builder:getAction(); -- Refresh the Builder's next action.
				builder:realizeAction(); -- Do something based on current goal.
				m_Builders:save( builder ); -- Save the data to m_Builders table.
			end
		end
	end
end

--------------------------------------------------------------------------------------------------------
local function OnUnitSelectionChanged( iPlayer, iUnit, x, y, z, isSelected, isEditable)
	if isSelected then
		local unit = nil;
		if UnitManager then unit = UnitManager.GetUnit( iPlayer, iUnit ); end
		if unit and GameInfo.Units[unit:GetUnitType()].Index == GameInfo.Units["UNIT_BUILDER"].Index then
			--[[ Debug info on unit selection.
			for _, aPlot in pairs( m_PlayerPlots[0] ) do
				local distance = GetTurnDistance( unit, aPlot );
			end
			--]]
			if unit:GetMovesRemaining() > 0 and ( not unit:HasPendingOperations() ) then -- check if selected unit has moves and no pending operations
				local builder = m_Builders:get( unit );
				 -- check for an automated builder and owned by player with a queued action.
				if builder and builder.isAutomated and builder:getOwner() == iPlayer then
					if ( not ( builder.queuedAction == "none" ) ) then -- Builder has a queued non-sleep action: there was an issue moving to the target plot.
						Error( "There was an issue processing action for Builder (" .. builder.ID .. "). There was an unexpected reason why the Builder could not" .. 
						" move to its target plot. Switching to new action for Builder so user does not have to select." );
						--Debug( "OnUnitSelectionChanged: Unit selected is an automated Builder with movement left and a pending action, switching action." );
						builder.has_error = true;
						builder:getActionSwitch(); -- Refresh the Builder's next action.
						builder:realizeAction(); -- Do something based on current goal.
						m_Builders:save( builder ); -- Save the data to m_Builders table.
					elseif builder.queuedAction == "none" and ( not ( builder.previousAction == "SLEEP" ) ) then 
						-- The Builder just tried to perform a non-sleep action on its target plot and it failed (the unit had to be told what to do).
						Error( "There was an issue processing action for Builder (" .. builder.ID .. "). There was an unexpected reason why the Builder could not" .. 
						" perform an action on its current plot. Switching to new action for Builder so user does not have to select." );
						--Debug( "OnUnitSelectionChanged: Unit selected is an automated Builder with movement left and no pending operations, switching action." );
						-- Ban any automated Builder from trying to perform this action on this plot again for this session.
						if builder.improvement and builder.improvement.NAME then
							BanPlotAction( builder.targetPlot, builder.previousAction, builder.improvement.NAME );
						else
							BanPlotAction( builder.targetPlot, builder.previousAction, nil );
						end
						builder.has_error = true;
						builder:getActionSwitch(); -- Refresh the Builder's next action.
						builder:realizeAction(); -- Do something based on current goal.
						m_Builders:save( builder ); -- Save the data to m_Builders table.
					end
				end
			end
		end
	end
end

--------------------------------------------------------------------------------------------------------
local function OnUnitMoveComplete( iPlayer, iUnit )
	local unit = nil;
	if UnitManager then unit = UnitManager.GetUnit( iPlayer, iUnit ); end
	if unit and GameInfo.Units[unit:GetUnitType()].Index == GameInfo.Units["UNIT_BUILDER"].Index 
		and unit:GetMovesRemaining() > 0 then -- only try to perform an action if the unit has moves left.
		local theBuilder = m_Builders:get( unit );
		if theBuilder and theBuilder.isAutomated and theBuilder:hasReachedTarget() then 
			Debug( "OnUnitMoveComplete: Builder (" .. theBuilder.ID .. ") finished movement and still has moves left, realizing action." );
			theBuilder:realizeAction();
			m_Builders:save( theBuilder );
		end
	end
end
--------------------------------------------------------------------------------------------------------
local function OnUnitMovementPointsChanged( iPlayer, iUnit, movement )
	local unit = nil;
	if UnitManager then unit = UnitManager.GetUnit( iPlayer, iUnit ); end
	if ( unit and ( GameInfo.Units[unit:GetUnitType()].Index == GameInfo.Units["UNIT_BUILDER"].Index ) ) then 
		if ( movement > 0 ) then -- only try to perform an action if the unit has moves left.
			local theBuilder = m_Builders:get( unit );
			if theBuilder and theBuilder.isAutomated and theBuilder:hasReachedTarget() then 
				Debug( "OnUnitMovementPointsChanged: Builder (" .. theBuilder.ID .. ") finished movement and still has moves left, realizing action." );
				theBuilder:realizeAction();
				m_Builders:save( theBuilder );
			end
		end
	end
end

--------------------------------------------------------------------------------------------------------
local function OnUnitRemovedFromMap( iPlayer, iUnit )
	local theBuilder = m_Builders:get( iPlayer, iUnit );
	if theBuilder and theBuilder.isAutomated then 
		Debug( "OnUnitRemovedFromMap: Automated Builder (" .. theBuilder.ID .. ") was removed from the map, resetting object data in table..." );
		-- Reset object data for this unit ID and save it back to the table.
		theBuilder:setAutomated( false );
		theBuilder:resetAction();
		theBuilder:resetPreviousAction();
		m_Builders:save( theBuilder );
	end
end

--------------------------------------------------------------------------------------------------------
local function OnCivicCompleted( iPlayer, param2, param3, param4 )
	if Players and iPlayer and Players[iPlayer]:IsHuman() then 
		m_Player = Players[iPlayer];
		Debug( "Civic completed for Player: " .. iPlayer .. ". Refreshing player visible resources." );
		if m_Player then 
			RefreshPlayerValidImprovements( iPlayer );
			RefreshPlayerVisibleResources( iPlayer );
		end
	end
end

--------------------------------------------------------------------------------------------------------
local function OnResearchCompleted( iPlayer, param2, param3, param4 )
	if Players and iPlayer and Players[iPlayer]:IsHuman() then 
		m_Player = Players[iPlayer];
		Debug( "Tech completed for Player: " .. iPlayer .. ". Refreshing player visible resources." );
		if m_Player then 
			RefreshPlayerValidImprovements( iPlayer );
			RefreshPlayerValidFeatureRemovals( iPlayer );
			RefreshPlayerVisibleResources( iPlayer );
			RefreshPlayerValidResourceHarvests( iPlayer );
		end
	end
end

--------------------------------------------------------------------------------------------------------
-- This code would be run after the player's turn ends, so it's not helpful because you can't command units after turn has ended.
local function OnPlayerTurnDeactivated( iPlayer )
	if Players and iPlayer and Players[iPlayer]:IsHuman() then 
		m_Player = Players[iPlayer];
		--Debug( "Player: " .. iPlayer .. " turn deactivated." );
		if m_Player then 
			if ( GameConfiguration.IsHotseat() == true ) and ( m_isAutoBuilder_GP_Loaded == true ) then -- Save tables in gameplay script	after player turn ends
				m_AutoBuilder_GP.SetBuilders( m_Builders );
				m_AutoBuilder_GP.SetBuilderPlots( m_Plots );
			end
			-- ProcessAutomatedBuilderActions( iPlayer ); -- Tell Builders to perform their queued actions.
		end
	end
end

--------------------------------------------------------------------------------------------------------
local function OnPlayerTurnActivated( iPlayer )
	if Players and iPlayer and Players[iPlayer]:IsHuman() then 
		m_Player = Players[iPlayer];
		--Debug( "Player: " .. iPlayer .. " turn activated." );
		if m_Player then 
			if ( ( GameConfiguration.IsHotseat() == true ) and ( m_isAutoBuilder_GP_Loaded == true ) and ( m_AutoBuilder_GP.HasMembers() == true ) ) then
				-- Retrieve tables from gameplay script
				m_Builders = m_AutoBuilder_GP.GetBuilders();
				m_Plots = m_AutoBuilder_GP.GetBuilderPlots();
			end
			-- SleepAutomatedUnits();
			ProcessAutomatedBuilderActions( iPlayer ); -- Tell Builders to perform their queued actions.
		end
	end
end

--------------------------------------------------------------------------------------------------------
local function InitializeAutoBuilderGP()
	if ExposedMembers.CNO_AutoBuilder_GP_Initialized then 
        m_AutoBuilder_GP = ExposedMembers.CNO_AutoBuilder_GP;   -- contains functions from other context
        Events.GameCoreEventPublishComplete.Remove( InitializeAutoBuilderGP );
		m_isAutoBuilder_GP_Loaded = true;
		print( "AutoBuilder: Loaded gameplay script context." );	
    end
end

ExposedMembers.CNO_AutoBuilder_Initialized = false;

--------------------------------------------------------------------------------------------------------
function Initialize()
	
	--print( "Initializing UI script..." );
	
	-- Populate player data for all human players when initializing.
	for ID = 0, PlayerManager.GetWasEverAliveCount() - 1 do -- go through players.
		local player = Players[ID];
		if player:IsHuman() then 
			RefreshPlayerValidPlots( ID );
			RefreshPlayerValidImprovements( ID );
			RefreshPlayerValidFeatureRemovals( ID );
			RefreshPlayerValidResourceHarvests( ID );
			RefreshPlayerVisibleResources( ID );
		end
	end

	--Events.UnitMoveComplete.Add( OnUnitMoveComplete );
	Events.UnitMovementPointsChanged.Add( OnUnitMovementPointsChanged );
	Events.CivicCompleted.Add( OnCivicCompleted );
	Events.ResearchCompleted.Add( OnResearchCompleted );
	Events.PlayerTurnActivated.Add( OnPlayerTurnActivated );
	Events.PlayerTurnDeactivated.Add( OnPlayerTurnDeactivated );
	Events.UnitRemovedFromMap.Add( OnUnitRemovedFromMap );
	-- Fallback event in case a user is asked to select an action for a Builder
	Events.UnitSelectionChanged.Add( OnUnitSelectionChanged );

	LuaEvents.CNO_AutoBuilder_SettingsUpdate.Add( OnUpdateAutoBuilderSettings );
	LuaEvents.CNO_AutoBuilder_SettingsInitialized.Add( OnUpdateAutoBuilderSettings );
	LuaEvents.CNO_AutoBuilder_PrioritySettingsUpdate.Add( OnUpdateAutoBuilderPrioritySettings );
	LuaEvents.CNO_AutoBuilder_PrioritySettingsInitialized.Add( OnUpdateAutoBuilderPrioritySettings );
	
	-- Gedemon's method for sharing functions between different contexts using the ExposedMembers table.
	if ( not ExposedMembers.CNO_AutoBuilder ) then ExposedMembers.CNO_AutoBuilder = {}; end
	ExposedMembers.CNO_AutoBuilder.AutomateBuilder = AutomateBuilder;
	ExposedMembers.CNO_AutoBuilder.StopAutomateBuilder = StopAutomateBuilder;
	ExposedMembers.CNO_AutoBuilder.debug = debug;
	ExposedMembers.CNO_AutoBuilder.IsBuilderAutomated = IsBuilderAutomated;
	ExposedMembers.CNO_AutoBuilder.GetUnitStatus = GetBuilderStatus;
	ExposedMembers.CNO_AutoBuilder_Initialized = true;
	
	--print( "Added UI script functions to exposed members table." );

	Events.GameCoreEventPublishComplete.Add( InitializeAutoBuilderGP );

end

Initialize();