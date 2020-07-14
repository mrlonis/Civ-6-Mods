--------------------------------------------------------------------------------------------------------


-- ATTENTION:

-- SETTINGS ARE NO LONGER CONTAINED IN THIS FILE. SEE the AutoBuilders_Settings.sql TO CHANGE SETTINGS


--------------------------------------------------------------------------------------------------------
local debug				:boolean = true; -- Set to true to enable basic debug messages in the Lua.log
local debug_FindAction 	:boolean = false; -- Set to true to enable LOTS of debug messages for finding plot actions and scoring them.
local debug_GameInfo	:boolean = false; -- Set to true to enable printing all of the resources, improvements, features, and terrains loaded into mod.
--------------------------------------------------------------------------------------------------------
--[[

AUTOMATED ARCHAEOLOGISTS SCRIPT

Mod Version: 0.98.2
Script Version: 0.95
Contributors: MadManCam
Created: 27 Nov 2017
Last Edited: 8 Jul 2018

This script contains the processing and logic for the Automated Archaeologists Mod for Civilization 6.

Steam Workshop Mod: http://steamcommunity.com/sharedfiles/filedetails/?id=1243167006
Civ Fanatics Resource: https://forums.civfanatics.com/resources/automated-builders-archaeologists.26662/


CHANGELOG
Version 0.95 ( MadManCam )
- Removed UnitPanel.lua replacement, added a separate panel to automate units and show their current status.
- This new method makes the ability to automate units more reliable. It also means this mod is now compatible with other mods that replace the UnitPanel.lua file.
- Units now calculate their moves primarily on number of turns away, rather than plot distance (although it is still used).
- Added support for hot seat mode. Automated Builders/Archaelogists will now stay automated even after the UI is refreshed.
- Fixed script definitions for traders/civilian/religious units so that new units of that type added by mods or DLC will be recognized.
- At the beginning of every turn, the Unit Manager will reprocess automated builder actions and reassign builders to closer plots.

Version 0.94 ( MadManCam )
- Fixed an issue where automated units would try to target plots in National Parks.

Version 0.93 ( MadManCam )
- Fixed a "ghost unit" issue where newly created units had a small chance of becoming automated right away and bugging out, 
	taking on the automation from a previously destroyed/spent unit if the game assigned them the old unit's ID.
- Implemented a basic virtual moderator for the automated units: if a unit tries to do something and there is an error, 
	that action on that plot will be banned for all automated units for that session (the data is reset when the UI is refreshed 
	or when you re-load the game). Please post a bug report if you ever see a unit doing something bad like moving back and forth for several turns.
- Changed how required techs/civics were checked so that if a modder ever makes both a Tech AND Civic required for an 
	improvement that the mod will check for both.

Version 0.92 ( MadManCam )
- Updated actual automation code for compatibility with games without the Fall 2017 patch: If the Fall 2017 patch is not installed,
	Automated units will no longer try to target plots that have religious units since they did not have their own layer until this patch.
- Enemy spies should no longer block Automated units targeting the plot. This didn't really affect automated Archaeologists or Builders
	since they never targeted plots with districts anyways, but it will be important for future mods with other automated units.
	
Version 0.91 ( MadManCam )
- Fixed the setting for archaeologists not knowing where all artifacts are. Before, if you changed the setting to false they would only check in "visible" tiles for the player, now it should check all "revealed" tiles for the player on the map.
- The previous version was set up so that Archaeologists would never target the same plot. This could mean that in multiplayer games, archaeologists from different players would not go for the same plot. Changed code so that archaeologists from different players can target the same plot, seeing which one gets there first.
- Archaeologists have a new setting that allows you to turn off automated Archaeologists excavating in other player's territory. By default it is turned off so that archaeologists won't excavate in other player's territory.

Version 0.90 ( MadManCam )
- Added script.


CONTRIBUTOR NOTES
- Not tested on Mac or Linux.


END USER DESCRIPTION
Notes/Features
- When automated they will move to and excavate artifacts automatically. If there is nothing to do they will just sleep wherever they are, but will check at the beginning of each turn for something to do.
- They don't care about nearby enemy units, but if they are captured I believe they just spawn back in one of your cities.
- By default, archaeologists know where all the artifacts are on the map, even if you haven't explored it. This can be changed in the mod settings (see discussion) so that they can only see plots you have revealed.
- Archaeologists will go towards the nearest artifact in terms of plot distance away from their location. If they can no longer enter the tile for that artifact (another civilian moves into it) then they will choose somewhere else to go.
- By default, Archaeologists will not excavate in other player's territory. See mod settings discussion for how to change. If you switch it to true, they will check for open borders and excavate in other player's territory.
- If excavating in other player's territory is enabled in the settings, building Terracotta Army will let your archaeologists enter foreign lands without open borders. Haven't tested this yet but I've implemented it so that it should work for automated Archaeologists.
- Archaeologists will NOT target any artifact that has an improvement over it. You have to manually remove that improvement with a Builder if you want to excavate there.
- At the beginning of every turn, the Unit Manager will reprocess automated builder actions and reassign builders to closer plots.

--]]
--------------------------------------------------------------------------------------------------------


--======================================================================================================
-- MEMBERS
--======================================================================================================
local b_ArchaeologistsExplore					= GameInfo.CNO_AutoBuilders_Settings[ "ArchaeologistsExplore" ].mBoolean or true;
local b_ArchaeologistsExcavateInOtherBorders	= GameInfo.CNO_AutoBuilders_Settings[ "ArchaeologistsExcavateInOtherBorders" ].mBoolean or false;
b_ArchaeologistsExplore = b_ArchaeologistsExplore == 1 or b_ArchaeologistsExplore == true;
b_ArchaeologistsExcavateInOtherBorders = b_ArchaeologistsExcavateInOtherBorders == 1 or b_ArchaeologistsExcavateInOtherBorders == true;

--local b_UseAutoArchaeologistManager = GameInfo.CNO_AutoBuilders_Settings[ "AutoArchaeologistManager" ].mBoolean;
--b_UseAutoArchaeologistManager = b_UseAutoArchaeologistManager == 1 or b_UseAutoArchaeologistManager == true;
local b_UseAutoArchaeologistManager = false;

local BAD_DISTANCE = 9999;
local BAD_SCORE = -9999;

--------------------------------------------------------------------------------------------------------
-- Setting to value (just for priorities).
local function SettingToValue( setting )
	--local value = setting;
	if setting < -99 then setting = BAD_SCORE; end -- For now, just limit value range. 
	if setting > 400 then setting = 400; end
	return setting;
end

--------------------------------------------------------------------------------------------------------
-- Updates variables from database settings.
local function OnUpdateAutoArchaeologySettings()
	b_ArchaeologistsExplore					= GameConfiguration.GetValue( "AutoBuilders_ArchaeologistsExplore_Boolean" );
	b_ArchaeologistsExcavateInOtherBorders	= GameConfiguration.GetValue( "AutoBuilders_ArchaeologistsExcavateInOtherBorders_Boolean" );
	if b_ArchaeologistsExplore == nil then b_ArchaeologistsExplore = GameInfo.CNO_AutoBuilders_Settings[ "ArchaeologistsExplore" ].mBoolean; end
	if b_ArchaeologistsExcavateInOtherBorders == nil then b_ArchaeologistsExcavateInOtherBorders = GameInfo.CNO_AutoBuilders_Settings[ "ArchaeologistsExcavateInOtherBorders" ].mBoolean end
	b_ArchaeologistsExplore = b_ArchaeologistsExplore == 1 or b_ArchaeologistsExplore == true;
	b_ArchaeologistsExcavateInOtherBorders = b_ArchaeologistsExcavateInOtherBorders == 1 or b_ArchaeologistsExcavateInOtherBorders == true;
end
OnUpdateAutoArchaeologySettings();

local debug_AllActions = false; -- Set to true to enable EVEN MORE debug messages printed to log for each plot.
m_Scoring = {};
m_Scoring["ARCHAEOLOGIST_DISTANCE"] = -5;
m_Scoring["ARTIFACT"] = 100;
-- Some functions for debug/error usage.
local function Error() print( "AutoArchaeology ERROR!" ); end
local function Error( message ) if not message then Error() else print( "AutoArchaeology ERROR: " .. message ); end end
local function DebugError() print( "AutoArchaeology debug ERROR" ); end
local function Debug( message ) if debug then if message then print( "AutoArchaeology Debug: " .. message ); else DebugError(); end end end
local function Debug_Actions( message ) if debug_FindAction then if message then print( "AutoArchaeology Debug: " .. message ); else DebugError(); end end end
local function Debug_AllActions( message ) if debug_AllActions then if message then print( "AutoArchaeology Debug: " .. message ); else DebugError(); end end end
local m_Player = Players[0]; -- Stores player data for local processing.
local m_PlayerTechs = m_Player:GetTechs();
local m_PlayerCulture = m_Player:GetCulture();

local m_Archaeologist = {}; --  stores Archaeologist object data for local processing.
local m_Plot = {}; -- stores TargetPlot object data for local processing.
local m_PlayerResources = {}; -- Contains a list of visible resources for each human player.
local m_BannedPlotActions = {}; -- Table of banned plot actions so Archaeologists will not attempt them again.
m_BannedPlotActions.X = {};
m_BannedPlotActions.Y = {};
m_BannedPlotActions.Actions = {};

local m_ArchaeologistManager = {};

local m_AutoArchaeologist_GP = {}; -- Gameplay script for storing tables
local m_isAutoArchaeologist_GP_Loaded = false;

-- Check if the Fall 2017 patch is installed:
local b_Fall2017Patch_Installed = false;
if GameInfo.Units["UNIT_GURU"] then 
	b_Fall2017Patch_Installed = true; 
	print( "The Fall 2017 Patch is installed for this game." );
else
	print( "The Fall 2017 Patch is NOT installed for this game." );
end


--======================================================================================================
-- CONSTANTS
--======================================================================================================

local STATUSES = { -- Used for UI unit status text.
	{ action_type="ARTIFACT",			string=Locale.Lookup( "LOC_CNO_AUTOBUILDERS_STATUS_EXCAVATE" )	}, 
	{ action_type="EXCAVATE",			string=Locale.Lookup( "LOC_CNO_AUTOBUILDERS_STATUS_EXCAVATE" )	}
};

-- Returns a unit status string given an action type and optional resource/improvement object.
local function GetStatusString( actionType )
	local status_string = "";
	local foundStatus = false;
	for _, row in pairs( STATUSES ) do
		if row.action_type == actionType then
			status_string = row.string;
			foundStatus = true;
			break;	
		end
	end
	if not foundStatus then status_string = Locale.Lookup( "LOC_CNO_AUTOBUILDERS_STATUS_SLEEP" ); end
	return status_string;
end

local RESOURCES = {};
local UNIT_COMMANDS = {};
local UNIT_OPS = {};
local map_width, map_height = Map.GetGridSize();

--------------------------------------------------------------------------------------------------------
local function GetGameResources()
	if debug_GameInfo then print( "Populating RESOURCES table from GameInfo: " ); end
	for row in GameInfo.Resources() do 
		local o = {};
		-- Associate Archaeologist priority actions with the different resources.
		if row.ResourceClassType == "RESOURCECLASS_STRATEGIC" then o.TYPE = "IMPROVE_STRATEGIC";
		elseif row.ResourceClassType == "RESOURCECLASS_LUXURY" then o.TYPE = "IMPROVE_LUXURY";
		elseif row.ResourceClassType == "RESOURCECLASS_BONUS" then o.TYPE = "IMPROVE_BONUS";
		elseif row.ResourceClassType == "RESOURCECLASS_ARTIFACT" then o.TYPE = "ARTIFACT";
		else o.TYPE = "NON_CONVENTIONAL_RESOURCE"; end
		
		o.NAME = row.ResourceType;
		o.HASH = row.Hash;
		if row.PrereqTech then o.TECH = GameInfo.Technologies[row.PrereqTech].Index; end
		if row.PrereqCivic then o.CIVIC = GameInfo.Civics[row.PrereqCivic].Index; end
		
		if debug_GameInfo then 
			print( "Added resource: " );
			for key, data in pairs( o ) do print( tostring( key ) .. ": " .. tostring( data ) ); end
			print();
		end
		RESOURCES[o.NAME] = o;
	end
end

--------------------------------------------------------------------------------------------------------
local function GetGameUnitCommands()
	for row in GameInfo.UnitCommands() do 
		local o = {};
		o.NAME = row.CommandType;
		o.HASH = row.Hash;
		if debug_GameInfo and 
			o.NAME == "UNITOPERATION_EXCAVATE"
			then 
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
		if debug_GameInfo and
			o.NAME == "UNITOPERATION_EXCAVATE"
			then 
			print( "Added unit operation: " );
			for key, data in pairs( o ) do print( tostring( key ) .. ": " .. tostring( data ) ); end
			print();
		end
		UNIT_OPS[o.NAME] = o;
	end
end

-- Load some game data, including that from all mods enabled.
GetGameResources();
GetGameUnitCommands();
GetGameUnitOps();


--======================================================================================================
-- STATIC OBJECTS
--======================================================================================================
 -- Table of archaeologists.
local m_Archaeologists = {
	members = {};
};
function m_Archaeologists:count() -- Number of archaeologists currently automated.
	local totalAutomated = 0;
	for key, keyData in ipairs( self.members ) do
		if keyData.isAutomated then totalAutomated = totalAutomated + 1; end
	end
	return totalAutomated;
end
function m_Archaeologists:add( o ) -- Adds a new object to the table.
	if not o then Error( "Nil data passed to mArchaeologists' add function! No data was added." ); end
	table.insert( self.members, o );
end
function m_Archaeologists:get( unit, iUnit ) -- Returns a Archaeologist object from the table.
	if not unit then Error( "Nil data passed to mArchaeologists' get function!" ); return nil; end
	for _, anArchaeologist in ipairs( self.members ) do 
		if iUnit ~= nil then
			if ( anArchaeologist.owner == unit ) and ( anArchaeologist.ID == iUnit ) then
				return anArchaeologist;
			end
		elseif ( type( unit ) == "table" ) then -- Check if a table was given.
			if ( unit.GetID ~= nil and anArchaeologist.ID == unit:GetID() and unit.GetOwner ~= nil and anArchaeologist:getOwner() == unit:GetOwner() ) 
				or ( anArchaeologist.ID == unit.ID and anArchaeologist:getOwner() == unit:getOwner() ) then 
				return anArchaeologist;
			end
		end
	end return nil;
end
function m_Archaeologists:save( o ) -- Overwrites updated Archaeologist object data into the table.
	if not o then Error( "Nil data passed to mArchaeologists' save function! No data was saved." ); return; end
	for key, anArchaeologist in ipairs( self.members ) do
		if ( anArchaeologist.ID == o.ID and anArchaeologist:getOwner() == o:getOwner() ) then self.members[key] = o; end
	end
end

-- Table of plots.
local m_Plots = {
	members = {};
};
function m_Plots:count() -- Number of plots currently targeted.
	local totalTargeted = 0;
	for key, keyData in ipairs( self.members ) do
		if keyData.isTargeted then totalTargeted = totalTargeted + 1; end
	end
	return totalTargeted;
end
function m_Plots:add( o ) -- Adds a new object to the table.
	if not o then Error( "Nil data passed to m_Plots' add function! No data was added." ); end
	table.insert( self.members, o );
end
function m_Plots:get( iPlot, iPlayer ) -- Returns a TargetPlot object from the table.
	if not iPlot then Error( "Nil data passed to m_Plots' get function!" ); return nil; end
	for _, aPlot in ipairs( self.members ) do 
		if aPlot.ID == iPlot then -- Check if a iPlot ID number was given.
			if aPlot.byPlayer == iPlayer then
				return aPlot; 
			end
		elseif ( type( iPlot ) == "table" ) then -- Check if a table was given.
			if ( iPlot.GetIndex ~= nil and aPlot.ID == iPlot:GetIndex() ) or aPlot.ID == iPlot.ID then 
				if aPlot.byPlayer == iPlayer then
					return aPlot; 
				end
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
-- Release a plot from being targeted by an automated Archaeologist.
local function ReleasePlot( iPlot, iPlayer )
	m_Plot = m_Plots:get( iPlot, iPlayer );
	if m_Plot then 
		m_Plot:setTargeted( false ); -- Set plot to untargeted.
		m_Plots:save( m_Plot ); -- Save the data back to the list.
		--Debug( "Released Plot ( x=" .. m_Plot.plot_data:GetX() .. " ; y=" .. m_Plot.plot_data:GetY() .. " ) from being targeted by player "  .. iPlayer );
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
-- -- Sets an archaeologist in the game to not automated.
local function StopAutomateArchaeologist( unit )
	m_Archaeologist = m_Archaeologists:get( unit );
	if m_Archaeologist then 
		if m_Archaeologist.isAutomated then
			m_Archaeologist:setAutomated( false ); -- Set archaeologist to not automated.
			m_Archaeologist.ID = unit:GetID(); -- Refresh unit ID
			m_Archaeologist.unit_data = unit; -- Refresh unit data.
			m_Archaeologist:cancel(); -- Cancel anything the Archaeologist is doing.
			m_Archaeologist.has_error = false;
			m_Archaeologists:save( m_Archaeologist ); -- Save the data back to the list.
			ReleasePlot( m_Archaeologist.targetPlot, m_Archaeologist:getOwner() ); -- Release the plot from the Archaeologist's target.
			Debug( "Stopped Automation for Archaeologist (" .. m_Archaeologist.ID .. ")." );
		else Error( "Attempt to stop Archaeologist automation for a Archaeologist that is already not automated." ); end
	else Error( "Nil data for m_Plot entry when entering function StopAutomateArchaeologist." ); end
end


--======================================================================================================
-- OBJECT CLASSES AND METHODS
--======================================================================================================

---[[
-- TargetPlot Object Class
local TargetPlotClass = { 
	ID = nil; -- The plot's ID for this game.
	isTargeted = true; -- Is this plot currently targeted by a Archaeologist?
	byPlayer = -1; -- the player currently targeting this plot
	x = 0;
	y = 0;
	plot_data = nil;
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
--]]

--------------------------------------------------------------------------------------------------------
-- Returns true if plotA is adjacent to plotB and improvementA and improvementB are the same.
local function WasPreviousActionSuccessful( action, plot, resource )
	if action and plot and plot.GetX then
		local plot_resource = plot:GetResourceType();
		if action == "ARTIFACT" then 
			if plot_resource < 0 then return true; end
		elseif action == "EXCAVATE" then 
			if plot_resource < 0 then return true; end
		end
		return false;
	else
		return true; -- nil action or plot data for previous action input. Just return true.
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


-- Archaeologist Object Class
local ArchaeologistClass = {
	ID = nil; -- The archaeologist's unit ID for this game.
	owner = -1;
	unit_data = nil; -- Unit data for this Archaeologist.
	isAutomated = true; -- If this archaeologist is currently automated.
	targetPlot = nil; -- The plot this archaeologist is currently targeting.
	previousPlot = nil;
	distanceToTarget = 0; -- The distance in tiles to the Archaeologist's current target.
	queuedAction = "none"; -- The type of action that the Archaeologist is trying to perform.
	previousAction = "SLEEP"; -- Stores action the Archaeologist last attempted to perform.
	resource = nil; -- The resource this Archaeologist is trying to improve.
	previousResource = nil;
	has_error = false; -- Error flag
};
function ArchaeologistClass:x() 
	if self and self.unit_data then 
		local unit = UnitManager.GetUnit( self:getOwner(), self.unit_data:GetID() );
		if unit then return unit:GetX(); else return 0; end
	else return 0; end 
end
function ArchaeologistClass:y() 
	if self and self.unit_data then 
		local unit = UnitManager.GetUnit( self:getOwner(), self.unit_data:GetID() );
		if unit then return unit:GetY(); else return 0; end
	else return 0; end
end
function ArchaeologistClass:getOwner() 
	-- return UnitManager.GetUnit( self.unit_data:GetOwner(), self.unit_data:GetID() ):GetOwner(); 
	local unit = UnitManager.GetUnit( self.unit_data:GetOwner(), self.unit_data:GetID() );
	if unit then self.owner = unit:GetOwner(); return unit:GetOwner(); else return -1; end
end
 -- Sets this Archaeologist object's automation.
function ArchaeologistClass:setAutomated( automated:boolean ) self.isAutomated = automated; end
 -- Sets this Archaeologist object's target plot.
function ArchaeologistClass:setTargetPlot( target ) self.targetPlot = target; end
-- Archaeologist targets the plot it is on.
function ArchaeologistClass:targetSelf()
	self:setTargetPlot( Map.GetPlot( self:x(), self:y() ) );
end
-- Resets Archaeologist action
function ArchaeologistClass:resetAction()
	if self.targetPlot then ReleasePlot( self.targetPlot ); end
	self.targetPlot = nil; -- The plot this archeaologist is currently targeting.
	self.distanceToTarget = 0; -- The distance in tiles to the Archaeologist's current target.
	self.queuedAction = "none"; -- The type of action that the Archaeologist is trying to perform.
	self.resource = nil; -- The resource this Archaeologist is trying to excavate.
	self.has_error = false; -- Error flag
end
-- Copys and overwrites action data in from another object
function ArchaeologistClass:getActionObject()
	return {
		targetPlot = self.targetPlot,
		action_type = self.queuedAction,
		distanceToTarget = self.distanceToTarget or 0,
		resource = self.resource
	};
end
-- Copys and overwrites action data in from another object
function ArchaeologistClass:setAction( action )
	if not action.targetPlot then 
		Error( "ArchaeologistClass:setAction(): Attempt to set Archaeologist action with no target plot." );
		return;
	end
	self:resetAction();
	self.targetPlot = action.targetPlot;
	self.queuedAction = action.queuedAction or "none";
	self.distanceToTarget = action.distanceToTarget or 0;
	self.resource = action.resource;
end
-- Resets Archaeologist action
function ArchaeologistClass:resetPreviousAction()
	self.previousAction = "SLEEP"; -- Stores action the Archaeologist last attempted to perform.
	self.targetPlot = nil;
	self.resource = nil;
end
-- Returns true if this archaeologist has reached its target plot.
function ArchaeologistClass:hasReachedTarget()
	local hasReachedTarget = false;
	if self and self.isAutomated then 
		if self.targetPlot then 
			if self.targetPlot:GetX() == self:x() and self.targetPlot:GetY() == self:y() then hasReachedTarget = true; end
		else Error( "Nil target plot data when using Archaeologist's HasReachedTargetPlot." ); end
	else Error( "Invalid object data when using Archaeologist's HasReachedTargetPlot." ); end
	return hasReachedTarget;
end

-- Commands the archaeologist to cancel whatever it is doing.
function ArchaeologistClass:cancel()
	if not self then Error( "Nil object data when using Archaeologist's Cancel." ); return; end
	local unit = UnitManager.GetUnit( self:getOwner(), self.ID );
	UnitManager.RequestCommand( unit, UNIT_COMMANDS["UNITCOMMAND_CANCEL"].HASH );
	UnitManager.RequestCommand( unit, UNIT_COMMANDS["UNITCOMMAND_WAKE"].HASH ); -- Wake the unit.
end

-- Commands the archaeologist to sleep.
function ArchaeologistClass:excavate()
	if not self then Error( "Nil object data when using Archaeologist's Excavate." ); return; end
	local unit = UnitManager.GetUnit( self:getOwner(), self.ID );
	UnitManager.RequestOperation( unit, UNIT_OPS["UNITOPERATION_EXCAVATE"].HASH );
	Debug( Locale.Lookup( PlayerConfigurations[self:getOwner()]:GetLeaderTypeName() ) .. " commanded Archaeologist " .. 
	"(" .. self.ID .. ") to excavate an artifact at x=" .. unit:GetX() .. " ; y=" .. unit:GetY());
end

-- Commands the archaeologist to sleep.
function ArchaeologistClass:sleep()
	if not self then Error( "Nil object data when using Archaeologist's Sleep." ); return; end
	local unit = UnitManager.GetUnit( self:getOwner(), self.ID );
	UnitManager.RequestOperation( unit, UNIT_OPS["UNITOPERATION_SLEEP"].HASH );
	Debug( Locale.Lookup( PlayerConfigurations[self:getOwner()]:GetLeaderTypeName() ) .. " commanded Archaeologist " .. 
	"(" .. self.ID .. ") to sleep on Plot: x = " .. self:x() .. " , y = " .. self:y() );
end

 -- Commands this archaeologist to move to a plot coordinate.
function ArchaeologistClass:moveTo( new_x, new_y )
	if not self then Error( "Nil object data when using Archaeologist's MoveTo." ); return; end
	if not ( new_x or new_y ) then Error( "Nil x and y coordinates passed to Archaeologist's MoveTo." ); return; end
	---[[
	local tParameters = {};
	tParameters[UnitOperationTypes.PARAM_X] = new_x;
	tParameters[UnitOperationTypes.PARAM_Y] = new_y;
	local unit = UnitManager.GetUnit( self:getOwner(), self.ID );
	UnitManager.RequestOperation( unit, UNIT_OPS["UNITOPERATION_MOVE_TO"].HASH, tParameters );
	--]]
	-- MoveUnitToPlot( unit, move_x, move_y );
	--[[
	Debug( Locale.Lookup( PlayerConfigurations[self:getOwner()]:GetLeaderTypeName() ) .. " commanded Archaeologist " .. 
	" (" .. self.ID .. ") to move from plot x=" .. self:x() .. 
		" , y = " .. self:y() .. " to new plot x=" .. new_x .. " ; y=" .. new_y );
	--]]
end

 -- Commands this archaeologist to perform its queued action
function ArchaeologistClass:performAction()
	-- Debug("Telling this unit to perform its queued action.");
	if self.queuedAction then -- Attempt to perform the Archaeologist's queued action.
		UnitManager.RequestCommand( UnitManager.GetUnit( self:getOwner(), self.ID ), UNIT_COMMANDS["UNITCOMMAND_WAKE"].HASH ); -- Wake the unit.
		local actionTaken = true;
		-- Do a check if previous action was succesful. Can't check right after action taken as a UI request is sent, code isn't run right away.
		-- This is necessary due to possible bugs in action switching after movement end.
		if IsSameAction( self.queuedAction, self.previousAction, self.targetPlot, self.previousPlot ) == false then
			if WasPreviousActionSuccessful( self.previousAction, self.previousPlot, self.previousResource ) == false then
				if self.has_error == false then -- Only switch back to previous action if it didn't create an error.
					Debug( "Previous action for Archaeologist (" .. self.ID .. ") was unsuccessful. Assigning to previous action." );
					self.queuedAction = self.previousAction;
					self.targetPlot = self.previousPlot;
					self.resource = self.previousResource;
					self:realizeAction();
					return; -- Don't proceed farther into function.
				end
			end
		end
		self.has_error = false;
		if self.queuedAction == "ARTIFACT" then self:excavate();
		elseif self.queuedAction == "EXCAVATE" then self:excavate();
		else
			actionTaken = false;
			self:sleep(); -- Otherwise, put the archaeologist to sleep for this turn.
		end
		if actionTaken then 
			self.previousAction = self.queuedAction;
			self.previousPlot = self.targetPlot;
			self.previousResource = self.resource;
			self:getActionSwitch(); -- Get a new action (can't check if how many excavations archaeologist has left).
			if self.targetPlot:GetIndex() ~= self.previousPlot:GetIndex() then 
				self:realizeAction(); -- Tell unit to move to next action (for UI visibility) if it is on a different plot.
			end
		else 
			self:resetPreviousAction();
			self:resetAction();
		end 
	else
		Debug("Nil queued action data for this archaeologist.");
		self:resetAction();
		self:sleep();
	end
end

-- Returns true if this Archaeologist unit has more than 0 moves remaining.
function ArchaeologistClass:hasMovementLeft()
	local unit = UnitManager.GetUnit( self:getOwner(), self.ID );
	if unit:GetMovesRemaining() > 0 then return true; else return false; end
end

 -- Gives this archaeologist something to do based on its action.
function ArchaeologistClass:realizeAction()
	if not self then Error( "Nil object data when using Archaeologist's RealizeAction." ); return; end
	if not self.targetPlot then Error( "Nil target plot data when using Archaeologist's RealizeAction." ); return; end
	if self:hasReachedTarget() and self:hasMovementLeft() then -- Do something if the archaeologist has reached its target.
		self:performAction();
	else -- Otherwise move it towards its target.
		self:moveTo( self.targetPlot:GetX(), self.targetPlot:GetY() );
	end
end

-- Returns the unit's current status.
function ArchaeologistClass:GetStatus()
	if not self then Error( "Nil object data when using Archaeologist's GetStatus." ); return; end
	return GetStatusString( self.queuedAction );
end

-- Object Constructor
function ArchaeologistClass:new ( o )
	o = o or {};
	setmetatable( o, self );
	self.__index = self;
	return o;
end


--======================================================================================================
-- FUNCTIONS
--======================================================================================================

--------------------------------------------------------------------------------------------------------
-- Sets a plot as being targeted by an automated Archaeologist.
local function TargetPlot( iPlot, iPlayer )
	m_Plot = m_Plots:get( iPlot, iPlayer );  -- Get any existing object data for this plot.
	if not m_Plot then -- Make a new TargetPlot object and add it to the list.
		m_Plots:add( 
			TargetPlotClass:new{
				ID = iPlot:GetIndex();
				byPlayer = iPlayer;
				x = iPlot:GetX();
				y = iPlot:GetY();
				plot_data = Map.GetPlotByIndex( iPlot:GetIndex() );
			}
		 );
		--Debug( "Added a new TargetPlot ( x=" .. iPlot:GetX() .. " ; y=" .. iPlot:GetY() .. " ) object to the list for player " .. iPlayer );
	else 
		m_Plot:setTargeted( true ); -- If it already exists, then set it to Targeted.
		m_Plot.plot_data = Map.GetPlotByIndex( iPlot:GetIndex() );
		m_Plots:save( m_Plot ); -- Save the data back to the list.
		--Debug( "Set an existing TargetPlot ( x=" .. m_Plot.plot_data:GetX() .. " ; y=" .. m_Plot.plot_data:GetY() .. " ) as targeted for player " .. iPlayer  );
	end
end

--------------------------------------------------------------------------------------------------------
-- Sets an archaeologist in the game to automated.
local function AutomateArchaeologist( unit )
	m_Archaeologist = m_Archaeologists:get( unit ); -- Get any existing object data for this archaeologist.
	if not m_Archaeologist then -- Make a new Archaeologist object and add it to the list.
		m_Archaeologist = 
			ArchaeologistClass:new{ 
				ID = unit:GetID();
				owner = unit:GetOwner();
				unit_data = unit;
			};
		m_Archaeologist:getAction(); -- Find something for the archaeologist to do.
		--TargetPlot( m_Archaeologist.targetPlot, m_Archaeologist:getOwner() );
		m_Archaeologist:realizeAction(); -- Have the archaeologist do something right away.
		m_Archaeologists:add( m_Archaeologist ); -- Add Archaeologist to the list.
		Debug( "Added a new Archaeologist (" .. m_Archaeologist.ID .. ") object to the list." );
	else
		m_Archaeologist:setAutomated( true ); -- If it already exists, then set it to Automated.
		m_Archaeologist.ID = unit:GetID(); -- Refresh unit ID
		m_Archaeologist.unit_data = unit; -- Refresh unit data.
		m_Archaeologist:getAction(); -- Find something for the archaeologist to do.
		--TargetPlot( m_Archaeologist.targetPlot, m_Archaeologist:getOwner() );
		m_Archaeologist:realizeAction(); -- Have the archaeologist do something right away.
		m_Archaeologists:save( m_Archaeologist ); -- Save the data back to the list.
		Debug( "Set an existing Archaeologist (" .. m_Archaeologist.ID .. ") to automated." );
	end
end

--------------------------------------------------------------------------------------------------------
-- Returns true if an automated Archaeologist is targeting this plot.
local function IsPlotTargetedByPlayer( iPlot, iPlayer )
	m_Plot = m_Plots:get( iPlot, iPlayer );
	if m_Plot then 
		return m_Plot.isTargeted;
	else 
		return false;
	end
end

--------------------------------------------------------------------------------------------------------
-- Returns true if the given unit is an automated Archaeologist
local function IsArchaeologistAutomated( pUnit )
	m_Archaeologist = m_Archaeologists:get( pUnit );
	if m_Archaeologist then 
		return m_Archaeologist.isAutomated;
	else 
		return false;
	end
end

--------------------------------------------------------------------------------------------------------
-- Returns string status of the given unit if it is an automated Archaeologist.
local function GetArchaeologistStatus( pUnit )
	m_Archaeologist = m_Archaeologists:get( pUnit );
	if m_Archaeologist and m_Archaeologist.isAutomated then 
		return m_Archaeologist:GetStatus();
	else 
		return "";
	end
end

--------------------------------------------------------------------------------------------------------
-- Bans a specific action for a plot.
local function BanPlotAction( aPlot, anAction )
	if aPlot and aPlot.GetX then
		if ( anAction ~= nil ) and ( anAction ~= "none" ) and ( anAction ~= "sleep" ) and ( anAction ~= "SLEEP" ) then
			table.insert( m_BannedPlotActions.X, aPlot:GetX() );
			table.insert( m_BannedPlotActions.Y, aPlot:GetY() );
			table.insert( m_BannedPlotActions.Actions, anAction );
			Debug( "BANNED action: " .. anAction .. " on plot: x=" .. aPlot:GetX() .. "; y=" .. aPlot:GetY() .. 
				" for automated Archaeologists for this session." );
		else
			Error( "Attempted to ban nil/'none'/sleep action. No action was banned for automated Archaeologists." );
		end
	else
		Error( "Attempted to ban action on nil plot. No action was banned for automated Archaeologists." );
	end
end

--------------------------------------------------------------------------------------------------------
-- Returns true if the given action on the given plot is banned based on the black list.
local function IsPlotActionBanned( aPlot, anAction )
	for key, action in ipairs( m_BannedPlotActions.Actions ) do
		if action == anAction then -- action match
			local x = m_BannedPlotActions.X;
			local y = m_BannedPlotActions.Y;
			if ( ( x[key] == aPlot:GetX() ) and ( y[key] == aPlot:GetY() ) ) then -- Plot x and y coords match
				return true; -- The given plot and action match this key entry in the table. Action for this plot is banned.
			end
		end
	end
	return false;
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
-- Get valid improvements for a plot given a resource.
local function GetActionsForPlot_Resource( Actions, aPlot, iPlayer )
	if iPlayer then m_Player = Players[iPlayer]; end
	--Debug_AllActions( "Entered function: GetActionsForPlot_Resource" );
	if not m_Player then Error( "Nil player data passed to function GetActionsForPlot_Resource." ); return Actions; end
	if not Actions then Error( "Nil valid Improvement table passed to function GetActionsForPlot_Resource." ); return Actions; end
	if not aPlot then Error( "Nil plot data passed to function GetActionsForPlot_Resource." ); return Actions; end
	local improvement = aPlot:GetImprovementType();
	local resource = aPlot:GetResourceType();
	
	if resource ~= -1 and improvement == -1 then -- There is a resource and there is no improvement on plot.
		local resourceObject = IsResourceVisibleForPlayer( resource, iPlayer );
		if not resourceObject then -- return nothing because the player can't see this resource.
			-- Debug_AllActions( "Resource is not currently visible to player. Returning..." );
			return Actions;
		else
			if resourceObject.TYPE == "ARTIFACT" then -- Return excavate action for this archaeologist if resource is an artifact.
				table.insert( Actions, resourceObject );
			end
		end
	end

	return Actions;
end

--------------------------------------------------------------------------------------------------------
local m_ArchaeologistActionClass = {
	action_type = "";
	target_plot = {};
	turnDistance = BAD_DISTANCE;
	distance = BAD_DISTANCE;
	resource = nil;
};
--------------------------------------------------------------------------------------------------------
function m_ArchaeologistActionClass:new ( o )
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
		local district = aPlot:GetDistrictType(); 
		if district == -1 then -- Plot has no district
			if aPlot:IsMountain() == false then -- Plot has no mountain
				-- Plot is valid, has no district, and is not a mountain. Print some debug info.
				local improvement = aPlot:GetImprovementType();
				local resource = aPlot:GetResourceType();
				--if terrain then Debug_AllActions("Plot has terrain: " .. Locale.Lookup( GameInfo.Terrains[terrain].Name ) ); end
				if improvement == -1 then -- Plot has no improvement
					if resource == -1 then -- Plot has no improvement and no resource
						-- Don't do anything if there is no resource
					else -- Plot has no improvement and has a resource
						-- Debug_AllActions( "Plot has resource type: " .. Locale.Lookup( GameInfo.Resources[resource].Name ) );
						validActions = GetActionsForPlot_Resource( validActions, aPlot, iPlayer );
						if validActions then
							for key, anAction in pairs( validActions ) do
								actionO = m_ArchaeologistActionClass:new{
									action_type = anAction.TYPE;
									target_plot = aPlot;
									resource = anAction;
								};
								table.insert( returnedActionTable, actionO );
							end
						end
					end
				else -- Plot has an improvement
						-- Don't try to do anything if there is an improvement.
				end
			else 
				--Debug_AllActions( "Cannot build on Plot ID: " .. aPlot:GetIndex() .. " (x=" .. aPlot:GetX() .. 
				--	" ; y=" .. aPlot:GetY() .. ") because there is a Mountain." );
			end
		else 
			--Debug_AllActions( "Cannot build on Plot ID: " .. aPlot:GetIndex() .. " (x=" .. aPlot:GetX() .. 
			--	" ; y=" .. aPlot:GetY() .. ") because plot has DistrictType: " .. Locale.Lookup( GameInfo.Districts[district].Name ) );
		end
	else Error( "Nil plot data in function parameter for PlotGetValidActions." ); end
	return returnedActionTable;
end

--------------------------------------------------------------------------------------------------------
-- Returns the distance between two plots.
local function GetDistance( firstPlot, secondPlot )
	local distance = BAD_DISTANCE;
	if firstPlot and secondPlot and firstPlot.GetX and secondPlot.GetX then -- Check for good data.
		distance = Map.GetPlotDistance( firstPlot:GetX(), firstPlot:GetY(), secondPlot:GetX(), secondPlot:GetY() );
	end
	return distance;
end

--------------------------------------------------------------------------------------------------------
-- Returns the number of turns it will take for the given unit to move to the plot.
local function GetTurnDistance( unit, plot )
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
		if unit.ID then -- Object was given.
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
		return nTurnCount;
	else
		-- No path; is it a bad path or is the player have the cursor on the same hex as the unit?
		local startPlotId :number = Map.GetPlot(unit:GetX(),unit:GetY()):GetIndex();
		if startPlotId == endPlotId then				
			return nTurnCount; -- unit is truly 0 turns away from this plot.
		else
			return BAD_DISTANCE;
		end
	end
	return nTurnCount;
end

--------------------------------------------------------------------------------------------------------
-- Returns true if the given player has built the given building.
local function HasBuilding( iPlayer, building )
	local hasBuilding = false;
	local cities = Players[iPlayer]:GetCities();
	for _, aCity in cities:Members() do
		local buildings = aCity:GetBuildings();
		--if buildings:HasBuilding( building ) or buildings:HasBuilding( GameInfo.Buildings[building].Index ) then 
		if buildings:HasBuilding( GameInfo.Buildings[building].Index ) then
			hasBuilding = true;
			break;
		end
	end
	return hasBuilding;
end

--------------------------------------------------------------------------------------------------------
-- Returns true if the given unit is a civilian
local function IsCivilian( Unit )
	local isCivilian = false;
	local unitType = Unit:GetUnitType();
	if unitType == GameInfo.Units["UNIT_SETTLER"].Index then isCivilian = true;
	elseif unitType == GameInfo.Units["UNIT_ARCHAEOLOGIST"].Index then isCivilian = true;
	elseif unitType == GameInfo.Units["UNIT_ARCHAEOLOGIST"].Index then isCivilian = true;
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
	elseif GameInfo.Units["UNIT_GURU"] and unitType == GameInfo.Units["UNIT_GURU"].Index then isReligious = true;
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
-- Returns true if a Archaeologist can move here to perform an action.
local function CanMoveToPlot( unit, aPlot )
	if ( not unit ) or ( not aPlot ) then return false; end
	local canMoveToPlot = true;
	if aPlot:IsNationalPark() then -- Don't try to excavate in National Park.
		Debug_AllActions( "Plot x=" .. aPlot:GetX() .. " ; y=" .. aPlot:GetY() .. " is in a National Park! Archaeologist cannot excavate here." );
		return false; 
	end 
	local resource = aPlot:GetResourceType();
	if resource ~= GameInfo.Resources["RESOURCE_SHIPWRECK"].Index and 
		resource ~= GameInfo.Resources["RESOURCE_ANTIQUITY_SITE"].Index then
		Debug_AllActions( "Plot x=" .. aPlot:GetX() .. " ; y=" .. aPlot:GetY() .. " has no artifact! Archaeologist cannot excavate here." );
		return false;
	end
	local improvement = aPlot:GetImprovementType();
	if improvement ~= -1 then -- Plot has an improvement, can't build here anymore.
		Debug_AllActions( "Plot x=" .. aPlot:GetX() .. " ; y=" .. aPlot:GetY() .. " has an improvement! Archaeologist cannot excavate here." );
		return false;
	end
	local district = aPlot:GetDistrictType();
	if district ~= -1 then -- Plot has a district, can't build here anymore.
		Debug_AllActions( "Plot x=" .. aPlot:GetX() .. " ; y=" .. aPlot:GetY() .. " contains a district! Archaeologist cannot excavate here." );
		return false;
	end
	local units = Units.GetUnitsInPlot( aPlot );
	for _, aUnit in pairs( units ) do
		if aUnit:GetID() ~= unit:GetID() then -- Its fine if the unit in the plot is itself.
			if ( not IsTrader( unit ) ) and ( not IsSpy( unit ) ) then -- Traders and spies do not block movement.
				-- Unit in plot is owned by another player.
				if aUnit:GetOwner() ~= unit:GetOwner() then  
					-- Fall 2017 patch is installed, so it also doesn't matter if the unit is religious.
					if b_Fall2017Patch_Installed and ( not IsReligious( unit ) ) then
						Debug_AllActions( "Plot x=" .. aPlot:GetX() .. " ; y=" .. aPlot:GetY() .. 
							" contains a non-religious, non-trader, non-spy unit owned by another player! Archaeologist cannot move here." );
						return false;
					elseif ( not b_Fall2017Patch_Installed ) then -- Fall 2017 patch is not installed, religious units will block movement.
						Debug_AllActions( "Plot x=" .. aPlot:GetX() .. " ; y=" .. aPlot:GetY() .. 
							" contains a non-trader, non-spy unit owned by another player! Archaeologist cannot move here." );
						return false;
					end
				else -- Unit is friendly, owned by the same player. Check if it is another civilian that will block movement.
					-- Fall 2017 patch is installed, so friendly religious units will not block movement.
					if b_Fall2017Patch_Installed and IsCivilian( aUnit ) then 
						Debug_AllActions( "Plot x=" .. aPlot:GetX() .. " ; y=" .. aPlot:GetY() .. 
							" contains a friendly civilian! Archaeologist cannot move here." );
						return false;
					-- Fall 2017 patch is not installed, friendly civilian or religious units will block movement.
					elseif ( not b_Fall2017Patch_Installed ) and ( IsCivilian( aUnit ) or IsReligious( unit ) ) then
						Debug_AllActions( "Plot x=" .. aPlot:GetX() .. " ; y=" .. aPlot:GetY() .. 
							" contains a friendly civilian or religious unit! Archaeologist cannot move here." );
						return false;
					end
				end
			end
		end
	end
	-- Check if user wants archaeologists to know where all artifacts are and explore. If not, check if plot is revealed for player.
	if not b_ArchaeologistsExplore then 
		local isPathInFog = false;
		local pPlayerVis = PlayersVisibility[unit:GetOwner()];
		if pPlayerVis ~= nil then
			-- isPathInFog = not pPlayerVis:IsVisible( aPlot:GetIndex() );
			isPathInFog = not pPlayerVis:IsRevealed( aPlot:GetIndex() );
		end
		if isPathInFog then return false; end
	end
	-- Don't move to a spot with a military unit if unit is in a formation with military unit
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
							" Archaeologist cannot move here since it is currently in formation with another military land unit." );
						return false; -- Unit in target plot is also a military land unit with a different ID, can't move here while in formation.
					end
				end
			end
		end
	end
	-- Check if in borders of other player and if Archaeologist can enter.
	if aPlot:GetOwner() == -1 or aPlot:GetOwner() == unit:GetOwner() then -- Plot is unowned or owned by player.
		-- nothing here for now.
	elseif aPlot:GetOwner() ~= unit:GetOwner() then -- Plot is owned by another player.
		if not b_ArchaeologistsExcavateInOtherBorders then return false; end -- Player has disabled excavating in other player's territory. Return false.
		-- Check for open borders with player
		local unitOwner = Players[unit:GetOwner()];
		local hasOpenBorders = unitOwner:GetDiplomacy():HasOpenBordersFrom( aPlot:GetOwner() );
		-- Debug( "hasOpenBorders returned value: " .. tostring( hasOpenBorders ) );
		if ( not hasOpenBorders ) and -- Unit owner does not have open borders from plot owner.
			( not HasBuilding( unit:GetOwner(), "BUILDING_TERRACOTTA_ARMY" ) ) -- Unit owner has not built Terracotta Army.
			then 
			Debug_AllActions( "Plot is owned by " .. Locale.Lookup( PlayerConfigurations[aPlot:GetOwner()]:GetLeaderTypeName() ) ..
			", archaeologist owned by " .. Locale.Lookup( PlayerConfigurations[unit:GetOwner()]:GetLeaderTypeName() ) .. 
			" cannot enter this plot to excavate." );
			return false;
		elseif ( not hasOpenBorders ) and HasBuilding( unit:GetOwner(), "BUILDING_TERRACOTTA_ARMY" ) then -- Unit owner has built Terracotta Army.
			Debug_AllActions( Locale.Lookup( PlayerConfigurations[unit:GetOwner()]:GetLeaderTypeName() ) .. 
			" has built Terracotta Army, and their archaeologist can enter plot owned by " .. 
			Locale.Lookup( PlayerConfigurations[aPlot:GetOwner()]:GetLeaderTypeName() ) .. " to excavate.");
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
					": UnitManager.CanStartOperation query returned false, Archaeologist cannot move here." );
				return false;
			end
		end
	end
	return canMoveToPlot;
end

--------------------------------------------------------------------------------------------------------
-- Populates the possible new actions a Archaeologist can take.
local function PopulateArchaeologistPossiblePlots( anArchaeologist )
	local Actions = {};
	
	local owner = anArchaeologist:getOwner();
	local startPlot = Map.GetPlot( anArchaeologist:x(), anArchaeologist:y() );
	for x = 0, ( map_width - 1 ) do
	for y = 0, ( map_height - 1 ) do	
		local aPlot = Map.GetPlot( x, y );
		if aPlot and ( not IsPlotTargetedByPlayer( aPlot, owner ) ) then -- Only proceed if this plot is not targeted by another automated Archaeologist.
			if CanMoveToPlot( UnitManager.GetUnit( owner, anArchaeologist.ID ), aPlot ) then -- Only proceed if the Archaeologist can move here.
				local actions = PlotGetValidActions( aPlot ); -- Get all valid actions for this plot.
				if actions then
					local bestKey = 1;
					local action = actions[ bestKey ];
					if action and action.action_type then
						if not IsPlotActionBanned( aPlot, action.action_type ) then -- Check if the action on this plot has been black-listed by Moderator.
							local action = actions[ bestKey ];
							local actionO = m_ArchaeologistActionClass:new{
								action_type = action.action_type;
								turnDistance = GetTurnDistance( anArchaeologist, aPlot );
								distance = GetDistance( aPlot, Map.GetPlot( anArchaeologist:x(), anArchaeologist:y() ) );
								target_plot = aPlot;
								resource = action.resource;
							};
							table.insert( Actions, actionO );
						end
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
-- Picks an action for a Archaeologist to take based on distance. Returns the same structure but with only one element in each column.
local function GetBestPossiblePlot( actions, archaeologistID )
	Debug_Actions("-------------------------------------------------------------------------------------------------");
	Debug_Actions( "Calculating next move by scoring possible plot actions:" );
	local scores = {};
	local Action = {};
	-- Give each plot a base score based on the Scoring table and distance away from Archaeologist.
	for a_key, action in ipairs( actions ) do
		local finalScore = BAD_SCORE;
		for key, aScore in pairs( m_Scoring ) do
			if key == action.action_type then 
				local scale = -1;
				local value = action.distance;
				if action.turnDistance < BAD_DISTANCE then value = value + action.turnDistance; end
				finalScore = aScore + ( scale * value );
				Debug_Actions( action.action_type .. " received a final score of " .. finalScore .. 
					" (" .. action.distance .. " tiles away at x=" .. action.target_plot:GetX() .. "; y=" .. action.target_plot:GetY() .. ")." );
			end
		end
		table.insert( scores, finalScore );
	end
	Debug_Actions("Finished scoring all un-targeted plots.");
	Debug_Actions("-------------------------------------------------------------------------------------------------");
	local bestKey = 1;
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
		if archaeologistID == nil then archaeologistID = ""; else archaeologistID = tostring( archaeologistID ); end
		Debug("Archaeologist (" .. archaeologistID .. ") found that action type: " .. action.action_type ..
		" on plot: x=" .. newPlot:GetX() .. " ; y=" .. newPlot:GetY() .. " at a distance of " .. action.distance .. 
		" tiles away was the best choice.");
		Action = action;
	else
		Action = nil;
		--Debug("No action with a score higher than BAD_SCORE was determined to exist in the given table.");
	end

	return Action;
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
		if o.TECH and GameInfo.Technologies[o.TECH] then -- Check for required tech.
			if m_PlayerTechs:HasTech( GameInfo.Technologies[o.TECH].Index ) then 
				if o.CIVIC and GameInfo.Civics[o.CIVIC] then -- Check if a Civic is also required
					if m_PlayerCulture:HasCivic( GameInfo.Civics[o.CIVIC].Index ) then addO = true; end -- Player has both required Tech and Civic.
				else addO = true; end -- Player has required tech and there is no required civic.
			end
		elseif o.CIVIC and GameInfo.Civics[o.CIVIC] then -- No required tech, check for required civic
			if m_PlayerCulture:HasCivic( GameInfo.Civics[o.CIVIC].Index ) then addO = true; end
		else addO = true; end -- No required tech or civic.
		if addO then List[o.NAME] = o; end
	end
	return List;
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
 -- Gets an updated action for the Archaeologist to perform
function ArchaeologistClass:getAction()
	local unit = nil;
	if UnitManager and UnitManager.GetUnit then unit = UnitManager.GetUnit( self:getOwner(), self.ID ); end
	if unit then
		m_Player = Players[self:getOwner()];
		self.resource = nil;
		if self.targetPlot then ReleasePlot( self.targetPlot, self:getOwner() ); end -- Release plot archaeologist is currently targeting because a new target will be obtained.
		local archaeologistActions = PopulateArchaeologistPossiblePlots( self );
		local bestAction = GetBestPossiblePlot( archaeologistActions, self.ID );
		if bestAction then
			if bestAction.target_plot == "SELF" then self:setTargetPlot( Map.GetPlot( unit:GetX(), unit:GetY() ) );
				else self:setTargetPlot( bestAction.target_plot ); end
			if bestAction.turnDistance < BAD_DISTANCE then 
				self.distanceToTarget = bestAction.turnDistance;
			else
				self.distanceToTarget = bestAction.distance;
			end
			self.resource = bestAction.resource;
			self.queuedAction = bestAction.action_type;
		else 
			Debug( "No action found when trying to obtain the best action in player's territory." ); 
			self:resetAction();
			self:targetSelf();
		end
		TargetPlot( self.targetPlot, self:getOwner() ); -- Set this Archaeologist's target plot.
	end
end

--------------------------------------------------------------------------------------------------------
 -- Gets an updated action for the Archaeologist to perform, but doesn't release its current target plot before, so it will switch targets.
function ArchaeologistClass:getActionSwitch()
	local unit = nil;
	if UnitManager and UnitManager.GetUnit then unit = UnitManager.GetUnit( self:getOwner(), self.ID ); end
	if unit then
		m_Player = Players[self:getOwner()];
		self.resource = nil;
		local archaeologistActions = PopulateArchaeologistPossiblePlots( self );
		local bestAction = GetBestPossiblePlot( archaeologistActions, self.ID );
		if bestAction then
			if self.targetPlot then ReleasePlot( self.targetPlot ); end
			if bestAction.target_plot == "SELF" then self:setTargetPlot( Map.GetPlot( unit:GetX(), unit:GetY() ) );
				else self:setTargetPlot( bestAction.target_plot ); end
			if bestAction.turnDistance < BAD_DISTANCE then 
				self.distanceToTarget = bestAction.turnDistance;
			else
				self.distanceToTarget = bestAction.distance;
			end
			self.resource = bestAction.resource;
			self.queuedAction = bestAction.action_type;
		else 
			Debug( "No action found when trying to obtain the best action in player's territory." ); 
			self:resetAction();
			self:targetSelf();
		end
		TargetPlot( self.targetPlot, m_Archaeologist:getOwner() ); -- Set this Archaeologist's target plot.
	end
end

--------------------------------------------------------------------------------------------------------
-- Returns the plot closest to the given archaeologist amongst the given table of plots.
local function GetClosestPlotToArchaeologist( archaeologist, plots )
	local closestPlot = nil;
	local leastDistance = BAD_DISTANCE;
	for _, aPlot in pairs( plots ) do
		local turnDistance = GetTurnDistance( archaeologist, aPlot );		
		if turnDistance < BAD_DISTANCE then
			if turnDistance < leastDistance then
				leastDistance = distance;
				closestPlot = aPlot;
			elseif turnDistance == leastDistance then -- Encountered another plot same number of turns away, check if it is closer in tiles.
				if not closestPlot then
					closestPlot = aPlot;
				else
					local newDistance = GetDistance( aPlot, Map.GetPlot( archaeologist:x(), archaeologist:y() ) ); -- Get the actual tile distance away
					local oldDistance = GetDistance( closestPlot, Map.GetPlot( archaeologist:x(), archaeologist:y() ) );
					if newDistance < oldDistance then -- Actual tile distance is closer, replace with new plot.
						leastDistance = turnDistance;
						closestPlot = aPlot;
					end
				end
			end
		else -- Bad turn data. Go by plot distance alone.
			local newDistance = GetDistance( aPlot, Map.GetPlot( archaeologist:x(), archaeologist:y() ) ); -- Get the actual tile distance away
			if newDistance < leastDistance then
				leastDistance = newDistance;
				closestPlot = aPlot;
			end
		end
	end
	return closestPlot;
end

--------------------------------------------------------------------------------------------------------
-- Returns the plot second closest to the given archaeologist amongst the given table of plots.
local function GetSecondClosestPlotToArchaeologist( archaeologist, plots )
	local closestPlot = nil;
	local secondClosestPlot = nil;
	local leastDistance = BAD_DISTANCE;
	local secondLeastDistance = BAD_DISTANCE;
	for _, aPlot in pairs( plots ) do
		local turnDistance = GetTurnDistance( archaeologist, aPlot );
		if turnDistance < BAD_DISTANCE then
			if turnDistance > leastDistance and turnDistance < secondLeastDistance then
				secondLeastDistance = distance;
				secondClosestPlot = aPlot;
			elseif turnDistance > leastDistance and turnDistance == secondLeastDistance then -- tie for second place for number of turns away.
				local newDistance = GetDistance( aPlot, Map.GetPlot( archaeologist:x(), archaeologist:y() ) );
				local oldDistance = GetDistance( closestPlot, Map.GetPlot( archaeologist:x(), archaeologist:y() ) );
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
				local newDistance = GetDistance( aPlot, Map.GetPlot( archaeologist:x(), archaeologist:y() ) );
				local oldDistance = GetDistance( closestPlot, Map.GetPlot( archaeologist:x(), archaeologist:y() ) );
				if newDistance < oldDistance then -- new plot is closer by actual tile number, replace and shift
					secondLeastDistance = leastDistance;
					secondClosestPlot = closestPlot;
					leastDistance = turnDistance;
					closestPlot = aPlot;
				end
			end
		else -- Bad turn data, use only plot distance.
			local newDistance = GetDistance( aPlot, Map.GetPlot( archaeologist:x(), archaeologist:y() ) );
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
	if o then return o; else return array; end
end


--------------------------------------------------------------------------------------------------------
local AM_TargetPlotClass = {
	old_archaeologist = -1;
	plot = {};
	action = {};
	distance = BAD_DISTANCE;
	id = -1;
	assigned = false;
};
--------------------------------------------------------------------------------------------------------
function AM_TargetPlotClass:new ( o )
	o = o or {};
	setmetatable( o, self );
	self.__index = self;
	return o;
end
--------------------------------------------------------------------------------------------------------
local AM_ArchaeologistClass = {
	id = -1;
	owner = -1;
	targetPlot = {};
	turnDistance = BAD_DISTANCE;
	distance = BAD_DISTANCE;
	assigned = false;
};
--------------------------------------------------------------------------------------------------------
function AM_ArchaeologistClass:new ( o )
	o = o or {};
	setmetatable( o, self );
	self.__index = self;
	return o;
end

--------------------------------------------------------------------------------------------------------
-- Return a table of archaeologists that aren't currently assigned.
local function AM_GetAvailableArchaeologists( archaeologists )
	local available_archaeologists = {};
	for _j, archaeologist in ipairs( archaeologists ) do
		if archaeologist.assigned == false then -- eligible for targeting.
			local unit = nil;
			if UnitManager and UnitManager.GetUnit then unit = UnitManager.GetUnit( archaeologist.owner, archaeologist.id ); end
			if unit and GameInfo.Units[unit:GetUnitType()].Index == GameInfo.Units["UNIT_ARCHAEOLOGIST"].Index then
				-- archaeologist.turnDistance = GetTurnDistance( unit, plot );
				-- archaeologist.distance = GetDistance( plot, Map.GetPlot( unit:GetX(), unit:GetY() ) );
				table.insert( available_archaeologists, archaeologist );
			end
		end
	end
	return available_archaeologists;
end

--------------------------------------------------------------------------------------------------------
-- Populate plot objects with closest archaeologist ids
local function AM_PopulateClosestArchaeologistsForPlots( plots, archaeologists, idx )
	local idx = idx or 1;
	local available_archaeologists = AM_GetAvailableArchaeologists( archaeologists );
	for i = idx, #plots do -- Go through plots
		local o = plots[ i ];
		local leastDistance = BAD_DISTANCE;
		local bestID = -1;
		local bestPlot = nil;
		for _, archaeologist in ipairs( available_archaeologists ) do -- Go through unassigned archaeologists.
			local turnDistance = BAD_DISTANCE;
			local unit = nil;
			if UnitManager and UnitManager.GetUnit then unit = UnitManager.GetUnit( archaeologist.owner, archaeologist.id ); end
			if unit then
				turnDistance = GetTurnDistance( unit, o.plot );
				if turnDistance < BAD_DISTANCE then
					if turnDistance < leastDistance then -- this archaeologist is closer by number of turns.
						leastDistance = turnDistance;
						bestID = archaeologist.id;
					elseif turnDistance == leastDistance then -- equal number of turns away.
						local oldUnit = UnitManager.GetUnit( archaeologist.owner, bestID );
						local newDistance = GetDistance( o.plot, Map.GetPlot( unit:GetX(), unit:GetY() ) );
						local oldDistance = GetDistance( o.plot, Map.GetPlot( oldUnit:GetX(), oldUnit:GetY() ) );
						if newDistance < oldDistance then -- new archaeologist is closer by actual number of plots, replace.
							leastDistance = turnDistance;
							bestID = archaeologist.id;
						end
					end
				else -- Bad turn data, go only by plot distance.
					local newDistance = GetDistance( o.plot, Map.GetPlot( unit:GetX(), unit:GetY() ) );
					if newDistance < leastDistance then
						leastDistance = newDistance;
						bestID = archaeologist.id;
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
-- Sorts a table of plots based on least plot distance and turn distance away from assigned archaeologist.
local function AM_SortPlots( iPlayer, plots, idx )
	local idx = idx or 1;
	local turn_distances = {};
	local distances = {};
	local useTurnDistance = true;
	for i = idx, #plots do -- Go through plots
		local o = plots[ i ];
		local unit = nil;
		if UnitManager and UnitManager.GetUnit then unit = UnitManager.GetUnit( iPlayer, o.id ); end
		if unit then
			local turnDistance = GetTurnDistance( unit, o.plot );
			if turnDistance >= BAD_DISTANCE then useTurnDistance = false; end
			table.insert( turn_distances, turnDistance );
			table.insert( distances, GetDistance( o.plot, Map.GetPlot( unit:GetX(), unit:GetY() ) ) );
		end
	end
	-- The Merge Sort algorithm is stable, so after sorting by least plot distance, that order plots will be preserved for plots with the same move turns.
	plots = MergeSort( distances, plots, idx ); -- Sort by plot distance first.
	if useTurnDistance == true then
		plots = MergeSort( turn_distances, plots, idx ); -- Then sory by turns away
	end
	if not plots then plots = {}; end
	return plots;
end

--------------------------------------------------------------------------------------------------------
-- Returns the archaeologist currently assigned to this plot.
local function AM_GetArchaeologistAssignedToPlot( iPlayer, plot, archaeologists )
	local iPlayer = iPlayer or 0;
	if ( not plot ) or ( not plot.GetIndex ) then return nil; end
	local archaeologist = nil;
	for _, anArchaeologist in pairs( archaeologists ) do
		if anArchaeologist.targetPlot and anArchaeologist.targetPlot.GetIndex and anArchaeologist.targetPlot:GetIndex() == plot:GetIndex() then
			archaeologist = anArchaeologist;
			break;
		end
	end
	return archaeologist;
end

--------------------------------------------------------------------------------------------------------
-- Higher level function taking consideration before assigning an archaeologist to a new plot.
local function AM_ShouldArchaeologistTakeOver( unit, oldUnit, plot, plots )
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
				if newDistance < oldDistance then -- New archaeologist has the same turns but is closer in plot distance, reassign.
					takeOver = true;
				elseif newDistance == oldDistance then -- New Buulder is just as close via plot distance as well, need to calculate if it should be assigned.
					
					-- Check the second closest unassigned plot to each Archaeologist and compare
					local unassigned_plots = {};
					for _, o in ipairs( plots ) do
						if o.assigned == false then table.insert( unassigned_plots, o.plot ); end
					end
					if #unassigned_plots > 1 then
						local newArchaeologist = nil;
						local oldArchaeologist = nil;
						newArchaeologist = m_Archaeologists:get( unit );
						if not newArchaeologist then return false; end
						print( "BM_ShouldArchaeologistTakeOver: Reached 5." );
						oldArchaeologist = m_Archaeologists:get( oldUnit );
						if not oldArchaeologist then return true; end
						local old_secondClosestPlot = GetSecondClosestPlotToArchaeologist( oldArchaeologist, unassigned_plots ); 
						local new_secondClosestPlot = GetSecondClosestPlotToArchaeologist( newArchaeologist, unassigned_plots );
						local old_second_turn_distance = GetTurnDistance( oldUnit, old_secondClosestPlot );
						local new_second_turn_distance = GetTurnDistance( newUnit, new_secondClosestPlot );
						if old_second_turn_distance < BAD_DISTANCE and new_second_turn_distance < BAD_DISTANCE then
							if old_second_turn_distance < new_second_turn_distance then -- Old archaeologist has shorter turns to travel for second closest plot, reassign.
								takeOver = true;
							elseif old_second_turn_distance == new_second_turn_distance then -- Its a tie for turns to the second closest plot.
								
								-- Calculate plot distances to second closest plot.
								local old_second_distance = GetDistance( old_secondClosestPlot, Map.GetPlot( oldArchaeologist:x(), oldArchaeologist:y() ) );
								local new_second_distance = GetDistance( new_secondClosestPlot, Map.GetPlot( newArchaeologist:x(), newArchaeologist:y() ) );
								if old_second_distance < new_second_distance then -- old archaeologist has shorter plot distance to travel for second closest plot, reassign.
									takeOver = true;
								elseif old_second_distance == new_second_distance then
									takeOver = false; -- Could check third closest plot here, but then a third archaeologist may have to be taken into account.
								else -- New archaeologist has shorter plot distance to travel for second closest plot. Don't reassign.
									takeOver = false;
								end
								
							else -- New archaeologist has shorter turns to travel for second closest plot. Don't reassign.
								takeOver = false;
							end
						else -- Bad turn data.
							-- Calculate plot distances to second closest plot.
							local old_second_distance = GetDistance( old_secondClosestPlot, Map.GetPlot( oldArchaeologist:x(), oldArchaeologist:y() ) );
							local new_second_distance = GetDistance( new_secondClosestPlot, Map.GetPlot( newArchaeologist:x(), newArchaeologist:y() ) );
							if old_second_distance < new_second_distance then -- old archaeologist has shorter plot distance to travel for second closest plot, reassign.
								takeOver = true;
							elseif old_second_distance == new_second_distance then
								takeOver = false; -- Could check third closest plot here, but then a third archaeologist may have to be taken into account.
							else -- New archaeologist has shorter plot distance to travel for second closest plot. Don't reassign.
								takeOver = false;
							end
						end
					else
						takeOver = false;
					end
					
				else -- Old plot is closer to Archaeologist, don't reassign
					takeOver = false; 
				end
			end
		
		else -- Bad turn distance data, only go by plot distance.
			
			local oldDistance = GetDistance( plot, Map.GetPlot( oldUnit:GetX(), oldUnit:GetY() ) );
			local newDistance = GetDistance( plot, Map.GetPlot( unit:GetX(), unit:GetY() ) );
			if newDistance < oldDistance then -- reassign
				takeOver = true;
			elseif newDistance == oldDistance then -- New Buulder is just as close via plot distance as well, need to calculate if it should be assigned.
				-- Check the second closest unassigned plot to each Archaeologist and compare
				local unassigned_plots = {};
				for _, o in ipairs( plots ) do
					if o.assigned == false then table.insert( unassigned_plots, o.plot ); end
				end
				if #unassigned_plots > 1 then
					local newArchaeologist = nil;
					local oldArchaeologist = nil;
					newArchaeologist = m_Archaeologists:get( unit );
					if not newArchaeologist then return false; end
					oldArchaeologist = m_Archaeologists:get( oldUnit );
					if not oldArchaeologist then return true; end
					local old_secondClosestPlot = GetSecondClosestPlotToArchaeologist( oldArchaeologist, unassigned_plots ); 
					local new_secondClosestPlot = GetSecondClosestPlotToArchaeologist( newArchaeologist, unassigned_plots );
					-- Calculate plot distances to second closest plot.
					local old_second_distance = GetDistance( old_secondClosestPlot, Map.GetPlot( oldArchaeologist:x(), oldArchaeologist:y() ) );
					local new_second_distance = GetDistance( new_secondClosestPlot, Map.GetPlot( newArchaeologist:x(), newArchaeologist:y() ) );
					if old_second_distance < new_second_distance then -- old archaeologist has shorter plot distance to travel for second closest plot, reassign.
						takeOver = true;
					elseif old_second_distance == new_second_distance then
						takeOver = false; -- Could check third closest plot here, but then a third archaeologist may have to be taken into account.
					else -- New archaeologist has shorter plot distance to travel for second closest plot. Don't reassign.
						takeOver = false;
					end
				else
					takeOver = false;
				end
			end
			
		end
	else
		Error( "BM_ShouldArchaeologistTakeOver: Nil data was passed into function, returned false." );
	end
	return takeOver;
end

--------------------------------------------------------------------------------------------------------
-- Mark plots and archaeologists as assigned until a conflict has been found.
local function AM_FindNextConflict( iPlayer, plots, archaeologists, idx, IDs_seen )
	local idx = idx or 1;
	local IDs_seen = IDs_seen or {};
	-- Go through and mark archaeologists as assigned. I
	for i = idx, #plots do
		local already_seen = false;
		local o = plots[ i ];
		for _i, anID in pairs( IDs_seen ) do
			if anID == o.id then 
				already_seen = true;
				break;
			end -- Check if this id is already in the table.
		end
		if not already_seen then
			local new_unit = UnitManager.GetUnit( iPlayer, o.id );
			local old_unit = nil;
			local old_archaeologist = BM_GetArchaeologistAssignedToPlot( iPlayer, o.plot, archaeologists );
			if old_archaeologist then old_unit = UnitManager.GetUnit( iPlayer, old_archaeologist.id ); end
			local takeOver = true;
			if old_unit then
				if new_unit:GetID() == old_unit:GetID() then -- Same unit we are checking, don't take over.
					takeOver = false;
				else -- Check if old archaeologist has not been assigned yet.
					for _, oB in ipairs( archaeologists ) do
						if ( oB.id == old_unit:GetID() ) and ( oB.assigned == false ) then -- ID match and not marked as assinged.
							takeOver = BM_ShouldArchaeologistTakeOver( new_unit, old_unit, o.plot, plots );
							break;
						end
					end
				end
			end
			if takeOver == true then
				if old_unit then
					Debug( "Archaeologist Manager re-assigned plot (" .. tostring(o.plot:GetIndex()) .. ") from archaeologist " 
						.. tostring(old_unit:GetID()) .. " to archaeologist " .. tostring(o.id) );
				else
					Debug( "Archaeologist Manager re-assigned plot (" .. tostring(o.plot:GetIndex()) .. ") from archaeologist " 
						.. tostring(o.old_archaeologist) .. " to archaeologist " .. tostring(o.id) );
				end
			else
				o.id = old_unit:GetID();
			end
			-- Also go through archaeologists and mark this archaeologist as assigned.
			for j, oB in ipairs( archaeologists ) do
				if o.id == oB.id then
					oB.assigned = true;
					oB.targetPlot = o.plot;
					archaeologists[ j ] = oB;
					break;
				end
			end
			table.insert( IDs_seen, o.id );
			o.assigned = true; -- Mark plot as okay to be assigned.
			plots[ i ] = o; -- Save data back to table.
		end
		if already_seen == true then break; end -- Archaeologist has appeared twice in the table. Break out of table.
		idx = idx + 1;
	end
	
	return plots, archaeologists, idx, IDs_seen, false;
end

--------------------------------------------------------------------------------------------------------
-- Recursive function used for optimizing archaeologist efficiency.
local function AM_ProcessMethod_1( iPlayer:number, plots:table, archaeologists:table, idx:number, IDs_seen:table )
	local iPlayer = iPlayer or 0;
	local idx = idx or 1;
	local IDs_seen = IDs_seen or {};
	if ( not plots ) or ( not archaeologists ) or ( type( plots ) ~= "table" ) or ( type( archaeologists ) ~= "table" ) then
		return plots, archaeologists, true; -- early escape
	end
	if #archaeologists ~= #plots then -- early escape
		Error( "Attempt to process archaeologist action optimization with different numbers of plots and archaeologists." );
		return plots, archaeologists, true;
	end
	local hasError = false;
	
	plots = AM_PopulateClosestArchaeologistsForPlots( plots, archaeologists, idx ); -- populate plots with closest archaeologist ids.
	plots = AM_SortPlots( iPlayer, plots, idx );
	plots, archaeologists, idx, IDs_seen, hasError = AM_FindNextConflict( iPlayer, plots, archaeologists, idx, IDs_seen );
	
	if hasError == true then return plots, archaeologists, true; end -- Escape if error during processing.
	if idx > #plots or idx > #archaeologists then -- no plots or archaeologists left to assign
		return plots, archaeologists, false; -- This is the base case that will stop recursion.
	end
	return AM_ProcessMethod_1( iPlayer, plots, archaeologists, idx, IDs_seen ); -- Call self with updated idx to search.
end

--------------------------------------------------------------------------------------------------------
-- Populate plots and archaeologists with appropriate objects.
local function AM_PopulateTables( iPlayer )
	local plots = {};
	local archaeologists = {};
	for _, anArchaeologist in pairs( m_Archaeologists.members ) do -- Go through archaeologists.
		if anArchaeologist.isAutomated and anArchaeologist:getOwner() == iPlayer then -- Check if they are automated and belong to the player
			local unit = nil;
			if UnitManager and UnitManager.GetUnit then unit = UnitManager.GetUnit( iPlayer, anArchaeologist.ID ); end
			if unit and GameInfo.Units[unit:GetUnitType()].Index == GameInfo.Units["UNIT_ARCHAEOLOGIST"].Index then
				if anArchaeologist.targetPlot and anArchaeologist.targetPlot.GetIndex then 
					table.insert( plots, AM_TargetPlotClass:new{ plot = anArchaeologist.targetPlot, action = anArchaeologist:getActionObject(), 
						id = anArchaeologist.ID, old_archaeologist = anArchaeologist.ID } );
					table.insert( archaeologists, AM_ArchaeologistClass:new{ id = anArchaeologist.ID, owner = iPlayer, targetPlot = anArchaeologist.targetPlot } );
				end
			end
		end
	end
	return plots, archaeologists;
end

--------------------------------------------------------------------------------------------------------
-- Processes and switches Automated Archaeologist targets to optimize routes and efficiency.
local function AM_ProcessArchaeologistActionsOptimization( iPlayer )
	
	local plots = {};
	local archaeologists = {};
	plots, archaeologists = AM_PopulateTables( iPlayer ); -- Load in automated archaeologists and their assignments.
	if not plots[1] then return; end -- early escape if no archaeologists are automated.
	local hasError = false;
	plots, archaeologists, hasError = AM_ProcessMethod_1( iPlayer, plots, archaeologists ); -- Recursive method for returning the optimized tables.
	if hasError == true then return; end -- early escape if there was a processing error.
	
	-- Plots should be all sorted and assigned, switch archaeologist actions.
	for i, o in ipairs( plots ) do
		if o.assigned == true then
			if o.id ~= o.old_archaeologist then
				local newUnit = nil;
				if UnitManager and UnitManager.GetUnit then newUnit = UnitManager.GetUnit( iPlayer, o.id ); end
				if newUnit then
					local newArchaeologist = m_Archaeologists:get( newUnit );
					if newArchaeologist then
						newArchaeologist:setAction( o.action ); -- Copy this action into new archaeologist object.
						--oldArchaeologist:resetAction(); -- Reset old archaeologist action
						TargetPlot( newArchaeologist.targetPlot ); -- Set plot as targeted again.
						m_Archaeologists:save( newArchaeologist );
						--m_Archaeologists:save( oldArchaeologist );
					end
				end
			end
		end
	end
	print( "Archaeologist Manager processed optimization for Automated Archaeologist actions using Method 1." );
end
m_ArchaeologistManager.Process = AM_ProcessArchaeologistActionsOptimization;

--------------------------------------------------------------------------------------------------------
-- Refreshes Automated Archaeologist instructions and automatically gives a command to each Archaeologist.
local function ProcessAutomatedArchaeologistActions( iPlayer )
	
	-- Refresh all Automated Archaeologist Actions
	for _, anArchaeologist in ipairs( m_Archaeologists.members ) do -- Go through archaeologists.
		if anArchaeologist.isAutomated and anArchaeologist:getOwner() == iPlayer then -- Check if they are automated and belong to the player
			local unit = UnitManager.GetUnit( iPlayer, anArchaeologist.ID );
			if unit and GameInfo.Units[unit:GetUnitType()].Index == GameInfo.Units["UNIT_ARCHAEOLOGIST"].Index then
				if anArchaeologist.queuedAction == "none" then -- Get a new action if the Archaeologist has finished performing their current action.
					Debug( "ProcessAutomatedArchaeologistActions: Archaeologist has no queued action, getting new action." );
					anArchaeologist:getAction(); -- Refresh the Archaeologist's next action.
					m_Archaeologists:save( anArchaeologist ); -- Save the data to m_Archaeologists table.
				elseif not CanMoveToPlot( unit, anArchaeologist.targetPlot ) then -- Else check if the Archaeologist can no longer move to its target plot.
					Debug( "ProcessAutomatedArchaeologistActions: Archaeologist can no longer perform queued operation at target plot, getting new action." );
					anArchaeologist:getAction(); -- Refresh the Archaeologist's next action.
					m_Archaeologists:save( anArchaeologist ); -- Save the data to m_Archaeologists table.
				end
			end
		end
	end
	
	-- Process refreshed archaeologist actions to maximize efficiency
	if b_UseAutoArchaeologistManager == true then m_ArchaeologistManager.Process( iPlayer ); end
	LuaEvents.CNO_AutoBuilder_OnArchaeologistActionsUpdate(); -- Tell other scripts that unit statuses were probably updated.
	
	-- Have all Archaeologists realize their actions.
	for _, anArchaeologist in ipairs( m_Archaeologists.members ) do -- Go through archaeologists.
		if anArchaeologist.isAutomated and anArchaeologist:getOwner() == iPlayer then -- Check if they are automated and belong to the player
			local unit = UnitManager.GetUnit( iPlayer, anArchaeologist.ID );
			if unit and GameInfo.Units[unit:GetUnitType()].Index == GameInfo.Units["UNIT_ARCHAEOLOGIST"].Index then
				anArchaeologist:realizeAction(); -- Do something based on current goal.
				m_Archaeologists:save( anArchaeologist ); -- Save the data to m_Archaeologists table.
			end
		end
	end
	
end

--------------------------------------------------------------------------------------------------------
local function SleepAutomatedUnits( iPlayer )
	for _, anArchaeologist in pairs( m_Archaeologists.members ) do
		if anArchaeologist.isAutomated and anArchaeologist:getOwner() == iPlayer then
			local unit = UnitManager.GetUnit( anArchaeologist:getOwner(), anArchaeologist.ID );
			if unit:IsReadyToMove() or unit:IsReadyToSelect() then 
				anArchaeologist:sleep(); -- Don't make the user have to select the unit's action.
			end
		end
	end
end

--------------------------------------------------------------------------------------------------------
local function OnUnitOperationDeactivated( iPlayer, iUnit, hOperation, iData1)
	local unit = nil;
	if UnitManager then unit = UnitManager.GetUnit( iPlayer, iUnit ); end
	if unit and GameInfo.Units[unit:GetUnitType()].Index == GameInfo.Units["UNIT_ARCHAEOLOGIST"].Index 
		and unit:GetMovesRemaining() > 0 then -- check if selected unit has moves and no pending operations
		local archaeologist = m_Archaeologists:get( unit );
		if archaeologist and archaeologist.isAutomated and archaeologist:getOwner() == iPlayer then -- check for an automated archaeologist.
			if not CanMoveToPlot( unit, archaeologist.targetPlot ) then -- Check if the Archaeologist cannot move to its target plot.
				archaeologist:getAction(); -- Refresh the Archaeologist's next action.
				archaeologist:realizeAction(); -- Do something based on current goal.
				m_Archaeologists:save( archaeologist ); -- Save the data to m_Archaeologists table.
			end
		end
	end
end

--------------------------------------------------------------------------------------------------------
local function OnUnitSelectionChanged( iPlayer, iUnit, x, y, z, isSelected, isEditable)
	if isSelected then
		local unit = nil;
		if UnitManager then unit = UnitManager.GetUnit( iPlayer, iUnit ); end
		if unit and GameInfo.Units[unit:GetUnitType()].Index == GameInfo.Units["UNIT_ARCHAEOLOGIST"].Index and
			unit:GetMovesRemaining() > 0 and not unit:HasPendingOperations() then -- check if selected unit has moves and no pending operations
			local archaeologist = m_Archaeologists:get( unit );
			-- check for an automated archaeologist.
			if archaeologist and archaeologist.isAutomated and archaeologist:getOwner() == iPlayer then
				if ( not ( archaeologist.queuedAction == "none" ) ) then -- Archaeologist has a queued non-sleep action: there was an issue moving to the target plot.
					Error( "There was an issue processing action for Archaeologist (" .. archaeologist.ID .. "). There was an unexpected reason why the Archaeologist could not" .. 
					" move to its target plot. Switching to new action for Archaeologist so user does not have to select." );
					--Debug( "OnUnitSelectionChanged: Unit selected is an automated Archaeologist with movement left and a pending action, switching action." );
					archaeologist.has_error = true;
					archaeologist:getActionSwitch(); -- Refresh the Archaeologist's next action.
					archaeologist:realizeAction(); -- Do something based on current goal.
					m_Archaeologists:save( archaeologist ); -- Save the data to m_Archaeologists table.
				elseif archaeologist.queuedAction == "none" and ( not ( archaeologist.previousAction == "SLEEP" ) ) then 
					-- The Archaeologist just tried to perform a non-sleep action on its target plot and it failed (the unit had to be told what to do).
					Error( "There was an issue processing action for Archaeologist (" .. archaeologist.ID .. "). There was an unexpected reason why the Archaeologist could not" .. 
					" perform an action on its current plot. Switching to new action for Archaeologist so user does not have to select." );
					--Debug( "OnUnitSelectionChanged: Unit selected is an automated Archaeologist with movement left and no pending operations, switching action." );
					-- Ban any automated Archaeologist from trying to perform this action on this plot again for this session.
					BanPlotAction( archaeologist.targetPlot, archaeologist.previousAction );
					archaeologist.has_error = true;
					archaeologist:getActionSwitch(); -- Refresh the Archaeologist's next action.
					archaeologist:realizeAction(); -- Do something based on current goal.
					m_Archaeologists:save( archaeologist ); -- Save the data to m_Archaeologists table.
				end
			end
		end
	end
end

--------------------------------------------------------------------------------------------------------
local function OnUnitMoveComplete( iPlayer, iUnit )
	local unit = nil;
	if UnitManager then unit = UnitManager.GetUnit( iPlayer, iUnit ); end
	if unit and GameInfo.Units[unit:GetUnitType()].Index == GameInfo.Units["UNIT_ARCHAEOLOGIST"].Index 
		and unit:GetMovesRemaining() > 0 then -- only try to perform an action if the unit has moves left.
		local theArchaeologist = m_Archaeologists:get( unit );
		if theArchaeologist and theArchaeologist.isAutomated and theArchaeologist:hasReachedTarget() then 
			Debug( "OnUnitMoveComplete: Archaeologist (" .. theArchaeologist.ID .. ") finished movement and still has moves left, realizing action." );
			theArchaeologist:realizeAction();
			m_Archaeologists:save( theArchaeologist );
		end
	end
end
--------------------------------------------------------------------------------------------------------
local function OnUnitMovementPointsChanged( iPlayer, iUnit, movement )
	local unit = nil;
	if UnitManager then unit = UnitManager.GetUnit( iPlayer, iUnit ); end
	if ( unit and ( GameInfo.Units[unit:GetUnitType()].Index == GameInfo.Units["UNIT_ARCHAEOLOGIST"].Index ) ) then 
		if ( movement > 0 ) then -- only try to perform an action if the unit has moves left.
			local theArchaeologist = m_Archaeologists:get( unit );
			if theArchaeologist and theArchaeologist.isAutomated and theArchaeologist:hasReachedTarget() then 
				Debug( "OnUnitMovementPointsChanged: Archaeologist (" .. theArchaeologist.ID .. ") finished movement and still has moves left, realizing action." );
				theArchaeologist:realizeAction();
				m_Archaeologists:save( theArchaeologist );
			end
		end
	end
end

--------------------------------------------------------------------------------------------------------
local function OnUnitRemovedFromMap( iPlayer, iUnit )
	local theArchaeologist = m_Archaeologists:get( iPlayer, iUnit );
	if theArchaeologist and theArchaeologist.isAutomated then 
		Debug( "OnUnitRemovedFromMap: Automated Archaeologist (" .. theArchaeologist.ID .. ") was removed from the map, resetting object data in table..." );
		-- Reset object data for this unit ID and save it back to the table.
		theArchaeologist:setAutomated( false );
		theArchaeologist:resetAction();
		theArchaeologist:resetPreviousAction();
		m_Archaeologists:save( theArchaeologist );
	end
end

--------------------------------------------------------------------------------------------------------
local function OnCivicCompleted( iPlayer, param2, param3, param4 )
	if Players and iPlayer and Players[iPlayer]:IsHuman() then 
		m_Player = Players[iPlayer];
		Debug( "Civic completed for Player: " .. iPlayer .. ". Refreshing player visible resources." );
		if m_Player then 
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
			RefreshPlayerVisibleResources( iPlayer );
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
			if ( GameConfiguration.IsHotseat() == true ) and ( m_isAutoArchaeologist_GP_Loaded == true ) then -- Save tables in gameplay script	after player turn ends
				m_AutoArchaeologist_GP.SetArchaeologists( m_Archaeologists );
				m_AutoArchaeologist_GP.SetArchaeologistPlots( m_Plots );
			end
			-- ProcessAutomatedArchaeologistActions( iPlayer ); -- Tell Archaeologists to perform their queued actions.
		end
	end
end

--------------------------------------------------------------------------------------------------------
local function OnPlayerTurnActivated( iPlayer )
	if Players and iPlayer and Players[iPlayer]:IsHuman() then 
		m_Player = Players[iPlayer];
		--Debug( "Player: " .. iPlayer .. " turn activated." );
		if m_Player then 
			if ( ( GameConfiguration.IsHotseat() == true ) and ( m_isAutoArchaeologist_GP_Loaded == true ) and ( m_AutoArchaeologist_GP.HasMembers() == true ) ) then
				-- Retrieve tables from gameplay script
				m_Archaeologists = m_AutoArchaeologist_GP.GetArchaeologists();
				m_Plots = m_AutoArchaeologist_GP.GetArchaeologistPlots();
			end
			-- SleepAutomatedUnits();
			ProcessAutomatedArchaeologistActions( iPlayer ); -- Tell Archaeologists to perform their queued actions.
		end
	end
end

--------------------------------------------------------------------------------------------------------
local function InitializeAutoArchaeologistGP()
	if ExposedMembers.CNO_AutoArchaeologist_GP_Initialized then 
        m_AutoArchaeologist_GP = ExposedMembers.CNO_AutoArchaeologist_GP;   -- contains functions from other context
        Events.GameCoreEventPublishComplete.Remove( InitializeAutoArchaeologistGP );
		m_isAutoArchaeologist_GP_Loaded = true;
		print( "AutoArchaeologist: Loaded gameplay script context." );	
    end
end

ExposedMembers.CNO_AutoArchaeology_Initialized = false;

--------------------------------------------------------------------------------------------------------
function Initialize()
	
	--print( "Initializing UI script..." );
	
	-- Populate player data for all human players when initializing.
	for ID = 0, PlayerManager.GetWasEverAliveCount() - 1 do -- go through players.
		local player = Players[ID];
		if player:IsHuman() then 
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
	-- Fallback event in case a user is asked to select an action for a Archaeologist
	Events.UnitSelectionChanged.Add( OnUnitSelectionChanged );

	LuaEvents.CNO_AutoBuilder_SettingsUpdate.Add( OnUpdateAutoArchaeologySettings );
	LuaEvents.CNO_AutoBuilder_SettingsInitialized.Add( OnUpdateAutoArchaeologySettings );
	
	-- Gedemon's method for sharing functions between different contexts using the ExposedMembers table.
	if ( not ExposedMembers.CNO_AutoArchaeology ) then ExposedMembers.CNO_AutoArchaeology = {}; end
	ExposedMembers.CNO_AutoArchaeology.AutomateArchaeologist = AutomateArchaeologist;
	ExposedMembers.CNO_AutoArchaeology.StopAutomateArchaeologist = StopAutomateArchaeologist;
	ExposedMembers.CNO_AutoArchaeology.debug = debug;
	ExposedMembers.CNO_AutoArchaeology.IsArchaeologistAutomated = IsArchaeologistAutomated;
	ExposedMembers.CNO_AutoArchaeology.GetUnitStatus = GetArchaeologistStatus;
	ExposedMembers.CNO_AutoArchaeology_Initialized = true;
	
	--print( "Added UI script functions to exposed members table." );

	Events.GameCoreEventPublishComplete.Add( InitializeAutoArchaeologistGP );

end

Initialize();